Return-Path: <cgroups+bounces-7674-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4A5A9461F
	for <lists+cgroups@lfdr.de>; Sun, 20 Apr 2025 02:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD59F189593B
	for <lists+cgroups@lfdr.de>; Sun, 20 Apr 2025 00:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FD8C13B;
	Sun, 20 Apr 2025 00:49:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D02136A;
	Sun, 20 Apr 2025 00:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745110188; cv=none; b=BnYap1SKKn6e6A1gsjR1G1eCSPJUuUxsR5hQdLNYVlorfC+d+lJPW92W9LGi+jBYBjeRdhsjQzMsJ0aivIu+kXRAnlE7vnG1HLV7Ipb/tYaR2kNpoMBD9zc61XFj0exi0kNyzzvSzUD7HuR28Ts5cf3u/5k4hmza1ziBQ82PVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745110188; c=relaxed/simple;
	bh=uH5w60ZKQo9st9KyEt5K4q1afZynKAInPJQIETXOtBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t7FwrgrHM+b4HtSU2vwUtrCWI0EW9KItsrFt8JxHFDxt7QuD6YMR1h54X8uWf+60zdexLUVts5iOCoByBXfLYLT4WoBRMLNs2zteNrfISvwCrjSHHBUBNSASAcVW3FS05LKl0CGUFBMG6BDj+EHQ/ZnPKC3ZzO5D+i0LJHLSQuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4Zg8yS6c8KzYl9q5;
	Sun, 20 Apr 2025 08:49:04 +0800 (CST)
Received: from a001.hihonor.com (10.68.28.182) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Apr
 2025 08:49:42 +0800
Received: from a007.hihonor.com (10.68.22.31) by a001.hihonor.com
 (10.68.28.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 20 Apr
 2025 08:49:37 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Sun, 20 Apr 2025 08:49:32 +0800
From: gaoxu <gaoxu2@honor.com>
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?B?TWljaGFsIEtvdXRuw70=?=
	<mkoutny@suse.com>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>, yipengxiang <yipengxiang@honor.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIGNncm91cDogRml4IGNvbXBpbGF0aW9uIGlz?=
 =?utf-8?Q?sue_due_to_cgroup=5Fmutex_not_being_exported?=
Thread-Topic: [PATCH v2] cgroup: Fix compilation issue due to cgroup_mutex not
 being exported
Thread-Index: AQHbsDYeM197mJQUykeNvUExeh4Rj7Oru2KA
Date: Sun, 20 Apr 2025 00:49:32 +0000
Message-ID: <d181a0a4e1bf42f69d9b1a26fc5dc8ea@honor.com>
References: <5df9200f0e7c4bc586af76e21b380f67@honor.com>
 <af289b54-de43-4d7c-bf74-926abfad7808@oracle.com>
In-Reply-To: <af289b54-de43-4d7c-bf74-926abfad7808@oracle.com>
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

PiANCj4gSGksDQo+IA0KPiBPbiA0LzE4LzI1IDg6MTIgQU0sIGdhb3h1IHdyb3RlOg0KPiANCj4g
Wy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2Nncm91cC9jZ3JvdXAuYyBiL2tlcm5lbC9j
Z3JvdXAvY2dyb3VwLmMgaW5kZXgNCj4gPiA0NDdhYzg1N2UuLmMxYmM1MTA1OCAxMDA2NDQNCj4g
PiAtLS0gYS9rZXJuZWwvY2dyb3VwL2Nncm91cC5jDQo+ID4gKysrIGIva2VybmVsL2Nncm91cC9j
Z3JvdXAuYw0KPiA+IEBAIC04NCwxMyArODQsMTMgQEANCj4gPiAgICogY3NzX3NldF9sb2NrIHBy
b3RlY3RzIHRhc2stPmNncm91cHMgcG9pbnRlciwgdGhlIGxpc3Qgb2YgY3NzX3NldA0KPiA+ICAg
KiBvYmplY3RzLCBhbmQgdGhlIGNoYWluIG9mIHRhc2tzIG9mZiBlYWNoIGNzc19zZXQuDQo+ID4g
ICAqDQo+ID4gLSAqIFRoZXNlIGxvY2tzIGFyZSBleHBvcnRlZCBpZiBDT05GSUdfUFJPVkVfUkNV
IHNvIHRoYXQgYWNjZXNzb3JzIGluDQo+ID4gLSAqIGNncm91cC5oIGNhbiB1c2UgdGhlbSBmb3Ig
bG9ja2RlcCBhbm5vdGF0aW9ucy4NCj4gPiArICogVGhlc2UgbG9ja3MgYXJlIGV4cG9ydGVkIGlm
IENPTkZJR19QUk9WRV9SQ1Ugb3IgQ09ORklHX0xPQ0tERVAgc28NCj4gPiArIHRoYXQNCj4gPiAr
ICogYWNjZXNzb3JzIGluIGNncm91cC5oIGNhbiB1c2UgdGhlbSBmb3IgbG9ja2RlcCBhbm5vdGF0
aW9ucy4NCj4gPiAgICovDQo+IA0KPiBUZWp1biBoYXMgYWxyZWFkeSBtZXJnZWQgdGhlIGluaXRp
YWwgdmVyc2lvbiBvZiB0aGUgcGF0Y2ggd2l0aG91dCB0aGUgdXBkYXRlZA0KPiBkZXNjcmlwdGlv
bi4gWW91IG1heSB3YW50IHRvIHNlbmQgdGhlIGRlc2NyaXB0aW9uIGNoYW5nZSBhcyBhIHNlcGFy
YXRlIHBhdGNoLA0KPiByZWJhc2VkIG9uIHRvcCBvZiB0aGUgY2dyb3VwL2Zvci1uZXh0IGJyYW5j
aC4NCj4gDQo+IEkndmUgcmVwaHJhc2VkIHRoZSBkZXNjcmlwdGlvbiB0byBjbGFyaWZ5IHRoYXQg
bG9ja2RlcCBhbm5vdGF0aW9ucyBjYW4gb2NjdXIgZXZlbg0KPiB3aXRob3V0IENPTkZJR19QUk9W
RV9SQ1UuIEZlZWwgZnJlZSB0byB1c2UgdGhpcyB2ZXJzaW9uIG9yIG1vZGlmeSBpdCBmdXJ0aGVy
Og0KPiAiRXhwb3J0IGxvY2tzIGZvciBsb2NrZGVwIGFubm90YXRpb25zLiBVc2UgQ09ORklHX1BS
T1ZFX1JDVSBmb3IgYWNjZXNzb3JzIGluDQo+IGNncm91cC5oLCBhbmQgQ09ORklHX0xPQ0tERVAg
Zm9yIGFjY2Vzc29ycyB0aGF0IGRvIG5vdCByZXF1aXJlDQo+IENPTkZJR19QUk9WRV9SQ1UuIg0K
UmVjZWl2ZWQsIHRoYW5rcyENCj4gDQo+IC0tDQo+IENoZWVycywNCj4gS2FtYWxlc2gNCg0K

