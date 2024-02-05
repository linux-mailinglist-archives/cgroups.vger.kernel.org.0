Return-Path: <cgroups+bounces-1350-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F386284A81B
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 22:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 240481C27FEE
	for <lists+cgroups@lfdr.de>; Mon,  5 Feb 2024 21:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03E1369B7;
	Mon,  5 Feb 2024 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UK+Cl8xk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990421369AE
	for <cgroups@vger.kernel.org>; Mon,  5 Feb 2024 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707166083; cv=none; b=hwsZKk02HYBkKpZEj8Xf06HZ0kEsjb9hyphF8QVsLJFp66GnKvPvCyTot04QaNgQOVwTysaezOdBRqvgiqIoqNtXxuiTatHUV5WKqfUVZjrQeNl2hSI6qJU6cxUbheN8sszHswckgRlbGvj2NSdC4I8MEU9Wl20Ecb3VDnYy9CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707166083; c=relaxed/simple;
	bh=w/RPe+1TMeAv2q+Knvi6t8U8IdOR8vPpIb0rxw6QTM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCOwsRwCUKnUR6s8edifIbDnwApXyULgXBhHPgg5lnokAnFP1ztHRvSMWVxvWlZhZCmKiwIXN3rCtcJR6f+M49EbILmcRjnvD4XYdCIwNTopXz0+HXNH/vKtRRKelOB5sMpVvEJ7M85nE4o0WDbXmmuGl5szv0jf4Cn6pqpqiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UK+Cl8xk; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60460399a33so12684877b3.1
        for <cgroups@vger.kernel.org>; Mon, 05 Feb 2024 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707166080; x=1707770880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ev1blGMITnTwTBJjyggVWdClFZ0R3d+SfaHhYV19muU=;
        b=UK+Cl8xkjjzOOroxld5uMxv5vKPPwHKPUJXcywoAsvWMUI9VZYAR/YmB8tndUVId8h
         icAJT4cJCafKjIdFgB2ICoWI7wNXQ2NM0KgI8OIF7501g1ZY6OO/qGTeyxb9xnriAkMa
         T/TdH1+sjYeSjmXNS2+6v2PW/Tal17Xbhz0PlxJvH+g5cK4aIkB45Jwo7OnhW2xZbGUs
         VpIVF/T4QCNvyafwpT+CbxU7N1RQbaNraWScmTjTv6sUKKShw75dY10rgdmnL4/+eJNC
         6Yx6I2gnX8sjejXwkKJdJOSJwsKBfAoyhPhGe+3ccv+MhzRv7PmLjj/NqjBmQdqm2SDU
         Y7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707166080; x=1707770880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ev1blGMITnTwTBJjyggVWdClFZ0R3d+SfaHhYV19muU=;
        b=Sk3qyoHlL6aP5NU+F91PLxXIeTN3YtVEeIsM+0Z6+38GvVDQZxbQ3fSREjypJjfyXW
         wajlKtXnAOPsfU8kfAhyfV0G3maOqpRzV+VFrfOPxEn4NFIbTvzxevyX7X7QdocbWejL
         KldlzBo1OjapV9Qf4YdLELMo7MEk0GsRYt8URUmFp5IlaFRZmzAu+rfm7wXAnLYjiTs9
         oh/CEr3XfRkEetmk2qctBkQ5aHfYPgnHLSaw43Y32FmXg6uHgj60jrwVjM9rMc5E+W/3
         XVWEBhzo4cIVtidnSI0xLkbmmMePBi63PNhdh3A1n/0igg0MCU1Wwxs1hdvhOMeUYp3L
         +ScA==
X-Gm-Message-State: AOJu0YyClPq6S/HosnSsq5w1BK/DpbdVTfXJDFJvTOsQRZNpo4e387OS
	x5xw+Jx2Csbh8tTTCN/lAagFm4X8yx9FN7IyspeYFgtRU8iMadpk+ayH/GtnCCywuMx1w8x0qgo
	3QOgRwqOC7adOu0lV41c26HUriNe4T5y6mRVp
X-Google-Smtp-Source: AGHT+IH6QR8LV9rFRVUdLhRUTE+qgb27qJmjD4J9AAEjrvOxC80Dud1zYKzjjCiCXXn5ykRAFbh3S6rgHlgl7hPp0y4=
X-Received: by 2002:a0d:d5d0:0:b0:5ff:6264:65c4 with SMTP id
 x199-20020a0dd5d0000000b005ff626465c4mr843162ywd.0.1707166080283; Mon, 05 Feb
 2024 12:48:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202233855.1236422-1-tjmercier@google.com>
 <ZcC7Kgew3GDFNIux@tiehlicka> <CABdmKX3HbSxX6zLF4z3f+=Ybiq1bA71jckkeHv5QJxAjSexgaA@mail.gmail.com>
 <ZcE5n9cTdTGJChmq@tiehlicka> <CABdmKX0Du2F+bko=hjLBqdQO-bJSFcG3y1Bbuu2v6J8aVB39sw@mail.gmail.com>
 <ZcFG2JoXI7i8XzQY@tiehlicka>
