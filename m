Return-Path: <cgroups+bounces-15684-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 63kIEshn/mmIqQAAu9opvQ
	(envelope-from <cgroups+bounces-15684-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 00:46:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9ED4FC732
	for <lists+cgroups@lfdr.de>; Sat, 09 May 2026 00:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 038103015D13
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A80377EDD;
	Fri,  8 May 2026 22:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0w6F9Li"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA07F2D8376
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280386; cv=none; b=GBgfOwixGxgjOpg6wt9kJV9u6gUGtg/xMi89lNTy2wr5fYFE1mmxU3xEAqkRbAYg79/KFLbMFyIjHY4uugV1G4GUhUEcDj9+zn/hvfmc3Nr3nMfIElcInOsuagopwK5d6SEZQ6Qo5CC5z5kJdwH6qT+bPSAmfzpPKV1diPLRJwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280386; c=relaxed/simple;
	bh=n9nAKeIL1dTTYel1gpomJc263KMqVzhUIP6B8R4y15o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKvb6YcEKA9yZ1ES9sucRPy5CBLPc0QgX4Aj7vFhMGftVKwtMrJccENgkBLzyJumeOG5KhRQ53obHV78bxCbYQbnwCBQ0Nk4gi7J9gYSci03ovQcWVXKvfH0lZBSRFNw7l6IpH1wv+hrJozKObX221vdnX0deVlW7m1Ihl7Th9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0w6F9Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9F2C2BCF7
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 22:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280386;
	bh=n9nAKeIL1dTTYel1gpomJc263KMqVzhUIP6B8R4y15o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=K0w6F9LiwVxv5jt/3QFKmZtnt19uWbs0qD6+2vmmZkUBArH/M1kvOxJ4MLP2qVexO
	 WXUPLGmB9x/HZKjfAaqqparlniSWVnfQNR9HOQBlHLM7ehT/ZVqxECIjMuFC9M0j92
	 sMuh2xEKVfziwXX6Ax85XgqzAlr7GFr/vcuSfcNNMJDfyqyFtooshMvYG6ru3xhnbc
	 /OcBAu263QfhTZ1Jdh54aC3T+Yhg4hgiQ41GJEM6l0zHUcv4MjuHca/YPx+UxV0TxD
	 hmwrVOYhGIT7aA0Z07DQHIdfq7Kn1txHcTSRZuioTYig0GTBgP2YacBlArG0gH7RHF
	 V+M0GHIhp7gpQ==
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-65c305f381eso2900147d50.3
        for <cgroups@vger.kernel.org>; Fri, 08 May 2026 15:46:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/+mhhYJYpCwajl147Pe1zjO7e/3VeUlf6YgToTs98McGmJUKt5hFCZ10ShkBSmwcahgBrs0BgN@vger.kernel.org
X-Gm-Message-State: AOJu0YwUr9VT2bKDhZIAM5OQKqQOaPxDwnXL5Z7U1qbJS72hXAX0gic2
	l8i9LsqZx6MY4slrTg/S9L8R8zgSrvfl++AfenZnCbMjoDXoqndOsqlp690SHvhp/iCLprQeme5
	z6er7EhMxZuQbjQoXd+G7+1WLwZ9z5aqFhoSev0Wg3Q==
X-Received: by 2002:a05:690e:15cf:b0:64c:f7d0:5c07 with SMTP id
 956f58d0204a3-65c7988c0b2mr10848529d50.10.1778280385105; Fri, 08 May 2026
 15:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-10-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-10-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 9 May 2026 00:46:12 +0200
X-Gmail-Original-Message-ID: <CACePvbXeUv9g+pKW55hrEbwrFZaZ+XdBip9oSwT7pfztrG_7GA@mail.gmail.com>
X-Gm-Features: AVHnY4JgZGuWXY1y5FMpJnPm8h7r9hpVXgl8W-LyfnXHFjHgZepiUybYMGafjl4
Message-ID: <CACePvbXeUv9g+pKW55hrEbwrFZaZ+XdBip9oSwT7pfztrG_7GA@mail.gmail.com>
Subject: Re: [PATCH v3 10/12] mm/memcg, swap: store cgroup id in cluster table directly
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
X-Rspamd-Queue-Id: AB9ED4FC732
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15684-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Apr 21, 2026 at 2:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Drop the usage of the swap_cgroup_ctrl, and use the dynamic cluster
> table instead.

Nice! It takes so many steps to finally drop the static allocated swap
cgroup ctrl array. Thank you for making it happen.

>
> The per-cluster memcg table is 1024 / 512 bytes on most archs, and does
> not need RCU protection: the cgroup data is only read and written under
> the cluster lock. That keeps things simple, lets the allocation use
> plain kmalloc with immediate kfree (no deferred free), and keeps
> fragmentation acceptable.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Overall looks good, with some nitpick and question follows.

Acked-by: Chris Li <chrisl@kernel.org>

> ---
>  include/linux/memcontrol.h |  6 ++++--
>  include/linux/swap.h       |  8 +++----
>  mm/memcontrol-v1.c         | 42 +++++++++++++++++++++++-------------
>  mm/memcontrol.c            | 14 +++++++-----
>  mm/swap.h                  |  4 ++++
>  mm/swap_state.c            |  6 ++----
>  mm/swap_table.h            | 54 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  mm/swapfile.c              | 35 +++++++++++++++++++-----------
>  mm/vmscan.c                |  2 +-
>  9 files changed, 128 insertions(+), 43 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a013f37f24aa..bf1a6e131eca 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -29,6 +29,7 @@ struct obj_cgroup;
>  struct page;
>  struct mm_struct;
>  struct kmem_cache;
> +struct swap_cluster_info;
>
>  /* Cgroup-specific page state, on top of universal node page state */
>  enum memcg_stat_item {
> @@ -1899,7 +1900,7 @@ static inline void mem_cgroup_exit_user_fault(void)
>         current->in_user_fault =3D 0;
>  }
>
> -void __memcg1_swapout(struct folio *folio);
> +void __memcg1_swapout(struct folio *folio, struct swap_cluster_info *ci)=
;
>  void memcg1_swapin(struct folio *folio);
>
>  #else /* CONFIG_MEMCG_V1 */
> @@ -1929,7 +1930,8 @@ static inline void mem_cgroup_exit_user_fault(void)
>  {
>  }
>
> -static inline void __memcg1_swapout(struct folio *folio)
> +static inline void __memcg1_swapout(struct folio *folio,
> +               struct swap_cluster_info *ci)
>  {
>  }
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index f2949f5844a6..57af4647d432 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -582,12 +582,12 @@ static inline int mem_cgroup_try_charge_swap(struct=
 folio *folio)
>         return __mem_cgroup_try_charge_swap(folio);
>  }
>
> -extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int n=
r_pages);
> -static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned =
int nr_pages)
> +extern void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int n=
r_pages);
> +static inline void mem_cgroup_uncharge_swap(unsigned short id, unsigned =
int nr_pages)
>  {
>         if (mem_cgroup_disabled())
>                 return;
> -       __mem_cgroup_uncharge_swap(entry, nr_pages);
> +       __mem_cgroup_uncharge_swap(id, nr_pages);
>  }
>
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
> @@ -598,7 +598,7 @@ static inline int mem_cgroup_try_charge_swap(struct f=
olio *folio)
>         return 0;
>  }
>
> -static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
> +static inline void mem_cgroup_uncharge_swap(unsigned short id,
>                                             unsigned int nr_pages)
>  {
>  }
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 36c507d81dc5..494e7b9adc60 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -14,6 +14,7 @@
>
>  #include "internal.h"
>  #include "swap.h"
> +#include "swap_table.h"
>  #include "memcontrol-v1.h"
>
>  /*
> @@ -606,14 +607,15 @@ void memcg1_commit_charge(struct folio *folio, stru=
ct mem_cgroup *memcg)
>  /**
>   * __memcg1_swapout - transfer a memsw charge to swap
>   * @folio: folio whose memsw charge to transfer
> + * @ci: the locked swap cluster holding the swap entries
>   *
>   * Transfer the memsw charge of @folio to the swap entry stored in
>   * folio->swap.
>   *
> - * Context: folio must be isolated, unmapped, locked and is just about
> - * to be freed, and caller must disable IRQs.
> + * Context: folio must be isolated, unmapped, locked and is just about t=
o
> + * be freed, and caller must disable IRQs and hold the swap cluster lock=
.
>   */
> -void __memcg1_swapout(struct folio *folio)
> +void __memcg1_swapout(struct folio *folio, struct swap_cluster_info *ci)
>  {
>         struct mem_cgroup *memcg, *swap_memcg;
>         struct obj_cgroup *objcg;
> @@ -646,7 +648,8 @@ void __memcg1_swapout(struct folio *folio)
>         swap_memcg =3D mem_cgroup_private_id_get_online(memcg, nr_entries=
);
>         mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
>
> -       swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), foli=
o->swap);
> +       __swap_cgroup_set(ci, swp_cluster_offset(folio->swap), nr_entries=
,
> +                         mem_cgroup_private_id(swap_memcg));
>
>         folio_unqueue_deferred_split(folio);
>         folio->memcg_data =3D 0;
> @@ -661,8 +664,7 @@ void __memcg1_swapout(struct folio *folio)
>         }
>
>         /*
> -        * Interrupts should be disabled here because the caller holds th=
e
> -        * i_pages lock which is taken with interrupts-off. It is
> +        * The caller must hold the swap cluster lock with IRQ off. It is
>          * important here to have the interrupts disabled because it is t=
he
>          * only synchronisation we have for updating the per-CPU variable=
s.
>          */
> @@ -677,7 +679,7 @@ void __memcg1_swapout(struct folio *folio)
>  }
>
>  /**
> - * memcg1_swapin - uncharge swap slot
> + * memcg1_swapin - uncharge swap slot on swapin
>   * @folio: folio being swapped in
>   *
>   * Call this function after successfully adding the charged
> @@ -687,6 +689,10 @@ void __memcg1_swapout(struct folio *folio)
>   */
>  void memcg1_swapin(struct folio *folio)
>  {
> +       struct swap_cluster_info *ci;
> +       unsigned long nr_pages;
> +       unsigned short id;
> +
>         VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
>         VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>
> @@ -702,14 +708,20 @@ void memcg1_swapin(struct folio *folio)
>          * correspond 1:1 to page and swap slot lifetimes: we charge the
>          * page to memory here, and uncharge swap when the slot is freed.
>          */
> -       if (do_memsw_account()) {
> -               /*
> -                * The swap entry might not get freed for a long time,
> -                * let's not wait for it.  The page already received a
> -                * memory+swap charge, drop the swap entry duplicate.
> -                */
> -               mem_cgroup_uncharge_swap(folio->swap, folio_nr_pages(foli=
o));
> -       }
> +       if (!do_memsw_account())
> +               return;
> +
> +       /*
> +        * The swap entry might not get freed for a long time,
> +        * let's not wait for it.  The page already received a
> +        * memory+swap charge, drop the swap entry duplicate.
> +        */
> +       nr_pages =3D folio_nr_pages(folio);
> +       ci =3D swap_cluster_get_and_lock(folio);
> +       id =3D __swap_cgroup_clear(ci, swp_cluster_offset(folio->swap),
> +                                nr_pages);
> +       swap_cluster_unlock(ci);
> +       mem_cgroup_uncharge_swap(id, nr_pages);
>  }
>
>  void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgo=
ut,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 641706fa47bf..193c8eb73be7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -64,6 +64,8 @@
>  #include <linux/sched/isolation.h>
>  #include <linux/kmemleak.h>
>  #include "internal.h"
> +#include "swap.h"
> +#include "swap_table.h"
>  #include <net/sock.h>
>  #include <net/ip.h>
>  #include "slab.h"
> @@ -5462,6 +5464,7 @@ int __init mem_cgroup_init(void)
>  int __mem_cgroup_try_charge_swap(struct folio *folio)
>  {
>         unsigned int nr_pages =3D folio_nr_pages(folio);
> +       struct swap_cluster_info *ci;
>         struct page_counter *counter;
>         struct mem_cgroup *memcg;
>         struct obj_cgroup *objcg;
> @@ -5495,22 +5498,23 @@ int __mem_cgroup_try_charge_swap(struct folio *fo=
lio)
>         }
>         mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
>
> -       swap_cgroup_record(folio, mem_cgroup_private_id(memcg), folio->sw=
ap);
> +       ci =3D swap_cluster_get_and_lock(folio);
> +       __swap_cgroup_set(ci, swp_cluster_offset(folio->swap), nr_pages,
> +                         mem_cgroup_private_id(memcg));
> +       swap_cluster_unlock(ci);
>
>         return 0;
>  }
>
>  /**
>   * __mem_cgroup_uncharge_swap - uncharge swap space
> - * @entry: swap entry to uncharge
> + * @id: cgroup id to uncharge
>   * @nr_pages: the amount of swap space to uncharge
>   */
> -void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages=
)
> +void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages=
)
>  {
>         struct mem_cgroup *memcg;
> -       unsigned short id;
>
> -       id =3D swap_cgroup_clear(entry, nr_pages);
>         rcu_read_lock();
>         memcg =3D mem_cgroup_from_private_id(id);
>         if (memcg) {
> diff --git a/mm/swap.h b/mm/swap.h
> index 80c2f1bf7a57..e4ac7dbc1080 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -5,6 +5,7 @@
>  #include <linux/atomic.h> /* for atomic_long_t */
>  struct mempolicy;
>  struct swap_iocb;
> +struct swap_memcg_table;
>
>  extern int page_cluster;
>
> @@ -38,6 +39,9 @@ struct swap_cluster_info {
>         u8 order;
>         atomic_long_t __rcu *table;     /* Swap table entries, see mm/swa=
p_table.h */
>         unsigned int *extend_table;     /* For large swap count, protecte=
d by ci->lock */
> +#ifdef CONFIG_MEMCG
> +       struct swap_memcg_table *memcg_table;   /* Swap table entries' cg=
roup record */
> +#endif
>         struct list_head list;
>  };
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 86d517a33a55..71a3f128fcf0 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -176,21 +176,19 @@ static int __swap_cache_add_check(struct swap_clust=
er_info *ci,
>         if (shadowp && swp_tb_is_shadow(old_tb))
>                 *shadowp =3D swp_tb_to_shadow(old_tb);
>         if (memcg_id)
> -               *memcg_id =3D lookup_swap_cgroup_id(targ_entry);
> +               *memcg_id =3D __swap_cgroup_get(ci, ci_off);
>
>         if (nr =3D=3D 1)
>                 return 0;
>
> -       targ_entry.val =3D round_down(targ_entry.val, nr);
>         ci_off =3D round_down(ci_off, nr);
>         ci_end =3D ci_off + nr;
>         do {
>                 old_tb =3D __swap_table_get(ci, ci_off);
>                 if (unlikely(swp_tb_is_folio(old_tb) ||
>                              !__swp_tb_get_count(old_tb) ||
> -                            (memcg_id && *memcg_id !=3D lookup_swap_cgro=
up_id(targ_entry))))
> +                            (memcg_id && *memcg_id !=3D __swap_cgroup_ge=
t(ci, ci_off))))
>                         return -EBUSY;
> -               targ_entry.val++;
>         } while (++ci_off < ci_end);
>
>         return 0;
> diff --git a/mm/swap_table.h b/mm/swap_table.h
> index 8415ffbe2b9c..b2b02ee161b1 100644
> --- a/mm/swap_table.h
> +++ b/mm/swap_table.h
> @@ -11,6 +11,11 @@ struct swap_table {
>         atomic_long_t entries[SWAPFILE_CLUSTER];
>  };
>
> +/* For storing memcg private id */
> +struct swap_memcg_table {
> +       unsigned short id[SWAPFILE_CLUSTER];
> +};
> +
>  #define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) =3D=3D PAGE_SIZE)
>
>  /*
> @@ -247,4 +252,53 @@ static inline unsigned long swap_table_get(struct sw=
ap_cluster_info *ci,
>
>         return swp_tb;
>  }
> +
> +#ifdef CONFIG_MEMCG
> +static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
> +               unsigned int ci_off, unsigned long nr, unsigned short id)
> +{
> +       lockdep_assert_held(&ci->lock);
> +       VM_WARN_ON_ONCE(ci_off >=3D SWAPFILE_CLUSTER);
> +       do {
> +               ci->memcg_table->id[ci_off++] =3D id;

Do you need to check the memcg_table is not NULL here? Because this
function is no longer static. Another caller might invoke this when
the cluster hasn't allocated the memcg_table. They shouldn't. We might
want some check and complain here.



> +       } while (--nr);
> +}
> +
> +static inline unsigned short __swap_cgroup_get(struct swap_cluster_info =
*ci,
> +                                              unsigned int ci_off)
> +{
> +       lockdep_assert_held(&ci->lock);
> +       VM_WARN_ON_ONCE(ci_off >=3D SWAPFILE_CLUSTER);
> +       return ci->memcg_table->id[ci_off];

Here too.

> +}
> +
> +static inline unsigned short __swap_cgroup_clear(struct swap_cluster_inf=
o *ci,
> +                                                unsigned int ci_off,
> +                                                unsigned long nr)
> +{
> +       unsigned short old =3D ci->memcg_table->id[ci_off];

Here as well.

Chris
> +
> +       __swap_cgroup_set(ci, ci_off, nr, 0);
> +       return old;
> +}
> +#else
> +static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
> +               unsigned int ci_off, unsigned long nr, unsigned short id)
> +{
> +}
> +
> +static inline unsigned short __swap_cgroup_get(struct swap_cluster_info =
*ci,
> +                                              unsigned int ci_off)
> +{
> +       return 0;
> +}
> +
> +static inline unsigned short __swap_cgroup_clear(struct swap_cluster_inf=
o *ci,
> +                                                unsigned int ci_off,
> +                                                unsigned long nr)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2d16aa89a4fd..edf4cb36728e 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -423,7 +423,12 @@ static void swap_cluster_free_table(struct swap_clus=
ter_info *ci)
>  {
>         struct swap_table *table;
>
> -       table =3D (struct swap_table *)rcu_dereference_protected(ci->tabl=
e, true);
> +#ifdef CONFIG_MEMCG
> +       kfree(ci->memcg_table);
> +       ci->memcg_table =3D NULL;
> +#endif
> +
> +       table =3D (struct swap_table *)rcu_access_pointer(ci->table);
>         if (!table)
>                 return;
>
> @@ -441,6 +446,7 @@ static int swap_cluster_alloc_table(struct swap_clust=
er_info *ci, gfp_t gfp)
>  {
>         struct swap_table *table =3D NULL;
>         struct folio *folio;
> +       int ret =3D 0;
>
>         /* The cluster must be empty and not on any list during allocatio=
n. */
>         VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
> @@ -458,7 +464,17 @@ static int swap_cluster_alloc_table(struct swap_clus=
ter_info *ci, gfp_t gfp)
>                 return -ENOMEM;
>
>         rcu_assign_pointer(ci->table, table);
> -       return 0;
> +
> +#ifdef CONFIG_MEMCG
> +       if (!ci->memcg_table)
> +               ci->memcg_table =3D kzalloc(sizeof(*ci->memcg_table), gfp=
);
> +       if (!ci->memcg_table)
> +               ret =3D -ENOMEM;
> +#endif
> +       if (ret)
> +               swap_cluster_free_table(ci);
> +
> +       return ret;
>  }
>
>  /*
> @@ -483,6 +499,7 @@ static void swap_cluster_assert_empty(struct swap_clu=
ster_info *ci,
>                         bad_slots++;
>                 else
>                         WARN_ON_ONCE(!swp_tb_is_null(swp_tb));
> +               WARN_ON_ONCE(__swap_cgroup_get(ci, ci_off));
>         } while (++ci_off < ci_end);
>
>         WARN_ON_ONCE(bad_slots !=3D (swapoff ? ci->count : 0));
> @@ -1860,12 +1877,10 @@ void __swap_cluster_free_entries(struct swap_info=
_struct *si,
>                                  unsigned int ci_start, unsigned int nr_p=
ages)
>  {
>         unsigned long old_tb;
> -       unsigned int type =3D si->type;
>         unsigned short id =3D 0, id_cur;
>         unsigned int ci_off =3D ci_start, ci_end =3D ci_start + nr_pages;
>         unsigned long offset =3D cluster_offset(si, ci);
>         unsigned int ci_batch =3D ci_off;
> -       swp_entry_t entry;
>
>         VM_WARN_ON(ci->count < nr_pages);
>
> @@ -1883,21 +1898,17 @@ void __swap_cluster_free_entries(struct swap_info=
_struct *si,
>                  * Uncharge swap slots by memcg in batches. Consecutive
>                  * slots with the same cgroup id are uncharged together.
>                  */
> -               entry =3D swp_entry(type, offset + ci_off);
> -               id_cur =3D lookup_swap_cgroup_id(entry);
> +               id_cur =3D __swap_cgroup_clear(ci, ci_off, 1);
>                 if (id !=3D id_cur) {
>                         if (id)
> -                               mem_cgroup_uncharge_swap(swp_entry(type, =
offset + ci_batch),
> -                                                        ci_off - ci_batc=
h);
> +                               mem_cgroup_uncharge_swap(id, ci_off - ci_=
batch);
>                         id =3D id_cur;
>                         ci_batch =3D ci_off;
>                 }
>         } while (++ci_off < ci_end);
>
> -       if (id) {
> -               mem_cgroup_uncharge_swap(swp_entry(type, offset + ci_batc=
h),
> -                                        ci_off - ci_batch);
> -       }
> +       if (id)
> +               mem_cgroup_uncharge_swap(id, ci_off - ci_batch);
>
>         swap_range_free(si, offset + ci_start, nr_pages);
>         swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 63d06930d8e3..50d87ff58f86 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -739,7 +739,7 @@ static int __remove_mapping(struct address_space *map=
ping, struct folio *folio,
>
>                 if (reclaimed && !mapping_exiting(mapping))
>                         shadow =3D workingset_eviction(folio, target_memc=
g);
> -               __memcg1_swapout(folio);
> +               __memcg1_swapout(folio, ci);
>                 __swap_cache_del_folio(ci, folio, swap, shadow);
>                 swap_cluster_unlock_irq(ci);
>         } else {
>
> --
> 2.53.0
>
>

