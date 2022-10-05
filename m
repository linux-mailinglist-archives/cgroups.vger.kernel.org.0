Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EAC5F5979
	for <lists+cgroups@lfdr.de>; Wed,  5 Oct 2022 20:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiJESDE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Oct 2022 14:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJESDC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Oct 2022 14:03:02 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3E82D1DD
        for <cgroups@vger.kernel.org>; Wed,  5 Oct 2022 11:03:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id iv17so11266320wmb.4
        for <cgroups@vger.kernel.org>; Wed, 05 Oct 2022 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TCjtwDE/ZriAtqa2DbIyOC1Y1At4WbYfOYk+xVAATWQ=;
        b=Xfw+5sNmm+fWTn26t0tSkv6zUUdq6QmZHfCIhQtyetkHr5wyAEB6FoFq+DqwNzdowP
         ouWGV1dUT4fWhIJNgN7md3ziWMZi3LMK/boqOdcmnXkNJs1L6QwEFMmoRgF33+i88MPx
         8pev0ba9LpkIDrEob88pqFMGIG5WcJA1H93g8fOGliIdA+g5jZqTAeVSLXBelYBVPd+k
         JjDtSJ96uoBdhKSt7QVaxipVN7VIjsRxZTmY3O31gVOdLyeDJXRFyxiHkYrar25H/0ad
         wDTOBxzM/B42UT1SaSGSu3maVSph/JsJWOs0X3pjNbt05T4MT4I0HI9k8eUCd38qtV45
         aSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TCjtwDE/ZriAtqa2DbIyOC1Y1At4WbYfOYk+xVAATWQ=;
        b=wJ6IAJNmpzJy/wVo/cSgs9fpmtxuS0ZI9E0KFZeCdCsCbs9r9WRnnfXH0+eSNOUe0L
         8kWAQoAD+Kciw9vozbmAexWoVNjEpcQaFuPyM+zXZhc1tpr/ro5N0UWZ8WCo7KvPakFy
         /5D9/1sqWxk43qU93+6kf97tdjQ6KQaxMFnHeSHZhFtZc3oSVkbDC1lsyo++Udi26F+n
         5q1tLDw6JkECS2SzEy1ku0CQftviO1Dg8y0KujXKnDCtdGz5xc909Nybjk6J4KNHlgYV
         q6J6m6JWvuWta2bLIOl0bsMzjYUhGgM6B4kjaC4YD1ZSfrfVHwIj1Accf/+rbFAJXAIA
         FWqQ==
X-Gm-Message-State: ACrzQf1OnibXvjie/T1pJ4B7Mup4XKuE2BMboxB1bq/ZK/n7z9e/iZzp
        xdvW+64CfWDxHOOd6kHSkmWd1z6m0n3G5TamMAKGyQ==
X-Google-Smtp-Source: AMsMyM57C9+pCe8tNMjFFr62B8wfQ2NyVgB+jkNXJx3WCP2hOyJf8r0gr42KRu1ckUCg3zrXVlvUjq2PkaZqigbvGmg=
X-Received: by 2002:a7b:ce97:0:b0:3b3:4136:59fe with SMTP id
 q23-20020a7bce97000000b003b3413659femr552445wmj.24.1664992980038; Wed, 05 Oct
 2022 11:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
 <Yz2xDq0jo1WZNblz@slm.duckdns.org> <CAJD7tkawcrpmacguvyWVK952KtD-tP+wc2peHEjyMHesdM1o0Q@mail.gmail.com>
 <Yz3CH7caP7H/C3gL@slm.duckdns.org>
