Return-Path: <cgroups+bounces-7635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7C2A9301B
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 04:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBF58A56E7
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 02:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6577267F44;
	Fri, 18 Apr 2025 02:42:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0482638B2;
	Fri, 18 Apr 2025 02:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944179; cv=none; b=PfKbVwFsKXPsnbKLqZ1ffiYeo6lpGwzjsNIfuiS1uWDiySs8oXIjSPHfZyBnGaOM6uoqE3kwUhk3FhQcKXNZcgs2cZjR1AfMTb+hbPD8tH1uuI0zXkU9OgY/mCh598Dm1gnOeEAcHaOAB6HIw6tPdVku5rmfTFfzk60IEpx94LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944179; c=relaxed/simple;
	bh=JzLWMs2Szs5aHTCCSNq+CuxhsWOY7R+nLzMPUd/iKxA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Qq2SGOJ0EcFQwJkNqtXKA/fPl9mwOL2MCD72mZpBc1/LB7rAF/EVxmk5+Ve/Lhzd7XCUTID4sPPGeDp11cNT3my7nE59UjgqE4Q3u5aGXeucdxYzd1Eb+TmRPfwXbcobhl/ujwSg0NMOLSNGUZB5QWTfgQp/9ey4wl46ZLAMY6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4ZdzXk2W5DzYkxhB;
	Fri, 18 Apr 2025 10:41:10 +0800 (CST)
Received: from a003.hihonor.com (10.68.18.8) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Apr
 2025 10:42:55 +0800
