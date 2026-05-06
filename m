Return-Path: <cgroups+bounces-15650-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI8LFDer+2myewMAu9opvQ
	(envelope-from <cgroups+bounces-15650-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 22:57:27 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A764E072E
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 22:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 478D93008D46
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 20:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA253AF64F;
	Wed,  6 May 2026 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LadGnhx/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B2355F25
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778101043; cv=none; b=JUpmzA1GPq8FiOJpCRMNgfwLVqEEfNOFPqrow8VOqIwKta7M748qZbczXcAfvL28uccp/oD6Zp7y/gVnGvgZUXQlSA3uHYQX+dyh5eDOcp6+Fj52IPQlaEIzqd/lkLIxDnitCBEhhxn38m/L9LwFUjJTvUSJCv58kfxOpFtMXC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778101043; c=relaxed/simple;
	bh=pW8uXu+LHQnPU20yB7kegJlrYfjbjquYDEnrZG5nLB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Twd7x/e2+pU7E0p1/QikLBa1RslTrPUwEbAMeuUTprThqj5LWAMLpzR/YZY3q95EvL0qVV/ej7FrWJA/xIkaGAQo79GMVpl2vmo1aAHKYC0OR+jwID82PMf9fjBFfdS4b9dyDabdc0S2/Oqs505p780QUGMpASrUKgDGI/T5QUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LadGnhx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B566C2BCC9
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 20:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778101043;
	bh=pW8uXu+LHQnPU20yB7kegJlrYfjbjquYDEnrZG5nLB8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LadGnhx/0jjrUUU5MgxKXRZSNKulBJs0Jw21I1EJu7NB9tONgUjIn6qBqcRYY9Mjj
	 3a1McRnMevwjRae5WVmMW+/PQAZ2sMa6metO+Ypyh1RvyWiqFafHpQkPXa29leQVpO
	 45aZJL3/L1Hdu0aD+m0lL2qpXVFWxNXLp7AH0wjj/dKXsZYYhqJpI1h2H3IctvINTL
	 /7uIPMR+15PkZJZDNsCZoczMSPpwi7cEjbBlA937Dy7JqDjWReNgm735C5jySP6s21
	 M/4Br+rWccGXz5zYuDosprRdM/anRG6izwD0zObi9ZNgDLzmPCdRGJLUzkeP0Tk80i
	 Pw+FFpDwzTXTA==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c37eafcbeso111129d50.1
        for <cgroups@vger.kernel.org>; Wed, 06 May 2026 13:57:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9sFPkkC8SFQ1Ipg9maIw4/gN5nr1Zp6nL+5EPSUsoGjl8XxMERTq5dNBoEYC2THf1ezghU5Vbf@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlkPQL/GbgK1KTqIhuyOg6pES8oEpYPwmyZDdgjWRfUtJSxZ2
	VDBAzJ6I4IoyadUY24sPDFACaDbEWQ4CoQqqrmWlMphT9D3Ymt6iIltfvsH2mf3fFp6m5eObBFR
	PykQcvEHqEKzRutsutGowcUjWRSXXGvuUbOQ01Xx7Bw==
X-Received: by 2002:a53:ba85:0:b0:650:31d2:234f with SMTP id
 956f58d0204a3-65c79a050edmr4083353d50.51.1778101042371; Wed, 06 May 2026
 13:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-6-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-6-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 May 2026 22:57:11 +0200
X-Gmail-Original-Message-ID: <CACePvbXQcj+k8JbDXuGoCx6_qJaJg0RuOo5CT66-rVszJ2_7Yw@mail.gmail.com>
X-Gm-Features: AVHnY4LGClhGvn4cGG2NViAGtptr-fMX3vrnxcH1j_0UxcXuA3X80z-nqFq4XQc
Message-ID: <CACePvbXQcj+k8JbDXuGoCx6_qJaJg0RuOo5CT66-rVszJ2_7Yw@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] mm/memcg, swap: tidy up cgroup v1 memsw swap helpers
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
X-Rspamd-Queue-Id: D9A764E072E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15650-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email,mail.gmail.com:mid]

