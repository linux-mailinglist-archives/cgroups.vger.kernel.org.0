Return-Path: <cgroups+bounces-14144-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEtvL1FRnGktDwQAu9opvQ
	(envelope-from <cgroups+bounces-14144-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 14:08:33 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B331768DB
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 14:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29BC03013D51
	for <lists+cgroups@lfdr.de>; Mon, 23 Feb 2026 13:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638053659EE;
	Mon, 23 Feb 2026 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCI5hPTN"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D2C1CEAC2;
	Mon, 23 Feb 2026 13:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852057; cv=none; b=kdQcYCpRRLbPZ7E9f5OMKAbi/b0Img7rn0FDHNFzYPsgRQCyIAqrSbAeWG7ohaKWPo7hMjhGCZsHYygvm5NNklUK302l1DzMAwZ11mvrUUXpZyMoC5a5v9A/rpP4j1CXGzBQCvaubJuMfH3J+GBlfYWMQyj3TsevFH4chyJI8mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852057; c=relaxed/simple;
	bh=Ika/JAp4pU1JwzWcIf5dvk3cuyOWvlaomAbjRNXGRsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrrg09c1F2w3s1UqbuD68Kk7hbmn4y6OLM7Slur7pMq+U6B1c9WOz5MO/6K3zH6A4f7tQx8XHWMHiI8sZ+dnSfi0yUtT+6iJjzKIgxP3W2obpEYngbZoHUyqBY3WnR9hHq0LtGqnPgYkCo+8/Emp3RNmggXLAxz9HVgvH/Bhxmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCI5hPTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E37C116C6;
	Mon, 23 Feb 2026 13:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771852056;
	bh=Ika/JAp4pU1JwzWcIf5dvk3cuyOWvlaomAbjRNXGRsk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCI5hPTNqBuWhoQsLkcOdy4X8soFNRBZcphXi9R2/EfkNGkZsuLPAOekSv7BLgygC
	 g/eE7DHVevX1XY4BUIPDj44B9rlSTt0wsi/CI+I57iDUF3qtpRle31Wf2fanzIlLtD
	 7GmKM0FZJ2JNu8atgOAAobJMHSx7Ao6Vn/ts+Wg0gfJzMx+8wypStI3Vua/Beay8Hu
	 0tbRYWYLTQYiNZoQfv71O8SXWVHGSSqcw2/LxQKtpLwZkUh46kzNUo2miXjcR8v8VW
	 hXzQGnwRpHaPXp6pDLvHuXcmuQRYQXszTNA45jrHfbPPhyRi4rdxBYKi3iRTswDdp3
	 RxKaBDzytW06g==
Message-ID: <c10400db-2259-4465-a07e-19d0691101a4@kernel.org>
Date: Mon, 23 Feb 2026 14:07:15 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC][RFC PATCH v4 00/27] Private Memory Nodes (w/
 Compressed RAM)
To: Gregory Price <gourry@gourry.net>, lsf-pc@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, damon@lists.linux.dev,
 kernel-team@meta.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 dakr@kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
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
 zhengqi.arch@bytedance.com, terry.bowman@amd.com
References: <20260222084842.1824063-1-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260222084842.1824063-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	TAGGED_FROM(0.00)[bounces-14144-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gourry.net:email]
X-Rspamd-Queue-Id: 27B331768DB
X-Rspamd-Action: no action

