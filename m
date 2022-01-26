Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7F749CDDC
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 16:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbiAZPUh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 10:20:37 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbiAZPUh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 10:20:37 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 52F5821136;
        Wed, 26 Jan 2022 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643210436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MVPJooxS63HNRIlS658e3iRyqgnX+uNa3dzCBUuD74s=;
        b=dDKvAH5+JEZr5MU/CK0fGHdnmiSPWzpIjSHUTtooVpBAbJSbTs3slFzRHp5ut07ZpIEcwQ
        zF2igFDbx9qby+qr9YIXOmKVgpkpxHMxWXTtA8w5Wb+YHzfuaT92huY6eBF+RUTHwkv2eF
        maLGRM+zutuUJqYAXjn6HrYwFNznypg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 37923A3B84;
        Wed, 26 Jan 2022 15:20:36 +0000 (UTC)
Date:   Wed, 26 Jan 2022 16:20:36 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Message-ID: <YfFmxH1IXeegNOa9@dhcp22.suse.cz>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125164337.2071854-4-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 25-01-22 17:43:36, Sebastian Andrzej Siewior wrote:
> The members of the per-CPU structure memcg_stock_pcp are protected
> either by disabling interrupts or by disabling preemption if the
> invocation occurred in process context.
> Disabling interrupts protects most of the structure excluding task_obj
> while disabling preemption protects only task_obj.
> This schema is incompatible with PREEMPT_RT because it creates atomic
> context in which actions are performed which require preemptible
> context. One example is obj_cgroup_release().
> 
> The IRQ-disable and preempt-disable sections can be replaced with
> local_lock_t which preserves the explicit disabling of interrupts while
> keeps the code preemptible on PREEMPT_RT.
> 
> The task_obj has been added for performance reason on non-preemptible
> kernels where preempt_disable() is a NOP. On the PREEMPT_RT preemption
> model preempt_disable() is always implemented. Also there are no memory
> allocations in_irq() context and softirqs are processed in (preemptible)
> process context. Therefore it makes sense to avoid using task_obj.
> 
> Don't use task_obj on PREEMPT_RT and replace manual disabling of
> interrupts with a local_lock_t. This change requires some factoring:
> 
> - drain_obj_stock() drops a reference on obj_cgroup which leads to an
>   invocation of obj_cgroup_release() if it is the last object. This in
>   turn leads to recursive locking of the local_lock_t. To avoid this,
>   obj_cgroup_release() is invoked outside of the locked section.
> 
> - drain_obj_stock() gets a memcg_stock_pcp passed if the stock_lock has been
>   acquired (instead of the task_obj_lock) to avoid recursive locking later
>   in refill_stock().
> 
> - drain_all_stock() disables preemption via get_cpu() and then invokes
>   drain_local_stock() if it is the local CPU to avoid scheduling a worker
>   (which invokes the same function). Disabling preemption here is
>   problematic due to the sleeping locks in drain_local_stock().
>   This can be avoided by always scheduling a worker, even for the local
>   CPU. Using cpus_read_lock() stabilizes cpu_online_mask which ensures
>   that no worker is scheduled for an offline CPU. Since there is no
>   flush_work(), it is still possible that a worker is invoked on the wrong
>   CPU but it is okay since it operates always on the local-CPU data.
> 
> - drain_local_stock() is always invoked as a worker so it can be optimized
>   by removing in_task() (it is always true) and avoiding the "irq_save"
>   variant because interrupts are always enabled here. Operating on
>   task_obj first allows to acquire the lock_lock_t without lockdep
>   complains.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I do not see any obvious problem with this patch. The code is ugly as
hell, though, but a large part of that is because of the weird locking
scheme we already have. I've had a look at 559271146efc ("mm/memcg:
optimize user context object stock access") and while I agree that it
makes sense to optimize for user context I do not really see any numbers
justifying the awkward locking scheme. Is this complexity really worth
it?
-- 
Michal Hocko
SUSE Labs
