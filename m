Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17180788C45
	for <lists+cgroups@lfdr.de>; Fri, 25 Aug 2023 17:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjHYPPo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Aug 2023 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbjHYPPg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Aug 2023 11:15:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF6A2135
        for <cgroups@vger.kernel.org>; Fri, 25 Aug 2023 08:15:33 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so135178966b.0
        for <cgroups@vger.kernel.org>; Fri, 25 Aug 2023 08:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692976532; x=1693581332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gxXEdOB/IMxquDgU+zJqv+Cmd6hlTz7uMEp9VHRpC8=;
        b=6aIYmWlKv5lPGOvAuBXSFGGUGFZ1y8MMPu07HvyfBJIgCl2EPLP1D4OXUhuZ9dY+Js
         zDObdp3uyvm6noM5iZ7VGYK6MRF1SfdF5sEczoB3xr5KaZKcG0e6M5T/BVnmu8MaOktJ
         WzgSz+pbCdhDjyhqn8ZaPvt8BEAo/SWM1rl38fwbIQCAvLDNyEO3Ff8YhLMJln12GTud
         pKg0KoCuDXPKDcVWW0xMIgi+NUyWoaMIaiU9pjWCtVMbuTN52V5zUtElhoqC9/Nri7JY
         h5+L/1DzBsr3YWXc+w9kWzTKtHuy4QupNL5AwZw6DExJyNGLVZ9H5xqGPeMgAfeF3DWh
         FDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692976532; x=1693581332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gxXEdOB/IMxquDgU+zJqv+Cmd6hlTz7uMEp9VHRpC8=;
        b=LfHw9M6PtSr6G/zCZWRYKEfpM5A+lJMUyaDrEgj/iDPFoZ+0Ff1qodzkX38S8vw0ss
         lm5MNaDFUTKxP+qQR7EEYXl/es9kRa8ox7C2sb2YjRYOX12v7lOiuWbR+4E/VHGPAXmT
         SmosTeUwm2IlqdHgU3i+huEok0C3irvXDPdtoxgU4eqQGclnfteLYlJuEcwExordj9wB
         1NtR/dWsTM1TXKWOUpXfrNcUDCY5fsyc3hd+/VGwK+zS1XV16NDBiI5LYfk1wqVaBMGo
         I9weP5+l755Az253dCJtypoEOr6EKdGYkJTc5D1A52lsKEPtNBKl//XVFEUOiMDFDkZv
         f+1A==
X-Gm-Message-State: AOJu0YxnKVCJ+2SJ9GWs3i49W/JoxoVge3Gugl5AW2KL/u7zB2KiNmVh
        4lV4I7RNm9CGmS9dEgtsbn3NoIBCd3YSGDikUGT3gA==
X-Google-Smtp-Source: AGHT+IGJg7QkdQsClygNT9r5bEfow7rITYDHt5mrg27t0ux9YcRLbh1cZlAUmEqzdcKgGK7nq2+OP++BamPJYW0zqKQ=
X-Received: by 2002:a17:907:75c5:b0:9a2:1e14:86bd with SMTP id
 jl5-20020a17090775c500b009a21e1486bdmr3622301ejc.65.1692976531308; Fri, 25
 Aug 2023 08:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com> <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com> <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