In-Reply-To: <Yz3CH7caP7H/C3gL@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 5 Oct 2022 11:02:23 -0700
Message-ID: <CAJD7tkY8gNNaPneAVFDYcWN9irUvE4ZFW=Hv=5898cWFG1p7rg@mail.gmail.com>
Subject: Re: [RFC] memcg rstat flushing optimization
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Oct 5, 2022 at 10:43 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Oct 05, 2022 at 10:20:54AM -0700, Yosry Ahmed wrote:
> > > How long were the stalls? Given that rstats are usually flushed by its
> >
> > I think 10 seconds while interrupts are disabled is what we need for a
> > hard lockup, right?
>
> Oh man, that's a long while. I'd really like to learn more about the
> numbers. How many cgroups are being flushed across how many CPUs?

The total number of cgroups is about ~11k. Unfortunately, I wouldn't
know how many of them are on the rstat updated tree. The number of
cpus is 256.

In all honesty a chunk of those cgroups were dying, which is a
different problem, but there is nothing really preventing our users
from creating that many live cgroups. Also, we naturally don't want
the kernel to face a 10s hard lockup and panic even if we have a
zombie cgroups problem.

Interestingly, we are on cgroup v1, which means we are only flushing
memcg stats. When we move to cgroup v2 we will also flush blkcg stats
in the same irq disabled call.

>
> > IIUC you mean that the caller of cgroup_rstat_flush() can call a
> > different variant that only flushes a part of the rstat tree then
> > returns, and the caller makes several calls interleaved by re-enabling
> > irq, right? Because the flushing code seems to already do this
> > internally if the non irqsafe version is used.
>
> I was thinking more that being done inside the flush function.

I think the flush function already does that in some sense if
might_sleep is true, right? The problem here is that we are using
cgroup_rstat_flush_irqsafe() which can't sleep. Even if we modify
mem_cgroup_flush_stats() so that it doesn't always call the irqsafe
version, we still have code paths that need AFAICT. It would help to
limit the callers to the irqsafe version, but it doesn't fix the
problem.

>
> > I think this might be tricky. In this case the path that caused the
> > lockup was memcg_check_events()->mem_cgroup_threshold()->__mem_cgroup_threshold()->mem_cgroup_usage()->mem_cgroup_flush_stats().
> > Interrupts are disabled by callers of memcg_check_events(), but the
> > rstat flush call is made much deeper in the call stack. Whoever is
> > disabling interrupts doesn't have access to pause/resume flushing.
>
> Hmm.... yeah I guess it's worthwhile to experiment with selective flushing
> for specific paths. That said, we'd still need to address the whole flush
> taking long too.

Agreed. The irqsafe paths are a more severe problem but ideally we
want to optimize flushing in general (which is why I dumped a lot of
ideas in the original email, to see what makes sense to other folks).

>
> > There are also other code paths that used to use
> > cgroup_rstat_flush_irqsafe() directly before mem_cgroup_flush_stats()
> > was introduced like mem_cgroup_wb_stats() [1].
> >
> > This is why I suggested a selective flushing variant of
> > cgroup_rstat_flush_irqsafe(), so that flushers that need irq disabled
> > have the ability to only flush a subset of the stats to avoid long
> > stalls if possible.
>
> I have nothing against selective flushing but it's not a free thing to do
> both in terms of complexity and runtime overhead, so let's get some numbers
> on how much time is spent where.

The problem with acquiring numbers is that rstat flushing is very
heavily dependent on workloads. The stats represent basically
everything that memcg does. There might be some workloads that only
update a couple of stats mostly, and workloads that exercise most of
them. There might also be workloads that are limited to a few cpus or
can run on all cpus. The number of memcgs is also a huge factor. It
feels like if we use an artificial benchmark it would significantly be
non-representative.

I took a couple of crashed machines kdumps and ran a script to
traverse updated memcgs and check how many cpus have updates and how
many updates are there on each cpu. I found that on average only a
couple of stats are updated per-cpu per-cgroup, and less than 25% of
cpus (but this is on a large machine, I expect the number to go higher
on smaller machines). Which is why I suggested a bitmask. I understand
though that this depends on whatever workloads were running on those
machines, and that in case where most stats are updated the bitmask
will actually make things slightly worse.

>
> Thanks.
>
> --
> tejun
