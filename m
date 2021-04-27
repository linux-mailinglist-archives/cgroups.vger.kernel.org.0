Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123C236C7B5
	for <lists+cgroups@lfdr.de>; Tue, 27 Apr 2021 16:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbhD0O07 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Apr 2021 10:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbhD0O06 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Apr 2021 10:26:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216AAC061574
        for <cgroups@vger.kernel.org>; Tue, 27 Apr 2021 07:26:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j5so58723885wrn.4
        for <cgroups@vger.kernel.org>; Tue, 27 Apr 2021 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=tsLEq65WPKHRwU8rIMWjygbXMsjIHkGUMZ3Ia5QeHAw=;
        b=vxoNyU80KxxiBotb0lzjxlUzkwvkfWvuC8wvl+fAljbT8jvboVaOZTyTmoBBkVYEy8
         ODF18O5VwyagVT62PXJy8ixj23oSXmuh1KLUwKFguIPsnOLkhWeWUapx3ecC6VOb9UpO
         VclnghnBwzwggXYn/U8vznLQeKPRibZYBIl7aIqvEU2gPrjUG0nFbAo3w9VfsAKbB7hB
         qPmOZDXpkvZWQxouq7kGlCKcM/DGcjs++xKMIx+COAJqRPPI4J4iQ0bVFs10x0XSbz/m
         6DstotHlMNmCPVtifdBKbg5L7BDZ2JC3cLpY1c6gmLD2+z5m2nVeY4CCzdkVTNy6sjtu
         jnmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=tsLEq65WPKHRwU8rIMWjygbXMsjIHkGUMZ3Ia5QeHAw=;
        b=TpaGkCUQt4+HbJ11hp/OHSnqGY+e0nxuOu25ktpPPUoH8cfrCQ3YcpwYRgFK6BZvzO
         DLIgEmCe+ZGYfh/xvvrygc94q6tgeG+7QEHkrN4Bpp8komHJVVSyyj07wWzaU3a+2sNO
         ChYLmkWTs03VX6cj/SlunAMrQdtqNPj7ZrOtmz1svbs3eSAsJlGLqj5oQFYN4F0xoiG+
         HMuRcscveGB3Eh7jK4UqvdlTx7oj/gZEaFq2bIboG6ceRYK2Wv8Nng3/ZEF1fTB3fhOo
         +BG0IeRX6NpKgPAzpYBM2pFvKEA9mY/BXZLZVS+19uEALl1JP+5MnPxEnPMZukceNxuE
         dxSw==
X-Gm-Message-State: AOAM532u+3B8ym/n5K6haBoqXm7Sp3BMhZTzrDjCqOUd+DfqpPndHeY3
        U7FD6SzEFEnln0Rfv2DIg905bw==
X-Google-Smtp-Source: ABdhPJwec6hRUNjWSCxJ83wJL/+1rOqso5Ax4Ulzh5tpeJnc5TPLZU2HmP4+HzqqbtHxvWskg3j1Cg==
X-Received: by 2002:adf:9011:: with SMTP id h17mr29521491wrh.384.1619533573779;
        Tue, 27 Apr 2021 07:26:13 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:9db3:7ea6:7c21:e08])
        by smtp.gmail.com with ESMTPSA id x25sm2853368wmj.34.2021.04.27.07.26.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Apr 2021 07:26:13 -0700 (PDT)
Date:   Tue, 27 Apr 2021 16:26:11 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] sched/fair: Fix unfairness caused by missing load
 decay
Message-ID: <20210427142611.GA22056@vingu-book>
References: <20210425080902.11854-1-odin@uged.al>
 <20210425080902.11854-2-odin@uged.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210425080902.11854-2-odin@uged.al>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Le dimanche 25 avril 2021 à 10:09:02 (+0200), Odin Ugedal a écrit :
> This fixes an issue where old load on a cfs_rq is not properly decayed,
> resulting in strange behavior where fairness can decrease drastically.
> Real workloads with equally weighted control groups have ended up
> getting a respective 99% and 1%(!!) of cpu time.
> 
> When an idle task is attached to a cfs_rq by attaching a pid to a cgroup,
> the old load of the task is attached to the new cfs_rq and sched_entity by
> attach_entity_cfs_rq. If the task is then moved to another cpu (and
> therefore cfs_rq) before being enqueued/woken up, the load will be moved
> to cfs_rq->removed from the sched_entity. Such a move will happen when
> enforcing a cpuset on the task (eg. via a cgroup) that force it to move.

