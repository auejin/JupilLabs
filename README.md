# JupilLabs
This project receives data from [Pupil Labs](https://pupil-labs.com/) with [ZeroMQ](http://zeromq.org/) and [Message Pack](https://msgpack.org/). This project is fully implemented with Processing, but can be used as a Java-binding to receive Pupil Labs data.



## Message Type

Each payload is parsed as `HashMap<String, Object>`. Hashmap and array values in the payload are parsed into `JSONObject` and `JSONArray`. Other types such as doubles, strings, longs are parsed into their own type.



## Dependencies
Available with [msgpack-java(0.8.x)](https://github.com/msgpack/msgpack-java) and [jeromq (0.4.x)](https://github.com/zeromq/jeromq). Necessary JARs are included in this repo.


## Sample Output
```json
TOPIC : 
pupil.0
PAYLOAD : 
(java.lang.String)  3d c++
(java.lang.Double)  0.9920317806850061
(processing.data.JSONObject)  {
  "normal": [
    -0.4450478297740828,
    0.4464538015681454,
    -0.7762805113351294
  ],
  "center": [
    -8.278593196747561,
    8.265014934933978,
    74.14484388676804
  ],
  "radius": 2.1820955751403397
}
(processing.data.JSONObject)  {
  "center": [
    74.17436682741496,
    117.59943014161865
  ],
  "axes": [
    178.28855206495257,
    178.28855206495257
  ],
  "angle": 90
}
(java.lang.Long)  293
(java.lang.Double)  4.364191150280679
(java.lang.Double)  2.033594640578971
(java.lang.Double)  0.49359430993621833
(java.lang.Double)  -2.0913580962913323
(java.lang.Double)  36.4996983066617
(java.lang.Double)  268386.563916
(processing.data.JSONObject)  {
  "center": [
    -2.9380192394585674,
    2.907569316116233,
    83.4602100227896
  ],
  "radius": 12
}
(java.lang.String)  pupil.0
(processing.data.JSONObject)  {
  "center": [
    26.93606648365646,
    164.94976654515446
  ],
  "axes": [
    24.708057857245617,
    36.4996983066617
  ],
  "angle": -45.07328332841831
}
(processing.data.JSONArray)  [
  0.14029201293571072,
  0.14088663257732048
]
(java.lang.Long)  0
```
