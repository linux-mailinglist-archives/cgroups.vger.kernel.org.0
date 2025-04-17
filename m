Return-Path: <cgroups+bounces-7607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABCA91543
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 09:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5211893206
	for <lists+cgroups@lfdr.de>; Thu, 17 Apr 2025 07:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99D822154E;
	Thu, 17 Apr 2025 07:30:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF99D1F55E0;
	Thu, 17 Apr 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875011; cv=none; b=FbgFSojAkb1s6RxVjn8U0JwMHol1BbbP48U89gBhVWGIaJ9Cga0Ub80FCT1OITkO9OfATVjsRwZ1xnNt4Yghtl18N9Y19N2D18ng1bw42rtpP6l117cBWZjV3hTG55oBxG7mydST+718EChAEWBy5It6d0jArBkEFkVvcUL03pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875011; c=relaxed/simple;
	bh=4r2xm5VMxty8PMSLRQJuI6jowIacihcMePO3O1ALorw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F0SzIqEFLVIk0wHRHvhONwv3tTXao9eiZ/HE8M42R+ZNZOvXF2P6aZCL2+BbaOp06CF4qaKxTvC1H5P8kQpolzXwbFvc/Q6hNedlFnLQdx3wgAipdPEdCW185Oprcqyy+x8PZ3prL1bOWqXhHRa0HKYs+nu333m8NLTU+8WBl44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4ZdTzm0b84zYlBM9;
	Thu, 17 Apr 2025 15:29:24 +0800 (CST)
Received: from a006.hihonor.com (10.68.23.242) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Apr
 2025 15:30:01 +0800
Received: from a007.hihonor.com (10.68.22.31) by a006.hihonor.com
 (10.68.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 17 Apr
 2025 15:30:00 +0800
Received: from a007.hihonor.com ([fe80::e866:83ac:f23b:c25c]) by
 a007.hihonor.com ([fe80::e866:83ac:f23b:c25c%10]) with mapi id
 15.02.1544.011; Thu, 17 Apr 2025 15:30:00 +0800
From: gaoxu <gaoxu2@honor.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	=?utf-8?B?Ik1pY2hhbCBLb3V0bsO9Ig==?= <mkoutny@suse.com>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>, yipengxiang <yipengxiang@honor.com>
Subject: [PATCH] cgroup: Fix compilation issue due to cgroup_mutex not being
  exported
Thread-Topic: [PATCH] cgroup: Fix compilation issue due to cgroup_mutex not
 being  exported
Thread-Index: AduvagKxP1b3Kr31RQqt+yXrhxkqpw==
Date: Thu, 17 Apr 2025 07:30:00 +0000
Message-ID: <24763f5c8a13421fa6dc3672a57a7836@honor.com>
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
Zm9yDQpBbmRyb2lkMTYtNi4xMiwgdGhlIGZvbGxvd2luZyBlcnJvciBvY2N1cnMgZHVyaW5nIGNv
bXBpbGF0aW9uOg0KRVJST1I6IG1vZHBvc3Q6ICJjZ3JvdXBfbXV0ZXgiIFsuLi9zb2MtcmVwby96
cmFtLmtvXSB1bmRlZmluZWQhDQoNClRoaXMgZXJyb3IgaXMgY2F1c2VkIGJ5IHRoZSBpbmRpcmVj
dCBjYWxsIHRvIGxvY2tkZXBfaXNfaGVsZCgmY2dyb3VwX211dGV4KQ0Kd2l0aGluIGZvbGlvX21l
bWNnLiBUaGUgZXhwb3J0IHNldHRpbmcgZm9yIGNncm91cF9tdXRleCBpcyBjb250cm9sbGVkIGJ5
DQp0aGUgQ09ORklHX1BST1ZFX1JDVSBtYWNyby4gSWYgQ09ORklHX0xPQ0tERVAgaXMgZW5hYmxl
ZCB3aGlsZQ0KQ09ORklHX1BST1ZFX1JDVSBpcyBub3QsIHRoaXMgY29tcGlsYXRpb24gZXJyb3Ig
d2lsbCBvY2N1ci4NCg0KVG8gcmVzb2x2ZSB0aGlzIGlzc3VlLCBhZGQgYSBwYXJhbGxlbCBtYWNy
byBDT05GSUdfTE9DS0RFUCBjb250cm9sIHRvDQplbnN1cmUgY2dyb3VwX211dGV4IGlzIHByb3Bl
cmx5IGV4cG9ydGVkIHdoZW4gbmVlZGVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBnYW8geHUgPGdhb3h1
MkBob25vci5jb20+DQotLS0NCiBrZXJuZWwvY2dyb3VwL2Nncm91cC5jIHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
a2VybmVsL2Nncm91cC9jZ3JvdXAuYyBiL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMNCmluZGV4IDQ0
N2FjODU3ZS4uOWU2MGZmNjI5IDEwMDY0NA0KLS0tIGEva2VybmVsL2Nncm91cC9jZ3JvdXAuYw0K
KysrIGIva2VybmVsL2Nncm91cC9jZ3JvdXAuYw0KQEAgLTkwLDcgKzkwLDcgQEANCiBERUZJTkVf
TVVURVgoY2dyb3VwX211dGV4KTsNCiBERUZJTkVfU1BJTkxPQ0soY3NzX3NldF9sb2NrKTsNCiAN
Ci0jaWZkZWYgQ09ORklHX1BST1ZFX1JDVQ0KKyNpZiAoZGVmaW5lZCBDT05GSUdfUFJPVkVfUkNV
IHx8IGRlZmluZWQgQ09ORklHX0xPQ0tERVApDQogRVhQT1JUX1NZTUJPTF9HUEwoY2dyb3VwX211
dGV4KTsNCiBFWFBPUlRfU1lNQk9MX0dQTChjc3Nfc2V0X2xvY2spOw0KICNlbmRpZg0KLS0gDQoy
LjE3LjENCg==

