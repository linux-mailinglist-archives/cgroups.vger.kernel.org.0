Return-Path: <cgroups+bounces-16439-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GORmLvOnGWoIyQgAu9opvQ
	(envelope-from <cgroups+bounces-16439-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 16:51:31 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B654E603F82
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 16:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6AF6307D437
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3333ED13F;
	Fri, 29 May 2026 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4fnmHOX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8A3EAC84
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780065854; cv=pass; b=iAzGOSSlufLyjTOvowKYrOxGVak9IHA0lXNgHrugXnvLI7qQ/a4dGLD0bUP9RrAlmy1aI13mlwlclNSf6Ykkr79ZNRQqcWmkkxpoiXlvkLF33n7GlDDhMlGmrNA0i9uB2LICOZQxXrNRwFpSOyTYomL5zHr9CKVdWcKh+I/DBy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780065854; c=relaxed/simple;
	bh=ZMlUlOXe9c7G5c0G6bckWvx3txdC2cASx0GyRz7LbHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NgOYsOFSeJymYPjOS8MkqH28EmTXMpcijCWeinLolY8BEn61f+WT9JYHhno7R5LQKKkiUL/JwLqcXlxHwnLq5Z3PMfAa3/fI6HaiElxEBi54kr4pjeFt94/q3MdghiYlIjf1+Z8sPnHTwiSV//fYJqtmNhKnfc6gLLuEQ3aG0ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4fnmHOX; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so2380563866b.3
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 07:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780065850; cv=none;
        d=google.com; s=arc-20240605;
        b=TWrU+E/yXhCAWdyAd1txvKGnl2GSRyZT6dMgFnyhlKzqsz4CUJvqqbdoEI7rsxF6oQ
         xtnkivTCTb+X9/OJBZtZrkPBMaNX+7T++oLvGIF9rahiHMuKilIYBoKEVwQ7UMUfb4jU
         7/i2NjCMeoNAsBRzc8EhvUnD+yDyjmLhZyxLuR1C5keGCsiJAvJ8HlzOutYd9dJ1eGv7
         L06XUnhwNn5dWTo03Z+0IWhu+q/nLXL1poeaa0zSgqLfwHraayFgNgUnolKFg9gOMToU
         tem1dbh1jD8wIbGhIYZeTpqQYqUuIFTGehDimz25U9Sg5kzGo5BiBv6Ehv9tBURWRANE
         tiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xee0neRMxkEGWjOCgf0A+ajeM60T1isEWix9DcnYtQ4=;
        fh=p+PKnV0M1HwNwY+Qx4hnCfflUT8c1LNj1VO3uf+/mWg=;
        b=gV/KiXuYcsINjMxLoXJ5OG4+sHqaxaRSWkQfk1GGzR25as3xYggaPynZSDYSnb8fXT
         C31+n85+hiAZIUWHWYzxNIeCfsKniBx9pj0RC/AJOoHZaGCHGZpijVmCj1LDKLQHdNiy
         HFfFw564pQVWAQWd4ny7gi4MGUezM+/DLy1SSGtNIxoM+wo9YHBigoMMfFAbItvZqvar
         qKEcefsP412Ig6RfubZRsZW95WQVTv/ipVQsRm9lBRVOHRkucmGxa8KCqKj/scXHP94z
         nRSWe09V51Zeu8Sr7AZm/cXN/Z+Q89d6SvCXEzmWaEIfGndIIdfe04CuUOXLHOA0ASKr
         WEpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780065850; x=1780670650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xee0neRMxkEGWjOCgf0A+ajeM60T1isEWix9DcnYtQ4=;
        b=h4fnmHOXugXcPqKH+FhPRfa0ee5LyB/9TrGUSfMf8aUzwe3n2Z0auCqEcao+8iB+wU
         TYq/l8LPcn0LqW1XGuMwzi/RO3xw4viqpsgGDfGJifCXxfknSJUEDVwIBDzA3FKAN5Em
         HWsG4/vr/R6BYV+LCkKcfqR5V6TgoLjuDMdivo0I8vP3Ys3mESBChE4ySxF4Q8wax1FH
         uhLU3kfhpu3ZLXVfpUOMe7CbJZo4saC3fPY5S8se2RQxvkk05Ou9jaZW/cj5VzuyuxDt
         neTbp8M/MhZMTRJpLe2X9IX8rTzWGtfaSsa1yXGdB7w9yBuGRThJzQOa3PI10mC1mYnD
         RfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780065850; x=1780670650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xee0neRMxkEGWjOCgf0A+ajeM60T1isEWix9DcnYtQ4=;
        b=US7AMSj16baKmx8ab6fKDQWNIt77+SZhZXxsT4Jh51BzOUc3YiItsLp3Jh7z91ntWJ
         SSm/+zdAB2gRCMFx7wk+oU4Mtyuo5z4iXOGv4UsoRq4vSrsIHtszHEZGY4WCtFgjR1AM
         N80U/SB5b0FrW2twlF7uv9im0j9Ld/mYghYYVHEySpjD/WvLY7gBo5cCc0AgSiBdTBuf
         qL8W7kZ1GcY11BXEnkR9akh1RDxMMCF2kGjQSZliy+toTn1EdLSGIf5INBVBJWvEPGbs
         RcyHFPQlU77SqkBC9e/ihAGH+PpSbIeKObzkemu6kwOevC+HwG0VuYUDX8pWEsvlGqbK
         e67Q==
X-Forwarded-Encrypted: i=1; AFNElJ/b9J5WxMnHJxbE/6yofNUEFZFbCd3xrDMo+EdUOc5Iuo9/VYALew1Pq5MBAzPvt71iQDuRtOkC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+AMt3FUo+rvEz1jPtnsLVcfkFdzDKM9mce/jdBWtPbgRG5Jx
	k8jl3+qJfYSFLX3dclepJEgj37aAjB1yVoKLBowVMmLgl4biBdbGE8cwiiZeChppAwcTGdAI9G4
	8lCbdBH1Qh8WjXxf9tP18ll6I9Q4L0IM=
X-Gm-Gg: Acq92OHM4jH9aiKJ2dJ+nPxgWybsMqqFUlTYtABQtbrszpA5M6R3VWeXYZG+zqa6NSk
	6YVyZvjpo9RzueTubaOCytEP5TE6pofR+XBfa4dhAxbQpDvCRnI3reA90hoQPoDOSXThiYnC6KJ
	UeTiN4J92qapy1z3A5rT5G3OAtcPTYTiVjycmgq1Cc+yGnPTu1qGKG6IOvdAHkjyDjlvOdoQCkr
	UHDkDW5YMj/8uFakmLvNZsYy1tP45jK+x/OqclyGWml2Jt03AystpFKLOYbnW2f6za3HbOHDREW
	ilUyIxl7M8Yltw4WBG76tqC594GHIRu/LM8X2Y7KD6BPgWeRc0I=
X-Received: by 2002:a17:907:a68a:b0:bd5:2a43:b471 with SMTP id
 a640c23a62f3a-be9ccb8b34cmr202848866b.48.1780065849252; Fri, 29 May 2026
 07:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com> <tencent_EB78848E34DC7858C873193D67286ECD4B0A@qq.com>
In-Reply-To: <tencent_EB78848E34DC7858C873193D67286ECD4B0A@qq.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 29 May 2026 22:43:32 +0800
X-Gm-Features: AVHnY4KQ3LS9xvgeQfV41IMJNm14XsvQyrU_7jFjtxnCiD6FZQ0cqNPWPLweRic
Message-ID: <CAMgjq7AA_1esgtA8VyxaBLWBBRM12bCBpxO2Jch5OESBZSg--A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/9] mm: admit large swapin by backend range in swapin_sync()
To: fujunjie <fujunjie1@qq.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Alexandre Ghiti <alexghiti@meta.com>, Usama Arif <usamaarif642@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16439-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,meta.com,gmail.com,kernel.org,cmpxchg.org,google.com,linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,qq.com:email]
X-Rspamd-Queue-Id: B654E603F82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 8:26=E2=80=AFPM fujunjie <fujunjie1@qq.com> wrote:
>
> A large swapin can only read one folio when the whole range has compatibl=
e
> backing. Mixed zswap/disk ranges must not reach large-folio IO, and zswap
> range probes are only snapshots.
>
> Filter the orders passed to swap_cache_alloc_folio() in swapin_sync().
> Uniform zeromap ranges and all-disk ranges keep the existing large swapin
> path. Fully zswap-backed ranges may be tried. Mixed zswap/disk ranges fal=
l
> back before allocation.
>
> After a large swapcache folio is installed, recheck the zswap range and
> drop the fresh folio if it became mixed. Also consume -EAGAIN from
> swap_read_folio() the same way. Both cases retry order-0, where each slot
> can resolve its current backend independently.
>
> Signed-off-by: fujunjie <fujunjie1@qq.com>
> ---
>  mm/memcontrol-v1.c |   8 ++-
>  mm/memory.c        |  31 ++++++++-
>  mm/swap_state.c    | 169 ++++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 194 insertions(+), 14 deletions(-)
>
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index 765069211567..5b11b8055c66 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -682,8 +682,8 @@ void __memcg1_swapout(struct folio *folio, struct swa=
p_cluster_info *ci)
>   * memcg1_swapin - uncharge swap slot on swapin
>   * @folio: folio being swapped in
>   *
> - * Call this function after successfully adding the charged
> - * folio to swapcache.
> + * Call this after the charged folio has been added to swapcache and the=
 caller
