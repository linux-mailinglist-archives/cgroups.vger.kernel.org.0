Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4116C8A2D
	for <lists+cgroups@lfdr.de>; Sat, 25 Mar 2023 03:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjCYCSf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Mar 2023 22:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjCYCSe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Mar 2023 22:18:34 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716862724
        for <cgroups@vger.kernel.org>; Fri, 24 Mar 2023 19:18:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b20so14808727edd.1
        for <cgroups@vger.kernel.org>; Fri, 24 Mar 2023 19:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679710711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uw0vvRX6fB45yziv3c2fRfTS3bTqjYau48XTnRaZKUQ=;
        b=O7Jst4Abb03/2SPXMx5C68RHpw3r3kFMKH7fZnFXh0aJIp2ZBgoM9SwaZL0lI/9pGh
         nOnlLtm4EcFl3i8d0j46aVqMGUTdlYBqj5yZXFsOZY9Wt0HiaQAMqbcFmRL6lcVCWdbx
         TnkXpXZS53IaAukR3UsCxNyfv1DwvSSVUN2GtB8yMaLijLAA2wiQ4TtPwRaAWmO3RNMB
         ssGwMxA6FnWB+KLIdXXQrz42GNgvAWzmC9y1auxEEhX5ynPFv8qM/jW7VouPr1t8bz9W
         o/YBrB3nWIDIOZaWdVAxep7Nkgx0jPcDgraTEVMPnZzXibYcCq16TyKvx4l4lRaML3zU
         Wd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679710711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uw0vvRX6fB45yziv3c2fRfTS3bTqjYau48XTnRaZKUQ=;
        b=3I+qK3t/ExIC9JE88JJtAPtHbAt1b4h9VylWhVrU313wJDWTDjtoaPbzy0NvE1ygVe
         KCFe1Z0wpeBn/+j318mSGRmcUOnWCAUFIYj0lwpfFqzJLiQmFPVf0t5XQPG6AoyVwPfy
         AEcpcAd8V/HpXIYUK/B81c8SzlJ9AMbfd076/Kv/XmPtYoUqeBA5TFELVrA44LLhll39
         5Tn8ITzHIZkCNmhezXD73P0uByKrd4BRS9qNSbwTG4tfMzLQYn12jPcKhRM8e9g3oDub
         F2J4TtQlcvmh9m3F7ZYHHZbLjq8ePss5oXAqKtuUPX9PEb6rlS0DjmSYLvRsGGPR5KjO
         7OJg==
X-Gm-Message-State: AAQBX9f5hPwWEyB3VqjYTWHcX6KqSsV5n0RUiL3QVT/CpQXfVZbM7IOk
        0s29CuhrOuavi0hvLyL3T5fzo0/UY2JZ4o+ZVaVO8A==
X-Google-Smtp-Source: AKy350a0I79S1SUmVIQ6HRmx0m1CdZp1+LfkjYwoFLdgBR60G/VLIqAXQszZ4lDVKDYUrsvufqHj6nn/nq6hxnyegx8=
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr2057027ejb.15.1679710710778; Fri, 24
 Mar 2023 19:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com> <ZB5UalkjGngcBDEJ@slm.duckdns.org>
In-Reply-To: <ZB5UalkjGngcBDEJ@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 24 Mar 2023 19:17:54 -0700
Message-ID: <CAJD7tkYhyMkD8SFf8b8L1W9QUrLOdw-HJ2NUbENjw5dgFnH3Aw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Tejun Heo <tj@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 24, 2023 at 6:54=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Mar 24, 2023 at 12:22:09AM -0700, Yosry Ahmed wrote:
> > I think a problem with this approach is that we risk having to contend
> > for the global lock at every CPU boundary in atomic contexts. Right
> > now we contend for the global lock once, and once we have it we go
> > through all CPUs to flush, only having to contend with updates taking
> > the percpu locks at this point. If we unconditionally release &
> > reacquire the global lock at every CPU boundary then we may contend
> > for it much more frequently with concurrent flushers.
> >
> > On the memory controller side, concurrent flushers are already held
> > back to avoid a thundering herd problem on the global rstat lock, but
> > flushers from outside the memory controller can still compete together
> > or with a flusher from the memory controller. In this case, we risk
> > contending the global lock more and concurrent flushers taking a
> > longer period of time, which may end up causing multi-CPU stalls
> > anyway, right? Also, if we keep _irq when spinning for the lock, then
> > concurrent flushers still need to spin with irq disabled -- another
> > problem that this series tries to fix.
> >
> > This is particularly a problem for flushers in atomic contexts. There
> > is a flusher in mem_cgroup_wb_stats() that flushes while holding
> > another spinlock, and a flusher in mem_cgroup_usage() that flushes
> > with irqs disabled. If flushing takes a longer period of time due to
> > repeated lock contention, it affects such atomic context negatively.
> >
> > I am not sure how all of this matters in practice, it depends heavily
> > on the workloads and the configuration like you mentioned. I am just
> > pointing out the potential disadvantages of reacquiring the lock at
> > every CPU boundary in atomic contexts.
>
> So, I'm not too convinced by the arguments for a couple reasons:
>
> * It's not very difficult to create conditions where a contented non-irq
>   protected spinlock is held unnecessarily long due to heavy IRQ irq load=
 on
>   the holding CPU. This can easily extend the amount of time the lock is
>   held by multiple times if not orders of magnitude. That is likely a
>   significantly worse problem than the contention on the lock cacheline
>   which will lead to a lot more gradual degradation.

I agree that can be a problem, it depends on the specific workload and
configuration. The continuous lock contention at each CPU boundary
causes a regression (see my reply to Waiman), but I am not sure if
it's worse than the scenario you are describing.

>
> * If concurrent flushing is an actual problem, we need and can implement =
a
>   better solution. There's quite a bit of maneuvering room here given tha=
t
>   the flushing operations are mostly idempotent in close time proximity a=
nd
>   there's no real atomicity requirement across different segments of
>   flushing operations.

Concurrent flushing can be a problem for some workloads, especially in
the MM code we flush in the reclaim and refault paths. This is
currently mitigated by only allowing one flusher at a time from the
memcg side, but contention can still happen with flushing when a
cgroup is being freed or other flushers in other subsystems.

I tried allowing concurrent flushing by completely removing the global
rstat lock, and only depending on the percpu locks for
synchronization. For this to be correct the global stat counters need
to be atomic, this introduced a slow down for flushing in general. I
also noticed heavier lock contention on the percpu locks, since all
flushers try to acquire all locks in the same order. I even tried
implementing a simple retry scheme where we try to acquire the percpu
lock, and if we fail we queue the current cpu and move to the next
one. This ended up causing a little bit of slowness as well. Together
with the slowness introduced by atomic operations it seemed like a
significant regression in the simple flushing path.

Don't get me wrong, I am all for modifying the current approach, I
just want to make sure we are making the correct decision for *most*
workloads. Keep in mind that this series aims to minimize the number
of flushers from atomic contexts as well, and for non-atomic flushers
we allow giving up the lock at CPU boundaries anyway. The current
approach only keeps the lock held throughout for atomic flushers.

Any ideas here are welcome!

>
> Thanks.
>
> --
> tejun
