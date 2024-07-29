Return-Path: <cgroups+bounces-3927-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2047D93EB85
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2024 04:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D41C216E7
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2024 02:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774587F48A;
	Mon, 29 Jul 2024 02:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="aeIDMdDG"
X-Original-To: cgroups@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4AB1E49E;
	Mon, 29 Jul 2024 02:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722221103; cv=none; b=oqfLJedW+Ts9IKff0mTXOYKh+N0Ra00+nGOHUroMndheSLDpZ1hiaGIVNh0rwMnwsasYPvM3OgLFGKZk/kByT9sBSdiPMOUcuz61wPsntIrRFquSJKsUcG+zw8WRvY8iIjusOnqIuB6dtz3DyhKEmTdLUWfP2B1VerBLlcadYSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722221103; c=relaxed/simple;
	bh=/3T3nVZnNNLASnDz6+rykGbtHRDtkaHp0CYR19w3tzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=I62Zi0ZzNnSvrfSdeCwBlUdfT9GT8bxJTY6xNLI1j5UT2J4hxnICoh45VM/cZuVLHwNMqIn6fl9gvjwT2OTudhNTaSEk64jNc3wX71Fxv0tKrnl2mdVZqetby4kC6HJ8GEuzjEZDs14IC7kKKsFMp1uyDJh6hOxy0QiWXL7oKMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=aeIDMdDG reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=gRgYzzpxI7K2DOYkmRJXnELCFTcBfJpMncVVeIaMHxQ=; b=a
	eIDMdDG2y9kM20BuLdVns9ymTKesx4xSsropFA6QZJ/OXOqBZ9uMmxBXrxE+l6wy
	/AJ9dn3xOi0uUbRrKSy/9Cg9UyuA7pHB00FkWpmNnDVMtWpbi/G/0D98HbcxZz+Y
	O1UR93w06BLAhMmpWYKMKfNZpaXrUR4wGaIx+ocWAM=
Received: from xavier_qy$163.com ( [59.82.45.102] ) by
 ajax-webmail-wmsvr-40-128 (Coremail) ; Mon, 29 Jul 2024 10:44:08 +0800
 (CST)
Date: Mon, 29 Jul 2024 10:44:08 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: "Tejun Heo" <tj@kernel.org>, "Waiman Long" <longman@redhat.com>
Cc: akpm@linux-foundation.org, lizefan.x@bytedance.com, hannes@cmpxchg.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, mkoutny@suse.com
Subject: Re:Re: [PATCH-cpuset v11 0/2] Add Union-Find and use it to optimize
 cpuset
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <ZowyKf3RlMI0q1P-@slm.duckdns.org>
References: <f9e55eb8-82a8-45f2-a949-1db182e95fc8@redhat.com>
 <20240704062444.262211-1-xavier_qy@163.com>
 <e20fe0dc-a3ef-4f55-a991-6efe1a9ddecd@redhat.com>
 <ZowyKf3RlMI0q1P-@slm.duckdns.org>
X-CM-CTRLMSGS: JVIT3nBsdXM9MTcyMjIyMTA0OTYwNV9lY2NlYzNiNGQzNWY4MmJlOWZiMDU2N
 2IzNzYzMmUzNw==
X-NTES-SC: AL_Qu2ZAP6Zvkgv7iKdbOkfmk4aj+k+XsG0vfUj34FWOp9wjA7p2y4sYHZ6EX/kyPyJMA2WuyGudB5tyP9mYbJecaUtoyGtxbu3R9B6iAKhZuRM2w==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5c90d42c.2c03.190fc5fb1c8.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f5b4AadmnCJlAA--.48941W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiwgQrEGWXv4LGOQAHsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIFRlanVuLAoKSSBzYXcgb24ga2VybmVsLm9yZyB0aGF0IHY2LjExLXJjMSBoYXMgYmVlbiBy
ZWxlYXNlZC4gSXQgbWlnaHQgYmUgdGltZSB0byBzdGFydCBtZXJnaW5nCnRoaXMgcGF0Y2guIAoK
QnkgdGhlIHdheSwgIEkgaGF2ZSBzdWJtaXR0ZWQgYW4gb3B0aW1pemF0aW9uIHBhdGNoIGZvciBS
VCBncm91cCBzY2hlZHVsaW5nLCBidXQgYWZ0ZXIKdHdvIHJvdW5kcyBvZiBjb21tdW5pY2F0aW9u
LCBJIGhhdmVuJ3QgcmVjZWl2ZWQgYW55IGZ1cnRoZXIgcmVzcG9uc2VzLiBDb3VsZCB5b3UKcHJv
dmlkZSBtZSB3aXRoIHNvbWUgYWR2aWNlPwoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIw
MjQwNjI3MTcyMTU2LjIzNTQyMS0xLXhhdmllcl9xeUAxNjMuY29tLwoKVGhhbmtzLgoKCkF0IDIw
MjQtMDctMDkgMDI6Mzg6MzMsICJUZWp1biBIZW8iIDx0akBrZXJuZWwub3JnPiB3cm90ZToKPk9u
IFN1biwgSnVsIDA3LCAyMDI0IGF0IDA5OjU5OjU1UE0gLTA0MDAsIFdhaW1hbiBMb25nIHdyb3Rl
Ogo+PiBUaGUgcGF0Y2ggc2VyaWVzIGxvb2tzIGdvb2QgdG8gbWUuIEhvd2V2ZXIsIGl0IGlzIGEg
c3RpbGwgbWFqb3IgY2hhbmdlIGluCj4+IHRoZSBkb21haW4gZ2VuZXJhdGlvbiBhbGdvcml0aG0g
YW5kIGl0IGlzIHRvbyBsYXRlIGZvciB2Ni4xMS4gSSB3b3VsZCBhbHNvCj4+IGxpa2UgaXQgdG8g
c3BlbmQgbW9yZSB0aW1lIGluIGxpbnV4LW5leHQgYXMgSSBkb24ndCBoYXZlIGEgZ29vZCBzZXQg
b2YKPj4gY2dyb3VwIHYxIHRlc3QuIEkgd2lsbCBzdXBwb3J0IG1lcmdpbmcgdGhpcyBmb3IgdjYu
MTIuCj4+IAo+PiBBY2tlZC1ieTogV2FpbWFuIExvbmcgPGxvbmdtYW5AcmVkaGF0LmNvbT4KPgo+
WGF2aWVyLCBhcyB3ZSdyZSBwcmV0dHkgY2xvc2UgdG8gdGhlIG1lcmdlIHdpbmRvdywgSSB0aGlu
ayBpdCdkIGJlIGJlc3QgdG8KPmRvIHRoaXMgaW4gdGhlIG5leHQgbWVyZ2Ugd2luZG93IGFzIFdh
aW1hbiBzYWlkLiBDYW4geW91IHBsZWFzZSBwaW5nIG1lIG9uY2UKPnY2LjExLXJjMSBpcyBjdXQ/
IEknbGwgYXBwbHkgdGhlIHR3byBwYXRjaGVzIG9uIGNncm91cC9mb3ItNi4xMi4KPgoKCgotLQpC
ZXN0IFJlZ2FyZHMsClhhdmllcgo=

