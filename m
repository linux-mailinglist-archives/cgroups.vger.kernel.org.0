Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F2E580BB
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfF0KrV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 06:47:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbfF0KrV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 27 Jun 2019 06:47:21 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BD5B17F56BB173CBEBC9;
        Thu, 27 Jun 2019 18:47:15 +0800 (CST)
Received: from [10.133.206.78] (10.133.206.78) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Jun
 2019 18:47:11 +0800
Subject: Re: [PATCH] cgroup: provide a macro helper to iterate a cgroup's
 ancestors
To:     Peng Wang <rocking@whu.edu.cn>, <tj@kernel.org>,
        <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190627101901.26714-1-rocking@whu.edu.cn>
From:   Zefan Li <lizefan@huawei.com>
Message-ID: <0af30b27-3f09-bfa1-235a-d57b04570e8c@huawei.com>
Date:   Thu, 27 Jun 2019 18:47:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627101901.26714-1-rocking@whu.edu.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.206.78]
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2019/6/27 18:19, Peng Wang wrot:
> Use for_each_ancestor macro to iterate a cgroup's ancestors for clarity.> 

This patch doesn't make much sense to me. Because it does not reduce lines of code,
and I don't think it will reduce the size of the kernel, and the original code is
not bad in readability.

> Signed-off-by: Peng Wang <rocking@whu.edu.cn>
> ---
>   include/linux/cgroup.h  | 11 +++++++++++
>   kernel/cgroup/cgroup.c  |  7 +++----
>   kernel/cgroup/freezer.c |  2 +-
>   kernel/cgroup/rstat.c   |  4 ++--
>   4 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 0297f930a56e..00b0a16bbc30 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -298,6 +298,17 @@ void css_task_iter_end(struct css_task_iter *it);
>   			;						\
>   		else
>   
> +/**
> + * for_each_ancestor - iterate a cgroup's ancestors
> + * @tcgrp: the loop cursor
> + * @cgrp: cgroup whose ancestors to iterate
> + *
> + * Iterate ancestors of @cgrp.
> + */
> +#define for_each_ancestor(tcgrp, cgrp)					\
> +	for ((tcgrp) = cgroup_parent((cgrp)); (tcgrp);			\
> +		(tcgrp) = cgroup_parent((tcgrp)))
> +
>   /*
>    * Inline functions.
>    */
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index bf9dbffd46b1..32fa09679209 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -404,7 +404,7 @@ static bool cgroup_is_valid_domain(struct cgroup *cgrp)
>   		return false;
>   
>   	/* but the ancestors can't be unless mixable */
> -	while ((cgrp = cgroup_parent(cgrp))) {
> +	for_each_ancestor(cgrp, cgrp) {
>   		if (!cgroup_is_mixable(cgrp) && cgroup_is_thread_root(cgrp))
>   			return false;
>   		if (cgroup_is_threaded(cgrp))
> @@ -4987,8 +4987,7 @@ static void css_release_work_fn(struct work_struct *work)
>   			cgroup_rstat_flush(cgrp);
>   
>   		spin_lock_irq(&css_set_lock);
> -		for (tcgrp = cgroup_parent(cgrp); tcgrp;
> -		     tcgrp = cgroup_parent(tcgrp))
> +		for_each_ancestor(tcgrp, cgrp)
>   			tcgrp->nr_dying_descendants--;
>   		spin_unlock_irq(&css_set_lock);
>   
> @@ -5518,7 +5517,7 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
>   		parent->nr_threaded_children--;
>   
>   	spin_lock_irq(&css_set_lock);
> -	for (tcgrp = cgroup_parent(cgrp); tcgrp; tcgrp = cgroup_parent(tcgrp)) {
> +	for_each_ancestor(tcgrp, cgrp) {
>   		tcgrp->nr_descendants--;
>   		tcgrp->nr_dying_descendants++;
>   		/*
> diff --git a/kernel/cgroup/freezer.c b/kernel/cgroup/freezer.c
> index 8cf010680678..4dfc2f04a82d 100644
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -21,7 +21,7 @@ static void cgroup_propagate_frozen(struct cgroup *cgrp, bool frozen)
>   	 *
>   	 * Otherwise, all ancestor cgroups are forced into the non-frozen state.
>   	 */
> -	while ((cgrp = cgroup_parent(cgrp))) {
> +	for_each_ancestor(cgrp, cgrp) {
>   		if (frozen) {
>   			cgrp->freezer.nr_frozen_descendants += desc;
>   			if (!test_bit(CGRP_FROZEN, &cgrp->flags) &&
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index ca19b4c8acf5..58d352e0d76a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -49,8 +49,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
>   	raw_spin_lock_irqsave(cpu_lock, flags);
>   
>   	/* put @cgrp and all ancestors on the corresponding updated lists */
> -	for (parent = cgroup_parent(cgrp); parent;
> -	     cgrp = parent, parent = cgroup_parent(cgrp)) {
> +	for_each_ancestor(parent, cgrp) {
>   		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
>   		struct cgroup_rstat_cpu *prstatc = cgroup_rstat_cpu(parent, cpu);
>   
> @@ -63,6 +62,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
>   
>   		rstatc->updated_next = prstatc->updated_children;
>   		prstatc->updated_children = cgrp;
> +		cgrp = parent;
>   	}
>   
>   	raw_spin_unlock_irqrestore(cpu_lock, flags);
> 

