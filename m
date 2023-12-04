Return-Path: <cgroups+bounces-791-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 358AF80428D
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 00:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E570B20B03
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 23:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B22F878;
	Mon,  4 Dec 2023 23:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFGkfpiJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F79DF0
	for <cgroups@vger.kernel.org>; Mon,  4 Dec 2023 15:31:30 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1cc79f73e58so27595ad.1
        for <cgroups@vger.kernel.org>; Mon, 04 Dec 2023 15:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701732689; x=1702337489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0XB2Hd768QRSmXeqfgdQPhQTeGNeuuAaGIf9egd5wTU=;
        b=BFGkfpiJ9zJGnHROsRoC74FNdES7hyLgSJvy7KIX8OBPNsAJow9Ugtopo5U8Y5pxep
         +Bf2TzbWbbd86rMWVRfZeYT9iPT8Vv5sAqhCLMP9YgHAjv66zcO8ibjs+Fn6MWb9oM6Y
         uLW19e6b6mBmhN9twGZ2KroFL6qHRMAIk0VMKJBIqqkTzzrZEAbPc+EsuaJABSBH81zV
         Y5yeNSrhDIRaoDiGxpJ5fvxnTpdQKDNQYX6qMzZuBbkFMvkBZaXQN+9OuQkKj7Vzbopr
         2NrZo9iX+MWz3fsQNFDmJIUKpsY/mUjBTQZ6lfoyWIY12YenGBpokjrJ+kegc30BfNce
         ipOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701732689; x=1702337489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XB2Hd768QRSmXeqfgdQPhQTeGNeuuAaGIf9egd5wTU=;
        b=CWp72/gvjnXqSQBxv2GyfpJKvyKz6ba/XpxoBW7TXi5piYNKU8rm1Zt8kFkJeLmOPt
         alsBQyrGLqz3kDK0cUM4icxu5/DcL52Nvo3+DHNV+ohKMvey5wqP9VhQg/im2ACkZJOh
         lhgnWSOk2v60y9K8khWI9ZlGW57kJfEqd+IDwqTekxKtZktWs6+/3R1pVfQ+PRJaFGlf
         Oj2uWAtWf+S2yYU6mmPPCn44XGX18bMHCF3tMdC4cBKcUoKnbmXjJocP+iyuqOg3bFz+
         pQ1HUvvvRBk2Ek2eT5qcEet5IDKEHqZs87prcXwP8XG3co+uYNBIPF02jtMOtVEUvPUx
         p4KQ==
X-Gm-Message-State: AOJu0YxVjzmagJtelDa4huky1xoK3zZ/WJUmA2a/HrVleHbFnVNKTcXb
	7W33v4aivzHdgA6Urrue23UQqC9lMybhLQ9pLo8STw==
X-Google-Smtp-Source: AGHT+IFmdkC9ch/3eLVBOiGZh8DIxkkGecScpXwg2x20sFeSN6PWtiNEFXSwFv8bhB6BZ0tDdbS2HkOyV0dkECqyPJk=
X-Received: by 2002:a17:903:3247:b0:1cf:e100:a99c with SMTP id
 ji7-20020a170903324700b001cfe100a99cmr723356plb.6.1701732689357; Mon, 04 Dec
 2023 15:31:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
 <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com> <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
In-Reply-To: <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 4 Dec 2023 15:31:17 -0800
Message-ID: <CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
To: Yosry Ahmed <yosryahmed@google.com>
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

On Mon, Dec 4, 2023 at 1:38=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> On Mon, Dec 4, 2023 at 12:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Sat, Dec 2, 2023 at 12:31=E2=80=AFAM Shakeel Butt <shakeelb@google.c=
om> wrote:
> > >
> > > On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
> > > [...]
> > > > +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> > > >  {
> > > > -     if (memcg_should_flush_stats(root_mem_cgroup))
> > > > -             do_flush_stats();
> > > > +     static DEFINE_MUTEX(memcg_stats_flush_mutex);
> > > > +
> > > > +     if (mem_cgroup_disabled())
> > > > +             return;
> > > > +
> > > > +     if (!memcg)
> > > > +             memcg =3D root_mem_cgroup;
> > > > +
> > > > +     if (memcg_should_flush_stats(memcg)) {
> > > > +             mutex_lock(&memcg_stats_flush_mutex);
> > >
> > > What's the point of this mutex now? What is it providing? I understan=
d
> > > we can not try_lock here due to targeted flushing. Why not just let t=
he
> > > global rstat serialize the flushes? Actually this mutex can cause
> > > latency hiccups as the mutex owner can get resched during flush and t=
hen
> > > no one can flush for a potentially long time.
> >
> > I was hoping this was clear from the commit message and code comments,
> > but apparently I was wrong, sorry. Let me give more context.
> >
> > In previous versions and/or series, the mutex was only used with
> > flushes from userspace to guard in-kernel flushers against high
> > contention from userspace. Later on, I kept the mutex for all memcg
> > flushers for the following reasons:
> >
> > (a) Allow waiters to sleep:
> > Unlike other flushers, the memcg flushing path can see a lot of
> > concurrency. The mutex avoids having a lot of CPUs spinning (e.g.
> > concurrent reclaimers) by allowing waiters to sleep.
> >
> > (b) Check the threshold under lock but before calling cgroup_rstat_flus=
h():
> > The calls to cgroup_rstat_flush() are not very cheap even if there's
> > nothing to flush, as we still need to iterate all CPUs. If flushers
> > contend directly on the rstat lock, overlapping flushes will
> > unnecessarily do the percpu iteration once they hold the lock. With
> > the mutex, they will check the threshold again once they hold the
> > mutex.
> >
> > (c) Protect non-memcg flushers from contention from memcg flushers.
> > This is not as strong of an argument as protecting in-kernel flushers
> > from userspace flushers.
> >
> > There has been discussions before about changing the rstat lock itself
> > to be a mutex, which would resolve (a), but there are concerns about
> > priority inversions if a low priority task holds the mutex and gets
> > preempted, as well as the amount of time the rstat lock holder keeps
> > the lock for:
> > https://lore.kernel.org/lkml/ZO48h7c9qwQxEPPA@slm.duckdns.org/
> >
> > I agree about possible hiccups due to the inner lock being dropped
> > while the mutex is held. Running a synthetic test with high
> > concurrency between reclaimers (in-kernel flushers) and stats readers
> > show no material performance difference with or without the mutex.
> > Maybe things cancel out, or don't really matter in practice.
> >
> > I would prefer to keep the current code as I think (a) and (b) could
> > cause problems in the future, and the current form of the code (with
> > the mutex) has already seen mileage with production workloads.
>
> Correction: The priority inversion is possible on the memcg side due
> to the mutex in this patch. Also, for point (a), the spinners will
> eventually sleep once they hold the lock and hit the first CPU
> boundary -- because of the lock dropping and cond_resched(). So
> eventually, all spinners should be able to sleep, although it will be
> a while until they do. With the mutex, they all sleep from the
> beginning. Point (b) still holds though.
>
> I am slightly inclined to keep the mutex but I can send a small fixlet
> to remove it if others think otherwise.
>
> Shakeel, Wei, any preferences?

My preference is to avoid the issue we know we see in production alot
i.e. priority inversion.

In future if you see issues with spinning then you can come up with
the lockless flush mechanism at that time.

