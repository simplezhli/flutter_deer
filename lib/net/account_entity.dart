class AccountEntity {
	String accessToken;
	String refreshToken;

	AccountEntity({this.accessToken, this.refreshToken});

	AccountEntity.fromJson(Map<String, dynamic> json) {
		accessToken = json['access_token'];
		refreshToken = json['refresh_token'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['access_token'] = this.accessToken;
		data['refresh_token'] = this.refreshToken;
		return data;
	}
}
