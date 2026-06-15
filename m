Return-Path: <cgroups+bounces-16920-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ndQwKFpVL2ps+gQAu9opvQ
	(envelope-from <cgroups+bounces-16920-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 03:28:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F46682BF9
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 03:28:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=koJCR0uL;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16920-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16920-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADC833007378
	for <lists+cgroups@lfdr.de>; Mon, 15 Jun 2026 01:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236EF239E80;
	Mon, 15 Jun 2026 01:28:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAE4223DFB
	for <cgroups@vger.kernel.org>; Mon, 15 Jun 2026 01:28:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781486922; cv=pass; b=kJy5KN98NFMiF4EkO3KjTpSXxm/JQC9d9YqhrnY9E9Dv7jYuSNy0GYoGgvcS7WA0oIKTs9ZjPU7wg1JjRmryOl/lP4Yk5Mp7eHdxtlT5EOgxTvk42Nzl06xvyiWVx+EWqiTBQPkeyFNTVkznQ9fcPZgGmsoIcxQk21vrGtTrtMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781486922; c=relaxed/simple;
	bh=ULCiQmh3Fr57rxfPWnrO4oKZXSzYPIWseb5cOe0Q/Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rr4M+u5BSKSkFgc6+KbmURUDcEZU4rX3RJCHvKMigJS+yROuLo4mey5s26ESRm+/HM7HU5y+mAbj79po0RpQlfMnXoyB8UqBNLsQPUlBd/HTeDGYZGPQ0fyYCL7mIIvvAmx7B4W2XWgF+xAR7iOv5W6j7BE7xXlPqFddv7+y6CI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=koJCR0uL; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5177d1ff061so658341cf.1
        for <cgroups@vger.kernel.org>; Sun, 14 Jun 2026 18:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781486920; cv=none;
        d=google.com; s=arc-20240605;
        b=NcayNI9/bzlTXLVkL00Ay4e7tPvxOM15WAW0pGEMg4/Pl8eC13MseCB4EvypTJVp0u
         IyEMbrGS3oxvM4EcELD++d4KOg38Y8GZ22yG/tKoUTvVNbnLnOgPtZxSiWSnnnPgkkNi
         igcBUiM06gwSIPswhRoS/B6VenHec0QTmPP4le0NSziZlk9/wuZgciZP8UKN+QSziw/k
         8ckUBccSVC7vk+FwYXiiy8RLvEF+Dw36zBR2qoonpqmgEytA481ceICBddV+qW1d25WB
         9+gGVF3UIKs4tt/X3Tli3iImTepJ9QRnezqOowOVNGCZSiShxJvfJKDsclIbsc8UwQ70
         BUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ULCiQmh3Fr57rxfPWnrO4oKZXSzYPIWseb5cOe0Q/Q0=;
        fh=qrst8mZ/All+yTcurb6M1/QRLvXZaBbYUgNV0Y7mS0Y=;
        b=Jymlfd0hf+neBfECnNotCuah9354DBHOHhyZSSCBO5/Oc82sRrFMFYN7icsUF0/Tx5
         e2joSTRaIFv5KYKb0z4OAHSv1PZ6/BY+co+V1hdDQGMpQZrPurzRcdluNTk6kcehqsBU
         OCGscU7fgAIdZ9FaQW6RsWnUcRphxD51JO+cxqBcosn4SZu1CpKoHlNSUtmIOkjlNiQZ
         lisadjZgmamJZvGbzehD2GHiQ9/N70JYPs02/ONwTLO3V1a4izYQVxYr7g/LvGWspiRZ
         wuZc2hwc9w1ID1ofLtsv/UdEnVUroZyvpjmW0lGJOTSadUmvanrgceH0Hf2mOU0L1qsp
         kgvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781486920; x=1782091720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULCiQmh3Fr57rxfPWnrO4oKZXSzYPIWseb5cOe0Q/Q0=;
        b=koJCR0uLfDG7hX7njhpieGWG76eCmvfUQLzatSCzVW1sVHAto19bgjV3Vp+5R25+ke
         Ub5pB8q+o0o/frHossnrTar3lsxZJmcMIu1SuQacJ3ktJoCpdBvvG8Jaq9iJgZqQO86s
         MUMtGoxDD8NIU2ZzdTjHW4n8oj/RJz50C1RMVNp64v9O4i0jzDD9O15Pjr8AbXRX1/lK
         1dSLmzfxbKlPFVonFuwLOnrNHkE7dvLVHlRBrqHNPHBL7oUQo0uU5+fRHEmaX7fXOIAT
         j8lk37c7/6/NZDqRJj9pAUljUiyzLSjcWjQf/Jd4YTwKxCdox6oI7ktTszf3xtdWKtHs
         XR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781486920; x=1782091720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ULCiQmh3Fr57rxfPWnrO4oKZXSzYPIWseb5cOe0Q/Q0=;
        b=ERquhvcGi/j5n6ZTEn+C3IMjwM0ZtmENKHsd/STmT+v0axG/bYnORiMHU+35vk1hUj
         lrTiR1V4jPIH+vm9dzbL+PjGy1NHicv9ASXJOjdlzh+dreXy/SXMoPbNBGcRN0WPSD1M
         ueEv4p3vMAxlLxEYJpSTsACMiloHnllrxjqRmLCgz2kOZxaG1rfJe5oZPmAti3dR+UTe
         oLnQWkMMR2WzHNxi+EX0TwL3/8cPdW4EN7KPk+vYllsZueDLSXyhPw2xbMfUxCnkGK/W
         57DFZE4WJRkOMm2WC+rbOO+ygLXtiDVp3z1g201yuV26UEHFi4maILqVD49ZbJIbRV3H
         tXkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Dm2+yCB+9//w18TfP+JHuV0vCFElnGmMq6G3rrdKJH6m9UsTPmENo3h2tvF7lMzbW2HcQTrZE@vger.kernel.org
X-Gm-Message-State: AOJu0YzlI/aXNsSokRUm/uJKSu5VipdzLfqBVUBOS/cxUUqZ28s7Zvfq
	Ud6zwGs1ozGfDqSMS9d/7aT25kep/XJaNpI9phwcai95PDPeL++W9efvkMupc7x+bgOK4HYOuxi
	nvKcsAdfGZmirFRn4lyX4L5k9A6PgqhNX6Ge/HqHj
X-Gm-Gg: Acq92OGvxn4eFeNHXdOAJZu93Zh3MPvtHuXB/k8shVLkw/ojoZfzx7pDxyEEePdkKbl
	9yaqXNYVMetA27497+RoSpmzHsaWdDISfa2zoeeHaJI73wp+UwoElojgLsTuY+XjRSojJtvZ4EJ
	WvsHWp3T/FZplHuuRZepgdh9JMKSrhgFdc3SVLqh1xG78YNkbr14L+rQAd0/Loqu+PwRWyJHv7e
	xYp3WlT5MuqW4Im4fBdUrZ67hr/AMwExxOzx90FSm2IMXAMJ29h84mwhJgB4072upO7k8CIDZh4
	+FuBZg==
X-Received: by 2002:ac8:5785:0:b0:517:38aa:c2b3 with SMTP id
 d75a77b69052e-519549f8a99mr12415291cf.14.1781486919930; Sun, 14 Jun 2026
 18:28:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-slab_alloc_flags-v2-0-7190909db118@kernel.org>
 <20260610-slab_alloc_flags-v2-2-7190909db118@kernel.org> <b6530e92-d648-4028-9e77-0df8c3ab166d@kernel.org>
 <159d1e20-5b21-4329-ac9a-f7a5cb0fd56a@kernel.org> <e71bfc13-c233-4f85-a6ec-76327d3c6510@kernel.org>
 <74adf668-78c2-4989-a6c6-c6ec7bd68855@kernel.org> <4cf98483-ae35-4ad0-8f77-5a46194eb65f@kernel.org>
In-Reply-To: <4cf98483-ae35-4ad0-8f77-5a46194eb65f@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 14 Jun 2026 18:28:29 -0700
X-Gm-Features: AVVi8CeJscivUYBempgvh_YTouGssLUsWYrE-XuqGN36nJ9_C6J7p37pzGF9m8A
Message-ID: <CAJuCfpH8g9mNGV_ke-mhVZ=J9J05PZg-ozPTA=5WQrm_eViVpA@mail.gmail.com>
Subject: Re: [PATCH v2 02/16] mm/slab: do not init any kfence objects on allocation
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vbabka@kernel.org,m:harry@kernel.org,m:hao.li@linux.dev,m:cl@gentwo.org,m:rientjes@google.com,m:roman.gushchin@linux.dev,m:ast@kernel.org,m:akpm@linux-foundation.org,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:shakeel.butt@linux.dev,m:glider@google.com,m:andreyknvl@gmail.com,m:elver@google.com,m:dvyukov@google.com,m:kasan-dev@googlegroups.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-16920-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,gentwo.org,google.com,linux-foundation.org,cmpxchg.org,gmail.com,googlegroups.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[surenb@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1F46682BF9

On Thu, Jun 11, 2026 at 9:37=E2=80=AFAM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 6/11/26 17:11, Harry Yoo wrote:
> >
> >> From 3a1c4398ce9f361a4e6f4d9946eab6237eea89c2 Mon Sep 17 00:00:00 2001
> >> From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
> >> Date: Wed, 10 Jun 2026 17:40:04 +0200
> >> Subject: [PATCH] mm/slab: do not init any kfence objects on allocation
> >>
> >> When init (zeroing) on allocation is requested, for kmalloc() we
> >> generally have to zero the full object size even if a smaller size is
> >> requested, in order to provide krealloc()'s __GFP_ZERO guarantees.
> >>
> >> When we end up allocating a kfence object, kfence perfoms the zeroing =
on
> >
> > nit: perfoms -> performs
>
> Fixed.
>
> >> its own because has its own redzone beyond the requested size. Thus

nit: s/because has/because it has

> >> slab_post_alloc_hook() has an 'init' parameter which has to be evaluat=
ed
> >> in all callers (via slab_want_init_on_alloc()) and should be false for
> >> kfence allocations.
> >>
> >> For kfence allocations in slab_alloc_node() this is achieved by subtly
> >> skipping over the slab_want_init_on_alloc() call. Other callers (i.e.
> >> kmem_cache_alloc_bulk_noprof()) however evaluate it unconditionally ev=
en
> >> if they do end up with a kfence allocation. This is only subtly not a
> >> problem, as those are not kmalloc allocations and thus the "requested
> >> size" equals s->object_size and thus it cannot interfere with kfence's
> >> redzone. There's just a unnecessary double zeroing (in both kfence and
> >> slab_post_alloc_hook()), but it's all very fragile and contradicts the
> >> comment in kfence_guarded_alloc().
> >>
> >> Remove this subtlety and simplify the code by eliminating the init
> >> parameter from slab_post_alloc_hook() and make it call
> >> slab_want_init_on_alloc() itself. Instead add a is_kfence_address()
> >> check before performing the memset, which will start doing the right
> >> thing for all callers of slab_post_alloc_hook().
> >>
> >> This potentially adds overhead of the is_kfence_address() check to
> >> allocation hotpath, but that one is designed to be as small as possibl=
e,
> >> and it's only evaluated if zeroing is about to happen. This means (asi=
de
> >> from init_on_alloc hardening) only for __GFP_ZERO allocations, and the
> >> zeroing itself comes with an overhead likely larger than the added
> >> check.
> >
> >> While at it, refactor the handling of evaluating when KASAN does the
> >> init instead of SLUB, with no intended functional changes. A
> >> non-functional change is that we don't pass kasan_init as true to
> >> kasan_slab_alloc() if kasan has no integrated init, but then the value
> >> is ignored anyway, so it's theoretically more correct.
> >
> > Right.
> >
> >> Thanks to Harry Yoo for the initial refactoring attempt, and for updat=
ed
> >> comments that are used here.
> >
> > No problem ;)
> >
> >> Link: https://patch.msgid.link/20260610-slab_alloc_flags-v2-2-7190909d=
b118@kernel.org
> >> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> >> ---
> >
> > Looks good to me,
> > Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> Thanks!
>
> > Thanks!
> >
>

