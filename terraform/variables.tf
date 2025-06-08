variable "regions" {
  type = map(string)
  default = {
    EU = "http://localhost:9001"
    US = "http://localhost:9002"
  }
}