class Validation {
  late bool valid;
  late String? message;

  Validation(this.valid, this.message);

  Validation.fromJson(Map<String, dynamic> json) {
    valid = json['valid'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['valid'] = valid;
    data['message'] = message;
    return data;
  }
}