In-Reply-To: <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 25 Aug 2023 08:14:54 -0700
Message-ID: <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 25, 2023 at 12:05=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 24-08-23 11:50:51, Yosry Ahmed wrote:
> > On Thu, Aug 24, 2023 at 11:15=E2=80=AFAM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > >
> > > On Thu, Aug 24, 2023 at 12:13=E2=80=AFAM Michal Hocko <mhocko@suse.co=
m> wrote:
> > > >
> > > > On Wed 23-08-23 07:55:40, Yosry Ahmed wrote:
> > > > > On Wed, Aug 23, 2023 at 12:33=E2=80=AFAM Michal Hocko <mhocko@sus=
e.com> wrote:
> > > > > >
> > > > > > On Tue 22-08-23 08:30:05, Yosry Ahmed wrote:
> > > > > > > On Tue, Aug 22, 2023 at 2:06=E2=80=AFAM Michal Hocko <mhocko@=
suse.com> wrote:
> > > > > > > >
> > > > > > > > On Mon 21-08-23 20:54:58, Yosry Ahmed wrote:
> > > > > > [...]
> > > > > > > So to answer your question, I don't think a random user can r=
eally
> > > > > > > affect the system in a significant way by constantly flushing=
. In
> > > > > > > fact, in the test script (which I am now attaching, in case y=
ou're
> > > > > > > interested), there are hundreds of threads that are reading s=
tats of
> > > > > > > different cgroups every 1s, and I don't see any negative effe=
cts on
> > > > > > > in-kernel flushers in this case (reclaimers).
> > > > > >
> > > > > > I suspect you have missed my point.
> > > > >
> > > > > I suspect you are right :)
> > > > >
> > > > >
> > > > > > Maybe I am just misunderstanding
> > > > > > the code but it seems to me that the lock dropping inside
> > > > > > cgroup_rstat_flush_locked effectivelly allows unbounded number =
of
> > > > > > contenders which is really dangerous when it is triggerable fro=
m the
> > > > > > userspace. The number of spinners at a moment is always bound b=
y the
> > > > > > number CPUs but depending on timing many potential spinners mig=
ht be
> > > > > > cond_rescheded and the worst time latency to complete can be re=
ally
> > > > > > high. Makes more sense?
> > > > >
> > > > > I think I understand better now. So basically because we might dr=
op
> > > > > the lock and resched, there can be nr_cpus spinners + other spinn=
ers
> > > > > that are currently scheduled away, so these will need to wait to =
be
> > > > > scheduled and then start spinning on the lock. This may happen fo=
r one
> > > > > reader multiple times during its read, which is what can cause a =
high
> > > > > worst case latency.
> > > > >
> > > > > I hope I understood you correctly this time. Did I?
> > > >
> > > > Yes. I would just add that this could also influence the worst case
> > > > latency for a different reader - so an adversary user can stall oth=
ers.
> > >
> > > I can add that for v2 to the commit log, thanks.
> > >
> > > > Exposing a shared global lock in uncontrolable way over generally
> > > > available user interface is not really a great idea IMHO.
> > >
> > > I think that's how it was always meant to be when it was designed. Th=
e
> > > global rstat lock has always existed and was always available to
> > > userspace readers. The memory controller took a different path at som=
e
> > > point with unified flushing, but that was mainly because of high
> > > concurrency from in-kernel flushers, not because userspace readers
> > > caused a problem. Outside of memcg, the core cgroup code has always
> > > exercised this global lock when reading cpu.stat since rstat's
> > > introduction. I assume there hasn't been any problems since it's stil=
l
> > > there.
>
> I suspect nobody has just considered a malfunctioning or adversary
> workloads so far.

Perhaps that also means it's not a problem in practice, or at least I hope =
so :)

>
> > > I was hoping Tejun would confirm/deny this.
>
> Yes, that would be interesting to hear.
>
> > One thing we can do to remedy this situation is to replace the global
> > rstat lock with a mutex, and drop the resched/lock dropping condition.
> > Tejun suggested this in the previous thread. This effectively reverts
> > 0fa294fb1985 ("cgroup: Replace cgroup_rstat_mutex with a spinlock")
> > since now all the flushing contexts are sleepable.
>
> I would have a very daring question. Do we really need a global lock in
> the first place? AFAIU this locks serializes (kinda as the lock can be
> dropped midway) flushers and cgroup_rstat_flush_hold/release caller (a
> single one ATM). I can see cgroup_base_stat_cputime_show would like to
> have a consistent view on multiple stats but can we live without a
> strong guarantee or to replace the lock with seqlock instead?

Unfortunately, it's more difficult than this. I thought about breaking
down that lock and falled back to this solution. See below.

