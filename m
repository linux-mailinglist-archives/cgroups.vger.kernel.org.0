Return-Path: <cgroups+bounces-2648-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9DF8ACDBF
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 15:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F8AB242F7
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 13:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FD14EC7D;
	Mon, 22 Apr 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="QvGAWxu8"
X-Original-To: cgroups@vger.kernel.org
Received: from bjm7-spam01.kuaishou.com (smtpcn03.kuaishou.com [103.107.217.217])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61899149C6C;
	Mon, 22 Apr 2024 13:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.107.217.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791116; cv=none; b=W6UpgEUCxD6KCp83EyhSoOhM3RLPWhPCdKqeRC2WwG3X5lUPhLTrhTKJkhBV2eUEO7Slu7pSIodeLXZKoCHbhI7oIOddNi42K3d1/TYDSgpH8QawfLiEzxSnKuFT2G/UjzgDaQhuBy9qV6VCxgw6QooYt6N4lTapZURcpIkh2HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791116; c=relaxed/simple;
	bh=7IgAqNObdTNIs+v4wPjXNvzjhPKhJtnwoYfAtKltNcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QOtbGwXzTpAIWsqZ2UfUyFsWYhQghcpq58waFbAhHuj5oi/bu8h/081RSvyNpy9ufhlQEJ0Yui8rk6clsy8Ohe77o1VHU0SvEUcdCWQELDwKBsmY4VS1RQ4KpfHZ117dJ8wuYTNtIXHVZI6evrTyCZ+Mx9FPjCC2+KwNSLdz8YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=QvGAWxu8; arc=none smtp.client-ip=103.107.217.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Received: from bjxm-pm-mail04.kuaishou.com (unknown [172.28.128.4])
	by bjm7-spam01.kuaishou.com (Postfix) with ESMTPS id 19A6218017040;
	Mon, 22 Apr 2024 21:05:09 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1713791109; h=from:subject:to:date:message-id;
	bh=7IgAqNObdTNIs+v4wPjXNvzjhPKhJtnwoYfAtKltNcI=;
	b=QvGAWxu8ZCuPLfY5WRLtnOjFgU9HIUe19Y2SDiGmXhbgsNUO0wxI216ZhGBQklUOi6B9oeEFRiG
	fkBjC59yHrY4z6JHhw5HWieaMXcU1YzOeYUEtPJtk3D2IZLxrOQY3keMm/9+vG3KnnrNxxsSXrjTJ
	S2FkPgjOTLUbvUR9QFQ=
