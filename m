Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6383C6C8896
	for <lists+cgroups@lfdr.de>; Fri, 24 Mar 2023 23:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjCXWuv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Mar 2023 18:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjCXWuu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Mar 2023 18:50:50 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51FF766
        for <cgroups@vger.kernel.org>; Fri, 24 Mar 2023 15:50:48 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y4so13610088edo.2
        for <cgroups@vger.kernel.org>; Fri, 24 Mar 2023 15:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679698247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4C4+ig9qii8cFMiMH7UB83VKoFh5dhcH5qAN4vMsyQ=;
        b=PNZilH1Gjf6oog3t5h9HCkdzcH1etVK5NHRvqEGz0tzMA6UkvV8oibBMlnELMdCsTx
         ESv3g4RuIOXbzQrTC6JLpovuuTr2leIRJnt5pu6Ur8taswzMfoVb3b76ogYPK9rIUKoz
         ZroJcsC87UZfJJ2+P4nODPSm6IGXHRapFkl2XStb5f6xPFrqB4NCxRgBRY328FFsfaDb
         t6M4EYsSyH+txGLv4+tb4mRYPL29/PWW8y0ndgEQEPnNflpkS9g0D0g6ILZ3+M7P/deo
         ZMVQpgzWN70olFlt/oeGeYGAsjRYrdlraZNnRwlFQ+LQ65cNhoGA3o8yS9sSslR5pm/L
         5tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679698247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4C4+ig9qii8cFMiMH7UB83VKoFh5dhcH5qAN4vMsyQ=;
        b=Vdrz/l6JEYa6oGczSa5oYABYZMC5vR6zq+fHKR7SXsSuxh4gNkjWVXq4K7FaCnHJt7
         YwRPzJPHYiabyGz8v3H/Sw+vNdDHXujdH2Zuu3iOCIR0XPPDCMb/wTOGe8g7aOJwEi5d
         k8GD+ISjvxzauwQvpHChnRBdL3yOeD904xAxHedYToCaHgOhifCxZfdLzCAAkDark4L5
         p7fiPksSXyTfStqBbCJbdyyH4kHqnPOb/qAkw3Ys/62YdMi8EeckV2WlQiJ3klOq53gi
         4ozdtUTxfUBylDSVqUwVdBDiNw1hUJSlyN7VsC8XVAQYHaAVgr7UzjRjoyS+wuBK8/z4
         M67w==
X-Gm-Message-State: AAQBX9eexHaP3yw6IbR0ViQrsTTfgo/n/sEcbfdBX6l1jrGAfgkwg7lQ
        xvhB+Avvb12gHJs6EaiJRs8oWotxfi0z9+FtWxfLWg==
X-Google-Smtp-Source: AKy350as1fjLqRzEXcj4LkTEmL/GZJV50WUfZRkDVfUJxjhMe3gHdgiiXSgPCONXQe0PAnrHWJ2DjRG+gGSUM+zjV0U=
X-Received: by 2002:a50:a6d7:0:b0:4fa:71a2:982b with SMTP id
 f23-20020a50a6d7000000b004fa71a2982bmr2076902edc.0.1679698246555; Fri, 24 Mar
 2023 15:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-2-yosryahmed@google.com> <ZBz/V5a7/6PZeM7S@slm.duckdns.org>
 <CAJD7tkYNZeEytm_Px9_73Y-AYJfHAxaoTmmnO71HW5hd1B5tPg@mail.gmail.com> <53582a07-81c6-35eb-10bf-7920b27483be@redhat.com>
In-Reply-To: <53582a07-81c6-35eb-10bf-7920b27483be@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 24 Mar 2023 15:50:10 -0700
Message-ID: <CAJD7tkZA-LxAVA5SWRzMeQ17T26qGBApPqErqT_SpCbrtCJQkA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] cgroup: rstat: only disable interrupts for the
 percpu lock
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
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

