Return-Path: <cgroups+bounces-10624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED75ABCA3F0
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 18:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80B744EEC49
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE32264BA;
	Thu,  9 Oct 2025 16:51:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27591E51EE;
	Thu,  9 Oct 2025 16:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028667; cv=none; b=A1dMHEE2rux1SJajHhLZT0Jx3uI2lW5i+g6EJk/WQTEpoNgCucS6Lv9Ewsbvt9SRiZMEmqFuymiSF5bkN4DJ6h66Wy916MvBJjhHOMQPzduwMNR+ios+3co8YQfLy030xxXmJDmR3/q7e9hfj57aiNfrLOC+SJa8oY1U2jvRBrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028667; c=relaxed/simple;
	bh=3Eyiw6JDpn8V/snm9OAwBsRfFov9CTb9Tl+xjccfhu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPSbqMLRR1mc59PwulTh0FdzxGDIukim28QrnF612UXnz28pRO0A4QspRTJB0OPf9QDOXYAUBaGwp2YUfk1HWLBOqsp8oPSoEvC9Wx1swJK3mqyEPrPmLeF4GXsG60+wQQTJmnuKk/2txa7YsMliKNZbdcBMV72xva0JDBwdlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BD4F1762;
	Thu,  9 Oct 2025 09:50:53 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A81C03F66E;
	Thu,  9 Oct 2025 09:50:57 -0700 (PDT)
Message-ID: <e611b632-0156-4204-a748-78d44b2d14c8@arm.com>
Date: Thu, 9 Oct 2025 18:50:55 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] sched: Fold sched_class::switch{ing,ed}_{to,from}()
 into the change pattern
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
References: <20251006104402.946760805@infradead.org>
 <20251006104526.861755244@infradead.org>
 <02452879-8998-47e0-9679-d2ff00503901@arm.com>
 <20251009135408.GD4067720@noisy.programming.kicks-ass.net>
 <20251009140925.GD4068168@noisy.programming.kicks-ass.net>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20251009140925.GD4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09.10.25 16:09, Peter Zijlstra wrote:
> On Thu, Oct 09, 2025 at 03:54:08PM +0200, Peter Zijlstra wrote:
>> On Thu, Oct 09, 2025 at 03:30:02PM +0200, Dietmar Eggemann wrote:
>>> On 06.10.25 12:44, Peter Zijlstra wrote:
>>>> Add {DE,EN}QUEUE_CLASS and fold the sched_class::switch* methods into
>>>> the change pattern. This completes and makes the pattern more
>>>> symmetric.
>>>>
>>>> This changes the order of callbacks slightly:
>>>>
>>>> 				|
>>>> 				|  switching_from()
>>>>   dequeue_task();		|  dequeue_task()
>>>>   put_prev_task();		|  put_prev_task()
>>>> 				|  switched_from()
>>>> 				|
>>>>   ... change task ...		|  ... change task ...
>>>> 				|
>>>>   switching_to();		|  switching_to()
>>>>   enqueue_task();		|  enqueue_task()
>>>>   set_next_task();		|  set_next_task()
>>>>   prev_class->switched_from()	|
>>>>   switched_to()			|  switched_to()
>>>> 				|
>>>>
>>>> Notably, it moves the switched_from() callback right after the
>>>> dequeue/put. Existing implementations don't appear to be affected by
>>>> this change in location -- specifically the task isn't enqueued on the
>>>> class in question in either location.
>>>>
>>>> Make (CLASS)^(SAVE|MOVE), because there is nothing to save-restore
>>>> when changing scheduling classes.
>>>
>>> This one causes a DL bw related warning when I run a simple 1 DL task
>>> rt-app workload:
>>
>>> Not sure yet how this is related to switched_from_dl() being now called earlier?
>>
>> Ooh, I might see a problem. task_non_contending() uses dl_task(), which
>> uses p->prio. The move above means it is now called using the 'old'
>> prio, whereas it used to run with the 'new' prio.
>>
>> Let me see if I can figure out something for this.
> 
> Does this help? /me goes find rt-app.

Yes, but there seems to be more ... missing DEQUEUE_SAVE (a.k.a.
ENQUEUE_RESTORE) in

  enqueue_dl_entity()

    if (flags & (ENQUEUE_RESTORE|ENQUEUE_MIGRATING))
                 ^^^^^^^^^^^^^^^
      ...
      add_running_bw(dl_se, dl_rq)

and

  __sched_setscheduler()

    ...
    if (prev_class != next_class)
      queue_flags |= DEQUEUE_CLASS;
      queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
                       ^^^^^^^^^^^^

as well as

  sched_change_begin()

    ...
    if (flags & DEQUEUE_CLASS) {
      if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
        flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
                   ^^^^^^^^^^^^

With your patch and this the issue went away:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 884926d3dd95..35074799e9ad 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10844,9 +10844,6 @@ struct sched_change_ctx
*sched_change_begin(struct task_struct *p, unsigned int
        lockdep_assert_rq_held(rq);

        if (flags & DEQUEUE_CLASS) {
-               if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
-                       flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
-
                if (p->sched_class->switching_from)
                        p->sched_class->switching_from(rq, p);
        }
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 007d1440374b..bcef5c72d287 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -684,10 +684,8 @@ int __sched_setscheduler(struct task_struct *p,
        prev_class = p->sched_class;
        next_class = __setscheduler_class(policy, newprio);

-       if (prev_class != next_class) {
+       if (prev_class != next_class)
                queue_flags |= DEQUEUE_CLASS;
-               queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
-       }