In-Reply-To: <ZcFG2JoXI7i8XzQY@tiehlicka>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 5 Feb 2024 12:47:47 -0800
Message-ID: <CABdmKX0t1LXj80Awe20TrmY5gQB6v2E4bGfW8WXr2i84o+k6ow@mail.gmail.com>
Subject: Re: [PATCH v3] mm: memcg: Use larger batches for proactive reclaim
To: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeelb@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Efly Young <yangyifei03@kuaishou.com>, 
	android-mm@google.com, yuzhao@google.com, mkoutny@suse.com, 
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 12:36=E2=80=AFPM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 05-02-24 12:26:10, T.J. Mercier wrote:
> > On Mon, Feb 5, 2024 at 11:40=E2=80=AFAM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Mon 05-02-24 11:29:49, T.J. Mercier wrote:
> > > > On Mon, Feb 5, 2024 at 2:40=E2=80=AFAM Michal Hocko <mhocko@suse.co=
m> wrote:
> > > > >
> > > > > On Fri 02-02-24 23:38:54, T.J. Mercier wrote:
> > > > > > Before 388536ac291 ("mm:vmscan: fix inaccurate reclaim during p=
roactive
> > > > > > reclaim") we passed the number of pages for the reclaim request=
 directly
> > > > > > to try_to_free_mem_cgroup_pages, which could lead to significan=
t
> > > > > > overreclaim. After 0388536ac291 the number of pages was limited=
 to a
> > > > > > maximum 32 (SWAP_CLUSTER_MAX) to reduce the amount of overrecla=
im.
> > > > > > However such a small batch size caused a regression in reclaim
> > > > > > performance due to many more reclaim start/stop cycles inside
> > > > > > memory_reclaim.
> > > > >
> > > > > You have mentioned that in one of the previous emails but it is g=
ood to
> > > > > mention what is the source of that overhead for the future refere=
nce.
> > > >
> > > > I can add a sentence about the restart cost being amortized over mo=
re
> > > > pages with a large batch size. It covers things like repeatedly
> > > > flushing stats, walking the tree, evaluating protection limits, etc=
.
> > > >
> > > > > > Reclaim tries to balance nr_to_reclaim fidelity with fairness a=
cross
> > > > > > nodes and cgroups over which the pages are spread. As such, the=
 bigger
> > > > > > the request, the bigger the absolute overreclaim error. Histori=
c
> > > > > > in-kernel users of reclaim have used fixed, small sized request=
s to
> > > > > > approach an appropriate reclaim rate over time. When we reclaim=
 a user
> > > > > > request of arbitrary size, use decaying batch sizes to manage e=
rror while
> > > > > > maintaining reasonable throughput.
> > > > >
> > > > > These numbers are with MGLRU or the default reclaim implementatio=
n?
> > > >
> > > > These numbers are for both. root uses the memcg LRU (MGLRU was
> > > > enabled), and /uid_0 does not.
> > >
> > > Thanks it would be nice to outline that in the changelog.
> >
> > Ok, I'll update the table below for each case.
> >
> > > > > > root - full reclaim       pages/sec   time (sec)
> > > > > > pre-0388536ac291      :    68047        10.46
> > > > > > post-0388536ac291     :    13742        inf
> > > > > > (reclaim-reclaimed)/4 :    67352        10.51
> > > > > >
> > > > > > /uid_0 - 1G reclaim       pages/sec   time (sec)  overreclaim (=
MiB)
> > > > > > pre-0388536ac291      :    258822       1.12            107.8
> > > > > > post-0388536ac291     :    105174       2.49            3.5
> > > > > > (reclaim-reclaimed)/4 :    233396       1.12            -7.4
> > > > > >
> > > > > > /uid_0 - full reclaim     pages/sec   time (sec)
> > > > > > pre-0388536ac291      :    72334        7.09
> > > > > > post-0388536ac291     :    38105        14.45
> > > > > > (reclaim-reclaimed)/4 :    72914        6.96
> > > > > >
> > > > > > Fixes: 0388536ac291 ("mm:vmscan: fix inaccurate reclaim during =
proactive reclaim")
> > > > > > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > > > > > Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > >
> > > > > > ---
> > > > > > v3: Formatting fixes per Yosry Ahmed and Johannes Weiner. No fu=
nctional
> > > > > > changes.
> > > > > > v2: Simplify the request size calculation per Johannes Weiner a=
nd Michal Koutn=C3=BD
> > > > > >
> > > > > >  mm/memcontrol.c | 6 ++++--
> > > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index 46d8d02114cf..f6ab61128869 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -6976,9 +6976,11 @@ static ssize_t memory_reclaim(struct ker=
nfs_open_file *of, char *buf,
> > > > > >               if (!nr_retries)
> > > > > >                       lru_add_drain_all();
> > > > > >
> > > > > > +             /* Will converge on zero, but reclaim enforces a =
minimum */
> > > > > > +             unsigned long batch_size =3D (nr_to_reclaim - nr_=
reclaimed) / 4;
> > > > >
> > > > > This doesn't fit into the existing coding style. I do not think t=
here is
> > > > > a strong reason to go against it here.
> > > >
> > > > There's been some back and forth here. You'd prefer to move this to
> > > > the top of the while loop, under the declaration of reclaimed? It's
> > > > farther from its use there, but it does match the existing style in
> > > > the file better.
> > >
> > > This is not something I deeply care about but generally it is better =
to
> > > not mix styles unless that is a clear win. If you want to save one LO=
C
> > > you can just move it up - just couple of lines up, or you can keep th=
e
> > > definition closer and have a separate declaration.
> >
> > I find it nicer to have to search as little as possible for both the
> > declaration (type) and definition, but I am not attached to it either
> > and it's not worth annoying anyone over here. Let's move it up like
> > Yosry suggested initially.
> >
> > > > > > +
> > > > > >               reclaimed =3D try_to_free_mem_cgroup_pages(memcg,
> > > > > > -                                     min(nr_to_reclaim - nr_re=
claimed, SWAP_CLUSTER_MAX),
> > > > > > -                                     GFP_KERNEL, reclaim_optio=
ns);
> > > > > > +                                     batch_size, GFP_KERNEL, r=
eclaim_options);
> > > > >
> > > > > Also with the increased reclaim target do we need something like =
this?
> > > > >
> > > > > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > > > > index 4f9c854ce6cc..94794cf5ee9f 100644
> > > > > --- a/mm/vmscan.c
> > > > > +++ b/mm/vmscan.c
> > > > > @@ -1889,7 +1889,7 @@ static unsigned long shrink_inactive_list(u=
nsigned long nr_to_scan,
> > > > >
> > > > >                 /* We are about to die and free our memory. Retur=
n now. */
> > > > >                 if (fatal_signal_pending(current))
> > > > > -                       return SWAP_CLUSTER_MAX;
> > > > > +                       return sc->nr_to_reclaim;
> > > > >         }
> > > > >
> > > > >         lru_add_drain();
> > > > > >
> > > > > >               if (!reclaimed && !nr_retries--)
> > > > > >                       return -EAGAIN;
> > > > > > --
> > > >
> > > > This is interesting, but I don't think it's closely related to this
> > > > change. This section looks like it was added to delay OOM kills due=
 to
> > > > apparent lack of reclaim progress when pages are isolated and the
> > > > direct reclaimer is scheduled out. A couple things:
> > > >
> > > > In the context of proactive reclaim, current is not really undergoi=
ng
> > > > reclaim due to memory pressure. It's initiated from userspace. So
> > > > whether it has a fatal signal pending or not doesn't seem like it
> > > > should influence the return value of shrink_inactive_list for some
> > > > probably unrelated process. It seems more straightforward to me to
> > > > return 0, and add another fatal signal pending check to the caller
> > > > (shrink_lruvec) to bail out early (dealing with OOM kill avoidance
> > > > there if necessary) instead of waiting to accumulate fake
> > > > SWAP_CLUSTER_MAX values from shrink_inactive_list.
> > >
> > > The point of this code is to bail out early if the caller has fatal
> > > signals pending. That could be SIGTERM sent to the process performing
> > > the reclaim for whatever reason. The bail out is tuned for
> > > SWAP_CLUSTER_MAX as you can see and your patch is increasing the recl=
aim
> > > target which means that bailout wouldn't work properly and you wouldn=
't
> > > get any useful work done but not really bail out.
> >
> > It's increasing to 1/4 of what it was 6 months ago before 88536ac291
> > ("mm:vmscan: fix inaccurate reclaim during proactive reclaim") and
> > this hasn't changed since then, so if anything the bailout should
> > happen quicker than originally tuned for.
>
> Yes, this wasn't handled properly back then either.
>
> > > > As far as changing the value, SWAP_CLUSTER_MAX puts the final value=
 of
> > > > sc->nr_reclaimed pretty close to sc->nr_to_reclaim. Since there's a
> > > > loop for each evictable lru in shrink_lruvec, we could end up with =
4 *
> > > > sc->nr_to_reclaim in sc->nr_reclaimed if we switched to
> > > > sc->nr_to_reclaim from SWAP_CLUSTER_MAX... an even bigger lie. So I
> > > > don't think we'd want to do that.
> > >
> > > The actual number returned from the reclaim is not really important
> > > because memory_reclaim would break out of the loop and userspace woul=
d
> > > never see the result.
> >
> > This makes sense, but it makes me uneasy. I can't point to anywhere
> > this would cause a problem currently (except maybe super unlikely
> > overflow of nr_reclaimed), but it feels like a setup for future
> > unintended consequences.
>
> This of something like
> timeout $TIMEOUT echo $TARGET > $MEMCG_PATH/memory.reclaim
> where timeout acts as a stop gap if the reclaim cannot finish in
> TIMEOUT.

Yeah I get the desired behavior, but using sc->nr_reclaimed to achieve
it is what's bothering me.

It's already wired up that way though, so if you want to make this
change now then I can try to test for the difference using really
large reclaim targets.

