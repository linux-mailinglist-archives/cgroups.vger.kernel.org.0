Return-Path: <cgroups+bounces-16382-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKwNAO3pF2osVQgAu9opvQ
	(envelope-from <cgroups+bounces-16382-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 09:08:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F15725ED80B
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 09:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F02533038DA6
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 07:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9A333ADB0;
	Thu, 28 May 2026 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsU8QIVn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E5833123F;
	Thu, 28 May 2026 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952103; cv=none; b=A96fDPJBifSS2PzgnHYjqU730OccEbdgaFihWDhobaS7B/gnzXUyfx7Szc/ZaYTjQVSRPs7GxBZgavYsAOeImTdiR+4ycrH39UL3cPHCkbYajBk+aPPbh6He5gfIUQzoZmFGLfTQbShC2LBGDQ+J/mBH8bEYTQ23aQEMve3gITE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952103; c=relaxed/simple;
	bh=iXHxLWW13XCjsH7LPepQwDPpFeFrLz3Usc4Xb2tuYEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCGHfAVN1oVD0Hmk7O9XJV2NoL8SD/I3y87haddDPn4TvZ2snF1z0RcvRGxyyDvI/rd9YWWgqMYHn3B7Q5irHs707CU3WyiJiMOKVsUHZ9TXk0A3aGGysRoCSdANnwOcNA2zTYUlo7B5uA6lm5php2Cq38suEvEk4cvzSQcm/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsU8QIVn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8FB1F000E9;
	Thu, 28 May 2026 07:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952102;
	bh=2clXgxZ7c/pvTfwrBOL3xWfVe49AoMGW0QPsabdY69E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nsU8QIVnzMzyn+e5flwiiHA/nxMSp4B2s5E4s8GCGm9FdqniH/FM2BJVo3BCL7E9H
	 WiczwUgsMG+N40nxLMQfi/hQDfg9FLex9EpkdbyGdeoKHJ1irUaWlj50wNHxxyOjUH
	 eL34XxZW0yowXuinlK4+p2rd1DzgRWxhhNk3Rk+Lxo5foLNd448BKiT8Z+qj4dCgrv
	 ughS2fH+WCB5KapD2thqP/ppjXCPcjt35qn3hOZgKQHnfeuE2kZbp4mrZnXl/40B9M
	 Imq9Z/rPiBimvN6/jy+Yg4A2EGv//iaJ5HXbdGcCSe+qLAbaMsx+Ff5G7+FZnQmnBI
	 aPPm/WjSkNmGA==
From: SeongJae Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Zi Yan <ziy@nvidia.com>,
	"Liam R . Howlett" <liam@infradead.org>,
	Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Kairui Song <ryncsn@gmail.com>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 9/9] mm: switch deferred split shrinker to list_lru
Date: Thu, 28 May 2026 00:08:05 -0700
Message-ID: <20260528070807.144064-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527204757.2544958-10-hannes@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16382-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,linux.dev,fromorbit.com,nvidia.com,infradead.org,gmail.com,linux.ibm.com,linux.alibaba.com,arm.com,redhat.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F15725ED80B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Johannes,

On Wed, 27 May 2026 16:45:16 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> The deferred split queue handles cgroups in a suboptimal fashion. The
> queue is per-NUMA node or per-cgroup, not the intersection. That means
> on a cgrouped system, a node-restricted allocation entering reclaim
> can end up splitting large pages on other nodes:
> 
>         alloc/unmap
>           deferred_split_folio()
>             list_add_tail(memcg->split_queue)
>             set_shrinker_bit(memcg, node, deferred_shrinker_id)
> 
>         for_each_zone_zonelist_nodemask(restricted_nodes)
>           mem_cgroup_iter()
>             shrink_slab(node, memcg)
>               shrink_slab_memcg(node, memcg)
>                 if test_shrinker_bit(memcg, node, deferred_shrinker_id)
>                   deferred_split_scan()
>                     walks memcg->split_queue
> 
> The shrinker bit adds an imperfect guard rail. As soon as the cgroup
> has a single large page on the node of interest, all large pages owned
> by that memcg, including those on other nodes, will be split.
> 
> list_lru properly sets up per-node, per-cgroup lists. As a bonus, it
> streamlines a lot of the list operations and reclaim walks. It's used
> widely by other major shrinkers already. Convert the deferred split
> queue as well.
> 
> The list_lru per-memcg heads are instantiated on demand when the first
> object of interest is allocated for a cgroup, by calling
> folio_memcg_alloc_deferred(). Add calls to where splittable pages are
> created: anon faults, swapin faults, khugepaged collapse.
> 
> These calls create all possible node heads for the cgroup at once, so
> the migration code (between nodes) doesn't need any special care.
> 
> Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/huge_mm.h    |   7 +-
>  include/linux/memcontrol.h |   4 -
>  include/linux/mmzone.h     |  12 --
>  mm/huge_memory.c           | 364 +++++++++++++------------------------
>  mm/internal.h              |   2 +-
>  mm/khugepaged.c            |   5 +
>  mm/memcontrol.c            |  12 +-
>  mm/memory.c                |   4 +
>  mm/mm_init.c               |  15 --
>  mm/swap_state.c            |  10 +
>  10 files changed, 150 insertions(+), 285 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index edece3e26985..f6c2531a27a3 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -423,10 +423,10 @@ static inline int split_huge_page(struct page *page)
>  {
>  	return split_huge_page_to_list_to_order(page, NULL, 0);
>  }
> +
> +int folio_memcg_alloc_deferred(struct folio *folio);
> +
>  void deferred_split_folio(struct folio *folio, bool partially_mapped);
> -#ifdef CONFIG_MEMCG
> -void reparent_deferred_split_queue(struct mem_cgroup *memcg);
> -#endif
>  
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze);
> @@ -664,7 +664,6 @@ static inline int folio_split(struct folio *folio, unsigned int new_order,
>  }
>  
>  static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
> -static inline void reparent_deferred_split_queue(struct mem_cgroup *memcg) {}
>  #define split_huge_pmd(__vma, __pmd, __address)	\
>  	do { } while (0)

