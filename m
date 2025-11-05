Return-Path: <cgroups+bounces-11581-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A905DC340A2
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 07:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4505B421A05
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C928750C;
	Wed,  5 Nov 2025 06:18:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0D6176ADE;
	Wed,  5 Nov 2025 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762323506; cv=none; b=MES3av3CBkccDXRwZaSZdEMyuvk3bPOS4hWx6yoWcY5n14DIadl6/Yk2C8jg5DvWwCafHGi/+1QASAqqcDYr4VydPy57ajM8bJCN/bCc7gAMOIPPf2BsfNlWWMzu8bx6Gt1dVPlKcOcYevUsCBzXUj2ouOT8dpCJtYZEdWXT0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762323506; c=relaxed/simple;
	bh=oNItNYXlIl55ks6BNKsiGDZADO2Xd45pgssSZji7J0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hhpEodpYqU4muxko1YUtviIKjYcWinN+r9smL4pK47gIgMO5/YhKOVHs7MJibG43EJsjJPI3IW/zQnLx5yl3zb2zomtXMsIU58Pyjnfa6RDIGMKbT1fgrIrPpnVU0Yyl7G2jY6P/lVjbAoIbcQYtnJoEhmfjlu5k1PVlXmoT3jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d1ZrP3ws8zKHMn1;
	Wed,  5 Nov 2025 14:18:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 6931E1A12C3;
	Wed,  5 Nov 2025 14:18:20 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBHnUUr7App4GgOCw--.12693S2;
	Wed, 05 Nov 2025 14:18:20 +0800 (CST)
Message-ID: <165437cc-d104-4b10-8efb-3da87ed5aa51@huaweicloud.com>
Date: Wed, 5 Nov 2025 14:18:18 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH v3 3/5] cgroup/cpuset: Move up
 prstate_housekeeping_conflict() helper
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251105043848.382703-1-longman@redhat.com>
 <20251105043848.382703-4-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251105043848.382703-4-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHnUUr7App4GgOCw--.12693S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4xKF43CFyruF43ZF47Jwb_yoW8tw1kpF
	43WrW3GrZ5Xa15G3sxX3WkuwnYgws7JF10yasxGrn5tF17Xw4vvFWq939avFWrXas7WryU
	ZFZ0kr43uF4xArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/5 12:38, Waiman Long wrote:
> Move up the prstate_housekeeping_conflict() helper so that it can be
> used in remote partition code.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 99622e90991a..cc9c3402f16b 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1432,6 +1432,26 @@ static bool isolated_cpus_can_update(struct cpumask *add_cpus,
>  	return res;
>  }
>  
> +/*
> + * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
> + * @prstate: partition root state to be checked
> + * @new_cpus: cpu mask
> + * Return: true if there is conflict, false otherwise
> + *
> + * CPUs outside of boot_hk_cpus, if defined, can only be used in an
> + * isolated partition.
> + */
> +static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
> +{
> +	if (!have_boot_isolcpus)
> +		return false;
> +
> +	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
> +		return true;
> +
> +	return false;
> +}
> +
>  static void update_isolation_cpumasks(bool isolcpus_updated)
>  {
>  	int ret;
> @@ -1727,26 +1747,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>  	remote_partition_disable(cs, tmp);
>  }
>  
> -/*
> - * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
> - * @prstate: partition root state to be checked
> - * @new_cpus: cpu mask
> - * Return: true if there is conflict, false otherwise
> - *
> - * CPUs outside of boot_hk_cpus, if defined, can only be used in an
> - * isolated partition.
> - */
> -static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
> -{
> -	if (!have_boot_isolcpus)
> -		return false;
> -
> -	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
> -		return true;
> -
> -	return false;
> -}
> -
>  /**
>   * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>   * @cs:      The cpuset that requests change in partition root state

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


