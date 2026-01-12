Return-Path: <cgroups+bounces-13043-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB3D1067B
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 04:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2CED300B355
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 03:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2132D30595C;
	Mon, 12 Jan 2026 03:02:33 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB41FAD24;
	Mon, 12 Jan 2026 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768186953; cv=none; b=ivP7ZkjUGQn1ZKHJ9uAzkdXBnw57t/ui20AyxvOFJzAukPasxwL8cX0JEqeNDVU8t1/G0jB7Rbono/Hrx/lOlUUKkTK+iggrpv76XorXHJcGGbLeXc9y4DomTabIiH/9GNAa7aA1wGwh2lFDJSd1xe1iK9Xy+tku/pu2iudUiDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768186953; c=relaxed/simple;
	bh=aa/+CW4jHh7kiUBj2C2vwjVZB2sgzu05+yQnqZvPFYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUOhNUTsUDyPBq5W77ynjZ3qvSsaq/xcv/GkPaR5IubPN75ZwtOaPiyUTOBpA0FsNZNEC6xoC/ccNtHlIdZJg2N/LN3WqGhoP23kwvDkji7ZJ+rq++bGNPS1V8vr8las5AGf5+hjCqKHFNbhVVyYMWlrXIWu5FJ2x/7NTpfTxWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dqHGC0JtgzKHM0B;
	Mon, 12 Jan 2026 11:01:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 63FED4058D;
	Mon, 12 Jan 2026 11:02:27 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBH9fVBZGRp92z6DQ--.45356S2;
	Mon, 12 Jan 2026 11:02:27 +0800 (CST)
Message-ID: <7fe75baa-3270-48b5-bb79-ef79c964a135@huaweicloud.com>
Date: Mon, 12 Jan 2026 11:02:25 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: Treat cpusets in attaching as populated
To: longman@redhat.com, lizefan.x@bytedance.com, tj@kernel.org,
 hannes@cmpxchg.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>
Cc: cgroups@vger.kernel.org, stable@vger.kernel.org, lujialin4@huawei.com
References: <20260109112140.992393920@linuxfoundation.org>
 <20260112024257.1073959-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260112024257.1073959-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBH9fVBZGRp92z6DQ--.45356S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw48tF18Kr4DCF43Kr1fCrg_yoWrWFy3pF
	WDu3W7J3yUJ347Cws3G3WIg34rKw4kJF1UJr1ftw1rJFy7JF1jyr1DZ3ZIqry3JF97C3y8
	ZFsIvrs2g3ZFyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/12 10:42, Chen Ridong wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> 6.6-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Chen Ridong <chenridong@huawei.com>
> 
> [ Upstream commit b1bcaed1e39a9e0dfbe324a15d2ca4253deda316 ]
> 
> Currently, the check for whether a partition is populated does not
> account for tasks in the cpuset of attaching. This is a corner case
> that can leave a task stuck in a partition with no effective CPUs.
> 
> The race condition occurs as follows:
> 
> cpu0				cpu1
> 				//cpuset A  with cpu N
> migrate task p to A
> cpuset_can_attach
> // with effective cpus
> // check ok
> 
> // cpuset_mutex is not held	// clear cpuset.cpus.exclusive
> 				// making effective cpus empty
> 				update_exclusive_cpumask
> 				// tasks_nocpu_error check ok
> 				// empty effective cpus, partition valid
> cpuset_attach
> ...
> // task p stays in A, with non-effective cpus.
> 
> To fix this issue, this patch introduces cs_is_populated, which considers
> tasks in the attaching cpuset. This new helper is used in validate_change
> and partition_is_populated.
> 
> Fixes: e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/cgroup/cpuset.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index eadb028916c8..3c466e742751 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -453,6 +453,15 @@ static inline bool is_in_v2_mode(void)
>  	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>  }
>  
> +static inline bool cpuset_is_populated(struct cpuset *cs)
> +{
> +	lockdep_assert_held(&cpuset_mutex);
> +
> +	/* Cpusets in the process of attaching should be considered as populated */
> +	return cgroup_is_populated(cs->css.cgroup) ||
> +		cs->attach_in_progress;
> +}
> +
>  /**
>   * partition_is_populated - check if partition has tasks
>   * @cs: partition root to be checked
> @@ -465,21 +474,31 @@ static inline bool is_in_v2_mode(void)
>  static inline bool partition_is_populated(struct cpuset *cs,
>  					  struct cpuset *excluded_child)
>  {
> -	struct cgroup_subsys_state *css;
> -	struct cpuset *child;
> +	struct cpuset *cp;
> +	struct cgroup_subsys_state *pos_css;
>  
> -	if (cs->css.cgroup->nr_populated_csets)
> +	/*
> +	 * We cannot call cs_is_populated(cs) directly, as
> +	 * nr_populated_domain_children may include populated
> +	 * csets from descendants that are partitions.
> +	 */
> +	if (cs->css.cgroup->nr_populated_csets ||
> +	    cs->attach_in_progress)
>  		return true;
>  	if (!excluded_child && !cs->nr_subparts_cpus)
> -		return cgroup_is_populated(cs->css.cgroup);
> +		return cpuset_is_populated(cs);
>  

We should adjust this part to use cpuset_is_populated instead of cgroup_is_populated.

Thanks.

>  	rcu_read_lock();
> -	cpuset_for_each_child(child, css, cs) {
> -		if (child == excluded_child)
> +	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
> +		if (cp == cs || cp == excluded_child)
>  			continue;
> -		if (is_partition_valid(child))
> +
> +		if (is_partition_valid(cp)) {
> +			pos_css = css_rightmost_descendant(pos_css);
>  			continue;
> -		if (cgroup_is_populated(child->css.cgroup)) {
> +		}
> +
> +		if (cpuset_is_populated(cp)) {
>  			rcu_read_unlock();
>  			return true;
>  		}
> @@ -751,7 +770,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>  	 * be changed to have empty cpus_allowed or mems_allowed.
>  	 */
>  	ret = -ENOSPC;
> -	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
> +	if (cpuset_is_populated(cur)) {
>  		if (!cpumask_empty(cur->cpus_allowed) &&
>  		    cpumask_empty(trial->cpus_allowed))
>  			goto out;

-- 
Best regards,
Ridong


