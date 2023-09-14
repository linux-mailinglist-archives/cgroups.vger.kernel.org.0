Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843117A1153
	for <lists+cgroups@lfdr.de>; Fri, 15 Sep 2023 00:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjINW6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 18:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjINW6v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 18:58:51 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44326BC
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 15:58:46 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563ab574cb5so1230481a12.1
        for <cgroups@vger.kernel.org>; Thu, 14 Sep 2023 15:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694732326; x=1695337126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OBvN087+LWsLjnRA9Q/StMUiztB5piJc+GOWYwv7hrg=;
        b=p3JssecyoEX9wuIVN0J7z8qmLVKXKzxNoq3mjO4yI95IflwOVTbu9mFZQjU0enJb/6
         sbOSw3kaCV3XPKw8/AbII/ly2LbVcY+50VKFZACDajJlsvLWnMto0bk3BxRJ/rdWdqHy
         iQ1W76kU69HA6FJ5IVeMNTFO0vsl22k5zRCy6K7mw4HLeJpMc9UuDCvZun/wsAkVD+s9
         ZkrrwT+BTSpcq9x7qn7ZSwbnxe0PIeHP281nueNpSMKRyzpkAsz7198rnLhoixgJxcDu
         nNSPPgNeC4jgHQ4MabFMPln+95ePlenHHRYtcmQsuajUyIrXmcQV+rFg82bgLZwko9xO
         it2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694732326; x=1695337126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBvN087+LWsLjnRA9Q/StMUiztB5piJc+GOWYwv7hrg=;
        b=cPyU6THpH5EYYPAOHEpENdQ/P7puKbuaKLIXagNd5e2cinOWz2dBsG4viXP1/WSYGt
         1OVTDQPL6KIYJWPcshHIx5dituaHT7heMF14x7Cmgp9mY+UKkN/selclndiQmH4JRyUM
         6ie511O9eU6/ZV3xDKyIHPUVYNa8UVY7gaickbRVpTwo4eakWSrG9ag6+pRsDqDmGtJ+
         aSw+d1udUEdi4SRr5ub3KLsd23JfoDcIrpCYMvzx11Upny2rgSGVDLSEVIROtrDz1ab2
         /NWZlAMRO9HYkB+ja7SNx9rUy2H6AYV8io33DjZOmPLdLGZA8Q9ZHdSCOWLaiovIwM2l
         NE1A==
X-Gm-Message-State: AOJu0YxxxZ8l+I5BBaNhbY0P03aRIHPPFyIgTZzVid4WVdtSzjrskeTe
        e4x+wQu3ZpWzg/Vo0X/h366OPiyhg9+uIw==
X-Google-Smtp-Source: AGHT+IEpNEc4jLhITi/avuNxdjVhmv5rK3VAkgg6J4TclKm4i8qSATiM+JZ1b0hGZt0buZsf8KqVFPQcOiYGIg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:6d8a:0:b0:578:1b5a:6367 with SMTP id
 i132-20020a636d8a000000b005781b5a6367mr19710pgc.12.1694732326211; Thu, 14 Sep
 2023 15:58:46 -0700 (PDT)
Date:   Thu, 14 Sep 2023 22:58:44 +0000
In-Reply-To: <CAJD7tkbb5zxEPSW6vvijDpQKCZiDcUJqe8SPvLHfo0RX7iHXAw@mail.gmail.com>
Mime-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
 <20230913073846.1528938-4-yosryahmed@google.com> <CALvZod6j5E2MXFz463LRcrP6XY8FedzLUKW88c=ZY39B6mYyMA@mail.gmail.com>
 <CAJD7tkbb5zxEPSW6vvijDpQKCZiDcUJqe8SPvLHfo0RX7iHXAw@mail.gmail.com>
Message-ID: <20230914225844.woz7mke6vnmwijh7@google.com>
Subject: Re: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and accuracy
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 14, 2023 at 10:56:52AM -0700, Yosry Ahmed wrote:
[...]
> >
> > 1. How much delayed/stale stats have you observed on real world workload?
> 
> I am not really sure. We don't have a wide deployment of kernels with
> rstat yet. These are problems observed in testing and/or concerns
> expressed by our userspace team.
> 

Why sleep(2) not good enough for the tests?

> I am trying to solve this now because any problems that result from
> this staleness will be very hard to debug and link back to stale
> stats.
> 

I think first you need to show if this (2 sec stale stats) is really a
problem.

> >
> > 2. What is acceptable staleness in the stats for your use-case?
> 
> Again, unfortunately I am not sure, but right now it can be O(seconds)
> which is not acceptable as we have workloads querying the stats every
> 1s (and sometimes more frequently).
> 

It is 2 seconds in most cases and if it is higher, the system is already
in bad shape. O(seconds) seems more dramatic. So, why 2 seconds
staleness is not acceptable? Is 1 second acceptable? or 500 msec? Let's
look at the use-cases below.

> >
> > 3. What is your use-case?
> 
> A few use cases we have that may be affected by this:
> - System overhead: calculations using memory.usage and some stats from
> memory.stat. If one of them is fresh and the other one isn't we have
> an inconsistent view of the system.
> - Userspace OOM killing: We use some stats in memory.stat to gauge the
> amount of memory that will be freed by killing a task as sometimes
> memory.usage includes shared resources that wouldn't be freed anyway.
> - Proactive reclaim: we read memory.stat in a proactive reclaim
> feedback loop, stale stats may cause us to mistakenly think reclaim is
> ineffective and prematurely stop.
> 

I don't see why userspace OOM killing and proactive reclaim need
subsecond accuracy. Please explain. Same for system overhead but I can
see the complication of two different sources for stats. Can you provide
the formula of system overhead? I am wondering why do you need to read
stats from memory.stat files. Why not the memory.current of top level
cgroups and /proc/meminfo be enough. Something like:

Overhead = MemTotal - MemFree - SumOfTopCgroups(memory.current)

> >
> > I know I am going back on some of the previous agreements but this
> > whole locking back and forth has made in question the original
> > motivation.
> 
> That's okay. Taking a step back, having flushing being indeterministic

I would say atmost 2 second stale instead of indeterministic.

> in this way is a time bomb in my opinion. Note that this also affects
> in-kernel flushers like reclaim or dirty isolation

Fix the in-kernel flushers separately. Also the problem Cloudflare is
facing does not need to be tied with this.
