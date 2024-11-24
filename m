Return-Path: <cgroups+bounces-5675-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64D19D75DE
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2024 17:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61D94B676BF
	for <lists+cgroups@lfdr.de>; Sun, 24 Nov 2024 14:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D21F9A9E;
	Sun, 24 Nov 2024 13:42:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 557481F9A87;
	Sun, 24 Nov 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455774; cv=none; b=A4y9yVWceCz9UpC1QX+VOHAl0L9ibUHMBah8OkWsm9DqPywziowxphGESXnXfOaCS7nM2yxQG5Um5VyLMDBkG8kZf95A1uxlPcnjH9xQILmTmFizhqwY7arGv9atD0eW9xabEOqzH6QE3T0Vx7k8i908uWS6UxTDPn7MtpBI6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455774; c=relaxed/simple;
	bh=MmwMCPrM9AuWrKSPKRDw0/46E7tEcIxq2BmimQ4Ulbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=jr50pG8N7yVpD9E3x4lYnZiTCwAI9DVm1oQXFPfSbtVQZhz7yxhd+lIYdRtJmmThVWO7eJ+0E/NtA88aYsGDom1kwYcFnh1AJpQ3CiZYyyJkgX7W/K6OXwhcRcQYHtFWMnJ7ODqO0KwXco9yMWHGgs1OBx6crzE9A4yD7hZvGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.37])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id A8159186D6C8E0;
	Sun, 24 Nov 2024 21:42:05 +0800 (CST)
Received: from BJ02-ACTMBX-03.didichuxing.com (10.79.65.11) by
 BJ03-ACTMBX-01.didichuxing.com (10.79.71.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 24 Nov 2024 21:42:23 +0800
Received: from BJ02-ACTMBX-03.didichuxing.com ([fe80::9c02:2754:e1db:e82e]) by
 BJ02-ACTMBX-03.didichuxing.com ([fe80::9c02:2754:e1db:e82e%5]) with mapi id
 15.02.1544.011; Sun, 24 Nov 2024 21:42:23 +0800
X-MD-Sfrom: daikunhai@didiglobal.com
X-MD-SrcIP: 10.79.71.37
From: =?utf-8?B?5oi05Z2k5rW3IFRvbnkgRGFp?= <daikunhai@didiglobal.com>
To: "tj@kernel.org" <tj@kernel.org>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: iocost: ensure hweight_inuse is at least 1
Thread-Topic: [PATCH] block: iocost: ensure hweight_inuse is at least 1
Thread-Index: AQHbPK/ZVOMoLGOycU+ydueJcsx/wrLGdAAA
Date: Sun, 24 Nov 2024 13:42:23 +0000
Message-ID: <191E5CDE-1E1C-4035-91BF-322CBB05E651@didiglobal.com>
In-Reply-To: <20241122072609.29429-1-daikunhai@didiglobal.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E36976AACDB324CA4AC64918F709B0A@didichuxing.com>
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
d2VpZ2h0IGNncm91cCkuDQoNCu+7v+WcqCAyMDI0LzExLzIyIDE1OjI277yM4oCc5oi05Z2k5rW3
IFRvbnkgRGFp4oCdPGRhaWt1bmhhaUBkaWRpZ2xvYmFsLmNvbSA8bWFpbHRvOmRhaWt1bmhhaUBk
aWRpZ2xvYmFsLmNvbT4+IOWGmeWFpToNCg0KDQpUaGUgaHdlaWdodF9pbnVzZSBjYWxjdWxhdGlv
biBpbiB0cmFuc2Zlcl9zdXJwbHVzZXMoKSBjb3VsZCBwb3RlbnRpYWxseQ0KcmVzdWx0IGluIGEg
dmFsdWUgb2YgMCwgd2hpY2ggd291bGQgbGVhZCB0byBkaXZpc2lvbiBieSB6ZXJvIGVycm9ycyBp
bg0Kc3Vic2VxdWVudCBjYWxjdWxhdGlvbnMgdGhhdCB1c2UgdGhpcyB2YWx1ZSBhcyBhIGRpdmlz
b3IuDQoNCg0KU2lnbmVkLW9mZi1ieTogS3VuaGFpIERhaSA8ZGFpa3VuaGFpQGRpZGlnbG9iYWwu
Y29tIDxtYWlsdG86ZGFpa3VuaGFpQGRpZGlnbG9iYWwuY29tPj4NCi0tLQ0KYmxvY2svYmxrLWlv
Y29zdC5jIHwgNyArKysrLS0tDQoxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KDQoNCmRpZmYgLS1naXQgYS9ibG9jay9ibGstaW9jb3N0LmMgYi9ibG9jay9i
bGstaW9jb3N0LmMNCmluZGV4IDM4NGFhMTVlODI2MC4uNjVjZGI1NWQzMGNjIDEwMDY0NA0KLS0t
IGEvYmxvY2svYmxrLWlvY29zdC5jDQorKysgYi9ibG9jay9ibGstaW9jb3N0LmMNCkBAIC0xOTk5
LDkgKzE5OTksMTAgQEAgc3RhdGljIHZvaWQgdHJhbnNmZXJfc3VycGx1c2VzKHN0cnVjdCBsaXN0
X2hlYWQgKnN1cnBsdXNlcywgc3RydWN0IGlvY19ub3cgKm5vdykNCnBhcmVudCA9IGlvY2ctPmFu
Y2VzdG9yc1tpb2NnLT5sZXZlbCAtIDFdOw0KDQoNCi8qIGInID0gZ2FtbWEgKiBiX2YgKyBiX3Qn
ICovDQotIGlvY2ctPmh3ZWlnaHRfaW51c2UgPSBESVY2NF9VNjRfUk9VTkRfVVAoDQotICh1NjQp
Z2FtbWEgKiAoaW9jZy0+aHdlaWdodF9hY3RpdmUgLSBpb2NnLT5od2VpZ2h0X2RvbmF0aW5nKSwN
Ci0gV0VJR0hUX09ORSkgKyBpb2NnLT5od2VpZ2h0X2FmdGVyX2RvbmF0aW9uOw0KKyBpb2NnLT5o
d2VpZ2h0X2ludXNlID0gbWF4X3QodTY0LCAxLA0KKyBESVY2NF9VNjRfUk9VTkRfVVAoDQorICh1
NjQpZ2FtbWEgKiAoaW9jZy0+aHdlaWdodF9hY3RpdmUgLSBpb2NnLT5od2VpZ2h0X2RvbmF0aW5n
KSwNCisgV0VJR0hUX09ORSkgKyBpb2NnLT5od2VpZ2h0X2FmdGVyX2RvbmF0aW9uKTsNCg0KDQov
KiB3JyA9IHMnICogYicgLyBiJ19wICovDQppbnVzZSA9IERJVjY0X1U2NF9ST1VORF9VUCgNCi0t
IA0KMi4yNy4wDQoNCg0KDQoNCg0K

