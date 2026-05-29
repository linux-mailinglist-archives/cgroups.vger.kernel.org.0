Return-Path: <cgroups+bounces-16457-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B+iJXbiGWpmzggAu9opvQ
	(envelope-from <cgroups+bounces-16457-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:01:10 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B36079D6
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E9CA300D33C
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 19:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A2401A2E;
	Fri, 29 May 2026 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWJSfwbW"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99A4421A13
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780081259; cv=pass; b=V2V1hpz6GWHYAUkWb6mcqTXqQMItwD/jdBiBBFTa7qejIC4vAFu8NF2p4tknlb1gv+pOpUOXX7qxzKLANaDecIYfgVIorLHyWCxr3lteBehe7IOPcuUBbu3woxnueS7X3/wIDFUkXv+oIi3cpWWqfkmYi1zBlptOJ0+F0JWJ+eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780081259; c=relaxed/simple;
	bh=U+CLdUwJYmp9u2UBQGu4kBpkDzb14h2E9s7VyLlBDxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWDS5lZgeGcayCDhrpDHmvdPuQm44iV3ICzlKNRCfNGj62ee72bi5kJ6B78r+5W8S2BrdIbdHmZEi+aaKJXIiU7IyrBf/g/v8jP7e2AIUqRuUgrZmx/BgpwroKAAFFfVrzMVCErbBwWylibk/vhbea+PsOWrolm/Hejqx5OwRH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWJSfwbW; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so9061237f8f.2
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 12:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780081228; cv=none;
        d=google.com; s=arc-20240605;
        b=VLo2V9TLnk4+h9MnhwYLuoRSaH7dkl5gORP4k2fG1yp6fGZoT6yLEAQR6fHxrUK94Z
         nIC5qGhDv3pt/sQYr9otnVk+7myKcDafbd2w9MPl0V2d18R9AwIfNNkS19h1gXip5Tcl
         ObTCvMxX3ICXdEaIwGa8waegQb0bQTqAd37Mgw0S1s1PAlCTAAVNSlEB4x6v0RaANLA/
         6ldHuc8ekiRti3mvgNAuq/CdpmRhTQzJ6jTS/O3KyaLm2lK7PedtfD21TSgiw7pv7CJx
         NYR1eRbGzbw3ic9EmvcVdD5PLJR9DwPVyfjaiS2pPcQ/aQXmU6d4SrbAjRQ8xdYWyw+Q
         ChvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aGQR4YysPBB/foRQIvAUmjWKvFtUy/aEBc6VLae5pA0=;
        fh=41dSEHwKji921QYTfE/xY2j4ezfkMkQLKWPHtUN5JwY=;
        b=Xm/Esxuaq9o/26BGdFemfelV9UkPuLCWWYzc8JzN3GLMf+5ZfP0liOvzaaDkqxhE2j
         aKtGXMKnWHcglYnO7xfRmPBGACh464IKaBFKVjdMuJ+QXDSNu1U0rQ5x9ZfbRpdQNoBZ
         o/4pMU2aqyi7JkI1j/pPHha342anZKLVF2leDv7qSe2P5I0rSYiCj/RZeISYMXQB6e18
         LXkkI8Zt+xNxHeJPjDV8c/Zc3wissn2Id4Opdn85QIIxPyHaP8apV3GquTvqgR1PaBch
         xkDJOrI201Pm+aj6QuwG2RnM9E7E3E4rPcYKmAp4kdCoz5Ri3HXZVTLvzTY+jEL8wtUU
         qw+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780081228; x=1780686028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGQR4YysPBB/foRQIvAUmjWKvFtUy/aEBc6VLae5pA0=;
        b=WWJSfwbW/U29pX3o6LAB3749ekUA8v725wkFpQgSBGLewLQn8X/F2ph2zK4gNfWlGl
         bRY86BVdw4avriaXQEMVtLqFjE8TTx6U7dcRg6202f7tfnwtp6ChQMSf9UXKL1E8cH/3
         yb3rBQDRnmqjBGoy3Q/iKPe1/x/tdLe1hVwUyVr4grrmhOEZA6/E0cpFa6TR7j0FNSXt
         KPWPqIcvBfqIhTc6jtzEPYaBUMdvNMB9h5wcnVs6E3Tz0A7TIP+iH16pVCMF9WPk2yZS
         s0dS2eqmLzCGWzuOkosW3MezOKqVI1HO/LOGPuP5Op9oNW9ReNlnI6Uagxea22Tkzjf6
         6B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780081228; x=1780686028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aGQR4YysPBB/foRQIvAUmjWKvFtUy/aEBc6VLae5pA0=;
        b=CRN+y1t/6ifA6LqzMe3TwhaC4r7Ir38UjE43XU3SNZbPfnx71HKYEAknxD/sCWQvhc
         5xHfhi8SxX6LERBgMP71hwvM6oiTO3S0hDRVFDK6K6Ru3qn/xgOJL6C7V2SbZAQ/uShE
         VuMTXa7X9IeLJhkUtqNpVQ3pnP2u5Y6eNlt9bng17ZvydSFHCkeF1ZNo20Zapokqtb2m
         GosaCpQsI34W1G9pk7HStzXnXUivePVGrSnBv4arz8t5K2tb4H8K4Wr+0w98xCn1UxYX
         q7ubHJpvTnj9vY2WK4FaVHkr7MyHw1L9WpuWnDYtmkRQ6/vpa7x+MpKKPMjgEBHmIS7h
         I8Xw==
X-Forwarded-Encrypted: i=1; AFNElJ8VbM+2Wuah2cVmTdxS5uFRokar7zWzSBAMB+t0Gt0qRCr1/ZOgFrYNiWAE3Xq91xq7u4t+eWbf@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLRqxa6nKL4LqoE7oewQkSSBu2huenRyFHXwlqPDnUXy33wAQ
	1eq4cehpODhijwG+90YNv3K5qedsBbXgZpeEtoCHEIB36lDemDrfPE0P0kzAoyiB2a1tLGLRm2p
	FO90dWwIw5exhMiCU10ikRgthByiQxro=
X-Gm-Gg: Acq92OHeiYyNJ1tbEMmJ7+UiCvJrAMT6NyRHU/xrbJpBhnNFvpDc14V8T0j9z3mDmJD
	JaFYvmAH1NLRNE2kWIoNuHYdb/OPDm5QyrM8z2UJJiZ8EZLfGERHOYnZO5Ubv8xS/Vk6NyMjhD9
	4nqXqTpWV8CfifYWkPhFOfX9tj+P46Guipvb48ZJy4Da4q6Xj7Mx2OHBS54ymbdLQSW0gBD2j6x
	ClTxJNFStoxtoPDhUFmD74cViWW82UDvp4VTErg7RlC0PHmjjmTs0ORSZvNjT50fPpGaI2Hik0E
	4GFKmx1cyEassMBJrkyRtADzL2Wq11XrghoD3CvDUwTJBmTMrjkvZzX53YWN
X-Received: by 2002:a5d:6e42:0:b0:45e:ec27:b4b0 with SMTP id
 ffacd0b85a97d-45ef6b6b9e5mr1263048f8f.18.1780081227932; Fri, 29 May 2026
 12:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com> <tencent_69E7033C2446FE6E922D28B82E9F59142D09@qq.com>
In-Reply-To: <tencent_69E7033C2446FE6E922D28B82E9F59142D09@qq.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 12:00:16 -0700
X-Gm-Features: AVHnY4Lmd5EuNAmRswfTBPzH28gWST3OFE2RsUoUHLPyi7DvUKM0_DWVHRndTho
Message-ID: <CAKEwX=O_Jt3aCxocDoY1h5AY=-eOYnj_0saQ4rMbdfnLzPAFxw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/9] mm: add common locality admission for zswap
 large swapin
