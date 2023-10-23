Return-Path: <cgroups+bounces-3-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68F27D3F39
	for <lists+cgroups@lfdr.de>; Mon, 23 Oct 2023 20:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605D02815D7
	for <lists+cgroups@lfdr.de>; Mon, 23 Oct 2023 18:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48B3219E4;
	Mon, 23 Oct 2023 18:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c685XqEl"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DB921105
	for <cgroups@vger.kernel.org>; Mon, 23 Oct 2023 18:26:39 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A32C9B
	for <cgroups@vger.kernel.org>; Mon, 23 Oct 2023 11:26:37 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso542206866b.3
        for <cgroups@vger.kernel.org>; Mon, 23 Oct 2023 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698085595; x=1698690395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oE+REpypGDMAev/H3GE245B5o6iKa1zk/siXumc4sBI=;
        b=c685XqElf1b4xplslUsYHl7JeCJibrdFsEGeYXa6IH+068FS7S4RYyet3jwViv6mH9
         RL523QRttm2KM5YppqkviU0DokVh0cgKMpjKnLIK+5ourSbTw7lyKi/a2qocUvxAHA/c
         BTEuZd5ECdcawGk3sTmftB8bb9SrNDzzbX4VbpZUqF0h9PetmTd+nmTkeouUnv8bBdrO
         sr7/9qJhpG5qUz1iq3GK9/isellkzSvR9QRa6P8y1xqfpEJ+DRbBRzCTwazvPFuk2RXu
         v4Nr35vQG9G64Thajw+aMxNB5uHfoWIb21cH6Ja4PqpSYxSAxAxU27H9OGLxzswBeswd
         THWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085595; x=1698690395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oE+REpypGDMAev/H3GE245B5o6iKa1zk/siXumc4sBI=;
        b=jd4vnxf269ArXmmPPyaF5DqEuTdEbmpJhWvrtwlsja5EsmMw1KWvWr8kjM/m0xYZRu
         6QziwCBJn5Iwu3lVlkJf+RZ0RQSesFUpuAmeWlemmpsS5fve5y3fQ/BGhxGODa9nR5v7
         k1AVjlMgvSo2rh1OthKPYKMvzhiHQq6rdIsOQ4b2Mx9/Vu7AI/wbki0hCplFXSIBgn65
         0IQQTbjVevY+OQpv3tzJgSyAey8tzlXDHrMT7T++f6UM4aoguTQq24RjJ1Ab8hRRtBTq
         si0dky+KFchfcOnq0pV6tbhThYeIvR76t/kq9wL26Iec2FpJEe1lIyMAgtsRZ0QYsWy5
         T9OQ==
X-Gm-Message-State: AOJu0YxZbOuhQmLR1RfCZHdLvFMw+C1BxhaNgSP1o9p4zz35AxgYyb7v
	D1HABHWEJqK0hh9nDx9U8A4d2eRCJwZtcuoVMge2mg==
X-Google-Smtp-Source: AGHT+IG9GvP+J6p+a0G+WPAQIu946WVihLIDsq32dpZ9WN0/LYIVUoqcHZK5j4U7bjqT28mUlI/UmNUtjdVKdyLr1mU=
X-Received: by 2002:a17:907:7295:b0:9bf:30e8:5bf9 with SMTP id
 dt21-20020a170907729500b009bf30e85bf9mr8656842ejc.4.1698085595352; Mon, 23
 Oct 2023 11:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010032117.1577496-4-yosryahmed@google.com>
 <202310202303.c68e7639-oliver.sang@intel.com> <CALvZod5hKvjm3WVSOGc5PpR9eNHFkt=BDmcrBe5CeWgFzP7jgQ@mail.gmail.com>
 <CAJD7tkbjZri4ayBOT9rJ0yMAi__c-1SVmRh_5oXezr7U6dvALg@mail.gmail.com> <ZTXLeAAI1chMamkU@feng-clx>
In-Reply-To: <ZTXLeAAI1chMamkU@feng-clx>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 23 Oct 2023 11:25:55 -0700
Message-ID: <CAJD7tka5UnHBz=eX1LtynAjJ+O_oredMKBBL3kFNfG7PHjuMCw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
To: Feng Tang <feng.tang@intel.com>
Cc: Shakeel Butt <shakeelb@google.com>, "Sang, Oliver" <oliver.sang@intel.com>, 
	"oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>, lkp <lkp@intel.com>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"Huang, Ying" <ying.huang@intel.com>, "Yin, Fengwei" <fengwei.yin@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Waiman Long <longman@redhat.com>, 
	"kernel-team@cloudflare.com" <kernel-team@cloudflare.com>, Wei Xu <weixugc@google.com>, 
	Greg Thelen <gthelen@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 22, 2023 at 6:34=E2=80=AFPM Feng Tang <feng.tang@intel.com> wro=
