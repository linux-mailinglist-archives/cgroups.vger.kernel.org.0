Return-Path: <cgroups+bounces-1248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE0B83EB68
	for <lists+cgroups@lfdr.de>; Sat, 27 Jan 2024 07:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6762843E1
	for <lists+cgroups@lfdr.de>; Sat, 27 Jan 2024 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1414A8E;
	Sat, 27 Jan 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9l+dhbg"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850CC13AC7
	for <cgroups@vger.kernel.org>; Sat, 27 Jan 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706336289; cv=none; b=P5omZne8AvOEF8bsOMRk/7HmSzR2Sdfs1qM79shhYL0LYWYgh6bvP+0uIak8OrRyefTRdDkqCGXwxBVdb2Ipxa0Uiil1QwPv0Edhrf1tjUqqPvrrj/SYsibqWFFToG9zIPJdq1ImsK8W5LXfmLrOB8kBP3UnIjZIScO5j907Tps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706336289; c=relaxed/simple;
	bh=w1/OgqChEj6StyqlrSu+Vzw7cQuKvUK042Bi/JTM83w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebO8GFOFChHN37sy3NlB2fKIo50aPG50IXtaTwF4//YIzEQGGSeXdBqbmcJP01bfEz9KI1AfAWbHY3Xqc7l5mrtCIZ5yAOineZLVs6OT20MKCm++wrSuMo/wXI96+G9EJqVSrU68SQ6m1zQMSNjEjejkjbDuonyPb8MA5to/urM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9l+dhbg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55d418c5ca1so3030a12.1
        for <cgroups@vger.kernel.org>; Fri, 26 Jan 2024 22:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706336286; x=1706941086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQS8ABsYVYk+vXzULL6wVLsWJRItyzMNzDk9tNnAZhk=;
        b=Z9l+dhbguPn2nvzsDvFFauhRtnuLgvL0IcyvcZjffL5MOAMn+oeMIjBR/RyVGFK4sJ
         Nm5mXOUTbR4Rf1VF1GLNxsDknU7tkCJtxaC9p5QFivTHzSwCFtXndZMtxO6zybi4zPbO
         gosWSzD8bzMOS7gSYn1RiDwAl9uB2eFUPtFRqdh26m9qsb248pfdQ/ajaVAOpMZP2Xeu
         xwTe9QBLTV/QGUNIhmC76T5ReizHSFuCfPgyN8OIwkrGlizzOOWk6Kzm8PuN4yHRGVl7
         OVar4vmb3r/dviwuXbOwlKvBBS6uU4NW+3qaARFZ1e26oTHGdye8o92jCb48CMtvnAz5
         JInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706336286; x=1706941086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rQS8ABsYVYk+vXzULL6wVLsWJRItyzMNzDk9tNnAZhk=;
        b=pGHFL6Q7V1dXM15UYrEZTi3g/3LegcbuAUXxDSF0NdtR/TxERxI15o84eSXq+YgXGZ
         +bNVLvBE3DD49Gdu3dH5ZJFLup/TZjuARd6DjVXqefYQmxhGn17JenSkXCAMzMRx1BY5
         Xm5nLd/S3JcW/5G3Zl3hY+BOok+SOCkvtyCo5IbZegILKJIzB/IQ7XOYFxOMXmlSvmOS
         fgQv47RCXWWaV427wRN3ycpBNVrUwvhNDSNbwxpndWV9FBoJckuz3GSJ6oBUeIyg55Qa
         QOz5su3MONe2UVNH0D+2qLmC3RgdVn/73932RxnTgTz//D8ccSJgLpS74BfFsr6aTvUf
         OIVg==
X-Gm-Message-State: AOJu0YycEwDjIkP8R5Tvs8pQnBfDAnhHZeXI/hQsm0yunbhEVqIUAEYb
	sHmF7r7bLzlenqVEmB97HLLVzOpP7HW70gXBepGrTtbtBbQQIu6QGAGriWiCTZ0Q1GcY5OH6Kgy
	KUMWYxrezrQtuk1O0LY9ft/5O0iry2Z7dvXYn
X-Google-Smtp-Source: AGHT+IEC/ffY0/I5b9O6s6DxqO/WeV7hfBpt/L89V/jFI/rxF/SDPYan36q5Xk+Jeuh9WDU6CfTsaVmCB0AJFAzvT0s=
X-Received: by 2002:a05:6402:2281:b0:55e:b62f:6eb6 with SMTP id
 cw1-20020a056402228100b0055eb62f6eb6mr27532edb.3.1706336285548; Fri, 26 Jan
 2024 22:18:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240121214413.833776-1-tjmercier@google.com> <Za-H8NNW9bL-I4gj@tiehlicka>
 <CABdmKX2K4MMe9rsKfWi9RxUS5G1RkLVzuUkPnovt5O2hqVmbWA@mail.gmail.com> <20240123164819.GB1745986@cmpxchg.org>
In-Reply-To: <20240123164819.GB1745986@cmpxchg.org>
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 26 Jan 2024 23:17:26 -0700
Message-ID: <CAOUHufa68Tm0OpWkzC_VQYAEGtgaAwkJQqztOFwBqYrDD=1T+g@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm:vmscan: fix inaccurate reclaim during
 proactive reclaim"
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, Michal Hocko <mhocko@suse.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, android-mm@google.com, 
	yangyifei03@kuaishou.com, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:48=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The revert isn't a straight-forward solution.
>
> The patch you're reverting fixed conventional reclaim and broke
> MGLRU. Your revert fixes MGLRU and breaks conventional reclaim.

This is not true -- the patch reverted regressed the active/inactive
LRU too, on execution time.

Quoting the commit message: "completion times for proactive reclaim on
much smaller non-root cgroups take ~30% longer (with or without
MGLRU)."

And I wouldn't call the original patch a fix -- it shifted the problem
from space to time, which at best is a tradeoff.

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
>
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
>
> We should figure out what the right method for balancing fairness with
> overreclaim is, regardless of reclaim implementation. Because having
> two different approaches and reverting dependent things back and forth
> doesn't make sense.
>
> Using an LRU to rotate through memcgs over multiple reclaim cycles
> seems like a good idea. Why is this specific to MGLRU? Shouldn't this
> be a generic piece of memcg infrastructure?
>
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

