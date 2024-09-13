Return-Path: <cgroups+bounces-4871-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26A3977A9E
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 10:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120EB1C206A9
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2024 08:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF31E1BD4E7;
	Fri, 13 Sep 2024 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4mSvIrk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C81BC088;
	Fri, 13 Sep 2024 08:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214765; cv=none; b=F9V0fcC7Cp8T4/ehbPv2ssFL1D1lEapDpfocN2qjJ3ZZmenvxFq2hpPDNuvlUhvGDJp8tgyOo+pWUOYJo3fO/1J/Q+yYHjsXbqgvaonmliOa4UQNXsyWhayVGBQCWI2clPLKG5ZqKO4RWNXg9VYU3ZCQVs04iutThBvi9RIjhJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214765; c=relaxed/simple;
	bh=/OHZfeDKU0Zmhsk43vg+X1uyuNrME+HedLybJIinnkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u16RBLerhYHEgw33GUMPV0QN21qQjlBHlYJ74/kNZPcfZzLLwUGxc8rXWHIQCnA82I2hs5CXqnZZtuY2yQzgnnlqa8fsGbQUp2ccJoeQLFA+w3o1p0s6Dh0sFxlYiNMCgsfDGVYfE6Wf953KR+EH5/i3qPc99yqc7XPczHLfKWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4mSvIrk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso1528177a12.2;
        Fri, 13 Sep 2024 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726214763; x=1726819563; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zblplU9yow7GMYopy1E/IBLw2FDfeEv6pZ/jZLC49h0=;
        b=W4mSvIrk+K6G640Vr0Dt9NrBVqqGEynP/ssSX4kktmjZmVApRwSktgmw1lbPAt4Oc3
         ydnO29OrPhtV8YQG79UNkGZPMkIDGyFAhNk7atpYKexyo+F69Q69Q0w/Qa1hLXHb1PUf
         y6PwXoFVL2ZgCvFql5PneEVmr14uVwFs4Go6sjPHN6ECjVwf69MvhKgsQXUB+0E7C7Ih
         k2u16iNaKNUaMvUTni7B1Sd/BMC6jvoj5pjYdeOSATfpzhF30G4TH44mRHgrgWuzNutC
         H/gvy9kftoWcQsXwp11PtkaAfP0G4n8MOVtWSWl4kX0K/gerMtLbBfhUC7v9nylwwOSo
         wEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726214763; x=1726819563;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zblplU9yow7GMYopy1E/IBLw2FDfeEv6pZ/jZLC49h0=;
        b=A4yeRApT+qxY/1WkifGevt6KttU775hsCohhZdvMCejXYyBBCO8DyAYoDETgZLLjXe
         lSI/YdSAnqMaORTyMy45v/A/lnLvbPsE49H/q2ANXfJVGlfkFdV3jM8Mhe+hbxkPtAYo
         xZ18JkPTHZZjFb9eKnyr9dRA37eyIfFO/XPEO3vVT7DhwnWrJcWkbjz0owm+x487fXLv
         ecpiPHeHuB+vnPrE9Fxz26F3YzqU+Y8pPXOXY+fbDHFh1pMR8Jx0n/DsX8dXBKMeaZz6
         KtZxWRuOexJlqiyvsBDolFkUJXH+u7NkDX/SUpWfZ7kZg/ZTDzc9WFHyy+5QcHblR1FV
         Vjaw==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7AXAlmMRM4iXeJ4LpOZwZZpNL5LBnKzkGWy0mEk/QFEw8Z4IO+SeVcRa5WpStYwYWf7mA31G1f/yLlzj@vger.kernel.org, AJvYcCUnm4mRk1x/fI1qTIQrJ6PYDY+ly2PRWa0WE49h1HhMptn3ZAT/2GtCPb8T+mZgWQ7xTVNu0kSl@vger.kernel.org
X-Gm-Message-State: AOJu0YxCuLSjyiabhsbmaOxswg4y4mZFIyRQ65zMIrOjq8JDsBK4ALJs
	DV48mq2Z82WR1vDkNO/nzo2cWj2LknbVTHO3acmtJv2Sv3hXfpy6n8fCUqp+BDFmVu9VzPVEfVx
	iLJA/f35b+ApthRNAfAUGTSQ8zPU=
X-Google-Smtp-Source: AGHT+IHYLysGhGvGSCWMgEKAQslDaU+U3KUnr4CmtkyWsPOGe1CgIgN36TZphXJZQCjB2EDJUI11vidz1KiElaAKFpU=
X-Received: by 2002:a17:90a:4b09:b0:2bd:7e38:798e with SMTP id
 98e67ed59e1d1-2dba0064f3dmr6016181a91.28.1726214763248; Fri, 13 Sep 2024
 01:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com> <e5k22kuavnli72v3lmeezrewut6hvhfdpteouj3ii6dmcdiiin@2e3dlbs4ahe2>
In-Reply-To: <e5k22kuavnli72v3lmeezrewut6hvhfdpteouj3ii6dmcdiiin@2e3dlbs4ahe2>
From: jingxiang zeng <jingxiangzeng.cas@gmail.com>
Date: Fri, 13 Sep 2024 16:05:51 +0800
Message-ID: <CAJqJ8ig2=UqSTemAEU_5Shtc_S=deEuHyq1fJ1QUi1PU=_8pCQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jingxiang Zeng <linuszeng@tencent.com>, linux-mm@kvack.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 15:10, Shakeel Butt <shakeel.butt@linux.dev> wrote:
>
> On Fri, Aug 30, 2024 at 04:22:44PM GMT, Jingxiang Zeng wrote:
> > From: Jingxiang Zeng <linuszeng@tencent.com>
> >
> > In proactive memory reclamation scenarios, it is necessary to
> > estimate the pswpin and pswpout metrics of the cgroup to
> > determine whether to continue reclaiming anonymous pages in
> > the current batch. This patch will collect these metrics and
> > expose them.
>
> Please explain a bit more on how these metrics will be used to make
> a decision to continue to do proactive reclaim or not.

Currently there is simply no way to know exactly how many anon page
was faulted in through SWAP for each cgroup. One may use
workingset refault as an indicator but it is inaccurate due to shadow reclaim.

We have a proactive reclaim agent that sets a forced swappiness
dynamically for each reclaim, so we can reclaim file or anon pages striclty.
Knowing the anon page swapin status is a huge win for estimating the
workload status.

And the swapout info is also important for getting an idea of how much
swapout is effective for a cgroup.

>
> >
> > Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
> > ---
> >  mm/memcontrol-v1.c | 2 ++
> >  mm/memcontrol.c    | 2 ++
> >  mm/page_io.c       | 4 ++++
> >  3 files changed, 8 insertions(+)
> >
> > diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> > index b37c0d870816..44803cbea38a 100644
> > --- a/mm/memcontrol-v1.c
> > +++ b/mm/memcontrol-v1.c
> > @@ -2729,6 +2729,8 @@ static const char *const memcg1_stat_names[] = {
> >  static const unsigned int memcg1_events[] = {
> >       PGPGIN,
> >       PGPGOUT,
> > +     PSWPIN,
> > +     PSWPOUT,
> >       PGFAULT,
> >       PGMAJFAULT,
> >  };
>
> As Yosry said, no need to add these in v1.
>
> thanks,
> Shakeel
>