On 2/22/26 09:48, Gregory Price wrote:
> Topic type: MM
> 
> Presenter: Gregory Price <gourry@gourry.net>
> 
> This series introduces N_MEMORY_PRIVATE, a NUMA node state for memory
> managed by the buddy allocator but excluded from normal allocations.
> 
> I present it with an end-to-end Compressed RAM service (mm/cram.c)
> that would otherwise not be possible (or would be considerably more
> difficult, be device-specific, and add to the ZONE_DEVICE boondoggle).
> 
> 
> TL;DR
> ===
> 
> N_MEMORY_PRIVATE is all about isolating NUMA nodes and then punching
> explicit holes in that isolation to do useful things we couldn't do
> before without re-implementing entire portions of mm/ in a driver.
> 
> 
> /* This is my memory. There are many like it, but this one is mine. */
> rc = add_private_memory_driver_managed(nid, start, size, name, flags,
>                                         online_type, private_context);
> 
> page = alloc_pages_node(nid, __GFP_PRIVATE, 0);
> 
> /* Ok but I want to do something useful with it */
> static const struct node_private_ops ops = {
>          .migrate_to     = my_migrate_to,
>          .folio_migrate  = my_folio_migrate,
>          .flags = NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
> };
> node_private_set_ops(nid, &ops);
> 
> /* And now I can use mempolicy with my memory */
> buf = mmap(...);
> mbind(buf, len, mode, private_node, ...);
> buf[0] = 0xdeadbeef;  /* Faults onto private node */
> 
> /* And to be clear, no one else gets my memory */
> buf2 = malloc(4096);  /* Standard allocation */
> buf2[0] = 0xdeadbeef; /* Can never land on private node */
> 
> /* But i can choose to migrate it to the private node */
> move_pages(0, 1, &buf, &private_node, NULL, ...);
> 
> /* And more fun things like this */
> 
> 
> Patchwork
> ===
> A fully working branch based on cxl/next can be found here:
> https://github.com/gourryinverse/linux/tree/private_compression
> 
> A QEMU device which can inject high/low interrupts can be found here:
> https://github.com/gourryinverse/qemu/tree/compressed_cxl_clean
> 
> The additional patches on these branches are CXL and DAX driver
> housecleaning only tangentially relevant to this RFC, so i've
> omitted them for the sake of trying to keep it somewhat clean
> here.  Those patches should (hopefully) be going upstream anyway.
> 
> Patches 1-22: Core Private Node Infrastructure
> 
>    Patch  1:      Introduce N_MEMORY_PRIVATE scaffolding
>    Patch  2:      Introduce __GFP_PRIVATE
>    Patch  3:      Apply allocation isolation mechanisms
>    Patch  4:      Add N_MEMORY nodes to private fallback lists
>    Patches 5-9:   Filter operations not yet supported
>    Patch 10:      free_folio callback
>    Patch 11:      split_folio callback
>    Patches 12-20: mm/ service opt-ins:
>                     Migration, Mempolicy, Demotion, Write Protect,
>                     Reclaim, OOM, NUMA Balancing, Compaction,
>                     LongTerm Pinning
>    Patch 21:      memory_failure callback
>    Patch 22:      Memory hotplug plumbing for private nodes
> 
> Patch 23: mm/cram -- Compressed RAM Management
> 
> Patches 24-27: CXL Driver examples
>    Sysram Regions with Private node support
>    Basic Driver Example: (MIGRATION | MEMPOLICY)
>    Compression Driver Example (Generic)
> 
> 
> Background
> ===
> 
> Today, drivers that want mm-like services on non-general-purpose
> memory either use ZONE_DEVICE (self-managed memory) or hotplug into
> N_MEMORY and accept the risk of uncontrolled allocation.
> 
> Neither option provides what we really want - the ability to:
> 	1) selectively participate in mm/ subsystems, while
> 	2) isolating that memory from general purpose use.
> 
> Some device-attached memory cannot be managed as fully general-purpose
> system RAM.  CXL devices with inline compression, for example, may
> corrupt data or crash the machine if the compression ratio drops
> below a threshold -- we simply run out of physical memory.
> 
> This is a hard problem to solve: how does an operating system deal
> with a device that basically lies about how much capacity it has?
> 
> (We'll discuss that in the CRAM section)
> 
> 
> Core Proposal: N_MEMORY_PRIVATE
> ===
> 
> Introduce N_MEMORY_PRIVATE, a NUMA node state for memory managed by
> the buddy allocator, but excluded from normal allocation paths.
> 
> Private nodes:
> 
>    - Are filtered from zonelist fallback: all existing callers to
>      get_page_from_freelist cannot reach these nodes through any
>      normal fallback mechanism.
> 
>    - Filter allocation requests on __GFP_PRIVATE
>      	numa_zone_allowed() excludes them otherwise.
> 
>      Applies to systems with and without cpusets.
> 
>      GFP_PRIVATE is (__GFP_PRIVATE | __GFP_THISNODE).
> 
>      Services use it when they need to allocate specifically from
>      a private node (e.g., CRAM allocating a destination folio).
> 
>      No existing allocator path sets __GFP_PRIVATE, so private nodes
>      are unreachable by default.
> 
>    - Use standard struct page / folio.  No ZONE_DEVICE, no pgmap,
>      no struct page metadata limitations.
> 
>    - Use a node-scoped metadata structure to accomplish filtering
>      and callback support.
> 
>    - May participate in the buddy allocator, reclaim, compaction,
>      and LRU like normal memory, gated by an opt-in set of flags.
> 
> The key abstraction is node_private_ops: a per-node callback table
> registered by a driver or service.
> 
> Each callback is individually gated by an NP_OPS_* capability flag.
> 
> A driver opts in only to the mm/ operations it needs.
> 
> It is similar to ZONE_DEVICE's pgmap at a node granularity.
> 
> In fact...
> 
> 
> Re-use of ZONE_DEVICE Hooks
> ===
> 
> The callback insertion points deliberately mirror existing ZONE_DEVICE
> hooks to minimize the surface area of the mechanism.
> 
> I believe this could subsume most DEVICE_COHERENT users, and greatly
> simplify the device-managed memory development process (no more
> per-driver allocator and migration code).
> 
> (Also it's just "So Fresh, So Clean").
> 
> The base set of callbacks introduced include:
> 
>    free_folio           - mirrors ZONE_DEVICE's
>                           free_zone_device_page() hook in
>                           __folio_put() / folios_put_refs()
> 
>    folio_split          - mirrors ZONE_DEVICE's
>    			 called when a huge page is split up
> 
>    migrate_to           - demote_folio_list() custom demotion (same
>                           site as ZONE_DEVICE demotion rejection)
> 
>    folio_migrate        - called when private node folio is moved to
>                           another location (e.g. compaction)
> 
>    handle_fault         - mirrors the ZONE_DEVICE fault dispatch in
>                           handle_pte_fault() (do_wp_page path)
> 
>    reclaim_policy       - called by reclaim to let a driver own the
>                           boost lifecycle (driver can driver node reclaim)
> 
>    memory_failure       - parallels memory_failure_dev_pagemap(),
>                           but for online pages that enter the normal
>                           hwpoison path
> 
> At skip sites (mlock, madvise, KSM, user migration), a unified
> folio_is_private_managed() predicate covers both ZONE_DEVICE and
> N_MEMORY_PRIVATE folios, consolidating existing zone_device checks
> with private node checks rather than adding new ones.
> 
>    static inline bool folio_is_private_managed(struct folio *folio)
>    {
>            return folio_is_zone_device(folio) ||
>                   folio_is_private_node(folio);
>    }
> 
> Most integration points become a one-line swap:
> 
>    -     if (folio_is_zone_device(folio))
>    +     if (unlikely(folio_is_private_managed(folio)))
> 
> 
> Where a one-line integration is insufficient, the integration is
> kept as clean as possible with zone_device, rather than simply
> adding more call-sites on top of it:
> 
> static inline bool folio_managed_handle_fault(struct folio *folio,
>    struct vm_fault *vmf, vm_fault_t *ret)
> {
>    /* Zone device pages use swap entries; handled in do_swap_page */
>    if (folio_is_zone_device(folio))
>      return false;
> 
>    if (folio_is_private_node(folio)) {
>      const struct node_private_ops *ops = folio_node_private_ops(folio);
> 
>      if (ops && ops->handle_fault) {
>        *ret = ops->handle_fault(vmf);
>        return true;
>      }
>    }
>    return false;
> }
> 
> 
> 
> Flag-gated behavior (NP_OPS_*) controls:
> ===
> 
> We use OPS flags to denote what mm/ services we want to allow on our
> private node.   I've plumbed these through so far:
> 
>    NP_OPS_MIGRATION       - Node supports migration
>    NP_OPS_MEMPOLICY       - Node supports mempolicy actions
>    NP_OPS_DEMOTION        - Node appears in demotion target lists
>    NP_OPS_PROTECT_WRITE   - Node memory is read-only (wrprotect)
>    NP_OPS_RECLAIM         - Node supports reclaim
>    NP_OPS_NUMA_BALANCING  - Node supports numa balancing
>    NP_OPS_COMPACTION      - Node supports compaction
>    NP_OPS_LONGTERM_PIN    - Node supports longterm pinning
>    NP_OPS_OOM_ELIGIBLE	 - (MIGRATION | DEMOTION), node is reachable
>                             as normal system ram storage, so it should
> 			   be considered in OOM pressure calculations.
> 
> I wasn't quite sure how to classify ksm, khugepaged, madvise, and
> mlock - so i have omitted those for now.
> 
> Most hooks are straightforward.
> 
> Including a node as a demotion-eligible target was as simple as:
> 
> static void establish_demotion_targets(void)
> {
>    ..... snip .....
>    /*
>     * Include private nodes that have opted in to demotion
>     * via NP_OPS_DEMOTION.  A node might have custom migrate
>     */
>    all_memory = node_states[N_MEMORY];
>    for_each_node_state(node, N_MEMORY_PRIVATE) {
>        if (node_private_has_flag(node, NP_OPS_DEMOTION))
>        node_set(node, all_memory);
>    }
>    ..... snip .....
> }
> 
> The Migration and Mempolicy support are the two most complex pieces,
> and most useful things are built on top of Migration (meaning the
> remaining implementations are usually simple).
> 
> 
> Private Node Hotplug Lifecycle
> ===
> 
> Registration follows a strict order enforced by
> add_private_memory_driver_managed():
> 
>    1. Driver calls add_private_memory_driver_managed(nid, start,
>       size, resource_name, mhp_flags, online_type, &np).
> 
>    2. node_private_register(nid, &np) stores the driver's
>       node_private in pgdat and sets pgdat->private.  N_MEMORY and
>       N_MEMORY_PRIVATE are mutually exclusive -- registration fails
>       with -EBUSY if the node already has N_MEMORY set.
> 
>       Only one driver may register per private node.
> 
>    3. Memory is hotplugged via __add_memory_driver_managed().
> 
>       When online_pages() runs, it checks pgdat->private and sets
>       N_MEMORY_PRIVATE instead of N_MEMORY.
> 
>       Zonelist construction gives private nodes a self-only NOFALLBACK
>       list and an N_MEMORY fallback list (so kernel/slab allocations on
>       behalf of private node work can fall back to DRAM).
> 
>    4. kswapd and kcompactd are NOT started for private nodes.  The
>       owning service is responsible for driving reclaim if needed
>       (e.g., CRAM uses watermark_boost to wake kswapd on demand).
> 
> Teardown is the reverse:
> 
>    1. Driver calls offline_and_remove_private_memory(nid, start,
>       size).
> 
>    2. offline_pages() offlines the memory.  When the last block is
>       offlined, N_MEMORY_PRIVATE is cleared automatically.
> 
>    3. node_private_unregister() clears pgdat->node_private and
>       drops the refcount.  It refuses to unregister (-EBUSY) if
>       N_MEMORY_PRIVATE is still set (other memory ranges remain).
> 
> The driver is responsible for ensuring memory is hot-unpluggable
> before teardown.  The service must ensure all memory is cleaned
> up before hot-unplug - or the service must support migration (so
> memory_hotplug.c can evacuate the memory itself).
> 
> In the CRAM example, the service supports migration, so memory
> hot-unplug can remove memory without any special infrastructure.
> 
> 
> Application: Compressed RAM (mm/cram)
> ===
> 
> Compressed RAM has a serious design issue:  Its capacity a lie.
> 
> A compression device reports more capacity than it physically has.
> If workloads write faster than the OS can reclaim from the device,
> we run out of real backing store and corrupt data or crash.
> 
> I call this problem: "Trying to Out Run A Bear"
> 
> I.e. This is only stable as long as we stay ahead of the pressure.
> 
> We don't want to design a system where stability depends on outrunning
> a bear - I am slow and do not know where to acquire bear spray.
> 
>    Fun fact:   Grizzly bears have a top-speed of 56-64 km/h.
>    Unfun Fact: Humans typically top out at ~24 km/h.
> 
> This MVP takes a conservative position:
> 
>     all compressed memory is mapped read-only.
> 
>    - Folios reach the private node only via reclaim (demotion)
>    - migrate_to implements custom demotion with backpressure.
>    - fixup_migration_pte write-protects PTEs on arrival.
>    - wrprotect hooks prevent silent upgrades
>    - handle_fault promotes folios back to DRAM on write.
>    - free_folio scrubs stale data before buddy free.
> 
> Because pages are read-only, writes can never cause runaway
> compression ratio loss behind the allocator's back.  Every write
> goes through handle_fault, which promotes the folio to DRAM first.
> 
> The device only ever sees net compression (demotion in) and explicit
> decompression (promotion out via fault or reclaim), and has a much
> wider timeframe to respond to poor compression scenarios.
> 
> That means there's no bear to out run. The bears are safely asleep in
> their bear den, and even if they show up we have a bear-proof cage.
> 
> The backpressure system is our bear-proof cage: the driver reports real
> device utilization (generalized via watermark_boost on the private
> node's zone), and CRAM throttles demotion when capacity is tight.
> 
> If compression ratios are bad, we stop demoting pages and start
> evicting pages aggressively.
> 
> The service as designed is ~350 functional lines of code because it
> re-uses mm/ services:
> 
>    - Existing reclaim/vmscan code handles demotion.
>    - Existing migration code handles migration to/from.
>    - Existing page fault handling dispatches faults.
> 
> The driver contains all the CXL nastiness core developers don't want
> anything to do with - No vendor logic touches mm/ internals.
> 
> 
> 
> Future CRAM : Loosening the read-only constraint
> ===
> 
> The read-only model is safe but conservative.  For workloads where
> compressed pages are occasionally written, the promotion fault adds
> latency.  A future optimization could allow a tunable fraction of
> compressed pages to be mapped writable, accepting some risk of
> write-driven decompression in exchange for lower overhead.
> 
> The private node ops make this straightforward:
> 
>    - Adjust fixup_migration_pte to selectively skip
>      write-protection.
>    - Use the backpressure system to either revoke writable mappings,
>      deny additional demotions, or evict when device pressure rises.
> 
> This comes at a mild memory overhead: 32MB of DRAM per 1TB of CRAM.
> (1 bit per 4KB page).
> 
> This is not proposed here, but it should be somewhat trivial.
> 
> 
> Discussion Topics
> ===
> 0. Obviously I've included the set as an RFC, please rip it apart.
> 
> 1. Is N_MEMORY_PRIVATE the right isolation abstraction, or should
>     this extend ZONE_DEVICE?  Prior feedback pushed away from new
>     ZONE logic, but this will likely be debated further.
> 
>     My comments on this:
> 
>     ZONE_DEVICE requires re-implementing every service you want to
>     provide to your device memory, including basic allocation.
> 
>     Private nodes use real struct pages with no metadata
>     limitations, participate in the buddy allocator, and get NUMA
>     topology for free.
> 
> 2. Can this subsume ZONE_DEVICE COHERENT users?  The architecture
>     was designed with this in mind, but it is only a thought experiment.
> 
> 3. Is a dedicated mm/ service (cram) the right place for compressed
>     memory management, or should this be purely driver-side until
>     more devices exist?
> 
>     I wrote it this way because I forsee more "innovation" in the
>     compressed RAM space given current... uh... "Market Conditions".
> 
>     I don't see CRAM being CXL-specific, though the only solutions I've
>     seen have been CXL.  Nothing is stopping someone from soldering such
>     memory directly to a PCB.
> 
> 5. Where is your hardware-backed data that shows this works?
> 
>     I should have some by conference time.
> 
> Thanks for reading
> Gregory (Gourry)
> 
> 
> Gregory Price (27):
>    numa: introduce N_MEMORY_PRIVATE node state
>    mm,cpuset: gate allocations from N_MEMORY_PRIVATE behind __GFP_PRIVATE
>    mm/page_alloc: add numa_zone_allowed() and wire it up
>    mm/page_alloc: Add private node handling to build_zonelists
>    mm: introduce folio_is_private_managed() unified predicate
>    mm/mlock: skip mlock for managed-memory folios
>    mm/madvise: skip madvise for managed-memory folios
>    mm/ksm: skip KSM for managed-memory folios
>    mm/khugepaged: skip private node folios when trying to collapse.
>    mm/swap: add free_folio callback for folio release cleanup
>    mm/huge_memory.c: add private node folio split notification callback
>    mm/migrate: NP_OPS_MIGRATION - support private node user migration
>    mm/mempolicy: NP_OPS_MEMPOLICY - support private node mempolicy
>    mm/memory-tiers: NP_OPS_DEMOTION - support private node demotion
>    mm/mprotect: NP_OPS_PROTECT_WRITE - gate PTE/PMD write-upgrades

I'm concerned about adding more special-casing (similar to what we 
already added for ZONE_DEVICE) all over the place.

Like the whole folio_managed_() stuff in mprotect.c

Having that said, sounds like a reasonable topic to discuss.

-- 
Cheers,

David

