Return-Path: <cgroups+bounces-3102-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33648FC1DA
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 04:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8A428782F
	for <lists+cgroups@lfdr.de>; Wed,  5 Jun 2024 02:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB84EB55;
	Wed,  5 Jun 2024 02:32:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail115-100.sinamail.sina.com.cn (mail115-100.sinamail.sina.com.cn [218.30.115.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935241A28C
	for <cgroups@vger.kernel.org>; Wed,  5 Jun 2024 02:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717554755; cv=none; b=IsWYJDGpk3nMD+ChyeTmUrjYEfcirqxuxV4OMBJDmhZvpDwkrNhCvutrgFoTmVcp2tclR1fCv5FtX/7jEYveiuOnbENvNln2HeUVwL4vsVezcXw+ogpbDLjrSM06I1S2isW0PuCydKv+ujajZ3/Tz4hFeHny3b6v1Y5ZQiQwUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717554755; c=relaxed/simple;
	bh=c+2oWUwgKmMxy9vJPIMcaAT5KjS3qKAGALV1ECdGJ6E=;
	h=Date:From:To:Cc:Subject:Mime-Version:Message-ID:Content-Type:
	 Content-Disposition; b=PpkmFxtasrnPnwfJrcw9TV4YKPAdVqg7xOwFmD6BoSdHirOaZR+CscVRJ+k1hWueZmvmsaSFiFflYyxWQkyfMEtdSUbCS9gyhZ12mEwLDBoXF3J2C63G+vv88bAPSUOci+oFYEXzAQisQtiZI3Yv8L9w8lHaY+roRMh0dElP0lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: webmail.sinamail.sina.com.cn
Received: from webmail-23-146.pop3.fmail.yf.sinanode.com (HELO webmail.sinamail.sina.com.cn)([10.2.23.146])
	by sina.com (172.16.235.24) with SMTP
	id 665FCE3500006D9B; Wed, 5 Jun 2024 10:32:21 +0800 (CST)
X-Sender: ghostxavier@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=ghostxavier@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=ghostxavier@sina.com
X-SMAIL-MID: 58651245089622
Received: by webmail.sinamail.sina.com.cn (Postfix, from userid 993)
	id 82C222AEA; Wed,  5 Jun 2024 10:32:21 +0800 (CST)
Date: Wed, 05 Jun 2024 10:32:21 +0800
Received: from ghostxavier@sina.com ([59.82.45.118]) by m1.mail.sina.com.cn via HTTP;
 Wed, 05 Jun 2024 10:32:21 +0800
From: ghostxavier@sina.com
Reply-To: ghostxavier@sina.com
To: "Waiman Long" <longman@redhat.com>
Cc: "lizefan.x" <lizefan.x@bytedance.com>, "tj" <tj@kernel.org>,
 "hannes" <hannes@cmpxchg.org>, "cgroups" <cgroups@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cpuset: use Union-Find to optimize the merging of cpumasks
X-Priority: 3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <665fce357d3050.07594014.09810475@m1.mail.sina.com.cn>
X-MessageID: 08dd085708a2d07ac4a03e8c869c7964_202406
X-SMAIL-UIID: 38698129900DD987383F1AD1E832DD4F-20240605-103221-2
X-Mailer: Sina WebMail 4.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGkgTG9uZ21hbiwNCg0KSSBhbSByZWFkeSB0byBwcmVwYXJlIGFuZCBzZW5kIGEgdjQgcGF0Y2gg
YmFzZWQgb24gdGhlIG5ldyBjcHVzZXQgY29kZWJhc2UuIFRoYW5rcyBmb3IgeW91ciBndWlkYW5j
ZSBhbmQgc3VwcG9ydC4NCg0KQmVzdCByZWdhcmRzLA0KWGF2aWVyDQoNCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KDQpPbiA2LzMvMjQgMDg6MzEsIFhhdmllciB3cm90ZToNCj4g
VGhlIHByb2Nlc3Mgb2YgY29uc3RydWN0aW5nIHNjaGVkdWxpbmcgZG9tYWlucyBpbnZvbHZlcyBt
dWx0aXBsZSBsb29wcw0KPiBhbmQgcmVwZWF0ZWQgZXZhbHVhdGlvbnMsIGxlYWRpbmcgdG8gbnVt
ZXJvdXMgcmVkdW5kYW50IGFuZCBpbmVmZmVjdGl2ZQ0KPiBhc3Nlc3NtZW50cyB0aGF0IGltcGFj
dCBjb2RlIGVmZmljaWVuY3kuDQo+DQo+IEhlcmUsIHdlIHVzZSBVbmlvbi1GaW5kIHRvIG9wdGlt
aXplIHRoZSBtZXJnaW5nIG9mIGNwdW1hc2tzLiBCeSBlbXBsb3lpbmcNCj4gcGF0aCBjb21wcmVz
c2lvbiBhbmQgdW5pb24gYnkgcmFuaywgd2UgZWZmZWN0aXZlbHkgcmVkdWNlIHRoZSBudW1iZXIg
b2YNCj4gbG9va3VwcyBhbmQgbWVyZ2UgY29tcGFyaXNvbnMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6
IFhhdmllciA8Z2hvc3R4YXZpZXJAc2luYS5jb20+DQo+DQo+IEhpIExvbmdtYW4sDQo+DQo+IFRo
YW5rIHlvdSBmb3IgeW91ciBmZWVkYmFjayBvbiB0aGUgcHJldmlvdXMgdmVyc2lvbiBvZiB0aGUg
cGF0Y2guDQo+DQo+IE5vdyBJIHdpbGwgcmVzcG9uZCB0byB0aGUgdGhyZWUgcXVlc3Rpb25zIHlv
dSByYWlzZWQ6DQo+IDEpIFRoZSBmdW5jdGlvbiBjb21tZW50IGRlc2NyaWJlcyB0aGUgYWxnb3Jp
dGhtIHRvIGZpbmQgdGhlIHNldCBvZg0KPiBkb21haW5zLiBJZiB5b3UgY2hhbmdlIHRoZSBhbGdv
cml0aG0sIHlvdSBoYXZlIHRvIHVwZGF0ZSB0aGUgY29tbWVudCBhcw0KPiB3ZWxsLg0KPg0KPiBS
ZXBseTogU29ycnkgZm9yIG5vdCBwYXlpbmcgYXR0ZW50aW9uIHRvIHRoZSBjb21tZW50cyBiZWZv
cmUuIFRoZSBuZXcgcGF0Y2ggKHYzKSBoYXMgdXBkYXRlZCB0aGUgY29tbWVudCBjb250ZW50Lg0K
Pg0KPiAyKSBnZW5lcmF0ZV9zY2hlZF9kb21haW5zKCkgaXMgbm90IGluIGEgcGVyZm9ybWFuY2Ug
Y3JpdGljYWwgcGF0aCwgc28NCj4gaXRzIHBlcmZvcm1hbmNlIGlzIG5vdCBhcyBpbXBvcnRhbnQu
IEFsc28gdGhlIGNzbiBhcnJheSBpcyB0eXBpY2FsbHkgbm90DQo+IHRoYXQgYmlnLiBDaGFuZ2lu
ZyB0aGUgYWxnb3JpdGhtIG1heSBpbnRyb2R1Y2UgbmV3IGJ1Z3Mgd2hpY2ggbGVhZHMgdG8NCj4g
dGhlIG5leHQgcG9pbnQuDQo+DQo+IFJlcGx5OiBJbmRlZWQsIHRoaXMgZnVuY3Rpb24gaXMgbm90
IGEgY3JpdGljYWwgcGF0aCBpbXBhY3RpbmcgcGVyZm9ybWFuY2UsIGJ1dCBpdCdzIGFsd2F5cyBn
b29kIHRvIG9wdGltaXplIGVmZmljaWVuY3kuIFRoZSBvcHRpbWl6YXRpb24gaXMgbGltaXRlZCB0
byB0aGUgaW50ZXJuYWxzIG9mIHRoaXMgZnVuY3Rpb24gYW5kIGRvZXMgbm90IGFmZmVjdCBvdGhl
ciBtb2R1bGVzLCBzbyBmaXhpbmcgdGhlIGludGVybmFsIGJ1ZyBzaG91bGQgaGF2ZSBtYW5hZ2Vh
YmxlIHJpc2tzLg0KSW4gdGVybSBvZiBlZmZpY2llbmN5LCB5b3VyIHBhdGNoIGRvZXMgZWxpbWlu
YXRlIHRoZSB0aGlyZCBpdGVyYXRpb24gKGspIA0KaW4gdGhlIGNzbiBpdGVyYXRpb24gbG9vcC4g
SG93ZXZlciB0aGUgbmV3IHVuaW9uX3NldHMoKSBmdW5jdGlvbiBtYXkgZ28gDQp1cCB0aGUgbm9k
ZSBoaWVyYXJjaHkgd2hpY2ggY2FuIGNvbnNpZGVyZWQgYSB0aGlyZCBpdGVyYXRpb24gaW4gc29t
ZSANCndheS4gU28gdGhlcmUgaXMgc29tZSBzYXZpbmcsIGJ1dCBub3QgYXMgc2lnbmlmaWNhbnQg
YXMgaXQgbG9va3MuIEl0IA0KZG9lcyBzaW1wbGlmeSB0aGUgY29kZSBhbmQgbWFrZSBpdCBhIGJp
dCBlYXNpZXIgdG8gcmVhZC4NCj4NCj4gMykgSG93IGRvIHlvdSB0ZXN0IHlvdXIgY29kZSB0byBl
bnN1cmUgaXRzIGNvcnJlY3RuZXNzPw0KPiBJIGFwcGxpZWQgeW91ciBwYXRjaCBhbmQgcnVuIHRo
ZSAuL3Rlc3RfY3B1c2V0X3Bycy5zaCBnb3QgdGhlIGZvbGxvd2luZy4uLg0KPg0KPiBSZXBseTog
SSdtIHZlcnkgc29ycnksIHRoaXMgaXMgbXkgZmlyc3QgdGltZSBzdWJtaXR0aW5nIGEga2VybmVs
IHBhdGNoIGFuZCBJIGRvbid0IGtub3cgd2hpY2ggdGVzdCBjYXNlcyBuZWVkIHRvIGJlIHJ1bi4g
SSBqdXN0IGNvbnN0cnVjdGVkIHNvbWUgc2NlbmFyaW9zIGxvY2FsbHkgdG8gdGVzdCwgc28gdGhl
IHRlc3Rpbmcgc2NvcGUgaXMgbGltaXRlZC4gVGhhbmsgeW91IGZvciBwcm92aWRpbmcgdGhlIHRl
c3QgY2FzZXMuIEkgaGF2ZSByZXByb2R1Y2VkIGFuZCByZXNvbHZlZCB0aGUgaXNzdWUsIGFuZCBo
YXZlIHBhc3NlZCBzZXZlcmFsIG90aGVyIHRlc3QgY2FzZXMgaW4gQ0dyb3VwLiBCdXQgY3VycmVu
dGx5LCBJIG9ubHkgaGF2ZSBRRU1VIHNpbXVsYXRpb24gZW52aXJvbm1lbnQsIHNvIG15IHRlc3Rp
bmcgYWJpbGl0eSBpcyBsaW1pdGVkLiBJIGhvcGUgeW91IGNhbiBoZWxwIG1lIHdpdGggc29tZSBj
b21wcmVoZW5zaXZlIHRlc3Rpbmcgb2YgbXkgbmV3IHZlcnNpb24gcGF0Y2guIFRoYW5rIHlvdSB2
ZXJ5IG11Y2guDQo+DQo+IEkgaG9wZSB5b3UgY2FuIHBheSBmdXJ0aGVyIGF0dGVudGlvbiB0byB0
aGUgbmV3IHBhdGNoLg0KQWxzbyB5b3VyIHBhdGNoIGVsaW1pbmF0ZXMgYWxsIHRoZSB1c2Ugb2Yg
dGhlIGNwdXNldC0+cG4gdmFyaWFibGUuIFNvIA0KeW91IGNhYiByZW1vdmUgaXQgYXMgaXQgaXMg
bm8gbG9uZ2VyIG5lZWRlZC4NCkFmdGVyIGEgaGFyZGVyIGxvb2sgYXQgdGhlIGdlbmVyYXRlX3Nj
aGVkX2RvbWFpbnMoKSBjb2RlLCBJIGhhdmUgZm91bmQgYSANCmJ1ZyBpbiB0aGUgY29kZSB3aXRo
IHJlc3BlY3QgdG8gdGhlIHN1cHBvcnQgb2YgcmVtb3RlIHBhcnRpdGlvbi4gSSB3aWxsIA0Kc2Vu
ZCBhbm90aGVyIHBhdGNoIHRvIGZpeCBpdC4gSSBhbHNvIHJlYWxpemUgdGhhdCB0aGUgZnVuY3Rp
b24gd2FzIA0Kb3JpZ2luYWxseSBkZXNpZ25lZCB0byBzdXBwb3J0IHYxIGNwdXNldC4gdjIgY3B1
c2V0IGlzIHF1aXRlIGRpZmZlcmVudCANCmFuZCB0aGUgY29kZSBjYW4gYmUgc2ltcGxpZmllZCBm
b3IgdGhlIHYyIHVzZSBjYXNlLg0KWW91IGFyZSB3ZWxjb21lIHRvIHNlbmQgYSB2NCBwYXRjaCBv
biB0b3Agb2YgdGhlIG5ldyBjcHVzZXQgY29kZSBiYXNlLg0KVGhhbmtzLA0KTG9uZ21hbg==


