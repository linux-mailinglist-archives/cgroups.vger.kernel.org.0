Return-Path: <cgroups+bounces-15649-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK7bAEap+2myewMAu9opvQ
	(envelope-from <cgroups+bounces-15649-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 22:49:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E794E05F9
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 22:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 10F963007AD2
	for <lists+cgroups@lfdr.de>; Wed,  6 May 2026 20:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9E93B19B1;
	Wed,  6 May 2026 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVbYHzV6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500FD3B0AD8
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100540; cv=none; b=F43EkrZIFxyydskpl4tUIRHMe+RHjFPz1yib6JIdcPJqljbfxu4gz2Sp4NMcCzCHaXflFOpuqqqfo3ySaf+iu0t6P0+GGnXjqM1YOhMKFeub3DS2LUGplbEjvzuHuXoppHvcD0kBmkGUQutmyh9rIvOn7LSmc0/Ni25heNzekvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100540; c=relaxed/simple;
	bh=k1fE6kIITx9nHpViczvQB5H+zgoxilh4XU5GU6Qfqbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrtjOGyclTerypWbd26ZG+G/gyL0reybfAbBzqfZ9uR95yr0sDM+mxQduP8Xeo8pvxP5w60A+frInSoU496hJ0a+mvCRFAKDEN0fbaqpXV4M/DXz9x1RisOUDo40KALFxqfSrWbPLvAPMyFa1kXSlyiH7CHijFa1+7pBcB8A02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVbYHzV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C4AC4AF0C
	for <cgroups@vger.kernel.org>; Wed,  6 May 2026 20:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778100539;
	bh=k1fE6kIITx9nHpViczvQB5H+zgoxilh4XU5GU6Qfqbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SVbYHzV6iknqJ7J/BmeTFEY8kIwUJCjkSjP8cAfMVYzaUPSzXJJKO3sICVK0kARbT
	 V2aAH6eYGP/pL/PnfWqAGwNPH21OQmGnfqUlsDrVPSyfBcaTK6aUW6EB8EBY0dmJKp
	 jP2WoCjr8rzY8CQbLbyLSHzPvSvliAQ4J9j9JCjnjpo7OJJ1FeaiBDIXhz1p3Hl6i+
	 di8+Ze2tyxl/Mh6k/uTb6z1Eg7rYrhGxzcXgRRGAdbBWfSJejJ+0IFChdXCizT9Dzm
	 Xd9op/MkLwZKWAxsoXwVCftjLDTjunNOQ2tE8Xn+PIt2w6myrdaMylDflxGzFaVE2n
	 /bH0FWHlYWvUA==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651bc83e74aso75159d50.2
        for <cgroups@vger.kernel.org>; Wed, 06 May 2026 13:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/8zyJs85/SVFF4/Eugirxyt85WBLV6fkiLuULARMPYLcZ8Fy91ky+CJYvIhjjvV1b+1hPwlAua@vger.kernel.org
X-Gm-Message-State: AOJu0YxBf5SIR74RzbHCYILzCl4PAXmRFjZOLRlOBfbLQt68yTVHiiGt
	/JPI1pz1+1eGnsmFwC03RimlkyWuO9pdJKJwbsoAPLaLHtW8TfLdRImdenYIkjh2GnLweyxRu4E
	gwChJooWwDVrr/3m2HDObrT/6oqBrXI4K0P/Jd1t2Mw==
X-Received: by 2002:a05:690e:42cf:b0:65c:6164:f287 with SMTP id
 956f58d0204a3-65c79c8dec7mr4393598d50.16.1778100538517; Wed, 06 May 2026
 13:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com> <20260421-swap-table-p4-v3-5-2f23759a76bc@tencent.com>
In-Reply-To: <20260421-swap-table-p4-v3-5-2f23759a76bc@tencent.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 6 May 2026 22:48:46 +0200
X-Gmail-Original-Message-ID: <CACePvbWKYLp_ik2cgsnb6Us2a5mFbeBAHEB+7qJMLKg+YGauFg@mail.gmail.com>
X-Gm-Features: AVHnY4KfEdAgMM0-KaWPKUyvtjzVk-Qr_y0l-d9ZlfVqlFnWWqLtFPgUOihYvms
Message-ID: <CACePvbWKYLp_ik2cgsnb6Us2a5mFbeBAHEB+7qJMLKg+YGauFg@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] mm, swap: unify large folio allocation
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
X-Rspamd-Queue-Id: E8E794E05F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15649-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]

