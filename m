Return-Path: <cgroups+bounces-16206-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJjQNWBDEGrpVQYAu9opvQ
	(envelope-from <cgroups+bounces-16206-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 13:52:00 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D88905B3423
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 13:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 931BA30136FC
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042063E7159;
	Fri, 22 May 2026 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JERPYZtT"
X-Original-To: cgroups@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929F3CAA27;
	Fri, 22 May 2026 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779449893; cv=none; b=UYsAGgS/ofAAL9LXeE90wbO2fZ9ulJ4G3Ib2l9ettUCKQ4dV99eMkx9RvFcSciGERzy0LKY2wnBjSMfb6OxHJfTvcsxo67mZXT4MYIISDQiwOD5Ee6yS94e9zmE7YS9s6WSxewe+7ztLESRJGpP1c0sk9SyKlbmmRoUkwp+uBFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779449893; c=relaxed/simple;
	bh=8+SVtEunmLO5luTB/woJSREfnnEC/4OY69OYVm8LLR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=KF0fmiQs3ZIP37GbSzxQsyTzKg8qvXXm6cheqMTM3QeVlKef8oJ5+Iei3gNFHU5zHqwtIugnOTsi1wWJCb2uoRCZp+fGMD0xnPZ7ZXzuoXAZ7QgtBdaRmDVAZ9ge0Mv+k3UYCenIvtGTW/Q3KDhpQo+oaj2LA4kW01SpM0CkVCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JERPYZtT; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260522113802epoutp047d45dc3660ab4d2cdce57be27d46d659~x4D12kzVZ0577105771epoutp04e;
	Fri, 22 May 2026 11:38:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260522113802epoutp047d45dc3660ab4d2cdce57be27d46d659~x4D12kzVZ0577105771epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1779449882;
	bh=X9XR94YHNMocWUFw9punBQGDBFYxc1lt25ZEVZWgtac=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JERPYZtTU2TlEprNnCJlv0WM7hhtolUmAJHHUSjqwurELxRa/onqsWy1YDtIN+8xj
	 +MRV/ZDvXNq0x1UISaIT5DzyMNQLc2ARA7V98cZIDNSHBwP9Pl28ac/y9dgft9Nee1
	 aqj+yfQb92T4awPevYqHuFEft5mQPyEqwKj12DkU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260522113801epcas5p3905b503bc0cfbc37e68be912f3324730~x4D1cklL90648906489epcas5p32;
	Fri, 22 May 2026 11:38:01 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4gMNZ16HSyz6B9m7; Fri, 22 May
	2026 11:38:01 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260522084048epcas5p4778c8dc9ced70300473adfc67f24098c~x1pGJAfr53182831828epcas5p4i;
	Fri, 22 May 2026 08:40:48 +0000 (GMT)
Received: from [107.122.10.65] (unknown [107.122.10.65]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260522084036epsmtip25fbb927d3a064212cc2ad4bc1ee9e926~x1o6sdf2f2396423964epsmtip2V;
	Fri, 22 May 2026 08:40:35 +0000 (GMT)
Message-ID: <1891546521.01779449881859.JavaMail.epsvc@epcpadp2new>
Date: Fri, 22 May 2026 14:10:34 +0530
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
	dakr@kernel.org, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
	longman@redhat.com, akpm@linux-foundation.org, david@kernel.org,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, osalvador@suse.de,
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com,
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com,
	apopple@nvidia.com, axelrasmussen@google.com, yuanchu@google.com,
	weixugc@google.com, yury.norov@gmail.com, linux@rasmusvillemoes.dk,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, jackmanb@google.com, sj@kernel.org,
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
In-Reply-To: <afmgJcFUjQLYxkb5@gourry-fedora-PF4VCD3F>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260522084048epcas5p4778c8dc9ced70300473adfc67f24098c
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
	<1891546521.01777901881625.JavaMail.epsvc@epcpadp2new>
	<afmgJcFUjQLYxkb5@gourry-fedora-PF4VCD3F>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_MUA_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16206-lists,cgroups=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,opencompute.org:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,huawei.com,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com,samsung.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arun.george@samsung.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCPT_COUNT_GT_50(0.00)[75];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D88905B3423
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks.

On 05-05-2026 01:15 pm, Gregory Price wrote:
> In the scenario i'm talking about, a "write budget" is defined as a
> number of pages that are allows to be mapped writable in the page
> tables at any given time.
> Agree. I was also in the same context.

I am trying to bring the device perspective here, and would like to 
discuss a few corner cases and possible solutions.

As I see, solving the compressed memory problem statement has these 
aspects mainly:

1) Allocation control: private/managed memory concept.
2) Write control: write-protected PTEs, write-controlled use cases like 
ZSWAP
3) Proactive reclaims: optional methods to ease back-pressure using 
memory shrinkers, ballooning, kswapd, promotion etc. These methods will 
be triggered based on notifications/interrupts from the device.

May be they are not enough to cover some corner cases for cram!

  I believe that this thin-provisioned memory infra is susceptible to 
'writes-above-media-capacity corner cases' (because of not handling 
device back-pressure notifications in time) whichever methods we use in 
the kernel. Even if we use write-controlled methods like ZSWAP and 
pro-active reclaims, there could be corner cases where the communication 
with the device could be broken and the write path is not aware of it 
immediately. Note that OCP spec [1] says the device should mark the 
memory location as 'poisoned' in 'over-capacity' writes.

So I have the following proposals / options for this scenario.

    Option 1: Poisoned data management - This is about accepting that 
poisoning of memory locations can happen in much more regular frequency 
here than regular memories and we need to figure out potential recovery 
mechanisms in host (not recovery of data; but recovery from the poison 
situation). But I guess folks will not be okay with it in general, and I 
am not aware of any workloads where data poisoning is tolerated (may be 
caching workloads?).

    Option 2 (preferred): Device assisted write budgeting - This is 
about a device aware / assisted mechanism for the write-controlled 
use-cases (Ex: ZSWAP) to know the 'safe number of  writes' that can be 
performed to the device (Or allows to be mapped writable in the page 
tables). This could be like a 'token bucket' algorithm, where the device 
provides a 'budget / set of tokens' to the host. And it need to be 
replenished periodically in the device communication code path; and if 
the host does not find the token, writes cannot go ahead.

In short, the communication with the device has to be maintained to make 
pages mapped writable. For MVP, this could be a simple constraint of 
checking actual device capacity periodically to replenish write-budget 
for CRAM. For other users of private nodes (GPU memory?), this 
constraint may not be needed at all.

We are planning to send an RFC code which will fit into your CRAM infra 
to discuss this poison management approach further.

[1]: 
https://www.opencompute.org/documents/hyperscale-tiered-memory-expander-specification-for-compute-express-link-cxl-1-pdf

~Arun George


