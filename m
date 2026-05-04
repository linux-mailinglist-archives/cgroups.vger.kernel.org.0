Return-Path: <cgroups+bounces-15592-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHdeHJih+GlExQIAu9opvQ
	(envelope-from <cgroups+bounces-15592-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 15:39:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 89EBF4BDFC7
	for <lists+cgroups@lfdr.de>; Mon, 04 May 2026 15:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C3393018BDA
	for <lists+cgroups@lfdr.de>; Mon,  4 May 2026 13:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A143DD513;
	Mon,  4 May 2026 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nmZ8O9mw"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18F03D3334;
	Mon,  4 May 2026 13:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777901894; cv=none; b=pnOV9SUmLcJFWxgKnyLxFrmfvzOXZnFHxoiyUWjnZx2mBAA7S3owJGRpWGcxOs++l5GpQRaVozWferPH5VMVSL3uxdl13UEaC12Ol3P47GS3glt3C0id7SpMwhbGMBBy+nRdVJsvP9Sct35n94Ot1A2pCzIA1Yi32k0XlzoL59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777901894; c=relaxed/simple;
	bh=yxSm6/vu3IyP3srDroK/mn0D3idiK2xCmju19Wy9HrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=XbNHjD3S/18u1QCUzqm7OWB/YJZg9iloQiU7Vru56Q1+xq38vmkkp92Kzn+SGsj+LascW79fwp3mP5v68D7NF7vh86pf9QTlk1qtcuxdTO6apEO72KWI53zaHds8FbT7SW8NJ/Z6+0kLWTCi+uVL+OSYqh3TTz6EaymerfZS7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nmZ8O9mw; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260504133802epoutp02b4fe67eaaad6b60cdae9efe8d85f925e~sYFeNTetM0577405774epoutp02e;
	Mon,  4 May 2026 13:38:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260504133802epoutp02b4fe67eaaad6b60cdae9efe8d85f925e~sYFeNTetM0577405774epoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777901882;
	bh=K5X6546rG8Q7CDMgHYe0dMLLoA8JVhsjJIJ+l/s2c4Y=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nmZ8O9mwkiw6Qc3oNT26vkjmnNlI2wukd5FwCDzd9H7xY8AuXai7IIgT3MUN5KTvU
	 zuWhH4yfS4vIWtH7ZZm3cCd5duET+79RK+Yll2CLppi9ZAF+JaB3VR+AtIpQLJzfYp
	 kuHf8nA1xhwKYRz7MOqFl4cYZJ66wHOLsJP//U40=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260504133801epcas5p2868c041e3779e42e6e5fde3d36dba3a3~sYFd4KT8O2899328993epcas5p29;
	Mon,  4 May 2026 13:38:01 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4g8N4n4bV1z2SSKX; Mon,  4 May
	2026 13:38:01 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260504130907epcas5p29c41fc288662c37cd8ad7241772a53f8~sXsPFsdos2990329903epcas5p2Z;
	Mon,  4 May 2026 13:09:07 +0000 (GMT)
Received: from [107.122.10.65] (unknown [107.122.10.65]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260504130855epsmtip2f74fac9944e13b661bd91b5d97d7c8d2~sXsD4QdS72669726697epsmtip2P;
	Mon,  4 May 2026 13:08:55 +0000 (GMT)
Message-ID: <1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
Date: Mon, 4 May 2026 18:38:54 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
To: Gregory Price <gourry@gourry.net>
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
	kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, longman@redhat.com, akpm@linux-foundation.org,
	david@kernel.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com,
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
From: Arun George/Arun George <arun.george@samsung.com>
In-Reply-To: <afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260504130907epcas5p29c41fc288662c37cd8ad7241772a53f8
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
	<1891546521.01777455002601.JavaMail.epsvc@epcpadp1new>
	<afIKxG5mJZE6QgpR@gourry-fedora-PF4VCD3F>
X-Rspamd-Queue-Id: 89EBF4BDFC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15592-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samsung.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,samsung.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.george@samsung.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCPT_COUNT_GT_50(0.00)[76];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

On 29-04-2026 07:12 pm, Gregory Price wrote:
>>
>> Great! I believe "writable budget" could be an interesting idea which
>> can solve the 'bus error' sort of scenarios due to device not capable of
>> taking any more writes. The write budget could be replenished using the
>> control path and writes will not go ahead without the budget available,
>> right?>
>>
> 
> Write budget is simple
> 
> budget=1  (up to 1 page can be writable
>     1) swap 1 page ->  cram alloc 1 page, put VSWAP_CRAM in PTE
>     2) read-fault  ->  cram upgrades VSWAP_CRAM to R/O PTE
>     3) write-fault ->
>        a) if (writable_cnt < budget) { budget++; mkwrite(pte); }
>        b) else:  normal swap semantic -> promote to normal memory
> 
> Meanwhile - use ballooning and a simple shrinker to dynamically size the
> region to respond to real compression ratio.
> 
> 
> All said an done - you get something close to zswap but with R/O
> mappings for all entries, and optional R/W-mappings for administrators
> who know something about their workload and can afford to take the risk
> of some amount of capacity being written to uncontended in exchange for
> performance.
> 
> The writable-budget is a risk-dial:  How much do you trust your workload
> to now spew un/poorly-compressible memory?  The write-budget is a direct
> measure of that. (so take P99.99999 compression ratios, and you can make
> a good chunk of that writable).
> 
> ~Gregory
> 
> 
I believe we are converging. Agree to most points you mentioned.

I see this problem statement can be solved by 'write-control + write 
budget' approach similar to what you have described, whether we take 
swap path or not.

But I see this 'write budget' (budget in terms of number of write 
operations that can be handled by the device, not capacity) to be 
provided by the device in control plane; not by the workloads in the host.

The budget can be communicated by the device in the device control plane 
periodically (to be handled in the specific cram back-end driver; may be 
interpreting the device back-pressure indications into a write budget 
value). Even if the control plane breaks down, the host does not run 
into issues except that it will not write further.

I assume you see this value coming from the workloads. This might be a 
place where I have a different opinion.

There are multiple advantages of this value coming from the device:

  1) We can modulate the write budget depending on the actual 
compressibility in the device (and so workloads data). We don't have to 
do estimation based on the workloads.

  2) We don't have to do the capacity modulation - as in ballooning or 
shrinker.

  3) Even if the control path is broken, host can write only till the 
available 'write budget'; so it won't get into 'bus error' situations.

~Arun George