te:
>
> On Sat, Oct 21, 2023 at 01:42:58AM +0800, Yosry Ahmed wrote:
> > On Fri, Oct 20, 2023 at 10:23=E2=80=AFAM Shakeel Butt <shakeelb@google.=
com> wrote:
> > >
> > > On Fri, Oct 20, 2023 at 9:18=E2=80=AFAM kernel test robot <oliver.san=
g@intel.com> wrote:
> > > >
> > > >
> > > >
> > > > Hello,
> > > >
> > > > kernel test robot noticed a -25.8% regression of will-it-scale.per_=
thread_ops on:
> > > >
> > > >
> > > > commit: 51d74c18a9c61e7ee33bc90b522dd7f6e5b80bb5 ("[PATCH v2 3/5] m=
m: memcg: make stats flushing threshold per-memcg")
> > > > url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-=
memcg-change-flush_next_time-to-flush_last_time/20231010-112257
> > > > base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm-e=
verything
> > > > patch link: https://lore.kernel.org/all/20231010032117.1577496-4-yo=
sryahmed@google.com/
> > > > patch subject: [PATCH v2 3/5] mm: memcg: make stats flushing thresh=
old per-memcg
> > > >
> > > > testcase: will-it-scale
> > > > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > > > parameters:
> > > >
> > > >         nr_task: 100%
> > > >         mode: thread
> > > >         test: fallocate1
> > > >         cpufreq_governor: performance
> > > >
> > > >
> > > > In addition to that, the commit also has significant impact on the =
following tests:
> > > >
> > > > +------------------+-----------------------------------------------=
----------------+
> > > > | testcase: change | will-it-scale: will-it-scale.per_thread_ops -3=
0.0% regression |
> > > > | test machine     | 104 threads 2 sockets (Skylake) with 192G memo=
ry              |
> > > > | test parameters  | cpufreq_governor=3Dperformance                =
                  |
> > > > |                  | mode=3Dthread                                 =
                  |
> > > > |                  | nr_task=3D50%                                 =
                  |
> > > > |                  | test=3Dfallocate1                             =
                  |
> > > > +------------------+-----------------------------------------------=
----------------+
> > > >
> > >
> > > Yosry, I don't think 25% to 30% regression can be ignored. Unless
> > > there is a quick fix, IMO this series should be skipped for the
> > > upcoming kernel open window.
> >
> > I am currently looking into it. It's reasonable to skip the next merge
> > window if a quick fix isn't found soon.
> >
> > I am surprised by the size of the regression given the following:
> >       1.12 =C4=85  5%      +1.4        2.50 =C4=85  2%
> > perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
> >
> > IIUC we are only spending 1% more time in __mod_memcg_lruvec_state().
>
> Yes, this is kind of confusing. And we have seen similar cases before,
> espcially for micro benchmark like will-it-scale, stressng, netperf
> etc, the change to those functions in hot path was greatly amplified
> in the final benchmark score.
>
> In a netperf case, https://lore.kernel.org/lkml/20220619150456.GB34471@xs=
ang-OptiPlex-9020/
> the affected functions have around 10% change in perf's cpu-cycles,
> and trigger 69% regression. IIRC, micro benchmarks are very sensitive
> to those statistics update, like memcg's and vmstat.
>

Thanks for clarifying. I am still trying to reproduce locally but I am
running into some quirks with tooling. I may have to run a modified
version of the fallocate test manually. Meanwhile, I noticed that the
patch was tested without the fixlet that I posted [1] for it,
understandably. Would it be possible to get some numbers with that
fixlet? It should reduce the total number of contended atomic
operations, so it may help.

[1]https://lore.kernel.org/lkml/CAJD7tkZDarDn_38ntFg5bK2fAmFdSe+Rt6DKOZA7Sg=
s_kERoVA@mail.gmail.com/

I am also wondering if aligning the stats_updates atomic will help.
Right now it may share a cacheline with some items of the
events_pending array. The latter may be dirtied during a flush and
unnecessarily dirty the former, but the chances are slim to be honest.
If it's easy to test such a diff, that would be nice, but I don't
expect a lot of difference:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7cbc7d94eb65..a35fce653262 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -646,7 +646,7 @@ struct memcg_vmstats {
        unsigned long           events_pending[NR_MEMCG_EVENTS];

        /* Stats updates since the last flush */
-       atomic64_t              stats_updates;
+       atomic64_t              stats_updates ____cacheline_aligned_in_smp;
 };

 /*

