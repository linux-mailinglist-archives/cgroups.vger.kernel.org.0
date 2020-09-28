Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B2027B6CB
	for <lists+cgroups@lfdr.de>; Mon, 28 Sep 2020 23:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgI1VDz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Sep 2020 17:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgI1VDz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Sep 2020 17:03:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81994C061755
        for <cgroups@vger.kernel.org>; Mon, 28 Sep 2020 14:03:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s131so2431157qke.0
        for <cgroups@vger.kernel.org>; Mon, 28 Sep 2020 14:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SGBe8MpSknH0qUb+TQ90a6ftrB2Ede16bHQ7TXX42Tw=;
        b=Vtkaz3mp9a/NY/motnU4x+MiinMLrHa+BomCSZqvd/94lUeghj9zTyK0isXJQDPNcZ
         tIYJgFj8bxYSYVfrutfK7NslWH0FKdNxyQM2TUh7RbX/+k5Aq68v2co3gbvLBbnA+Y9b
         Q0tM24OtlAKlE2lkaxPXRaXVYKLiz/2HCaYmRDwKYzf1jL7irKZtZV9hEkmR8C6OyFBt
         tED7c83d22hWrtTlz3MY07Co8qUTaNZB9zUYrG+EE1nW8I1KqoxJQ15erhYZbNPmCJuO
         0nVk/EQMhSqQksp50gMeUB2JNwP5iWRpAmi+E5fNP3Fn70jG1HKW6OdaSlS4CwxiJu6W
         Kmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SGBe8MpSknH0qUb+TQ90a6ftrB2Ede16bHQ7TXX42Tw=;
        b=JcsZpl414dEgmPYyhiuWbPVdBm0f/hFY45zU8rlB2IVEpOrBjJhhEqPwvH6QUqQOs5
         Bx86xw1Xdw7BqRvxMj2X6mrI6OJeX8dApltd4tG84nFkSNoGenkTmysmBspr4HZTc0DB
         E3ya7X4Valk3lO2JjueDOn9QpjGjJjoRhK8IT7RobyLgFmE5/rXHsPXaUYMPFBN4NZYL
         IYtt5dF0OAFCR++vSMONDAljfTKQqZFd8FOSr/Dm8J9cFkPJDCUAm4Ci1I9i3PqRheV6
         DV1UAoNANdxWsnOOLJwdyRCG0DI00jqqM5WniJn24/PpYRHzUxqOGbw7q9E8iI6TwDWY
         uGAg==
X-Gm-Message-State: AOAM533tQ8OuVRE8OKODrYVoffDOESpW3pPwa4/J5F22HBNevz/nU5O5
        zT7eMU1Zna6m6rSCBIJHpJPKLw==
X-Google-Smtp-Source: ABdhPJy9DN7eukM57oH76vW7yWC/hkgBmIqLB2xSOGXpfF8h03OXKgaYAK8Ds39zw0xS7+3LjVvUYQ==
X-Received: by 2002:a05:620a:1583:: with SMTP id d3mr1317180qkk.495.1601327034521;
        Mon, 28 Sep 2020 14:03:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3928])
        by smtp.gmail.com with ESMTPSA id y46sm2665377qtc.30.2020.09.28.14.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:03:53 -0700 (PDT)
Date:   Mon, 28 Sep 2020 17:02:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20200928210216.GA378894@cmpxchg.org>
References: <20200909215752.1725525-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909215752.1725525-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

I apologize for the late reply. The proposed interface has been an
ongoing topic and area of experimentation within Facebook as well,
which makes it a bit difficult to respond with certainty here.

I agree with both your usecases. They apply to us as well. We
currently make two small changes to our kernel to solve them. They
work okay-ish in our production environment, but they aren't quite
there yet, and not ready for upstream.

Some thoughts and comments below.

On Wed, Sep 09, 2020 at 02:57:52PM -0700, Shakeel Butt wrote:
> Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> 
> Use cases:
> ----------
> 
> 1) Per-memcg uswapd:
> 
> Usually applications consists of combination of latency sensitive and
> latency tolerant tasks. For example, tasks serving user requests vs
> tasks doing data backup for a database application. At the moment the
> kernel does not differentiate between such tasks when the application
> hits the memcg limits. So, potentially a latency sensitive user facing
> task can get stuck in high reclaim and be throttled by the kernel.
> 
> Similarly there are cases of single process applications having two set
> of thread pools where threads from one pool have high scheduling
> priority and low latency requirement. One concrete example from our
> production is the VMM which have high priority low latency thread pool
> for the VCPUs while separate thread pool for stats reporting, I/O
> emulation, health checks and other managerial operations. The kernel
> memory reclaim does not differentiate between VCPU thread or a
> non-latency sensitive thread and a VCPU thread can get stuck in high
> reclaim.
> 
> One way to resolve this issue is to preemptively trigger the memory
> reclaim from a latency tolerant task (uswapd) when the application is
> near the limits. Finding 'near the limits' situation is an orthogonal
> problem.

I don't think a userspace implementation is suitable for this purpose.

Kswapd-style background reclaim is beneficial to probably 99% of all
workloads. Because doing reclaim inside the execution stream of the
workload itself is so unnecessary in a multi-CPU environment, whether
the workload is particularly latency sensitive or only cares about
overall throughput. In most cases, spare cores are available to do
this work concurrently, and the buffer memory required between the
workload and the async reclaimer tends to be negligible.

