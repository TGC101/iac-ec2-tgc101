variable "hostname" {
  type=set(string)
  default = [
    "master",
    "node1",
    "node2"
  ]
}



variable "key_devops" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNFYG3FjRNa0BxcFzvoqZ0R0875a27+XWcCf9j7uRBjHtQoqwL2sdffJl+GDelRDAgUa8t53zpNoU156Ci6UbPIv83dO92qgxwjS8ZigR1jcaDJdpvhzLmsTA8/thREfhM1YbqtY4kN2EJDGig/9y1U4loLdaIafv1Kz5CsvKUtMUheGo+x3EHCaRIAS8jmoDQbWR6dUJYofrJfhBZLkfgklLOkr/6pKm4aWkWFiMW3vHvEB4yR/TBt3Oxum1gtFZO93SkOYszZeoADLi4S1YDXfQt174NCmKYHsKBygu0HX1FEsGTwiJ2GarIMS7BgpKWZCpdI+z9nw4lPe1HCRdpO5+w42CpzFq//D+IQWDzyZogydyXPgPt9cmupHCOAT/BsLeFnT0rv9DtRPQAWgBE0eeg0IbkIrCwv8b9yhNjVTbk0Wa6rjdVFL3KgRmJY4BVh+bZ4Q8Y6ww6dsSRNTbccT++Yr84drzZ3jpnH7eIcbdFLedfalmsRiWjo0EMdc8= root@base.com"
  type = string
}