On Tue, Apr 21, 2026 at 8:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> The cgroup v1 swap helpers always operate on swap cache folios whose
> swap entry is stable: the folio is locked and in the swap cache. There
> is no need to pass the swap entry or page count as separate parameters
> when they can be derived from the folio itself.
>
> Simplify the redundant parameters and add sanity checks to document
> the required preconditions.
>
> Also rename memcg1_swapout to __memcg1_swapout to indicate it requires
> special calling context: the folio must be isolated and dying, and the
> call must be made with interrupts disabled.
>
> No functional change.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> ---
>  include/linux/memcontrol.h |  8 ++++----
>  include/linux/swap.h       | 10 ++++------
>  mm/huge_memory.c           |  2 +-
>  mm/memcontrol-v1.c         | 33 ++++++++++++++++++++-------------
>  mm/memcontrol.c            |  9 ++++-----
>  mm/swap_state.c            |  4 ++--
>  mm/swapfile.c              |  2 +-
>  mm/vmscan.c                |  2 +-
>  8 files changed, 37 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index dc3fa687759b..7d08128de1fd 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1899,8 +1899,8 @@ static inline void mem_cgroup_exit_user_fault(void)
>         current->in_user_fault =3D 0;
>  }
>
> -void memcg1_swapout(struct folio *folio, swp_entry_t entry);
> -void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages);
> +void __memcg1_swapout(struct folio *folio);
> +void memcg1_swapin(struct folio *folio);
>
>  #else /* CONFIG_MEMCG_V1 */
>  static inline
> @@ -1929,11 +1929,11 @@ static inline void mem_cgroup_exit_user_fault(voi=
d)
>  {
>  }
>
> -static inline void memcg1_swapout(struct folio *folio, swp_entry_t entry=
)
> +static inline void __memcg1_swapout(struct folio *folio)
>  {
>  }
>
> -static inline void memcg1_swapin(swp_entry_t entry, unsigned int nr_page=
s)
> +static inline void memcg1_swapin(struct folio *folio)
>  {
>  }
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 1930f81e6be4..f2949f5844a6 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -574,13 +574,12 @@ static inline void folio_throttle_swaprate(struct f=
olio *folio, gfp_t gfp)
>  #endif
>
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
> -int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)=
;
> -static inline int mem_cgroup_try_charge_swap(struct folio *folio,
> -               swp_entry_t entry)
> +int __mem_cgroup_try_charge_swap(struct folio *folio);
> +static inline int mem_cgroup_try_charge_swap(struct folio *folio)
>  {
>         if (mem_cgroup_disabled())
>                 return 0;
> -       return __mem_cgroup_try_charge_swap(folio, entry);
> +       return __mem_cgroup_try_charge_swap(folio);
>  }
>
>  extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int n=
r_pages);
> @@ -594,8 +593,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry=
_t entry, unsigned int nr_p
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
>  extern bool mem_cgroup_swap_full(struct folio *folio);
>  #else
> -static inline int mem_cgroup_try_charge_swap(struct folio *folio,
> -                                            swp_entry_t entry)
> +static inline int mem_cgroup_try_charge_swap(struct folio *folio)
>  {
>         return 0;
>  }
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 970e077019b7..9630e283cf25 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4431,7 +4431,7 @@ void deferred_split_folio(struct folio *folio, bool=
 partially_mapped)
