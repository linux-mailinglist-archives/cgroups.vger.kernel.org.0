Return-Path: <cgroups+bounces-1232-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8C83B051
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 18:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8083A1C22851
	for <lists+cgroups@lfdr.de>; Wed, 24 Jan 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3E1272CB;
	Wed, 24 Jan 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMyTAmrs"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBCA1272A5
	for <cgroups@vger.kernel.org>; Wed, 24 Jan 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118397; cv=none; b=btc2nG6HdFsHlT3/rPvAuG3/g2seUhXysdwps2ueDOLtZl/qndkFJQ+4aAA0sEusZrfuLM/+9wTJ6ZCdI1l/krSTX4kEDwmUC7pcy3OTvKTPbVXKU2fcUhU5jefBzHk+XAbzHx1DoWYMeZj6rwgkwRQpGfxr73zxvN8yfmBtRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118397; c=relaxed/simple;
	bh=85X4MSVhu6FZyouQ/Vf2EMa2KnP6pI2T2c6pSfjhuGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEq3IFcUU44Zgu9NGcUYJFckk2Tdb2AbLKU0ypp9oYuF4heSSoKo5H8UQXcIlBwGFaeh51kvJoCEpY+HwcrVueG7Tk58/bYeSwkRVU06OOD+JDMgIyvWK0iLRtAkoBkKVjw6vRWPSXtzNuG0lbARqR8LbwXfb8IQAA6ySdQCXIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMyTAmrs; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5ffb528dc8dso33742037b3.1
        for <cgroups@vger.kernel.org>; Wed, 24 Jan 2024 09:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706118395; x=1706723195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcrjU1rXiL0wUCSwbKfLMXGroLa5TBhUecGAmJobD/I=;
        b=HMyTAmrsiXetH6P5VydKM0Vcw4WVkpfcVzjQh2vRhvBmUwYiHkShOidKwUJT/soYI2
         XaSxIODvBaYvS3536EVYAH/wD+/YoCnELYv3QIIS9rzO4oSik9O/Dq2fWlqpFMtB6NcC
         /TcMFDI2Q1h/qEQ7DowwDupEFChFwUbSncRzkBWerK5leK6WadX+qAeaDcCP8QKSUnhU
         ntcujFh0XHmUw3Zjg48PGFCojMs5KLBoPbjnCqaBpOX4OG+xvijnOMjAVYURmcEZDi4q
         1Wmc5ZkhZw8hhcuM/vfZ2B3KL3VvHJW0GXJ8RAIGuvh0uBPBCRwD1PeByazGUkA+0/wD
         JkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118395; x=1706723195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZcrjU1rXiL0wUCSwbKfLMXGroLa5TBhUecGAmJobD/I=;
        b=BJrOevtlvw8j9M/uBkYrBIvbd9BIgaJ/qfR3A8GVGR496Uj6eKjUhbmfw/N4WkoOP1
         ajsxOTsTZT1bgi4WmAJhOjX9hbNguBehVQ6oemyhG8WK5Kyy6wFon57VdRDRKgNVOxx6
         yQLiohBqHstnKX1SpgAn2tzBMFw2NX0wfizLB8GW6i/Rmg2QG8Y6VJj854gawxJE2cBy
         oCsv9fwyrvjNy0hQVleIJHKcLpCyDnpLb1CDVa7RBBHw6sboZuuqWQBPqmNKdMZiQbFo
         nfQ0+lkBWCiCU0kNwN0Toq1q3BA5sBTXmbq1TjW3Jsw9h2K2a99ElnbMPFxCs86pF1HA
         IHlA==
X-Gm-Message-State: AOJu0Yw6N6VSQgQKyd1S01IsY2eCs/tY6O1oNqi5dbxd0TKwe0Qn1qRq
	uaFx2Cu92c/32rNck1l/aeW8pHtDlUQ5hpla6mDaoFzCmKJhx99OkIpW0CTHQnaMH0i+iZv9/cD
	xs6XAoq1J4M4mfpbUbourJKvIKF0Rl7Jupjjy
