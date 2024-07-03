Return-Path: <cgroups+bounces-3520-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1387A925DCA
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 13:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B177E1F22F98
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 11:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFE19415A;
	Wed,  3 Jul 2024 11:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="jLwO2iOA"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1975B175549;
	Wed,  3 Jul 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720005807; cv=none; b=mWHr+i2yC3GFLP6amhcVm8eeC8hULu1gumU/VWz7OoLBUaxbsLvCim0wITnPIbx8FLhLzCxIitVJYPDTsyN+P9wWnF3DIdldiklVkKbwuc4VjbLvBrhQVwdd+zv2jvDYSUiPNnp4iLq6TT8G84Lm0iLxtE3TZSH1BSg3GCQ4iK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720005807; c=relaxed/simple;
	bh=nQiTDZ7nqA0Uw9Lrn3vTdguwK9Iz6Yt7yURRRhUQRzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=N/BBIUc1c6yoZ5HwtfNK0caJgcFrgIGJz7eHq0m2SHriWKF9SXWC85Gmq07xpEg76jbuEe38eepGqWE8Gak/i7e7AdSeriKyuvrT4lDWGdFApcxOP69QRDGRiVzchIxHwuzV/jq4w3Ki+AfzZdrrvNFpZ+49Oam735AjIR119Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=jLwO2iOA reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=V7t00RqL96BHgAhWVmpE7JBjLbm+xuBNNxvx6wIpm9k=; b=j
	LwO2iOAgrdnX6bQrFNFxmF8Mmc6ZMk3bd1njrkmMgRv4/ad2XeOGgZHAkxCtsNHC
	4ju23q+O63Ja1p/vHiZIyJn88ta60dtpTw/khw0mMbdzlHuaUnLqRuUOGB6DUGv1
	tYufJPFg6v87kjnQOwk2BLR1kL4cCx7N/chhhVN/ZY=
Received: from xavier_qy$163.com ( [59.82.45.106] ) by
 ajax-webmail-wmsvr-40-122 (Coremail) ; Wed, 3 Jul 2024 19:20:09 +0800 (CST)
Date: Wed, 3 Jul 2024 19:20:09 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, longman@redhat.com, akpm@linux-foundation.org, 
	lizefan.x@bytedance.com, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re:Re: [PATCH-cpuset v10 1/2] Union-Find: add a new module in
 kernel library
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <haimyc4y2trcyvbnkpw2gkfoiaunykb2q2d5ybr6qgt6upf3lm@afhcevtyjcjl>
References: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
 <20240703063727.258722-1-xavier_qy@163.com>
 <20240703063727.258722-2-xavier_qy@163.com>
 <haimyc4y2trcyvbnkpw2gkfoiaunykb2q2d5ybr6qgt6upf3lm@afhcevtyjcjl>
