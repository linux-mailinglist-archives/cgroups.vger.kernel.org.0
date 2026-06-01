Return-Path: <cgroups+bounces-16508-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aP4yKmw3HWoqWQkAu9opvQ
	(envelope-from <cgroups+bounces-16508-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 09:40:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9761B00D
	for <lists+cgroups@lfdr.de>; Mon, 01 Jun 2026 09:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A7DE30160E8
	for <lists+cgroups@lfdr.de>; Mon,  1 Jun 2026 07:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FF4386556;
	Mon,  1 Jun 2026 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G12YTEvn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240DA386C05
	for <cgroups@vger.kernel.org>; Mon,  1 Jun 2026 07:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299293; cv=none; b=WFqi+YK6Z90UihSbEQTNVJghwKKAzLXvcyjV/sepDG890EyXHjsO6h8ZINk5pSm78zU+Cx/8mBwsrZn35/FxvJnYQSxxZszDrHCsf3Z0pG4l0XZl1M000F8gMVMZyjiBXqKKUApA/ainUHmEki8I0rMq24YbFNxkGL6D53QhktY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299293; c=relaxed/simple;
	bh=rQwmF9Z0bF2+ssgODdEVa+v28Rq2XiZeAKdj/LJGOL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjViuoMH5Hsyp/6Sida7gQV+Po3CbsyI+MTb82xTf5XVBdGpTFDM3FuaBzWRGwXgwrxvv2u02a7424PeXJFVOynOalLX59GjclpabXVP3yEs4AfnvzfTUqdDw7I4ZoFgHbsSqP18zeECJdjrl1DSuhii8wiZMHRBadqd9qd2FTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G12YTEvn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c0c3543590so6303775ad.2
        for <cgroups@vger.kernel.org>; Mon, 01 Jun 2026 00:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780299288; x=1780904088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UntsdzuqpdttstMyOLOIQLL5ljvbyDCzLnXwa0e2org=;
        b=G12YTEvnWT6O8akt8WPf7nNhBfPJaRUHORX6x51m2rCV720o6wUunJV54R9v8UtScb
         oIDEURCXEYb9VRCyEUE4I6d5P1JPeuWt23pPo0rfvyLMvDbi/pF3OifRs/I6BJQirDj3
         X+jW+IX1mdl7TtjglH9hoO0k2SyZ5poF7/Yb/63tta0GI9w4YSKrzbKgCHpg13Z5iV2F
         bkYy3RlHLvyhguP5QP8dxwwsgszniWIwmhso4770RzfAdhnrDdz0od39vKjzjP+qg2m6
         ZCzV7WHmNTM/4x1ZkCyodqWRwMAAUU6MUJR/RLRdD1tWNS4mOL2LCEoy9BqSz3rMhrNF
         9pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780299288; x=1780904088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UntsdzuqpdttstMyOLOIQLL5ljvbyDCzLnXwa0e2org=;
        b=GarCOrrbjU4vq+RHcEva9Dmhx5E2u/fk4kQjyHBfB/We7MshHT92H4uyw9ea+Nku0F
         xRkt8O7Nsf0imB/xj+9g+BeipdCUp+WX63twvsy6S8YFgVby5qVxukDO2NsWeMPad2PE
         WPwVqe1+1MwNVtFCTjkzCIgQmHcgeG78LoQYtnGYGJboDQ53uEiqtoliHJl3jWWfjdsN
         5VcrfTMRjMMQfHHl7GMUkRlF3qEf8fsBgLICbhqJwvuXh/0mNe8mUBDEaoYUCpqFUaDm
         PVqCH/dj6fTdwVRTMRlqHI9GjrB71PbZvV/NsNVuyH2CruLHWhdj07JW9bRWBMd6BMpV
         7F9A==
X-Forwarded-Encrypted: i=1; AFNElJ+vR2hRMhRyWOD+5xfSsv4fa5wf/l7eGYYn8/6zaS2DFtsMrkJSTHLOPdkuzdumSa5KYkSqV4yZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9B93JsVgTIq4RibtlWE7cTMlfNINozCMnccZjAYqHnzt3Fs3T
	trxjssztXrlIhNYvZgh/TEsS91P4qw2h4FiMi2txXQD02zT7ncZYglzC
X-Gm-Gg: Acq92OH0AFuW7e/BTjq+X+KXqgwYBC8b/2zeTuc1xwjvuSNMFID3jMOlajhs20q2aYG
	bP1Al86yodGggDNo4LL0SqFqVQ9cM8bF2tCGcskqc53qP/V37HIRTnFWk5L0ISofycr744q4Cr/
	oOL8E0uiSTPTpDMjD7WArc6Q/zLTS4YoHABpcPLBB118r0MjuXmzv6AGVPEDOeow989gunaDmwu
	EN6XUqKxz0R2XemiQPPC0CnOokWoW9mn8LGxQdnvysKVr/FA6+swPm20Z+Uvd9+KmQZ5KvwGdA5
	C5UH6s/kyMqznAItOI9YgkWuS5QOF/a0oNIqfnW0vcfzWyDbn32TGFop1fpXTBvo6d7iMvPcfvc
	stG5NBR71uvtwRreFxnBnbNA/qDr0HfsZXV2bc+gxnsGqA6s1S/ltK5skdMozRUiam9qz8XMZhJ
	/I8qx1TWAUdjigLwCaxEFWiRiQ6HjKTeu26dTXl5qylg+zYg3/5giET1zCMx5VNqI6tK5/5p4Nz
	l7jPso=
X-Received: by 2002:a17:902:ce11:b0:2c0:3400:5c34 with SMTP id d9443c01a7336-2c034005dd9mr93758435ad.3.1780299287941;
        Mon, 01 Jun 2026 00:34:47 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c4dd4csm97887385ad.78.2026.06.01.00.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 00:34:47 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:34:34 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org, 
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com, 
	yosry.ahmed@linux.dev, yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com, 
	kernel-team@meta.com, riel@surriel.com, haowenchao22@gmail.com
Subject: Re: [RFC PATCH 0/5] mm, swap: Virtual Swap Space (Swap Table Edition)
Message-ID: <ahz_iYG4lqWL4g-J@KASONG-MC4>
References: <20260528212955.1912856-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260528212955.1912856-1-nphamcs@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16508-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_GT_50(0.00)[55];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 41C9761B00D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 02:29:24PM +0800, Nhat Pham wrote:
> Based on: mm-unstable @ 444fc9435e57 + swap-table phase IV v5 [2].
> 
> I manually adapted Kairui's ghost device implementation (from [4])
> for my vswap device. I've credited him as Co-developed-by on Patch I
> since a substantial portion of the dynamic-cluster infrastructure is
> his (I did propose the idea of using xarray/radix tree for dynamic
> swap clusters allocation and management though :P).
> 
> >From here on out, for simplicity, I will refer to swap table phase IV
> as "P4", and the older v6 virtual swap space implementation as "v6".
> 

...

> 
> This series reimplements the virtual swap space concept (see [1])
> on top of Kairui Song's swap table infrastructure, on top of [2]
> and in accordance with his proposal in [3]. The proposal's idea
> is interesting, so I decided to give it a shot myself. I'm still not
> 100% sure that this is bug-proof, but hey, it compiles, and has
> not crashed in my simple stress testing :)
> 
> The prototype here is feature-complete relative to the swap-table P4
> baseline — swapout, swapin, freeing, swapoff, zswap writeback, zswap
> shrinker, memcg charging, and THP swapin all work for
> both vswap and direct-physical entries — and satisfies all three
> requirements above: no backend coupling (zswap/zero entries hold no
> physical slot), dynamic swap space (clusters allocated on demand via
> xarray, no static provisioning), and efficient backend transfer
> (in-place vtable updates, no PTE/rmap walking).
> 
> II. Design
> 
> With vswap, pages are assigned virtual swap entries on a ghost device
> with no backing storage. These entries are backed by zswap, zero pages,
> or (lazily) physical swap slots. Physical backing is allocated only
> when needed — on zswap writeback or reclaim writeout, after the rmap
> step.
> 
> Compared to the standalone v6 implementation [1], which introduces a
> 24-byte per-entry swap descriptor and its own cluster allocator, this
> edition uses swap_table infrastructure, and share a lot of the allocator
> logic. Per-slot metadata is stored in a tag-encoded virtual_table
> (atomic_long_t, 8 bytes per slot), and physical clusters store
> Pointer-tagged rmap entries in the swap_table for reverse lookup back to
> the virtual cluster.
> 
> Here are some data layout diagrams:
> 
>   Case 1: vswap entry (virtualized)
> 
>   PTE                  swap_cluster_info_dynamic
>   vswap_entry          +-------------------------+
>   (swp_entry_t) ------>| swap_cluster_info (ci)  |
>                        | +--------------------+  |
>                        | | swap_table         |  |
>                        | |   PFN / Shadow     |  |
>                        | | memcg_table        |  |
>                        | | count,flags,order  |  |
>                        | | lock, list         |  |
>                        | +--------------------+  |
>                        |                         |
>                        | virtual_table           |
>                        | +--------------------+  |
>                        | | NONE               |  |
>                        | | PHYS               |  |
>                        | | ZERO               |  |
>                        | | ZSWAP(entry*)      |  |
>                        | | FOLIO(folio*)      |  |
>                        | +--------------------+  |
>                        +-------------------------+
>                               |
>                               | PHYS resolves to
>                               v
>                        PHYSICAL CLUSTER (swap_cluster_info)
>                        +--------------------------+
>                        | swap_table per-slot:     |
>                        |   NULL   - free          |
>                        |   PFN    - cached folio  |
>                        |   Shadow - swapped out   |
>                        |   Pointer- vswap rmap    |
>                        |   Bad    - unusable      |
>                        |                          |
>                        | Vswap-backing slot:      |
>                        |   Pointer(C|swp_entry_t) |
>                        |     rmap back to vswap   |
>                        +--------------------------+
> 
>   Case 2: direct-mapped physical entry (no vswap)
> 
>   PTE                  PHYSICAL CLUSTER (swap_cluster_info)
>   phys_entry           +--------------------------+
>   (swp_entry_t) ------>| swap_table per-slot:     |
>                        |   NULL   - free          |
>                        |   PFN    - cached folio  |
>                        |   Shadow - swapped out   |
>                        |   Bad    - unusable      |
>                        +--------------------------+
> 
> struct swap_cluster_info_dynamic {
>     struct swap_cluster_info ci;       /* swap_table, lock, etc. */
>     unsigned int index;                /* position in xarray */
>     struct rcu_head rcu;               /* kfree_rcu deferred free */
>     atomic_long_t *virtual_table;      /* backend info, 8 B/slot */
> };
> 
> Each vswap cluster (swap_cluster_info_dynamic) extends the classic
> swap_cluster_info struct with a virtual_table array that stores the
> backend information for each virtual swap entry in the cluster. Each
> entry is tag-encoded in the low 3 bits to indicate backend types:
> 
>   NONE:   |----- 0000 ------|000|  free / unbacked
>   PHYS:   |-- (type:5,off:N)|001|  on a physical swapfile (shifted)
>   ZERO:   |----- 0000 ------|010|  zero-filled page
>   ZSWAP:  |--- zswap_entry* |011|  compressed in zswap
>   FOLIO:  |--- folio* ------|100|  in-memory folio