To: fujunjie <fujunjie1@qq.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@meta.com>, Kairui Song <kasong@tencent.com>, 
	Usama Arif <usamaarif642@gmail.com>, Chris Li <chrisl@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16457-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,meta.com,tencent.com,gmail.com,kernel.org,cmpxchg.org,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,qq.com:email]
X-Rspamd-Queue-Id: 0B9B36079D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 5:19=E2=80=AFAM fujunjie <fujunjie1@qq.com> wrote:
>
> Fully zswap-backed ranges are safe to load as a large folio only when
> the caller has a reason to expect the neighbouring slots to be useful.
> Otherwise a sparse refault can turn one 4K demand fault into a 64K
> decompression and swapcache fill.
>
> Add a common admission gate for zswap-backed large swapin. The common
> layer keeps backend checks, the 64K cap, recent-refault rejection, and
> zswap reclaim-pressure rejection. It consumes a caller-provided locality
> order mask instead of looking at anon or shmem state directly.

Can you add more documentation about these policies, both in patch
changelog and in code? I'm pretty confused by the
zswap_pool_reclaim_pressure heuristics, for e.g

>
> Callers pass no locality evidence for now, so this patch only installs
> the common policy hook. Later patches add anon and shmem producers.
>
> Signed-off-by: fujunjie <fujunjie1@qq.com>
> ---
>  mm/memory.c     |   2 +-
>  mm/shmem.c      |   2 +-
>  mm/swap.h       |   8 ++--
>  mm/swap_state.c | 118 ++++++++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 117 insertions(+), 13 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d73a19692dea..92a82008d583 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4849,7 +4849,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
>                         folio =3D swapin_sync(entry, GFP_HIGHUSER_MOVABLE=
,
>                                             thp_swapin_suitable_orders(vm=
f) | BIT(0),
> -                                           vmf, NULL, 0);
> +                                           0, vmf, NULL, 0);
>                 else
>                         folio =3D swapin_readahead(entry, GFP_HIGHUSER_MO=
VABLE, vmf);
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 56c23a7b15c7..fa99b48ed62b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2031,7 +2031,7 @@ static struct folio *shmem_swap_alloc_folio(struct =
inode *inode,
>
>  again:
>         mpol =3D shmem_get_pgoff_policy(info, index, order, &ilx);
> -       folio =3D swapin_sync(entry, gfp, BIT(order), vmf, mpol, ilx);
> +       folio =3D swapin_sync(entry, gfp, BIT(order), 0, vmf, mpol, ilx);
>         mpol_cond_put(mpol);
>
>         if (!IS_ERR(folio))
> diff --git a/mm/swap.h b/mm/swap.h
> index ea7e1f3c4410..dd35a310d06d 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -323,9 +323,10 @@ struct folio *read_swap_cache_async(swp_entry_t entr=
y, gfp_t gfp_mask,
>  struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>                 struct mempolicy *mpol, pgoff_t ilx);
>  struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
> -               struct vm_fault *vmf);
> +                       struct vm_fault *vmf);
>  struct folio *swapin_sync(swp_entry_t entry, gfp_t flag, unsigned long o=
rders,
> -                          struct vm_fault *vmf, struct mempolicy *mpol, =
pgoff_t ilx);
> +                         unsigned long locality_orders, struct vm_fault =
*vmf,
> +                         struct mempolicy *mpol, pgoff_t ilx);
>  void swap_update_readahead(struct folio *folio, struct vm_area_struct *v=
ma,
>                            unsigned long addr);
>
> @@ -418,7 +419,8 @@ static inline struct folio *swapin_readahead(swp_entr=
y_t swp, gfp_t gfp_mask,
>
>  static inline struct folio *swapin_sync(
>         swp_entry_t entry, gfp_t flag, unsigned long orders,
> -       struct vm_fault *vmf, struct mempolicy *mpol, pgoff_t ilx)
> +       unsigned long locality_orders, struct vm_fault *vmf,
> +       struct mempolicy *mpol, pgoff_t ilx)
>  {
>         return NULL;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index f03ad4832f16..5a4ca289009a 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -21,6 +21,7 @@
>  #include <linux/migrate.h>
>  #include <linux/vmalloc.h>
>  #include <linux/huge_mm.h>
> +#include <linux/sizes.h>
>  #include <linux/zswap.h>
>  #include <linux/shmem_fs.h>
>  #include "internal.h"
> @@ -556,6 +557,24 @@ static struct folio *swap_cache_alloc_speculative_fo=
lio(swp_entry_t targ_entry,
>                                         mpol, ilx, true);
>  }
>
> +/*
> + * Initial conservative cap for speculative zswap large swapin. Locality
> + * evidence is supplied by the caller or by generic VMA hints; the commo=
n
> + * swapin layer keeps backend safety and pressure decisions here.
> + */
> +#define SWAPIN_ZSWAP_MAX_SIZE                  SZ_64K
> +#if PAGE_SIZE < SWAPIN_ZSWAP_MAX_SIZE
> +#define SWAPIN_ZSWAP_MAX_ORDER                 \
> +       ilog2(SWAPIN_ZSWAP_MAX_SIZE / PAGE_SIZE)
> +#else
> +#define SWAPIN_ZSWAP_MAX_ORDER                 0
> +#endif
> +
> +struct zswap_admit_ctx {
> +       bool pressure_checked;
> +       bool reclaim_pressure;
> +};
> +
>  static bool swapin_zeromap_same(swp_entry_t entry, unsigned int nr_pages=
)
>  {
>         unsigned int ci_start =3D swp_cluster_offset(entry);
> @@ -586,11 +605,84 @@ static bool swapin_zeromap_same(swp_entry_t entry, =
unsigned int nr_pages)
>         return true;
>  }
>
> +static bool swapin_zswap_locality(struct vm_fault *vmf, unsigned int ord=
er,
> +                                 unsigned long locality_orders)
> +{
> +       struct vm_area_struct *vma =3D vmf ? vmf->vma : NULL;
> +
> +       if (!order || order > MAX_PAGE_ORDER)
> +               return false;
> +
> +       if (vma && (vma->vm_flags & VM_RAND_READ))
> +               return false;

what about VM_SEQ_READ?

> +
> +       return locality_orders & BIT(order);
> +}
> +
> +static bool swapin_zswap_refaulted(swp_entry_t entry, unsigned int nr_pa=
ges)

