Return-Path: <cgroups+bounces-17268-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3J9LIthyPGp+oAgAu9opvQ
	(envelope-from <cgroups+bounces-17268-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 02:14:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 096986C1F29
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 02:14:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VUaVg9gt;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17268-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17268-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDBFA303DD73
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 00:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA21684BE;
	Thu, 25 Jun 2026 00:14:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D2C13E41A
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 00:14:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782346453; cv=pass; b=kLO/eXK1VdW11tVSgAdKvMIW+0krpn4k1mGRNPrydkygSlrSpMcgk8lBiSc1FGt6Dr3pA69QR9fnxf645fwIxd6cH+n9D5uor/2g77DTz1wTYGJ9U50DAvhmHPeC/Bj1xLcszRqMSlTsmua8b0/gNKy8iyjU2QHmqUB7gSexIn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782346453; c=relaxed/simple;
	bh=rbwxD9NvlBeLm5utdKHPN9vWZkwTv/BkkG91wENKrrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0vNQVhfvnuCvSuS3/9S0sPmC+8CwxJMxr1iVHd+x7zx8tXb0um8I6wLw7FZ46wLiyyKODdIvhzhIjIdzHMlmrNdlpVU1pqd0A+zRANitQHSrI7rTnRLBSklJ1BKPG4kQ397taiddPagWg9h5nJCB41/aTrW406B2zRRc92z0t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUaVg9gt; arc=pass smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4924593f45dso18764155e9.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 17:14:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782346450; cv=none;
        d=google.com; s=arc-20260327;
        b=cUphP1lX9yi/6YT3HprDfg6PMrbq6+o33zETs/sPhI2hCW3TTEIpH8lPQzEM2AdByL
         5Z65+rndXGjF80J2BCuqdsrHLMshwbFCFu2K3SrE3p37LOsJq242AzgcRP+az+FJ3smB
         0FXvHSdd+7UZriIVvwCqimQTeU2mpyozuuGZG1K3Flh4DVAplJn9dj1+7mRTXNo3IUEk
         mYS9ZWA6a9LAmXZTa7YVK0EfEfPF0aIclxDHGFuGP30y67/CHXZ+brfoplQ+02ecUiW0
         lhhVMDKGmbrSIIZwRY4CBdrRcnajP4ivnfB2kmDVG4RgygFCYzz7cSkxLz/Tdn/c7V7+
         eALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQUU4QEwAFRoM46ZCAt+65nFqlnbcp63bvZEbEWuj4k=;
        fh=Kq7wA1TmZrGdv1eNbIi++F6hgQjYPcWnwVDG8iIidA4=;
        b=ixTKsqyhXnPlUJdHPymcaPYDVMFhi9oG+2jwRt9rVMni+iPlHyN1G9vGGebiMGZ7RO
         3eqM4qX8jOS11mInyTUi/mQ88O/gBrTqJ9+B1WCuPRWhwXkmrjAylGPnJhxYb0TszU9Q
         23edL9LfORooRNBdIVyXDpHJrKft0yN/bav+KSLvlvtiQbg/NuPBNRqMdU6svCknz6Xo
         r0q+E3svSygkA5LXNO5Oe26+8kdCl5FAFVv7ovfDgWZ+XZWSQ4qwJaKHJ1sktldBASSv
         5OFINMHVHBGL4e8H08exF7IddZuWBUwo0NYCd8roIgGK9B8zK0uNAfAG2OyxiZBHwUBW
         iNkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782346450; x=1782951250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQUU4QEwAFRoM46ZCAt+65nFqlnbcp63bvZEbEWuj4k=;
        b=VUaVg9gtomuEqay9V35r3TsLS30xv7VoMAoQB/X1stelj10FjfNakESVqCwg1P56Dx
         UFLFyIKwZu5YWLPJ0S31mVaLEqN8KOfoK7EwC+hoDCuilO7/wXzpp/KMDh1BfVgpnOwF
         QzxEZN49PxZ/vblgzYVZMj6RVyned4YKBJmlig0s0asP47zhmfF92MoVYxg0AboCWmqr
         nfhWqRnKJk5SbsU1EXHDuVMFSCAHw+H8T/s3cL0lGjAgDJRx5/u08cixdDo/jVn+lfaZ
         avdGDUNb5gJs9B3JpAoCJqQxrSZ1AxAL1qQB/XVd9JGtCjwjYX+gYiQo4T3Kmv1XCPyz
         8Fcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782346450; x=1782951250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQUU4QEwAFRoM46ZCAt+65nFqlnbcp63bvZEbEWuj4k=;
        b=PsY42MaO4buAE3Qg/mE1P2V4qnYfv2QFEJag02q9x8avkfLOq/7ZDQH23MqO9hh8/I
         u5rqkfi1FQ5qg+2wrJmuXUkoCtX8+xEYb6LcpwkBhONC6ozzI6JTCNqN1AMbI4XNMXhJ
         s18d1PCPXxzH229P6aZ+5xCzflgb9ykxkqAbJp3oMJNnTgvipHioLImzkpT+CFSt+OFO
         JkRSpY4dQF5CzSvC3hzObUkKcDeUV1iLekQaSttqgQcREhu3NY6/QQM9Jkyy1LCew0Ez
         kuc78a7QWN+1DOiKgG/CWzC7011bDy74HuAWhEjj1uyB1eeGlRuRft3A2ybvQzJNqNsl
         kdSA==
X-Forwarded-Encrypted: i=1; AFNElJ9d+sxdkqz45yt+gYlxkM7DLNmi6t5oxOH7WFkiH+YwugCucZHQ7bGCVSF2jY2Q5wOBWAf/H7Ww@vger.kernel.org
X-Gm-Message-State: AOJu0YzwLqeievRbQTB0QxztsDs3XDcZsy3ZoZM5JLXDrHuR0gq7jom6
	9bD/AupRFnbHj6bqXt0pbazx/LLt1ufG/I2/rFCrVRorfDVgOwDjtG87lfg2MfCyBo8t3KhEieC
	rY18sqnjh7dpXQw+N6JMXubTZQLF7chc=
X-Gm-Gg: AfdE7clpsg4lpbxZiA2b24pdLwT6hc2S9iBZUAnN4SCdvmJFcqzi3lSLQsHXsssYLqH
	ZPc2EF6UnxC0D4OZxjTQ64WZE/u0nzzoRD+5aSW8Y5njOKrue6N/lmuxvm2aSfX0mlRd4+9GLA8
	YM3lgdUyvPFf5UqRwVVB3JKvsRl0Xky7DkX9fyEp5z4qBGsChNB7nRMXB9dW+WzMvlK6d86TN+v
	b5WlL8aP7ZCK2kZ29doiM9f0i0P1s+SkHhK4y7HT4nkAjy7UbmhKDC8bOTQjJrVAcCwo1eQ8r12
	t4h1fTlxE5gJHtQrnO5sp2Ro50anMtadkkUy4R/nMgJsyHNWSqZubxY=
X-Received: by 2002:a05:600c:a46:b0:492:604b:c77b with SMTP id
 5b1f17b1804b1-49266885dcfmr780335e9.26.1782346450038; Wed, 24 Jun 2026
 17:14:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <20260612193738.2183968-4-nphamcs@gmail.com>
 <CAO9r8zPXk2eRbVcEMQDTCH1j-w241h189=p04FenAfKAjkkQtA@mail.gmail.com>
In-Reply-To: <CAO9r8zPXk2eRbVcEMQDTCH1j-w241h189=p04FenAfKAjkkQtA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 24 Jun 2026 17:13:58 -0700
X-Gm-Features: AVVi8CepHOibpPdukelNQnwEdTBgwRTdcmtt33fMSa9KmP8wKp2yKEwbQKXWFqM
Message-ID: <CAKEwX=PT_ABx51--Qv9AAZwkuH+_Wp_TeiUYVQBY=1=SCf1HJA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] mm, swap: support physical swap as a vswap backend
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17268-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 096986C1F29

