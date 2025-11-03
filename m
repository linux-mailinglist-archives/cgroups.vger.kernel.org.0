Return-Path: <cgroups+bounces-11481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F188EC29E58
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 03:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4F684EA0F1
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 02:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0DA2874E9;
	Mon,  3 Nov 2025 02:56:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3A286887;
	Mon,  3 Nov 2025 02:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762138613; cv=none; b=qqVNV9w4PM6gC+tMklMhIWqiKfTD4snQ3W2p/CcQ501UdzVOe6yrvT0ZUmVokEWxo8jocTPAwN8LtKruWKPMXtPvNoxEVFUNBrsCx8bOwxRqvTS8e5kA5Ji7aEg0kNp5f1IA/rSdymMdB7+JwrWru16tZ5+ASweF452+Mk1p/0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762138613; c=relaxed/simple;
	bh=Li2Y5ViLOwdmo7AahR2So4fNyrxRb9RAKN8qSFD5SA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cu29HTXxR4NLLkfmMg1Xc/hUPWAbn0EiciEGxyMgPTZ/DTLnDeGcuBt2ez28gWkzAeB8K7dBZmKjp4zZemXd8fA+/FT76ypYkxw6xG65EmlWvlWwPjR2xwWcaH616LAtMPkmDRA4SeTnK3Nwav5LD7hyxJWWt8ejeT6WNcCWCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d0GSh0dqdzYQtrv;
	Mon,  3 Nov 2025 10:56:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C62FE1A17CC;
	Mon,  3 Nov 2025 10:56:48 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgBHjuLwGQhp6oLlCQ--.29120S2;
	Mon, 03 Nov 2025 10:56:48 +0800 (CST)
Message-ID: <d8726de9-55ad-49b0-a434-cc580ebc3ea5@huaweicloud.com>
Date: Mon, 3 Nov 2025 10:56:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 1/3] cgroup/cpuset: Rename
 update_unbound_workqueue_cpumask() to update_isolation_cpumasks()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-2-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251103013411.239610-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBHjuLwGQhp6oLlCQ--.29120S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJF4Dur45trykuFyrXw1kZrb_yoW5tF1Dpr
	y5CFWIkayxtw45uas8JFsFgr4xKw4Dt3ZFywnrXr1ftFyaqwn7Aw1UKFs0qr4rXr98Gr45
	ZFWqvrsrXr40kwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/3 9:34, Waiman Long wrote:
> From: Gabriele Monaco <gmonaco@redhat.com>
> 
> update_unbound_workqueue_cpumask() updates unbound workqueues settings
> when there's a change in isolated CPUs, but it can be used for other
> subsystems requiring updated when isolated CPUs change.
> 
> Generalise the name to update_isolation_cpumasks() to prepare for other
> functions unrelated to workqueues to be called in that spot.
> 
> [longman: Change the function name to update_isolation_cpumasks()]
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Acked-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7aef59ea9627..da770dac955e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1393,7 +1393,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>  	return isolcpus_updated;
>  }
>  
> -static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
> +static void update_isolation_cpumasks(bool isolcpus_updated)
>  {
>  	int ret;
>  
> @@ -1557,7 +1557,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  	list_add(&cs->remote_sibling, &remote_children);
>  	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_isolation_cpumasks(isolcpus_updated);
>  	cpuset_force_rebuild();
>  	cs->prs_err = 0;
>  
> @@ -1598,7 +1598,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>  	compute_excpus(cs, cs->effective_xcpus);
>  	reset_partition_data(cs);
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_isolation_cpumasks(isolcpus_updated);
>  	cpuset_force_rebuild();
>  
>  	/*
> @@ -1667,7 +1667,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  	if (xcpus)
>  		cpumask_copy(cs->exclusive_cpus, xcpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_isolation_cpumasks(isolcpus_updated);
>  	if (adding || deleting)
>  		cpuset_force_rebuild();
>  
> @@ -2011,7 +2011,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>  							tmp->delmask);
>  
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_isolation_cpumasks(isolcpus_updated);
>  
>  	if ((old_prs != new_prs) && (cmd == partcmd_update))
>  		update_partition_exclusive_flag(cs, new_prs);
> @@ -3029,7 +3029,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  	else if (isolcpus_updated)
>  		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
>  	spin_unlock_irq(&callback_lock);
> -	update_unbound_workqueue_cpumask(isolcpus_updated);
> +	update_isolation_cpumasks(isolcpus_updated);
>  
>  	/* Force update if switching back to member & update effective_xcpus */
>  	update_cpumasks_hier(cs, &tmpmask, !new_prs);

LGTM

Reviewed-by: Chen Ridong<chenridong@huawei.com>

-- 
Best regards,
Ridong


