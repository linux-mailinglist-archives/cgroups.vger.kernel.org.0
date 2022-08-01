Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0589586EF6
	for <lists+cgroups@lfdr.de>; Mon,  1 Aug 2022 18:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiHAQp6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 1 Aug 2022 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbiHAQp4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Aug 2022 12:45:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F741084;
        Mon,  1 Aug 2022 09:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CB0FB815B8;
        Mon,  1 Aug 2022 16:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A215C433C1;
        Mon,  1 Aug 2022 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659372353;
        bh=pX7cVWCOiiHtMKCUYXRUfASuBYlxu+7/tdxAAuxjyrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdGerin0vW2Af6UTgL4kPaMf6DXvN2ZyQDVQ/IenI4l39Fuk/vw/ujcKfhKWYW8OI
         6sPS++jA3O9B7yfUmMwJyPPSqddw/f3OJaQgkuGQE68hjOyO8QPvQGaep5J0LSwjZT
         dImiZrwlvdyunL1/LC1hrzv9bYVg/h5FqYkMuBJEQxpee/pmI2/SPevhFkvuBQI6Ac
         c+m29F74WH2tlqm0sZuEWYiDVx9BC5HqZiLjKtQ4igf78uUeCF4cBTFtLxPCfhLrhU
         qjkPql3Us+MkWcTNMAzOCG5kZsdOFhhy+jfhUHe60vZf3TabasmrqEPcex/fcRjHN8
         mD1qRNntbXufQ==
Date:   Mon, 1 Aug 2022 17:45:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Message-ID: <20220801164545.GA26471@willie-the-truck>
References: <20220801154124.2011987-1-longman@redhat.com>
 <20220801154124.2011987-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801154124.2011987-2-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 01, 2022 at 11:41:23AM -0400, Waiman Long wrote:
> The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
> Introduce task_struct::user_cpus_ptr to track requested affinity"). It
> is currently used only by arm64 arch due to possible asymmetric cpu
> setup. This patch extends its usage to save user provided cpumask when
> sched_setaffinity() is called for all arches.
> 
> To preserve the existing arm64 use case, a new cpus_affinity_set flag is
> added to differentiate if user_cpus_ptr is set up by sched_setaffinity()
> or by force_compatible_cpus_allowed_ptr(). user_cpus_ptr
> set by sched_setaffinity() has priority and won't be
> overwritten by force_compatible_cpus_allowed_ptr() or
> relax_compatible_cpus_allowed_ptr().
> 
> As a call to sched_setaffinity() will no longer clear user_cpus_ptr
> but set it instead, the SCA_USER flag is no longer necessary and can
> be removed.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sched.h |  1 +
>  kernel/sched/core.c   | 71 +++++++++++++++++++++++++++++++------------
>  kernel/sched/sched.h  |  1 -
>  3 files changed, 52 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c46f3a63b758..60ae022fa842 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -815,6 +815,7 @@ struct task_struct {
>  
>  	unsigned int			policy;
>  	int				nr_cpus_allowed;
> +	int				cpus_affinity_set;
>  	const cpumask_t			*cpus_ptr;
>  	cpumask_t			*user_cpus_ptr;
>  	cpumask_t			cpus_mask;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index da0bf6fe9ecd..7757828c7422 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2607,6 +2607,7 @@ int dup_user_cpus_ptr(struct task_struct *dst, struct task_struct *src,
>  		return -ENOMEM;
>  
>  	cpumask_copy(dst->user_cpus_ptr, src->user_cpus_ptr);
> +	dst->cpus_affinity_set = src->cpus_affinity_set;

I haven't been through this thorougly, but it looks a bit suspicious to me
to inherit this field directly across fork(). If a 64-bit task with this
flag set forks and then exec's a 32-bit program, arm64 will be in trouble if
we're not able to override the affinity forcefully.

Will
