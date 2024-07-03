Return-Path: <cgroups+bounces-3519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10A8925AA8
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 13:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB041C21995
	for <lists+cgroups@lfdr.de>; Wed,  3 Jul 2024 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A0617B426;
	Wed,  3 Jul 2024 10:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="CY0eaoHw"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7717B40C;
	Wed,  3 Jul 2024 10:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003829; cv=none; b=FVtnY1hy840IlWF1kxpPq2WxBSSWPRVPbsjRKZqzk571pLb36Mw0z7z9IS/xdcfqiQPeouDzPIlJLZv0mM0aKeyuyWC/pm+pc6XPb7kcoWKQNjRY9T9J0BHg4YFwqhcujhLbNAsiigrGvQ2ltO8nMdsEE5BUV9t4fCffxoT33Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003829; c=relaxed/simple;
	bh=/ZMNpSBPb58KxZfQ0JIkpCU0TfJGNJM3mhHBj/gQjy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=IQdKwOzMn9GdxiCu2pdKVQDuuDu6kIIJ2LPgqsovpxV7zM5MObwadrtPqyN8LBH+SF5tubP/tblo5yPHaBYEXWWBub9YExjJLtuCWTfEXyr+EYbCmOaquYLwXGfDYxP8t6apEOR3lYGM6ciD+RvT4EaIR9WEzgivJ5xLVO2gegA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=CY0eaoHw reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=CsWwucUpJYB3LDpO9mwB6hwY51CP/09Pinks4UDzUJs=; b=C
	Y0eaoHw+iA0NQIZx9120np0IKOVjAFFgjOHqn+cLzfz/ImJBQ3/l+oSyhSC9VUZg
	8yeeCEMxeAtg7QyVXEDf6E0i7P7F9/h2cF0OWDc29oJFUaQIhDKr24Pz5B6lLZvc
	hPD2giVzdHVuUF+Ap6YW+HdaqcDkoYDjR8EsUzt7mo=
Received: from xavier_qy$163.com ( [59.82.45.106] ) by
 ajax-webmail-wmsvr-40-122 (Coremail) ; Wed, 3 Jul 2024 18:49:43 +0800 (CST)
Date: Wed, 3 Jul 2024 18:49:43 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, longman@redhat.com
Cc: tj@kernel.org, akpm@linux-foundation.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re:Re: [PATCH-cpuset v10 2/2] cpuset: use Union-Find to optimize
 the merging of cpumasks
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <zkkadtdssdgkndojsvfwbig3xwtqvfleyw3wbg6vewjntmklxe@xle6jq7jvkv5>
References: <ZoRThI4lcZLxBlwc@slm.duckdns.org>
 <20240703063727.258722-1-xavier_qy@163.com>
 <20240703063727.258722-3-xavier_qy@163.com>
 <zkkadtdssdgkndojsvfwbig3xwtqvfleyw3wbg6vewjntmklxe@xle6jq7jvkv5>
