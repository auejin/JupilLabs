# JupilLabs
This project receives data from Pupil Labs with ZeroMQ and Message Pack. This project is fully implemented using Java, but developed for Processing.



## Message Type

Each payload is parsed as `HashMap<String, Object>`. Hashmap and array values in the payload are parsed into `JSONObject` and `JSONArray`. Other types such as doubles, strings, longs are parsed into their own type.



## Dependencies
Available with [msgpack-java(0.8.x)](https://github.com/msgpack/msgpack-java) and [jeromq (0.4.x)](https://github.com/zeromq/jeromq). Necessary JARs are included in this repo.

