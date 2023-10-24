Return-Path: <cgroups+bounces-5-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74077D4563
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 04:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069DF2811D2
	for <lists+cgroups@lfdr.de>; Tue, 24 Oct 2023 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDC72114;
	Tue, 24 Oct 2023 02:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FSQR5QOB"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298241C20
	for <cgroups@vger.kernel.org>; Tue, 24 Oct 2023 02:14:34 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040DC4
	for <cgroups@vger.kernel.org>; Mon, 23 Oct 2023 19:14:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9be3b66f254so556835866b.3
        for <cgroups@vger.kernel.org>; Mon, 23 Oct 2023 19:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698113669; x=1698718469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0sOgq9xlJHiJPp92A0KCrtEWTJLcsYxL+ixDw2Vc7k=;
        b=FSQR5QOBhiH8kpauWayc9Cju3OshKKeJvFNDKtjNgXlrpRSXlsjI7B1g2Dm5g3AR/R
         +u6So0mOowzurgsYpb2GO2BYT/ye4s1iVPL4FhHIrzwJWsPY2JRAT1dJPL1oUY9KNAi4
         MBVRibA/KKEfcjltHcxgohVBADc/Tbq/ooYKNzHztCHJWQBIx9PRAKtGUWw49TOU+g1Y
         kUQSkzMNf7vuONKUakHonqjdf0KmoKFADvW5HS1Nzpo8jvkb8941BZoqgwQEYU9r9UzY
         WylCqZgM1AB67ZISpe6dAyKk/zTdk2536PCLM/Bf6bdMz6iPy1eVBlegQMnHgfRD9K7c
         o+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698113669; x=1698718469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0sOgq9xlJHiJPp92A0KCrtEWTJLcsYxL+ixDw2Vc7k=;
        b=SsZpwIY6qxGQSniMGa6+bEXb7Z5o/fTSbT+ny6e/QNqUfRKHhqCsQwBQq3l9lKoK6q
         OoGH2Uo/b1+KXm1x42ImziQfJasvPpfqpXIxzfgI3fDNm2lUkUFuYuX3OhqqCj+XtgUP
         6t/9WvH33G4wudmtwRYjVu49BsbDPetRvcfACcvytPzL4Qnf8YAalmx8m2VZ4SELf+5U
         Au64DMFLJ7k38cFQCw32CNKJBrRetDEJzO3cY5ydpPOKwqq+aBnNUllMNrGnPLfLOd05
         v+SJHo5mZuEVliJow1ckIx1PQT+yfm5wRGy/WU6xqxtfLtRI4YlPqthEvGgUw9suysJe
         RKWw==
X-Gm-Message-State: AOJu0Yz7BcqGQPNqXV+VpT2O01N9p/pQfUDAm+kRmVRUTo+oN+Zd1jBX
	QI9By58PbUPFfYYKwvMdCwHMG3A90hrNZWuh6/TKQA==
X-Google-Smtp-Source: AGHT+IGeRq7C8JWKVf4prx/Nk1sPNumBk/pAdlLdFwV2cA8IUX0KnxZ7o/tDW4NdAfp5mE+6HqdtDeggVKPiuYE+iSc=
X-Received: by 2002:a17:907:7f8b:b0:9bf:2673:7371 with SMTP id
 qk11-20020a1709077f8b00b009bf26737371mr9869290ejc.13.1698113669449; Mon, 23
 Oct 2023 19:14:29 -0700 (PDT)
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
In-Reply-To: <CAJD7tka5UnHBz=eX1LtynAjJ+O_oredMKBBL3kFNfG7PHjuMCw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 23 Oct 2023 19:13:50 -0700
Message-ID: <CAJD7tkYXJ3vcGvteNH98tB_C7OTo718XSxL=mFsUa7kO8vzFzA@mail.gmail.com>
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

