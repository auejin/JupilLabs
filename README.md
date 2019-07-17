# JupilLabs
This project receives data from [Pupil Labs](https://pupil-labs.com/) with [ZeroMQ](http://zeromq.org/) and [Message Pack](https://msgpack.org/). This project is fully implemented with Processing, but can be used as a Java-binding to receive Pupil Labs data.



## Message Type

Each payload is parsed as `HashMap<String, Object>`. Hashmap and array values in the payload are parsed into `JSONObject` and `JSONArray`. Other types such as doubles, strings, longs are parsed into their own type.



## Dependencies
Available with [msgpack-java(0.8.x)](https://github.com/msgpack/msgpack-java) and [jeromq (0.4.x)](https://github.com/zeromq/jeromq). Necessary JARs are included in this repo.



## Example

On this example, the topic is set as `pupil.0`. And each entry of the corresponding payload was printed in the following form of `key, (class of value) value`.

```json
TOPIC : 
pupil.0
PAYLOAD : 
method,  (java.lang.String)  3d c++
confidence,  (java.lang.Double)  0.9999968162820061
circle_3d,  (processing.data.JSONObject)  {
  "normal": [
    -0.5484866533710238,
    0.4110233246651724,
    -0.7281635926459402
  ],
  "center": [
    -3.3799455415836395,
    3.253979022642664,
    80.5431014420888
  ],
  "radius": 2.5197866827996807
}
projected_sphere,  (processing.data.JSONObject)  {
  "center": [
    118.23511194920195,
    84.34527179228537
  ],
  "axes": [
    166.66467939600741,
    166.66467939600741
  ],
  "angle": 90
}
model_id,  (java.lang.Long)  55
diameter_3d,  (java.lang.Double)  5.039573365599361
theta,  (java.lang.Double)  1.9943726335943859
model_confidence,  (java.lang.Double)  0.6987836400925818
phi,  (java.lang.Double)  -2.216371938616329
diameter,  (java.lang.Double)  38.80314654787235
model_birth_timestamp,  (java.lang.Double)  92728.483758
sphere,  (processing.data.JSONObject)  {
  "center": [
    3.2018942988686456,
    -1.6783008733394045,
    89.28106455384008
  ],
  "radius": 12
}
topic,  (java.lang.String)  pupil.0
ellipse,  (processing.data.JSONObject)  {
  "center": [
    70.21255306995407,
    120.87811158262909
  ],
  "axes": [
    26.722480275145124,
    38.80314654787235
  ],
  "angle": -37.21570741645479
}
norm_pos,  (processing.data.JSONArray)  [
  0.36569038057267744,
  0.3704265021738068
]
id,  (java.lang.Long)  0
timestamp,  (java.lang.Double)  92756.531689
```
