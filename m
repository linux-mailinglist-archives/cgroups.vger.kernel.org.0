Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4F26C6FF8
	for <lists+cgroups@lfdr.de>; Thu, 23 Mar 2023 19:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjCWSI1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Mar 2023 14:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjCWSI0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Mar 2023 14:08:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079E2A270
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 11:08:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so90490740edd.5
        for <cgroups@vger.kernel.org>; Thu, 23 Mar 2023 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679594903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVEQ3jjBhRvvdROqbmTd0ErWpAgtFM7LpI2zkeVM6nc=;
        b=iSMmzvR4nUOgFdPoIuMVdAVhXTbAdbYo7pLETlxOCbMwcNRovtBt/22dPXrSySYxbp
         zJCQTHhPo4PFrUR62vtMimmYSgiWTsqB9tSiqzOg0nSraK9/nvwtvh334JEH2rWJQ6FS
         97I4Xoiz7o/cACMu+o9beDqaksw/PavmXjFklptwSOqiOI8p/ig5E0vc2DDXoFcGspgE
         dju0BzbOVvGZNQp11KXGu3UcBpKdWla8vD/e/4gAeirBuUxilCcora4A4l+Yn/h2OwD4
         6M/kCw/eev/Mgj2sy4Ebimfd+9ZQNukVrkyECwua5LZ1YLU4Qdfjw8d4Qq5KqMIfy9SZ
         h7Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679594903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVEQ3jjBhRvvdROqbmTd0ErWpAgtFM7LpI2zkeVM6nc=;
        b=2vmbuK892/D2gikgB2s9q0xvFg8AF3GoR6W8WI0EiaX3+h0zn4MNeNvohmzRpUuboE
         Vq1HoFEOycFeUxATKy9lotwyle/Apu1CMoz3bP9TyLMXwpz5Jyif0piAemSiLVSZ7bLs
         Caj7tNz5NZRFzAxNwECRm4BFs0uAV4C8q62mFRbX6kEnGpJqualjExPl+7DxyfiQ81ko
         Y1PNxhxbvI4XRLU52UKwR1RUU2exa0u17mz7dgTW8fjI75mOCkst/ygzloorkRTU2rNS
         iS2IQrD3mzXLQqmpdwzqFOMYG7ydX+amWW1fNkap9ksliUZpi7kRMPub9HNplerrIw9H
         YoVg==
X-Gm-Message-State: AO0yUKUjQi/YhVSPXGLVxITt5DpJ3SwXL0xTmPDDJb6VO8q+f1bhhBRp
        Ttdq5zNQYo5tJREKVQhhfSpyzKz+4jg9CvSGW1DqwA==
X-Google-Smtp-Source: AK7set9uzu0+uLVYPeW1/TKT07Y1C8fU/op63gdiSoakbq07Xp2dmMzhQ0EX2/+iZXC1dLM/RK6moL4HGFXShEgJUAY=
X-Received: by 2002:a17:906:aac9:b0:927:912:6baf with SMTP id
 kt9-20020a170906aac900b0092709126bafmr5401952ejb.15.1679594903374; Thu, 23
 Mar 2023 11:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-5-yosryahmed@google.com> <20230323155613.GC739026@cmpxchg.org>
 <CAJD7tkZ7Dz9myftc9bg7jhiaOYcn7qJ+V4sxZ_2kfnb+k=zhJQ@mail.gmail.com> <20230323172732.GE739026@cmpxchg.org>
In-Reply-To: <20230323172732.GE739026@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Mar 2023 11:07:47 -0700
Message-ID: <CAJD7tkbtHhzOytu3hfN8tjdAyNq0BZXYN8TEipS4NTApUzkL7w@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] memcg: sleep during flushing stats in safe contexts
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
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

