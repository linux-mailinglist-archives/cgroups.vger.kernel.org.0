Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223E798003
	for <lists+cgroups@lfdr.de>; Fri,  8 Sep 2023 03:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbjIHBMH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Sep 2023 21:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjIHBMH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Sep 2023 21:12:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E60C1BCB
        for <cgroups@vger.kernel.org>; Thu,  7 Sep 2023 18:12:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so324208066b.0
        for <cgroups@vger.kernel.org>; Thu, 07 Sep 2023 18:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694135521; x=1694740321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwP1nywgzoBgchgsvrLcyHWBwwxyPh3r9Nw+HpT3wqM=;
        b=EE5Dp9cXwobIzfTx6SUK8DmHqidYAPPgSQRFZoL/OdyAARG1eKxUk6v2YmWtjykYl2
         /WislVDIVqR7tdqVAVxqRKxTijIHXPCdpv86CcDKB0zDM6LQCb8C+WkdLnJ3PwsxApUj
         lrzv2MM89nGydKOVsdIWFgllr0ncS+IdLNM0K8hgjlL4Lw2jw9Nlm+JHJaR5NNohOJfF
         xFbczENfYikFHH4rQCQqPyFEeWy2hgKiUTz1DVlgckEHlnDRRpSOpPm0XKuJDei1ocmM
         YDCdBiipLBfVVj7rryvmmoyypx9m5YmWav8PNJ/iC9FKb/qNlnXYj26xCqYksO2ZT0qr
         Jb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694135521; x=1694740321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwP1nywgzoBgchgsvrLcyHWBwwxyPh3r9Nw+HpT3wqM=;
        b=aFWWoUwQVzJdION7ZD+NZHnBfObTL7kv0M4FpnApqdaPlWyCu/XM0jF8LmcHXjuBnA
         w8r2hdfYhiaOyxTYjdJN2cQvKWFOW8bFI6R43TWTrGO4DrcvutMOOdIzGAEpwlBTjiIg
         0Bkx1jF0JkK/B0fxip/9tTXtT3ABJnIFJosJyylw88j6ZO2bsbdYjg9l34b7sDSVZlLB
         ocl3lMrn3akg88dkYfqw2O49QHU4Oy7VSKXWN9kYhOXV6f4gsGpfbmti0ejseo+G6Zby
         mzx1VPURYcvnwtJk4TpJcUJ5QClL1Di3BH7GPuHV6XgI268XRsBppJN7vn9Xrh2xU0M+
         /kjA==
X-Gm-Message-State: AOJu0YwDcKuABpB58RjzeOFqOeVhoGTVevzB5w1K5eZ4KLAqgI7uRvMk
        HLrzlOVXcsuB171Y3BHmp8M6cc6tgdaoK/2s7IiG9w==
X-Google-Smtp-Source: AGHT+IEo4HrtlJQLiB3a2CguUL41qVkvqToyGm9wIVJBUWGz9ZnQ1lO3IUapwZ91iqxoVX0OpJDvsX65JDjRAipLIvM=
X-Received: by 2002:a17:907:e8e:b0:9a1:e5bf:c907 with SMTP id
 ho14-20020a1709070e8e00b009a1e5bfc907mr5449125ejc.2.1694135521534; Thu, 07
 Sep 2023 18:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com> <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com> <CABWYdi1WNp9f20nRFEExn8QB1MwP7QXwvD6Q8xHHuTO2SUTLkA@mail.gmail.com>
In-Reply-To: <CABWYdi1WNp9f20nRFEExn8QB1MwP7QXwvD6Q8xHHuTO2SUTLkA@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 7 Sep 2023 18:11:22 -0700
Message-ID: <CAJD7tkasteOdJ_waQ0r9WqbiwRz3OCzmx35v7-XMNOLb2WRddQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Wei Xu <weixugc@google.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 7, 2023 at 6:03=E2=80=AFPM Ivan Babrou <ivan@cloudflare.com> wr=
ote:
>
> On Thu, Sep 7, 2023 at 5:52=E2=80=AFPM Wei Xu <weixugc@google.com> wrote:
> >
> > On Mon, Sep 4, 2023 at 8:15=E2=80=AFAM Michal Hocko <mhocko@suse.com> w=
rote:
> > >
> > > On Thu 31-08-23 16:56:11, Yosry Ahmed wrote:
> > > > Unified flushing allows for great concurrency for paths that attemp=
t to
> > > > flush the stats, at the expense of potential staleness and a single
> > > > flusher paying the extra cost of flushing the full tree.
> > > >
> > > > This tradeoff makes sense for in-kernel flushers that may observe h=
igh
> > > > concurrency (e.g. reclaim, refault). For userspace readers, stale s=
tats
> > > > may be unexpected and problematic, especially when such stats are u=
sed
> > > > for critical paths such as userspace OOM handling. Additionally, a
> > > > userspace reader will occasionally pay the cost of flushing the ent=
ire
> > > > hierarchy, which also causes problems in some cases [1].
> > > >
> > > > Opt userspace reads out of unified flushing. This makes the cost of
> > > > reading the stats more predictable (proportional to the size of the
> > > > subtree), as well as the freshness of the stats. Userspace readers =
are
> > > > not expected to have similar concurrency to in-kernel flushers,
> > > > serializing them among themselves and among in-kernel flushers shou=
ld be
> > > > okay. Nonetheless, for extra safety, introduce a mutex when flushin=
g for
> > > > userspace readers to make sure only a single userspace reader can c=
ompete
> > > > with in-kernel flushers at a time. This takes away userspace abilit=
y to
> > > > directly influence or hurt in-kernel lock contention.
> > >
> > > I think it would be helpful to note that the primary reason this is a
> > > concern is that the spinlock is dropped during flushing under
> > > contention.
> > >
> > > > An alternative is to remove flushing from the stats reading path
> > > > completely, and rely on the periodic flusher. This should be accomp=
anied
> > > > by making the periodic flushing period tunable, and providing an
> > > > interface for userspace to force a flush, following a similar model=
 to