On Mon, Oct 23, 2023 at 11:25=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Sun, Oct 22, 2023 at 6:34=E2=80=AFPM Feng Tang <feng.tang@intel.com> w=
rote:
> >
> > On Sat, Oct 21, 2023 at 01:42:58AM +0800, Yosry Ahmed wrote:
> > > On Fri, Oct 20, 2023 at 10:23=E2=80=AFAM Shakeel Butt <shakeelb@googl=
e.com> wrote:
> > > >
> > > > On Fri, Oct 20, 2023 at 9:18=E2=80=AFAM kernel test robot <oliver.s=
ang@intel.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > Hello,
> > > > >
> > > > > kernel test robot noticed a -25.8% regression of will-it-scale.pe=
r_thread_ops on:
> > > > >
> > > > >
> > > > > commit: 51d74c18a9c61e7ee33bc90b522dd7f6e5b80bb5 ("[PATCH v2 3/5]=
 mm: memcg: make stats flushing threshold per-memcg")
> > > > > url: https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/m=
m-memcg-change-flush_next_time-to-flush_last_time/20231010-112257
> > > > > base: https://git.kernel.org/cgit/linux/kernel/git/akpm/mm.git mm=
-everything
> > > > > patch link: https://lore.kernel.org/all/20231010032117.1577496-4-=
yosryahmed@google.com/
> > > > > patch subject: [PATCH v2 3/5] mm: memcg: make stats flushing thre=
shold per-memcg
> > > > >
> > > > > testcase: will-it-scale
> > > > > test machine: 104 threads 2 sockets (Skylake) with 192G memory
> > > > > parameters:
> > > > >
> > > > >         nr_task: 100%
> > > > >         mode: thread
> > > > >         test: fallocate1
> > > > >         cpufreq_governor: performance
> > > > >
> > > > >
> > > > > In addition to that, the commit also has significant impact on th=
e following tests:
> > > > >
> > > > > +------------------+---------------------------------------------=
------------------+
> > > > > | testcase: change | will-it-scale: will-it-scale.per_thread_ops =
-30.0% regression |
> > > > > | test machine     | 104 threads 2 sockets (Skylake) with 192G me=
mory              |
> > > > > | test parameters  | cpufreq_governor=3Dperformance              =
                    |
> > > > > |                  | mode=3Dthread                               =
                    |
> > > > > |                  | nr_task=3D50%                               =
                    |
> > > > > |                  | test=3Dfallocate1                           =
                    |
> > > > > +------------------+---------------------------------------------=
------------------+
> > > > >
> > > >
> > > > Yosry, I don't think 25% to 30% regression can be ignored. Unless
> > > > there is a quick fix, IMO this series should be skipped for the
> > > > upcoming kernel open window.
> > >
> > > I am currently looking into it. It's reasonable to skip the next merg=
e
> > > window if a quick fix isn't found soon.
> > >
> > > I am surprised by the size of the regression given the following:
> > >       1.12 =C4=85  5%      +1.4        2.50 =C4=85  2%
> > > perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
> > >
> > > IIUC we are only spending 1% more time in __mod_memcg_lruvec_state().
> >
> > Yes, this is kind of confusing. And we have seen similar cases before,
> > espcially for micro benchmark like will-it-scale, stressng, netperf
> > etc, the change to those functions in hot path was greatly amplified
> > in the final benchmark score.
> >
> > In a netperf case, https://lore.kernel.org/lkml/20220619150456.GB34471@=
xsang-OptiPlex-9020/
> > the affected functions have around 10% change in perf's cpu-cycles,
> > and trigger 69% regression. IIRC, micro benchmarks are very sensitive
> > to those statistics update, like memcg's and vmstat.
> >
>
> Thanks for clarifying. I am still trying to reproduce locally but I am
> running into some quirks with tooling. I may have to run a modified
> version of the fallocate test manually. Meanwhile, I noticed that the
> patch was tested without the fixlet that I posted [1] for it,
> understandably. Would it be possible to get some numbers with that
> fixlet? It should reduce the total number of contended atomic
> operations, so it may help.
>
> [1]https://lore.kernel.org/lkml/CAJD7tkZDarDn_38ntFg5bK2fAmFdSe+Rt6DKOZA7=
Sgs_kERoVA@mail.gmail.com/
>
> I am also wondering if aligning the stats_updates atomic will help.
> Right now it may share a cacheline with some items of the
> events_pending array. The latter may be dirtied during a flush and
> unnecessarily dirty the former, but the chances are slim to be honest.
> If it's easy to test such a diff, that would be nice, but I don't
> expect a lot of difference:
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7cbc7d94eb65..a35fce653262 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -646,7 +646,7 @@ struct memcg_vmstats {
>         unsigned long           events_pending[NR_MEMCG_EVENTS];
>
>         /* Stats updates since the last flush */
> -       atomic64_t              stats_updates;
> +       atomic64_t              stats_updates ____cacheline_aligned_in_sm=
p;
>  };
>
>  /*

I still could not run the benchmark, but I used a version of
fallocate1.c that does 1 million iterations. I ran 100 in parallel.
This showed ~13% regression with the patch, so not the same as the
will-it-scale version, but it could be an indicator.

With that, I did not see any improvement with the fixlet above or
___cacheline_aligned_in_smp. So you can scratch that.

I did, however, see some improvement with reducing the indirection
layers by moving stats_updates directly into struct mem_cgroup. The
regression in my manual testing went down to 9%. Still not great, but
I am wondering how this reflects on the benchmark. If you're able to
test it that would be great, the diff is below. Meanwhile I am still
looking for other improvements that can be made.

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f64ac140083e..b4dfcd8b9cc1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -270,6 +270,9 @@ struct mem_cgroup {

        CACHELINE_PADDING(_pad1_);

+       /* Stats updates since the last flush */
+       atomic64_t              stats_updates;
+
        /* memory.stat */
        struct memcg_vmstats    *vmstats;

@@ -309,6 +312,7 @@ struct mem_cgroup {
        atomic_t                moving_account;
        struct task_struct      *move_lock_task;

+       unsigned int __percpu *stats_updates_percpu;
        struct memcg_vmstats_percpu __percpu *vmstats_percpu;

 #ifdef CONFIG_CGROUP_WRITEBACK
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7cbc7d94eb65..e5d2f3d4d874 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -627,9 +627,6 @@ struct memcg_vmstats_percpu {
        /* Cgroup1: threshold notifications & softlimit tree updates */
        unsigned long           nr_page_events;
        unsigned long           targets[MEM_CGROUP_NTARGETS];
-
-       /* Stats updates since the last flush */
-       unsigned int            stats_updates;
 };

 struct memcg_vmstats {
@@ -644,9 +641,6 @@ struct memcg_vmstats {
        /* Pending child counts during tree propagation */
        long                    state_pending[MEMCG_NR_STAT];
        unsigned long           events_pending[NR_MEMCG_EVENTS];
-
-       /* Stats updates since the last flush */
-       atomic64_t              stats_updates;
 };

 /*
@@ -695,14 +689,14 @@ static void memcg_stats_unlock(void)

 static bool memcg_should_flush_stats(struct mem_cgroup *memcg)
 {
-       return atomic64_read(&memcg->vmstats->stats_updates) >
+       return atomic64_read(&memcg->stats_updates) >
                MEMCG_CHARGE_BATCH * num_online_cpus();
 }

 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
        int cpu =3D smp_processor_id();
-       unsigned int x;
+       unsigned int *stats_updates_percpu;

        if (!val)
                return;
@@ -710,10 +704,10 @@ static inline void memcg_rstat_updated(struct
mem_cgroup *memcg, int val)
        cgroup_rstat_updated(memcg->css.cgroup, cpu);

        for (; memcg; memcg =3D parent_mem_cgroup(memcg)) {
-               x =3D __this_cpu_add_return(memcg->vmstats_percpu->stats_up=
dates,
-                                         abs(val));
+               stats_updates_percpu =3D
this_cpu_ptr(memcg->stats_updates_percpu);

-               if (x < MEMCG_CHARGE_BATCH)
+               *stats_updates_percpu +=3D abs(val);
+               if (*stats_updates_percpu < MEMCG_CHARGE_BATCH)
                        continue;

                /*
@@ -721,8 +715,8 @@ static inline void memcg_rstat_updated(struct
mem_cgroup *memcg, int val)
                 * redundant. Avoid the overhead of the atomic update.
                 */
                if (!memcg_should_flush_stats(memcg))
-                       atomic64_add(x, &memcg->vmstats->stats_updates);
-               __this_cpu_write(memcg->vmstats_percpu->stats_updates, 0);
+                       atomic64_add(*stats_updates_percpu,
&memcg->stats_updates);
+               *stats_updates_percpu =3D 0;
        }
 }

@@ -5467,6 +5461,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memc=
g)
                free_mem_cgroup_per_node_info(memcg, node);
        kfree(memcg->vmstats);
        free_percpu(memcg->vmstats_percpu);