On Tue, Jun 23, 2026 at 12:02=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wro=
te:
>
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 466f8a182716..5daff7a25f67 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -993,6 +993,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
> >         struct folio *folio;
> >         struct mempolicy *mpol;
> >         struct swap_info_struct *si;
> > +       swp_entry_t phys =3D {};
> >         int ret =3D 0;
> >
> >         /* try to allocate swap cache folio */
> > @@ -1000,16 +1001,6 @@ static int zswap_writeback_entry(struct zswap_en=
try *entry,
> >         if (!si)
> >                 return -EEXIST;
> >
> > -       /*
> > -        * Vswap entries have no physical backing - writeback would fai=
l
> > -        * and SIGBUS the caller. Bail before we waste a swap-cache fol=
io
> > -        * allocation.
> > -        */
> > -       if (si->flags & SWP_VSWAP) {
> > -               put_swap_device(si);
> > -               return -EINVAL;
> > -       }
> > -
> >         mpol =3D get_task_policy(current);
> >         folio =3D swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), =
NULL, mpol,
> >                                        NO_INTERLEAVE_INDEX);
> > @@ -1028,40 +1019,78 @@ static int zswap_writeback_entry(struct zswap_e=
ntry *entry,
> >         /*
> >          * folio is locked, and the swapcache is now secured against
> >          * concurrent swapping to and from the slot, and concurrent
> > -        * swapoff so we can safely dereference the zswap tree here.
> > -        * Verify that the swap entry hasn't been invalidated and recyc=
led
> > -        * behind our backs, to avoid overwriting a new swap folio with
> > -        * old compressed data. Only when this is successful can the en=
try
> > -        * be dereferenced.
> > +        * swapoff so we can safely dereference the zswap tree (or vswa=
p
> > +        * vtable) here. Verify that the swap entry hasn't been
> > +        * invalidated and recycled behind our backs, to avoid overwrit=
ing
> > +        * a new swap folio with old compressed data. Only when this is
> > +        * successful can the entry be dereferenced.
> >          */
> > -       tree =3D swap_zswap_tree(swpentry);
> > -       if (entry !=3D xa_load(tree, offset)) {
> > -               ret =3D -ENOMEM;
> > -               goto out;
> > +       if (swap_is_vswap(si)) {
> > +               if (entry !=3D vswap_zswap_load(swpentry)) {
> > +                       ret =3D -ENOMEM;
> > +                       goto out;
> > +               }
> > +               /*
> > +                * Allocate physical backing BEFORE decompress - if it =
fails,
> > +                * no wasted work. folio_realloc_swap sets vtable to PH=
YS,
> > +                * overwriting ZSWAP - the old entry pointer is only he=
ld
> > +                * by the caller now.
> > +                */
> > +               phys =3D folio_realloc_swap(folio);
> > +               if (!phys.val) {
> > +                       ret =3D -ENOMEM;
> > +                       goto out;
> > +               }
> > +       } else {
> > +               tree =3D swap_zswap_tree(swpentry);
> > +               if (entry !=3D xa_load(tree, offset)) {
> > +                       ret =3D -ENOMEM;
> > +                       goto out;
> > +               }
>
> There's a lot of divergence in the code (in this patch and previous
> ones). Seems like a lot of it is to do xarray operations vs vswap
> operations. I wonder if we can abstract these into helpers, e.g.
> zswap_tree_store(), zswap_tree_load(), etc. Maybe the name is not the
> best, but you get the point :)

How about zswap_entry_load() and zswap_entry_store()? :)

