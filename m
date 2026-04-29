Return-Path: <cgroups+bounces-15553-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6jJhMh7Q8WmjkgEAu9opvQ
	(envelope-from <cgroups+bounces-15553-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 11:32:14 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89104491EFE
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 11:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC35B3061918
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A573C3442;
	Wed, 29 Apr 2026 09:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f4Jz3rp4"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5FD3921CC;
	Wed, 29 Apr 2026 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455017; cv=none; b=NjDJ5Aw0N8L/wnt3Q1ESjOnpyuytIf5jVknBZPjNMvPjWkQ/m9gwi3ZLeBmzadEKF5a3R9nyITpZ3Fa7sMZrlqQdmZetjJhYFIeWxqhhitUm7tXPdSC2Pi0YfA9PsoEjMCOB35eLjtOi0VM4D1Ii0mZEs3iKtxhVd4tT/HXpmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455017; c=relaxed/simple;
	bh=yy8oNEAoS/uzpxt3v8eVFMCgeKKpmjXxjvuY7Wbunjs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type:References; b=YOu86P6ioza40OWZaO0BFDCpIcmAcvD9e+yGBj8fkqMbl9NM+zqZMUVtOozmbhdXP6Lv89IT4o88hV02I0pRVtvIPkgQzHAbTi7KT2GXtcTxF99Zg/LQjPga6X4nW0o7SEn3cjEbA55k0IXSaAUI1L3CKlb0mE4DYeqUhUI+0tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=f4Jz3rp4; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260429093002epoutp0459abb6078236d1b7922c976b1042db95~qyehotRtY1912719127epoutp04T;
	Wed, 29 Apr 2026 09:30:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260429093002epoutp0459abb6078236d1b7922c976b1042db95~qyehotRtY1912719127epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777455003;
	bh=l2sErW9ifuxlN4x+Sne0CeYYbEJKHpiCBGf6vhcU2Jk=;
	h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
	b=f4Jz3rp4k+M6bC+6TqlXloRnoElu8gbjEIiUIua1QviqkO+4RxEinkUKYJCggf8Hd
	 FVrvtEGPb/OllLUxDO4vDE05M+R+UKBx6SqInb9CWkL+WMtxaQmXCaDix7f3d++h7o
	 yAcy3bhNxsmOBqM5dvxXy58dF4C26cPcMyLnfNPE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260429093002epcas5p409aa78c4d55a86cef067895205a1b2d5~qyehWqKUG3126931269epcas5p4T;
	Wed, 29 Apr 2026 09:30:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4g5Bpy4N4Rz3hhT9; Wed, 29 Apr
	2026 09:30:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260429061641epcas5p3c2d6063ba101e347c36ccfa050174482~qv1tDSpkV0853808538epcas5p3d;
	Wed, 29 Apr 2026 06:16:41 +0000 (GMT)
Received: from [107.122.10.65] (unknown [107.122.10.65]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260429061628epsmtip20cd5b871612ade998c9aaa11fb84dd9a~qv1gikvBb1891418914epsmtip2w;
	Wed, 29 Apr 2026 06:16:28 +0000 (GMT)
Message-ID: <1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
Date: Wed, 29 Apr 2026 11:45:26 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Arun George/Arun George <arun.george@samsung.com>
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com,
	akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	ying.huang@linux.alibaba.com, apopple@nvidia.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
	baolin.wang@linux.alibaba.com, npache@redhat.com, ryan.roberts@arm.com,
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
	muchun.song@linux.dev, xu.xin16@zte.com.cn, chengming.zhou@linux.dev,
	jannh@google.com, linmiaohe@huawei.com, nao.horiguchi@gmail.com,
	pfalcato@suse.de, rientjes@google.com, shakeel.butt@linux.dev,
	riel@surriel.com, harry.yoo@oracle.com, cl@gentwo.org,
	roman.gushchin@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	zhengqi.arch@bytedance.com, terry.bowman@amd.com, gost.dev@samsung.com,
	arungeorge05@gmail.com, cpgs@samsung.com
Content-Language: en-US
In-Reply-To: <ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260429061641epcas5p3c2d6063ba101e347c36ccfa050174482
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0
References: <20260222084842.1824063-1-gourry@gourry.net>
	<CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
	<1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
	<ae_i9IlIndumJWN3@gourry-fedora-PF4VCD3F>
X-Rspamd-Queue-Id: 89104491EFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15553-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,samsung.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.george@samsung.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCPT_COUNT_GT_50(0.00)[77];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

On 28-04-2026 03:58 am, Gregory Price wrote:
> On Mon, Apr 27, 2026 at 06:02:57PM +0530, Arun George wrote:
>>
>> Any particular workload you are targeting with
>> this (which can tolerate this latency)?
>>
>> Any deployments you think of where the goal is a capacity expansion
>> with a compromise in performance?
>>
> Primary use cases for us are any workload that benefits from zswap -
> which is many, many (many, many [many, many]) workloads.
> 
A curious question please. If the primary use case is swap, can't we 
handle this problem statement by re-using the zsmalloc allocation classes?

A separate size class can be reserved for non-compressed pages in 
zsmalloc. And this interface could be used by zswap, zram etc. (We have 
been using this implementation for testing btw.). This does not require 
additional book-keeping or buddy allocator.

But that approach will not give a generic solution and not available for 
user-land anyway!
>> And I believe the bear-proof cage might work in the normal scenarios,
>> but may not work for all.
> 
> If it can't work for all workloads, then it's likely not general purpose
> enough to find core kernel support and should seek to use the existing
> interfaces (DAX and friends).
> 
I agree. That is a good point.

> 
> You need two controls over compressed RAM for it to be reliable:
> 
>    - Allocation control (acquiring new struct page to write to)
>    - Write-control (preventing new writes to compressed pages)
> 
> Private nodes provide the allocation control.
> 
> A read-only mapping, and guarantee that only memory that can reach
> the device is userland memory - is the only way to control the cpu
> writes from the OS perspective.
> 
So write-control part need to handled in the specific back end driver of 
private pages while the allocation control is a generic front-end sort 
of, right? (Ex: zswap cram back end for compressed devices case.)>
> In the next version of the RFC i'll demonstrate cram.c as a new swap
> backend that allows for read-only mappings to be soft-faulted in,
> migration on write, isolation to ANON memory, and some optional
> settings that allow a device or administrator a "writable budget"
> which allows some number of pages to be made writable without migration.

Great! I believe "writable budget" could be an interesting idea which 
can solve the 'bus error' sort of scenarios due to device not capable of 
taking any more writes. The write budget could be replenished using the 
control path and writes will not go ahead without the budget available, 
right?>
> ~Gregory
> 
~Arun George