nit: this does not seem zswap-specific. Just call it
swapin_range_refaulted or sth like that, maybe?

> +{
> +       unsigned int type =3D swp_type(entry);
> +       pgoff_t offset =3D swp_offset(entry);
> +       unsigned int i;
> +
> +       for (i =3D 0; i < nr_pages; i++) {
> +               bool workingset;
> +               void *shadow;
> +
> +               shadow =3D swap_cache_get_shadow(swp_entry(type, offset +=
 i));

This seems inefficient. Can't we just lock the swap cluster once,
check all the shadow in the range, instead of repeatedly getting then
dropping the swap cluster lock?

> +               if (!shadow)
> +                       continue;
> +               if (workingset_test_recent(shadow, false, &workingset, fa=
lse) &&
> +                   workingset)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static bool swapin_zswap_admit(swp_entry_t entry,
> +                              unsigned int order, unsigned int nr_pages,
> +                              struct vm_fault *vmf,
> +                              unsigned long locality_orders,
> +                              struct zswap_admit_ctx *ctx)
> +{
> +       if (order > SWAPIN_ZSWAP_MAX_ORDER)
> +               return false;
> +
> +       /*
> +        * Treat zswap-backed large swapin as speculative. The common lay=
er
> +        * consumes caller-provided locality orders, but does not inspect
> +        * anon-specific PTE state or shmem-specific mapping state direct=
ly.
> +        */
> +       if (!swapin_zswap_locality(vmf, order, locality_orders))
> +               return false;
> +
> +       /*
> +        * A recent workingset refault shadow in the target range means r=
eclaim
> +        * already saw churn there. Keep the refault path narrow instead =
of
> +        * speculatively decompressing neighbouring slots.
> +        */
> +       if (swapin_zswap_refaulted(entry, nr_pages))
> +               return false;

Hmm this depends. If it's just a refault coming from a speculative
read (readhead or THP (z)swpin), which is then promptly discarded,
then yeah we should backoff here. But maybe the refaulted page is
workingset one?

But yeah I guess it is better to be cautious when you are uncertain :)


> +
> +       if (!ctx->pressure_checked) {
> +               ctx->reclaim_pressure =3D zswap_pool_reclaim_pressure();
> +               ctx->pressure_checked =3D true;
> +       }

Why do we backoff if there is zswap_pool_reclaim_pressure (which only
check if the pool is full ONCE in its lifetime)? What's the rationale
here?

> +       if (ctx->reclaim_pressure)
> +               return false;
> +
> +       return true;
> +}
> +
>  static unsigned long swapin_admit_orders(swp_entry_t entry,
> -                                        unsigned long orders)
> +                                        unsigned long orders,
> +                                        struct vm_fault *vmf,
> +                                        unsigned long locality_orders)
>  {
>         unsigned long candidates =3D orders & ~BIT(0);
>         unsigned long admitted =3D orders & BIT(0);
> +       struct zswap_admit_ctx zswap_ctx =3D {};
>         int order;
>
>         if (!candidates)
> @@ -616,9 +708,14 @@ static unsigned long swapin_admit_orders(swp_entry_t=
 entry,
>
>                 state =3D zswap_probe_range(range_entry, nr_pages);
>                 switch (state) {
> +               case ZSWAP_RANGE_ALL_ZSWAP:
> +                       admit =3D swapin_zswap_admit(range_entry, order,
> +                                                  nr_pages, vmf,
> +                                                  locality_orders,
> +                                                  &zswap_ctx);
> +                       break;
>                 case ZSWAP_RANGE_MIXED:
>                         break;
> -               case ZSWAP_RANGE_ALL_ZSWAP:
>                 case ZSWAP_RANGE_NEVER_ENABLED:
>                 case ZSWAP_RANGE_NO_ZSWAP:
>                         admit =3D true;
> @@ -769,8 +866,8 @@ static struct folio *swap_cache_read_folio(swp_entry_=
t entry, gfp_t gfp,
>         ret =3D swap_read_folio(folio, plug);
>         /*
>          * Swap readahead allocates order-0 folios. -EAGAIN is reserved f=
or
> -        * retryable large zswap backend races and must be handled by the
> -        * synchronous common swapin path.
> +        * retryable large zswap backend races and should never escape to=
 this
> +        * order-0 path.
>          */
>         VM_WARN_ON_ONCE(ret =3D=3D -EAGAIN);
>         if (readahead) {
> @@ -786,6 +883,7 @@ static struct folio *swap_cache_read_folio(swp_entry_=
t entry, gfp_t gfp,
>   * @entry: swap entry indicating the target slot
>   * @gfp: memory allocation flags
>   * @orders: allocation orders
> + * @locality_orders: orders with caller-provided locality evidence
>   * @vmf: fault information
>   * @mpol: NUMA memory allocation policy to be applied
>   * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
> @@ -794,16 +892,20 @@ static struct folio *swap_cache_read_folio(swp_entr=
y_t entry, gfp_t gfp,
>   * existing folio in the swap cache for @entry. This initiates the IO, t=
oo,
>   * if needed. @entry is rounded down if @orders allow large allocation.
>   *
> - * Context: Caller must ensure @entry is valid and pin the swap device w=
ith refcount.
> + * Context: Caller must ensure @entry is valid and pin the swap device w=
ith
> + * refcount.
>   * Return: Returns the folio on success, error code if failed.
>   */
> -struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp, unsigned long or=
ders,
> -                          struct vm_fault *vmf, struct mempolicy *mpol, =
pgoff_t ilx)
> +struct folio *swapin_sync(swp_entry_t entry, gfp_t gfp,
> +                         unsigned long orders,
> +                         unsigned long locality_orders,
> +                         struct vm_fault *vmf, struct mempolicy *mpol,
> +                         pgoff_t ilx)
>  {
>         struct folio *folio;
>         int ret;
>
> -       orders =3D swapin_admit_orders(entry, orders);
> +       orders =3D swapin_admit_orders(entry, orders, vmf, locality_order=
s);
>  again:
>         do {
>                 folio =3D swap_cache_get_folio(entry);
> --
> 2.34.1
>

