Return-Path: <cgroups+bounces-15763-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO1TAwoRAmqIngEAu9opvQ
	(envelope-from <cgroups+bounces-15763-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:25:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE43513617
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7996232B615B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 16:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B14643DA39;
	Mon, 11 May 2026 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1y9j09i"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D4E43D51D
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 16:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517017; cv=none; b=i+6SkbXVTEJV/PSQYx1ritkL+8v5nt3GeizbBsXpMPrnh7s8N4bDGhXqm25ElUh8ASmxDXdY+nDhmAuux0bPmLTOHX+brtfl6SNyp53AW9c5hCnc0tlJGI0UIL5Robahcr5SjMMcV0xZfdZK/5CGb8t/Hc2KfAfnAj1W5wJNthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517017; c=relaxed/simple;
	bh=NK+z4gRjbF45r5Dtfb20Lc9nuMv3b4YGkpxURINlBxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDKRfg9jvjKSF057qDUNpzzlKQGab2ovkLAjbMlt0+opgk4stAwAR4JMb1LfcKXLoGkGhGmvAYsRe3RSJ6QG9YDESmi13DaksMwQFRhxjzw/8LQoZsCmbEtr9nEYcdsD0aZ4kHnG9If/0oCWVaR8b6VwUjvIZXTDrU9qWegnKiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1y9j09i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3CFC4AF10
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778517017;
	bh=NK+z4gRjbF45r5Dtfb20Lc9nuMv3b4YGkpxURINlBxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y1y9j09iO53IBTu/UjVzIkXsz+DMECpyxpATo+a0SlFQJGOymXyh3CWdJ05aMUBdq
	 GeOkTwsYSPkF5KiP1xP4WlKeMl4d/b5CxDom7Q1dh/oo5UrHz6gK8AMLPEf5wRkWBe
	 1eeS1zs8h22YfZd4DDZi68WO0dfu0EyO9ZCQzdVQ90+gNymTntqI+rY7VwayGyJIPs
	 K0quDPz22kgasA2YZDAugWCphqSKt679BXPtSIqIkNvPIsEJBJtyfdBI9RUUTYz9Q0
	 7GeHkfqSoa5VUaUdJI4HzPxn6DXkBde+d4LY0xdXIkC8XXqXdbh/an2bdpnmV8Ih06
	 LqMFas/DNG5/Q==
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65c52bb5dd7so4292174d50.2
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 09:30:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/fEa7hk58bTh/3RTOkYPqMCt7Wh1JKThm667XPZiDfiWrGLZM9GATFsZqqfl/DP80NTLnyKBkK@vger.kernel.org
X-Gm-Message-State: AOJu0YxzY2qsvt99um3M6W5hBPCmVcYP22Skp8NzHHUxi/zYED6qt1Nl
	h8ff6Ik2lVJJrUW/Y5KEHD+GRfjlJcBVdX9NnOuIb/KLIYKjtKsVkH6Sh6BN1yC+twv40Z/whC1
	f4iqPQlQPQVjhglu5Lq51xa4HIIrpF72riUn/GznnsA==
X-Received: by 2002:a05:690e:168c:b0:65d:8f98:6b24 with SMTP id
 956f58d0204a3-65da84c478dmr8764418d50.26.1778517016312; Mon, 11 May 2026
 09:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-12-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-12-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 11 May 2026 18:30:04 +0200
X-Gmail-Original-Message-ID: <CACePvbUSqkw+5MFFfvwWe9RUs4xUuAzzEkBYOcQ4eB6e7kNonQ@mail.gmail.com>
X-Gm-Features: AVHnY4ItTvMNQ-wLc8fKnvIXajfv8TzAxNB_HrorOWSj82K9eYJzAU4hoR1V424
Message-ID: <CACePvbUSqkw+5MFFfvwWe9RUs4xUuAzzEkBYOcQ4eB6e7kNonQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] mm, swap: merge zeromap into swap table
To: kasong@tencent.com
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5FE43513617
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15763-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

)

On Tue, Apr 21, 2026 at 8:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> By allocating one additional bit in the swap table entry's flags field
> alongside the count, we can store the zeromap inline
>
> For certain 32-bit archs, there might not be enough bits in the swap
> table to contain both PFN and flags. Therefore, conditionally let each
> cluster have a zeromap field at build time, and use that instead of the
> swap table for these archs. A few macros were moved to different headers
> for build time struct definition.

It might be worthwhile to mention the user-visible impact. For 64 bit
systems. The zeromap will store in the swap table, avoiding zeromap
allocation. It reduces the allocated memory. That is the happy path.
For certain 32-bit architectures, if the swapfile cluster is not fully
used, it will use less memory for zeromap. The empty cluster does not
allocate a zeromap. We still save memory. In the worst case, all
cluster are fully populated. We will use memory similar to the
previous zeromap implementation.