Requiring non-trivial userspace participation for such a basic
optimization does not seem like a good idea to me. We'd probably end
up with four or five hyperscalers having four or five different
implementations, and not much user coverage beyond that.

I floated this patch before:
https://lore.kernel.org/linux-mm/20200219181219.54356-1-hannes@cmpxchg.org/

It's blocked on infrastructure work in the CPU controller that allows
accounting CPU cycles spent on behalf of other cgroups. But we need
this functionality in other places as well - network, async filesystem
encryption, various other stuff bounced to workers.

> 2) Proactive reclaim:
> 
> This is a similar to the previous use-case, the difference is instead of
> waiting for the application to be near its limit to trigger memory
> reclaim, continuously pressuring the memcg to reclaim a small amount of
> memory. This gives more accurate and uptodate workingset estimation as
> the LRUs are continuously sorted and can potentially provide more
> deterministic memory overcommit behavior. The memory overcommit
> controller can provide more proactive response to the changing behavior
> of the running applications instead of being reactive.

This is an important usecase for us as well. And we use it not just to
keep the LRUs warm, but to actively sample the workingset size - the
true amount of memory required, trimmed of all its unused cache and
cold pages that can be read back from disk on demand.

For this purpose, we're essentially using memory.high right now.

The only modification we make here is adding a memory.high.tmp variant
that takes a timeout argument in addition to the limit. This ensures
we don't leave an unsafe limit behind if the userspace daemon crashes.

We have experienced some of the problems you describe below with it.

> Benefit of user space solution:
> -------------------------------
> 
> 1) More flexible on who should be charged for the cpu of the memory
> reclaim. For proactive reclaim, it makes more sense to centralized the
> overhead while for uswapd, it makes more sense for the application to
> pay for the cpu of the memory reclaim.

Agreed on both counts.

> 2) More flexible on dedicating the resources (like cpu). The memory
> overcommit controller can balance the cost between the cpu usage and
> the memory reclaimed.

This could use some elaboration, I think.

> 3) Provides a way to the applications to keep their LRUs sorted, so,
> under memory pressure better reclaim candidates are selected. This also
> gives more accurate and uptodate notion of working set for an
> application.

That's a valid argument for proactive reclaim, and I agree with
it. But not necessarily an argument for which part of the proactive
reclaim logic should be in-kernel and which should be in userspace.

> Questions:
> ----------
> 
> 1) Why memory.high is not enough?
> 
> memory.high can be used to trigger reclaim in a memcg and can
> potentially be used for proactive reclaim as well as uswapd use cases.
> However there is a big negative in using memory.high. It can potentially
> introduce high reclaim stalls in the target application as the
> allocations from the processes or the threads of the application can hit
> the temporary memory.high limit.

That's something we have run into as well. Async memory.high reclaim
helps, but when proactive reclaim does bigger steps and lowers the
limit below the async reclaim buffer, the workload can still enter
direct reclaim. This is undesirable.

> Another issue with memory.high is that it is not delegatable. To
> actually use this interface for uswapd, the application has to introduce
> another layer of cgroup on whose memory.high it has write access.

Fair enough.

I would generalize that and say that limiting the maximum container
size and driving proactive reclaim are separate jobs, with separate
goals, happening at different layers of the system. Sharing a single
control knob for that can be a coordination nightmare.

> 2) Why uswapd safe from self induced reclaim?
> 
> This is very similar to the scenario of oomd under global memory
> pressure. We can use the similar mechanisms to protect uswapd from self
> induced reclaim i.e. memory.min and mlock.

Agreed.

> Interface options:
> ------------------
> 
> Introducing a very simple memcg interface 'echo 10M > memory.reclaim' to
> trigger reclaim in the target memory cgroup.

This gets the assigning and attribution of targeted reclaim work right
(although it doesn't solve kswapd cycle attribution yet).

However, it also ditches the limit semantics, which themselves aren't
actually a problem. And indeed I would argue have some upsides.

As per above, the kernel knows best when and how much to reclaim to
match the allocation rate, since it's in control of the allocation
path. To do proactive reclaim with the memory.reclaim interface, you
would need to monitor memory consumption closely. Workloads may not
allocate anything for hours, and then suddenly allocate gigabytes
within seconds. A sudden onset of streaming reads through the
filesystem could destroy the workingset measurements, whereas a limit
would catch it and do drop-behind (and thus workingset sampling) at
the exact rate of allocations.

Again I believe something that may be doable as a hyperscale operator,
but likely too fragile to get wider applications beyond that.

My take is that a proactive reclaim feature, whose goal is never to
thrash or punish but to keep the LRUs warm and the workingset trimmed,
would ideally have:

- a pressure or size target specified by userspace but with
  enforcement driven inside the kernel from the allocation path

- the enforcement work NOT be done synchronously by the workload
  (something I'd argue we want for *all* memory limits)

- the enforcement work ACCOUNTED to the cgroup, though, since it's the
  cgroup's memory allocations causing the work (again something I'd
  argue we want in general)

- a delegatable knob that is independent of setting the maximum size
  of a container, as that expresses a different type of policy

- if size target, self-limiting (ha) enforcement on a pressure
  threshold or stop enforcement when the userspace component dies

Thoughts?