Received: from a007.hihonor.com (10.68.22.31) by a003.hihonor.com (10.68.18.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Apr
 2025 10:42:55 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Fri, 18 Apr 2025 10:42:55 +0800
From: gaoxu <gaoxu2@honor.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	=?utf-8?B?Ik1pY2hhbCBLb3V0bsO9Ig==?= <mkoutny@suse.com>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kamalesh
 Babulal" <kamalesh.babulal@oracle.com>, "surenb@google.com"
	<surenb@google.com>, yipengxiang <yipengxiang@honor.com>
Subject: [PATCH v2] cgroup: Fix compilation issue due to cgroup_mutex not
 being  exported
Thread-Topic: [PATCH v2] cgroup: Fix compilation issue due to cgroup_mutex not
 being  exported
Thread-Index: AduwCdTeMvaUVPv/T2GFTliS72mszA==
Date: Fri, 18 Apr 2025 02:42:55 +0000
Message-ID: <5df9200f0e7c4bc586af76e21b380f67@honor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

V2hlbiBhZGRpbmcgZm9saW9fbWVtY2cgZnVuY3Rpb24gY2FsbCBpbiB0aGUgenJhbSBtb2R1bGUg
Zm9yDQpBbmRyb2lkIDE2LTYuMTIsIHRoZSBmb2xsb3dpbmcgZXJyb3Igb2NjdXJzIGR1cmluZyBj
b21waWxhdGlvbjoNCkVSUk9SOiBtb2Rwb3N0OiAiY2dyb3VwX211dGV4IiBbLi4vc29jLXJlcG8v
enJhbS5rb10gdW5kZWZpbmVkIQ0KDQpUaGlzIGVycm9yIGlzIGNhdXNlZCBieSB0aGUgaW5kaXJl
Y3QgY2FsbCB0byBsb2NrZGVwX2lzX2hlbGQoJmNncm91cF9tdXRleCkNCndpdGhpbiBmb2xpb19t
ZW1jZy4gVGhlIGV4cG9ydCBzZXR0aW5nIGZvciBjZ3JvdXBfbXV0ZXggaXMgY29udHJvbGxlZCBi
eQ0KdGhlIENPTkZJR19QUk9WRV9SQ1UgbWFjcm8uIElmIENPTkZJR19MT0NLREVQIGlzIGVuYWJs
ZWQgd2hpbGUNCkNPTkZJR19QUk9WRV9SQ1UgaXMgbm90LCB0aGlzIGNvbXBpbGF0aW9uIGVycm9y
IHdpbGwgb2NjdXIuDQoNClRvIHJlc29sdmUgdGhpcyBpc3N1ZSwgYWRkIGEgcGFyYWxsZWwgbWFj
cm8gQ09ORklHX0xPQ0tERVAgY29udHJvbCB0bw0KZW5zdXJlIGNncm91cF9tdXRleCBpcyBwcm9w
ZXJseSBleHBvcnRlZCB3aGVuIG5lZWRlZC4NCg0KU2lnbmVkLW9mZi1ieTogZ2FvIHh1IDxnYW94
dTJAaG9ub3IuY29tPg0KLS0tDQp2MSAtPiB2MjogdXBkYXRlIHRoZSBub3RlcyBvZiB0aGUgZGVz
Y3JpcHRpb24gYWJvdmUgREVGSU5FX01VVEVYKGNncm91cF9tdXRleCkNCnBlciBLYW1hbGVzaCdz
IHN1Z2dlc3Rpb24uDQotLS0NCiBrZXJuZWwvY2dyb3VwL2Nncm91cC5jIHwgNiArKystLS0NCiAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0t
Z2l0IGEva2VybmVsL2Nncm91cC9jZ3JvdXAuYyBiL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMNCmlu
ZGV4IDQ0N2FjODU3ZS4uYzFiYzUxMDU4IDEwMDY0NA0KLS0tIGEva2VybmVsL2Nncm91cC9jZ3Jv
dXAuYw0KKysrIGIva2VybmVsL2Nncm91cC9jZ3JvdXAuYw0KQEAgLTg0LDEzICs4NCwxMyBAQA0K
ICAqIGNzc19zZXRfbG9jayBwcm90ZWN0cyB0YXNrLT5jZ3JvdXBzIHBvaW50ZXIsIHRoZSBsaXN0
IG9mIGNzc19zZXQNCiAgKiBvYmplY3RzLCBhbmQgdGhlIGNoYWluIG9mIHRhc2tzIG9mZiBlYWNo
IGNzc19zZXQuDQogICoNCi0gKiBUaGVzZSBsb2NrcyBhcmUgZXhwb3J0ZWQgaWYgQ09ORklHX1BS
T1ZFX1JDVSBzbyB0aGF0IGFjY2Vzc29ycyBpbg0KLSAqIGNncm91cC5oIGNhbiB1c2UgdGhlbSBm
b3IgbG9ja2RlcCBhbm5vdGF0aW9ucy4NCisgKiBUaGVzZSBsb2NrcyBhcmUgZXhwb3J0ZWQgaWYg
Q09ORklHX1BST1ZFX1JDVSBvciBDT05GSUdfTE9DS0RFUCBzbyB0aGF0DQorICogYWNjZXNzb3Jz
IGluIGNncm91cC5oIGNhbiB1c2UgdGhlbSBmb3IgbG9ja2RlcCBhbm5vdGF0aW9ucy4NCiAgKi8N
CiBERUZJTkVfTVVURVgoY2dyb3VwX211dGV4KTsNCiBERUZJTkVfU1BJTkxPQ0soY3NzX3NldF9s
b2NrKTsNCiANCi0jaWZkZWYgQ09ORklHX1BST1ZFX1JDVQ0KKyNpZiAoZGVmaW5lZCBDT05GSUdf
UFJPVkVfUkNVIHx8IGRlZmluZWQgQ09ORklHX0xPQ0tERVApDQogRVhQT1JUX1NZTUJPTF9HUEwo
Y2dyb3VwX211dGV4KTsNCiBFWFBPUlRfU1lNQk9MX0dQTChjc3Nfc2V0X2xvY2spOw0KICNlbmRp
Zg0KLS0gDQoyLjE3LjENCg==