>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Chris Li <chrisl@kernel.org>

> ---
>  include/linux/swap.h |   1 -
>  mm/memory.c          |  11 +----
>  mm/page_io.c         |  58 ++++++++++++++++++++++----
>  mm/swap.h            |  51 +++++++++--------------
>  mm/swap_state.c      |  14 ++++---
>  mm/swap_table.h      | 115 +++++++++++++++++++++++++++++++++++++--------=
------
>  mm/swapfile.c        |  45 +++++++++-----------
>  7 files changed, 184 insertions(+), 111 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 57af4647d432..8f0f68e245ba 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -253,7 +253,6 @@ struct swap_info_struct {
>         struct plist_node list;         /* entry in swap_active_head */
>         signed char     type;           /* strange name for an index */
>         unsigned int    max;            /* size of this swap device */
> -       unsigned long *zeromap;         /* kvmalloc'ed bitmap to track ze=
ro pages */

Nice.


>         struct swap_cluster_info *cluster_info; /* cluster info. Only for=
 SSD */
>         struct list_head free_clusters; /* free clusters list */
>         struct list_head full_clusters; /* full clusters list */
> diff --git a/mm/memory.c b/mm/memory.c
> index 404734a5bcff..a45905f8728f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4595,13 +4595,11 @@ static vm_fault_t handle_pte_marker(struct vm_fau=
lt *vmf)
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  /*
> - * Check if the PTEs within a range are contiguous swap entries
> - * and have consistent swapcache, zeromap.
> + * Check if the PTEs within a range are contiguous swap entries.
>   */
>  static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pag=
es)
>  {
>         unsigned long addr;
> -       softleaf_t entry;
>         int idx;
>         pte_t pte;
>
> @@ -4611,18 +4609,13 @@ static bool can_swapin_thp(struct vm_fault *vmf, =
pte_t *ptep, int nr_pages)
>
>         if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
>                 return false;
> -       entry =3D softleaf_from_pte(pte);
> -       if (swap_pte_batch(ptep, nr_pages, pte) !=3D nr_pages)
> -               return false;
> -
>         /*
>          * swap_read_folio() can't handle the case a large folio is hybri=
dly
>          * from different backends. And they are likely corner cases. Sim=
ilar
>          * things might be added once zswap support large folios.
>          */
> -       if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) !=3D nr_pa=
ges))
> +       if (swap_pte_batch(ptep, nr_pages, pte) !=3D nr_pages)
>                 return false;
> -
>         return true;
>  }
>
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 70cea9e24d2f..c2557e72c381 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -26,6 +26,7 @@
>  #include <linux/delayacct.h>
>  #include <linux/zswap.h>
>  #include "swap.h"
> +#include "swap_table.h"
>
>  static void __end_swap_bio_write(struct bio *bio)
>  {
> @@ -204,15 +205,20 @@ static bool is_folio_zero_filled(struct folio *foli=
o)
>  static void swap_zeromap_folio_set(struct folio *folio)
>  {
>         struct obj_cgroup *objcg =3D get_obj_cgroup_from_folio(folio);
> -       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
>         int nr_pages =3D folio_nr_pages(folio);
> +       struct swap_cluster_info *ci;
>         swp_entry_t entry;
>         unsigned int i;
>
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +
> +       ci =3D swap_cluster_get_and_lock(folio);
>         for (i =3D 0; i < folio_nr_pages(folio); i++) {
>                 entry =3D page_swap_entry(folio_page(folio, i));
> -               set_bit(swp_offset(entry), sis->zeromap);
> +               __swap_table_set_zero(ci, swp_cluster_offset(entry));
>         }
> +       swap_cluster_unlock(ci);
>
>         count_vm_events(SWPOUT_ZERO, nr_pages);
>         if (objcg) {
> @@ -223,14 +229,19 @@ static void swap_zeromap_folio_set(struct folio *fo=
lio)
>
>  static void swap_zeromap_folio_clear(struct folio *folio)
>  {
> -       struct swap_info_struct *sis =3D __swap_entry_to_info(folio->swap=
);
> +       struct swap_cluster_info *ci;
>         swp_entry_t entry;
>         unsigned int i;
>
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +
> +       ci =3D swap_cluster_get_and_lock(folio);
>         for (i =3D 0; i < folio_nr_pages(folio); i++) {
>                 entry =3D page_swap_entry(folio_page(folio, i));
> -               clear_bit(swp_offset(entry), sis->zeromap);
> +               __swap_table_clear_zero(ci, swp_cluster_offset(entry));
>         }
> +       swap_cluster_unlock(ci);
>  }
>
>  /*
> @@ -255,10 +266,9 @@ int swap_writeout(struct folio *folio, struct swap_i=
ocb **swap_plug)
>         }
>
>         /*
> -        * Use a bitmap (zeromap) to avoid doing IO for zero-filled pages=
.
> -        * The bits in zeromap are protected by the locked swapcache foli=
o
> -        * and atomic updates are used to protect against read-modify-wri=
te
> -        * corruption due to other zero swap entries seeing concurrent up=
dates.
> +        * Use the swap table zero mark to avoid doing IO for zero-filled
> +        * pages. The zero mark is protected by the cluster lock, which i=
s
> +        * acquired internally by swap_zeromap_folio_set/clear.
>          */
>         if (is_folio_zero_filled(folio)) {
>                 swap_zeromap_folio_set(folio);
> @@ -509,16 +519,48 @@ static void sio_read_complete(struct kiocb *iocb, l=
ong ret)
>         mempool_free(sio, sio_pool);
>  }
>
> +/*
> + * Return the count of contiguous swap entries that share the same
> + * zeromap status as the starting entry. If is_zerop is not NULL,
> + * it will return the zeromap status of the starting entry.
> + *
> + * Context: Caller must ensure the cluster containing the entries
> + * that will be checked won't be freed.
> + */
> +static int swap_zeromap_batch(swp_entry_t entry, int max_nr,
> +                             bool *is_zerop)
> +{
> +       bool is_zero;
> +       struct swap_cluster_info *ci =3D __swap_entry_to_cluster(entry);
> +       unsigned int ci_start =3D swp_cluster_offset(entry), ci_off, ci_e=
nd;
> +
> +       ci_off =3D ci_start;
> +       ci_end =3D ci_off + max_nr;

Should we check ci_end less than the cluster's end and complain if not?

It seems using a for loop can be simpler. The loop index serves as a
counter as well.
Totally untested code:

int i;
rcu_read_lock();
is_zero =3D __swap_table_test_zero(ci, ci_start);
for (i =3D1; i < max_nr ; i++)
       if  (is_zero !=3D  __swap_table_test_zero(ci, ci_start + i))
                 break;
rcu_read_unlock();
if (is_zerop)
     *is_zerop =3D is_zero;
return i;

Chris

> +                       break;
> +       rcu_read_lock();
> +       is_zero =3D __swap_table_test_zero(ci, ci_off);
> +       if (is_zerop)
> +               *is_zerop =3D is_zero;
> +       while (++ci_off < ci_end) {
> +               if (is_zero !=3D __swap_table_test_zero(ci, ci_off))
> +                       break;
> +       }
> +       rcu_read_unlock();
> +       return ci_off - ci_start;
> +}
> +
>  static bool swap_read_folio_zeromap(struct folio *folio)
>  {
>         int nr_pages =3D folio_nr_pages(folio);
>         struct obj_cgroup *objcg;
>         bool is_zeromap;
>
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +
>         /*
>          * Swapping in a large folio that is partially in the zeromap is =
not
>          * currently handled. Return true without marking the folio uptod=
ate so
>          * that an IO error is emitted (e.g. do_swap_page() will sigbus).
> +        * Folio lock stabilizes the cluster and map, so the check is saf=
e.
>          */
>         if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
>                         &is_zeromap) !=3D nr_pages))
> diff --git a/mm/swap.h b/mm/swap.h
> index e4ac7dbc1080..025ff4f0b021 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -3,12 +3,29 @@
>  #define _MM_SWAP_H
>
>  #include <linux/atomic.h> /* for atomic_long_t */
> +#include <linux/mm.h> /* for PAGE_SHIFT */
>  struct mempolicy;
>  struct swap_iocb;
>  struct swap_memcg_table;
>
>  extern int page_cluster;
>
> +#if defined(MAX_POSSIBLE_PHYSMEM_BITS)
> +#define SWAP_CACHE_PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
> +#elif defined(MAX_PHYSMEM_BITS)
> +#define SWAP_CACHE_PFN_BITS (MAX_PHYSMEM_BITS - PAGE_SHIFT)
> +#else
> +#define SWAP_CACHE_PFN_BITS (BITS_PER_LONG - PAGE_SHIFT)
> +#endif
> +
> +/* Swap table marker, 0x1 means shadow, 0x2 means PFN (SWP_TB_PFN_MARK) =
*/
> +#define SWAP_CACHE_PFN_MARK_BITS       2
> +/* At least 2 bits are needed to distinguish SWP_TB_COUNT_MAX, 1 and 0 *=
/
> +#define SWAP_COUNT_MIN_BITS            2
> +/* If there are enough bits besides PFN and marker, store zero flag inli=
ne */
> +#define SWAP_TABLE_HAS_ZEROFLAG                ((BITS_PER_LONG - SWAP_CA=
CHE_PFN_MARK_BITS - \
> +                                         SWAP_CACHE_PFN_BITS) > SWAP_COU=
NT_MIN_BITS)
> +
>  #ifdef CONFIG_THP_SWAP
>  #define SWAPFILE_CLUSTER       HPAGE_PMD_NR
>  #define swap_entry_order(order)        (order)
> @@ -41,6 +58,9 @@ struct swap_cluster_info {
>         unsigned int *extend_table;     /* For large swap count, protecte=
d by ci->lock */
>  #ifdef CONFIG_MEMCG
>         struct swap_memcg_table *memcg_table;   /* Swap table entries' cg=
roup record */
> +#endif
> +#if !SWAP_TABLE_HAS_ZEROFLAG
> +       unsigned long *zero_bitmap;
>  #endif
>         struct list_head list;
>  };
> @@ -314,31 +334,6 @@ static inline unsigned int folio_swap_flags(struct f=
olio *folio)
>         return __swap_entry_to_info(folio->swap)->flags;
>  }
>
> -/*
> - * Return the count of contiguous swap entries that share the same
> - * zeromap status as the starting entry. If is_zeromap is not NULL,
> - * it will return the zeromap status of the starting entry.
> - */
> -static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
> -               bool *is_zeromap)
> -{
> -       struct swap_info_struct *sis =3D __swap_entry_to_info(entry);
> -       unsigned long start =3D swp_offset(entry);
> -       unsigned long end =3D start + max_nr;
> -       bool first_bit;
> -
> -       first_bit =3D test_bit(start, sis->zeromap);
> -       if (is_zeromap)
> -               *is_zeromap =3D first_bit;
> -
> -       if (max_nr <=3D 1)
> -               return max_nr;
> -       if (first_bit)
> -               return find_next_zero_bit(sis->zeromap, end, start) - sta=
rt;
> -       else
> -               return find_next_bit(sis->zeromap, end, start) - start;
> -}
> -
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline struct swap_cluster_info *swap_cluster_lock(
> @@ -476,11 +471,5 @@ static inline unsigned int folio_swap_flags(struct f=
olio *folio)
>  {
>         return 0;
>  }
> -
> -static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
> -               bool *has_zeromap)
> -{
> -       return 0;
> -}
>  #endif /* CONFIG_SWAP */
>  #endif /* _MM_SWAP_H */
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 71a3f128fcf0..fa4ef9f4a1d3 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -159,6 +159,7 @@ static int __swap_cache_add_check(struct swap_cluster=
_info *ci,
>  {
>         unsigned int ci_off, ci_end;
>         unsigned long old_tb;
> +       bool is_zero;
>
>         /*
>          * If the target slot is not swapped out, return
> @@ -181,12 +182,14 @@ static int __swap_cache_add_check(struct swap_clust=
er_info *ci,
>         if (nr =3D=3D 1)
>                 return 0;
>
> +       is_zero =3D __swap_table_test_zero(ci, ci_off);
>         ci_off =3D round_down(ci_off, nr);
>         ci_end =3D ci_off + nr;
>         do {
>                 old_tb =3D __swap_table_get(ci, ci_off);
>                 if (unlikely(swp_tb_is_folio(old_tb) ||
>                              !__swp_tb_get_count(old_tb) ||
> +                            is_zero !=3D __swap_table_test_zero(ci, ci_o=
ff) ||
>                              (memcg_id && *memcg_id !=3D __swap_cgroup_ge=
t(ci, ci_off))))
>                         return -EBUSY;
>         } while (++ci_off < ci_end);
> @@ -210,7 +213,7 @@ static void __swap_cache_do_add_folio(struct swap_clu=
ster_info *ci,
>         do {
>                 old_tb =3D __swap_table_get(ci, ci_off);
>                 VM_WARN_ON_ONCE(swp_tb_is_folio(old_tb));
> -               __swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_=
get_count(old_tb)));
> +               __swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_=
get_flags(old_tb)));
>         } while (++ci_off < ci_end);
>
>         folio_ref_add(folio, nr_pages);
> @@ -246,7 +249,6 @@ static void __swap_cache_do_del_folio(struct swap_clu=
ster_info *ci,
>                                       struct folio *folio,
>                                       swp_entry_t entry, void *shadow)
>  {
> -       int count;
>         unsigned long old_tb;
>         struct swap_info_struct *si;
>         unsigned int ci_start, ci_off, ci_end;
> @@ -266,13 +268,13 @@ static void __swap_cache_do_del_folio(struct swap_c=
luster_info *ci,
>                 old_tb =3D __swap_table_get(ci, ci_off);
>                 WARN_ON_ONCE(!swp_tb_is_folio(old_tb) ||
>                              swp_tb_to_folio(old_tb) !=3D folio);
> -               count =3D __swp_tb_get_count(old_tb);
> -               if (count)
> +               if (__swp_tb_get_count(old_tb))
>                         folio_swapped =3D true;
>                 else
>                         need_free =3D true;
>                 /* If shadow is NULL, we set an empty shadow. */
> -               __swap_table_set(ci, ci_off, shadow_to_swp_tb(shadow, cou=
nt));
> +               __swap_table_set(ci, ci_off, shadow_to_swp_tb(shadow,
> +                                __swp_tb_get_flags(old_tb)));
>         } while (++ci_off < ci_end);
>
>         folio->swap.val =3D 0;
> @@ -366,7 +368,7 @@ void __swap_cache_replace_folio(struct swap_cluster_i=
nfo *ci,
>         do {
>                 old_tb =3D __swap_table_get(ci, ci_off);
>                 WARN_ON_ONCE(!swp_tb_is_folio(old_tb) || swp_tb_to_folio(=
old_tb) !=3D old);
> -               __swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_=
get_count(old_tb)));
> +               __swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_=
get_flags(old_tb)));
>         } while (++ci_off < ci_end);
>
>         /*
> diff --git a/mm/swap_table.h b/mm/swap_table.h
> index b2b02ee161b1..6cf1575eb26e 100644
> --- a/mm/swap_table.h
> +++ b/mm/swap_table.h
> @@ -26,12 +26,14 @@ struct swap_memcg_table {
>   * Swap table entry type and bits layouts:
>   *
>   * NULL:     |---------------- 0 ---------------| - Free slot
> - * Shadow:   | SWAP_COUNT |---- SHADOW_VAL ---|1| - Swapped out slot
> - * PFN:      | SWAP_COUNT |------ PFN -------|10| - Cached slot
> + * Shadow:   |SWAP_COUNT|Z|---- SHADOW_VAL ---|1| - Swapped out slot
> + * PFN:      |SWAP_COUNT|Z|------ PFN -------|10| - Cached slot
>   * Pointer:  |----------- Pointer ----------|100| - (Unused)
>   * Bad:      |------------- 1 -------------|1000| - Bad slot
>   *
> - * SWAP_COUNT is `SWP_TB_COUNT_BITS` long, each entry is an atomic long.
> + * COUNT is `SWP_TB_COUNT_BITS` long, Z is the `SWP_TB_ZERO_FLAG` bit,
> + * and together they form the `SWP_TB_FLAGS_BITS` wide flags field.
> + * Each entry is an atomic long.
>   *
>   * Usages:
>   *
> @@ -54,14 +56,6 @@ struct swap_memcg_table {
>   * - Bad: Swap slot is reserved, protects swap header or holes on swap d=
evices.
>   */
>
> -#if defined(MAX_POSSIBLE_PHYSMEM_BITS)
> -#define SWAP_CACHE_PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
> -#elif defined(MAX_PHYSMEM_BITS)
> -#define SWAP_CACHE_PFN_BITS (MAX_PHYSMEM_BITS - PAGE_SHIFT)
> -#else
> -#define SWAP_CACHE_PFN_BITS (BITS_PER_LONG - PAGE_SHIFT)
> -#endif
> -
>  /* NULL Entry, all 0 */
>  #define SWP_TB_NULL            0UL
>
> @@ -69,22 +63,26 @@ struct swap_memcg_table {
>  #define SWP_TB_SHADOW_MARK     0b1UL
>
>  /* Cached: PFN */
> -#define SWP_TB_PFN_BITS                (SWAP_CACHE_PFN_BITS + SWP_TB_PFN=
_MARK_BITS)
> +#define SWP_TB_PFN_BITS                (SWAP_CACHE_PFN_BITS + SWAP_CACHE=
_PFN_MARK_BITS)
>  #define SWP_TB_PFN_MARK                0b10UL
> -#define SWP_TB_PFN_MARK_BITS   2
> -#define SWP_TB_PFN_MARK_MASK   (BIT(SWP_TB_PFN_MARK_BITS) - 1)
> +#define SWP_TB_PFN_MARK_MASK   (BIT(SWAP_CACHE_PFN_MARK_BITS) - 1)
>
> -/* SWAP_COUNT part for PFN or shadow, the width can be shrunk or extende=
d */
> -#define SWP_TB_COUNT_BITS      min(4, BITS_PER_LONG - SWP_TB_PFN_BITS)
> +/* Flags: For PFN or shadow, contains SWAP_COUNT, width changes */
> +#define SWP_TB_FLAGS_BITS      min(5, BITS_PER_LONG - SWP_TB_PFN_BITS)
> +#define SWP_TB_COUNT_BITS      (SWP_TB_FLAGS_BITS - SWAP_TABLE_HAS_ZEROF=
LAG)
> +#define SWP_TB_FLAGS_MASK      (~((~0UL) >> SWP_TB_FLAGS_BITS))
>  #define SWP_TB_COUNT_MASK      (~((~0UL) >> SWP_TB_COUNT_BITS))
> +#define SWP_TB_FLAGS_SHIFT     (BITS_PER_LONG - SWP_TB_FLAGS_BITS)
>  #define SWP_TB_COUNT_SHIFT     (BITS_PER_LONG - SWP_TB_COUNT_BITS)
>  #define SWP_TB_COUNT_MAX       ((1 << SWP_TB_COUNT_BITS) - 1)
> +/* The first flag is zero bit (SWAP_TABLE_HAS_ZEROFLAG) */
> +#define SWP_TB_ZERO_FLAG       BIT(BITS_PER_LONG - SWP_TB_FLAGS_BITS)
>
>  /* Bad slot: ends with 0b1000 and rests of bits are all 1 */
>  #define SWP_TB_BAD             ((~0UL) << 3)
>
>  /* Macro for shadow offset calculation */
> -#define SWAP_COUNT_SHIFT       SWP_TB_COUNT_BITS
> +#define SWAP_COUNT_SHIFT       SWP_TB_FLAGS_BITS
>
>  /*
>   * Helpers for casting one type of info into a swap table entry.
> @@ -102,40 +100,47 @@ static inline unsigned long __count_to_swp_tb(unsig=
ned char count)
>          * used (count > 0 && count < SWP_TB_COUNT_MAX), and
>          * overflow (count =3D=3D SWP_TB_COUNT_MAX).
>          */
> -       BUILD_BUG_ON(SWP_TB_COUNT_MAX < 2 || SWP_TB_COUNT_BITS < 2);
> +       BUILD_BUG_ON(SWP_TB_COUNT_BITS < SWAP_COUNT_MIN_BITS);
>         VM_WARN_ON(count > SWP_TB_COUNT_MAX);
>         return ((unsigned long)count) << SWP_TB_COUNT_SHIFT;
>  }
>
> -static inline unsigned long pfn_to_swp_tb(unsigned long pfn, unsigned in=
t count)
> +static inline unsigned long __flags_to_swp_tb(unsigned char flags)
> +{
> +       BUILD_BUG_ON(SWP_TB_FLAGS_BITS > BITS_PER_BYTE);
> +       VM_WARN_ON(flags >> SWP_TB_FLAGS_BITS);
> +       return ((unsigned long)flags) << SWP_TB_FLAGS_SHIFT;
> +}
> +
> +static inline unsigned long pfn_to_swp_tb(unsigned long pfn, unsigned ch=
ar flags)
>  {
>         unsigned long swp_tb;
>
>         BUILD_BUG_ON(sizeof(unsigned long) !=3D sizeof(void *));
>         BUILD_BUG_ON(SWAP_CACHE_PFN_BITS >
> -                    (BITS_PER_LONG - SWP_TB_PFN_MARK_BITS - SWP_TB_COUNT=
_BITS));
> +                    (BITS_PER_LONG - SWAP_CACHE_PFN_MARK_BITS - SWP_TB_F=
LAGS_BITS));
>
> -       swp_tb =3D (pfn << SWP_TB_PFN_MARK_BITS) | SWP_TB_PFN_MARK;
> -       VM_WARN_ON_ONCE(swp_tb & SWP_TB_COUNT_MASK);
> +       swp_tb =3D (pfn << SWAP_CACHE_PFN_MARK_BITS) | SWP_TB_PFN_MARK;
> +       VM_WARN_ON_ONCE(swp_tb & SWP_TB_FLAGS_MASK);
>
> -       return swp_tb | __count_to_swp_tb(count);
> +       return swp_tb | __flags_to_swp_tb(flags);
>  }
>
> -static inline unsigned long folio_to_swp_tb(struct folio *folio, unsigne=
d int count)
> +static inline unsigned long folio_to_swp_tb(struct folio *folio, unsigne=
d char flags)
>  {
> -       return pfn_to_swp_tb(folio_pfn(folio), count);
> +       return pfn_to_swp_tb(folio_pfn(folio), flags);
>  }
>
> -static inline unsigned long shadow_to_swp_tb(void *shadow, unsigned int =
count)
> +static inline unsigned long shadow_to_swp_tb(void *shadow, unsigned char=
 flags)
