Return-Path: <cgroups+bounces-17266-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nqiFO2ljPGqHnggAu9opvQ
	(envelope-from <cgroups+bounces-17266-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 01:08:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BEE6C1DCF
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 01:08:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cUYr9DxH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17266-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17266-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B3483020020
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B56E3B4432;
	Wed, 24 Jun 2026 23:08:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4289B2D7386
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 23:08:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782342503; cv=pass; b=RG2YnqiC/4qQ1HnQKDonhwxgnD7cauJAGBsrvzctEy/ZcyrprYyiB0gRAQIj6WzkEXbzSyDdhOk6zHdmT3UthGC8tOhUUNm62U1tTuGonHfNeQBgZBQeTF9dx8aWURyj8oSdO4Z9yUyppIwiXGfFb4kqYMMBfk8rBOF+D8i48lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782342503; c=relaxed/simple;
	bh=jlQjl7spty/PYH9DhxiV7IM/khkngfG/klzLNmzCa6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHqSUu7jRsibWdEiFX+OOn45F1spuxBATSgpsG0pp9BiCZ5L7JQWE8d8f8ADEezZCOM0+DDoW1N5p6tK+ESP6Ia78TECVnLRcTrJ4qq+bWnZ0GicwWCKCnM9uOch8vgYoc+zW0Ml+2g9QRqnANG3EXquDeratFBm5Y+yjNF0i1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUYr9DxH; arc=pass smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so15942615e9.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 16:08:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782342500; cv=none;
        d=google.com; s=arc-20240605;
        b=VA0c2lB1wo1fMzW5V17DgtSAbKOXnR+ZrSAvI0Kv5FLq+uZk7VIhmwLYn4X1kI/Nvx
         OFx+CAKkbRV00VvaQ8QEy6S2l+BII+N63e189Nj2oxF0cBCZP+oCcy2zZK7WwyKgAyJd
         BxAOVFjVKiG7hjAtPdhznC6JJ/SSyghdyqy2Zu5q8xSOjfEiquLaFSoBjKNJuB4Wqg0Z
         gI+P9emt0M6s7HyG+/lhY+iyEPNZZQsOukmj7Yl4ACsIBbnPjtD52yeaQxT2WptDukwo
         orbZ6BRau8GyuD7LENzo9BJscPdiyxOoqDUVl/0giFyNtFQcUH8zBSSok/d83BBR/bSq
         Mn4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+fHkr90D90S1AcwNcJcCz4YNxvQsSfEc7T9eLgJMlGk=;
        fh=DLR2A01Y8cOxmwHNhM8D33EySkIu9Elp8rxaSgkyDY0=;
        b=CP+WLfvB2qoe8psFZj202BzIyVdlvKl+hwK4AQmzFkZPjMVEq4GAfcaAqQFYBAIiH+
         9fGnm5IdLJsmaNm1VEXl8HlDN66xr6dEIjOSt9HMujtnSbX/o85hiy+6YZlb8HFqSb+u
         Zi8xXefE3eWXYMOzwr8u8HzZZd/Hef4OchU8e+APFP7UZpP3DM8OxfCHh1U1l3hNW851
         oA7Qg0k6Wax2WkwwZU+5N9ean0wjE6WhnnDcvq/i1K/bfR0GKrg/NeE6aIBht3K8xqgP
         3F5vrxYNyrK8FQY3GZPxhjPi1NixQsja7WM9Q90kSaVEG9SkOPQMGe3XamHiYCk9DK8s
         4BFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782342500; x=1782947300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fHkr90D90S1AcwNcJcCz4YNxvQsSfEc7T9eLgJMlGk=;
        b=cUYr9DxHqObf7gJDhaikbpDPO/9Du7ETMpix8occEZV3jgiLBsemU5ONUVI3YS635k
         M4Triv3ZG9eCyj+6hjq0JLAVgp7IrT2XSqUnJd+JuOZEhuOjc0lY5zNksO6YlQx/+DGX
         Img3j13VvOzVsXPqDfel2aO7c6acI/eY4tjKsIpzl+Z8ofT+QHLfvYeBccqRXyDdA8w6
         H3B2swf79JjEtlgjoLj+sT5srTi2tNDiGSlnttaT4w6f9oYsv6X8/NW+8pRYTzQn0mTm
         zrErWNC5f6hjXToGD7wDzV3+XX65jhlgVlqKxb20Mp98XFVcKoRLx9PfWjIqoGdP4RR+
         eWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782342500; x=1782947300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+fHkr90D90S1AcwNcJcCz4YNxvQsSfEc7T9eLgJMlGk=;
        b=gRxnd5Mwcw85zHwEicBJH8UTargiKkCem7JGM9e685U0vX7l96CA11d/LINE+Sq9TB
         FCLabTXQjaVbFiZByaneVseZ6ytehdxlaiZtwSXL6tzgcW/bB3SDwDG64VJ2eeepVukk
         uLATRpPmxzGK/JrOfqWvEFHjlftTKVPCF0tduUjGIVlYUdIKQwbPyOFBc6CUExd4JbH3
         to8P8ko3+YyjT+lq9u3GrSaPb9xcLofrhWkEFRULx39pSDko8sGZ3oflFTenuOpiyusO
         4k17I4fzy9615qSDvZANfJMbvLmc4w7NsS5F/Y2esJHB70twW4hFOaUN+4LaigXOtLBx
         UmGA==
X-Forwarded-Encrypted: i=1; AHgh+RqoAYIn2H0MORmgOJXdchkmyJcTZnvszrteh/tDkTxJOTVH65wuLRe+zURGvZtDSfxbRd49abTE@vger.kernel.org
X-Gm-Message-State: AOJu0YyRADPwDCmSvvraXYrvnDN5hvuwonPSDOicngBBBZL5+VBX+a+t
	NY+lI7OJ8ZyiThe1gBwID5J8rjBTGFJ3Em7mgEJpTLtErsJ1i3KiuYtHocsAMGfFaIaGt0QFwkk
	uu24wPuIvu533sFv3mCzi5eThJ3K1St4=
X-Gm-Gg: AfdE7cnadkT87eeAzMtnJJ4v3d6nIcjOWcIbgKB5EhLAzGD1sM/uOBLHK049sLNotGu
	4ufS3KRNAYEcKILrY/xi5LrHCVkN5ie714F3/DJsNPqtuEmHpZeDNj2mS7M31Kk+pB6FDO/H9aI
	I5DjhScOPVVv5NYOr9ftfeZR595HnsKw24vK+eMEYdfLQTdwjUXNUkSHOuqq/kJucDAiBE0fEv2
	/pMVWLmP1OqkRJm5uWjvhRPpO0p013uNpt7+sAUYyAW7QGCXeRCfscKUypyFrtMOtL1ZlfNynvL
	aypPQSDAErQfhfUVdZSD20D0ScR4QECtZkTzQshzVpx+u5UUEJ4pf5c=
X-Received: by 2002:a05:6000:288c:b0:462:93cf:d510 with SMTP id
 ffacd0b85a97d-46ad90f5d88mr14558516f8f.12.1782342499561; Wed, 24 Jun 2026
 16:08:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <20260612193738.2183968-3-nphamcs@gmail.com>
 <ajnNWRO7apBq2-kQ@google.com>
In-Reply-To: <ajnNWRO7apBq2-kQ@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 24 Jun 2026 16:08:08 -0700
X-Gm-Features: AVVi8CfZPRJXeQiZ-QI0fuqfZ80V8OQT-rm0BmrU_pyrNuBxccG3s68zL1rO5Pk
Message-ID: <CAKEwX=MtyRQawS-1LRnpqUhTqfY2Dfm0S57Bgwsd2ZAWJgk9VQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/7] mm, swap: support zswap and zeroswap as vswap backends
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, david@kernel.org, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, baoquan.he@linux.dev, baohua@kernel.org, 
	youngjun.park@lge.com, chengming.zhou@linux.dev, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	qi.zheng@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, riel@surriel.com, gourry@gourry.net, 
	haowenchao22@gmail.com, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17266-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8BEE6C1DCF