+       free_percpu(memcg->stats_updates_percpu);
        kfree(memcg);
 }

@@ -5504,6 +5499,11 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
        if (!memcg->vmstats_percpu)
                goto fail;

+       memcg->stats_updates_percpu =3D alloc_percpu_gfp(unsigned int,
+                                                      GFP_KERNEL_ACCOUNT);
+       if (!memcg->stats_updates_percpu)
+               goto fail;
+
        for_each_node(node)
                if (alloc_mem_cgroup_per_node_info(memcg, node))
                        goto fail;
@@ -5735,10 +5735,12 @@ static void mem_cgroup_css_rstat_flush(struct
cgroup_subsys_state *css, int cpu)
        struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
        struct mem_cgroup *parent =3D parent_mem_cgroup(memcg);
        struct memcg_vmstats_percpu *statc;
+       int *stats_updates_percpu;
        long delta, delta_cpu, v;
        int i, nid;

        statc =3D per_cpu_ptr(memcg->vmstats_percpu, cpu);
+       stats_updates_percpu =3D per_cpu_ptr(memcg->stats_updates_percpu, c=
pu);

        for (i =3D 0; i < MEMCG_NR_STAT; i++) {
                /*
@@ -5826,10 +5828,10 @@ static void mem_cgroup_css_rstat_flush(struct
cgroup_subsys_state *css, int cpu)
                        }
                }
        }
-       statc->stats_updates =3D 0;
+       *stats_updates_percpu =3D 0;
        /* We are in a per-cpu loop here, only do the atomic write once */
-       if (atomic64_read(&memcg->vmstats->stats_updates))
-               atomic64_set(&memcg->vmstats->stats_updates, 0);
+       if (atomic64_read(&memcg->stats_updates))
+               atomic64_set(&memcg->stats_updates, 0);
 }

 #ifdef CONFIG_MMU