> + * is no longer going to drop it back to swapped-out state.
>   *
>   * Context: The folio has to be in swap cache and locked.
>   */
> @@ -721,7 +721,9 @@ void memcg1_swapin(struct folio *folio)
>         id =3D __swap_cgroup_clear(ci, swp_cluster_offset(folio->swap),
>                                  nr_pages);
>         swap_cluster_unlock(ci);
> -       mem_cgroup_uncharge_swap(id, nr_pages);
> +
> +       if (id)
> +               mem_cgroup_uncharge_swap(id, nr_pages);
>  }
>  #endif
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 5a365492a9a2..d73a19692dea 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4538,6 +4538,24 @@ static inline bool should_try_to_free_swap(struct =
swap_info_struct *si,
>                 folio_ref_count(folio) =3D=3D (extra_refs + folio_nr_page=
s(folio));
>  }
>
> +static void memcg1_swapin_retry_folio(struct folio *folio,
> +                                     struct vm_fault *vmf)
> +{
> +       if (!folio_test_large(folio) || !folio_test_swapcache(folio))
> +               return;
> +
> +       if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
> +               if (!folio_trylock(folio))
> +                       return;
> +       } else {
> +               folio_lock(folio);
> +       }
> +
> +       if (folio_test_large(folio) && folio_test_swapcache(folio))
> +               memcg1_swapin(folio);
> +       folio_unlock(folio);
> +}
> +
>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
>  {
>         vmf->pte =3D pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> @@ -4857,8 +4875,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>
>         swapcache =3D folio;
>         ret |=3D folio_lock_or_retry(folio, vmf);
> -       if (ret & VM_FAULT_RETRY)
> +       if (ret & VM_FAULT_RETRY) {
> +               memcg1_swapin_retry_folio(folio, vmf);
>                 goto out_release;
> +       }
>
>         page =3D folio_file_page(folio, swp_offset(entry));
>         /*
> @@ -5067,6 +5087,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (unlikely(folio !=3D swapcache)) {
>                 folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSI=
VE);
>                 folio_add_lru_vma(folio, vma);
> +               if (folio_test_large(swapcache))
> +                       memcg1_swapin(swapcache);
>                 folio_put_swap(swapcache, NULL);
>         } else if (!folio_test_anon(folio)) {
>                 /*
> @@ -5076,6 +5098,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 VM_WARN_ON_ONCE_FOLIO(folio_nr_pages(folio) !=3D nr_pages=
, folio);
>                 VM_WARN_ON_ONCE_FOLIO(folio_mapped(folio), folio);
>                 folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
> +               if (folio_test_large(folio))
> +                       memcg1_swapin(folio);
>                 folio_put_swap(folio, NULL);
>         } else {
>                 VM_WARN_ON_ONCE(nr_pages !=3D 1 && nr_pages !=3D folio_nr=
_pages(folio));
> @@ -5132,8 +5156,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out_page:
> -       if (folio_test_swapcache(folio))
> +       if (folio_test_swapcache(folio)) {
> +               if (folio_test_large(folio))
> +                       memcg1_swapin(folio);
>                 folio_free_swap(folio);
> +       }
>         folio_unlock(folio);
>  out_release:
>         folio_put(folio);
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d37097913b30..f03ad4832f16 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -21,6 +21,7 @@
>  #include <linux/migrate.h>
>  #include <linux/vmalloc.h>
>  #include <linux/huge_mm.h>
> +#include <linux/zswap.h>
>  #include <linux/shmem_fs.h>
>  #include "internal.h"
>  #include "swap_table.h"
> @@ -403,7 +404,8 @@ void __swap_cache_replace_folio(struct swap_cluster_i=
nfo *ci,
>  static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
>                                         swp_entry_t targ_entry, gfp_t gfp=
,
>                                         unsigned int order, struct vm_fau=
lt *vmf,
> -                                       struct mempolicy *mpol, pgoff_t i=
lx)
> +                                       struct mempolicy *mpol, pgoff_t i=
lx,
> +                                       bool defer_memcg1_swapin)

Hi Fujunjie,

Thanks for the update, but this whole defer_memcg1_swapin thing is so
ugly I don't think this is the right way at all.

If you really need this, maybe you can always defer the memcg1
uncharge, I don't see why we need to treat large folio differently.
This charge doesn't effect the memory pressure, the reason we uncharge
memcg1's swap counter is to avoid long pinning swap cache holding the
swap cache of a cgroup so the cgroup will no longer be able to swap
out more folios. Deferring it won't hurt.

>  {
>         int err;
>         swp_entry_t entry;
> @@ -466,7 +468,8 @@ static struct folio *__swap_cache_alloc(struct swap_c=
luster_info *ci,
>         }
>
>         /* memsw uncharges swap when folio is added to swap cache */
> -       memcg1_swapin(folio);
> +       if (!defer_memcg1_swapin || !order)
> +               memcg1_swapin(folio);
>         if (shadow)
>                 workingset_refault(folio, shadow);
>
> @@ -495,9 +498,12 @@ static struct folio *__swap_cache_alloc(struct swap_=
cluster_info *ci,
>   * Return: Returns the folio if allocation succeeded and folio is in the=
 swap
>   * cache. Returns error code if failed due to race, OOM or invalid argum=
ents.
>   */
> -struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
> -                                    unsigned long orders, struct vm_faul=
t *vmf,
> -                                    struct mempolicy *mpol, pgoff_t ilx)
> +static struct folio *__swap_cache_alloc_folio(swp_entry_t targ_entry,
> +                                             gfp_t gfp, unsigned long or=
ders,
> +                                             struct vm_fault *vmf,
> +                                             struct mempolicy *mpol,
> +                                             pgoff_t ilx,
> +                                             bool defer_memcg1_swapin)
>  {
>         int order, err;
>         struct folio *ret;
> @@ -512,7 +518,8 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ=
_entry, gfp_t gfp,
>
>         do {
>                 ret =3D __swap_cache_alloc(ci, targ_entry, gfp, order,
> -                                        vmf, mpol, ilx);
> +                                        vmf, mpol, ilx,
> +                                        defer_memcg1_swapin);
>                 if (!IS_ERR(ret))
>                         break;
>                 err =3D PTR_ERR(ret);
> @@ -525,6 +532,124 @@ struct folio *swap_cache_alloc_folio(swp_entry_t ta=
rg_entry, gfp_t gfp,
>         return ret;
>  }
>
> +struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
> +                                    unsigned long orders, struct vm_faul=
t *vmf,
> +                                    struct mempolicy *mpol, pgoff_t ilx)
> +{
> +       return __swap_cache_alloc_folio(targ_entry, gfp, orders, vmf,
> +                                       mpol, ilx, false);
> +}
> +
> +static struct folio *swap_cache_alloc_speculative_folio(swp_entry_t targ=
_entry,
> +                                                       gfp_t gfp,
> +                                                       unsigned long ord=
ers,
> +                                                       struct vm_fault *=
vmf,
> +                                                       struct mempolicy =
*mpol,
> +                                                       pgoff_t ilx)
> +{
> +       /*
> +        * Speculative large swapin may drop this fresh swapcache folio a=
nd
> +        * retry order-0 after backend or page-table revalidation. Keep t=
he
> +        * cgroup v1 memsw swap owner until the caller commits the folio.
> +        */
> +       return __swap_cache_alloc_folio(targ_entry, gfp, orders, vmf,
> +                                       mpol, ilx, true);
> +}
> +
> +static bool swapin_zeromap_same(swp_entry_t entry, unsigned int nr_pages=
)
> +{
> +       unsigned int ci_start =3D swp_cluster_offset(entry);
> +       struct swap_cluster_info *ci =3D __swap_entry_to_cluster(entry);
> +       bool is_zero;
> +       unsigned int i;
> +
> +       if (ci_start + nr_pages > SWAPFILE_CLUSTER) {
> +               VM_WARN_ON_ONCE(1);
> +               return false;
> +       }
> +
> +       rcu_read_lock();
> +       if (!rcu_dereference(ci->table)) {
> +               rcu_read_unlock();
> +               return true;
> +       }
> +
> +       is_zero =3D __swap_table_test_zero(ci, ci_start);
> +       for (i =3D 1; i < nr_pages; i++) {
> +               if (is_zero !=3D __swap_table_test_zero(ci, ci_start + i)=
) {
> +                       rcu_read_unlock();
> +                       return false;
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return true;
> +}
> +
> +static unsigned long swapin_admit_orders(swp_entry_t entry,
> +                                        unsigned long orders)

And this swapin_admit_orders chunk doesn't look good either...

> +{
> +       unsigned long candidates =3D orders & ~BIT(0);
> +       unsigned long admitted =3D orders & BIT(0);
> +       int order;
> +
> +       if (!candidates)
> +               return orders;
> +
> +       while (candidates) {
> +               enum zswap_range_state state;
> +               unsigned int nr_pages;
> +               swp_entry_t range_entry;
> +               bool admit =3D false;
> +
> +               order =3D fls_long(candidates) - 1;
> +               if (order > MAX_PAGE_ORDER) {
> +                       candidates &=3D ~BIT(order);
> +                       continue;
> +               }
> +
> +               nr_pages =3D 1U << order;
> +               range_entry =3D swp_entry(swp_type(entry),
> +                                       round_down(swp_offset(entry), nr_=
pages));
> +               if (!swapin_zeromap_same(range_entry, nr_pages))
> +                       goto next;

I think you don't need to test zeromap at all? __swap_cache_alloc
handles that already.

> +
> +               state =3D zswap_probe_range(range_entry, nr_pages);

If you just move the zswap_probe_range into __swap_cache_alloc and do
fallback there (or maybe you can shrink the order faster), then this
two new helpers are all redundant.

> +               switch (state) {
> +               case ZSWAP_RANGE_MIXED:
> +                       break;
> +               case ZSWAP_RANGE_ALL_ZSWAP:
> +               case ZSWAP_RANGE_NEVER_ENABLED:
> +               case ZSWAP_RANGE_NO_ZSWAP:
> +                       admit =3D true;
> +                       break;
> +               }
> +
> +next:
> +               if (admit)
> +                       admitted |=3D BIT(order);
> +               else
> +                       count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
> +               candidates &=3D ~BIT(order);
> +       }
> +
> +       return admitted ? admitted : BIT(0);
> +}
> +
> +static bool zswap_needs_order0_retry(struct folio *folio)
> +{
> +       if (!folio_test_large(folio))
> +               return false;
> +
> +       /*
> +        * Admission sees only an advisory zswap snapshot. Recheck after =
the
> +        * large swapcache folio is installed; if the range became mixed,=
 drop
> +        * the fresh folio before IO and let order-0 handle each slot.
> +        */
> +       return zswap_probe_range(folio->swap, folio_nr_pages(folio)) =3D=
=3D
> +              ZSWAP_RANGE_MIXED;
> +}
> +

Again, I think you can just probe the suitable size in
__swap_cache_alloc directly, that way, we avoid the diverge of sync /
non-sync device, and avoid the whole chunk making the code much
simplier too, just like what we are alreadying doing for zero map in
__swap_cache_alloc, or am I over simpliying it?

