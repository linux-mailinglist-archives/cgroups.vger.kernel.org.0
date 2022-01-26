Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCF449C117
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 03:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236187AbiAZCSD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jan 2022 21:18:03 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50824 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235987AbiAZCSD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jan 2022 21:18:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V2tKVfc_1643163477;
Received: from 30.21.164.198(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0V2tKVfc_1643163477)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jan 2022 10:17:58 +0800
Message-ID: <7f8a14be-762b-7ab8-4cef-1de6799d2dce@linux.alibaba.com>
Date:   Wed, 26 Jan 2022 10:17:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH] cpuset: Fix the bug that subpart_cpus updated wrongly in
 update_cpumask()
Content-Language: en-US
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
To:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220118100518.2381118-1-dtcccc@linux.alibaba.com>
In-Reply-To: <20220118100518.2381118-1-dtcccc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ping~
Any maintainer take a look?

On 2022/1/18 18:05, Tianchen Ding wrote:
> subparts_cpus should be limited as a subset of cpus_allowed, but it is
> updated wrongly by using cpumask_andnot(). Use cpumask_and() instead to
> fix it.
> 
> Fixes: ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>   kernel/cgroup/cpuset.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bb3531e7fda7..804ff5738c5f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1635,8 +1635,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 * Make sure that subparts_cpus is a subset of cpus_allowed.
>   	 */
>   	if (cs->nr_subparts_cpus) {
> -		cpumask_andnot(cs->subparts_cpus, cs->subparts_cpus,
> -			       cs->cpus_allowed);
> +		cpumask_and(cs->subparts_cpus, cs->subparts_cpus, cs->cpus_allowed);
>   		cs->nr_subparts_cpus = cpumask_weight(cs->subparts_cpus);
>   	}
>   	spin_unlock_irq(&callback_lock);

