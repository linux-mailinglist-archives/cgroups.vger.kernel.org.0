Return-Path: <cgroups+bounces-14848-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIe7E0xXuWnYAgIAu9opvQ
	(envelope-from <cgroups+bounces-14848-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 14:29:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDF2AAE25
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 14:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F03C3087682
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3D73CBE60;
	Tue, 17 Mar 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyRGysGg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59371375F6B;
	Tue, 17 Mar 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753949; cv=none; b=RyQpx4+PaAfNKcSHwvKzgt5dh2Uw+fI3wB1bjBa0udyV7cxI+urfjmmQKdBA2OcVWTLXAz3GTAuxlSjtKB7F4SwuQCrZQIZE+XMzwtLCVPkx1WGWkyuamHISCekMRaL4x2jY/G+C5k8uoI4Db1ISMmJN4E/6msReQRtvp1vQFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753949; c=relaxed/simple;
	bh=NbMxuERCb9JHAsoZXa40NtkHjx682HdeZjRT7I45/4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSDWhnvOVqRfoQDTswwbGxYAohgXHY/+hXv8thmQMC9FSuh8bbEhx+geuC73s6lEN1KU5/K7ydmt1cp/RnigTYr3N2F7KcV95ALXc5RzsAgvb/NOu+9I31MD7+CyXnL0xyFlWUCx2IuwJqlwJ+54GqS85kg3C49b25UR6REOjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyRGysGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E33C4CEF7;
	Tue, 17 Mar 2026 13:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773753949;
	bh=NbMxuERCb9JHAsoZXa40NtkHjx682HdeZjRT7I45/4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EyRGysGgOyFFvG7qMB5gGnylt0h0q9g8KKVIFOAcPBTTzTr300k+WkSOCAQXMWcex
	 7ccF18bHEaCKDandZn4R8JHkPf92HY9s+bux2XaUPPWclIlNabVXUvq9WPwV0JFStS
	 VhebImaylFWTQB5xxBEmA6GdQL1GEyFf/2PViHN/P5BCV73QbtRRj+KJx7wD/Htl6g
	 f8TfUluXqVSUtK5o4eg8Ws6XPGx0vu8BIHEZj+/gnde3WE6FZpyfeR9A//oynqFsCl
	 GKzjjIbuUs71EuzjSLWz8sT6Bdx2faIwpimHvFqZLz7P/QmvhQ+SzN/4jJCvIFYoot
	 xCH6zuoklkiZw==
Message-ID: <3342acb5-8d34-4270-98a2-866b1ff80faf@kernel.org>
Date: Tue, 17 Mar 2026 14:25:29 +0100
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,meta.com,linuxfoundation.org,kernel.org,stgolabs.net,huawei.com,intel.com,redhat.com,linux-foundation.org,oracle.com,suse.cz,google.com,suse.com,suse.de,nvidia.com,gmail.com,sk.com,linux.alibaba.com,rasmusvillemoes.dk,efficios.com,cmpxchg.org,arm.com,linux.dev,zte.com.cn,surriel.com,gentwo.org,tencent.com,huaweicloud.com,bytedance.com,amd.com];
	TAGGED_FROM(0.00)[bounces-14848-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03BDF2AAE25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2/22/26 09:48, Gregory Price wrote:
> Topic type: MM

Hi Gregory,

stumbling over this again, some questions whereby I'll just ignore the
compressed RAM bits for now and focus on use cases where promotion etc
are not relevant :)

[...]

> 
> TL;DR
> ===
> 
> N_MEMORY_PRIVATE is all about isolating NUMA nodes and then punching
> explicit holes in that isolation to do useful things we couldn't do
> before without re-implementing entire portions of mm/ in a driver.

Just to clarify: we don't currently have any mechanism to expose, say,
SPM/PMEM/whatsoever to the buddy allocator through the dax/kmem driver
and *not* have random allocations end up on it, correct?

Assume we online the memory to ZONE_MOVABLE, still other (fallback)
allocations might end up on that memory.

How would we currently handle something like that? (do we have drivers
for that? I'd assume that drivers would only migrate some user memory to
ZONE_DEVICE memory.)

