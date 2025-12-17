Return-Path: <cgroups+bounces-12386-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 729E7CC5AC4
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 02:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1312300BBB9
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 01:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739FF23815D;
	Wed, 17 Dec 2025 01:10:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC16234964;
	Wed, 17 Dec 2025 01:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765933816; cv=none; b=Co5Judqxo1SKkYVdy8DS5dIKLRFsy1xKmD+O5Adn53O3OIg8X9vwgZ16PuUW3SNDCSabKpDRVW9nnB+WLz4c8JSq4os1lhUYng2lHjxXDOz0tLRgxy1+0NhBACH9/YwYheaBb18I2TuTRWcC9YSXhk+AFQvNXJ6KCV2soWJjzlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765933816; c=relaxed/simple;
	bh=ZLDTBuN2hE6tfqMqcaD1Ad2aoeMjR39bjNDuIOynwAY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fEo8xWmFFhNTvvkD3Fis6eS2VHz6BkyAyjgpwdFAMqDcwmFs5/guBsGaZ4fvC6KZmAcQyTzAkgWrN8OlaLKcUcEuiyyYNkeavXWKXJZuleCLuVJXxwV3FlojZBzx3oD787pGGxZXA1bKAH5tP/nLhvYyIe2P1tCOEv/BI3CXEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dWG1P0hHQzKHLyH;
	Wed, 17 Dec 2025 09:10:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 75BB740575;
	Wed, 17 Dec 2025 09:10:09 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXt_fwAkJpsYrSAQ--.19220S2;
	Wed, 17 Dec 2025 09:10:09 +0800 (CST)
Message-ID: <5cbfe54e-846a-4303-bb34-3a7b64a174f3@huaweicloud.com>
Date: Wed, 17 Dec 2025 09:10:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: fix warning when disabling remote partition
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251127030450.1611804-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251127030450.1611804-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXt_fwAkJpsYrSAQ--.19220S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr48Jr1xJFWrXF1fJr17GFg_yoW7Xw1rpF
	yUKr47GFWFgr1UCa47JF4xuw1rKanrAFWjywn3GryfJF17A3WvkFyjk398J345W3yDGry3
	Za4Dur4SqFnrAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/27 11:04, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> A warning was triggered as follows:
> 
> WARNING: kernel/cgroup/cpuset.c:1651 at remote_partition_disable+0xf7/0x110
> RIP: 0010:remote_partition_disable+0xf7/0x110
> RSP: 0018:ffffc90001947d88 EFLAGS: 00000206
> RAX: 0000000000007fff RBX: ffff888103b6e000 RCX: 0000000000006f40
> RDX: 0000000000006f00 RSI: ffffc90001947da8 RDI: ffff888103b6e000
> RBP: ffff888103b6e000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000001 R11: ffff88810b2e2728 R12: ffffc90001947da8
> R13: 0000000000000000 R14: ffffc90001947da8 R15: ffff8881081f1c00
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f55c8bbe0b2 CR3: 000000010b14c000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  update_prstate+0x2d3/0x580
>  cpuset_partition_write+0x94/0xf0
>  kernfs_fop_write_iter+0x147/0x200
>  vfs_write+0x35d/0x500
>  ksys_write+0x66/0xe0
>  do_syscall_64+0x6b/0x390
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f55c8cd4887
> 
> Reproduction steps (on a 16-CPU machine):
> 
>         # cd /sys/fs/cgroup/
>         # mkdir A1
>         # echo +cpuset > A1/cgroup.subtree_control
>         # echo "0-14" > A1/cpuset.cpus.exclusive
>         # mkdir A1/A2
>         # echo "0-14" > A1/A2/cpuset.cpus.exclusive
>         # echo "root" > A1/A2/cpuset.cpus.partition
>         # echo 0 > /sys/devices/system/cpu/cpu15/online
>         # echo member > A1/A2/cpuset.cpus.partition
> 
> When CPU 15 is offlined, subpartitions_cpus gets cleared because no CPUs
> remain available for the top_cpuset, forcing partitions to share CPUs with
> the top_cpuset. In this scenario, disabling the remote partition triggers
> a warning stating that effective_xcpus is not a subset of
> subpartitions_cpus. Partitions should be invalidated in this case to
> inform users that the partition is now invalid(cpus are shared with
> top_cpuset).
> 
> To fix this issue:
> 1. Only emit the warning only if subpartitions_cpus is not empty and the
>    effective_xcpus is not a subset of subpartitions_cpus.
> 2. During the CPU hotplug process, invalidate partitions if
>    subpartitions_cpus is empty.
> 
> Fixes: 4449b1ce46bf ("cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier() handle remote partition")

Fixes: f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check() & make update_cpumasks_hier()
handle remote partition")

Apologies, the correct fixes commit id should be f62a5d39368e. The earlier one might be from stale
code in my local repository.

Tj, could you please update the commit ID when applying this patch?

> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cpuset.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index fea577b4016a..fbe539d66d9b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1648,7 +1648,14 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>  {
>  	WARN_ON_ONCE(!is_remote_partition(cs));
> -	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
> +	/*
> +	 * When a CPU is offlined, top_cpuset may end up with no available CPUs,
> +	 * which should clear subpartitions_cpus. We should not emit a warning for this
> +	 * scenario: the hierarchy is updated from top to bottom, so subpartitions_cpus
> +	 * may already be cleared when disabling the partition.
> +	 */
> +	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus) &&
> +		     !cpumask_empty(subpartitions_cpus));
>  
>  	spin_lock_irq(&callback_lock);
>  	cs->remote_partition = false;
> @@ -3956,8 +3963,9 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>  	if (remote || (is_partition_valid(cs) && is_partition_valid(parent)))
>  		compute_partition_effective_cpumask(cs, &new_cpus);
>  
> -	if (remote && cpumask_empty(&new_cpus) &&
> -	    partition_is_populated(cs, NULL)) {
> +	if (remote && (cpumask_empty(subpartitions_cpus) ||
> +			(cpumask_empty(&new_cpus) &&
> +			 partition_is_populated(cs, NULL)))) {
>  		cs->prs_err = PERR_HOTPLUG;
>  		remote_partition_disable(cs, tmp);
>  		compute_effective_cpumask(&new_cpus, cs, parent);
> @@ -3970,9 +3978,12 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>  	 * 1) empty effective cpus but not valid empty partition.
>  	 * 2) parent is invalid or doesn't grant any cpus to child
>  	 *    partitions.
> +	 * 3) subpartitions_cpus is empty.
>  	 */
> -	if (is_local_partition(cs) && (!is_partition_valid(parent) ||
> -				tasks_nocpu_error(parent, cs, &new_cpus)))
> +	if (is_local_partition(cs) &&
> +	    (!is_partition_valid(parent) ||
> +	     tasks_nocpu_error(parent, cs, &new_cpus) ||
> +	     cpumask_empty(subpartitions_cpus)))
>  		partcmd = partcmd_invalidate;
>  	/*
>  	 * On the other hand, an invalid partition root may be transitioned

-- 
Best regards,
Ridong


