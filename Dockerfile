from java:8
workdir /senyuanmes/
copy mes.war  /senyuanmes/mes.war
cmd ["java", "-Duser.timezone=GMT+08","-jar","mes.jar"]
