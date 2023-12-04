Return-Path: <cgroups+bounces-789-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB35D803F12
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 21:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0161F211D9
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 20:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7AD33CE6;
	Mon,  4 Dec 2023 20:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LbmNSRC3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE0CF0
	for <cgroups@vger.kernel.org>; Mon,  4 Dec 2023 12:13:04 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9f559b82cso24023231fa.0
        for <cgroups@vger.kernel.org>; Mon, 04 Dec 2023 12:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701720782; x=1702325582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EG2n1RagWpJyioFCtKEQGNRIi6T2whr4+NS0jQsnqJc=;
        b=LbmNSRC3pKCuJDLGJ1XvjqON7WRsUw/WxQRwsRCTFTX1GU5HHIbhEtKUzW2OkIcdEc
         Vxu/WtcT2oScSIl9cqfTNSh+kZUnp03wTRnt4SgViF+Brzt9B4BNnOjGiG4kEdq+BOuy
         NyXq93+m7svRiRSsKoxHPSDSMk4cixiZ2woezxPVJ1MJUpOjk2JibFK8m3my77OKqMHx
         WlG0DgNhKabuhcANCuQPY0EM3gFotMWyGXVwUIntsGYLsMVdbMw2zy9e/cFQVVtPoQTt
         PRbq0GyX8YQMEHoX5YQ6mzdWBcGFere4JC2/j3saUGZUUbeb4jfJ9THN+PKR46lcfFF5
         QB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720782; x=1702325582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EG2n1RagWpJyioFCtKEQGNRIi6T2whr4+NS0jQsnqJc=;
        b=wd7wxe8unHcrveRK/WuiIHacQLzE6aqaPD9a/C0nacEvI0i+CVtQRh3AL9j+DwZXpN
         VQUckZHy2URxacO9trVa55zWZduU9RcNP3qePShEGFitiUhe5HfxknNu7JaP9r2PeUST
         bIPxb4n/3NSl3cXiXdsFNBpmTno0Z4L1Adp0rsEUF+N+nZ3frxIVYkJv+Ryml/T8A3b9
         N4fdF3SDZYVy1mHOXghYOtCgDIId3i98oMWuTogAbXFvMnHOdCZqCK4Ad+1qNd9QzuFx
         xq2UU9pHg7hrYqAl39bl1Njb3jpGSU5xlWnIe6yMeFltRM4Z9iK8N9PeIpBICyoh8l2R
         plPg==
X-Gm-Message-State: AOJu0YzeDskw1Q8Q1GeRTVnypSZJYDVlKuRwNVWf0G/RUQ+6rRAJGf6Z
	Gz2+aTNNJCq9tSqeKDwZGmSwzuSmOQ/u/ZsiTfT71A==
X-Google-Smtp-Source: AGHT+IEAqW8tj2cjKzLL1LEqxk6D1GCavzEx5M1oQoWziuX/KyNNqhq2NyR/1wV/bzk3AHA7UVHZ98keWs1mbybvl0w=
X-Received: by 2002:a2e:9a87:0:b0:2c9:efa3:e1e8 with SMTP id
 p7-20020a2e9a87000000b002c9efa3e1e8mr1610758lji.33.1701720782130; Mon, 04 Dec
 2023 12:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
In-Reply-To: <20231202083129.3pmds2cddy765szr@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 4 Dec 2023 12:12:25 -0800
Message-ID: <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To: Shakeel Butt <shakeelb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 2, 2023 at 12:31=E2=80=AFAM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
> [...]
> > +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> >  {
> > -     if (memcg_should_flush_stats(root_mem_cgroup))
> > -             do_flush_stats();
> > +     static DEFINE_MUTEX(memcg_stats_flush_mutex);
> > +
> > +     if (mem_cgroup_disabled())
> > +             return;
> > +
> > +     if (!memcg)
> > +             memcg =3D root_mem_cgroup;
> > +
> > +     if (memcg_should_flush_stats(memcg)) {
> > +             mutex_lock(&memcg_stats_flush_mutex);
>
> What's the point of this mutex now? What is it providing? I understand
> we can not try_lock here due to targeted flushing. Why not just let the
> global rstat serialize the flushes? Actually this mutex can cause
> latency hiccups as the mutex owner can get resched during flush and then
> no one can flush for a potentially long time.

I was hoping this was clear from the commit message and code comments,
but apparently I was wrong, sorry. Let me give more context.

In previous versions and/or series, the mutex was only used with
flushes from userspace to guard in-kernel flushers against high
contention from userspace. Later on, I kept the mutex for all memcg
flushers for the following reasons:

(a) Allow waiters to sleep:
Unlike other flushers, the memcg flushing path can see a lot of
concurrency. The mutex avoids having a lot of CPUs spinning (e.g.
concurrent reclaimers) by allowing waiters to sleep.

(b) Check the threshold under lock but before calling cgroup_rstat_flush():
The calls to cgroup_rstat_flush() are not very cheap even if there's
nothing to flush, as we still need to iterate all CPUs. If flushers
contend directly on the rstat lock, overlapping flushes will
unnecessarily do the percpu iteration once they hold the lock. With
the mutex, they will check the threshold again once they hold the
mutex.

(c) Protect non-memcg flushers from contention from memcg flushers.
This is not as strong of an argument as protecting in-kernel flushers
from userspace flushers.

There has been discussions before about changing the rstat lock itself
to be a mutex, which would resolve (a), but there are concerns about
priority inversions if a low priority task holds the mutex and gets
preempted, as well as the amount of time the rstat lock holder keeps
the lock for:
https://lore.kernel.org/lkml/ZO48h7c9qwQxEPPA@slm.duckdns.org/

I agree about possible hiccups due to the inner lock being dropped
while the mutex is held. Running a synthetic test with high
concurrency between reclaimers (in-kernel flushers) and stats readers
show no material performance difference with or without the mutex.
Maybe things cancel out, or don't really matter in practice.

I would prefer to keep the current code as I think (a) and (b) could
cause problems in the future, and the current form of the code (with
the mutex) has already seen mileage with production workloads.