>
>         /*
>          * Exclude swapcache: originally to avoid a corrupt deferred spli=
t
> -        * queue. Nowadays that is fully prevented by memcg1_swapout();
> +        * queue. Nowadays that is fully prevented by __memcg1_swapout();
>          * but if page reclaim is already handling the same folio, it is
>          * unnecessary to handle it again in the shrinker, so excluding
>          * swapcache here may still be a useful optimization.
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 433bba9dfe71..36c507d81dc5 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -604,18 +604,23 @@ void memcg1_commit_charge(struct folio *folio, stru=
ct mem_cgroup *memcg)
>  }
>
>  /**
> - * memcg1_swapout - transfer a memsw charge to swap
> + * __memcg1_swapout - transfer a memsw charge to swap
>   * @folio: folio whose memsw charge to transfer
> - * @entry: swap entry to move the charge to
>   *
> - * Transfer the memsw charge of @folio to @entry.
> + * Transfer the memsw charge of @folio to the swap entry stored in
> + * folio->swap.
> + *
> + * Context: folio must be isolated, unmapped, locked and is just about
> + * to be freed, and caller must disable IRQs.
>   */
> -void memcg1_swapout(struct folio *folio, swp_entry_t entry)
> +void __memcg1_swapout(struct folio *folio)
>  {
>         struct mem_cgroup *memcg, *swap_memcg;
>         struct obj_cgroup *objcg;
>         unsigned int nr_entries;
>
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>         VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
>         VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
>
> @@ -641,7 +646,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t =
entry)
>         swap_memcg =3D mem_cgroup_private_id_get_online(memcg, nr_entries=
);
>         mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
>
> -       swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), entr=
y);
> +       swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), foli=
o->swap);
>
>         folio_unqueue_deferred_split(folio);
>         folio->memcg_data =3D 0;
> @@ -671,18 +676,20 @@ void memcg1_swapout(struct folio *folio, swp_entry_=
t entry)
>         obj_cgroup_put(objcg);
>  }
>
> -/*
> +/**
>   * memcg1_swapin - uncharge swap slot
> - * @entry: the first swap entry for which the pages are charged
> - * @nr_pages: number of pages which will be uncharged
> + * @folio: folio being swapped in
>   *
> - * Call this function after successfully adding the charged page to swap=
cache.
> + * Call this function after successfully adding the charged
> + * folio to swapcache.
>   *
> - * Note: This function assumes the page for which swap slot is being unc=
harged
> - * is order 0 page.
> + * Context: The folio has to be in swap cache and locked.
>   */
> -void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
> +void memcg1_swapin(struct folio *folio)
>  {
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> +
>         /*
>          * Cgroup1's unified memory+swap counter has been charged with th=
e
>          * new swapcache page, finish the transfer by uncharging the swap
> @@ -701,7 +708,7 @@ void memcg1_swapin(swp_entry_t entry, unsigned int nr=
_pages)
>                  * let's not wait for it.  The page already received a
>                  * memory+swap charge, drop the swap entry duplicate.
>                  */
> -               mem_cgroup_uncharge_swap(entry, nr_pages);
> +               mem_cgroup_uncharge_swap(folio->swap, folio_nr_pages(foli=
o));
>         }
>  }
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c3d98ab41f1f..c7df30ca5aa7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5456,13 +5456,12 @@ int __init mem_cgroup_init(void)
>  /**
>   * __mem_cgroup_try_charge_swap - try charging swap space for a folio
>   * @folio: folio being added to swap
> - * @entry: swap entry to charge
>   *
> - * Try to charge @folio's memcg for the swap space at @entry.
> + * Try to charge @folio's memcg for the swap space at folio->swap.
>   *
>   * Returns 0 on success, -ENOMEM on failure.
>   */
> -int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
> +int __mem_cgroup_try_charge_swap(struct folio *folio)
>  {
>         unsigned int nr_pages =3D folio_nr_pages(folio);
>         struct page_counter *counter;
> @@ -5479,7 +5478,7 @@ int __mem_cgroup_try_charge_swap(struct folio *foli=
o, swp_entry_t entry)
>
>         rcu_read_lock();
>         memcg =3D obj_cgroup_memcg(objcg);
> -       if (!entry.val) {
> +       if (!folio_test_swapcache(folio)) {
>                 memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
>                 rcu_read_unlock();
>                 return 0;
> @@ -5498,7 +5497,7 @@ int __mem_cgroup_try_charge_swap(struct folio *foli=
o, swp_entry_t entry)
>         }
>         mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
>
> -       swap_cgroup_record(folio, mem_cgroup_private_id(memcg), entry);
> +       swap_cgroup_record(folio, mem_cgroup_private_id(memcg), folio->sw=
ap);
>
>         return 0;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 6ebd062bcece..12b290d43e45 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -451,8 +451,8 @@ static struct folio *__swap_cache_alloc(struct swap_c=
luster_info *ci,
>                 return ERR_PTR(-ENOMEM);
>         }
>
> -       /* For memsw accounting, swap is uncharged when folio is added to=
 swap cache */
> -       memcg1_swapin(entry, 1 << order);
> +       /* memsw uncharges swap when folio is added to swap cache */
> +       memcg1_swapin(folio);
>         if (shadow)
>                 workingset_refault(folio, shadow);
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2e384d1c78c3..e1ad77a69e54 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1730,7 +1730,7 @@ int folio_alloc_swap(struct folio *folio)
>         }
>
>         /* Need to call this even if allocation failed, for MEMCG_SWAP_FA=
IL. */
> -       if (unlikely(mem_cgroup_try_charge_swap(folio, folio->swap)))
> +       if (unlikely(mem_cgroup_try_charge_swap(folio)))
>                 swap_cache_del_folio(folio);
>
>         if (unlikely(!folio_test_swapcache(folio)))
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd1b1aa12581..63d06930d8e3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -739,7 +739,7 @@ static int __remove_mapping(struct address_space *map=
ping, struct folio *folio,
>
>                 if (reclaimed && !mapping_exiting(mapping))
>                         shadow =3D workingset_eviction(folio, target_memc=
g);
> -               memcg1_swapout(folio, swap);
> +               __memcg1_swapout(folio);
>                 __swap_cache_del_folio(ci, folio, swap, shadow);
>                 swap_cluster_unlock_irq(ci);
>         } else {
>
> --
> 2.53.0
>
>