>  {
>         BUILD_BUG_ON((BITS_PER_XA_VALUE + 1) !=3D
>                      BITS_PER_BYTE * sizeof(unsigned long));
>         BUILD_BUG_ON((unsigned long)xa_mk_value(0) !=3D SWP_TB_SHADOW_MAR=
K);
>
>         VM_WARN_ON_ONCE(shadow && !xa_is_value(shadow));
> -       VM_WARN_ON_ONCE(shadow && ((unsigned long)shadow & SWP_TB_COUNT_M=
ASK));
> +       VM_WARN_ON_ONCE(shadow && ((unsigned long)shadow & SWP_TB_FLAGS_M=
ASK));
>
> -       return (unsigned long)shadow | __count_to_swp_tb(count) | SWP_TB_=
SHADOW_MARK;
> +       return (unsigned long)shadow | SWP_TB_SHADOW_MARK | __flags_to_sw=
p_tb(flags);
>  }
>
>  /*
> @@ -173,14 +178,14 @@ static inline bool swp_tb_is_countable(unsigned lon=
g swp_tb)
>  static inline struct folio *swp_tb_to_folio(unsigned long swp_tb)
>  {
>         VM_WARN_ON(!swp_tb_is_folio(swp_tb));
> -       return pfn_folio((swp_tb & ~SWP_TB_COUNT_MASK) >> SWP_TB_PFN_MARK=
_BITS);
> +       return pfn_folio((swp_tb & ~SWP_TB_FLAGS_MASK) >> SWAP_CACHE_PFN_=
MARK_BITS);
>  }
>
>  static inline void *swp_tb_to_shadow(unsigned long swp_tb)
>  {
>         VM_WARN_ON(!swp_tb_is_shadow(swp_tb));
>         /* No shift needed, xa_value is stored as it is in the lower bits=
. */
> -       return (void *)(swp_tb & ~SWP_TB_COUNT_MASK);
> +       return (void *)(swp_tb & ~SWP_TB_FLAGS_MASK);
>  }
>
>  static inline unsigned char __swp_tb_get_count(unsigned long swp_tb)
> @@ -189,6 +194,12 @@ static inline unsigned char __swp_tb_get_count(unsig=
ned long swp_tb)
>         return ((swp_tb & SWP_TB_COUNT_MASK) >> SWP_TB_COUNT_SHIFT);
>  }
>
> +static inline unsigned char __swp_tb_get_flags(unsigned long swp_tb)
> +{
> +       VM_WARN_ON(!swp_tb_is_countable(swp_tb));
> +       return ((swp_tb & SWP_TB_FLAGS_MASK) >> SWP_TB_FLAGS_SHIFT);
> +}
> +
>  static inline int swp_tb_get_count(unsigned long swp_tb)
>  {
>         if (swp_tb_is_countable(swp_tb))
> @@ -253,6 +264,50 @@ static inline unsigned long swap_table_get(struct sw=
ap_cluster_info *ci,
>         return swp_tb;
>  }
>
> +static inline void __swap_table_set_zero(struct swap_cluster_info *ci,
> +                                        unsigned int ci_off)
> +{
> +#if SWAP_TABLE_HAS_ZEROFLAG
> +       unsigned long swp_tb =3D __swap_table_get(ci, ci_off);
> +
> +       BUILD_BUG_ON(SWP_TB_ZERO_FLAG & ~SWP_TB_FLAGS_MASK);
> +       VM_WARN_ON(!swp_tb_is_countable(swp_tb));
> +       swp_tb |=3D SWP_TB_ZERO_FLAG;
> +       __swap_table_set(ci, ci_off, swp_tb);
> +#else
> +       __set_bit(ci_off, ci->zero_bitmap);
> +#endif
> +}
> +
> +static inline bool __swap_table_test_zero(struct swap_cluster_info *ci,
> +                                         unsigned int ci_off)
> +{
> +#if SWAP_TABLE_HAS_ZEROFLAG
> +       unsigned long swp_tb =3D __swap_table_get(ci, ci_off);
> +
> +       VM_WARN_ON(!swp_tb_is_countable(swp_tb));
> +       return !!(swp_tb & SWP_TB_ZERO_FLAG);
> +#else
> +       return test_bit(ci_off, ci->zero_bitmap);
> +#endif
> +}
> +
> +static inline void __swap_table_clear_zero(struct swap_cluster_info *ci,
> +                                          unsigned int ci_off)
> +{
> +
> +#if SWAP_TABLE_HAS_ZEROFLAG
> +       unsigned long swp_tb =3D __swap_table_get(ci, ci_off);
> +
> +       VM_WARN_ON(!swp_tb_is_countable(swp_tb));
> +       swp_tb &=3D ~SWP_TB_ZERO_FLAG;
> +       __swap_table_set(ci, ci_off, swp_tb);
> +#else
> +       lockdep_assert_held(&ci->lock);
> +       __clear_bit(ci_off, ci->zero_bitmap);
> +#endif
> +}
> +
>  #ifdef CONFIG_MEMCG
>  static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
>                 unsigned int ci_off, unsigned long nr, unsigned short id)
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2172920e68d1..287d5807b8f7 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -427,6 +427,11 @@ static void swap_cluster_free_table(struct swap_clus=
ter_info *ci)
>         ci->memcg_table =3D NULL;
>  #endif
>
> +#if !SWAP_TABLE_HAS_ZEROFLAG
> +       kfree(ci->zero_bitmap);
> +       ci->zero_bitmap =3D NULL;
> +#endif
> +
>         table =3D (struct swap_table *)rcu_access_pointer(ci->table);
>         if (!table)
>                 return;
> @@ -470,6 +475,13 @@ static int swap_cluster_alloc_table(struct swap_clus=
ter_info *ci, gfp_t gfp)
>         if (!ci->memcg_table)
>                 ret =3D -ENOMEM;
>  #endif
> +
> +#if !SWAP_TABLE_HAS_ZEROFLAG
> +       ci->zero_bitmap =3D bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
> +       if (!ci->zero_bitmap)
> +               ret =3D -ENOMEM;
> +#endif
> +
>         if (ret)
>                 swap_cluster_free_table(ci);
>
> @@ -926,8 +938,8 @@ static bool __swap_cluster_alloc_entries(struct swap_=
info_struct *si,
>                 order =3D 0;
>                 nr_pages =3D 1;
>                 swap_cluster_assert_empty(ci, ci_off, 1, false);
> -               /* Sets a fake shadow as placeholder */
> -               __swap_table_set(ci, ci_off, shadow_to_swp_tb(NULL, 1));
> +               /* Fake shadow placeholder with no flag, hibernation does=
 not use the zeromap */
> +               __swap_table_set(ci, ci_off, __swp_tb_mk_count(shadow_to_=
swp_tb(NULL, 0), 1));
>         } else {
>                 /* Allocation without folio is only possible with hiberna=
tion */
>                 WARN_ON_ONCE(1);
> @@ -1299,14 +1311,8 @@ static void swap_range_free(struct swap_info_struc=
t *si, unsigned long offset,
>         void (*swap_slot_free_notify)(struct block_device *, unsigned lon=
g);
>         unsigned int i;
>
> -       /*
> -        * Use atomic clear_bit operations only on zeromap instead of non=
-atomic
> -        * bitmap_clear to prevent adjacent bits corruption due to simult=
aneous writes.
> -        */
> -       for (i =3D 0; i < nr_entries; i++) {
> -               clear_bit(offset + i, si->zeromap);
> +       for (i =3D 0; i < nr_entries; i++)
>                 zswap_invalidate(swp_entry(si->type, offset + i));
> -       }
>
>         if (si->flags & SWP_BLKDEV)
>                 swap_slot_free_notify =3D
> @@ -1891,7 +1897,11 @@ void __swap_cluster_free_entries(struct swap_info_=
struct *si,
>                  * ref, or after swap cache is dropped
>                  */
>                 VM_WARN_ON(!swp_tb_is_shadow(old_tb) || __swp_tb_get_coun=
t(old_tb) > 1);
> +
> +               /* Resetting the slot to NULL also clears the inline flag=
s. */
>                 __swap_table_set(ci, ci_off, null_to_swp_tb());
> +               if (!SWAP_TABLE_HAS_ZEROFLAG)
> +                       __swap_table_clear_zero(ci, ci_off);
>
>                 /*
>                  * Uncharge swap slots by memcg in batches. Consecutive
> @@ -3024,7 +3034,6 @@ static void flush_percpu_swap_cluster(struct swap_i=
nfo_struct *si)
>  SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  {
>         struct swap_info_struct *p =3D NULL;
> -       unsigned long *zeromap;
>         struct swap_cluster_info *cluster_info;
>         struct file *swap_file, *victim;
>         struct address_space *mapping;
> @@ -3120,8 +3129,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>
>         swap_file =3D p->swap_file;
>         p->swap_file =3D NULL;
> -       zeromap =3D p->zeromap;
> -       p->zeromap =3D NULL;
>         maxpages =3D p->max;
>         cluster_info =3D p->cluster_info;
>         p->max =3D 0;
> @@ -3133,7 +3140,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         mutex_unlock(&swapon_mutex);
>         kfree(p->global_cluster);
>         p->global_cluster =3D NULL;
> -       kvfree(zeromap);
>         free_swap_cluster_info(cluster_info, maxpages);
>
>         inode =3D mapping->host;
> @@ -3665,17 +3671,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, speci=
alfile, int, swap_flags)
>         if (error)
>                 goto bad_swap_unlock_inode;
>
> -       /*
> -        * Use kvmalloc_array instead of bitmap_zalloc as the allocation =
order might
> -        * be above MAX_PAGE_ORDER incase of a large swap file.
> -        */
> -       si->zeromap =3D kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(lo=
ng),
> -                                    GFP_KERNEL | __GFP_ZERO);
> -       if (!si->zeromap) {
> -               error =3D -ENOMEM;
> -               goto bad_swap_unlock_inode;
> -       }
> -
>         if (si->bdev && bdev_stable_writes(si->bdev))
>                 si->flags |=3D SWP_STABLE_WRITES;
>
> @@ -3777,8 +3772,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>         destroy_swap_extents(si, swap_file);
>         free_swap_cluster_info(si->cluster_info, si->max);
>         si->cluster_info =3D NULL;
> -       kvfree(si->zeromap);
> -       si->zeromap =3D NULL;
>         /*
>          * Clear the SWP_USED flag after all resources are freed so
>          * alloc_swap_info can reuse this si safely.
>
> --
> 2.53.0
>
>