>
> > My synthetic stress test does not show any regressions with mutexes,
> > and there is a small boost to reading latency (probably because we
> > stop dropping the lock / rescheduling). Not sure if we may start
> > seeing need_resched warnings on big flushes though.
>
> Reading 0fa294fb1985 ("cgroup: Replace cgroup_rstat_mutex with a spinlock=
")
> it seems the point of moving away from mutex was to have a more usable
> API.

Right, we needed an atomic interface for flushing, but that later
turned out to cause some problems, so we reworked the code such that
we never have to flush atomically. Now we can go back to the mutex if
it makes things better, I am not really sure how much it helps though.

>
> > One other concern that Shakeel pointed out to me is preemption. If
> > someone holding the mutex gets preempted this may starve other
> > waiters. We can disable preemption while we hold the mutex, not sure
> > if that's a common pattern though.
>
> No, not really. It is expected that holder of mutex can sleep and can be
> preempted as well.

Maybe not for this specific case because it's a global mutex and
holding it for too long might cause problems? Is it bad to disable
preemption while holding a mutex?

>
> I might be wrong but the whole discussion so far suggests that the
> global rstat lock should be reconsidered. From my personal experience
> global locks easily triggerable from the userspace are just a receip for
> problems. Stats reading shouldn't be interfering with the system runtime
> as much as possible and they should be deterministic wrt runtime as
> well.

The problem is that the global lock also serializes the global
counters that we flush to. I will talk from the memcg flushing
perspective as that's what I am familiar with. I am not sure how much
this is transferable to other flushers.

On the memcg side (see mem_cgroup_css_rstat_flush()), the global lock
synchronizes access to multiple counters, for this discussion what's
most important are:
- The global stat counters of the memcg being flushed (e.g.
memcg->vmstats->state).
- The pending stat counters of the parent being flushed (e.g.
parent->vmstats->state_pending).

To get rid of this lock, we either need to use atomics for those
counters, or have fine-grained locks. I experimented a while back with
atomic and flushing was significantly more expensive. The number of
atomic operations would scale with O(# cgroups * # cpus) and can grow
unbounded.

The other option is fine-grained locks. In this case we would need to
lock both the memcg being flushed and its parent together. This can go
wrong with ordering, and for top-level memcgs the root memcg lock will
become the new global lock anyway. One way to overcome this is to
change the parent's pending stat counters to also be percpu. This will
increase the memory usage of the stat counters per-memcg, by hundreds
of bytes per cpu.

Let's assume that's okay, so we only need to lock one cgroup at a
time. There are more problems.

We also have a percpu lock (cgroup_rstat_cpu_lock), which we use to
lock the percpu tree which has the cgroups that have updates on this
cpu. It is held by both flushing contexts and updating contexts (hot
paths). Ideally we don't want to spin on a per-cgroup (non percpu)
lock while holding the percpu lock, as flushers of different cpus will
start blocking one another, as well as blocking updaters. On the other
hand, we need to hold percpu lock to pop a cgroup from that tree and
lock it. It's a chicken and egg problem. Also, if we release the
percpu lock while flushing, we open another can of worms:
(a) Concurrent updates can keep updating the tree putting us in an
endless flushing loop. We need some sort of generation tracking for
this.
(b) Concurrent flushing can flush a parent prematurely on the same cpu
as we are flushing a child, and not get the updates from the child.

One possible scheme to handle the above is as follows:
1. Hold the percpu lock, find the cgroup that needs to be flushed next.
2. Trylock that cgroup. If we succeed, we flush it with both the
percpu and the per-cgroup locks held.
3. If we fail, release the percpu lock and spin on the per-cgroup lock.
4. When we get the per-cgroup lock, take the percpu lock again, and
make sure that the locked cgroup is still the correct cgroup to flush.
If not, repeat.
5. Flush the cgroup, and go back to step 1 to get the next cgroup.

Of course this is complex and error-prone, and might introduce
significant overheads due to the number of locks we need to take
compared with what we currently have.

I guess what I am trying to say is, breaking down that lock is a major
surgery that might require re-designing or re-implementing some parts
of rstat. I would be extremely happy to be proven wrong. If we can
break down that lock then there is no need for unified flushing even
for in-kernel contexts, and we can all live happily ever after with
cheap(ish) and accurate stats flushing.

I really hope we can move forward with the problems at hand (sometimes
reads are expensive, sometimes reads are stale), and not block fixing
them until we can come up with an alternative to that global lock
(unless, of course, there is a simpler way of doing that).

Sorry for the very long reply :)

Thanks!
