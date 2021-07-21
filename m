Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF103D1155
	for <lists+cgroups@lfdr.de>; Wed, 21 Jul 2021 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbhGUNsQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jul 2021 09:48:16 -0400
Received: from foss.arm.com ([217.140.110.172]:55980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235762AbhGUNsQ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 21 Jul 2021 09:48:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A15331B;
        Wed, 21 Jul 2021 07:28:52 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC7453F73D;
        Wed, 21 Jul 2021 07:28:50 -0700 (PDT)
Date:   Wed, 21 Jul 2021 15:28:45 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] sched/isolation: Make HK_FLAG_DOMAIN mutable
Message-ID: <20210721142726.GA206211@e120877-lin.cambridge.arm.com>
References: <20210714135420.69624-1-frederic@kernel.org>
 <20210714135420.69624-6-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714135420.69624-6-frederic@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Frederic,

[...]

>  
> +// Only support HK_FLAG_DOMAIN for now
> +// TODO: propagate the changes through all interested subsystems:
> +// workqueues, net, pci; ...
> +void housekeeping_cpumask_set(struct cpumask *mask, enum hk_flags flags)
> +{
> +	/* Only HK_FLAG_DOMAIN change supported for now */
> +	if (WARN_ON_ONCE(flags != HK_FLAG_DOMAIN))
> +		return;
>  
> +	if (!static_key_enabled(&housekeeping_overridden.key)) {
> +		if (cpumask_equal(mask, cpu_possible_mask))
> +			return;
> +		if (WARN_ON_ONCE(!alloc_cpumask_var(&hk_domain_mask, GFP_KERNEL)))
> +			return;
> +		cpumask_copy(hk_domain_mask, mask);
> +		static_branch_enable(&housekeeping_overridden);

I get a warning here. static_branch_enable() is trying to take cpus_read_lock().
But the same lock is already taken by cpuset_write_u64().

Also, shouldn't it set HK_FLAG_DOMAIN in housekeeping_flags to enable
housekeeping if the kernel started without isolcpus="" ?

-- 
Vincent
