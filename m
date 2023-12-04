Return-Path: <cgroups+bounces-790-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B9F804107
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 22:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0B91C20B39
	for <lists+cgroups@lfdr.de>; Mon,  4 Dec 2023 21:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68894381CF;
	Mon,  4 Dec 2023 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nMbPqGrL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239FDB9
	for <cgroups@vger.kernel.org>; Mon,  4 Dec 2023 13:38:20 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a196f84d217so508846066b.3
        for <cgroups@vger.kernel.org>; Mon, 04 Dec 2023 13:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701725898; x=1702330698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hop+jSggmEUlZwuqjvhWA9rrsZ1f5SnaiqYLNC/ALg4=;
        b=nMbPqGrLwann738ZgHbcaUdpHR9fzuxibXjMHMEiQsNoUwTURnHbgUSX0ysvVk5Eqa
         zNAhJiGPIR4pqayfPaHZrFW2cacxOxhIpuiLX8X2c+Wrqk5rWa9P1PVtAkkaQxPtulZm
         GZ1ZvVcqdl4rwex9LlrNm5Kao/uiVOjk2QFkz7k7gtIzfwub/tvj9VGKSBvpdlf5B/O5
         r06Bbr7h8cLbmWEvTY4pJp7qzaCMuEqzdoapQ5PJqkTIcfsY6POx+SUW33pIhxJ6nQtc
         HYdhKQV9BDdFq+iD0co3Zct/59D61K23AYcySB4sPfABDHK7ExzALx+brvnJxrWIFMmr
         suaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701725898; x=1702330698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hop+jSggmEUlZwuqjvhWA9rrsZ1f5SnaiqYLNC/ALg4=;
        b=xTIPS4lalZ/sxS2RRVQTWZTINRa7uj+UEZLOMkZ6NRmqYLwQ1lTBEZbnQsNNQMtlve
         grJS6YXdzRTO5tCs3QiLMSmimPJ/PE3vvI2872PIbCHKEXhpu8srhcOnTXNk5AF3DW+4
         0XhFQP+VeFoHKMTuRHk2R4HVmWBkepeXIcSXQIm0WHaZ0z0iDYMZ8tVAva1OiwjhpWrx
         7hMQfds51WVnL9wzNaAXbPYYZppogvpx/d8I66MEaZd0IQczcken9+fpH9XnVxX8C1Pn
         6yxzY9JWDQ/PEvG30TGD6fqp12/YR7ohNDJNSmsHU4qxZvYeCITxz6U3utiCvKPkFlLx
         GkOQ==
X-Gm-Message-State: AOJu0YxTnUPWeBRON820FYCNkKVgMVg9ruyKP2divE7g7sjhBwBx+oek
	rRNeVkaF6ScOVsc9m2hVSfUqu50TotKtv6vWZl3o+g==
X-Google-Smtp-Source: AGHT+IG/IeYkVvZXRhGOJtuyrrZO5rU7RKwJ59APByW8scWghaWLQjxjSzwxW33hqfosiYZ0F4HPrtlUnPAOPAHtqrw=
X-Received: by 2002:a17:906:1091:b0:a19:a1ba:8cbf with SMTP id
 u17-20020a170906109100b00a19a1ba8cbfmr4359871eju.93.1701725898370; Mon, 04
 Dec 2023 13:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
 <20231129032154.3710765-6-yosryahmed@google.com> <20231202083129.3pmds2cddy765szr@google.com>
 <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
In-Reply-To: <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 4 Dec 2023 13:37:42 -0800
Message-ID: <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
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

On Mon, Dec 4, 2023 at 12:12=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Sat, Dec 2, 2023 at 12:31=E2=80=AFAM Shakeel Butt <shakeelb@google.com=
> wrote:
> >
> > On Wed, Nov 29, 2023 at 03:21:53AM +0000, Yosry Ahmed wrote:
> > [...]
> > > +void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
> > >  {
> > > -     if (memcg_should_flush_stats(root_mem_cgroup))
> > > -             do_flush_stats();
> > > +     static DEFINE_MUTEX(memcg_stats_flush_mutex);
> > > +
> > > +     if (mem_cgroup_disabled())
> > > +             return;
> > > +
> > > +     if (!memcg)
> > > +             memcg =3D root_mem_cgroup;
> > > +
> > > +     if (memcg_should_flush_stats(memcg)) {
> > > +             mutex_lock(&memcg_stats_flush_mutex);
> >
> > What's the point of this mutex now? What is it providing? I understand
> > we can not try_lock here due to targeted flushing. Why not just let the
> > global rstat serialize the flushes? Actually this mutex can cause
> > latency hiccups as the mutex owner can get resched during flush and the=
n
> > no one can flush for a potentially long time.
>
> I was hoping this was clear from the commit message and code comments,
> but apparently I was wrong, sorry. Let me give more context.
>
> In previous versions and/or series, the mutex was only used with
> flushes from userspace to guard in-kernel flushers against high
> contention from userspace. Later on, I kept the mutex for all memcg
> flushers for the following reasons:
>
> (a) Allow waiters to sleep:
> Unlike other flushers, the memcg flushing path can see a lot of
> concurrency. The mutex avoids having a lot of CPUs spinning (e.g.
> concurrent reclaimers) by allowing waiters to sleep.
>
> (b) Check the threshold under lock but before calling cgroup_rstat_flush(=
):
> The calls to cgroup_rstat_flush() are not very cheap even if there's
> nothing to flush, as we still need to iterate all CPUs. If flushers
> contend directly on the rstat lock, overlapping flushes will
> unnecessarily do the percpu iteration once they hold the lock. With
> the mutex, they will check the threshold again once they hold the
> mutex.
>
> (c) Protect non-memcg flushers from contention from memcg flushers.
> This is not as strong of an argument as protecting in-kernel flushers
> from userspace flushers.
>
> There has been discussions before about changing the rstat lock itself
> to be a mutex, which would resolve (a), but there are concerns about
> priority inversions if a low priority task holds the mutex and gets
> preempted, as well as the amount of time the rstat lock holder keeps
> the lock for:
> https://lore.kernel.org/lkml/ZO48h7c9qwQxEPPA@slm.duckdns.org/
>
> I agree about possible hiccups due to the inner lock being dropped
> while the mutex is held. Running a synthetic test with high
> concurrency between reclaimers (in-kernel flushers) and stats readers
> show no material performance difference with or without the mutex.
> Maybe things cancel out, or don't really matter in practice.
>
> I would prefer to keep the current code as I think (a) and (b) could
> cause problems in the future, and the current form of the code (with
> the mutex) has already seen mileage with production workloads.

Correction: The priority inversion is possible on the memcg side due
to the mutex in this patch. Also, for point (a), the spinners will
eventually sleep once they hold the lock and hit the first CPU
boundary -- because of the lock dropping and cond_resched(). So
eventually, all spinners should be able to sleep, although it will be
a while until they do. With the mutex, they all sleep from the
beginning. Point (b) still holds though.

I am slightly inclined to keep the mutex but I can send a small fixlet
to remove it if others think otherwise.

Shakeel, Wei, any preferences?

