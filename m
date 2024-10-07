Return-Path: <cgroups+bounces-5044-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F05992D03
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C8AB22FFB
	for <lists+cgroups@lfdr.de>; Mon,  7 Oct 2024 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8171D318B;
	Mon,  7 Oct 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="NJc2ucq7"
X-Original-To: cgroups@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5D31D26F1;
	Mon,  7 Oct 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728307172; cv=none; b=eYryBTURuDnawNP5nJ0WUnaJ9y1ykbUdixy5xyAcdKYwRdiYxgWOddzgSv1O16ZidQcRwUVJkl+IVIl8B1AYSxdwQyAOn/0ybfIDq4tNt+Neus5mpwbsUpMPcslKVng/2xz9yQqzjC+MniNdkgl2/db6CVenw1cOFAZKxqCJge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728307172; c=relaxed/simple;
	bh=vAz7pZDL3BR81Lhia4d2r7TiUxEWmjljNtzZ3P6X1XI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=Dak494ng7csibUpeJHzJ4mtjQF3VKW2Km6PD6GVJCo4S9FJEMNoLSXNBngIKFrk6wU0OQYALqaAiRTZhCY7zUJA8fF7CRkB76++zzllUaAEDiuviBbHqltSpu+GmfchrdOVXA3XrWCmMxviuSdB5ff7dp8luxJ9CyTroyMXrrTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=NJc2ucq7 reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=zstMmq+3IQ9atdLT3B4wAddmtdx2y8lJRRg5bRY003M=; b=N
	Jc2ucq7KeSrQpQisOFH7t+LkF2yhH49412aaXlCyN+S/WHaKT/Gplm8NXXYv9pkh
	6VSJrUG90Pv6q5eU60eZovjw/NaETFtg5E9c+3OAC69Tq6lW7yZuzl1EkX5x2Fvw
	RaUj+8WWljSwiDfo1V8ssOYuaIdxjjt1i3ifNVk7Tg=
Received: from xavier_qy$163.com ( [2408:820c:340b:a810:21d6:43cb:fa74:1f0d]
 ) by ajax-webmail-wmsvr-40-128 (Coremail) ; Mon, 7 Oct 2024 21:18:52 +0800
 (CST)
Date: Mon, 7 Oct 2024 21:18:52 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org, 
	hannes@cmpxchg.org, mkoutny@suse.com, akpm@linux-foundation.org, 
	jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Subject: Re:[PATCH 4/5] lib/union_find: Optimize uf_find() with enhanced
 path compression
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20241005214938.2147393-5-visitorckw@gmail.com>
References: <20241005214938.2147393-1-visitorckw@gmail.com>
 <20241005214938.2147393-5-visitorckw@gmail.com>
