Return-Path: <cgroups+bounces-15871-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDdOAOweBGpyEAIAu9opvQ
	(envelope-from <cgroups+bounces-15871-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 08:49:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 543F552E3D5
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 08:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A8DE3087A18
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2AA3D47CF;
	Wed, 13 May 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hld+8IYr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319A23D4119
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 06:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654905; cv=pass; b=sUrSBdny9nRyprVnemqVZ9SlORVDaYKplM47YGg6NcQTdj20EIFWi2kQJbmfaT4evevl/mldfzOxEw0fmEeJiKCaAL+480uSIFWZ0TI71rsJAy6eTBVAHJZaRK0CJs4doiM5kuGLL72EWiv6/xupqTb+wIzxpy6ci4FEEVqy/lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654905; c=relaxed/simple;
	bh=LlcesgHHnZ+6ttGyX96wo1e5WvRhO2xz8L5H8Ly2RVc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qRCzIhkCmtUCFU09t96m5Ilk8lCVj7tmc62yuMis5cRm6mymXSwZKLNyb+cIzpzhxVxvpXNG/LPv8ANyLY8XUjKy4krEpDbXWzRxF8AFL55Uk47NqviISQcnvkKLEI1lloKuByV9ltn1No2p8TwnFXIpWx099mjcWNMZnR7M2Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hld+8IYr; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd01481e592so409164766b.2
        for <cgroups@vger.kernel.org>; Tue, 12 May 2026 23:48:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778654900; cv=none;
        d=google.com; s=arc-20240605;
        b=kpZ+q7rjwAe5W9k/aWxPuZM28SBj+MAi7+TSh7ShXVNFwC/BAYN75KpO8eXpsblv/U
         UKkJDZf3cEgrJNR07LMnA4IRgRjbxztPdLWCFcOdJ0tpXmKItpLhujosAG5uFxgvYrfA
         Fsx+8awxBmsLu7pcS6gaxn8xjh7n9/CObl8g2kIASOsXMEd9PoiWf+mClfUPUezUa+M7
         irEf7M0wBIZBNfzkT7DGxXnMBILs0RddGF0oT79TG6C60SMGm8grCxVAgbjmvoL2GG/k
         pC+9AUR9e1pp3+Z97Nxkrq0Wi9gdTm3t7/D0ijLuz5KmnNpv0163Jy7TYNqtrB3iDCfw
         wD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NO9IfTuyK11eGbbv/78bll6gwJfN7wdF7CjlfPBKFAY=;
        fh=p++WXXrxUXWfu+Jb/jSpuoSGkPu18Cvo9ChkiSGcwio=;
        b=UnYilOlw1SZ3a/Op3t05368XHjHWRHmnXu+BIuN6+3GIPFh4f/Y5MaMLexh64LQrJX
         esALIsDY19/BIipERh5EGP/HG3OFs81CoQid4Qo3uttnR+sYRwAhIWozvpmSa/3zNoSn
         WPw2uS1ofX4YtcsG2KeIJzWxB8+1BJ7QldgdkvJus8yhEXF1n0Kx3+2pcuSuWK3dxEPY
         ikbcw6oY9eN2pLGB2c129PRAcu2dXyY6ijJxD0pY/J/So9HXXnR0FwtmqqKysgg5WUP6
         wyyiM0wzo/W96H+SjPyMZMZTCWO9CSO5ELZ8VqqVWjDEB7auCZPReCTqUZj9Dz2nhZOX
         nihA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778654900; x=1779259700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NO9IfTuyK11eGbbv/78bll6gwJfN7wdF7CjlfPBKFAY=;
        b=hld+8IYrsCJaOn0D8q9DkveOt93QLHrWa4ipkhjOdWiogMuv6xq6/0uUTu740QTcBt
         fPC2Y8b+lUHe0itrpl2nsZ8AX9l7xGGDocCeWGGcyd0XFdwa9WiJjwZo9uNMnGrh+WHs
         KxnGWHmrYKvz0hWet/aTfgjjDLlJNkSxfA+Pllfe+4tOXrw4ggJegHC7gCmoM/9ZgD0a
         gTDN7tbd7EH9gVkxNeGfyeDjUwb4ISjcgGQ+MnSvuHOux5X3NnmMuK9b4PTjU3TIfNX/
         bxvBJ9Ba4n6QOQsx4bNo5W0TdclbC1DNeQsfTckHORWUBGLEyBhStOPSgAhhSLadq/mo
         59Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778654900; x=1779259700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NO9IfTuyK11eGbbv/78bll6gwJfN7wdF7CjlfPBKFAY=;
        b=MXFfB9k8fNFwen7UUFYNVWBYdX9kP95BsNrmk8xdiRTm4SDZA4L9BmIN4ea0yy9luQ
         aeJEzJ7I82iqEPXyMSIhdyDg+c4VhOI0fDqzUz2gRtSHwBgPuzFFWvoriLcRUpqTqrAa
         HdhvGMIKtwh6i569zk933vBsu1HAht6xBBl+XxkU2347wZSHi5ESZw6+jOpN9wqldRVI
         PRtH14LFzEnr2aFr7dWPUBm6/NOORTy+635DG7T3e3m6AJMQplpkqmwO4011A7/63M2i
         q+T8ke6XeQV8A9Ta7PA5c/wQjwz+IcqgdTgl6r0nD62+rOQ9hx9Q70nNMnyVU5ddbXG/
         01sQ==
X-Forwarded-Encrypted: i=1; AFNElJ9p2hQiU55mNex5NPymLX/RcW30RsfGCGwo7XDZgSvxj0fWAjgjAI37FZJnvCtTNfYJSdzcgMZy@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWX8xyzihZ/PGIWEu1hUeh+twJ2aoYWoxRkHujNN4dmFrJZpG
	szXo34PKqBzcJOU6/j1EM4Kyzgb+0DtRIKbv5n7EiE+tlyOjEYN2f19mcFVNJ92tU6wXtMks7BL
	E3bEb6xciktNSdWvPzGFHKXzV4RllRcw=
X-Gm-Gg: Acq92OEg6pAhqeWCvszUJ33z3Ii6fOuPw5h80f9fQI457jR/6OTEpQy5QnCl6o7b2Oo
	zPCYw56a2IKzyAmytaulibU9CnvWyr0MpLY4VXkAv446H2zL7cOIZYRX4Jq5wadlSm3K0SJ9LuA
	YfhClH/+Gsn1vJjRWcFmXwWRjNgRwyWDi8Qetl0x2Sooisos61a2vntcPeRaGkhZypa5NwEkyfC
	RGyxZK/AIbNMI4MCJ7EP2o1VpMU1+yQXCxMZfKMFvVKjLKe5z8sCGqhRIqFRhHuiNXOtQj+4RMC
	PvovtPp8Wy1jtJhFw37NVGHKQPGur0uQ3MWgPeop
X-Received: by 2002:a17:906:9c82:b0:bba:8587:1164 with SMTP id
 a640c23a62f3a-bd3e0459b78mr85678566b.15.1778654900164; Tue, 12 May 2026
 23:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-5-2f23759a76bc@tencent.com> <d5341d37-5644-4446-a406-9a7251b83399@linux.alibaba.com>
In-Reply-To: <d5341d37-5644-4446-a406-9a7251b83399@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 13 May 2026 14:47:43 +0800
X-Gm-Features: AVHnY4Jc9dnL_qPLCNsf1WUukJFRqXaEPwjZkq2XUmQtt_5xcUIeBJ3UzKjpIu4
Message-ID: <CAMgjq7CPDk4hP-5hnV4Bth523W_Z+9hvg7Wo_upE-5rYCA0Mpw@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] mm, swap: unify large folio allocation
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Youngjun Park <youngjun.park@lge.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Lance Yang <lance.yang@linux.dev>, Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 543F552E3D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15871-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,alibaba.com:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 6:14=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> On 4/21/26 2:16 PM, Kairui Song via B4 Relay wrote:
> > From: Kairui Song <kasong@tencent.com>
> >
> > Now that direct large order allocation is supported in the swap cache,
> > both anon and shmem can use it instead of implementing their own method=
s.
> > This unifies the fallback and swap cache check, which also reduces the
> > TOCTOU race window of swap cache state: previously, high order swapin
> > required checking swap cache states first, then allocating and falling
> > back separately. Now all these steps happen in the same compact loop.
> >
> > Order fallback and statistics are also unified, callers just need to
> > check and pass the acceptable order bitmask.
> >
> > There is basically no behavior change. This only makes things more
> > unified and prepares for later commits. Cgroup and zero map checks can
> > also be moved into the compact loop, further reducing race windows and
> > redundancy
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >   mm/memory.c     |  77 ++++++------------------------
> >   mm/shmem.c      |  94 +++++++++---------------------------
> >   mm/swap.h       |  30 ++----------
> >   mm/swap_state.c | 145 ++++++++++-------------------------------------=
---------
> >   mm/swapfile.c   |   3 +-
> >   5 files changed, 67 insertions(+), 282 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index ea6568571131..404734a5bcff 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -4593,26 +4593,6 @@ static vm_fault_t handle_pte_marker(struct vm_fa=
ult *vmf)
> >       return VM_FAULT_SIGBUS;
> >   }
> >
> > -static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
> > -{
> > -     struct vm_area_struct *vma =3D vmf->vma;
> > -     struct folio *folio;
> > -     softleaf_t entry;
> > -
> > -     folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->addr=
ess);
> > -     if (!folio)
> > -             return NULL;
> > -
> > -     entry =3D softleaf_from_pte(vmf->orig_pte);
> > -     if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> > -                                        GFP_KERNEL, entry)) {
> > -             folio_put(folio);
> > -             return NULL;
> > -     }
> > -
> > -     return folio;
> > -}
> > -
> >   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >   /*
> >    * Check if the PTEs within a range are contiguous swap entries
> > @@ -4642,8 +4622,6 @@ static bool can_swapin_thp(struct vm_fault *vmf, =
pte_t *ptep, int nr_pages)
> >        */
> >       if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) !=3D nr_pa=
ges))
> >               return false;
> > -     if (unlikely(non_swapcache_batch(entry, nr_pages) !=3D nr_pages))
> > -             return false;
> >
> >       return true;
> >   }
> > @@ -4671,16 +4649,14 @@ static inline unsigned long thp_swap_suitable_o=
rders(pgoff_t swp_offset,
> >       return orders;
> >   }
> >
> > -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > +static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
> >   {
> >       struct vm_area_struct *vma =3D vmf->vma;
> >       unsigned long orders;
> > -     struct folio *folio;
> >       unsigned long addr;
> >       softleaf_t entry;
> >       spinlock_t *ptl;
> >       pte_t *pte;
> > -     gfp_t gfp;
> >       int order;
> >
> >       /*
> > @@ -4688,7 +4664,7 @@ static struct folio *alloc_swap_folio(struct vm_f=
ault *vmf)
> >        * maintain the uffd semantics.
> >        */
> >       if (unlikely(userfaultfd_armed(vma)))
> > -             goto fallback;
> > +             return 0;
> >
> >       /*
> >        * A large swapped out folio could be partially or fully in zswap=
. We
> > @@ -4696,7 +4672,7 @@ static struct folio *alloc_swap_folio(struct vm_f=
ault *vmf)
> >        * folio.
> >        */
> >       if (!zswap_never_enabled())
> > -             goto fallback;
> > +             return 0;
> >
> >       entry =3D softleaf_from_pte(vmf->orig_pte);
> >       /*
> > @@ -4710,12 +4686,12 @@ static struct folio *alloc_swap_folio(struct vm=
_fault *vmf)
> >                                         vmf->address, orders);
> >
> >       if (!orders)
> > -             goto fallback;
> > +             return 0;
> >
> >       pte =3D pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> >                                 vmf->address & PMD_MASK, &ptl);
> >       if (unlikely(!pte))
> > -             goto fallback;
> > +             return 0;
> >
> >       /*
> >        * For do_swap_page, find the highest order where the aligned ran=
ge is
> > @@ -4731,29 +4707,12 @@ static struct folio *alloc_swap_folio(struct vm=
_fault *vmf)
> >
> >       pte_unmap_unlock(pte, ptl);
> >
> > -     /* Try allocating the highest of the remaining orders. */
> > -     gfp =3D vma_thp_gfp_mask(vma);
> > -     while (orders) {
> > -             addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> > -             folio =3D vma_alloc_folio(gfp, order, vma, addr);
> > -             if (folio) {
> > -                     if (!mem_cgroup_swapin_charge_folio(folio, vma->v=
m_mm,
> > -                                                         gfp, entry))
> > -                             return folio;
> > -                     count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_C=
HARGE);
> > -                     folio_put(folio);
> > -             }
> > -             count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> > -             order =3D next_order(&orders, order);
> > -     }
> > -
> > -fallback:
> > -     return __alloc_swap_folio(vmf);
> > +     return orders;
> >   }
> >   #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
> > -static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > +static unsigned long thp_swapin_suitable_orders(struct vm_fault *vmf)
> >   {
> > -     return __alloc_swap_folio(vmf);
> > +     return 0;
> >   }
> >   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> >
> > @@ -4859,21 +4818,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (folio)
> >               swap_update_readahead(folio, vma, vmf->address);
> >       if (!folio) {
> > -             if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> > -                     folio =3D alloc_swap_folio(vmf);
> > -                     if (folio) {
> > -                             /*
> > -                              * folio is charged, so swapin can only f=
ail due
> > -                              * to raced swapin and return NULL.
> > -                              */
> > -                             swapcache =3D swapin_folio(entry, folio);
> > -                             if (swapcache !=3D folio)
> > -                                     folio_put(folio);
> > -                             folio =3D swapcache;
> > -                     }
> > -             } else {
> > +             /* Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devic=
es */
> > +             if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
> > +                     folio =3D swapin_entry(entry, GFP_HIGHUSER_MOVABL=
E,
> > +                                          thp_swapin_suitable_orders(v=
mf),
> > +                                          vmf, NULL, 0);
> > +             else
> >                       folio =3D swapin_readahead(entry, GFP_HIGHUSER_MO=
VABLE, vmf);
> > -             }
> >
> >               if (!folio) {
> >                       /*
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 5916acf594a8..17e3da11bb1d 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -159,7 +159,7 @@ static unsigned long shmem_default_max_inodes(void)
> >
> >   static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
> >                       struct folio **foliop, enum sgp_type sgp, gfp_t g=
fp,
> > -                     struct vm_area_struct *vma, vm_fault_t *fault_typ=
e);
> > +                     struct vm_fault *vmf, vm_fault_t *fault_type);
> >
> >   static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
> >   {
> > @@ -2017,68 +2017,24 @@ static struct folio *shmem_alloc_and_add_folio(=
struct vm_fault *vmf,
> >   }
> >
> >   static struct folio *shmem_swap_alloc_folio(struct inode *inode,
> > -             struct vm_area_struct *vma, pgoff_t index,
> > +             struct vm_fault *vmf, pgoff_t index,
> >               swp_entry_t entry, int order, gfp_t gfp)
> >   {
> > +     pgoff_t ilx;
> > +     struct folio *folio;
> > +     struct mempolicy *mpol;
> > +     unsigned long orders =3D BIT(order);
> >       struct shmem_inode_info *info =3D SHMEM_I(inode);
> > -     struct folio *new, *swapcache;
> > -     int nr_pages =3D 1 << order;
> > -     gfp_t alloc_gfp =3D gfp;
> > -
> > -     if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> > -             if (WARN_ON_ONCE(order))
> > -                     return ERR_PTR(-EINVAL);
> > -     } else if (order) {
> > -             /*
> > -              * If uffd is active for the vma, we need per-page fault
> > -              * fidelity to maintain the uffd semantics, then fallback
> > -              * to swapin order-0 folio, as well as for zswap case.
> > -              * Any existing sub folio in the swap cache also blocks
> > -              * mTHP swapin.
> > -              */
> > -             if ((vma && unlikely(userfaultfd_armed(vma))) ||
> > -                  !zswap_never_enabled() ||
> > -                  non_swapcache_batch(entry, nr_pages) !=3D nr_pages)
> > -                     goto fallback;
> >
> > -             alloc_gfp =3D thp_limit_gfp_mask(vma_thp_gfp_mask(vma), g=
fp);
> > -     }
> > -retry:
> > -     new =3D shmem_alloc_folio(alloc_gfp, order, info, index);
> > -     if (!new) {
> > -             new =3D ERR_PTR(-ENOMEM);
> > -             goto fallback;
> > -     }
> > +     if ((vmf && unlikely(userfaultfd_armed(vmf->vma))) ||
> > +          !zswap_never_enabled())
> > +             orders =3D 0;
> >
> > -     if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
> > -                                        alloc_gfp, entry)) {
> > -             folio_put(new);
> > -             new =3D ERR_PTR(-ENOMEM);
> > -             goto fallback;
> > -     }
> > +     mpol =3D shmem_get_pgoff_policy(info, index, order, &ilx);
> > +     folio =3D swapin_entry(entry, gfp, orders, vmf, mpol, ilx);
> > +     mpol_cond_put(mpol);
> >
> > -     swapcache =3D swapin_folio(entry, new);
> > -     if (swapcache !=3D new) {
> > -             folio_put(new);
> > -             if (!swapcache) {
> > -                     /*
> > -                      * The new folio is charged already, swapin can
> > -                      * only fail due to another raced swapin.
> > -                      */
> > -                     new =3D ERR_PTR(-EEXIST);
> > -                     goto fallback;
> > -             }
> > -     }
> > -     return swapcache;
> > -fallback:
> > -     /* Order 0 swapin failed, nothing to fallback to, abort */
> > -     if (!order)
> > -             return new;
> > -     entry.val +=3D index - round_down(index, nr_pages);
> > -     alloc_gfp =3D gfp;
> > -     nr_pages =3D 1;
> > -     order =3D 0;
> > -     goto retry;
> > +     return folio;
> >   }
>
> IIUC, in the __swap_cache_alloc() implementation in patch 4, when shmem
> swapin falls back to order 0, it doesn't adjust the swap entry value
> like here. Because the original swap entry may not correspond to the
> swap entry for the order 0 index.
>
> Of course, I haven't tested this yet, just pointing it out for you to
> double check.

Thanks for pointing it out. No worry, we have the below change in this
commit already:

                        /* Direct swapin skipping swap cache & readahead */
-                       folio =3D shmem_swap_alloc_folio(inode, vma, index,
-                                                      index_entry, order, =
gfp);
-                       if (IS_ERR(folio)) {
-                               error =3D PTR_ERR(folio);
-                               folio =3D NULL;
-                               goto failed;
-                       }
+                       folio =3D shmem_swap_alloc_folio(inode, vmf, index,
+                                                      swap, order, gfp);

It's using swap instead of index_entry now, so __swap_cache_alloc will
do the round down for large order instead and skip the round_down if
ordedr is zero. So we are fine here.

