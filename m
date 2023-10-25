Return-Path: <cgroups+bounces-89-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463427D7358
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 20:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED61F281D46
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19821CAB2;
	Wed, 25 Oct 2023 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZUDCNyW"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A290F9DC
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 18:36:56 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB06B116
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 11:36:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so13739366b.1
        for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 11:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698259013; x=1698863813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2e92O8wEWD/53OKXUltaj6IOD/TJFtp9v92hFMtfX+0=;
        b=HZUDCNyWfmVGsQvYptxE2H5bp/TtofRCTOocZ+RBHWLyryaezilnDrb/MzrfogOWdp
         +DgOnlBW/XHxVKrIRjqb9K9+2uOyM8p0iHryEfbWWxKwv643z3Jdl5um+CxPeGQ+5pAG
         I2405qN/sR/CmHZ8RZbvDJSQpPIo+G5uMdQyDHqXlJ8UynGCYES3iL47Rks0xEghww7l
         DlxaAghKgRKsQMzC0+yq9KAzzxcLmuv+I97df0DhiC28+5i4iyKiBjid0wDExEXxf5cL
         2piE8YMRLN7pvWIjoMKXU2c9uZ+dW5In6wdX7LL3GRAqgMvAURLahG1NMFaSfjlpv4wB
         97/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698259013; x=1698863813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2e92O8wEWD/53OKXUltaj6IOD/TJFtp9v92hFMtfX+0=;
        b=rhtMkf8cegsbnTOV+r5o4K460FY9OjmP0Me3BiI6vPPG3glUzj1xau9DIJA791biCo
         GWLVDMMUD74/9cE6dT2+ZPAlS12HYkPsS/0rYEa4VHSnYBJs86fUG+7N1DPi+ybxquJr
         bo1mbx86yy/UFQqm9lBF/UsHO5pMcpkwka8LVOf8GBu38H4GxBrlpfWw06aIZ/uB8vIx
         uaFJ/gSGZ9z94wtMWwEcES6YxCm953ORMDNq+Jw1zeuKqkvIbKTYM5Ak7gBbeGqqIrGW
         uQhQTMX3t7CDd6dCTyBim1P6rUrYjsaZFKn94uJ3I6YAU9F7hftffalpjxDzNHtqBQWR
         FdyQ==
X-Gm-Message-State: AOJu0Yx50b6DB/E7701UauOrbWgccLpdVoF2DANy7q1/z3kUpnqRH8nJ
	T8a9RZ5fTmZAcdOj6mpHQeHUK41ftpT3Gsx0qyLB6A==
X-Google-Smtp-Source: AGHT+IFOrNXjGlGRWcmGJFHDoHQlFO4oVM3n0QNoccBm8uXU8YVkyo7zdGNfYE0da5c1OHviWCGusZmXqEZmjkytLeo=
X-Received: by 2002:a17:907:70b:b0:9c6:724:fa16 with SMTP id
 xb11-20020a170907070b00b009c60724fa16mr12368133ejb.59.1698259012860; Wed, 25
 Oct 2023 11:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com> <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
 <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com>
 <ZTXLeAAI1chMamkU@feng-clx> <CAJD7tka5UnHBz=eX1LtynAjJ+O_oredMKBBL3kFNfG7PHjuMCw@mail.gmail.com>
 <CAJD7tkYXJ3vcGvteNH98tB_C7OTo718XSxL=mFsUa7kO8vzFzA@mail.gmail.com>
 <ZTdqpcDFVHhFwWMc@xsang-OptiPlex-9020> <CAJD7tka7hmOD6KPmJBJa+TscbYEMmTjS+Jh2utPfTbKkfvwD9A@mail.gmail.com>
 <ZTiw/iIb0SbvN7vh@xsang-OptiPlex-9020> <CAJD7tkaBnSwarz8yHu9RL_3DtaLRfjrcZ7m0YZZgHJsJdtHaZw@mail.gmail.com>
 <CALvZod5V-Ag5avAewE2nFp8__J6b_WqHuQw5=F70OPQrGNjfVw@mail.gmail.com>
In-Reply-To: <CALvZod5V-Ag5avAewE2nFp8__J6b_WqHuQw5=F70OPQrGNjfVw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 25 Oct 2023 11:36:13 -0700
Message-ID: <CAJD7tkaw1bFDgC1dfbuuCkyLToXRO2T2T7OuMt2fbfEKisP_4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To: Shakeel Butt <shakeelb@google.com>
Cc: Oliver Sang <oliver.sang@intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Feng Tang <feng.tang@intel.com>, "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"Huang, Ying" <ying.huang@intel.com>, "Yin, Fengwei" <fengwei.yin@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, 
	"kernel-team@cloudflare.com" <kernel-team@cloudflare.com>, Wei Xu <weixugc@google.com>, 
	Greg Thelen <gthelen@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 10:06=E2=80=AFAM Shakeel Butt <shakeelb@google.com>=
 wrote:
>
> On Tue, Oct 24, 2023 at 11:23=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> [...]
> >
> > Thanks Oliver for running the numbers. If I understand correctly the
> > will-it-scale.fallocate1 microbenchmark is the only one showing
> > significant regression here, is this correct?
> >
> > In my runs, other more representative microbenchmarks benchmarks like
> > netperf and will-it-scale.page_fault* show minimal regression. I would
> > expect practical workloads to have high concurrency of page faults or
> > networking, but maybe not fallocate/ftruncate.
> >
> > Oliver, in your experience, how often does such a regression in such a
> > microbenchmark translate to a real regression that people care about?
> > (or how often do people dismiss it?)
> >
> > I tried optimizing this further for the fallocate/ftruncate case but
> > without luck. I even tried moving stats_updates into cgroup core
> > (struct cgroup_rstat_cpu) to reuse the existing loop in
> > cgroup_rstat_updated() -- but it somehow made it worse.
> >
> > On the other hand, we do have some machines in production running this
> > series together with a previous optimization for non-hierarchical
> > stats [1] on an older kernel, and we do see significant reduction in
> > cpu time spent on reading the stats. Domenico did a similar experiment
> > with only this series and reported similar results [2].
> >
> > Shakeel, Johannes, (and other memcg folks), I personally think the
> > benefits here outweigh a regression in this particular benchmark, but
> > I am obviously biased. What do you think?
> >
> > [1]https://lore.kernel.org/lkml/20230726153223.821757-2-yosryahmed@goog=
le.com/
> > [2]https://lore.kernel.org/lkml/CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0d=
PYEL7nK77e2A@mail.gmail.com/
>
> I still am not convinced of the benefits outweighing the regression
> but I would not block this. So, let's do this, skip this open window,
> get the patch series reviewed and hopefully we can work together on
> fixing that regression and we can make an informed decision of
> accepting the regression for this series for the next cycle.

Skipping this open window sounds okay to me.

FWIW, I think with this patch series we can keep the old behavior
(roughly) and hide the changes behind a tunable (config option or
sysfs file). I think the only changes that need to be done to the code
to approximate the previous behavior are:
- Use root when updating the pending stats in memcg_rstat_updated()
instead of the passed memcg.
- Use root in mem_cgroup_flush_stats() instead of the passed memcg.
- Use mutex_trylock() instead of mutex_lock() in mem_cgroup_flush_stats().

So I think it should be doable to hide most changes behind a tunable,
but let's not do this unless necessary.

