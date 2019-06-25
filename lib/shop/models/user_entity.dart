class UserEntity {
	String avatarUrl;
	String name;
	int id;
	String blog;

	UserEntity({this.avatarUrl, this.name, this.id, this.blog});

	UserEntity.fromJson(Map<String, dynamic> json) {
		avatarUrl = json['avatar_url'];
		name = json['name'];
		id = json['id'];
		blog = json['blog'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['avatar_url'] = this.avatarUrl;
		data['name'] = this.name;
		data['id'] = this.id;
		data['blog'] = this.blog;
		return data;
	}
}
