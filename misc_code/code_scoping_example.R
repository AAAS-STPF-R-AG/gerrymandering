# Script to illustrate R's peculiar scoping behavior
#


# function definitions ------------------------------------
TestStomp <- function(x){
  print(sprintf("Inside first function, start , %4.2f, %4.2f, %4.2f, %4.2f", x, y, z, a))
  print(x*z)
  x<-1.1
  y<-2.1
  z<-3.1
  a<<-4.1
  
  print(sprintf("Inside first function, before, %4.2f, %4.2f, %4.2f, %4.2f", x, y, z, a))
  
  InnerTestStomp(y)
  
  print(sprintf("Inside first function, after , %4.2f, %4.2f, %4.2f, %4.2f", x, y, z, a))
  z
}

InnerTestStomp <- function(y){
  print(sprintf("Inside inner function, before, %4.2f, %4.2f, %4.2f, %4.2f", x, y, z, a))
  x<-1.01
  y<-2.01
  z<-3.01
  a<<-4.01
  print(sprintf("Inside inner function, after , %4.2f, %4.2f, %4.2f, %4.2f", x, y, z, a))
  z

}

# Test script ----------------------------------------

x<-1
y<-2
z<-3
a<-4

print(sprintf("Global scope, before function, %4.2f,%4.2f,%4.2f,%4.2f",x,y,z,a))

TestStomp(x)

print(sprintf("Global scope, after function , %4.2f,%4.2f,%4.2f,%4.2f",x,y,z,a))



