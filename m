Return-Path: <cgroups+bounces-16451-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DJAAzPaGWoAzggAu9opvQ
	(envelope-from <cgroups+bounces-16451-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:25:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFAA60738D
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 20:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34EB53008D1E
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 18:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C21409104;
	Fri, 29 May 2026 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiAmolIn"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B1C403E8C
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780079149; cv=pass; b=rPuQnpKIsjNbsKKQtKrzks8sTS+h5Osr3UpD5nLeiqGWwHx2DpUUep0NOPHxt7v+Py+nmYKHcw4ESmGCOXoGu73B7zbG1Jed9qStbe+vjdyXH3Lak3MA5kbdEzXQHP8rMTl4ys3DpIHH/qBz3EK9SXVDKqaygbt7ij3HnhA+/o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780079149; c=relaxed/simple;
	bh=a8PKYrqaWiptnOMvpltMHLnW4tWyZeuk+G0weqhin4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Boj+Jqwogvp1yKMBocWkvQsqQPuYuHZG0OjVC9bseyKLCWVkfXUQGCSSsa+qXBeDzFKTcjyeGcdHVnxgo77w1p3YtTOuipbtM+ZZdrznV+JarBgPWyFWSUZ/mzaHTL/iZEr5S7wt6YPSp9uw4esCn5zBOOVX/24fvv/1btB4JbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiAmolIn; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so84742865e9.2
        for <cgroups@vger.kernel.org>; Fri, 29 May 2026 11:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780079146; cv=none;
        d=google.com; s=arc-20240605;
        b=DNDDxGIjWX0l9LNNaR8ZMqXNRlqBXQQqgNjLOKdkFGZ1ndBuxUQHFxh030rut0u7d8
         TU1VSSI2CP6osFGy3xPyWtEFcBJpdUAS92ViddR0uKcuRDwBmDIq3TXxQddxxSBFalht
         9ErkJPEWfYlPV2K7FhLX+OaQRSL7eic/eWo4Y5aq7XAMWCPtDPE6IDyvQhtB780h7ItX
         mqn3nWNMWlJA8RbI/9cN7pWcJKdnqAQa+HqYFGd+khJ0z8u60/fTLaJbVjvbO6NMPkUp
         PVnxk6982Hq6dEsJhNpmNDjN0TqQ6ZAnmh+KXg/9hWUm6oVt8FdWO/TgZ0XSl/JxNRf4
         qY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=n/7VoLmlkelTnjhAVM+WgpRo6OCkYvMP+6JN8/8y21k=;
        fh=mpOXrUb7lMsIRFnceQOrXvPdHwG1oS+EGuC+TKfhjkE=;
        b=L1f4+RkV4b2I45IhwVdsxFw8HMny/MujrLv8IG+S8FpbvuWSHaSz7nCjGCqpUZuaUh
         C9w5e0sLJH1YY/mwCtnqFWhCz/zZ/g706WIISWQ3w9D3EhB1xDQreD0oUJp9fj3iTKrb
         HLow7vUaMjyEbA5eq7jf/VTBVUQVzyFkVmV538joQ/gy1VV7ouItQWtlMOd8UR7PzSn8
         gW5f3MpHD4+wCwlnrD3I/+ThGkKAEJ7Scmq+Iex9WSElNKasRr2zmIFoqozQXybDgRoB
         Lp0ayPNt8leLBAkxO3B7zA4P9U7jkTcFGTGHruidFPrxv9CGtwC39ool9epYPrt1KZL5
         eAew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780079146; x=1780683946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/7VoLmlkelTnjhAVM+WgpRo6OCkYvMP+6JN8/8y21k=;
        b=hiAmolInz1CfTDIvTboB3KZeE4RiPQX2dnrTIN+kGFEMhmm/GNIG0gptbbkv/+wJNw
         Cl1fXDbTmEJhiOyURNcvgxCk/4RTGAIgPoBazq0DLM64BlNEYs6b/WguffshRVvfa6wj
         RVZVfyLe7VXhvOjI2+qjofnVjtuhCf5gubHXv6bd1eO8GoEUckiGBKS2nEsdXjiUR+bS
         SN1Vkpx27dt9gNlWdXy5ko4ZMTWKA8bmbJR4do7A6GfCZkHCmnERSjJh4jMfNvkxcJol
         fbHe1dRWNYOtYL4dfPNuLYhK+iQtT5rIzt0m0Y/cOfjuRXuSdjav7IIDq5DB52N/UN1n
         VCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780079146; x=1780683946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/7VoLmlkelTnjhAVM+WgpRo6OCkYvMP+6JN8/8y21k=;
        b=kPUXMDGMkSyWZXCDfXIUJVKR35Vc21F5WYeBtNHdCIUYDzTTZGuHVCAmGVN/CbqFga
         mpq+fTvZhjBNJm+Dg6HDe57reLm0jEFgbu99oZEDV4UOJQ42YBPYaUyyZN/wB4+aUbgB
         MQ6OjZ7NzghnfthW7IvsX566geogB1Ghx+1yl/UCtErML6cbtREypgQqahxjjqyMCJSX
         gSzbCiswLbn6mwIzqf97QgcyEzEccDz+/j+R369D7uC15sKgCJHDEXEoKzBvEQEbCO62
         kLX5adig7IcUqR8sXT2O7dn+EcMIznYoq5kTHRPkNRuI45mtGN3hrHLXGNy80ANWWUbx
         k9lA==
X-Forwarded-Encrypted: i=1; AFNElJ/ihjvAbbwzBHfiJWzFP9776W28EYFH7aobPphLy/mHnBNhi4iMqM1swKvWoHyut/99MWHa9Q8G@vger.kernel.org
X-Gm-Message-State: AOJu0YwWPBr7DkhqgnYSkl9rPaQ0fRFISlCtOJMhUJKxpa+J9WWvU2BE
	WHEL24szl7u7b/2o50Toyqf7Fr1QLwFtxIXTkLaS+jo7xda/+rEo81Jc+jWEssRpHwenEJ8SqwY
	Yt102ltiEBpXlWtnqzf5p07H5HcGUD98=
X-Gm-Gg: Acq92OFoVJRSpW0n87mqfm4pDXIxciSd9mixXfjj1Wxqvkge7YTv7qqG3F8Jw1UPSeI
	xgcKaAjA+khUhFjTvU/5+V2JTY4NvYy0uPaBGdyP3B8flGL7OLxLP5fcTU6Es895Rw3clVOVPtO
	lTjigiyRv/Tq9j2Vf/aH9cG7yCJy03D+N+Mx/GsziYeKB9GDo8g9vIvSQ0SQXzqD5v319yGr4rY
	5t7ugD7x3RMxyIcC9DFijKx9tbiC/y4s2DxlV6knm9ROABXU5u2TbMvIWZklbfl0LpL8FV1R8Gh
	MCAcgzDHefqmcVUoypxteQmXmHdrDf0gwsAio8nOO9sX/jKqdA==
X-Received: by 2002:a05:600c:c092:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-490a2959113mr10743195e9.21.1780079145975; Fri, 29 May 2026
 11:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_98CD9F78E48D08DC005A6471A13CFF28B60A@qq.com> <tencent_7D186EDC2C9AB9009F9915C1E68F3CF44609@qq.com>
In-Reply-To: <tencent_7D186EDC2C9AB9009F9915C1E68F3CF44609@qq.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 29 May 2026 11:25:34 -0700
X-Gm-Features: AVHnY4Kp-sEPE-FFUF6bBOJrz20u3PpASZs17QhUX4WKimDdvMA9ZEAzM1igyBk
Message-ID: <CAKEwX=Or6forBoArv1b=MZuhOuF+MTuLLZWPKgUmkBVaoBoYSQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/9] mm/zswap: support fully zswap-backed large
 folio loads
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16451-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qq.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0BFAA60738D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 5:19=E2=80=AFAM fujunjie <fujunjie1@qq.com> wrote:
>
> zswap currently refuses large swapcache folios. That is correct for mixed
> backend ranges, but it also prevents the common swapin path from loading =
a
> range that is still fully backed by zswap.
>
> Teach zswap_load() to fill a locked large swapcache folio by decompressin=
g
> each base-page entry into the matching folio offset, then flushing the
> folio once. A missing entry after zswap data has been seen is reported as
> -EAGAIN so the caller can drop the speculative large folio and retry
> order-0.
>
> The large load keeps the zswap entries in place. It is a clean speculativ=
e
> fill: until the swap slots are freed, zswap remains the backing copy if
> reclaim drops the large folio before PTEs are installed.
>
> Signed-off-by: fujunjie <fujunjie1@qq.com>
> ---
>  mm/zswap.c | 105 ++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 87 insertions(+), 18 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index da5297f7bd69..94ba112a2982 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -15,6 +15,8 @@
>
>  #include <linux/module.h>
>  #include <linux/cpu.h>
> +#include <linux/mm.h>
> +#include <linux/huge_mm.h>
>  #include <linux/highmem.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> @@ -934,7 +936,8 @@ static bool zswap_compress(struct page *page, struct =
zswap_entry *entry,
>         return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
>  }
>
> -static bool zswap_decompress(struct zswap_entry *entry, struct folio *fo=
lio)
> +static bool zswap_decompress(struct zswap_entry *entry, struct folio *fo=
lio,
> +                            unsigned int page_idx, bool flush_dcache)
>  {
>         struct zswap_pool *pool =3D entry->pool;
>         struct scatterlist input[2]; /* zsmalloc returns an SG list 1-2 e=
ntries */
> @@ -952,14 +955,15 @@ static bool zswap_decompress(struct zswap_entry *en=
try, struct folio *folio)
>
>                 WARN_ON_ONCE(input->length !=3D PAGE_SIZE);
>
> -               dst =3D kmap_local_folio(folio, 0);
> +               dst =3D kmap_local_folio(folio, page_idx * PAGE_SIZE);
>                 memcpy_from_sglist(dst, input, 0, PAGE_SIZE);
>                 dlen =3D PAGE_SIZE;
>                 kunmap_local(dst);
> -               flush_dcache_folio(folio);
> +               if (flush_dcache)
> +                       flush_dcache_folio(folio);
>         } else {
>                 sg_init_table(&output, 1);
> -               sg_set_folio(&output, folio, PAGE_SIZE, 0);
> +               sg_set_folio(&output, folio, PAGE_SIZE, page_idx * PAGE_S=
IZE);
>                 acomp_request_set_params(acomp_ctx->req, input, &output,
>                                          entry->length, PAGE_SIZE);
>                 ret =3D crypto_acomp_decompress(acomp_ctx->req);
> @@ -1042,7 +1046,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>                 goto out;
>         }
>
> -       if (!zswap_decompress(entry, folio)) {
> +       if (!zswap_decompress(entry, folio, 0, true)) {
>                 ret =3D -EIO;
>                 goto out;
>         }
> @@ -1615,10 +1619,9 @@ enum zswap_range_state zswap_probe_range(swp_entry=
_t swp,
>   *  NOT marked up-to-date, so that an IO error is emitted (e.g. do_swap_=
page()
>   *  will SIGBUS).
>   *
> - *  -EINVAL: if the swapped out content was in zswap, but the page belon=
gs
> - *  to a large folio, which is not supported by zswap. The folio is unlo=
cked,
> - *  but NOT marked up-to-date, so that an IO error is emitted (e.g.
> - *  do_swap_page() will SIGBUS).
> + *  -EAGAIN: if the swapped out content belongs to a large folio, but th=
e
> + *  range is mixed or raced with writeback. The folio remains locked so =
the
> + *  caller can drop the large swapcache folio and retry order-0.
>   *
>   *  -ENOENT: if the swapped out content was not in zswap. The folio rema=
ins
>   *  locked on return.
> @@ -1626,9 +1629,12 @@ enum zswap_range_state zswap_probe_range(swp_entry=
_t swp,
>  int zswap_load(struct folio *folio)
>  {
>         swp_entry_t swp =3D folio->swap;
> +       unsigned int nr_pages =3D folio_nr_pages(folio);
> +       unsigned int type =3D swp_type(swp);
>         pgoff_t offset =3D swp_offset(swp);
> -       struct xarray *tree =3D swap_zswap_tree(swp);
> +       struct xarray *tree;
>         struct zswap_entry *entry;
> +       unsigned int i;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
>         VM_WARN_ON_ONCE(!folio_test_swapcache(folio));
> @@ -1636,21 +1642,84 @@ int zswap_load(struct folio *folio)
>         if (zswap_never_enabled())
>                 return -ENOENT;
>
> -       /*
> -        * Large folios should not be swapped in while zswap is being use=
d, as
> -        * they are not properly handled. Zswap does not properly load la=
rge
> -        * folios, and a large folio may only be partially in zswap.
> -        */
> -       if (WARN_ON_ONCE(folio_test_large(folio))) {
> +       if (folio_test_large(folio)) {
> +               struct obj_cgroup *first_objcg =3D NULL;
> +               bool same_objcg =3D true;
> +               bool saw_zswap =3D false;
> +               bool saw_non_zswap =3D false;
> +
> +               /*
> +                * The locked large swapcache folio now covers the range =
and
> +                * conflicts with zswap writeback's order-0 swapcache all=
ocation.
> +                * If the range is mixed or an entry disappears, retry or=
der-0.
> +                */
> +               for (i =3D 0; i < nr_pages; i++) {
> +                       tree =3D swap_zswap_tree(swp_entry(type, offset +=
 i));
> +                       entry =3D xa_load(tree, offset + i);
> +                       if (!entry) {
> +                               if (saw_zswap)
> +                                       return -EAGAIN;
> +                               saw_non_zswap =3D true;
> +                               continue;
> +                       }

Can we use xas_load API here instead of traversing down the tree again
and again?

> +                       if (saw_non_zswap)
> +                               return -EAGAIN;
> +
> +                       if (!saw_zswap)
> +                               first_objcg =3D entry->objcg;
> +                       else if (entry->objcg !=3D first_objcg)
> +                               same_objcg =3D false;

Can we get different objcg at this point?

> +                       saw_zswap =3D true;
> +               }
> +               if (!saw_zswap)
> +                       return -ENOENT;
> +
> +               for (i =3D 0; i < nr_pages; i++) {
> +                       tree =3D swap_zswap_tree(swp_entry(type, offset +=
 i));
> +                       entry =3D xa_load(tree, offset + i);
> +                       if (!entry)
> +                               return -EAGAIN;
> +
> +                       if (!zswap_decompress(entry, folio, i, false)) {
> +                               folio_unlock(folio);
> +                               return -EIO;
> +                       }
> +               }
> +
> +               flush_dcache_folio(folio);
> +               /*
> +                * Keep zswap entries until swap slots are freed. This is=
 a clean
> +                * speculative fill; zswap remains the backing copy if re=
claim
> +                * drops the large folio before PTEs are installed.
> +                */
> +               folio_mark_uptodate(folio);
> +               count_vm_events(ZSWPIN, nr_pages);
> +               count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN);
> +
> +               if (same_objcg) {
> +                       if (first_objcg)
> +                               count_objcg_events(first_objcg, ZSWPIN, n=
r_pages);
> +               } else {
> +                       for (i =3D 0; i < nr_pages; i++) {
> +                               tree =3D swap_zswap_tree(swp_entry(type, =
offset + i));
> +                               entry =3D xa_load(tree, offset + i);
> +                               if (WARN_ON_ONCE(!entry))
> +                                       continue;
> +                               if (entry->objcg)
> +                                       count_objcg_events(entry->objcg, =
ZSWPIN, 1);

xas_load() here too?


> +                       }
> +               }
> +
>                 folio_unlock(folio);
> -               return -EINVAL;
> +               return 0;
>         }

>
> +       tree =3D swap_zswap_tree(swp);
>         entry =3D xa_load(tree, offset);
>         if (!entry)
>                 return -ENOENT;
>
> -       if (!zswap_decompress(entry, folio)) {
> +       if (!zswap_decompress(entry, folio, 0, true)) {
>                 folio_unlock(folio);
>                 return -EIO;
>         }

I wonder how much of these two paths (order 0 and larger order) can be
unified...

> --
> 2.34.1
>