Would be good to mention that the problem happens only if the new cfs_rq has
been removed from the leaf_cfs_rq_list because its PELT metrics were already
null. In such case __update_blocked_fair() never updates the blocked load of
the new cfs_rq and never propagate the removed load in the hierarchy.

> 
> The load will however not be removed from the task_group itself, making
> it look like there is a constant load on that cfs_rq. This causes the
> vruntime of tasks on other sibling cfs_rq's to increase faster than they
> are supposed to; causing severe fairness issues. If no other task is
> started on the given cfs_rq, and due to the cpuset it would not happen,
> this load would never be properly unloaded. With this patch the load
> will be properly removed inside update_blocked_averages. This also
> applies to tasks moved to the fair scheduling class and moved to another
> cpu, and this path will also fix that. For fork, the entity is queued
> right away, so this problem does not affect that.
> 
> For a simple cgroup hierarchy (as seen below) with two equally weighted
> groups, that in theory should get 50/50 of cpu time each, it often leads
> to a load of 60/40 or 70/30.
> 
> parent/
>   cg-1/
>     cpu.weight: 100
>     cpuset.cpus: 1
>   cg-2/
>     cpu.weight: 100
>     cpuset.cpus: 1
> 
> If the hierarchy is deeper (as seen below), while keeping cg-1 and cg-2
> equally weighted, they should still get a 50/50 balance of cpu time.
> This however sometimes results in a balance of 10/90 or 1/99(!!) between
> the task groups.
> 
> $ ps u -C stress
> USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
> root       18568  1.1  0.0   3684   100 pts/12   R+   13:36   0:00 stress --cpu 1
> root       18580 99.3  0.0   3684   100 pts/12   R+   13:36   0:09 stress --cpu 1
> 
> parent/
>   cg-1/
>     cpu.weight: 100
>     sub-group/
>       cpu.weight: 1
>       cpuset.cpus: 1
>   cg-2/
>     cpu.weight: 100
>     sub-group/
>       cpu.weight: 10000
>       cpuset.cpus: 1
> 
> This can be reproduced by attaching an idle process to a cgroup and
> moving it to a given cpuset before it wakes up. The issue is evident in
> many (if not most) container runtimes, and has been reproduced
> with both crun and runc (and therefore docker and all its "derivatives"),
> and with both cgroup v1 and v2.
> 
> Fixes: 3d30544f0212 ("sched/fair: Apply more PELT fixes")

The fix tag should be :
Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")

This patch re-introduced the del of idle cfs_rq from leaf_cfs_rq_list in order to
skip useless update of blocked load.


> Signed-off-by: Odin Ugedal <odin@uged.al>
> ---
>  kernel/sched/fair.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 794c2cb945f8..ad7556f99b4a 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10916,6 +10916,19 @@ static void attach_task_cfs_rq(struct task_struct *p)
>  
>  	if (!vruntime_normalized(p))
>  		se->vruntime += cfs_rq->min_vruntime;
> +
> +	/*
> +	 * Make sure the attached load will decay properly
> +	 * in case the task is moved to another cpu before
> +	 * being queued.
> +	 */
> +	if (!task_on_rq_queued(p)) {
> +		for_each_sched_entity(se) {
> +			if (se->on_rq)
> +				break;
> +			list_add_leaf_cfs_rq(cfs_rq_of(se));
> +		}
> +	}

propagate_entity_cfs_rq() already goes across the tg tree to
propagate the attach/detach.

would be better to call list_add_leaf_cfs_rq(cfs_rq)  inside this function
instead of looping twice the tg tree. Something like:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 33b1ee31ae0f..18441ce7316c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11026,10 +11026,10 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
        for_each_sched_entity(se) {
                cfs_rq = cfs_rq_of(se);

-               if (cfs_rq_throttled(cfs_rq))
-                       break;
+               if (!cfs_rq_throttled(cfs_rq))
+                       update_load_avg(cfs_rq, se, UPDATE_TG);

-               update_load_avg(cfs_rq, se, UPDATE_TG);
+               list_add_leaf_cfs_rq(cfs_rq);
        }
 }
 #else


>
>  }
>  
>  static void switched_from_fair(struct rq *rq, struct task_struct *p)
> -- 
> 2.31.1
> 