X-Google-Smtp-Source: AGHT+IGzutMsHILIshINx/VyFhlmwzviKnVmCZccXt19IOpc00/Klu99g2L+eiYhp7VbIDr/mDW1lxNH0NqhwmeCZNM=
X-Received: by 2002:a81:ae21:0:b0:5ff:a961:d91c with SMTP id
 m33-20020a81ae21000000b005ffa961d91cmr19539ywh.1.1706118394850; Wed, 24 Jan
 2024 09:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121214413.833776-1-tjmercier@google.com> <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com> <20240123164819.GB1745986@cmpxchg.org>
In-Reply-To: <20240123164819.GB1745986@cmpxchg.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 24 Jan 2024 09:46:23 -0800
Message-ID: <CABdmKX1uDsnFSG2YCyToZHD2R+A9Vr=SKeLgSqPocUgWd16+XA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, yuzhao@google.com, 
	yangyifei03@kuaishou.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 8:48=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The revert isn't a straight-forward solution.
>
> The patch you're reverting fixed conventional reclaim and broke
> MGLRU. Your revert fixes MGLRU and breaks conventional reclaim.
>
> On Tue, Jan 23, 2024 at 05:58:05AM -0800, T.J. Mercier wrote:
> > They both are able to make progress. The main difference is that a
> > single iteration of try_to_free_mem_cgroup_pages with MGLRU ends soon
> > after it reclaims nr_to_reclaim, and before it touches all memcgs. So
> > a single iteration really will reclaim only about SWAP_CLUSTER_MAX-ish
> > pages with MGLRU. WIthout MGLRU the memcg walk is not aborted
> > immediately after nr_to_reclaim is reached, so a single call to
> > try_to_free_mem_cgroup_pages can actually reclaim thousands of pages
> > even when sc->nr_to_reclaim is 32. (I.E. MGLRU overreclaims less.)
> > https://lore.kernel.org/lkml/20221201223923.873696-1-yuzhao@google.com/
>
> Is that a feature or a bug?

Feature!

>  * 1. Memcg LRU only applies to global reclaim, and the round-robin incre=
menting
>  *    of their max_seq counters ensures the eventual fairness to all elig=
ible
>  *    memcgs. For memcg reclaim, it still relies on mem_cgroup_iter().
>
> If it bails out exactly after nr_to_reclaim, it'll overreclaim
> less. But with steady reclaim in a complex subtree, it will always hit
> the first cgroup returned by mem_cgroup_iter() and then bail. This
> seems like a fairness issue.

Right. Because the memcg LRU is maintained in pg_data_t and not in
each cgroup, I think we are currently forced to have the iteration
across all child memcgs for non-root memcg reclaim for fairness.

> We should figure out what the right method for balancing fairness with
> overreclaim is, regardless of reclaim implementation. Because having
> two different approaches and reverting dependent things back and forth
> doesn't make sense.
>
> Using an LRU to rotate through memcgs over multiple reclaim cycles
> seems like a good idea. Why is this specific to MGLRU? Shouldn't this
> be a generic piece of memcg infrastructure?

It would be pretty sweet if it were. I haven't tried to measure this
part in isolation, but I know we had to abandon attempts to use
per-app memcgs in the past (2018?) because the perf overhead was too
much. In recent tests where this feature is used, I see some perf
gains which I think are probably attributable to this.

> Then there is the question of why there is an LRU for global reclaim,
> but not for subtree reclaim. Reclaiming a container with multiple
> subtrees would benefit from the fairness provided by a container-level
> LRU order just as much; having fairness for root but not for subtrees
> would produce different reclaim and pressure behavior, and can cause
> regressions when moving a service from bare-metal into a container.
>
> Figuring out these differences and converging on a method for cgroup
> fairness would be the better way of fixing this. Because of the
> regression risk to the default reclaim implementation, I'm inclined to
> NAK this revert.

In the meantime, instead of a revert how about changing the batch size
geometrically instead of the SWAP_CLUSTER_MAX constant:

                reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
-                                       min(nr_to_reclaim -
nr_reclaimed, SWAP_CLUSTER_MAX),
+                                       (nr_to_reclaim - nr_reclaimed)/2,
                                        GFP_KERNEL, reclaim_options);

I think that should address the overreclaim concern (it was mentioned
that the upper bound of overreclaim was 2 * request), and this should
also increase the reclaim rate for root reclaim with MGLRU closer to
what it was before.

