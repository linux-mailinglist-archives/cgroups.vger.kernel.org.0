Return-Path: <cgroups+bounces-16453-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFhVBEXcGWo4zggAu9opvQ
	(envelope-from <cgroups+bounces-16453-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:34:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ECA60746B
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3395B301DEF1
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6B4218A3;
	Fri, 29 May 2026 18:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3wdxiNj"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176B341B37D
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 18:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079669; cv=pass; b=G7NcH3Ny0J7TJlPhm6E4t8iZhfqmpw7gG0kwD6FIgtm1h7LVUiPhSNx/MqI+rCwQi9vMJXhT4v1mcJrr3phrcSG3gohGbH+6ah7pgTLBnyrbPpesEPR/QY1jnyIZzFoZ7wAGPdCjCDIbZh48N4H+dqlRmaSiLwQ8XCZOsvKUBL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079669; c=relaxed/simple;
	bh=m1ESnSThpjOOQTq6gAcWRfcmDYMSDR3x5QZIlGgYF1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=or25TY5WflT+BrD5zkjiV3ZNWaySIMQUGyP58AHmURFw/5txX8L67oWYEQ/2WgtP7AV4YRcpnvPpTeVLxFT1EucEHF58yythfDrxkv+v7BLwGLcu1nlE5+Y1I9VZ4R+9u3pvcyxsJByO4RbITCNsU/UA6X4PPorKSnO6+z0w/Uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3wdxiNj; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45eeba68948so1430897f8f.1
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 11:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079663; cv=none;
        d=google.com; s=arc-20240605;
        b=htgQ+7u2Ltm/+4Il30w3F4w76QDe8C3wPKtZjjsyQBUvGV+PeTMy8Kakb05wDDfq//
         Bjcv67QVMNZlSjg/EA7zO/zxg+xTBx40J+9RKMOC3319swUzl826/Hbi92MwnCppp8vv
         9Gss7MG/sO7eFXpQydjJhd9WbCzXpjcSh7H3Nn/Yg6WBxn3oWmmSkQJLHJIam7jVkyZi
         ZBSvDKN8kNE6LGQarjY0c06nDuEBPiIeXoo9eB4QacOvpqNLqAIw4vn4P8eOX+Vuhp3i
         h7uqYDls0pCHEKwfrPDsezp0cZfrzWwRR308N/44O+ez4NqHaOt5VS3HQQ0SQV/w1OqH
         FY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24YU1NBoUybBTpcYsacpUWpYJ0m9Z4yMIofjF2AMjYQ=;
        fh=gKHzmvXIOtpJUlc2vG2c+KOn+wfUXEegDeoD2PnX1QI=;
        b=X35Kc5FQvxJ8u/borQifc/bO44KS3w6nJQOVekv98O/2plpnqnd8V33dTkrWBXN17v
         sMyuq5czM2GPtKP6eZ2KHwHLulPOGqXDoBnaYBiWZj6codM+9jFYoi6zItX0ZWNzPN7Q
         kGpq0roa+ucyaoVEzdp7ZqgbNAZduUKme77ONK1buvolWo3yj/uXRff425VJVxzm6DCN
         XSkMP7EAwngg8st67KnmnhPcRl/nh0L4NZPrV0bmDsT+hH6dLzisleJzUGpwzE6ZTIXM
         qqrowvyTqd2upY8pKLJvdNqdaQ1adeo0VcZrf4igcC6nstXJKi7iMCCnYAVjmo23G95g
         QbQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079663; x=1780684463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=24YU1NBoUybBTpcYsacpUWpYJ0m9Z4yMIofjF2AMjYQ=;
        b=N3wdxiNjhmszEd0dRPcx9gXCPzTQlHgz0gD7ShSw8ulyeg6VKqW2s+qmbfkVCnL+vD
         mFo1We3C3mDzlpGg0FYYgn2pefqrt7eHzNMSoTH2CrPMHgi2IW2cJw0P5z2vmCNxc9xj
         l1LwtzfZuiVvBBPtayEoOAz5KiLUy2TwUNzx+bRlzB59vOvV+u7F4eK1toJTsRN0eB+q
         T4+Bth1x5ItasRqmKDJtPNBEnR8yd7YUi7PbQhnMy0b0GLetQ2rOFhr6wOBqx186FvDf
         BUl26aWbOecOyy0RX4Y8W3tyREczxo7QoiDc1fZueLwzwCIRrLNK4RCfGqjYyMUkQ6eH
         n1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079663; x=1780684463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=24YU1NBoUybBTpcYsacpUWpYJ0m9Z4yMIofjF2AMjYQ=;
        b=OATHqimEeCdCufz+NY1b/XAIC6V3N8RqQ+lkUvLLqvAK3CJePtNMmF0xMiLzXCwZrz
         t47lv5uIgXbW7zDAq+K7XxVmvuFZU/u+1Cqbra3C5svB4+k6g3rbg3v7bTvc4OD+AgEw
         9Ohamlt3qaP8+vb+ZqnlEMoAR82+luEJYciSa8M6qUBspU4PWiyhgs5lASmG0hkMgZXF
         b+Mhp6LMjRqGo0tzWz2gE2u+5n0KXNHfNzag0WXWPuFVXc2Vy9tOz4ZdOZNbMqZNSG3p
         xr837S3iyE/53sd7OfPkxAhCanq0JCqlw+HoC+i8/zeTFKVnlKtdXwRY5PS2dHFuOu9M
         bhuA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZjYagjxvUcyIX4+xIl7mC2J4JcvUMe89Mb14yz60UDcx1amUSY4j0wv3g8RRwXBtAR2mx4mRh@vger.kernel.org
X-Gm-Message-State: AOJu0YzvOwfhe8HTxiqfhqIj91Cp17MVfpgcoCBVePN89Y8LduOm9Er1
	5yGpN9E+gQZf/Ti3hXHEIgcwrO1oacQzZsHbOkQovVF5DcKfRbvNvV6nnLk1DX9TJuTR5vg82rZ
	ts75l0J09YKDhV3MZKGVRhStVFjSfYO8=
X-Gm-Gg: Acq92OHc4RgS0Xy396YYo8H/+2YjIZ1txG25o/5YB+SPO1hUUYNbDXxa1DzWhLCljcM
	NYSL3Yg3tIzyDAHq577S5IAkwhcozyDo/Hg7WsVWH2VaN+9gXTBI1tXzO8QVSLRO2x/BQdnuK00
	3Kojf2HOVV5cf8Bg38C6s5evX53rFdyFgQNdDujCzreVqvofEi43saAMzT1CaO7r6682bIwuFao
	pORgByBj8ZeX3DJtQW+rPMl8F8lfaxr6PxciyMoKXil/a6tSjZ7eUok9Qiyh6iIYp8O4Ya6J3n3
	Ze0JDB5L+vxZHhLBJE0KKebTiNfhnsQnkihgSl4kV4XoEAe4upHm8Z6SMnx+
X-Received: by 2002:a5d:6842:0:b0:43b:5672:efe with SMTP id
 ffacd0b85a97d-45ef6b0153cmr1499734f8f.9.1780079663307; Fri, 29 May 2026
 11:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com> <tencent_EB78848E34DC7858C873193D67286ECD4B0A@qq.com>
In-Reply-To: <tencent_EB78848E34DC7858C873193D67286ECD4B0A@qq.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 11:34:10 -0700
X-Gm-Features: AVHnY4Iug6gLEMoRTeLo5UdQvkvVMFVMPi6Ej_gA1JFadUnPf0B4TOcY1sBxJ8M
Message-ID: <CAKEwX=PvcM1u1n8TTikCAaqJN=GtgfwvnXtU2wCf=Qjp6E_Zew@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/9] mm: admit large swapin by backend range in swapin_sync()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16453-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qq.com:email]
X-Rspamd-Queue-Id: 84ECA60746B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 5:19=E2=80=AFAM fujunjie <fujunjie1@qq.com> wrote:
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
> +
> +               state =3D zswap_probe_range(range_entry, nr_pages);
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
>  /*
>   * If we are the only user, then try to free up the swap cache.
>   *
> @@ -634,7 +759,8 @@ static struct folio *swap_cache_read_folio(swp_entry_=
t entry, gfp_t gfp,
>                 folio =3D swap_cache_get_folio(entry);
>                 if (folio)
>                         return folio;
> -               folio =3D swap_cache_alloc_folio(entry, gfp, BIT(0), NULL=
, mpol, ilx);
> +               folio =3D swap_cache_alloc_folio(entry, gfp, BIT(0), NULL=
,
> +                                              mpol, ilx);
>         } while (PTR_ERR(folio) =3D=3D -EEXIST);
>
>         if (IS_ERR_OR_NULL(folio))
> @@ -677,18 +803,43 @@ struct folio *swapin_sync(swp_entry_t entry, gfp_t =
gfp, unsigned long orders,
>         struct folio *folio;
>         int ret;
>
> +       orders =3D swapin_admit_orders(entry, orders);
> +again:
>         do {
>                 folio =3D swap_cache_get_folio(entry);
>                 if (folio)
>                         return folio;
> -               folio =3D swap_cache_alloc_folio(entry, gfp, orders, vmf,=
 mpol, ilx);
> +               folio =3D swap_cache_alloc_speculative_folio(entry, gfp, =
orders,
> +                                                          vmf, mpol, ilx=
);
>         } while (PTR_ERR(folio) =3D=3D -EEXIST);
>
>         if (IS_ERR(folio))
>                 return folio;
>
> +       if (zswap_needs_order0_retry(folio)) {
> +               count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN_FALLB=
ACK);
> +               /*
> +                * The folio is newly allocated, locked, clean and not up=
todate;
> +                * no data has been read into it. Removing it only restor=
es the
> +                * swap table entries so order-0 swapin can resolve a bac=
kend
> +                * race without attempting speculative large-folio zswapi=
n.
> +                */
> +               swap_cache_del_folio(folio);
> +               folio_unlock(folio);
> +               folio_put(folio);
> +               orders =3D BIT(0);
> +               goto again;
> +       }
> +
>         ret =3D swap_read_folio(folio, NULL);
> -       VM_WARN_ON_ONCE(ret =3D=3D -EAGAIN);
> +       if (ret =3D=3D -EAGAIN) {

Can this happen? After you add the entire swap range to swap cache,
backend is locked. Zswap writeback bails out if it fails to add the
page to swap cache.

I think you can just check (zswap_probe_range or wev) before
swap_read_folio(). If the range is still fully backed by zswap, you
are good to go. Otherwise, bail here immediately.

Then you don't need all the complexity with extending swap_read_folio
to handle mixed range errors (for now at least).

