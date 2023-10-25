Return-Path: <cgroups+bounces-81-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 307F27D720A
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 19:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC67EB210DB
	for <lists+cgroups@lfdr.de>; Wed, 25 Oct 2023 17:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C8E2AB48;
	Wed, 25 Oct 2023 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EmbYoF2c"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3E2AB32
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 17:06:51 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF513A
	for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 10:06:50 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9d4f08d7cso7605ad.0
        for <cgroups@vger.kernel.org>; Wed, 25 Oct 2023 10:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698253610; x=1698858410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BLyhOS6DaA3Azb/y3i+aSNsSqvELymfgVFVzC4E2iU=;
        b=EmbYoF2cRtIaD4jboEb/NkjayqFcqtPyG7xJcY7OVPXgN48UyOyykCrIFvXIlaQJID
         KDzMW16DS8YHJ3BDA8DCn1rOJXue5JAAW8WkmzYWf2+1zzScR6E+C0CJDHp9w+if9B5U
         WEL8e7hn4PCGimiw7nEQHfvWnRReFatmNtkh/IPPEZI6pHolocrZ4bOU7xxLrFg5olkE
         ak/O77dadKD715EtH33j8/ZcPPXf1WZgk1sl2uc9nWkFObWlMDzGCzUmIG10tvgZE9dh
         aUzMxaOjtbdXN+KAFMZkptanURDD3V2Os135o2Q2B1fLqoakyBZymiO4Me03r+3Cmwt3
         kLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698253610; x=1698858410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BLyhOS6DaA3Azb/y3i+aSNsSqvELymfgVFVzC4E2iU=;
        b=ccaQoDaV8ZQxJAlqOQysy7lQApxFqP7Pvqdevp3t/kNvnOynnyZRtK3gzgnhOxEX8W
         SH6oquf5uUKw6SqUZCniCIV7M2KzhifSo+fuZGvwlIcpCZfyfcrb+YCeQZ6+Ey+yZzpw
         /tnmAZYslSWbcc0siWRAtbGkVSmMm1nUIe4++lQ7RjKHmVKdZ5Kq8RHNT3acND86+4oO
         8dkyJCld9uGW4XXi4TSK+TGhhw7vpjd65pRjnjv0kXbmz2xpOGGzd7jZTIjJGunmu4Sw
         b7J5WjbbospXIlbUVHE+Gw536+k5XcqN9drKY2NLPZf2AMYyXnIbEYOh0ce/hqBMwaFv
         UsQg==
X-Gm-Message-State: AOJu0YzR91C4THtMjR7ik4nVoSIw11bOO7OKW4+D2kOamFhdUgwlRAd2
	NIVeXuu3gyOZzbsLrEd7TFqvq1CDPE+7HIuOIURGnw==
X-Google-Smtp-Source: AGHT+IHTm3Fl1nDGBKuyZQng/G9O2lKwSEtDCNTvLWku+yOpMLnEMFF3diKUa2ikj5TXXEN2m6Iuk1tLQYL8Awlf64s=
X-Received: by 2002:a17:903:144b:b0:1ca:42a:1773 with SMTP id
 lq11-20020a170903144b00b001ca042a1773mr241841plb.12.1698253609714; Wed, 25
 Oct 2023 10:06:49 -0700 (PDT)
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
In-Reply-To: <CAJD7tkaBnSwarz8yHu9RL_3DtaLRfjrcZ7m0YZZgHJsJdtHaZw@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Wed, 25 Oct 2023 10:06:37 -0700
Message-ID: <CALvZod5V-Ag5avAewE2nFp8__J6b_WqHuQw5=F70OPQrGNjfVw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To: Yosry Ahmed <yosryahmed@google.com>
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

On Tue, Oct 24, 2023 at 11:23=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
[...]
>
> Thanks Oliver for running the numbers. If I understand correctly the
> will-it-scale.fallocate1 microbenchmark is the only one showing
> significant regression here, is this correct?
>
> In my runs, other more representative microbenchmarks benchmarks like
> netperf and will-it-scale.page_fault* show minimal regression. I would
> expect practical workloads to have high concurrency of page faults or
> networking, but maybe not fallocate/ftruncate.
>
> Oliver, in your experience, how often does such a regression in such a
> microbenchmark translate to a real regression that people care about?
> (or how often do people dismiss it?)
>
> I tried optimizing this further for the fallocate/ftruncate case but
> without luck. I even tried moving stats_updates into cgroup core
> (struct cgroup_rstat_cpu) to reuse the existing loop in
> cgroup_rstat_updated() -- but it somehow made it worse.
>
> On the other hand, we do have some machines in production running this
> series together with a previous optimization for non-hierarchical
> stats [1] on an older kernel, and we do see significant reduction in
> cpu time spent on reading the stats. Domenico did a similar experiment
> with only this series and reported similar results [2].
>
> Shakeel, Johannes, (and other memcg folks), I personally think the
> benefits here outweigh a regression in this particular benchmark, but
> I am obviously biased. What do you think?
>
> [1]https://lore.kernel.org/lkml/20230726153223.821757-2-yosryahmed@google=
.com/
> [2]https://lore.kernel.org/lkml/CAFYChMv_kv_KXOMRkrmTN-7MrfgBHMcK3YXv0dPY=
EL7nK77e2A@mail.gmail.com/

I still am not convinced of the benefits outweighing the regression
but I would not block this. So, let's do this, skip this open window,
get the patch series reviewed and hopefully we can work together on
fixing that regression and we can make an informed decision of
accepting the regression for this series for the next cycle.

