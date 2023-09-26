# Geotrellis Workshop Scala/Spark Notebooks

This repository contains a collection of [Jupyter](https://jupyter.org) notebooks to assist in the teaching and learning of [Scala](https://www.scala-lang.org/api/2.12.2/) and [Apache Spark](http://spark.apache.org).  We've also included a docker image to provide an [Almond](https://github.com/almond-sh/almond)-based Jupyter environment with some preloaded libraries.  The preloaded libraries are

- Spark 3.3.1
- Geotrellis 3.6.3
- Rasterframes 0.11.1

## Setup

Run the following commands in a terminal on Mac or Linux to create the docker environment:
```shell
docker build -t geotrellis-almond docker
docker run --rm -it -p 8888:8888 -p 4040:4040 geotrellis-almond
```
If you are using your local ports 8888 or 4040, adjust the `-p` arguments to the above to be, e.g., `-p 9999:8888` to redirect the container's internal port 8888 to your local machine's port 9999.

Upon running the above, a Jupyter splash screen will display in the terminal, and somewhere in that text, you will see a URL of the form
```
https://127.0.0.1:8888/lab?token=<hexidecimal string>
```
Copy and paste that into your browser's address bar.  If you had to use a different port number instead of 8888, adjust the URL to point to the selected port.

## Imports

This Almond-based notebook is built on top of an [Ammonite](http://ammonite.io/) interpreter.  Due to the lack of a build environment like `sbt`, we must rely on the Ammonite [import mechanisms](https://ammonite.io/#MagicImports) to ensure that jars are in place.  Specifically, there is special [Ivy import syntax](https://ammonite.io/#import$ivy) that must be used.  Also remember that it is both necessary to import the package from Ivy _and_ import the library code itself:
```scala
import $ivy.`org.locationtech.geotrellis::geotrellis-vector:3.6.3`
import geotrellis.vector._
```

## Generating a `SparkSession`

Here is the basic code template for creating a `SparkSession`:
```scala
import $ivy.`org.apache.logging.log4j:log4j-core:2.17.0`
import $ivy.`org.apache.logging.log4j:log4j-1.2-api:2.17.0`
import $ivy.`org.apache.spark::spark-sql:3.3.1`

import org.apache.log4j.{Level, Logger}
Logger.getLogger("org").setLevel(Level.OFF)

import org.apache.spark.sql._

val spark = {
  NotebookSparkSession.builder()
    .master("local[*]")
    .getOrCreate()
}
```
Note that this uses a custom `SparkSession` builder, but that builder largely has the same interface as the customary builder.
