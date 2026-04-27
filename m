Return-Path: <cgroups+bounces-15512-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K4cNPFn72lZBAEAu9opvQ
	(envelope-from <cgroups+bounces-15512-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 15:43:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E91473A14
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D422130089AD
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 13:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5873CBE71;
	Mon, 27 Apr 2026 13:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oTje4ElN"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586EA3C8705;
	Mon, 27 Apr 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297388; cv=none; b=hNtnomqRbSfZFvhGdI3bzptu3ZdSv5mY950hKMcHXa4YXSmh7yUn/d+t+dKDAhiCVsBJaKwzwxmeyjxnkhmULbDgI8VfoIafiOk52yeCVy9XbsTXgoVLs/pcX7noIM6IcbvBTwMQbGSMtGJ0spdx0+Rw2s8zHJQ/NKT80RHz4Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297388; c=relaxed/simple;
	bh=HYpZWzyqAIY0fKVdx1G8AWuk4ggGTSoGNuwwIO5d2iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=EliIs7/DDKxv2jgUAhkKr4kJ5DbqZcdCSZhyQTbewPCX6JUeJS7Ne5L1Nmfz7Pv8Wf0KPj97WHXdRfQu4UOjUKXSHBxOcW2gGH2ME5Algq+Jjm4sd/fv1t+qM7EZaEY7/dF3g+eg2R/K59816ZwPZTLyLAooSpE8pmcITMh0Nfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oTje4ElN; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260427134302epoutp0196401e6a027f43e9f7a2a8e4ec37def5~qOo2fjOBb1175011750epoutp01L;
	Mon, 27 Apr 2026 13:43:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260427134302epoutp0196401e6a027f43e9f7a2a8e4ec37def5~qOo2fjOBb1175011750epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1777297383;
	bh=HYpZWzyqAIY0fKVdx1G8AWuk4ggGTSoGNuwwIO5d2iQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oTje4ElNm4xecU1VG1Jrx86EY3Gpl1Vu+7Eg8igCfRDmuEWp0LdNN4Ssf0cEWBOKp
	 03qrQy7Mwh4wQ/opBqnoORCUo1z8aoZlbY7D0/ViobxGIRXTFLcHW7dWyX9aTsl2N3
	 Eh24v5hHa9Vb0gAdrDBssQHqG7CW+ElPnJnUatLc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260427134302epcas5p214d5e003586bc14fd5c926391fd2af9c~qOo16jVbi1491214912epcas5p24;
	Mon, 27 Apr 2026 13:43:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4g44Wp1ZR3z3hhT3; Mon, 27 Apr
	2026 13:43:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0~qNwDrt8ay0098400984epcas5p1l;
	Mon, 27 Apr 2026 12:38:00 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260427123748epsmtip257b0d1b83f2086e0e46dbf256b9f1ff0~qNv5BJqIr2057720577epsmtip23;
	Mon, 27 Apr 2026 12:37:48 +0000 (GMT)
Date: Mon, 27 Apr 2026 18:02:57 +0530
From: Arun George <arun.george@samsung.com>
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
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
Message-ID: <1983025922.01777297382206.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
X-CMS-MailID: 20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----lGFk.c4Zo19QZrlL9e6EpsCdvlY3lrbI5T.6445u7ei3FFQQ=_4f40_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0
References: <20260222084842.1824063-1-gourry@gourry.net>
	<CGME20260427123800epcas5p1e1a2fed257091b31e2e6c3a7d1b0c2b0@epcas5p1.samsung.com>
X-Rspamd-Queue-Id: 91E91473A14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,samsung.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:dkim,gourry.net:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15512-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.george@samsung.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[77];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

------lGFk.c4Zo19QZrlL9e6EpsCdvlY3lrbI5T.6445u7ei3FFQQ=_4f40_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 22/02/26 03:48AM, Gregory Price wrote:
>Topic type: MM
>
>Presenter: Gregory Price <gourry@gourry.net>
>
>This series introduces N_MEMORY_PRIVATE, a NUMA node state for memory
>managed by the buddy allocator but excluded from normal allocations.
>
>I present it with an end-to-end Compressed RAM service (mm/cram.c)
>that would otherwise not be possible (or would be considerably more
>difficult, be device-specific, and add to the ZONE_DEVICE boondoggle).
>
>
>TL;DR
>===
>
Appreciate the work as we also chase the same problem statement.
A few queries please.

I see the current support relies on read-only mappings which might
limit the performance. Any particular workload you are targeting with
this (which can tolerate this latency)?

Any deployments you think of where the goal is a capacity expansion
with a compromise in performance?

On the device side, are you targeting beyond compressed RAM like
devices such as memory with NAND etc.?

The TL;DR talked about mmap/mbind way of user space allocation from
the private node. But the allocation is controlled by GFP flag
N_MEMORY_PRIVATE. Does the user space path of allocation set this
flag along the way?

And I believe the bear-proof cage might work in the normal scenarios,
but may not work for all. We might not be able to rely on the control
path (backpressure) fully. The control path could go slow, slower and
even die as well. Should the device respond with something like
'bus error' if the host tries to write when it is not capable of
taking any more writes?

Are there any workloads (VM?) where this 'bus error'or similar error
could be an OK / recoverable scenario?

This is assuming that checking with the device on every operation
(whether it is safe to write or not) could be slow.

--- Arun George

------lGFk.c4Zo19QZrlL9e6EpsCdvlY3lrbI5T.6445u7ei3FFQQ=_4f40_
Content-Type: text/plain; charset="utf-8"


------lGFk.c4Zo19QZrlL9e6EpsCdvlY3lrbI5T.6445u7ei3FFQQ=_4f40_--


