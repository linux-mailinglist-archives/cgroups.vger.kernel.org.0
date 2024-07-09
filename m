Return-Path: <cgroups+bounces-3576-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B927992AE65
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 05:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2AB71C21DDA
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 03:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C63C466;
	Tue,  9 Jul 2024 03:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="ErKt8srj"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7353987D;
	Tue,  9 Jul 2024 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494118; cv=none; b=cWaa4k7MFbiNniMvXeISUQJ+yDh804qWQ4bKZCoM0EGtJaO6JOUs5D2iRcwW/UgocLjeprhOdgfPzGSsgq7iC3IY19wk6K+X8WoQmV2KzsCx4pPzNsTvarvaNIpe2nlkjVpJMqDh0e6BfWSnvzMA/TiAhyu+N5EzYiM08QsafwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494118; c=relaxed/simple;
	bh=BIu4ksIVe0DfTolYsbsEhIOOu8Kp7I9DOlYDtY6IkaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=lY2+Cdaln1xa4Hx6hyPLgpJgg89FqhReyl+YrchIIDjTMLLU2OwpCpPy3Ry4ygoUojzl/vwfMXkecjlFSkB7/jAKlYhE3gTjfSyLW/oWmtypvDQaja877+CV30CCBO63jwmKVwTHNaRu9WIG2EXUseTiun8IqJfzzLPMDfg2Hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=ErKt8srj reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=Q9XiKPZ9Kok9iJw0OVvF+KMDYu4F6qex4TEFkUsl7ZU=; b=E
	rKt8srjdwb2lWlcglEIwtEGOzgyM1YRGxQ1Q7B2URbfgEnqJghSNLYzDtX+dxGN/
	T1jpfjJuXzU3LshfOF+4NsT/CsHjf2m0ppATFTPIfCwsh3i80PYAsGQR5XbYEzDY
	9F02xknAzzyFwwIQjOM6oqHiqnTehHIKRy2oXaoiNE=
Received: from xavier_qy$163.com ( [59.82.45.121] ) by
 ajax-webmail-wmsvr-40-144 (Coremail) ; Tue, 9 Jul 2024 10:45:42 +0800 (CST)
Date: Tue, 9 Jul 2024 10:45:42 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: "Tejun Heo" <tj@kernel.org>
Cc: "Waiman Long" <longman@redhat.com>, mkoutny@suse.com, 
	akpm@linux-foundation.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
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
X-NTES-SC: AL_Qu2ZAviSvEkv5CidYekfmk4aj+k+XsG0vfUj34FWOp9wjC3r+TkOYnhEMWbwweapLD6ltR+QdRx19dlLUbBSRoENMaN7/VsfBWJIH1q0q8nJtg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <aab2201.2d75.1909561f34c.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H4ZZpIxmWBonAA--.63212W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZRMXEGXAm6VAtwADse
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpIHRlanVuLAoKClN1cmUsIHRoYXQgd29ya3MuIFdlIGNhbiB3YWl0IHRvIG1lcmdlIGl0IGlu
dG8gdGhlIGNncm91cC9mb3ItNi4xMiBicmFuY2guIEkgd2lsbCBwaW5nIHlvdSBvbmNlIHY2LjEx
LXJjMSBpcyBjdXQuClRoYW5rIHlvdS4KCgotLQpCZXN0IFJlZ2FyZHMsClhhdmllcgoKCgoKQXQg
MjAyNC0wNy0wOSAwMjozODozMywgIlRlanVuIEhlbyIgPHRqQGtlcm5lbC5vcmc+IHdyb3RlOgo+
T24gU3VuLCBKdWwgMDcsIDIwMjQgYXQgMDk6NTk6NTVQTSAtMDQwMCwgV2FpbWFuIExvbmcgd3Jv
dGU6Cj4+IFRoZSBwYXRjaCBzZXJpZXMgbG9va3MgZ29vZCB0byBtZS4gSG93ZXZlciwgaXQgaXMg
YSBzdGlsbCBtYWpvciBjaGFuZ2UgaW4KPj4gdGhlIGRvbWFpbiBnZW5lcmF0aW9uIGFsZ29yaXRo
bSBhbmQgaXQgaXMgdG9vIGxhdGUgZm9yIHY2LjExLiBJIHdvdWxkIGFsc28KPj4gbGlrZSBpdCB0
byBzcGVuZCBtb3JlIHRpbWUgaW4gbGludXgtbmV4dCBhcyBJIGRvbid0IGhhdmUgYSBnb29kIHNl
dCBvZgo+PiBjZ3JvdXAgdjEgdGVzdC4gSSB3aWxsIHN1cHBvcnQgbWVyZ2luZyB0aGlzIGZvciB2
Ni4xMi4KPj4gCj4+IEFja2VkLWJ5OiBXYWltYW4gTG9uZyA8bG9uZ21hbkByZWRoYXQuY29tPgo+
Cj5YYXZpZXIsIGFzIHdlJ3JlIHByZXR0eSBjbG9zZSB0byB0aGUgbWVyZ2Ugd2luZG93LCBJIHRo
aW5rIGl0J2QgYmUgYmVzdCB0bwo+ZG8gdGhpcyBpbiB0aGUgbmV4dCBtZXJnZSB3aW5kb3cgYXMg
V2FpbWFuIHNhaWQuIENhbiB5b3UgcGxlYXNlIHBpbmcgbWUgb25jZQo+djYuMTEtcmMxIGlzIGN1
dD8gSSdsbCBhcHBseSB0aGUgdHdvIHBhdGNoZXMgb24gY2dyb3VwL2Zvci02LjEyLgo+Cj5UaGFu
a3MuCj4KPi0tIAo+dGVqdW4K