I found this patch is now in mm-new and it makes UM mode kunit fails like
below.

    $ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/
    [00:00:02] Configuring KUnit Kernel ...
    [00:00:02] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=.kunit olddefconfig
    Building with:
    $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=8
    ERROR:root:../mm/swap_state.c: In function ‘__swap_cache_alloc’:
    ../mm/swap_state.c:468:26: error: implicit declaration of function ‘folio_memcg_alloc_deferred’ [-Wimplicit-function-declaration]
      468 |         if (order > 1 && folio_memcg_alloc_deferred(folio)) {
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [../scripts/Makefile.build:289: mm/swap_state.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
    make[3]: *** [../scripts/Makefile.build:548: mm] Error 2
    make[3]: *** Waiting for unfinished jobs....
    make[2]: *** [/home/lkhack/linux/Makefile:2143: .] Error 2
    make[1]: *** [/home/lkhack/linux/Makefile:248: __sub-make] Error 2
    make: *** [Makefile:248: __sub-make] Error 2

Maybe we can define the function for CONFIG_TRANSPARENT_HUGEPAGE unset case?  I
confirmed the below attaching temporal fix works for at least kunit.


Thanks,
SJ

[...]
=== >8 ===
From 23b5800dd49085707baee5774b74782c3e424f24 Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 27 May 2026 23:58:07 -0700
Subject: [PATCH] mm/huge_mm: define memcg_alloc_deferred() for
 !CONFIG_TRANSPARENT_HUGEPPAGE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Without this, UM mode kunit fails like below.

    $ ./tools/testing/kunit/kunit.py run --kunitconfig mm/damon/tests/
    [00:00:02] Configuring KUnit Kernel ...
    [00:00:02] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=.kunit olddefconfig
    Building with:
    $ make all compile_commands.json scripts_gdb ARCH=um O=.kunit --jobs=8
    ERROR:root:../mm/swap_state.c: In function ‘__swap_cache_alloc’:
    ../mm/swap_state.c:468:26: error: implicit declaration of function ‘folio_memcg_alloc_deferred’ [-Wimplicit-function-declaration]
      468 |         if (order > 1 && folio_memcg_alloc_deferred(folio)) {
          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
    make[4]: *** [../scripts/Makefile.build:289: mm/swap_state.o] Error 1
    make[4]: *** Waiting for unfinished jobs....
    make[3]: *** [../scripts/Makefile.build:548: mm] Error 2
    make[3]: *** Waiting for unfinished jobs....
    make[2]: *** [/home/lkhack/linux/Makefile:2143: .] Error 2
    make[1]: *** [/home/lkhack/linux/Makefile:248: __sub-make] Error 2
    make: *** [Makefile:248: __sub-make] Error 2

Fix by implementing the function for CONFIG_TRANSPARENT_HUGEPPAGE unset
case.

Fixes: https://lore.kernel.org/20260527204757.2544958-10-hannes@cmpxchg.org
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/huge_mm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f6c2531a27a35..055de7b8ed487 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -663,6 +663,11 @@ static inline int folio_split(struct folio *folio, unsigned int new_order,
 	return -EINVAL;
 }
 
+static inline int folio_memcg_alloc_deferred(struct folio *folio)
+{
+	return 0;
+}
+
 static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
-- 
2.47.3



