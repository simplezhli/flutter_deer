class GoodsItemEntity {

	GoodsItemEntity({this.icon, this.title, this.type});

	GoodsItemEntity.fromJson(Map<String, dynamic> json) {
		icon = json['icon'] as String;
		title = json['title'] as String;
		type = json['type'] as int;
	}

	String icon;
	String title;
	int type;

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['icon'] = icon;
		data['title'] = title;
		data['type'] = type;
		return data;
	}
}
