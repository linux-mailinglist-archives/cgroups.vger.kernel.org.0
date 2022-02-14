Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7066E4B575E
	for <lists+cgroups@lfdr.de>; Mon, 14 Feb 2022 17:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356575AbiBNQq1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Feb 2022 11:46:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356867AbiBNQqN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Feb 2022 11:46:13 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278CD60D9E
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 08:46:02 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id o25so14851415qkj.7
        for <cgroups@vger.kernel.org>; Mon, 14 Feb 2022 08:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QeA+W5UTyGJnefg3/KfG82NxGUq6cPYrEgrwO7WmFzM=;
        b=5yIaMy4IIema7swz7szhTLQYzc7X1qKWeHs6ELx7V9WGKbrNr1ofviMV6o/sHSGbrc
         uLfdlz7wGzHoatYQxr5nUEpWoHnlhNVKoTx2HouziKIlrkfigiEHFIAPKTW2HrjBuAlH
         4XFgAruRhogInTYSVI6dL1oi1lzUBa6OiLOPwPpiwEJ+mjzCzdvNHNo4W/69YIyRh4ry
         AcHDh7S5iqjBNQRDfnJKvNm47fbVELJEri4BTe97JKH0o/AeRL4VFBF96C7RsZLgoXYX
         tr9X6J3+CGE9dz+4WrXcat40YjfIU8NbRMCgfq79U/Ui5WuIUUBNYdkLypy9vVxwo7LK
         hDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QeA+W5UTyGJnefg3/KfG82NxGUq6cPYrEgrwO7WmFzM=;
        b=PwgI9uKvLZxTo1UdZGT9UrLvOqWhDle9HSv/LOCiU6WeSxMA0kEnLaT92GsBvimAfr
         zpC7t5dtfmItBDQdN7HVAF/L5G+JJ+wDVx0AyIcbeMQt4UbtvBQRSbnT1iasHgHw27Jf
         dkuGLzjJplVQs8sxw1QkrnUwlN1yxe+s8nubYXGAvyp6grvXCVniAlGfM2RrjVolZtqg
         w0/V+Sym9SywwP6s5VMyQjYTdfcJPynq5Hcf7N8j0BkyI4cLiol/ZEMxVzkVWfM8SQbA
         mDObAGs69ajPW9/AoXyjTsRcsZDS1zJ5ngxqPCErr9WgyfUvds2NlmO18pNl6ADyU+1H
         EMUQ==
X-Gm-Message-State: AOAM532urVKq/Rhh7Dk+KmaeAdnVHJEFhoBVloBkfZf4qv/SyfeTtPQ3
        E+bDcCzOUuwjl02qEUcceN3ENQ==
X-Google-Smtp-Source: ABdhPJxaRpxsUPimstp80kDcnPMfUAmF6zMUOF3LhZJ+Y50hwjdMTKk9P406wXzEc4+JKmL68OY1zw==
X-Received: by 2002:a05:620a:4546:: with SMTP id u6mr308674qkp.598.1644857161326;
        Mon, 14 Feb 2022 08:46:01 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id q22sm18799175qtw.52.2022.02.14.08.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 08:46:01 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:46:00 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 3/4] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YgqHSIa/WvJSXERe@cmpxchg.org>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211223537.2175879-4-bigeasy@linutronix.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 11, 2022 at 11:35:36PM +0100, Sebastian Andrzej Siewior wrote:
> The per-CPU counter are modified with the non-atomic modifier. The
> consistency is ensured by disabling interrupts for the update.
> On non PREEMPT_RT configuration this works because acquiring a
> spinlock_t typed lock with the _irq() suffix disables interrupts. On
> PREEMPT_RT configurations the RMW operation can be interrupted.
> 
> Another problem is that mem_cgroup_swapout() expects to be invoked with
> disabled interrupts because the caller has to acquire a spinlock_t which
> is acquired with disabled interrupts. Since spinlock_t never disables
> interrupts on PREEMPT_RT the interrupts are never disabled at this
> point.
> 
> The code is never called from in_irq() context on PREEMPT_RT therefore
> disabling preemption during the update is sufficient on PREEMPT_RT.
> The sections which explicitly disable interrupts can remain on
> PREEMPT_RT because the sections remain short and they don't involve
> sleeping locks (memcg_check_events() is doing nothing on PREEMPT_RT).
> 
> Disable preemption during update of the per-CPU variables which do not
> explicitly disable interrupts.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  mm/memcontrol.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c1caa662946dc..466466f285cea 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -705,6 +705,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>  	memcg = pn->memcg;
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();
>  	/* Update memcg */
>  	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
>  
> @@ -712,6 +714,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
>  
>  	memcg_rstat_updated(memcg, val);
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_enable();
>  }

I notice you didn't annoate __mod_memcg_state(). I suppose that is
because it's called with explicit local_irq_disable(), and that
disables preemption on rt? And you only need another preempt_disable()
for stacks that rely on coming from spin_lock_irq(save)?

That makes sense, but it's difficult to maintain. It'll easily break
if somebody adds more memory accounting sites that may also rely on an
irq-disabled spinlock somewhere.

So better to make this an unconditional locking protocol:

static void memcg_stats_lock(void)
{
#ifdef CONFIG_PREEMPT_RT
	preempt_disable();
#else
	VM_BUG_ON(!irqs_disabled());
#endif
}

static void memcg_stats_unlock(void)
{
#ifdef CONFIG_PREEMPT_RT
	preempt_enable();
#endif
}

and always use these around the counter updates.