Thanks for trying this approach!

For the format part, PHYS don't need that much bits I think,
so by slightly adjust the format vswap device could be share
mostly the same format with ordinary device.

For example typical modern system don't have a address space larger
than 52 bit. (Even with full 64 bits used for addressing, shift it
by 12 we get 52). Plus 5 for type, you get 57, so you can have a
marker that should work as long as it shorter than 1000000 for PHYS,
and shared for all table format since it's not in conflict with
anything. You have also use a few extra bits so a single swap space
can be 8 times larger than RAM space, and since we can help
multiple swap type I think that should be far than enough?

Then you have Shadow back at 001, and zero bit in shadow. The only
special one is Zswap, which will be 100 now, and that's exactly the
reserved pointer format in current swap table format, on seeing
si->flags & VSWAP && is_pointer(swp_tb) you know that's zswap :)

Folio / PFN can still be 010 as in the current swap table format.

Then everything seems clean and aligned, no more special handling
for vswap needed, there are detailed to sort out, but it should work.

> - Pointer-tagged swap_table on physical clusters for rmap (physical
>   -> virtual) lookup.

Or reuse the PHYS format (rename it maybe) since point back to vswap
is also pointing to a si.

> III. Follow-ups:
> 
> In no particular order (and most of which can be done as follow-up
> patch series rather than shoving everything in the initial landing):
> 
> - More thorough stress testing is very much needed.
> 
> - Performance benchmarks to make sure I don't accidentally regress
>   the vswap-less case, and that the vswap's case performance is
>   good. I suspect I will have to port a lot of the
>   optimizations I implemented in v6 over here - some of the
>   inefficiencies are inherent in any swap virtualization, and
>   would require the same fix (for e.g the MRU cluster caching
>   for faster cluster lookup - see [8] and [9]).

