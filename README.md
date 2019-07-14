# JupilLabs
This project receives data from [Pupil Labs](https://pupil-labs.com/) with [ZeroMQ](http://zeromq.org/) and [Message Pack](https://msgpack.org/). This project is fully implemented with Processing, but can be used as a Java-binding to receive Pupil Labs data.



## Message Type

Each payload is parsed as `HashMap<String, Object>`. Hashmap and array values in the payload are parsed into `JSONObject` and `JSONArray`. Other types such as doubles, strings, longs are parsed into their own type.



## Dependencies
Available with [msgpack-java(0.8.x)](https://github.com/msgpack/msgpack-java) and [jeromq (0.4.x)](https://github.com/zeromq/jeromq). Necessary JARs are included in this repo.
