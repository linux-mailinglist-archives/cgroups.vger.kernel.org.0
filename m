Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9546949D01D
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 17:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiAZQ5Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 11:57:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51438 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbiAZQ5Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 11:57:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD373218F8;
        Wed, 26 Jan 2022 16:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643216234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3McJH9/soyjDGsp4lQ4WDb3Lp1cmKICM9yz0suAddps=;
        b=cLAh3kTg6YH2mjns+CgakIQCEYBwygZGFAjVifsaYEfSyZACiBw3lgIHsgMtKLsXBXryhj
        egW/JW0V5e116ht90lFaE441PuvGgBp++a980OIva1KUIwmXSRsYAe+9C+Gx3IpZyRtzBe
        OZHRFzRYtyR7iOmR3AENe0VrXAALha4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643216234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3McJH9/soyjDGsp4lQ4WDb3Lp1cmKICM9yz0suAddps=;
        b=d/ezpIRJ0s+H4pkw6fmafDzl1Bi4zJkzOM51iBovrsIs36OlEObcv9xuoDYSVUUZLoPSN/
        GZZwnKlYI3E2yJCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF3A813E2C;
        Wed, 26 Jan 2022 16:57:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 897vKWp98WErUAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 26 Jan 2022 16:57:14 +0000
Message-ID: <7f4928b8-16e2-88b3-2688-1519a19653a9@suse.cz>
Date:   Wed, 26 Jan 2022 17:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-4-bigeasy@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
In-Reply-To: <20220125164337.2071854-4-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/25/22 17:43, Sebastian Andrzej Siewior wrote:
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

Looks like this was maybe true in some previous version but now
drain_obj_stock() gets a bool parameter that is passed to
obj_cgroup_uncharge_pages(). But drain_local_stock() uses a NULL or
stock_pcp for that bool parameter which is weird.

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

The problem is that this pattern where get_obj_stock() sets a
stock_lock_acquried bool and this is passed down and acted upon elsewhere,
is a well known massive red flag for Linus :/
Maybe we should indeed just revert 559271146efc, as Michal noted there were
no hard numbers to justify it, and in previous discussion it seemed to
surface that the costs of irq disable/enable are not that bad on recent cpus
as assumed?

> ---
>  mm/memcontrol.c | 174 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 114 insertions(+), 60 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 3d1b7cdd83db0..2d8be88c00888 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -260,8 +260,10 @@ bool mem_cgroup_kmem_disabled(void)
>  	return cgroup_memory_nokmem;
>  }
>  
> +struct memcg_stock_pcp;

Seems this forward declaration is unused.

>  static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
> -				      unsigned int nr_pages);
> +				      unsigned int nr_pages,
> +				      bool stock_lock_acquried);
>  
>  static void obj_cgroup_release(struct percpu_ref *ref)
>  {
