Return-Path: <cgroups+bounces-7632-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F390A92FE1
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 04:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66ED3A54D3
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 02:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E033267B09;
	Fri, 18 Apr 2025 02:22:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70AA261362;
	Fri, 18 Apr 2025 02:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942955; cv=none; b=jeKbcjOaG5eIZuKVnQk5RHOGCIiG8ftwZmJ9JYfnCVadCDrlMihmNJxoSdL+MfpRml6oNhwzH4cqv7OzDs/A9pnYP7hhWzn+tKvmvNtVMUjvp0gg/tS7GfnJ+lyxzObCbCaNaQUqWz6EIva7nIT26SekvdlvHxkt/yNWnrQqab4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942955; c=relaxed/simple;
	bh=1Tx6Mdt3qKj5SG8qW+SRU7cETDJ7D/+YS/cjVrLSmsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jXiPhx+5EV25YSjGR8i+OCXgR+1aCSLVbHoZbOVr+9RmxoWI46BXu23ZW0rIY33DkkR+OldEnhrMHcnG2ydjDY/jZEyjeqpXrqMHkNDzgb7GYGFxkLVFw7ZhhksxojFVgVRRA6BlsNPB+KezSdX5mm0YU3ZfJC0Ix+G9L85had8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w002.hihonor.com (unknown [10.68.28.120])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4ZdygV2RyKzYl2Zr;
	Fri, 18 Apr 2025 10:01:58 +0800 (CST)
Received: from a003.hihonor.com (10.68.18.8) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Apr
 2025 10:03:43 +0800
Received: from a007.hihonor.com (10.68.22.31) by a003.hihonor.com (10.68.18.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 18 Apr
 2025 10:03:43 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Fri, 18 Apr 2025 10:03:43 +0800
From: gaoxu <gaoxu2@honor.com>
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?B?TWljaGFsIEtvdXRuw70=?=
	<mkoutny@suse.com>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>, yipengxiang <yipengxiang@honor.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIGNncm91cDogRml4IGNvbXBpbGF0aW9uIGlzc3Vl?=
 =?utf-8?Q?_due_to_cgroup=5Fmutex_not_being_exported?=
Thread-Topic: [PATCH] cgroup: Fix compilation issue due to cgroup_mutex not
 being exported
Thread-Index: AQHbr7QM71iuXDyYE0O6u3XCrJ7tRrOorLKQ
Date: Fri, 18 Apr 2025 02:03:43 +0000
Message-ID: <93828629f46942b487ec2f6fd6dd373f@honor.com>
References: <24763f5c8a13421fa6dc3672a57a7836@honor.com>
 <d7cf14f0-213f-4e15-abe8-cc09a293c4fc@oracle.com>
In-Reply-To: <d7cf14f0-213f-4e15-abe8-cc09a293c4fc@oracle.com>
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

PiANCj4gT24gNC8xNy8yNSAxOjAwIFBNLCBnYW94dSB3cm90ZToNCj4gWy4uLl0NCj4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMgYi9rZXJuZWwvY2dyb3VwL2Nncm91
cC5jIGluZGV4DQo+ID4gNDQ3YWM4NTdlLi45ZTYwZmY2MjkgMTAwNjQ0DQo+ID4gLS0tIGEva2Vy
bmVsL2Nncm91cC9jZ3JvdXAuYw0KPiA+ICsrKyBiL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMNCj4g
PiBAQCAtOTAsNyArOTAsNyBAQA0KPiA+ICBERUZJTkVfTVVURVgoY2dyb3VwX211dGV4KTsNCj4g
PiAgREVGSU5FX1NQSU5MT0NLKGNzc19zZXRfbG9jayk7DQo+ID4NCj4gPiAtI2lmZGVmIENPTkZJ
R19QUk9WRV9SQ1UNCj4gPiArI2lmIChkZWZpbmVkIENPTkZJR19QUk9WRV9SQ1UgfHwgZGVmaW5l
ZCBDT05GSUdfTE9DS0RFUCkNCj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoY2dyb3VwX211dGV4KTsN
Cj4gPiAgRVhQT1JUX1NZTUJPTF9HUEwoY3NzX3NldF9sb2NrKTsNCj4gPiAgI2VuZGlmDQo+IA0K
PiANCj4gSXQgY2FuIGJlIHRyaWdnZXJlZCB3aGVuIENPTkZJR19MT0NLX1NUQVQ9eSBpcyBlbmFi
bGVkLCB3aGljaCBzZWxlY3RzDQo+IENPTkZJR19MT0NLREVQPXkgYW5kIHNldHMgQ09ORklHX1BS
T1ZFX1JDVT1uLiBUaGUgcGF0Y2ggbG9va3MgZ29vZCB0bw0KPiBtZS4NCj4gDQo+IFlvdSBtYXkg
YWxzbyB3YW50IHRvIHVwZGF0ZSB0aGUgZGVzY3JpcHRpb24gYWJvdmUNCj4gREVGSU5FX01VVEVY
KGNncm91cF9tdXRleCk7IHRvIHJlZmxlY3QgdGhlIG1vZGlmaWNhdGlvbnMgaW50cm9kdWNlZCBi
eSB0aGlzDQo+IHBhdGNoLg0KUmVjZWl2ZWQsIHRoYW5rcyENCj4gDQo+IC0tDQo+IENoZWVycywN
Cj4gS2FtYWxlc2gNCg0K

