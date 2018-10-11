from java:8
workdir /senyuanmes/
copy mes.war  /senyuanmes/mes.war
cmd ["java","-jar","mes.jar"]