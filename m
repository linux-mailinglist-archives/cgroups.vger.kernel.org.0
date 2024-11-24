Return-Path: <cgroups+bounces-5676-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B5F9D7380
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2024 15:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DEF166659
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2024 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052AE22A587;
	Sun, 24 Nov 2024 13:47:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mx9.didiglobal.com (mx9.didiglobal.com [111.202.70.124])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 556AA229C7B;
	Sun, 24 Nov 2024 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456076; cv=none; b=jl4RTeIRuGEzWNMonGWOBiIKVWtEKejDSdzSxGpAnhdPMw49v+t9NVal9dUAF8svHRf+Jxre61IqWtUsnIfkvy2MI2IcYE0MRxSJ6qGXiuU2WJEeAWYYIHaX+buRhwCbg81sxNIJHwe3W8cWDAIy/R0TSVcoeuGrTRVqdTxDN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456076; c=relaxed/simple;
	bh=pEalVqfZuwgm9F9FEnY4rS5iSP3CG4m6oKqxI94kKxQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=KV+AXpXGgbR42fUWxSb51I9Zd3Nj5iK0b1ChCO3oEUScGYsyBSkaXbP91eqZtnKAxHwZNLsGBEO4ziFu9KofrD62YCoLuRSmZMDnh4k0aMtvRmuMid2jUiteakjivoZ2A5zdxC8RNdBJkB+1E8CrTww75jkIGk4N/QsPibkg1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.65.20])
	by mx9.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 79B3E18746009B;
	Sun, 24 Nov 2024 21:44:22 +0800 (CST)