Assuming we don't have such a mechanism, I assume that part of your
proposal would be very interesting: online the memory to a
"special"/"restricted" (you call it private) NUMA node, whereby all
memory of that NUMA node will only be consumable through
mbind() and friends.

Any other allocations (including automatic page migration etc) would not
end up on that memory.

Thinking of some "terribly slow" or "terribly fast" memory that we don't
want to involve in automatic memory tiering, being able to just let
selected workloads consume that memory sounds very helpful.


(wondering if there could be some way allocations might get migrated out
of the node, for example, during memory offlining etc, which might also
not be desirable)

I am not sure if __GFP_PRIVATE etc is really required for that. But some
mechanism to make that work seems extremely helpful.

Because ...

> 
> 
> /* This is my memory. There are many like it, but this one is mine. */
> rc = add_private_memory_driver_managed(nid, start, size, name, flags,
>                                        online_type, private_context);
> 
> page = alloc_pages_node(nid, __GFP_PRIVATE, 0);
> 
> /* Ok but I want to do something useful with it */
> static const struct node_private_ops ops = {
>         .migrate_to     = my_migrate_to,
>         .folio_migrate  = my_folio_migrate,
>         .flags = NP_OPS_MIGRATION | NP_OPS_MEMPOLICY,
> };
> node_private_set_ops(nid, &ops);
> 
> /* And now I can use mempolicy with my memory */
> buf = mmap(...);
> mbind(buf, len, mode, private_node, ...);
> buf[0] = 0xdeadbeef;  /* Faults onto private node */

... just being able to consume that memory through mbind() and having
guarantees sounds extremely helpful.

[...]

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
>   - Are filtered from zonelist fallback: all existing callers to
>     get_page_from_freelist cannot reach these nodes through any
>     normal fallback mechanism.

Good.

> 
>   - Filter allocation requests on __GFP_PRIVATE
>     	numa_zone_allowed() excludes them otherwise. 

I think we discussed that in the past, but why can't we find a way that
only people requesting __GFP_THISNODE could allocate that memory, for
example? I guess we'd have to remove it from all "default NUMA bitmaps"
somehow.

> 
>     Applies to systems with and without cpusets.
> 
>     GFP_PRIVATE is (__GFP_PRIVATE | __GFP_THISNODE).
> 
>     Services use it when they need to allocate specifically from
>     a private node (e.g., CRAM allocating a destination folio).
> 
>     No existing allocator path sets __GFP_PRIVATE, so private nodes
>     are unreachable by default.
> 
>   - Use standard struct page / folio.  No ZONE_DEVICE, no pgmap,
>     no struct page metadata limitations.

Good.

> 
>   - Use a node-scoped metadata structure to accomplish filtering
>     and callback support.
> 
>   - May participate in the buddy allocator, reclaim, compaction,
>     and LRU like normal memory, gated by an opt-in set of flags.
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

I think all of that might not be required for the simplistic use case I
mentioned above (fast/slow memory only to be consumed by selected user
space that opts in through mbind() and friends).

Or are there other use cases for these callbacks

[...]
> 
> 
> Flag-gated behavior (NP_OPS_*) controls:
> ===
> 
> We use OPS flags to denote what mm/ services we want to allow on our
> private node.   I've plumbed these through so far:
> 
>   NP_OPS_MIGRATION       - Node supports migration
>   NP_OPS_MEMPOLICY       - Node supports mempolicy actions
>   NP_OPS_DEMOTION        - Node appears in demotion target lists
>   NP_OPS_PROTECT_WRITE   - Node memory is read-only (wrprotect)
>   NP_OPS_RECLAIM         - Node supports reclaim
>   NP_OPS_NUMA_BALANCING  - Node supports numa balancing
>   NP_OPS_COMPACTION      - Node supports compaction
>   NP_OPS_LONGTERM_PIN    - Node supports longterm pinning
>   NP_OPS_OOM_ELIGIBLE	 - (MIGRATION | DEMOTION), node is reachable
>                            as normal system ram storage, so it should
> 			   be considered in OOM pressure calculations.

I have to think about all that, and whether that would be required as a
first step. I'd assume in a simplistic use case mentioned above we might
only forbid the memory to be used as a fallback for any oom etc.

Whether reclaim (e.g., swapout) makes sense is a good question.


-- 
Cheers,

David

