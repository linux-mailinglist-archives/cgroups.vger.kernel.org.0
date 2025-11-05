Return-Path: <cgroups+bounces-11582-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 293A8C340E6
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 07:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBFF189C4AA
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 06:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CE9266B72;
	Wed,  5 Nov 2025 06:30:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539112C0276;
	Wed,  5 Nov 2025 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762324202; cv=none; b=UATP/Gk/esx1aGnxwz9dcXpddRFzcdZq69RfDTX1xchSLLMGTq/CbzNKmU/HwQdAlVNnEMwKlRVkR+1pmXx6lZanBm0etQUQqiOp48gN1nJ44MeX/+v+IEgMvbDYTJZ0Gn4ubz0YqweD0tWVBcoQkXTrVhQReAbQXq/6iqQPwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762324202; c=relaxed/simple;
	bh=+sjbq3hSIRJJOCJlSyIYGY4niIf1RklwToUJJv5n3hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4k8RwwtsRGwX2TDYo70AoljFUeLUug2/VBbU7WO5AZWgvwe+DFX2iedrJTovjzbUgmtnm8qv+zEbgY0f+f5rm0Ai/yLTTbw+yyukIe9mYmnvS/jynZ+6ZCknfkoWkN3GQrnIFEcfxluT1BSHNa+NOC55RfRBj98XHSvqWybAkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d1b5c5QzqzYQv7l;
	Wed,  5 Nov 2025 14:29:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0CA5F1A0A22;
	Wed,  5 Nov 2025 14:29:57 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgB3GkPj7gppiVIPCw--.2186S2;
	Wed, 05 Nov 2025 14:29:56 +0800 (CST)
Message-ID: <c1104fa0-10b6-4878-8296-8502c0105b83@huaweicloud.com>
Date: Wed, 5 Nov 2025 14:29:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH v3 4/5] cgroup/cpuset: Ensure domain
 isolated CPUs stay in root or isolated partition
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251105043848.382703-1-longman@redhat.com>
 <20251105043848.382703-5-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251105043848.382703-5-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgB3GkPj7gppiVIPCw--.2186S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr45Cr47WF15Gw4fKF17Wrg_yoW5AFWUpF
	yjkry3J3y5tr13C3sIq3Z29ryFga1DJF12krs8Gw1rX3ZFq3WvkFyj9ws8Xr15Xa9rWr1U
	Zay5ur4SgasrArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/5 12:38, Waiman Long wrote:
> Commit 4a74e418881f ("cgroup/cpuset: Check partition conflict with
> housekeeping setup") is supposed to ensure that domain isolated CPUs
> designated by the "isolcpus" boot command line option stay either in
> root partition or in isolated partitions. However, the required check
> wasn't implemented when a remote partition was created or when an
> existing partition changed type from "root" to "isolated".
> 
> Even though this is a relatively minor issue, we still need to add the
> required prstate_housekeeping_conflict() call in the right places to
> ensure that the rule is strictly followed.
> 
> The following steps can be used to reproduce the problem before this
> fix.
> 
>   # fmt -1 /proc/cmdline | grep isolcpus
>   isolcpus=9
>   # cd /sys/fs/cgroup/
>   # echo +cpuset > cgroup.subtree_control
>   # mkdir test
>   # echo 9 > test/cpuset.cpus
>   # echo isolated > test/cpuset.cpus.partition
>   # cat test/cpuset.cpus.partition
>   isolated
>   # cat test/cpuset.cpus.effective
>   9
>   # echo root > test/cpuset.cpus.partition
>   # cat test/cpuset.cpus.effective
>   9
>   # cat test/cpuset.cpus.partition
>   root
> 
> With this fix, the last few steps will become:
> 
>   # echo root > test/cpuset.cpus.partition
>   # cat test/cpuset.cpus.effective
>   0-8,10-95
>   # cat test/cpuset.cpus.partition
>   root invalid (partition config conflicts with housekeeping setup)
> 
> Reported-by: Chen Ridong <chenridong@huawei.com>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index cc9c3402f16b..2daf58bf0bbb 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1610,8 +1610,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>  	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>  	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>  		return PERR_INVCPUS;
> -	if ((new_prs == PRS_ISOLATED) &&
> -	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
> +	if (((new_prs == PRS_ISOLATED) &&
> +	     !isolated_cpus_can_update(tmp->new_cpus, NULL)) ||
> +	    prstate_housekeeping_conflict(new_prs, tmp->new_cpus))
>  		return PERR_HKEEPING;
>  
>  	spin_lock_irq(&callback_lock);
> @@ -3062,8 +3063,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>  		 * A change in load balance state only, no change in cpumasks.
>  		 * Need to update isolated_cpus.
>  		 */
> -		if ((new_prs == PRS_ISOLATED) &&
> -		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
> +		if (((new_prs == PRS_ISOLATED) &&
> +		     !isolated_cpus_can_update(cs->effective_xcpus, NULL)) ||
> +		    prstate_housekeeping_conflict(new_prs, cs->effective_xcpus))
>  			err = PERR_HKEEPING;
>  		else
>  			isolcpus_updated = true;

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


