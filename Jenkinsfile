def pass_between_stages = ""

pipelne {
  agent any
  // put real things here!
  stages {
    stage("Stage1") {
      pass_between_stages = "1"
    }
    stage("Stage2") {
      echo "${pass_between_stages}"
    }
  }
}