Received: from bjm7-pm-mail01.kuaishou.com (172.28.1.1) by
 bjxm-pm-mail04.kuaishou.com (172.28.128.4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Mon, 22 Apr 2024 21:05:08 +0800
Received: from bjm7-pm-mail01.kuaishou.com ([fe80::90df:c4ca:7789:1e31]) by
 bjm7-pm-mail01.kuaishou.com ([fe80::90df:c4ca:7789:1e31%16]) with mapi id
 15.02.1118.020; Mon, 22 Apr 2024 21:05:08 +0800
From: =?gb2312?B?1tzMqdPu?= <zhoutaiyu@kuaishou.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, "tj@kernel.org" <tj@kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yukuai (C)"
	<yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
Thread-Topic: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
Thread-Index: AQHalLWzslikgOEBQkagU28wACFozA==
Date: Mon, 22 Apr 2024 13:05:08 +0000
Message-ID: <2b492386e60c4819ac694a65de9b5846@kuaishou.com>
References: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
 <ea781ccc-c29e-894e-c54a-f44ea349edca@huaweicloud.com>
 <e2d291e6b6ed43d89930eb2a7d459ff8@kuaishou.com>,<6ab1172f-2c9a-ede3-8020-13c73b91db84@huaweicloud.com>
In-Reply-To: <6ab1172f-2c9a-ede3-8020-13c73b91db84@huaweicloud.com>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksIGt1YWkNCg0KVGhhbmsgeW91IHNvIG11Y2ggZm9yIHlvdXIgZmVlZGJhY2suDQoNCj4gVGhl
IHBvbml0IGhlcmUgaXMgdGhhdCB5b3UgYnJlYWsgdGhlIHJ1bGVzIGFib3V0IEZJRk8sIGJsay10
aHJvdHRsZQ0KPiBvbmx5IGp1ZGdlIHRoZSBiaW8gZnJvbSBoZWFkIGlmIGl0J3Mgd2l0aGluIGxp
bWl0LiBDdXJyZW50IGNvZGUgdG8ganVkZ2UNCj4gaWYgdGcgaW9wcyByZWFjaGVzIGxpbWl0IG9u
IHRoZSBjb25kaXRpb24gdGhhdCBubyBiaW8gaXMgdGhyb3R0bGVkLiBBbmQNCj4gdGhyb3RsIHRp
bWUgaXMgYWx3YXlzIGNhY3VsYXRlZCBieSBmaXJzdCB0aHJvdHRsZWQgYmlvLiBCdXQgdGhpcyBw
YXRjaA0KPiB3aWxsIGlnbm9yZSB0aHJvdHRsZWQgYmlvIGNhc2UsIGFuZCB0aGF0J3Mgd2h5IEkg
c2FpZCBJTyB3aWxsIG5vdCBiZQ0KPiB0aHJvdHRsZWQgYnkgaW9wcyBsaW1pc3QgYW55bW9yZS4g
WW91IGNhbiB0ZXN0IHRoaXMgd2l0aCBicHMgbGltaXQNCj4gZGlzYWJsZWQuDQoNClNvcnJ5LCBJ
IGRvbid0IGdldCBpdC4gIFllcywgSSBrbm93IHRoaXMgcGF0Y2ggd2lsbCBicmVhayB0aGUgRklG
TyBydWxlLg0KQnV0IEkgZGlkbid0IGZpbmQgYW55IHByb2JsZW1zIGFmdGVyIGxldHRpbmcgc3Bs
aXQgYmlvIGJyZWFrIHRoaXMgcnVsZS4gDQpJIHRoaW5rIHRoZSBzcGxpdCBiaW8gc2hvdWxkIGJl
IGlnbm9yZWQgaWYgaXQgZG9lcyBub3QNCm1ha2UgdGhlIHRnIG91dCBvZiBpb3BzIGxpbWl0IGFu
ZCBiZSBqdWRnZWQgaW4gdGdfd2l0aGluX2lvcHNfbGltaXQoKS4NCg0KSW4gdGhlIHBhdGNoLCBz
cGxpdCBiaW8gd2l0aGluIGlvcHMgbGltaXQgIHdpbGwgYmUgZGlzcGF0Y2hlZCBkaXJlY3RseS4N
Ckhvd2V2ZXIsIGlmIHRoZSBzcGxpdCBiaW8gbWFrZXMgYSB0ZyBvdXQgb2YgSU9QUyBsaW1pdCwg
dGhlIHNwbGl0IGJpbyB3aWxsIGJlIHRocm90dGxlZCANCmFuZCBiZSBhZGRlZCB0byB0aGUgdGcn
cyBzcS0+cXVldWVbcnddIGJ5IGNhbGxpbmcgdGhyb3RsX2FkZF9iaW9fdGcoKS4NCg0KVGhlcmUg
ZXhpc3RzIHR3byBjYXNlcyBhZnRlciB0aGUgc3BsaXQgYmlvIGlzIGp1ZGdlZCB0byBiZSB0aHJv
dHRsZWQuDQoNCjEpIFRoZSB0Zy0+c3EtPnF1ZXVlIGlzIGVtcHR5LiBJbiB0aGlzIGNhc2UsIHRo
ZSBzcGxpdCBiaW8gd2lsbCBiZSB0aGUgZmlyc3QgcXVldWVkIGJpby4gIFRoZSB0ZydzIA0KbGF0
ZXN0IGRpc3BhdGNoIHRpbWUgaXMgY2FsY3VsYXRlZCBhY2NvcmRpbmcgdG8gdGhlIHNwbGl0IGJp
byBieSBjYWxsaW5nIHRnX3VwZGF0ZV9kaXNwdGltZSgpLCBhbmQgDQp0aGUgZGlzcGF0Y2ggdGlt
ZXIgaXMgd2FrZWQgdXAgYnkgY2FsbGluZyB0aHJvdGxfc2NoZWR1bGVfbmV4dF9kaXNwYXRjaCgp
Lg0KDQoyKSBUaGUgdGctPnNxLT5xdWV1ZSBpcyBub3QgZW1wdHkuIEluIHRoaXMgY2FzZSwgdGhl
IHRnJ3MgZGlzcGF0Y2ggdGltZSBoYXMgYmVlbiB1cGRhdGVkDQphY2NvcmRpbmcgdG8gdGhlIGZp
cnN0IHF1ZXVlZCBiaW8gYW5kIHRoZSBkaXNwYXRjaCB0aW1lciBpcyBhbHNvIHdha2VkIHVwLg0K
U28sIGJsay10aHJvdHRsZSBqdXN0IGFkZHMgdGhlIHNwbGl0IGJpbyB0byB0aGUgdGFpbCBvZiB0
aGUgc3EtPnF1ZXVlW3J3XSB3aGljaCBhY3RzIGxpa2UNCnRoZSBjdXJyZW50IGNvZGUgKHNwbGl0
IGJpbyBpcyB0aHJvdHRsZWQgYmVjYXVzZSBzcS0+bnJfcXVldWVbcnddIGlzIG5vdCB6ZXJvKS4N
Cg0KDQpJIGhhdmUgdGVzdGVkIHRoaXMgcGF0Y2ggYnkgb25seSBzZXR0aW5nIGlvcHMgbGltaXQg
YXMgeW91IGFkdmlzZWQsIHdpdGggZm9sbG93aW5nIHNjcmlwdHMNCg0KIyEvYmluL2Jhc2gNCg0K
Q05VTT0zMA0KbWtkaXIgLXAgL3N5cy9mcy9jZ3JvdXAvYmxraW8vdGVzdDANCiNlY2hvICI4OjE2
IDEwNDg1NzYwIiA+IC9zeXMvZnMvY2dyb3VwL2Jsa2lvL3Rlc3QwL2Jsa2lvLnRocm90dGxlLndy
aXRlX2Jwc19kZXZpY2UNCmVjaG8gIjg6MTYgNTAiID4gL3N5cy9mcy9jZ3JvdXAvYmxraW8vdGVz
dDAvYmxraW8udGhyb3R0bGUud3JpdGVfaW9wc19kZXZpY2UNCg0KZm9yICgoaT0wO2k8JENOVU07
aSsrKSk7ZG8NCiAgICAgICAgZmlvIC1ydz13cml0ZSAtZGlyZWN0PTEgLWJzPTRNIC1pb2RlcHRo
PTggLXNpemU9MjAwTSAtbnVtam9icz0xIC10aW1lX2Jhc2VkPTEgLXJ1bnRpbWU9MTEwICAtbmFt
ZT10ZXN0dF8kaSAtZmlsZW5hbWU9dGVzdGZfJGkgID4gL2Rldi9udWxsICYNCiAgICAgICAgZWNo
byAkISA+IC9zeXMvZnMvY2dyb3VwL2Jsa2lvL3Rlc3QwL3Rhc2tzDQpkb25lDQoNCkkgbW9uaXRv
ciB0aGUgdy9zIG9uIGlvc3RhdCBhbmQgdGhlIGNoYW5nZSBvZiAvc3lzL2ZzL2Nncm91cC9ibGtp
by90ZXN0MC9ibGtpby50aHJvdHRsZS5pb19zZXJ2aWNlZCBldmVyeSBzZWNvbmQuDQpJdCBzZWVt
cyB3b3JrIHBlcmZlY3RseSAoYXJvdW5kIDUwKS4gIA0KDQpJIGFsc28gc2VlIHRoZSBzcGxpdCBi
aW8gYmUgdGhyb3R0bGVkIHRocm91Z2ggdGhlIHRyYWNlX3BpcGUNCg0KICAgIGt3b3JrZXIvMTk6
Mi0xNjAzICAgIFswMTldIGQuLjEuICAgNTgzLjU1NjAxMjogICA4LDE2ICAgWCAgV1MgOTc3MTUz
MjE2IC8gOTc3MTU1Nzc2IFtrd29ya2VyLzE5OjJdDQogICAga3dvcmtlci8xOToyLTE2MDMgICAg
WzAxOV0gZC4uMS4gICA1ODMuNTU2MDEyOiAgIDgsMTYgIDEsMCAgbSAgIE4gdGhyb3RsIFtXXSBi
aW8uIGJkaXNwPTAgc3o9MTU3Mjg2NCBicHM9MTg0NDY3NDQwNzM3MDk1NTE2MTUgaW9kaXNwPTUg
aW9wcz01MCBxdWV1ZWQ9MC8yOA0KICAgIC4uLi4uLg0KICAgIGt3b3JrZXIvMTk6Mi0xNjAzICAg
IFswMTldIGQuLjEuICAgNTgzLjU1NjAxNzogICA4LDE2ICAgWCAgV1MgMTg3MDQ3MiAvIDE4NzMw
MzIgW2t3b3JrZXIvMTk6Ml0NCiAgICBrd29ya2VyLzE5OjItMTYwMyAgICBbMDE5XSBkLi4xLiAg
IDU4My41NTYwMTg6ICAgOCwxNiAgMSwwICBtICAgTiB0aHJvdGwgW1ddIGJpby4gYmRpc3A9MCBz
ej0xNTcyODY0IGJwcz0xODQ0Njc0NDA3MzcwOTU1MTYxNSBpb2Rpc3A9NSBpb3BzPTUwIHF1ZXVl
ZD0wLzI5DQoNCldvdWxkIHlvdSBtaW5kIGdpdmUgbWUgbW9yZSBoaW50cyB0byBmaW5kIG91dCB0
aGUgcHJvYmxlbXMgb2YgbXkgcGF0Y2ggb3IgdHJ5IG15IHBhdGNoPyANCg0KU2luY2VyZWx5LA0K
VGFpeXUgWmhvdQ==