This could be imporved by per-si percpu cluster. Both YoungJun's
tiering and Baoquan's previous swap ops mentioned this is needed,
and now vswap also need that. If the vswap is also a si, then it will
make use of this too.

YoungJun posted this a few month before:
https://lore.kernel.org/linux-mm/20260131125454.3187546-5-youngjun.park@lge.com/

The concern is that some locking contention could be heavier, or maybe
that's just a hypothetical problem though.

> 
> - Runtime enable/disable of the vswap device. To be honest, I don't
>   know if there is a value in this. My preference is vswap can be
>   optimized to the point that any overhead is negligible. Failing that,
>   maybe we can come up with some simple heuristics that automatically
>   decides for users?
> 
>   In this RFC, CONFIG_VSWAP=y means the vswap device is always created at
>   boot, and CONFIG_VSWAP=n means the vswap device is never created. This
>   *might* be enough just on its own.
> 
>   Is a runtime knob (sysfs or sysctl) worth the complexity beyond
>   these heuristics? I'm not sure yet. Maintaining both cases

I checked the code and I think it's not hard to do, patch 1 already
handling the meta data dynamically, everything will still just work
even if you remove vswap at runtime. The rest of patches need adaption
but might not end up being complex, it other comments here
are considered.

For patch 2, a few routines like vswap_can_swapin_thp seems not
needed or should be moved to __swap_cache_alloc? VSWAP_FOLIO is
same as swap cache folio check, which is already covered. Same for
zero checking, and VSWAP_NONE which is same as swap count check
I think. That way we not only save a lot of code, we also no
longer need to treat vswap specially.

