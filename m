Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118F037281B
	for <lists+cgroups@lfdr.de>; Tue,  4 May 2021 11:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhEDJfS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhEDJfR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 05:35:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB03C061574;
        Tue,  4 May 2021 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nXlrBlO6thltfqcO3j1lyDgPNZ70D7N7dHT3PYTyMWc=; b=D8KSu7M20tDpfIcqTjK3oNrEM+
        hlZhC1i4wS5dOgoF4A3HbBYU85SbuxpC2yQaDxOdwwJ4I1pUJcNVfRwXtBFy+xZE2XPTbxNCzluIs
        JPgXCc92LT3lOTg8Na3zEpRBJkqHfpWtYcnvdT4YElYf+o34Jt1ie4PcO9RTZ1USAT+tuZxERMcjN
        h7sqym1dMWd75v4mNgYNn2YrUQ7BO94nw3HMQ80e42LCARRYfnACXx886G1Gvev1rRKczqepUdxwq
        rDFRKiEbn3O6sUDb4HvJJftV//2LaWJrh66/ty/1Oz8kDi7mW/s86XmdWXM+DqPEfAO+SL8y3gzov
        +uKRUnHQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1ldrQz-00GOlU-J7; Tue, 04 May 2021 09:33:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B44FD30022A;
        Tue,  4 May 2021 11:33:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6667E2026F4BA; Tue,  4 May 2021 11:33:40 +0200 (CEST)
Date:   Tue, 4 May 2021 11:33:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] sched/fair: Fix unfairness caused by missing load
 decay
Message-ID: <YJEU9FioWrdgS88F@hirez.programming.kicks-ass.net>
References: <20210501141950.23622-1-odin@uged.al>
 <20210501141950.23622-2-odin@uged.al>
 <CAKfTPtDmYcr82o4V=Hovc3+Ht4bqhj_NNiSG2Zm+CfdpcAX9iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDmYcr82o4V=Hovc3+Ht4bqhj_NNiSG2Zm+CfdpcAX9iA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 04, 2021 at 09:14:12AM +0200, Vincent Guittot wrote:
> On Sat, 1 May 2021 at 16:22, Odin Ugedal <odin@uged.al> wrote:
> >
> > This fixes an issue where old load on a cfs_rq is not properly decayed,
> > resulting in strange behavior where fairness can decrease drastically.
> > Real workloads with equally weighted control groups have ended up
> > getting a respective 99% and 1%(!!) of cpu time.
> >
> > When an idle task is attached to a cfs_rq by attaching a pid to a cgroup,
> > the old load of the task is attached to the new cfs_rq and sched_entity by
> > attach_entity_cfs_rq. If the task is then moved to another cpu (and
> > therefore cfs_rq) before being enqueued/woken up, the load will be moved
> > to cfs_rq->removed from the sched_entity. Such a move will happen when
> > enforcing a cpuset on the task (eg. via a cgroup) that force it to move.
> >
> > The load will however not be removed from the task_group itself, making
> > it look like there is a constant load on that cfs_rq. This causes the
> > vruntime of tasks on other sibling cfs_rq's to increase faster than they
> > are supposed to; causing severe fairness issues. If no other task is
> > started on the given cfs_rq, and due to the cpuset it would not happen,
> > this load would never be properly unloaded. With this patch the load
> > will be properly removed inside update_blocked_averages. This also
> > applies to tasks moved to the fair scheduling class and moved to another
> > cpu, and this path will also fix that. For fork, the entity is queued
> > right away, so this problem does not affect that.
> >
> > This applies to cases where the new process is the first in the cfs_rq,
> > issue introduced 3d30544f0212 ("sched/fair: Apply more PELT fixes"), and
> > when there has previously been load on the cgroup but the cgroup was
> > removed from the leaflist due to having null PELT load, indroduced
> > in 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing
> > path").
> >
> > For a simple cgroup hierarchy (as seen below) with two equally weighted
> > groups, that in theory should get 50/50 of cpu time each, it often leads
> > to a load of 60/40 or 70/30.
> >
> > parent/
> >   cg-1/
> >     cpu.weight: 100
> >     cpuset.cpus: 1
> >   cg-2/
> >     cpu.weight: 100
> >     cpuset.cpus: 1
> >
> > If the hierarchy is deeper (as seen below), while keeping cg-1 and cg-2
> > equally weighted, they should still get a 50/50 balance of cpu time.
> > This however sometimes results in a balance of 10/90 or 1/99(!!) between
> > the task groups.
> >
> > $ ps u -C stress
> > USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> > root       18568  1.1  0.0   3684   100 pts/12   R+   13:36   0:00 stress --cpu 1
> > root       18580 99.3  0.0   3684   100 pts/12   R+   13:36   0:09 stress --cpu 1
> >
> > parent/
> >   cg-1/
> >     cpu.weight: 100
> >     sub-group/
> >       cpu.weight: 1
> >       cpuset.cpus: 1
> >   cg-2/
> >     cpu.weight: 100
> >     sub-group/
> >       cpu.weight: 10000
> >       cpuset.cpus: 1
> >
> > This can be reproduced by attaching an idle process to a cgroup and
> > moving it to a given cpuset before it wakes up. The issue is evident in
> > many (if not most) container runtimes, and has been reproduced
> > with both crun and runc (and therefore docker and all its "derivatives"),
> > and with both cgroup v1 and v2.
> >
> > Fixes: 3d30544f0212 ("sched/fair: Apply more PELT fixes")
> > Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
> > Signed-off-by: Odin Ugedal <odin@uged.al>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