On Thu, Mar 23, 2023 at 10:27=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Thu, Mar 23, 2023 at 09:01:12AM -0700, Yosry Ahmed wrote:
> > On Thu, Mar 23, 2023 at 8:56=E2=80=AFAM Johannes Weiner <hannes@cmpxchg=
.org> wrote:
> > >
> > > On Thu, Mar 23, 2023 at 04:00:34AM +0000, Yosry Ahmed wrote:
> > > > @@ -644,26 +644,26 @@ static void __mem_cgroup_flush_stats(void)
> > > >               return;
> > > >
> > > >       flush_next_time =3D jiffies_64 + 2*FLUSH_TIME;
> > > > -     cgroup_rstat_flush(root_mem_cgroup->css.cgroup, false);
> > > > +     cgroup_rstat_flush(root_mem_cgroup->css.cgroup, may_sleep);
> > >
> > > How is it safe to call this with may_sleep=3Dtrue when it's holding t=
he
> > > stats_flush_lock?
> >
> > stats_flush_lock is always called with trylock, it is only used today
> > so that we can skip flushing if another cpu is already doing a flush
> > (which is not 100% correct as they may have not finished flushing yet,
> > but that's orthogonal here). So I think it should be safe to sleep as
> > no one can be blocked waiting for this spinlock.
>
> I see. It still cannot sleep while the lock is held, though, because
> preemption is disabled. Make sure you have all lock debugging on while
> testing this.

Thanks for pointing this out, will do.

>
> > Perhaps it would be better semantically to replace the spinlock with
> > an atomic test and set, instead of having a lock that can only be used
> > with trylock?
>
> It could be helpful to clarify what stats_flush_lock is protecting
> first. Keep in mind that locks should protect data, not code paths.
>
> Right now it's doing multiple things:
>
> 1. It protects updates to stats_flush_threshold
> 2. It protects updates to flush_next_time
> 3. It serializes calls to cgroup_rstat_flush() based on those ratelimits
>
> However,
>
> 1. stats_flush_threshold is already an atomic
>
> 2. flush_next_time is not atomic. The writer is locked, but the reader
>    is lockless. If the reader races with a flush, you could see this:
>
>                                         if (time_after(jiffies, flush_nex=
t_time))
>         spin_trylock()
>         flush_next_time =3D now + delay
>         flush()
>         spin_unlock()
>                                         spin_trylock()
>                                         flush_next_time =3D now + delay
>                                         flush()
>                                         spin_unlock()
>
>    which means we already can get flushes at a higher frequency than
>    FLUSH_TIME during races. But it isn't really a problem.
>
>    The reader could also see garbled partial updates, so it needs at
>    least READ_ONCE and WRITE_ONCE protection.
>
> 3. Serializing cgroup_rstat_flush() calls against the ratelimit
>    factors is currently broken because of the race in 2. But the race
>    is actually harmless, all we might get is the occasional earlier
>    flush. If there is no delta, the flush won't do much. And if there
>    is, the flush is justified.
>
> In summary, it seems to me the lock can be ditched altogether. All the
> code needs is READ_ONCE/WRITE_ONCE around flush_next_time.

Thanks a lot for this analysis. I agree that the lock can be removed
with proper READ_ONCE/WRITE_ONCE, but I think there is another purpose
of the lock that we are missing here.

I think one other purpose of the lock is avoiding a thundering herd
problem on cgroup_rstat_lock, particularly from reclaim context, as
mentioned by the log of  commit aa48e47e3906 ("memcg: infrastructure
to flush memcg stats").

While testing, I did notice that removing this lock indeed causes a
thundering herd problem if we have a lot of concurrent reclaimers. The
trylock makes sure we abort immediately if someone else is flushing --
which is not ideal because that flusher might have just started, and
we may end up reading stale data anyway.

This is why I suggested replacing the lock by an atomic, and do
something like this if we want to maintain the current behavior:

static void __mem_cgroup_flush_stats(void)
{
    ...
    if (atomic_xchg(&ongoing_flush, 1))
        return;
    ...
    atomic_set(&ongoing_flush, 0)
}

Alternatively, if we want to change the behavior and wait for the
concurrent flusher to finish flushing, we can maybe spin until
ongoing_flush goes back to 0 and then return:

static void __mem_cgroup_flush_stats(void)
{
    ...
    if (atomic_xchg(&ongoing_flush, 1)) {
        /* wait until the ongoing flusher finishes to get updated stats */
        while (atomic_read(&ongoing_flush) {};
        return;
    }
    /* flush the stats ourselves */
    ...
    atomic_set(&ongoing_flush, 0)
}

WDYT?