X-NTES-SC: AL_Qu2ZCv+buEko5CScYukfmk4QgeY+WMW1vP4m34NSN5FwjA7pxD84QnJOGWnX/8OIAieCnBWacxVuxfhBQqlacb0b7UN7nfe3i9r84FIBrdjppg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <18b085ce.3da3.1926721f823.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:gCgvCgDnz3C83wNnQk4HAA--.42779W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiZRVvEGcBr68fBQAEs3
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI0LTEwLTA2IDA1OjQ5OjM3LCAiS3Vhbi1XZWkgQ2hpdSIgPHZpc2l0b3Jja3dAZ21h
aWwuY29tPiB3cm90ZToKPk9wdGltaXplIHRoZSB1Zl9maW5kKCkgZnVuY3Rpb24gdG8gZW5oYW5j
ZSBpdHMgZWZmaWNpZW5jeSBieQo+aW1wbGVtZW50aW5nIGEgbW9yZSBlZmZlY3RpdmUgcGF0aCBj
b21wcmVzc2lvbiBzdHJhdGVneS4gVGhlIG9yaWdpbmFsCj5pbXBsZW1lbnRhdGlvbiBvbmx5IHVw
ZGF0ZWQgdGhlIHBhcmVudCBwb2ludGVyIG9mIHRoZSBjdXJyZW50IG5vZGUgdG8KPml0cyBncmFu
ZHBhcmVudCwgcmVzdWx0aW5nIGluIGEgcmVsYXRpdmVseSBzaGFsbG93IHRyZWUuCj4KPkluIHRo
ZSB1cGRhdGVkIHZlcnNpb24sIG9uY2UgdGhlIHJvb3Qgb2YgdGhlIG5vZGUgaXMgaWRlbnRpZmll
ZCwgYWxsCj5ub2RlcyBhbG9uZyB0aGUgc2VhcmNoIHBhdGggYXJlIHVwZGF0ZWQgdG8gZGlyZWN0
bHkgcG9pbnQgdG8gdGhlIHJvb3QuCj5UaGlzIGNoYW5nZSBtaW5pbWl6ZXMgdGhlIGhlaWdodCBv
ZiB0aGUgdHJlZSBhbmQgaW1wcm92ZXMgdGhlCj5lZmZpY2llbmN5IGZvciBzdWJzZXF1ZW50IGZp
bmQgb3BlcmF0aW9ucywgcHJvdmlkaW5nIGJldHRlciBwZXJmb3JtYW5jZQo+Zm9yIHRoZSBVbmlv
bi1GaW5kIGRhdGEgc3RydWN0dXJlLgo+Cj5TaWduZWQtb2ZmLWJ5OiBLdWFuLVdlaSBDaGl1IDx2
aXNpdG9yY2t3QGdtYWlsLmNvbT4KPi0tLQo+Tm90ZTogVGVzdGVkIHdpdGggdGhlIEtVbml0IHRl
c3RzIGludHJvZHVjZWQgaW4gdGhlIHByZXZpb3VzIHBhdGNoLgo+Cj4gbGliL3VuaW9uX2ZpbmQu
YyB8IDkgKysrKysrKy0tCj4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL2xpYi91bmlvbl9maW5kLmMgYi9saWIvdW5pb25fZmlu
ZC5jCj5pbmRleCBhMjA2NzhkYTAyMjAuLjdjNTUzZmE2MjJjOCAxMDA2NDQKPi0tLSBhL2xpYi91
bmlvbl9maW5kLmMKPisrKyBiL2xpYi91bmlvbl9maW5kLmMKPkBAIC0xMywxNCArMTMsMTkgQEAK
PiAgKi8KPiBzdHJ1Y3QgdWZfbm9kZSAqdWZfZmluZChzdHJ1Y3QgdWZfbm9kZSAqbm9kZSkKPiB7
Cj4rCXN0cnVjdCB1Zl9ub2RlICpyb290ID0gbm9kZTsKPiAJc3RydWN0IHVmX25vZGUgKnBhcmVu
dDsKPiAKPisJd2hpbGUgKHJvb3QtPnBhcmVudCAhPSByb290KQo+KwkJcm9vdCA9IHJvb3QtPnBh
cmVudDsKPisKPiAJd2hpbGUgKG5vZGUtPnBhcmVudCAhPSBub2RlKSB7CgpVc2luZyChsHJvb3Sh
sSBmb3IgdGhpcyBqdWRnbWVudCBtaWdodCBiZSBiZXR0ZXIsIGFzIGl0IGNvdWxkCnJlZHVjZSB1
bm5lY2Vzc2FyeSBlbnRlcmluZy4KICAgICAgICB3aGlsZSAobm9kZS0+cGFyZW50ICE9IHJvb3Qp
IHsKCj4gCQlwYXJlbnQgPSBub2RlLT5wYXJlbnQ7Cj4tCQlub2RlLT5wYXJlbnQgPSBwYXJlbnQt
PnBhcmVudDsKPisJCW5vZGUtPnBhcmVudCA9IHJvb3Q7Cj4gCQlub2RlID0gcGFyZW50Owo+IAl9
Cj4tCXJldHVybiBub2RlOwo+Kwo+KwlyZXR1cm4gcm9vdDsKPiB9Cj4gRVhQT1JUX1NZTUJPTCh1
Zl9maW5kKTsKPiAKPi0tIAo+Mi4zNC4xCg==

