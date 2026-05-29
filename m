Return-Path: <cgroups+bounces-16458-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PO6KX/nGWpDzwgAu9opvQ
	(envelope-from <cgroups+bounces-16458-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:22:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4EE607C90
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 21:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF0A43023C1D
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F878372EF7;
	Fri, 29 May 2026 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzAD5P8G"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330383AA1A6
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 19:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780082552; cv=pass; b=SY8XqE8ZU24wagdbs5uQ2XiaADqYRwDU74Nhl1XDqfxvBZ5IF0o3HAUuCLo5dEBDXrcAqHErkzU0km2/+IEQg+lp2dOsEBDdbT6GXTM973Uj9p1EimAoCjDF+G4m41xrkAp+RrsC8imFZbRaU2YAoGDTeD8Sju0nnutL3EB4EEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780082552; c=relaxed/simple;
	bh=EfCBVdRQMfaKQxC19S63AcJjOZsMHlfdKP5M7Inq26k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8Um2t4nuVXpdA3FZbd5NJz7CZweB9ra/O9n2V6iTrf9I6w9OP9OvbS/yBEEk9M5D0MLpvVL3UbTaxBhV/hleB4wK0gVwPxNTht19hNlfKDF77V62Oc3/xHEFWPTakmayRZyyRfOKIaQ5MuunKi3Vc9rJgIRFE8l1TsRuVYGlRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzAD5P8G; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ee1a56328so2445264f8f.3
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 12:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780082549; cv=none;
        d=google.com; s=arc-20240605;
        b=ie8G04EwNNdB9vT6fx0+Uun5cXsGCoMmcHxWE47YkjcWjqZPCULheKB10acjicB9b3
         Nx54GfqkrcYu1k17hBNNee9JnY8WPUWt8epbaAfQ8sqVxQml3uSflUD1RkPa3k70h8Z0
         EK15ytR8qJwEslOEc62xDJtwnl1nRImZlY2c5I4YGdNT5ZgsssTWXScmU5MS6gtFZvMZ
         89mHdsDVsIhXB/VIQ7Nks95s4uU0XQrtoQcA6wdw79Tksw/x0iq2I1YY7QAfaYL0CuVO
         BnL3zWVhIxxI04b4hKHuQXbH1h2NHd2RTtjyN9a/bTV+I0mJ0zxJLzXm2XGkSzK6qhpq
         LzGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/6XCh02b00Qi+J9V1RsLv+n1OUX7vNSIf/jjmHUvXP8=;
        fh=fXwusd7LAWW+7EXixKs9Pr7Ptoctsmx2xbAwugEwSoU=;
        b=AhQZGCgVd3zHYeypOLUH7pQHjgOTcE/yP83usAMDQ3K2+rdU1aSry4vhhwK4tBtD+k
         WHuUgmDnN7JEj6LmNsHYuAYHqFOb1Vshfg58nc4lRlhIgd8P2PKOcocA22PD0TLfQhWS
         GzOEv6Z7Tvpe/QEaZQsbwTIsagm40ycrbTuNUJKIkJtN4nL4BXO513nSUSIyCl51Hu1q
         ToEmunBd94J1qlgv13gQ917D3BAcSog66uTbATyFJ2PFOMrg9vqcOlRNCNMswgbCu5oI
         lu244ikSqISbmTvIVcDT6z+XRDZHxyOlolvECXW1fu0H5joJYlERk/SEbhRdaRQ1+HTs
         xVIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780082549; x=1780687349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6XCh02b00Qi+J9V1RsLv+n1OUX7vNSIf/jjmHUvXP8=;
        b=RzAD5P8Gq8PtNcLshv3s+iEBNLIWptmg85dioseCz8mPxiVYAcaTSSSYIECXWCQYkk
         QTZUJQjESbyjaLvgujvZeR7xxapw3A2t1oU6qVpHWGCOYq1BfUFqHBaCCF7HjP7NJf5Y
         S/1csqYzlNowyuzTSYtEMf32O9liHKFEpaNj389hziZGCltMV+7zOFJxELfIvfadiCiT
         XtQdlc1Dx0z2PvHKAiMxnRlGt/WcwoVnUOgK2CBMx9uqAg1XRuY9WiqzClxOo0ABKzQy
         7fFlHWjKL1mslcDD9dmOzLHwCqSeRzc/XlZISt/xGly26zS/nrAitYFGuuX761UoXYIL
         OKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780082549; x=1780687349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6XCh02b00Qi+J9V1RsLv+n1OUX7vNSIf/jjmHUvXP8=;
        b=iqB9Ii5DHeMwiZJvulVHu27u4wD2mDd8N4VeyOp54NaXBvpgi9PuocaawatYB+xa0X
         NJxeFbg6dv1FlUh3BNS1udvgiNWVNEYbgs1gs6dw3FlUrkXC17Fd0iOQGuSoFZKz9Hbl
         8C3gt7cFLSuKgMmeUwh4l1H9wPcvM/t0la2yhNOu1MeGFzxU3jt5YleX2D1G7G2A5ef/
         JHvOM/nflPMzDAO0Fw12SwHYdEMHFxYzNeK8eNN/ZuK9iXRfRUdQ2++5Uz/7QhoP0ODB
         ElD60X1vgWWaWQXIoovcJUg7VGkBD6xxFnbGC6e3JctDUoZDxoaLJbmWJEPx5ziHoAe0
         gjBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+M4RQxbZ0wp341cKqm/r7rQAwdUx44sIZq6/4BCJUoJCSJqiRkQqJ0mCVOV6c5+U+tCpijSsdL@vger.kernel.org
X-Gm-Message-State: AOJu0YzAXgbarL56B3ZGGudRUw6EH61yDez1QkzPII7NSFvDnDoNshNh
	QElw1DCTo9sQ/HjVld58R6ZhBnno/SPHxYa1fPDUieU2RJBHppgoHXKn5olgY9H1fkdTqUOShX5
	67MZaCyz5t38oD9/gAn1NeoqS2+Idl1k=
X-Gm-Gg: Acq92OEvzaJyiriG09bueQI12FCfGBpWMpXLOYu8vhMlkjaNzC9pY608s7c7fkEqNji
	BUA7TNAs0iTHwS1UHhnWw1BFI4tLp5Lx5BcXKeQRDnHBAzBnuGrrzSNhTGkYm+1B9z9r2092yiu
	VrhqRl5+No1yB0kHNw41wVP2nJ9myYOMDJMqcrY+liNtik3J8PKH6vaN63IodNsTUP1rkYJacmg
	2U69ReIfpUf1HxD340f2ucicbYOQtTjxYcPh27tAoBNld6Ke5IgSI5uVL2q2xOCh/sikJ4aBcGT
	0c62sAFOaA9Yj7bo4k+X1LKverpHhlNk36YbPcnqDCwuIS6hpQ==
X-Received: by 2002:a5d:58f6:0:b0:45e:e50e:3bc with SMTP id
 ffacd0b85a97d-45ef6b71573mr1443359f8f.29.1780082548503; Fri, 29 May 2026
 12:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com> <tencent_913470853E9B289ECF0379248E24DFB4590A@qq.com>
In-Reply-To: <tencent_913470853E9B289ECF0379248E24DFB4590A@qq.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 12:22:17 -0700
X-Gm-Features: AVHnY4L80PLx_iDOZ80xwVOsu9v7r1-5cHH_ebtBp8oo663yjgvDU9xhef7hoAI
Message-ID: <CAKEwX=MDSwMoU-=h3NOG==-ru+qT3LeTi2_PADLWFXBB9aZZ+w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/9] mm: provide anon locality evidence for zswap
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16458-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qq.com:email]
X-Rspamd-Queue-Id: AF4EE607C90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 5:19=E2=80=AFAM fujunjie <fujunjie1@qq.com> wrote:
>
> The common zswap large-swapin policy needs locality evidence from
> callers before it can admit a large folio. For anonymous faults, provide
> that evidence from existing VMA hints and from the PTE young state left
> by earlier zswap-backed large swapins.
>
> Keep non-faulting PTEs old when mapping a speculative all-zswap large
> folio. A later fault can then require a dense young previous range before
> admitting another large swapin without adding VMA state.