X-NTES-SC: AL_Qu2ZAvybvE8j5SedZekfmk4aj+k+XsG0vfUj34FWOp9wjDHp+ik+VG1eLH3Hwe+QGwuFiwWKaTVJ2/RZYo1ndawFvFaZAPIcyVXGI2xBxzJhWQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <2ea89e07.ac63.1907836ec4b.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3v6jHLIVmCfAfAA--.1241W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZRMREGXAmy+0tAAFsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpIaSBNaWNoYWwgYW5kIExvbmdtYW4sCgpQbGVhc2UgY29uZmlybSBteSBleHBsYW5hdGlvbiBh
Ym91dCBjZ3JvdXAgdjIgYmVsb3cuCgoKQXQgMjAyNC0wNy0wMyAxNzo0MDo0OSwgIk1pY2hhbCBL
b3V0bsO9IiA8bWtvdXRueUBzdXNlLmNvbT4gd3JvdGU6Cj5PbiBXZWQsIEp1bCAwMywgMjAyNCBh
dCAwMjozNzoyN1BNIEdNVCwgWGF2aWVyIDx4YXZpZXJfcXlAMTYzLmNvbT4gd3JvdGU6Cj4+IEBA
IC0xMTAyLDMxICsxMTAxLDI1IEBAIHN0YXRpYyBpbnQgZ2VuZXJhdGVfc2NoZWRfZG9tYWlucyhj
cHVtYXNrX3Zhcl90ICoqZG9tYWlucywKPj4gIAlpZiAocm9vdF9sb2FkX2JhbGFuY2UgJiYgKGNz
biA9PSAxKSkKPj4gIAkJZ290byBzaW5nbGVfcm9vdF9kb21haW47Cj4+ICAKPj4gLQlmb3IgKGkg
PSAwOyBpIDwgY3NuOyBpKyspCj4+IC0JCWNzYVtpXS0+cG4gPSBpOwo+PiAtCW5kb21zID0gY3Nu
Owo+PiAtCj4+IC1yZXN0YXJ0Ogo+PiAtCS8qIEZpbmQgdGhlIGJlc3QgcGFydGl0aW9uIChzZXQg
b2Ygc2NoZWQgZG9tYWlucykgKi8KPj4gLQlmb3IgKGkgPSAwOyBpIDwgY3NuOyBpKyspIHsKPj4g
LQkJc3RydWN0IGNwdXNldCAqYSA9IGNzYVtpXTsKPj4gLQkJaW50IGFwbiA9IGEtPnBuOwo+PiAt
Cj4+IC0JCWZvciAoaiA9IDA7IGogPCBjc247IGorKykgewo+PiAtCQkJc3RydWN0IGNwdXNldCAq
YiA9IGNzYVtqXTsKPj4gLQkJCWludCBicG4gPSBiLT5wbjsKPj4gLQo+PiAtCQkJaWYgKGFwbiAh
PSBicG4gJiYgY3B1c2V0c19vdmVybGFwKGEsIGIpKSB7Cj4+IC0JCQkJZm9yIChrID0gMDsgayA8
IGNzbjsgaysrKSB7Cj4+IC0JCQkJCXN0cnVjdCBjcHVzZXQgKmMgPSBjc2Fba107Cj4+ICsJaWYg
KCFjZ3JwdjIpIHsKPgo+SSdtIHN1cnByaXNlZCB0aGF0IG9yaWdpbmFsIGNvZGUgd2Fzbid0IGJy
YW5jaGVkIG9uIHRoaXMgb24geW91IGFkZCBpdAo+aGVyZS4gV2h5IGlzIFVGIHVzZWQgb25seSBm
b3IgdjEgY29kZT8KPgoKSW4gdGhlIFBhdGNoIHY2LCBJIGV4cGxhaW5lZCB0byBMb25nbWFuIHRo
YXQgYmFzZWQgb24gaGlzIG5ldyBwYXRjaCwgdGhlIG92ZXJsYXBwaW5nIGNoZWNrIGFuZAptZXJn
ZSBvcGVyYXRpb25zIGZvciBjcHVzZXRzIGFyZSBza2lwcGVkIGluIHRoZSBjYXNlIG9mIGNncm91
cCB2Mi4gQmVjYXVzZSBmb3IgY2dyb3VwIHYyLApkb21zW2ldIGlzIG1lcmVseSBjb3BpZWQgZnJv
bSBjc2FbaV0gcmF0aGVyIHRoYW4gbWVyZ2VkLgpUaGlzIG5lZWRzIGZ1cnRoZXIgY29uZmlybWF0
aW9uIGZyb20gTG9uZ21hbi4KCglpZiAoY2dycHYyKSB7CgkJZm9yIChpID0gMDsgaSA8IG5kb21z
OyBpKyspIHsKCQkJY3B1bWFza19jb3B5KGRvbXNbaV0sIGNzYVtpXS0+ZWZmZWN0aXZlX2NwdXMp
OwoJCQlpZiAoZGF0dHIpCgkJCQlkYXR0cltpXSA9IFNEX0FUVFJfSU5JVDsKCQl9CgkJZ290byBk
b25lOwoJfQoKCj4+ICsJCWZvciAoaSA9IDA7IGkgPCBjc247IGkrKykKPj4gKwkJCXVmX25vZGVf
aW5pdCgmY3NhW2ldLT5ub2RlKTsKPj4gIAo+PiAtCQkJCQlpZiAoYy0+cG4gPT0gYnBuKQo+PiAt
CQkJCQkJYy0+cG4gPSBhcG47Cj4+IC0JCQkJfQo+PiAtCQkJCW5kb21zLS07CS8qIG9uZSBsZXNz
IGVsZW1lbnQgKi8KPj4gLQkJCQlnb3RvIHJlc3RhcnQ7Cj4+ICsJCS8qIE1lcmdlIG92ZXJsYXBw
aW5nIGNwdXNldHMgKi8KPj4gKwkJZm9yIChpID0gMDsgaSA8IGNzbjsgaSsrKSB7Cj4+ICsJCQlm
b3IgKGogPSBpICsgMTsgaiA8IGNzbjsgaisrKSB7Cj4+ICsJCQkJaWYgKGNwdXNldHNfb3Zlcmxh
cChjc2FbaV0sIGNzYVtqXSkpCj4+ICsJCQkJCXVmX3VuaW9uKCZjc2FbaV0tPm5vZGUsICZjc2Fb
al0tPm5vZGUpOwo+PiAgCQkJfQo+PiAgCQl9Cj4+ICsKPj4gKwkJLyogQ291bnQgdGhlIHRvdGFs
IG51bWJlciBvZiBkb21haW5zICovCj4+ICsJCWZvciAoaSA9IDA7IGkgPCBjc247IGkrKykgewo+
PiArCQkJaWYgKGNzYVtpXS0+bm9kZS5wYXJlbnQgPT0gJmNzYVtpXS0+bm9kZSkKPj4gKwkJCQlu
ZG9tcysrOwo+Cj5UaGUgbmFrZWQgcGFyZW50IGFjY2VzcyBkb2Vzbid0IGhpZGUgdGhlIFVGIGFi
c3RyYWN0aW9uIHdlbGwuCj5JJ2QgY29uc2lkZXIgdWZfZmluZCgmY3NhW2ldLT5ub2RlKSA9PSAm
Y3NhW2ldLT5ub2RlIG9yIGEgc3BlY2lmaWMKPmhlbHBlciBsaWtlIHVmX2lzX3JlcHJlc2VudGFu
dCgmY3NhW2ldLT5ub2RlKS4KClRoaXMgY2FuIGJlIG9wdGltaXplZCBoZXJlLiBJIHdpbGwgY2hh
bmdlIGl0IHRvIHRoZSBmaXJzdCBtZXRob2QgeW91IG1lbnRpb25lZCBpbiB0aGUgbmV4dCBwYXRj
aC4KCkJlc3QgUmVnYXJkcywKWGF2aWVyCgo=