On Mon, Jun 22, 2026 at 5:16=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Jun 12, 2026 at 12:37:33PM -0700, Nhat Pham wrote:
> > Build the virtual swap layer on top of the swap-table infrastructure.
> > Virtual swap entries decouple PTE swap entries from physical backing,
> > allowing pages to be compressed by zswap (or detected as zero-filled)
> > without pre-allocating a physical swap slot.
> >
> > This patch only supports zswap and zero-page backends. If zswap_store
> > fails, the page stays dirty in the swap cache (AOP_WRITEPAGE_ACTIVATE)
> > - physical disk backing fallback comes in the next patch. Zswap
> > writeback of vswap-backed entries is also disabled - the shrinker
> > skips when no physical swap pages are available.
> >
> > Suggested-by: Kairui Song <kasong@tencent.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> [..]
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 993406074d58..466f8a182716 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -38,6 +38,7 @@
> >  #include <linux/zsmalloc.h>
> >
> >  #include "swap.h"
> > +#include "vswap.h"
> >  #include "internal.h"
> >
> >  /*********************************
> > @@ -762,7 +763,7 @@ static void zswap_entry_cache_free(struct zswap_ent=
ry *entry)
> >   * Carries out the common pattern of freeing an entry's zsmalloc alloc=
ation,
> >   * freeing the entry itself, and decrementing the number of stored pag=
es.
> >   */
> > -static void zswap_entry_free(struct zswap_entry *entry)
> > +void zswap_entry_free(struct zswap_entry *entry)
> >  {
> >       zswap_lru_del(&zswap_list_lru, entry);
> >       zs_free(entry->pool->zs_pool, entry->handle);
> > @@ -994,16 +995,21 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >       struct swap_info_struct *si;
> >       int ret =3D 0;
> >
> > +     /* try to allocate swap cache folio */
> >       si =3D get_swap_device(swpentry);
> >       if (!si)
> >               return -EEXIST;
> >
> > +     /*
> > +      * Vswap entries have no physical backing - writeback would fail
> > +      * and SIGBUS the caller. Bail before we waste a swap-cache folio
> > +      * allocation.
> > +      */
>
> Seems like this comment belongs in the previous patch, and the other
> comment movement is undoing what last patch did.

Yeah this comment belongs to the first patch. I added it after the
fact but commit to the second patch.

TBH, the first patch kinda not do much. It just declares a new special
struct swap_info_struct, with some helpers and checks, but it's not
hooked to any allocation path. Logically it should be squashed into
this patch, but this patch is already 600 LoC, lol.

>
> >       if (si->flags & SWP_VSWAP) {
> >               put_swap_device(si);
> >               return -EINVAL;
> >       }
> >
> > -     /* try to allocate swap cache folio */
> >       mpol =3D get_task_policy(current);
> >       folio =3D swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NU=
LL, mpol,
> >                                      NO_INTERLEAVE_INDEX);
> > @@ -1416,25 +1422,25 @@ static bool zswap_store_page(struct page *page,
> >       if (!zswap_compress(page, entry, pool))
> >               goto compress_failed;
> >
> > -     old =3D xa_store(swap_zswap_tree(page_swpentry),
> > -                    swp_offset(page_swpentry),
> > -                    entry, GFP_KERNEL);
> > -     if (xa_is_err(old)) {
> > -             int err =3D xa_err(old);
> > +     if (is_vswap_entry(page_swpentry)) {
> > +             vswap_zswap_store(page_swpentry, entry);
> > +     } else {
> > +             old =3D xa_store(swap_zswap_tree(page_swpentry),
> > +                            swp_offset(page_swpentry),
> > +                            entry, GFP_KERNEL);
> > +             if (xa_is_err(old)) {
> > +                     int err =3D xa_err(old);
> > +
> > +                     WARN_ONCE(err !=3D -ENOMEM,
> > +                               "unexpected xarray error: %d\n", err);
> > +                     zswap_reject_alloc_fail++;
> > +                     goto store_failed;
> > +             }
> >
> > -             WARN_ONCE(err !=3D -ENOMEM, "unexpected xarray error: %d\=
n", err);
> > -             zswap_reject_alloc_fail++;
> > -             goto store_failed;
> > +             if (old)
> > +                     zswap_entry_free(old);
> >       }
> >
> > -     /*
> > -      * We may have had an existing entry that became stale when
> > -      * the folio was redirtied and now the new version is being
> > -      * swapped out. Get rid of the old.
> > -      */
> > -     if (old)
> > -             zswap_entry_free(old);
> > -
> >       /*
> >        * The entry is successfully compressed and stored in the tree, t=
here is
> >        * no further possibility of failure. Grab refs to the pool and o=
bjcg,
> > @@ -1487,6 +1493,7 @@ bool zswap_store(struct folio *folio)
> >       struct mem_cgroup *memcg =3D NULL;
> >       struct zswap_pool *pool;
> >       bool ret =3D false;
> > +     bool partial_store =3D false;
> >       long index;
> >
> >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > @@ -1524,8 +1531,10 @@ bool zswap_store(struct folio *folio)
> >       for (index =3D 0; index < nr_pages; ++index) {
> >               struct page *page =3D folio_page(folio, index);
> >
> > -             if (!zswap_store_page(page, objcg, pool))
> > +             if (!zswap_store_page(page, objcg, pool)) {
> > +                     partial_store =3D index > 0;
> >                       goto put_pool;
> > +             }
> >       }
> >
> >       if (objcg)
> > @@ -1548,7 +1557,9 @@ bool zswap_store(struct folio *folio)
> >        * offsets corresponding to each page of the folio. Otherwise,
> >        * writeback could overwrite the new data in the swapfile.
> >        */
> > -     if (!ret) {
> > +     if (partial_store && is_vswap_entry(swp))
> > +             folio_release_vswap_backing(folio);
>
> Hmm the above should also only happen in the !ret case, but that's not
> obvious from the code here. I think all of this should go under if
> (!ret), but maybe reverse the polarity to avoid the indentation?

Yeah that's just me avoiding indentation lol. But yes, it only happens
in !ret case:

>
>         if (ret)
>                 return ret;
>
>         if (is_vswap_entry(swp)) {
>                 if (partial_store)
>                         folio_release_vswap_backing(folio);
>                 return ret;
>         }
>
>         ...
>
> Alternatively you can move the check_old code for xarray into a helper
> and do:
>
>         if (!ret) {
>                 if (is_vswap_entry(swp)) {
>                         if (partial_store)
>                                 folio_release_vswap_backing(folio);
>                 } else {
>                         zswap_free_old_xa_entries(swp, nr_pages)
>                 }
>         }

Yup! I can switch to this if you think it's cleaner.

>
> Also, I think you can probably drop partial_store and check the index
> directly here.

Ah yeah. That's true!

>
> > +     else if (!ret && !is_vswap_entry(swp)) {
> >               unsigned type =3D swp_type(swp);
> >               pgoff_t offset =3D swp_offset(swp);
> >               struct zswap_entry *entry;
> > @@ -1588,8 +1599,7 @@ bool zswap_store(struct folio *folio)
> >  int zswap_load(struct folio *folio)
> >  {
> >       swp_entry_t swp =3D folio->swap;
> > -     pgoff_t offset =3D swp_offset(swp);
> > -     struct xarray *tree =3D swap_zswap_tree(swp);
> > +     struct swap_info_struct *si =3D __swap_entry_to_info(swp);
> >       struct zswap_entry *entry;
> >
> >       VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > @@ -1599,16 +1609,25 @@ int zswap_load(struct folio *folio)
> >               return -ENOENT;
> >
> >       /*
> > -      * Large folios should not be swapped in while zswap is being use=
d, as
> > -      * they are not properly handled. Zswap does not properly load la=
rge
> > -      * folios, and a large folio may only be partially in zswap.
> > +      * zswap_load() does not support large folios. For non-vswap
> > +      * entries this is unexpected on the swapin path: WARN and
> > +      * sigbus. For vswap entries __swap_cache_add_check() has already
> > +      * filtered out ZSWAP-backed THPs under the cluster lock, so the
> > +      * large folio here is zero- or phys-backed; return -ENOENT to
> > +      * fall through to the phys/zero IO path.
>
> Hmm should we start simple and avoid THP swapin for vswap initially?
>
> IIUC, it isn't really vswap specific. Even without vswap, it's possible
> that an entire folio is on-disk, not in zswap, in which case THP swap
> should be allowed.
>
> I assume it's not common for zswap to be enabled and an entire THP worth
> of pages are not in zswap, so maybe we can add this later?

I was thinking of removing it altogether haha. Are we even doing THP
swap in for non-sync IO devices?

if (!folio) {
    /* Swapin bypasses readahead for SWP_SYNCHRONOUS_IO devices */
    if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
        folio =3D swapin_sync(entry, GFP_HIGHUSER_MOVABLE,
[...]
else
    folio =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);

So I guess it's primarily zram that does THP swap in here? on
non-SWP_SYNCHRONOUS_IO devices, seems like we only do "THP swapin" if
we catch the page in swap cache (minor page fault). :) Will zram users
like vswap?

OTOH, zswap might be getting THP zswap-in support soon, so it's not
just zram backend that cares about these kinds of check? :)

Or maybe I can keep it, but separate it from this big patch to make it
easier to review :) Lemme play with it.

>
> >        */
> > -     if (WARN_ON_ONCE(folio_test_large(folio))) {
> > -             folio_unlock(folio);
> > -             return -EINVAL;
> > +     if (folio_test_large(folio)) {
> > +             if (WARN_ON_ONCE(!swap_is_vswap(si))) {
> > +                     folio_unlock(folio);
> > +                     return -EINVAL;
> > +             }
> > +             return -ENOENT;
> >       }
> >
> > -     entry =3D xa_load(tree, offset);
> > +     if (swap_is_vswap(si))
> > +             entry =3D vswap_zswap_load(swp);
> > +     else
> > +             entry =3D xa_load(swap_zswap_tree(swp), swp_offset(swp));
> >       if (!entry)
> >               return -ENOENT;
> >
> > @@ -1623,16 +1642,14 @@ int zswap_load(struct folio *folio)
> >       if (entry->objcg)
> >               count_objcg_events(entry->objcg, ZSWPIN, 1);
> >
> > -     /*
> > -      * We are reading into the swapcache, invalidate zswap entry.
> > -      * The swapcache is the authoritative owner of the page and
> > -      * its mappings, and the pressure that results from having two
> > -      * in-memory copies outweighs any benefits of caching the
> > -      * compression work.
> > -      */
> >       folio_mark_dirty(folio);
> > -     xa_erase(tree, offset);
> > -     zswap_entry_free(entry);
> > +
> > +     if (swap_is_vswap(si)) {
> > +             folio_release_vswap_backing(folio);
>
> Is there any advantage to calling folio_release_vswap_backing() over
> zswap_entry_free()? Seems like __vswap_release_backing() ends up just
> calling zswap_entry_free() -- and I don't see any vswap-specific state
> being cleaned up.
>
> I wonder if the zswap code should call zswap_entry_free() directly? Same
> goes for the call in zswap_store() above.

Most just not repeating the vtable lookup-and-lock and what not. :)
The pattern is repeated the third time in swapoff when I allow phys
swap to be the backend of vswap in the next patch so I figure probably
should add some helper.

>
> > +     } else {
> > +             xa_erase(swap_zswap_tree(swp), swp_offset(swp));
> > +             zswap_entry_free(entry);
> > +     }
> >
> >       folio_unlock(folio);
> >       return 0;
> > --
> > 2.53.0-Meta
> >