Makes sense to me.

>
> This also removes the old zswap-enabled guard from the THP swapin
> candidate scan. The common swapin path now classifies the backend range
> and falls back to order-0 for mixed zswap/disk ranges or races.
>
> Signed-off-by: fujunjie <fujunjie1@qq.com>
> ---
>  mm/memory.c     | 234 +++++++++++++++++++++++++++++++++++++++++++-----
>  mm/swap.h       |   6 ++
>  mm/swap_state.c |  15 ++++
>  3 files changed, 235 insertions(+), 20 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 92a82008d583..7bbb89632000 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4556,6 +4556,35 @@ static void memcg1_swapin_retry_folio(struct folio=
 *folio,
>         folio_unlock(folio);
>  }
>
> +static void set_swapin_ptes(struct vm_area_struct *vma,
> +                           unsigned long address, pte_t *ptep, pte_t pte=
,
> +                           unsigned int nr_pages, unsigned int fault_pte=
_idx,
> +                           bool fault_only_young)
> +{
> +       struct mm_struct *mm =3D vma->vm_mm;
> +       pte_t old_pte;
> +
> +       if (!fault_only_young || nr_pages =3D=3D 1) {
> +               set_ptes(mm, address, ptep, pte, nr_pages);
> +               return;
> +       }
> +
> +       old_pte =3D pte_mkold(pte);
> +       if (fault_pte_idx)
> +               set_ptes(mm, address, ptep, old_pte, fault_pte_idx);
> +
> +       set_pte_at(mm, address + fault_pte_idx * PAGE_SIZE,
> +                  ptep + fault_pte_idx,
> +                  pte_mkyoung(pte_advance_pfn(pte, fault_pte_idx)));

Hmm, does this mean that without THP swapin, the faulting PTE is not
marked young, but it is marked young if there is a THP swapin. That's
a behavioral change right? Would this throw off other heuristics
relying on this bit, or any justification that this is fine?

> +
> +       fault_pte_idx++;
> +       if (fault_pte_idx < nr_pages)
> +               set_ptes(mm, address + fault_pte_idx * PAGE_SIZE,
> +                        ptep + fault_pte_idx,
> +                        pte_advance_pfn(old_pte, fault_pte_idx),
> +                        nr_pages - fault_pte_idx);
> +}
> +
>  static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
>  {
>         vmf->pte =3D pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> @@ -4628,6 +4657,157 @@ static vm_fault_t handle_pte_marker(struct vm_fau=
lt *vmf)
>  }
>
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#define SWAPIN_ANON_YOUNG_MIN_PERCENT          75
> +#define SWAPIN_ANON_MAX_FAULT_SKIP_SHIFT       2
> +
> +static bool swapin_anon_prev_young_dense(struct vm_fault *vmf,
> +                                        unsigned int order)
> +{
> +       struct vm_area_struct *vma;
> +       unsigned int nr_pages;
> +       unsigned int threshold;
> +       unsigned long size;
> +       unsigned long base, prev, addr;
> +       struct folio *first =3D NULL;
> +       unsigned int present =3D 0;
> +       unsigned int young =3D 0;
> +       pmd_t *pmd;
> +       pmd_t pmdval;
> +       spinlock_t *ptl; /* protects the previous PTE range */
> +       pte_t *ptep;
> +       unsigned int i;
> +
> +       if (!IS_ENABLED(CONFIG_MMU) || !arch_has_hw_pte_young() || !vmf |=
|
> +           !vmf->vma || !vmf->pmd || !order || order > MAX_PAGE_ORDER)
> +               return false;
> +
> +       nr_pages =3D 1U << order;
> +       threshold =3D DIV_ROUND_UP(nr_pages *
> +                                SWAPIN_ANON_YOUNG_MIN_PERCENT, 100);
> +       size =3D PAGE_SIZE << order;
> +
> +       vma =3D vmf->vma;
> +       base =3D ALIGN_DOWN(vmf->address, size);
> +       if (base < size)
> +               return false;
> +
> +       prev =3D base - size;
> +       if (prev < vma->vm_start || prev + size > vma->vm_end)
> +               return false;
> +
> +       pmd =3D vmf->pmd;
> +       if ((prev & PMD_MASK) !=3D (base & PMD_MASK)) {
> +               pmd =3D mm_find_pmd(vma->vm_mm, prev);
> +               if (!pmd)
> +                       return false;
> +       }
> +
> +       pmdval =3D pmdp_get_lockless(pmd);
> +       if (!pmd_present(pmdval) || pmd_leaf(pmdval))
> +               return false;
> +
> +       ptep =3D pte_offset_map_lock(vma->vm_mm, pmd, prev, &ptl);
> +       if (!ptep)
> +               return false;
> +
> +       for (i =3D 0, addr =3D prev; i < nr_pages; i++, addr +=3D PAGE_SI=
ZE) {
> +               struct folio *folio;
> +               pte_t pte =3D ptep_get(ptep + i);
> +
> +               if (!pte_present(pte))
> +                       break;
> +
> +               folio =3D vm_normal_folio(vma, addr, pte);
> +               if (!folio || folio_order(folio) !=3D order)
> +                       break;
> +               if (!first)
> +                       first =3D folio;
> +               else if (folio !=3D first)
> +                       break;
> +
> +               present++;
> +               if (pte_young(pte))
> +                       young++;
> +       }
> +
> +       pte_unmap_unlock(ptep, ptl);
> +       if (present !=3D nr_pages)
> +               return false;
> +
> +       return young >=3D threshold;
> +}
> +
> +static bool swapin_anon_accessed_neighbour(struct vm_fault *vmf,
> +                                          unsigned int order)
> +{
> +       unsigned long size;
> +       unsigned long base;
> +       unsigned long fault_idx;
> +       unsigned long max_skip;
> +
> +       if (!vmf || !vmf->vma || !order || order > MAX_PAGE_ORDER)
> +               return false;
> +
> +       size =3D PAGE_SIZE << order;
> +       base =3D ALIGN_DOWN(vmf->address, size);
> +
> +       /*
> +        * Without a sequential hint, require prior young-density evidenc=
e and
> +        * only allow faults near the start of the candidate range.
> +        */
> +       fault_idx =3D (vmf->address - base) >> PAGE_SHIFT;
> +       max_skip =3D (1UL << order) >> SWAPIN_ANON_MAX_FAULT_SKIP_SHIFT;
> +       if (fault_idx > max_skip)
> +               return false;
> +
> +       return swapin_anon_prev_young_dense(vmf, order);
> +}
> +
> +static bool swapin_anon_fault_starts_range(struct vm_fault *vmf,
> +                                          unsigned int order)
> +{
> +       struct vm_area_struct *vma;
> +       unsigned long size;
> +       unsigned long base;
> +       unsigned long first;
> +
> +       if (!vmf || !vmf->vma || !order || order > MAX_PAGE_ORDER)
> +               return false;
> +
> +       vma =3D vmf->vma;
> +       size =3D PAGE_SIZE << order;
> +       base =3D ALIGN_DOWN(vmf->address, size);
> +       first =3D ALIGN(vma->vm_start, size);
> +
> +       return base =3D=3D first && vmf->address =3D=3D base &&
> +              base + size <=3D vma->vm_end;
> +}
> +
> +static unsigned long swapin_anon_locality_orders(struct vm_fault *vmf,
> +                                                unsigned long orders)
> +{
> +       struct vm_area_struct *vma =3D vmf ? vmf->vma : NULL;
> +       unsigned long locality_orders =3D 0;
> +       unsigned long candidates =3D orders & ~BIT(0);
> +       int order;
> +
> +       if (vma && (vma->vm_flags & VM_RAND_READ))
> +               return 0;
> +
> +       if (vma && (vma->vm_flags & VM_SEQ_READ))
> +               return candidates;
> +
> +       while (candidates) {
> +               order =3D fls_long(candidates) - 1;
> +               if (swapin_anon_fault_starts_range(vmf, order) ||
> +                   swapin_anon_accessed_neighbour(vmf, order))
> +                       locality_orders |=3D BIT(order);
> +               candidates &=3D ~BIT(order);
> +       }
> +
> +       return locality_orders;
> +}
> +
>  /*
>   * Check if the PTEs within a range are contiguous swap entries.
>   */
> @@ -4644,9 +4824,9 @@ static bool can_swapin_thp(struct vm_fault *vmf, pt=
e_t *ptep, int nr_pages)
>         if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
>                 return false;
>         /*
> -        * swap_read_folio() can't handle the case a large folio is hybri=
dly
> -        * from different backends. And they are likely corner cases. Sim=
ilar
> -        * things might be added once zswap support large folios.
> +        * swap_read_folio() can't do mixed-backend large folio IO. The c=
ommon
> +        * synchronous swapin path will recheck backend state and fall ba=
ck to
> +        * order-0 if a zswap/disk race makes the range mixed.
>          */
>         if (swap_pte_batch(ptep, nr_pages, pte) !=3D nr_pages)
>                 return false;
> @@ -4693,14 +4873,6 @@ static unsigned long thp_swapin_suitable_orders(st=
ruct vm_fault *vmf)
>         if (unlikely(userfaultfd_armed(vma)))
>                 return 0;
>
> -       /*
> -        * A large swapped out folio could be partially or fully in zswap=
. We
> -        * lack handling for such cases, so fallback to swapping in order=
-0
> -        * folio.
> -        */
> -       if (!zswap_never_enabled())
> -               return 0;
> -
>         entry =3D softleaf_from_pte(vmf->orig_pte);
>         /*
>          * Get a list of all the (large) orders below PMD_ORDER that are =
enabled
> @@ -4708,10 +4880,13 @@ static unsigned long thp_swapin_suitable_orders(s=
truct vm_fault *vmf)
>          */
>         orders =3D thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEF=
AULT,
>                                           BIT(PMD_ORDER) - 1);
> +       if (!orders)
> +               return 0;
>         orders =3D thp_vma_suitable_orders(vma, vmf->address, orders);
> +       if (!orders)
> +               return 0;
>         orders =3D thp_swap_suitable_orders(swp_offset(entry),
>                                           vmf->address, orders);
> -
>         if (!orders)
>                 return 0;
>
> @@ -4741,6 +4916,12 @@ static unsigned long thp_swapin_suitable_orders(st=
ruct vm_fault *vmf)
>  {
>         return 0;
>  }
> +
> +static unsigned long swapin_anon_locality_orders(struct vm_fault *vmf,
> +                                                unsigned long orders)
> +{
> +       return 0;
> +}
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>
>  /* Sanity check that a folio is fully exclusive */
> @@ -4777,6 +4958,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         unsigned long page_idx;
>         unsigned long address;
>         pte_t *ptep;
> +       bool fault_only_young =3D false;
>
>         if (!pte_unmap_same(vmf))
>                 goto out;
> @@ -4845,13 +5027,22 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (folio)
>                 swap_update_readahead(folio, vma, vmf->address);
>         if (!folio) {
> -               /* Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devic=
es */
> -               if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
> +               /*
> +                * Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devic=
es.
> +                * The swap device is pinned while checking the flag, mat=
ching
> +                * the existing fault path.
> +                */
> +               if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
> +                       unsigned long swapin_orders =3D thp_swapin_suitab=
le_orders(vmf);
> +                       unsigned long locality_orders =3D
> +                               swapin_anon_locality_orders(vmf, swapin_o=
rders);
> +
>                         folio =3D swapin_sync(entry, GFP_HIGHUSER_MOVABLE=
,
> -                                           thp_swapin_suitable_orders(vm=
f) | BIT(0),
> -                                           0, vmf, NULL, 0);
> -               else
> +                                           swapin_orders | BIT(0),
> +                                           locality_orders, vmf, NULL, 0=
);
> +               } else {
>                         folio =3D swapin_readahead(entry, GFP_HIGHUSER_MO=
VABLE, vmf);
> +               }
>
>                 if (IS_ERR_OR_NULL(folio)) {
>                         /*
> @@ -5110,9 +5301,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>
>         VM_BUG_ON(!folio_test_anon(folio) ||
>                         (pte_write(pte) && !PageAnonExclusive(page)));
> -       set_ptes(vma->vm_mm, address, ptep, pte, nr_pages);
> -       arch_do_swap_page_nr(vma->vm_mm, vma, address,
> -                       pte, pte, nr_pages);
> +       if (folio =3D=3D swapcache && nr_pages =3D=3D folio_nr_pages(foli=
o) &&
> +           arch_has_hw_pte_young())
> +               fault_only_young =3D swapin_fault_only_young(folio);
> +       set_swapin_ptes(vma, address, ptep, pte, nr_pages, page_idx,
> +                       fault_only_young);
> +       arch_do_swap_page_nr(vma->vm_mm, vma, address, pte, pte, nr_pages=
);
>
>         /*
>          * Remove the swap entry and conditionally try to free up the swa=
pcache.
> diff --git a/mm/swap.h b/mm/swap.h
> index dd35a310d06d..5d1c81ab49b9 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -327,6 +327,7 @@ struct folio *swapin_readahead(swp_entry_t entry, gfp=
_t flag,
>  struct folio *swapin_sync(swp_entry_t entry, gfp_t flag, unsigned long o=
rders,
>                           unsigned long locality_orders, struct vm_fault =
*vmf,
>                           struct mempolicy *mpol, pgoff_t ilx);
> +bool swapin_fault_only_young(struct folio *folio);
>  void swap_update_readahead(struct folio *folio, struct vm_area_struct *v=
ma,
>                            unsigned long addr);
>
> @@ -430,6 +431,11 @@ static inline void swap_update_readahead(struct foli=
o *folio,
>  {
>  }
>
> +static inline bool swapin_fault_only_young(struct folio *folio)
> +{
> +       return false;
> +}
> +
>  static inline int swap_writeout(struct folio *folio,
>                 struct swap_iocb **swap_plug)
>  {
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 5a4ca289009a..80dff6a1ee65 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -747,6 +747,21 @@ static bool zswap_needs_order0_retry(struct folio *f=
olio)
>                ZSWAP_RANGE_MIXED;
>  }
>
> +/*
> + * A speculative large swapin may install PTEs for pages that did not fa=
ult.
> + * Keep those non-faulting PTEs old so a later anon fault can report
> + * PTE-young density as caller-provided locality evidence without storin=
g
> + * state in the VMA.
> + */
> +bool swapin_fault_only_young(struct folio *folio)
> +{
> +       if (!folio_test_large(folio) || !folio_test_swapcache(folio))
> +               return false;
> +
> +       return zswap_probe_range(folio->swap, folio_nr_pages(folio)) =3D=
=3D
> +              ZSWAP_RANGE_ALL_ZSWAP;
> +}
> +
>  /*
>   * If we are the only user, then try to free up the swap cache.
>   *
> --
> 2.34.1
>

