Return-Path: <cgroups+bounces-597-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E57FAFD7
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 02:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6EA1C20B76
	for <lists+cgroups@lfdr.de>; Tue, 28 Nov 2023 01:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2384681;
	Tue, 28 Nov 2023 01:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tIUWpXay"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC261AE
	for <cgroups@vger.kernel.org>; Mon, 27 Nov 2023 17:59:02 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so672856566b.1
        for <cgroups@vger.kernel.org>; Mon, 27 Nov 2023 17:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701136740; x=1701741540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PphOIqSqCVmNNOsOe5Hpj1iumuWnMQ+UeGD+TeZjx4U=;
        b=tIUWpXayImjFTCSBwCvC9k/n34K4SzVufu+DlrAXNVgLLhzvIhOwrkHntuzx4IP/xC
         rnYM1wcdm/0Q2i3LZK702k2LwSXQSYybW39h+BVdeIJkzZELV0NwKJUAlLpNTW8lP9P8
         Fyf2DosQAp8Si+hQ4R4+3pyTcuD2uFjcna3241igT0ugWvFDKxKE7F7+ze/VPxCs5Xt1
         p4IejA1H3AikSxJARZWPfYS3/DHEPOXP4hrxLxuZa5APO52LckTO4tT9jV6WubdgqhAX
         nJ+EqFk/3qGqstGZHm/NcZZKkRygbb6xY+I/4zOLn4F9aC7nlcC+P1sFU/DYi/yRcCgP
         3QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701136740; x=1701741540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PphOIqSqCVmNNOsOe5Hpj1iumuWnMQ+UeGD+TeZjx4U=;
        b=HfOzE8WoNXYNRAUcaq46CsJ56xRg9BS0p7sAuo+yqGQrf/7xW+DX4Sc+rfdQ7qMjhI
         /rdjX73fHgB3ITEwRISS4mdTzQOOXd6k2s3+fGuRPe9eSqxoOQj6/IvmmJsum2RjKzNP
         Ui3pLXl1xUNUxpsByCfCQAv1MSmfnnFHQQQHVZO4j6oS9UL6i3sKTywv0eqmQaQZadnJ
         aris/i6owX/aAqHN6H9yhjsXVYKDerzQuK2f9Jl3d81pg11qZUy9Ew5GisnTjGb4kUvW
         5sLlvLshuEnDQIvCO4Xr2bSaxwly4Lbu2HOVDgsxi/0RnpFejeP+iBcUQvz4BqJljoAF
         EASA==
X-Gm-Message-State: AOJu0YyIVYR+j2nGoc0YWMtIyqTPLCDpuFTs7HI6ENVxP8XKExO/leRL
	1RjfuxrtlxTgOVFYm4Wgyv6HQd6cWLMXAaiMINaruw==
X-Google-Smtp-Source: AGHT+IHFydTp2xVa4ET3Zk3VpJsnsjThN5lHXwAhFmVBcv53GS0WQDvOENSxAYKSIGQKCBEJvRE4lARsexdWQUTfp2Y=
X-Received: by 2002:a17:906:c282:b0:9be:68db:b763 with SMTP id
 r2-20020a170906c28200b009be68dbb763mr7753564ejz.71.1701136740404; Mon, 27 Nov
 2023 17:59:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116022411.2250072-4-yosryahmed@google.com>
 <202311221542.973f16ad-oliver.sang@intel.com> <CAJD7tkYnn6CxSJdo0QJ1hc6cFY_qWLuJ0=S6g_Pm=GBV+Ss-jw@mail.gmail.com>
 <ZWVGS2rNgueGH8uU@xsang-OptiPlex-9020>
In-Reply-To: <ZWVGS2rNgueGH8uU@xsang-OptiPlex-9020>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 27 Nov 2023 17:58:24 -0800
Message-ID: <CAJD7tkameJBrJQxRj+ibKL6-yd-i0wyoyv2cgZdh3ZepA1p7wA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] mm: memcg: make stats flushing threshold per-memcg
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Johannes Weiner <hannes@cmpxchg.org>, Domenico Cerasuolo <cerasuolodomenico@gmail.com>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 5:46=E2=80=AFPM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Yosry Ahmed,
>
> On Mon, Nov 27, 2023 at 01:13:44PM -0800, Yosry Ahmed wrote:
> > On Wed, Nov 22, 2023 at 5:54=E2=80=AFAM kernel test robot <oliver.sang@=
intel.com> wrote:
> > >
> > >
> > >
> > > Hello,
> > >
> > > kernel test robot noticed a -30.2% regression of will-it-scale.per_th=
read_ops on:
> > >
> > >
> > > commit: c7fbfc7b4e089c4a9b292b1973a42a5761c1342f ("[PATCH v3 3/5] mm:=
 memcg: make stats flushing threshold per-memcg")
> > > url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-me=
mcg-change-flush_next_time-to-flush_last_time/20231116-103300
> > > base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-eve=
rything
> > > patch link: https://lore.kernel.org/all/20231116022411.2250072-4-yosr=
yahmed@google.com/
> > > patch subject: [PATCH v3 3/5] mm: memcg: make stats flushing threshol=
d per-memcg
> > >
> > > testcase: will-it-scale
> > > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > > parameters:
> > >
> > >         nr_task: 50%
> > >         mode: thread
> > >         test: fallocate2
> > >         cpufreq_governor: performance
> > >
> > >
> >
> > This regression was also reported in v2, and I explicitly mention it
> > in the cover letter here:
> > https://lore.kernel.org/lkml/20231116022411.2250072-1-yosryahmed@google=
.com/
>
> got it. this also reminds us to read cover letter for a patch set in the
> future. Thanks!
>
> >
> > In a nutshell, I think this microbenchmark regression does not
> > represent real workloads. On the other hand, there are demonstrated
> > benefits on real workloads from this series in terms of stats reading
> > time.
> >
>
> ok, if there are future versions of this patch, or when it is merged, we =
will
> ignore similar results.
>
> just a small question, since we focus on microbenchmark, if we found othe=
r
> regression (or improvement) on tests other than will-it-scale::fallocate,
> do you want us to send report or just ignore them, either?

I think it would be useful to know if there are
regressions/improvements in other microbenchmarks, at least to
investigate whether they represent real regressions.

