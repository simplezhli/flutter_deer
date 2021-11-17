class GoodsItemEntity {

	GoodsItemEntity({required this.icon, required this.title, required this.type});

	GoodsItemEntity.fromJson(Map<String, dynamic> json) {
		icon = json['icon'] as String;
		title = json['title'] as String;
		type = json['type'] as int;
	}

	late String icon;
	late String title;
	late int type;

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = <String, dynamic>{};
		data['icon'] = icon;
		data['title'] = title;
		data['type'] = type;
		return data;
	}
}
