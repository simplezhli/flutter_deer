
class BaseEntity<T>{

  int code;
  String message;
  T data;
  
  BaseEntity(this.code, this.message, this.data);
}