X-NTES-SC: AL_Qu2ZAvybuk4r7ySZY+kfmk4aj+k+XsG0vfUj34FWOp9wjDHp+ik+VG1eLH3Hwe+QGwuFiwWKaTVJ2/RZYo1ndawFieXNfysjlVPU3yb2fJop3A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <13bf9422.aeb4.1907852c7ce.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f4vpM4VmdvsfAA--.2509W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZRMREGXAmy+0tAAJsv
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGkgTWljaGFsLAoKQXQgMjAyNC0wNy0wMyAxNzo0MDoyNSwgIk1pY2hhbCBLb3V0bsO9IiA8bWtv
dXRueUBzdXNlLmNvbT4gd3JvdGU6Cj5PbiBXZWQsIEp1bCAwMywgMjAyNCBhdCAwMjozNzoyNlBN
IEdNVCwgWGF2aWVyIDx4YXZpZXJfcXlAMTYzLmNvbT4gd3JvdGU6Cj4+IFRoaXMgcGF0Y2ggaW1w
bGVtZW50cyBhIHVuaW9uLWZpbmQgZGF0YSBzdHJ1Y3R1cmUgaW4gdGhlIGtlcm5lbCBsaWJyYXJ5
LAo+PiB3aGljaCBpbmNsdWRlcyBvcGVyYXRpb25zIGZvciBhbGxvY2F0aW5nIG5vZGVzLCBmcmVl
aW5nIG5vZGVzLAo+PiBmaW5kaW5nIHRoZSByb290IG9mIGEgbm9kZSwgYW5kIG1lcmdpbmcgdHdv
IG5vZGVzLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogWGF2aWVyIDx4YXZpZXJfcXlAMTYzLmNvbT4K
Pj4gLS0tCj4+ICBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL3VuaW9uX2ZpbmQucnN0ICAgICAgICAg
fCAxMDIgKysrKysrKysrKysrKysrKysrCj4+ICAuLi4vemhfQ04vY29yZS1hcGkvdW5pb25fZmlu
ZC5yc3QgICAgICAgICAgICAgfCAgODcgKysrKysrKysrKysrKysrCj4+ICBNQUlOVEFJTkVSUyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDkgKysKPj4gIGluY2x1ZGUvbGlu
dXgvdW5pb25fZmluZC5oICAgICAgICAgICAgICAgICAgICB8ICA0MSArKysrKysrCj4+ICBsaWIv
TWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPj4gIGxp
Yi91bmlvbl9maW5kLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0OCArKysrKysr
KysKPj4gIDYgZmlsZXMgY2hhbmdlZCwgMjg4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkK
Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2NvcmUtYXBpL3VuaW9uX2ZpbmQu
cnN0Cj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vY29yZS1hcGkvdW5pb25fZmluZC5yc3QKPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRl
L2xpbnV4L3VuaW9uX2ZpbmQuaAo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGxpYi91bmlvbl9maW5k
LmMKPj4gCj4KPk5pY2UuCj5JJ2Qgc28gcy9Vbmlvbi1GaW5kL3VuaW9uLWZpbmQvIGJvdGggaW4g
dGhlIGRvY3MgYW5kIHRoZSBjb2RlCj4oY29tbWVudHMpLCBJIGRpZG4ndCBmaW5kIGFueSBydWxl
IHdoeSB0d28gY2FwaXRhbGl6YXRpb25zIGFyZSB1c2VkLgoKVW5pb24tRmluZCBvbmx5IGFwcGVh
cnMgaW4gdGhlIHBhdGNoIGRlc2NyaXB0aW9uIG9yIHRpdGxlOyBpbiB0aGUgbWFpbiB0ZXh0LCB3
ZSBjb25zaXN0ZW50bHkKdXNlIHVuaW9uLWZpbmQuIFRoaXMgd2lsbCBiZSBjb3JyZWN0ZWQgaW4g
dGhlIG5leHQgdmVyc2lvbi4KCj4+ICtzdHJ1Y3QgdWZfbm9kZSB7Cj4+ICsJc3RydWN0IHVmX25v
ZGUgKnBhcmVudDsKPj4gKwl1bnNpZ25lZCBpbnQgcmFuazsKPj4gK307Cj4+ICsKPj4gKy8qIFRo
aXMgbWFjcm8gaXMgdXNlZCBmb3Igc3RhdGljIGluaXRpYWxpemF0aW9uIG9mIGEgdW5pb24tZmlu
ZCBub2RlLiAqLwo+PiArI2RlZmluZSBVRl9JTklUX05PREUobm9kZSkJey5wYXJlbnQgPSAmbm9k
ZSwgLnJhbmsgPSAwfQo+PiArCj4+ICsvKioKPj4gKyAqIHVmX25vZGVfaW5pdCAtIEluaXRpYWxp
emUgYSB1bmlvbi1maW5kIG5vZGUKPj4gKyAqIEBub2RlOiBwb2ludGVyIHRvIHRoZSB1bmlvbi1m
aW5kIG5vZGUgdG8gYmUgaW5pdGlhbGl6ZWQKPj4gKyAqCj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHNl
dHMgdGhlIHBhcmVudCBvZiB0aGUgbm9kZSB0byBpdHNlbGYgYW5kCj4+ICsgKiBpbml0aWFsaXpl
cyBpdHMgcmFuayB0byAwLgo+PiArICovCj4+ICtzdGF0aWMgaW5saW5lIHZvaWQgdWZfbm9kZV9p
bml0KHN0cnVjdCB1Zl9ub2RlICpub2RlKQo+PiArewo+PiArCW5vZGUtPnBhcmVudCA9IG5vZGU7
Cj4+ICsJbm9kZS0+cmFuayA9IDA7Cj4+ICt9Cj4KPlhhdmllciwgbm90IHN1cmUgaWYgeW91IHJl
c3BvbmRlZCB0byBteSBzdWdnZXN0aW9uIG9mIGNvbnNpZGVyZWQgemVyb2VkCj5vYmplY3QgYSB2
YWxpZCBpbml0aWFsaXplZCBvbmUuIFRoYXQgY291bGQgc2F2ZSBzb21lIGluaXQgd29yayAoYW5k
Cj5tb3ZlIGl0IHRvIGFsdGVybmF0aXZlIHVmX2ZpbmQsIHNlZSBiZWxvdykuCj4KPldpdGggdWZf
ZmluZCBib2R5IGNoZWNraW5nIGZvciBOVUxMOgo+Cj4Jd2hpbGUgKG5vZGUtPnBhcmVudCAhPSBu
b2RlKSB7Cj4JCXBhcmVudCA9IG5vZGUtPnBhcmVudDsKPgkJbm9kZS0+cGFyZW50ID0gcGFyZW50
ID8gcGFyZW50LT5wYXJlbnQgOiBub2RlOwo+CQlub2RlID0gbm9kZS0+cGFyZW50Owo+CX0KClll
cywgSSBub3RpY2VkIHlvdXIgc3VnZ2VzdGlvbi4gSW4gcGF0Y2ggdjQsIEkgaW1wbGVtZW50ZWQg
aXQgYnkgaW5pdGlhbGl6aW5nIHRvIDAKYW5kIGFkZGluZyBhIGNoZWNrIGZvciB3aGV0aGVyIHRo
ZSBwYXJlbnQgaXMgMCBpbiB1Zl9maW5kLiBIb3dldmVyLCBsYXRlciwKd2hlbiBJIHdhcyByZXZp
ZXdpbmcgdGhlIGFsZ29yaXRobSdzIGRvY3VtZW50YXRpb24sIEkgbm90aWNlZCBpdCByZXF1aXJl
cwppbml0aWFsaXphdGlvbiB0byBpdHNlbGYuIE1vcmVvdmVyLCB1Zl9maW5kIGlzIGEgaGlnaC1m
cmVxdWVuY3kgb3BlcmF0aW9uLCBpZiB3ZQphZGQgYSBwYXJlbnQgY2hlY2sgd2l0aGluIGl0LCB0
aGUgZWZmaWNpZW5jeSBpbXBhY3QgZWFjaCB0aW1lIHdvdWxkIGJlIG1vcmUKc2lnbmlmaWNhbnQg
dGhhbiBpbml0aWFsaXppbmcgb25jZS4gVGhlcmVmb3JlLCBJIGFkaGVyZWQgdG8gdGhlIGluaXRp
YWxpemF0aW9uCnRvIGl0c2VsZiBhcHByb2FjaC4KCj4+ICsvKioKPj4gKyAqIHVmX3VuaW9uIC0g
TWVyZ2UgdHdvIHNldHMsIHVzaW5nIHVuaW9uIGJ5IHJhbmsKPj4gKyAqIEBub2RlMTogdGhlIGZp
cnN0IG5vZGUKPj4gKyAqIEBub2RlMjogdGhlIHNlY29uZCBub2RlCj4+ICsgKgo+PiArICogVGhp
cyBmdW5jdGlvbiBtZXJnZXMgdGhlIHNldHMgY29udGFpbmluZyBub2RlMSBhbmQgbm9kZTIsIGJ5
IGNvbXBhcmluZwo+PiArICogdGhlIHJhbmtzIHRvIGtlZXAgdGhlIHRyZWUgYmFsYW5jZWQuCj4+
ICsgKi8KPj4gK3ZvaWQgdWZfdW5pb24oc3RydWN0IHVmX25vZGUgKm5vZGUxLCBzdHJ1Y3QgdWZf
bm9kZSAqbm9kZTIpCj4+ICt7Cj4+ICsJc3RydWN0IHVmX25vZGUgKnJvb3QxID0gdWZfZmluZChu
b2RlMSk7Cj4+ICsJc3RydWN0IHVmX25vZGUgKnJvb3QyID0gdWZfZmluZChub2RlMik7Cj4+ICsK
Pj4gKwlpZiAocm9vdDEgIT0gcm9vdDIpIHsKPgo+aWYgKHJvb3QxID09IHJvb3QyKQo+CXJldHVy
bjsKPnRoZW4gdGhlIHJlc3QgY2FuIGJlIG9uZSBsZXZlbCBsZXNzIG5lc3RlZCA7LSkKPgpPZiBj
b3Vyc2UsIHRoaXMgY2hhbmdlIG1ha2VzIGl0IGxvb2sgY2xlYXJlci4KCi0tCkJlc3QgUmVnYXJk
cywKWGF2aWVyCg==