>
> Here we can then do zswap_tree_load() for both code paths and only the
> folio_realloc_swap() needs to be different for vswap. We can do
> similar cleanups for the load/store paths as well.
>
> >         }
> >
> >         if (!zswap_decompress(entry, folio)) {
> >                 ret =3D -EIO;
> > +               /*
> > +                * For vswap: folio_realloc_swap already moved the entr=
y
> > +                * out of the vtable. Restore it via vswap_zswap_store =
so
> > +                * the entry stays tracked (and the just-allocated PHYS
> > +                * slot is freed). For non-vswap: entry is still in the
> > +                * zswap tree.
> > +                */
> > +               if (swap_is_vswap(si) && phys.val)
> > +                       vswap_zswap_store(swpentry, entry);
>
> Should this go in the cleanup path instead (i.e. in the 'out' label?).

Ah, maybe if (ret =3D=3D -EIO &&)...

>
> >                 goto out;
> >         }
> >
> > -       xa_erase(tree, offset);
> > +       if (!swap_is_vswap(si))
> > +               xa_erase(tree, offset);
>
> Maybe this can also be abstracted into a helper, but I wonder what the
> corresponding vswap operation would be. I think folio_realloc_swap()
> will have already "erased" the zswap entry from vswap. Maybe have a

Yup that's the right logic. We already change the backend to physical
swap slot here, so there's no real "erase".

> vswap helper that will only remove it if it's a zswap entry? We can
> probably do a lockless check first to make it cheap?
>
> It's probably silly to do this, and maybe there's a better way.
> Generally, I think the code would be easier to follow if we abstract
> away the xarray vs. vswap stuff into helpers (where it's reasonable).

I'm not entirely sure if its worth it either, yeah. Unlike load and
store, erase seems a bit asymmetric in the sense that we only need to
do it for non-vswap cases.