On Tue, Apr 21, 2026 at 8:16=E2=80=AFAM Kairui Song via B4 Relay
<devnull+kasong.tencent.com@kernel.org> wrote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Now that direct large order allocation is supported in the swap cache,
> both anon and shmem can use it instead of implementing their own methods.
> This unifies the fallback and swap cache check, which also reduces the
> TOCTOU race window of swap cache state: previously, high order swapin
> required checking swap cache states first, then allocating and falling
> back separately. Now all these steps happen in the same compact loop.
>
> Order fallback and statistics are also unified, callers just need to
> check and pass the acceptable order bitmask.
>
> There is basically no behavior change. This only makes things more
> unified and prepares for later commits. Cgroup and zero map checks can
> also be moved into the compact loop, further reducing race windows and
> redundancy
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     |  77 ++++++------------------------
>  mm/shmem.c      |  94 +++++++++---------------------------
>  mm/swap.h       |  30 ++----------
>  mm/swap_state.c | 145 ++++++++++----------------------------------------=
------

Thanks for unifying the different code paths. I really like those diff stat=
s.
The execution flow for swap in is easier to read now. Good job.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

>  mm/swapfile.c   |   3 +-
>  5 files changed, 67 insertions(+), 282 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index ea6568571131..404734a5bcff 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4593,26 +4593,6 @@ static vm_fault_t handle_pte_marker(struct vm_faul=
t *vmf)
>         return VM_FAULT_SIGBUS;
>  }
>
> -static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
> -{
> -       struct vm_area_struct *vma =3D vmf->vma;
> -       struct folio *folio;
> -       softleaf_t entry;
> -
> -       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->addr=
ess);
> -       if (!folio)
> -               return NULL;
> -
> -       entry =3D softleaf_from_pte(vmf->orig_pte);
> -       if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> -                                          GFP_KERNEL, entry)) {
> -               folio_put(folio);
> -               return NULL;
> -       }
> -
> -       return folio;
> -}
> -
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  /*
>   * Check if the PTEs within a range are contiguous swap entries
> @@ -4642,8 +4622,6 @@ static bool can_swapin_thp(struct vm_fault *vmf, pt=
e_t *ptep, int nr_pages)
>          */
>         if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) !=3D nr_pa=
ges))
>                 return false;
> -       if (unlikely(non_swapcache_batch(entry, nr_pages) !=3D nr_pages))
> -               return false;
>
>         return true;
>  }
> @@ -4671,16 +4649,14 @@ static inline unsigned long thp_swap_suitable_ord=
ers(pgoff_t swp_offset,
>         return orders;
>  }
>
> -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>         unsigned long orders;
> -       struct folio *folio;
>         unsigned long addr;
>         softleaf_t entry;
>         spinlock_t *ptl;
>         pte_t *pte;
> -       gfp_t gfp;
>         int order;
>
>         /*
> @@ -4688,7 +4664,7 @@ static struct folio *alloc_swap_folio(struct vm_fau=
lt *vmf)
>          * maintain the uffd semantics.
>          */
>         if (unlikely(userfaultfd_armed(vma)))
> -               goto fallback;
> +               return 0;
>
>         /*
>          * A large swapped out folio could be partially or fully in zswap=
. We
> @@ -4696,7 +4672,7 @@ static struct folio *alloc_swap_folio(struct vm_fau=
lt *vmf)
>          * folio.
>          */
>         if (!zswap_never_enabled())
> -               goto fallback;
> +               return 0;
>
>         entry =3D softleaf_from_pte(vmf->orig_pte);
>         /*
> @@ -4710,12 +4686,12 @@ static struct folio *alloc_swap_folio(struct vm_f=
ault *vmf)
>                                           vmf->address, orders);
>
>         if (!orders)
> -               goto fallback;
> +               return 0;
>
>         pte =3D pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
>                                   vmf->address & PMD_MASK, &ptl);
>         if (unlikely(!pte))
> -               goto fallback;
> +               return 0;
>
>         /*
>          * For do_swap_page, find the highest order where the aligned ran=
ge is
> @@ -4731,29 +4707,12 @@ static struct folio *alloc_swap_folio(struct vm_f=
ault *vmf)
>
>         pte_unmap_unlock(pte, ptl);
>
> -       /* Try allocating the highest of the remaining orders. */
> -       gfp =3D vma_thp_gfp_mask(vma);
> -       while (orders) {
> -               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> -               folio =3D vma_alloc_folio(gfp, order, vma, addr);
> -               if (folio) {
> -                       if (!mem_cgroup_swapin_charge_folio(folio, vma->v=
m_mm,
> -                                                           gfp, entry))
> -                               return folio;
> -                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_C=
HARGE);
> -                       folio_put(folio);
> -               }
> -               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> -               order =3D next_order(&orders, order);
> -       }
> -
> -fallback:
> -       return __alloc_swap_folio(vmf);
> +       return orders;
>  }
>  #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> +static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
>  {
> -       return __alloc_swap_folio(vmf);
> +       return 0;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
> @@ -4859,21 +4818,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (folio)
>                 swap_update_readahead(folio, vma, vmf->address);
>         if (!folio) {
> -               if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> -                       folio =3D alloc_swap_folio(vmf);
> -                       if (folio) {
> -                               /*
> -                                * folio is charged, so swapin can only f=
ail due
> -                                * to raced swapin and return NULL.
> -                                */
> -                               swapcache =3D swapin_folio(entry, folio);
> -                               if (swapcache !=3D folio)
> -                                       folio_put(folio);
> -                               folio =3D swapcache;
> -                       }
> -               } else {
> +               /* Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devic=
es */
> +               if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
> +                       folio =3D swapin_entry(entry, GFP_HIGHUSER_MOVABL=
E,
> +                                            thp_swapin_suitable_orders(v=
mf),
> +                                            vmf, NULL, 0);
> +               else
>                         folio =3D swapin_readahead(entry, GFP_HIGHUSER_MO=
VABLE, vmf);
> -               }
>
>                 if (!folio) {
>                         /*
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 5916acf594a8..17e3da11bb1d 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -159,7 +159,7 @@ static unsigned long shmem_default_max_inodes(void)
>
>  static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>                         struct folio **foliop, enum sgp_type sgp, gfp_t g=
fp,
> -                       struct vm_area_struct *vma, vm_fault_t *fault_typ=
e);
> +                       struct vm_fault *vmf, vm_fault_t *fault_type);
>
>  static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
>  {
> @@ -2017,68 +2017,24 @@ static struct folio *shmem_alloc_and_add_folio(st=
ruct vm_fault *vmf,
>  }
>
>  static struct folio *shmem_swap_alloc_folio(struct inode *inode,
> -               struct vm_area_struct *vma, pgoff_t index,
> +               struct vm_fault *vmf, pgoff_t index,
>                 swp_entry_t entry, int order, gfp_t gfp)
>  {
> +       pgoff_t ilx;
> +       struct folio *folio;
> +       struct mempolicy *mpol;
> +       unsigned long orders =3D BIT(order);
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
> -       struct folio *new, *swapcache;
> -       int nr_pages =3D 1 << order;
> -       gfp_t alloc_gfp =3D gfp;
> -
> -       if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -               if (WARN_ON_ONCE(order))
> -                       return ERR_PTR(-EINVAL);
> -       } else if (order) {
> -               /*
> -                * If uffd is active for the vma, we need per-page fault
> -                * fidelity to maintain the uffd semantics, then fallback
> -                * to swapin order-0 folio, as well as for zswap case.
> -                * Any existing sub folio in the swap cache also blocks
> -                * mTHP swapin.
> -                */
> -               if ((vma && unlikely(userfaultfd_armed(vma))) ||
> -                    !zswap_never_enabled() ||
> -                    non_swapcache_batch(entry, nr_pages) !=3D nr_pages)
> -                       goto fallback;
>
> -               alloc_gfp =3D thp_limit_gfp_mask(vma_thp_gfp_mask(vma), g=
fp);
> -       }
> -retry:
> -       new =3D shmem_alloc_folio(alloc_gfp, order, info, index);
> -       if (!new) {
> -               new =3D ERR_PTR(-ENOMEM);
> -               goto fallback;
> -       }
> +       if ((vmf && unlikely(userfaultfd_armed(vmf->vma))) ||
> +            !zswap_never_enabled())
> +               orders =3D 0;
>
> -       if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
> -                                          alloc_gfp, entry)) {
> -               folio_put(new);
> -               new =3D ERR_PTR(-ENOMEM);
> -               goto fallback;
> -       }
> +       mpol =3D shmem_get_pgoff_policy(info, index, order, &ilx);
> +       folio =3D swapin_entry(entry, gfp, orders, vmf, mpol, ilx);
> +       mpol_cond_put(mpol);
>
> -       swapcache =3D swapin_folio(entry, new);
> -       if (swapcache !=3D new) {
> -               folio_put(new);
> -               if (!swapcache) {
> -                       /*
> -                        * The new folio is charged already, swapin can
> -                        * only fail due to another raced swapin.
> -                        */
> -                       new =3D ERR_PTR(-EEXIST);
> -                       goto fallback;
> -               }
> -       }
> -       return swapcache;
> -fallback:
> -       /* Order 0 swapin failed, nothing to fallback to, abort */
> -       if (!order)
> -               return new;
> -       entry.val +=3D index - round_down(index, nr_pages);
> -       alloc_gfp =3D gfp;
> -       nr_pages =3D 1;
> -       order =3D 0;
> -       goto retry;
> +       return folio;
>  }
>
>  /*
> @@ -2265,11 +2221,12 @@ static int shmem_split_large_entry(struct inode *=
inode, pgoff_t index,
>   */
>  static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
>                              struct folio **foliop, enum sgp_type sgp,
> -                            gfp_t gfp, struct vm_area_struct *vma,
> +                            gfp_t gfp, struct vm_fault *vmf,
>                              vm_fault_t *fault_type)
>  {
>         struct address_space *mapping =3D inode->i_mapping;
> -       struct mm_struct *fault_mm =3D vma ? vma->vm_mm : NULL;
> +       struct vm_area_struct *vma =3D vmf ? vmf->vma : NULL;
> +       struct mm_struct *fault_mm =3D vmf ? vmf->vma->vm_mm : NULL;
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
>         swp_entry_t swap;
>         softleaf_t index_entry;
> @@ -2310,20 +2267,15 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
>                         /* Direct swapin skipping swap cache & readahead =
*/
> -                       folio =3D shmem_swap_alloc_folio(inode, vma, inde=
x,
> -                                                      index_entry, order=
, gfp);
> -                       if (IS_ERR(folio)) {
> -                               error =3D PTR_ERR(folio);
> -                               folio =3D NULL;
> -                               goto failed;
> -                       }
> +                       folio =3D shmem_swap_alloc_folio(inode, vmf, inde=
x,
> +                                                      swap, order, gfp);
>                 } else {
>                         /* Cached swapin only supports order 0 folio */
>                         folio =3D shmem_swapin_cluster(swap, gfp, info, i=
ndex);
> -                       if (!folio) {
> -                               error =3D -ENOMEM;
> -                               goto failed;
> -                       }
> +               }
> +               if (!folio) {
> +                       error =3D -ENOMEM;
> +                       goto failed;
>                 }
>                 if (fault_type) {
>                         *fault_type |=3D VM_FAULT_MAJOR;
> @@ -2471,7 +2423,7 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>
>         if (xa_is_value(folio)) {
>                 error =3D shmem_swapin_folio(inode, index, &folio,
> -                                          sgp, gfp, vma, fault_type);
> +                                          sgp, gfp, vmf, fault_type);
>                 if (error =3D=3D -EEXIST)
>                         goto repeat;
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 6774af10a943..80c2f1bf7a57 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -300,7 +300,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entr=
y, gfp_t flag,
>                 struct mempolicy *mpol, pgoff_t ilx);
>  struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
>                 struct vm_fault *vmf);
> -struct folio *swapin_folio(swp_entry_t entry, struct folio *folio);
> +struct folio *swapin_entry(swp_entry_t entry, gfp_t flag, unsigned long =
orders,
> +                          struct vm_fault *vmf, struct mempolicy *mpol, =
pgoff_t ilx);
>  void swap_update_readahead(struct folio *folio, struct vm_area_struct *v=
ma,
>                            unsigned long addr);
>
> @@ -334,24 +335,6 @@ static inline int swap_zeromap_batch(swp_entry_t ent=
ry, int max_nr,
>                 return find_next_bit(sis->zeromap, end, start) - start;
>  }
>
> -static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> -{
> -       int i;
> -
> -       /*
> -        * While allocating a large folio and doing mTHP swapin, we need =
to
> -        * ensure all entries are not cached, otherwise, the mTHP folio w=
ill
> -        * be in conflict with the folio in swap cache.
> -        */
> -       for (i =3D 0; i < max_nr; i++) {
> -               if (swap_cache_has_folio(entry))
> -                       return i;
> -               entry.val++;
> -       }
> -
> -       return i;
> -}
> -
>  #else /* CONFIG_SWAP */
>  struct swap_iocb;
>  static inline struct swap_cluster_info *swap_cluster_lock(
> @@ -433,7 +416,9 @@ static inline struct folio *swapin_readahead(swp_entr=
y_t swp, gfp_t gfp_mask,
>         return NULL;
>  }
>
> -static inline struct folio *swapin_folio(swp_entry_t entry, struct folio=
 *folio)
> +static inline struct folio *swapin_entry(
> +       swp_entry_t entry, gfp_t flag, unsigned long orders,
> +       struct vm_fault *vmf, struct mempolicy *mpol, pgoff_t ilx)
>  {
>         return NULL;
>  }
> @@ -493,10 +478,5 @@ static inline int swap_zeromap_batch(swp_entry_t ent=
ry, int max_nr,
>  {
>         return 0;
>  }
> -
> -static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
> -{
> -       return 0;
> -}
>  #endif /* CONFIG_SWAP */
>  #endif /* _MM_SWAP_H */
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index f5c77f348bbd..6ebd062bcece 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -235,45 +235,6 @@ void __swap_cache_add_folio(struct swap_cluster_info=
 *ci,
>         lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
>  }
>
> -/**
> - * swap_cache_add_folio - Add a folio into the swap cache.
> - * @folio: The folio to be added.
> - * @entry: The swap entry corresponding to the folio.
> - * @shadowp: If a shadow is found, return the shadow.
> - *
> - * Add a folio into the swap cache. Will return error if any slot is no
> - * longer a valid swapped out slot or already occupied by another folio.
> - *
> - * Context: Caller must ensure @entry is valid and protect the swap devi=
ce
> - * with reference count or locks.
> - */
> -static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
> -                               void **shadowp)
> -{
> -       int err;
> -       void *shadow =3D NULL;
> -       unsigned int ci_off;
> -       struct swap_info_struct *si;
> -       struct swap_cluster_info *ci;
> -       unsigned long nr_pages =3D folio_nr_pages(folio);
> -
> -       si =3D __swap_entry_to_info(entry);
> -       ci =3D swap_cluster_lock(si, swp_offset(entry));
> -       ci_off =3D swp_cluster_offset(entry);
> -       err =3D __swap_cache_add_check(ci, entry, nr_pages, &shadow);
> -       if (err) {
> -               swap_cluster_unlock(ci);
> -               return err;
> -       }
> -
> -       __swap_cache_add_folio(ci, folio, entry);
> -       swap_cluster_unlock(ci);
> -       if (shadowp)
> -               *shadowp =3D shadow;
> -
> -       return 0;
> -}
> -
>  static void __swap_cache_do_del_folio(struct swap_cluster_info *ci,
>                                       struct folio *folio,
>                                       swp_entry_t entry, void *shadow)
> @@ -644,51 +605,6 @@ void swap_update_readahead(struct folio *folio, stru=
ct vm_area_struct *vma,
>         }
>  }
>
> -/**
> - * __swap_cache_prepare_and_add - Prepare the folio and add it to swap c=
ache.
> - * @entry: swap entry to be bound to the folio.
> - * @folio: folio to be added.
> - * @gfp: memory allocation flags for charge, can be 0 if @charged if tru=
e.
> - * @charged: if the folio is already charged.
> - *
> - * Update the swap_map and add folio as swap cache, typically before swa=
pin.
> - * All swap slots covered by the folio must have a non-zero swap count.
> - *
> - * Context: Caller must protect the swap device with reference count or =
locks.
> - * Return: 0 if success, error code if failed.
> - */
> -static int __swap_cache_prepare_and_add(swp_entry_t entry,
> -                                       struct folio *folio,
> -                                       gfp_t gfp, bool charged)
> -{
> -       void *shadow;
> -       int ret;
> -
> -       __folio_set_locked(folio);
> -       __folio_set_swapbacked(folio);
> -
> -       if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, =
entry)) {
> -               ret =3D -ENOMEM;
> -               goto failed;
> -       }
> -
> -       ret =3D swap_cache_add_folio(folio, entry, &shadow);
> -       if (ret)
> -               goto failed;
> -
> -       memcg1_swapin(entry, folio_nr_pages(folio));
> -       if (shadow)
> -               workingset_refault(folio, shadow);
> -
> -       /* Caller will initiate read into locked folio */
> -       folio_add_lru(folio);
> -       return 0;
> -
> -failed:
> -       folio_unlock(folio);
> -       return ret;
> -}
> -
>  static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
>                                            struct mempolicy *mpol, pgoff_=
t ilx,
>                                            struct swap_iocb **plug, bool =
readahead)
> @@ -704,7 +620,6 @@ static struct folio *swap_cache_read_folio(swp_entry_=
t entry, gfp_t gfp,
>                 folio =3D swap_cache_get_folio(entry);
>                 if (folio)
>                         return folio;
> -
>                 folio =3D swap_cache_alloc_folio(entry, gfp, 0, NULL, mpo=
l, ilx);
>         } while (IS_ERR(folio) && PTR_ERR(folio) =3D=3D -EEXIST);
>
> @@ -721,49 +636,37 @@ static struct folio *swap_cache_read_folio(swp_entr=
y_t entry, gfp_t gfp,
>  }
>
>  /**
> - * swapin_folio - swap-in one or multiple entries skipping readahead.
> - * @entry: starting swap entry to swap in
> - * @folio: a new allocated and charged folio
> + * swapin_entry - swap-in one or multiple entries skipping readahead.
> + * @entry: swap entry indicating the target slot
> + * @gfp: memory allocation flags
> + * @orders: allocation orders
> + * @vmf: fault information
> + * @mpol: NUMA memory allocation policy to be applied
> + * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
>   *
> - * Reads @entry into @folio, @folio will be added to the swap cache.
> - * If @folio is a large folio, the @entry will be rounded down to align
> - * with the folio size.
> + * This allocates a folio suitable for given @orders, or returns the
> + * existing folio in the swap cache for @entry. This initiates the IO, t=
oo,
> + * if needed. @entry is rounded down if @orders allow large allocation.
>   *
> - * Return: returns pointer to @folio on success. If folio is a large fol=
io
> - * and this raced with another swapin, NULL will be returned to allow fa=
llback
> - * to order 0. Else, if another folio was already added to the swap cach=
e,
> - * return that swap cache folio instead.
> + * Context: Caller must ensure @entry is valid and pin the swap device w=
ith refcount.
> + * Return: Returns the folio on success, NULL if failed.
>   */
> -struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
> +struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp, unsigned long o=
rders,
> +                          struct vm_fault *vmf, struct mempolicy *mpol, =
pgoff_t ilx)
>  {
> -       int ret;
> -       struct folio *swapcache;
> -       pgoff_t offset =3D swp_offset(entry);
> -       unsigned long nr_pages =3D folio_nr_pages(folio);
> -
> -       entry =3D swp_entry(swp_type(entry), round_down(offset, nr_pages)=
);
> -       for (;;) {
> -               ret =3D __swap_cache_prepare_and_add(entry, folio, 0, tru=
e);
> -               if (!ret) {
> -                       swap_read_folio(folio, NULL);
> -                       break;
> -               }
> +       struct folio *folio;
>
> -               /*
> -                * Large order allocation needs special handling on
> -                * race: if a smaller folio exists in cache, swapin needs
> -                * to fall back to order 0, and doing a swap cache lookup
> -                * might return a folio that is irrelevant to the faultin=
g
> -                * entry because @entry is aligned down. Just return NULL=
.
> -                */
> -               if (ret !=3D -EEXIST || nr_pages > 1)
> -                       return NULL;
> +       do {
> +               folio =3D swap_cache_get_folio(entry);
> +               if (folio)
> +                       return folio;
> +               folio =3D swap_cache_alloc_folio(entry, gfp, orders, vmf,=
 mpol, ilx);
> +       } while (IS_ERR(folio) && PTR_ERR(folio) =3D=3D -EEXIST);
>
> -               swapcache =3D swap_cache_get_folio(entry);
> -               if (swapcache)
> -                       return swapcache;
> -       }
> +       if (IS_ERR(folio))
> +               return NULL;
>
> +       swap_read_folio(folio, NULL);
>         return folio;
>  }
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c7e173b93e11..2e384d1c78c3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1826,8 +1826,7 @@ void folio_put_swap(struct folio *folio, struct pag=
e *subpage)
>   *   do_swap_page()
>   *     ...                             swapoff+swapon
>   *     swap_cache_alloc_folio()
> - *       swap_cache_add_folio()
> - *         // check swap_map
> + *       // check swap_map
>   *     // verify PTE not changed
>   *
>   * In __swap_duplicate(), the swap_map need to be checked before
>
> --
> 2.53.0
>
>

