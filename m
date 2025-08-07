Return-Path: <cgroups+bounces-9013-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44779B1D116
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 05:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CAB171651
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 03:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEE143164;
	Thu,  7 Aug 2025 03:00:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00642F56;
	Thu,  7 Aug 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754535657; cv=none; b=eOCp9nwuQ6Op6H8tzbOep5+b7mzItfHZCCKprO6/a65ozGDPsUq2aPITJ/N9xsfftZJmkb8Z6xwvZGBFA0ag9yhcPpPskh4kshb4a/0pwNe85VeLr8poRE5PoVk2Yp1LENTSYQHwUlculi5IPGrcVmPNOH7a/2t/LaIJEqaD5HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754535657; c=relaxed/simple;
	bh=cYzfB73HHBCb57qds4G+Khpfac7ttQf1tdJfrvxq2UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJr9eJaEAJMMCWMG0PIbTLTfH2iQB1WfojydMr8kfIxoJE5J4UJ1dmF0v6YIEwMe5/knokCSp0+A56k9IryuCezx8U41ewngW3pfCsnx8dgCJmDJX5Y9X5w1TOahwnjs07TorDI1k5S+wlCcdLnNROacHOkWqjlbBsmcYT4Msbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4byBMK4KCGzKHMsq;
	Thu,  7 Aug 2025 10:44:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id ABB471A018D;
	Thu,  7 Aug 2025 10:44:28 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAXkNoLE5RohM4kCw--.59688S2;
	Thu, 07 Aug 2025 10:44:28 +0800 (CST)
Message-ID: <38800495-464f-4bbf-b605-9a6b8d2b4c11@huaweicloud.com>
Date: Thu, 7 Aug 2025 10:44:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] cgroup/cpuset.c: Fix a partition error with CPU
 hotplug
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250806172430.1155133-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAXkNoLE5RohM4kCw--.59688S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1DZrW3Kr4DZr1xXF1xAFb_yoW5XFyUpF
	yjk3y7Cay5KF1UCa4Sqan29ayFgws7Ja1qyrnIqw4rAFy7J3WvyF4kJa95Xr1UWrWDGw1U
	Z390vr4SgF9rArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/8/7 1:24, Waiman Long wrote:
> It was found during testing that an invalid leaf partition with an
> empty effective exclusive CPU list can become a valid empty partition
> with no CPU afer an offline/online operation of an unrelated CPU. An
> empty partition root is allowed in the special case that it has no
> task in its cgroup and has distributed out all its CPUs to its child
> partitions. That is certainly not the case here.
> 
> The problem is in the cpumask_subsets() test in the hotplug case
> (update with no new mask) of update_parent_effective_cpumask() as it
> also returns true if the effective exclusive CPU list is empty. Fix that
> by addding the cpumask_empty() test to root out this exception case.
> Also add the cpumask_empty() test in cpuset_hotplug_update_tasks()
> to avoid calling update_parent_effective_cpumask() for this special case.
> 
> Fixes: 0c7f293efc87 ("cgroup/cpuset: Add cpuset.cpus.exclusive.effective for v2")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bf149246e001..d993e058a663 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1843,7 +1843,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  			if (is_partition_valid(cs))
>  				adding = cpumask_and(tmp->addmask,
>  						xcpus, parent->effective_xcpus);
> -		} else if (is_partition_invalid(cs) &&
> +		} else if (is_partition_invalid(cs) && !cpumask_empty(xcpus) &&
>  			   cpumask_subset(xcpus, parent->effective_xcpus)) {
>  			struct cgroup_subsys_state *css;
>  			struct cpuset *child;

This path looks good to me.

However, I found the update_parent_effective_cpumask function a bit difficult to follow due to its
complexity.

To improve readability, could we refactor the partcmd_enable, partcmd_disable, partcmd_update and
partcmd_invalidate logic into separate, well-defined function blocks?  I'd be happy to take
ownership of this refactoring work if you agree with the approach.

Best regards,
Ridong

> @@ -3870,9 +3870,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>  		partcmd = partcmd_invalidate;
>  	/*
>  	 * On the other hand, an invalid partition root may be transitioned
> -	 * back to a regular one.
> +	 * back to a regular one with a non-empty effective xcpus.
>  	 */
> -	else if (is_partition_valid(parent) && is_partition_invalid(cs))
> +	else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
> +		 !cpumask_empty(cs->effective_xcpus))
>  		partcmd = partcmd_update;
>  
>  	if (partcmd >= 0) {