If you keep the format compatible with what we already have
as the earlier comment mentions, a large portion of this part
might be unneeded.

>   at runtime also has overhead for checking as well, and some of the
>   checks are not cheap :)

I also noticed the new introduced swap_read_folio_phys in patch 3, so
this actually can be done using Baoquan's swapops idea which is now
part of Christoph's swap batching:

https://lore.kernel.org/linux-mm/20260528124559.2566481-9-hch@lst.de/#r

That series is focusing on batching and better performance but swapops
was also proposed as a way to solve the virtual layer, makes it possible
to have vswap as one kind of swapops which is Chris talked a lot about:

https://lore.kernel.org/linux-mm/aZiFvzlBJiYBUDre@MiWiFi-R3L-srv/

Following this, we could have something like:

const struct swap_ops swap_vswap_ops = {
	.submit_write		= swap_vswap_submit_write,
	.submit_read		= swap_vswap_submit_read,
};

The move the folio_realloc_swap in swap_vswap_submit_write.

Merge of IO might be moved to lower phyiscal level for vswap.

Another gain is that the memory usage and CPU overhead will be
lower with only one layer. As I'm recently trying to offload swap
dataplane off CPU so the CPU won't touch the data at all, the
overhead will be purely by swap itself, plus some mm overhead.
Things like that and IO optimization above and could make swap
subsystem more and more performance sensitive so we have cases
that needs only one layer.

> 
> - Defer per-cluster memcg_table and zeromap allocation on physical
>   clusters. A physical swap cluster backing vswap entries only do
>   not really need their memcg_table, but the current design forces
>   us to allocate it anyway. This is a waste of memory, and is an
>   overhead regression compared to my older design on the zswap-only
>   case, which Johannes has pointed out multiple times (see [6]),
>   and is one of the biggest reasons why I have not been satisfied
>   with this approach thus far. It honestly is a bit of a
>   deal-breaker...
> 
>   That said, I think I might be able to allocate them on demand, i.e
>   only when the first direct-mapped slot is allocated on that cluster.
>   That will give us the best of BOTH worlds, for both the vswap and
>   directly-mapped physical swap cases. No promises, but I will try
>   (if this approach is good enough for all parties).

Zero map is not really a problem when it's just a inlined bit I think.
For memcg table allocation, on demand seems a good idea, and actually
we are not far from there, I tried to generalize the
alloc-then-retry-sleep-alloc in swap_alloc_table but still not generic
enough I guess.. Good new is the allocation of the table is already
kind of ondemand, just need to split the detection of these two kind
of table.

Mean while I also remember we once discussed about splitting the
accounting for vswap / physical swap? If we went that approach we
don't need to treat memcg_table specially.

> - Widen swap_info_struct->max to unsigned long. The vswap device's
>   max is currently clamped to ALIGN_DOWN(UINT_MAX, SWAPFILE_CLUSTER)
>   (~16 TiB) to fit in unsigned int. 16 TiB is small for vswap,
>   especially when we're getting increasingly big machines memory-wise.

This should be very easy to do, just replace unsigned int with
unsigned long, a lot of place to touch though :)

