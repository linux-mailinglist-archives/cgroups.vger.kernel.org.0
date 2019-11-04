Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9922ED6B3
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2019 01:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbfKDArz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Nov 2019 19:47:55 -0500
Received: from foss.arm.com ([217.140.110.172]:33508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbfKDAry (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 3 Nov 2019 19:47:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1C1A1FB;
        Sun,  3 Nov 2019 16:47:53 -0800 (PST)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C4BA3F67D;
        Sun,  3 Nov 2019 16:47:52 -0800 (PST)
Subject: Re: [PATCH v2] sched/topology, cpuset: Account for housekeeping CPUs
 to avoid empty cpumasks
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Cc:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
References: <20191104003906.31476-1-valentin.schneider@arm.com>
Message-ID: <fbb03d7c-5599-a2ac-b3ac-30f91d440e18@arm.com>
Date:   Mon, 4 Nov 2019 00:47:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104003906.31476-1-valentin.schneider@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 04/11/2019 00:39, Valentin Schneider wrote:
> Michal noted that a cpuset's effective_cpus can be a non-empy mask, but
> because of the masking done with housekeeping_cpumask(HK_FLAG_DOMAIN)
> further down the line, we can still end up with an empty cpumask being
> passed down to partition_sched_domains_locked().
> 
> Do the proper thing and don't just check the mask is non-empty - check
> that its intersection with housekeeping_cpumask(HK_FLAG_DOMAIN) is
> non-empty.
> 
> Fixes: cd1cb3350561 ("sched/topology: Don't try to build empty sched domains")
> Reported-by: Michal Koutný <mkoutny@suse.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---

Sigh, this is missing:

v2 changes:
    - Fix broken diff

At least it *does* apply this time around.

>  kernel/cgroup/cpuset.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index c87ee6412b36..e4c10785dc7c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -798,8 +798,14 @@ static int generate_sched_domains(cpumask_var_t **domains,
>  		    cpumask_subset(cp->cpus_allowed, top_cpuset.effective_cpus))
>  			continue;
>  
> +		/*
> +		 * Skip cpusets that would lead to an empty sched domain.
> +		 * That could be because effective_cpus is empty, or because
> +		 * it's only spanning CPUs outside the housekeeping mask.
> +		 */
>  		if (is_sched_load_balance(cp) &&
> -		    !cpumask_empty(cp->effective_cpus))
> +		    cpumask_intersects(cp->effective_cpus,
> +				       housekeeping_cpumask(HK_FLAG_DOMAIN)))
>  			csa[csn++] = cp;
>  
>  		/* skip @cp's subtree if not a partition root */
> 
