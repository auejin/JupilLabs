import java.io.*;
import java.util.*;
import java.math.BigInteger;
import org.zeromq.ZMQ;
import org.msgpack.*;

ZMQ.Socket subscriber;
ZMQ.Socket requester;

void settings() {  
  // Message Documentation : https://github.com/pupil-labs/pupil-docs/blob/master/developer-docs/ipc-backbone.md#message-documentation
  // How to receive from IPC Backbone : https://github.com/pupil-labs/pupil-docs/blob/master/developer-docs/ipc-backbone.md#pupil-and-gaze-messages
  // Pupil Datum Format : https://github.com/pupil-labs/pupil-docs/blob/master/developer-docs/dev-overview.md#pupil-datum-format
  
  String filter="";
  //filter="pupil.0";
  //filter="gaze";
  
  subsribeZeroMQ("tcp://127.0.0.1", "50020", filter);
    
  println("PUPIL LABS - LOGGING START");
}

void setup() {
  
}

void draw() {  
  println("TOPIC : ");
  byte[] bytes = subscriber.recv();
  MessageUnpacker unpacker = MessagePack.newDefaultUnpacker(bytes);
  println(unpackTopic(unpacker));
  
  println("PAYLOAD : ");
  byte[] bytes2 = subscriber.recv();
  MessageUnpacker unpacker2 = MessagePack.newDefaultUnpacker(bytes2);  
  Map<Object, Object> payload = (Map<Object, Object>) unpackPayload(unpacker2);
  
  for (Map.Entry entry : payload.entrySet())
  {
    print(entry.getKey().toString());
    print(",  (");
    print(entry.getValue().getClass().getName());
    print(")  ");
    println(entry.getValue().toString());    
  }
  println();
}

// port can be moditied at GUI
void subsribeZeroMQ(String address, String port, String filter){
  
  ZMQ.Context context = ZMQ.context(1);
  requester = context.socket(ZMQ.REQ);
  requester.connect(address + ":" + port); 
  
  String sub_port_txt = "SUB_PORT";
  requester.send(sub_port_txt.getBytes());
  String sub_port = requester.recvStr(); 
  subscriber = context.socket(ZMQ.SUB);
  subscriber.connect(address + ":" + sub_port);
  
  subscriber.subscribe(filter.getBytes());  
}


String unpackTopic(MessageUnpacker unpacker) {
  try{
    String rtn = "";
    while (unpacker.hasNext()) {
      MessageFormat format = unpacker.getNextFormat();
      Value v = unpacker.unpackValue();
      IntegerValue iv = v.asIntegerValue();
      int i = iv.toInt();
      rtn += String.valueOf((char) i);
    }
    return rtn;
  }catch(IOException e) {
    return "";
  }
}


Object unpackPayload(MessageUnpacker unpacker) {
  try{
    while (unpacker.hasNext()) {
      MessageFormat format = unpacker.getNextFormat();
      Value v = unpacker.unpackValue();
      switch (v.getValueType()) { // == format.getValueType()
        case NIL:
          v.isNilValue(); // true
        case BOOLEAN:
          boolean b = v.asBooleanValue().getBoolean();
          return b;
        case STRING:
          String s = v.asStringValue().asString();
          return s;
        case INTEGER:
          IntegerValue iv = v.asIntegerValue();
          if (iv.isInIntRange()) {
            int i = iv.toInt(); return i;
          }
          else if (iv.isInLongRange()) {
            long l = iv.toLong(); return l;
          }
          else {
            BigInteger i = iv.toBigInteger(); return i;
          }
        case FLOAT:
          FloatValue fv = v.asFloatValue();
          float f = fv.toFloat();   // use as float
          double d = fv.toDouble(); // use as double
          return f;
        case BINARY:
          byte[] mb = v.asBinaryValue().asByteArray();
          println("read binary: size=" + mb.length);
          break;
        case ARRAY:
          List<Object> rtn_arr = new ArrayList<Object>();
          ArrayValue a = v.asArrayValue();
          for (Value e : a) {
            //println("read array element: " + e);
            rtn_arr.add(e);
          }
          return rtn_arr;
        case MAP:
          Map<Value, Value> map = v.asMapValue().map();
          Map<Object, Object> rtn_map = new HashMap<Object, Object>();
          for (Map.Entry entry : map.entrySet())
          {
            JSONObject j = null;
            JSONArray ja = null;
            try {
              j = parseJSONObject(entry.getValue().toString());
            } catch(RuntimeException r1) {
              try {
                ja = parseJSONArray(entry.getValue().toString());
              } catch(RuntimeException r2) {}
            }
            if (j != null) {
              rtn_map.put(entry.getKey().toString(), j);
            }
            else if (ja != null) {
              rtn_map.put(entry.getKey().toString(), ja);
            }            
            else {
              Object value_obj;
              String type_name = entry.getValue().getClass().getName();
              if(type_name.contains("Double")){
                value_obj = Double.parseDouble(entry.getValue().toString());
              }
              else if(type_name.contains("Long")){
                value_obj = Long.parseLong(entry.getValue().toString());
              }
              else {
                value_obj = entry.getValue().toString();
              }
              rtn_map.put(entry.getKey().toString(), value_obj);
            }
          }
          return rtn_map;
        case EXTENSION:
          ExtensionValue ev = v.asExtensionValue();
          byte extType = ev.getType();
          byte[] extValue = ev.getData();
          break;
        default :
          println("default");
          break;
      }
    }
  } catch(IOException e) {
    println("ERROR");
  }
  return null;
}