Received: from BJ03-ACTMBX-03.didichuxing.com (10.79.71.12) by
 BJ02-ACTMBX-02.didichuxing.com (10.79.65.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 24 Nov 2024 21:44:42 +0800
Received: from BJ02-ACTMBX-03.didichuxing.com (10.79.65.11) by
 BJ03-ACTMBX-03.didichuxing.com (10.79.71.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 24 Nov 2024 21:44:41 +0800
Received: from BJ02-ACTMBX-03.didichuxing.com ([fe80::9c02:2754:e1db:e82e]) by
 BJ02-ACTMBX-03.didichuxing.com ([fe80::9c02:2754:e1db:e82e%5]) with mapi id
 15.02.1544.011; Sun, 24 Nov 2024 21:44:41 +0800
X-MD-Sfrom: daikunhai@didiglobal.com
X-MD-SrcIP: 10.79.65.20
From: =?utf-8?B?5oi05Z2k5rW3IFRvbnkgRGFp?= <daikunhai@didiglobal.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, "tj@kernel.org" <tj@kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yukuai (C)"
	<yukuai3@huawei.com>
Subject: Re: [PATCH] block: iocost: ensure hweight_inuse is at least 1
Thread-Topic: [PATCH] block: iocost: ensure hweight_inuse is at least 1
Thread-Index: AQHbPK/ZVOMoLGOycU+ydueJcsx/wrLCbhOAgAQGk4A=
Date: Sun, 24 Nov 2024 13:44:41 +0000
Message-ID: <3B8BC663-3B34-454D-AE79-4FCE50001D6E@didiglobal.com>
In-Reply-To: <29ebfb70-87de-dd75-5ff2-0ca49ec35cf1@huaweicloud.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <79D0517768A12840B638C9639307A8D3@didichuxing.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SW4gZmFjdCwgd2UgZGlkIGVuY291bnRlciBzdWNoIGEgc3BlY2lhbCBzaXR1YXRpb24gd2hlcmUg
dGhlIGtlcm5lbCBwcmludGVkIG91dCBgaW9jZzogaW52YWxpZCBkb25hdGlvbiB3ZWlnaHRzIGlu
IC9hL2IvYzogYWN0aXZlPTEgZG9uYXRpbmc9MSBhZnRlcj0wYCwgYW5kIHRoZW4gaXQgaW1tZWRp
YXRlbHkgcGFuaWMuIEkgYW5hbHl6ZWQgdGhlIGNvZGUgYnV0IGNvdWxkIG5vdCBmaWd1cmUgb3V0
IGhvdyB0aGlzIGhhcHBlbmVkOyBpdCBtaWdodCBiZSBhIGNvbmN1cnJlbmN5IGlzc3VlIG9yIHNv
bWUgb3RoZXIgaGlkZGVuIGJ1Zy4NCg0KT3VyIGtlcm5lbCBpcyBub3QgdGhlIGxhdGVzdCwgYnV0
IGl0IGluY2x1ZGVzIHRoZSBwYXRjaCBlZGFhMjYzMzRjMTE3YTU4NGFkZDYwNTNmNDhkNjNhOTg4
ZDI1YTZlIChpb2Nvc3Q6IEZpeCBkaXZpZGUtYnktemVybyBvbiBkb25hdGlvbiBmcm9tIGxvdyBo
d2VpZ2h0IGNncm91cCkuDQoNCu+7v+WcqCAyMDI0LzExLzIyIDE2OjE277yM4oCcWXUgS3VhaeKA
nTx5dWt1YWkxQGh1YXdlaWNsb3VkLmNvbSA8bWFpbHRvOnl1a3VhaTFAaHVhd2VpY2xvdWQuY29t
Pj4g5YaZ5YWlOg0KDQoNCkhpLA0KDQoNCuWcqCAyMDI0LzExLzIyIDE1OjI2LCBLdW5oYWkgRGFp
IOWGmemBkzoNCj4gVGhlIGh3ZWlnaHRfaW51c2UgY2FsY3VsYXRpb24gaW4gdHJhbnNmZXJfc3Vy
cGx1c2VzKCkgY291bGQgcG90ZW50aWFsbHkNCj4gcmVzdWx0IGluIGEgdmFsdWUgb2YgMCwgd2hp
Y2ggd291bGQgbGVhZCB0byBkaXZpc2lvbiBieSB6ZXJvIGVycm9ycyBpbg0KPiBzdWJzZXF1ZW50
IGNhbGN1bGF0aW9ucyB0aGF0IHVzZSB0aGlzIHZhbHVlIGFzIGEgZGl2aXNvci4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IEt1bmhhaSBEYWkgPGRhaWt1bmhhaUBkaWRpZ2xvYmFsLmNvbSA8bWFpbHRv
OmRhaWt1bmhhaUBkaWRpZ2xvYmFsLmNvbT4+DQo+IC0tLQ0KPiBibG9jay9ibGstaW9jb3N0LmMg
fCA3ICsrKystLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ibG9jay9ibGstaW9jb3N0LmMgYi9ibG9jay9ibGst
aW9jb3N0LmMNCj4gaW5kZXggMzg0YWExNWU4MjYwLi42NWNkYjU1ZDMwY2MgMTAwNjQ0DQo+IC0t
LSBhL2Jsb2NrL2Jsay1pb2Nvc3QuYw0KPiArKysgYi9ibG9jay9ibGstaW9jb3N0LmMNCj4gQEAg
LTE5OTksOSArMTk5OSwxMCBAQCBzdGF0aWMgdm9pZCB0cmFuc2Zlcl9zdXJwbHVzZXMoc3RydWN0
IGxpc3RfaGVhZCAqc3VycGx1c2VzLCBzdHJ1Y3QgaW9jX25vdyAqbm93KQ0KPiBwYXJlbnQgPSBp
b2NnLT5hbmNlc3RvcnNbaW9jZy0+bGV2ZWwgLSAxXTsNCj4gDQo+IC8qIGInID0gZ2FtbWEgKiBi
X2YgKyBiX3QnICovDQo+IC0gaW9jZy0+aHdlaWdodF9pbnVzZSA9IERJVjY0X1U2NF9ST1VORF9V
UCgNCj4gLSAodTY0KWdhbW1hICogKGlvY2ctPmh3ZWlnaHRfYWN0aXZlIC0gaW9jZy0+aHdlaWdo
dF9kb25hdGluZyksDQo+IC0gV0VJR0hUX09ORSkgKyBpb2NnLT5od2VpZ2h0X2FmdGVyX2RvbmF0
aW9uOw0KPiArIGlvY2ctPmh3ZWlnaHRfaW51c2UgPSBtYXhfdCh1NjQsIDEsDQo+ICsgRElWNjRf
VTY0X1JPVU5EX1VQKA0KPiArICh1NjQpZ2FtbWEgKiAoaW9jZy0+aHdlaWdodF9hY3RpdmUgLSBp
b2NnLT5od2VpZ2h0X2RvbmF0aW5nKSwNCj4gKyBXRUlHSFRfT05FKSArIGlvY2ctPmh3ZWlnaHRf
YWZ0ZXJfZG9uYXRpb24pOw0KDQoNCkknbSBjb25mdXNlZCwgaG93IGNvdWxkIERJVjY0X1U2NF9S
b3VuZF9VUCgpIGVuZCB1cCBsZXNzIHRoYW4gMT8NCg0KDQojZGVmaW5lIERJVjY0X1U2NF9ST1VO
RF9VUChsbCwgZCkgXA0KKHsgdTY0IF90bXAgPSAoZCk7IGRpdjY0X3U2NCgobGwpICsgX3RtcCAt
IDEsIF90bXApOyB9KQ0KDQoNCkFGQUlLLCB0aGUgb25seSBjYXNlIHRoYXQgY291bGQgaGFwcGVu
IGlzIHRoYXQNCmlvY2ctPmh3ZWlnaHRfYWN0aXZlIC0gaW9jZy0+aHdlaWdodF9kb25hdGluZyBp
cyAwLCB0aGVuIEkgZG9uJ3QNCmdldCBpdCBub3cgaG93IGNvdW5kIGFjdGl2ZSBpb2NnIGRvbmF0
ZSBhbGwgdGhlIGh3ZWlnaHQsIGlmIHRoaXMNCnJlYWxseSBoYXBwZW5kIHBlcmhhcHMgdGhlIGJl
dHRlciBzb2x1dGlvbiBpcyB0byBhdm9pZCBzdWNoIGNhc2UuDQoNCg0KVGhhbmtzLA0KS3VhaQ0K
DQoNCj4gDQo+IC8qIHcnID0gcycgKiBiJyAvIGInX3AgKi8NCj4gaW51c2UgPSBESVY2NF9VNjRf
Uk9VTkRfVVAoDQo+IA0KDQoNCg0KDQoNCg==