> > > > /proc/vmstat. However, such a change will be hard to reverse if the
> > > > implementation needs to be changed because:
> > > > - The cost of reading stats will be very cheap and we won't be able=
 to
> > > >   take that back easily.
> > > > - There are user-visible interfaces involved.
> > > >
> > > > Hence, let's go with the change that's most reversible first and re=
visit
> > > > as needed.
> > > >
> > > > This was tested on a machine with 256 cpus by running a synthetic t=
est
> > > > script [2] that creates 50 top-level cgroups, each with 5 children =
(250
> > > > leaf cgroups). Each leaf cgroup has 10 processes running that alloc=
ate
> > > > memory beyond the cgroup limit, invoking reclaim (which is an in-ke=
rnel
> > > > unified flusher). Concurrently, one thread is spawned per-cgroup to=
 read
> > > > the stats every second (including root, top-level, and leaf cgroups=
 --
> > > > so total 251 threads). No significant regressions were observed in =
the
> > > > total run time, which means that userspace readers are not signific=
antly
> > > > affecting in-kernel flushers:
> > > >
> > > > Base (mm-unstable):
> > > >
> > > > real  0m22.500s
> > > > user  0m9.399s
> > > > sys   73m41.381s
> > > >
> > > > real  0m22.749s
> > > > user  0m15.648s
> > > > sys   73m13.113s
> > > >
> > > > real  0m22.466s
> > > > user  0m10.000s
> > > > sys   73m11.933s
> > > >
> > > > With this patch:
> > > >
> > > > real  0m23.092s
> > > > user  0m10.110s
> > > > sys   75m42.774s
> > > >
> > > > real  0m22.277s
> > > > user  0m10.443s
> > > > sys   72m7.182s
> > > >
> > > > real  0m24.127s
> > > > user  0m12.617s
> > > > sys   78m52.765s
> > > >
> > > > [1]https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08=
M43KO9ME4-dsgfoQ@mail.gmail.com/
> > > > [2]https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbC=
jcOBZcz6POYTV-4g@mail.gmail.com/
> > > >
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > >
> > > OK, I can live with that but I still believe that locking involved in
> > > the user interface only begs for issues later on as there is no contr=
ol
> > > over that lock contention other than the number of processes involved=
.
> > > As it seems that we cannot make a consensus on this concern now and t=
his
> > > should be already helping existing workloads then let's just buy some
> > > more time ;)
> >
> > Indeed, even though the new global mutex protects the kernel from the
> > userspace contention on the rstats spinlock, its current
> > implementation doesn't have any protection for the lock contention
> > among the userspace threads and can cause significant delays to memcg
> > stats reads.
> >
> > I tested this patch on a machine with 384 CPUs using a microbenchmark
> > that spawns 10K threads, each reading its memory.stat every 100
> > milliseconds.  Most of memory.stat reads take 5ms-10ms in kernel, with
> > ~5% reads even exceeding 1 second. This is a significant regression.
> > In comparison, without contention, each memory.stat read only takes
> > 20us-50us in the kernel.  Almost all of the extra read time is spent
> > on waiting for the new mutex. The time to flush rstats only accounts
> > for 10us-50us (This test creates only 1K memory cgroups and doesn't
> > generate any loads other than these stat reader threads).
> >
> >  Here are some ideas to control the lock contention on the mutex and
> > reduce both the median and tail latencies of concurrent memcg stat
> > reads:


Thanks for the analysis, Wei!

I will update the patch series based on your ideas to limit the
contention on the userspace read mutex.

>
> >
> > - Bring back the stats_flush_threshold check in
> > mem_cgroup_try_flush_stats() to mem_cgroup_user_flush_stats().  This
> > check provides a reasonable bound on the stats staleness while being
> > able to filter out a large number of rstats flush requests, which
> > reduces the contention on the mutex.
> >
> > - When contended, upgrade the per-memcg rstats flush in
> > mem_cgroup_user_flush_stats() to a root memcg flush and coalesce these
> > contended flushes together.  We can wait for the ongoing flush to
> > complete and eliminate repeated flush requests.
>
> Full root memcg flush being slow is one of the issues that prompted this =
patch:
>
> * https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9M=
E4-dsgfoQ@mail.gmail.com/
>
> I don't want us to regress in this regard.


It will only be a fallback if there is high concurrency among
userspace reads, which will cause high contention on the mutex. In
that case, the userspace reads will be slowed down by contention,
which can be even worse than flush slowness as it is theoretically
unbounded.

I am working on a v5 now to incorporate Wei's suggestions. Would you
be able to test that and verify that there are no regressions?

>
>
> > - Wait for the mutex and the ongoing flush with a timeout.  We should
> > not use busy-wait, though.  We can bail out to read the stats without
> > a flush after enough wait.  A long-stalled system call is much worse
> > than somewhat stale stats in the corner cases in my opinion.
> >
> > Wei Xu
> >