On Fri, Mar 24, 2023 at 7:12=E2=80=AFAM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 3/24/23 03:22, Yosry Ahmed wrote:
> > On Thu, Mar 23, 2023 at 6:39=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote=
:
> >> Hello,
> >>
> >> On Thu, Mar 23, 2023 at 04:00:31AM +0000, Yosry Ahmed wrote:
> >>> Currently, when sleeping is not allowed during rstat flushing, we hol=
d
> >>> the global rstat lock with interrupts disabled throughout the entire
> >>> flush operation. Flushing in an O(# cgroups * # cpus) operation, and
> >>> having interrupts disabled throughout is dangerous.
> >>>
> >>> For some contexts, we may not want to sleep, but can be interrupted
> >>> (e.g. while holding a spinlock or RCU read lock). As such, do not
> >>> disable interrupts throughout rstat flushing, only when holding the
> >>> percpu lock. This breaks down the O(# cgroups * # cpus) duration with
> >>> interrupts disabled to a series of O(# cgroups) durations.
> >>>
> >>> Furthermore, if a cpu spinning waiting for the global rstat lock, it
> >>> doesn't need to spin with interrupts disabled anymore.
> >> I'm generally not a fan of big spin locks w/o irq protection. They too=
 often
> >> become a source of unpredictable latency spikes. As you said, the glob=
al
> >> rstat lock can be held for quite a while. Removing _irq makes irq late=
ncy
> >> better on the CPU but on the other hand it makes a lot more likely tha=
t the
> >> lock is gonna be held even longer, possibly significantly so depending=
 on
> >> the configuration and workload which will in turn stall other CPUs wai=
ting
> >> for the lock. Sure, irqs are being serviced quicker but if the cost is=
 more
> >> and longer !irq context multi-cpu stalls, what's the point?
> >>
> >> I don't think there's anything which requires the global lock to be he=
ld
> >> throughout the entire flushing sequence and irq needs to be disabled w=
hen
> >> grabbing the percpu lock anyway, so why not just release the global lo=
ck on
> >> CPU boundaries instead? We don't really lose anything significant that=
 way.
> >> The durations of irq disabled sections are still about the same as in =
the
> >> currently proposed solution at O(# cgroups) and we avoid the risk of h=
olding
> >> the global lock for too long unexpectedly from getting hit repeatedly =
by
> >> irqs while holding the global lock.
> > Thanks for taking a look!
> >
> > I think a problem with this approach is that we risk having to contend
> > for the global lock at every CPU boundary in atomic contexts. Right
> Isn't it the plan to just do a trylock in atomic contexts so that it
> won't get stuck spinning for the lock for an indeterminate amount of time=
?

Not exactly. On the memory controller side, we currently only allow
one flusher at a time and force all flushers to flush the full
hierarchy, such that concurrent flushers can skip. This is done for
both atomic and non-atomic contexts.

For flushers outside the memory controller, they can still contend the
lock among themselves or with flushers in the memory controller. In
this case, instead of contending the lock once, they contend it at
each CPU boundary.

> > now we contend for the global lock once, and once we have it we go
> > through all CPUs to flush, only having to contend with updates taking
> > the percpu locks at this point. If we unconditionally release &
> > reacquire the global lock at every CPU boundary then we may contend
> > for it much more frequently with concurrent flushers.
>
> Note that with the use of qspinlock in all the major arches, the impact
> of thundering herds of lockers are much less serious than before. There
> are certainly some overhead in doing multiple lock acquires and
> releases, but that shouldn't been too excessive.

I ran some tests to measure this. Since I am using a cgroup v1
hierarchy, I cannot reproduce contention between memory controller
flushers and non-memory controller flushers, so I removed the "one
memory flusher only" restriction to have concurrent memory flushers
compete for the global rstat lock to measure the impact:

Before (only one flusher allowed to compete for the global rstat lock):
            ---cgroup_rstat_flush
               |
                --1.27%--cgroup_rstat_flush_locked
                          |
                           --0.94%--mem_cgroup_css_rstat_flush

After (concurrent flushers allowed to compete for the global rstat lock):
            ---cgroup_rstat_flush
               |
               |--4.94%--_raw_spin_lock
               |          |
               |           --4.94%--queued_spin_lock_slowpath
               |
                --0.92%--cgroup_rstat_flush_locked
                          |
                           --0.56%--mem_cgroup_css_rstat_flush

This was run with 20 processes trying to flush concurrently, so it may
be excessive, but it seems like in this case lock contention makes a
significant difference.

Again, this is not a regression for non-atomic flushers, as they
already compete for the lock at every CPU boundary, but for atomic
flushers that don't give up the lock at all today, it would be a
regression to start competing for the lock at every CPU boundary. This
patch series aims to minimize the number of atomic flushers (brings
them down to two, one of which is not common), so this may be fine.

My main concern is that for some flushers that this series converts
from atomic to non-atomic, we may notice a regression later and revert
it (e.g. refault path), which is why I have them in separate patches.
If we regress the atomic flushing path, it would be a larger surgery
to restore the performance for these paths -- which is why I would
rather keep the atomic path without excessive lock contention.

Thoughts?

>
> I am all in for reducing lock hold time as much as possible as it will
> improve the response time.
>
> Cheers,
> Longman
>
