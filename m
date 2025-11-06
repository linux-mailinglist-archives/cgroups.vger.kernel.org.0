Return-Path: <cgroups+bounces-11644-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C78C38B00
	for <lists+cgroups@lfdr.de>; Thu, 06 Nov 2025 02:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C04814E3303
	for <lists+cgroups@lfdr.de>; Thu,  6 Nov 2025 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7786E20E03F;
	Thu,  6 Nov 2025 01:20:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FACC1FFC48;
	Thu,  6 Nov 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762392034; cv=none; b=sDz/Zg4TnGptDs5wnmnfVCIPve5o9i5+pl+K2Bjy7xaEhWWgcjITqC4rQVsT3obPuxDRIdGhR7TwojtV50xaSL9w9hBVe0SBzNf+9mDNa56v3Eztc273KHLsMEl6KBmvzXDd0e9lGd58qZFrnMYqLo5zADmug76ak/IdxUcAjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762392034; c=relaxed/simple;
	bh=1n2WjqKfbwvdH5KOodvEY+wR04CDw4VxYqgsx9+a/sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7ecrYh1vzSBM4fqZttBvqt4wN3llYDVuUcrUSZ+Cn7XUQ6ju1cHw7uTBOmeWVuTGqyQahcD/sbNYuEAvKHFZmX6mIUKNU9fOyEaYlaQkvAUE+EHo5z+/zGTgUzvZTwzGF6cbvvFI69oXI2bLN14BxwY8UdJBn77ADkdxgduL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d24BD5gnyzKHMPT;
	Thu,  6 Nov 2025 09:20:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C64E91A0CC3;
	Thu,  6 Nov 2025 09:20:28 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAHqEDb9wtp6fpnCw--.52284S2;
	Thu, 06 Nov 2025 09:20:28 +0800 (CST)
Message-ID: <7742487a-81e0-430f-8c4d-f1a761c2af98@huaweicloud.com>
Date: Thu, 6 Nov 2025 09:20:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/31] cpuset: Convert boot_hk_cpus to use
 HK_TYPE_DOMAIN_BOOT
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
 Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, netdev@vger.kernel.org
References: <20251105210348.35256-1-frederic@kernel.org>
 <20251105210348.35256-7-frederic@kernel.org>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251105210348.35256-7-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHqEDb9wtp6fpnCw--.52284S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryDGF1kuFW3trWkJFWDArb_yoW8Kw45pr
	47X3yUKa95JF1rG345J3WqvryFgws7Jr1DC3ZxGw1rXasrCF18ArW09asayFyFv34kur47
	Zrn8CF4SgF4rArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	EksDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/6 5:03, Frederic Weisbecker wrote:
> boot_hk_cpus is an ad-hoc copy of HK_TYPE_DOMAIN_BOOT. Remove it and use
> the official version.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Phil Auld <pauld@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..8595f1eadf23 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -81,12 +81,6 @@ static cpumask_var_t	subpartitions_cpus;
>   */
>  static cpumask_var_t	isolated_cpus;
>  
> -/*
> - * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
> - */
> -static cpumask_var_t	boot_hk_cpus;
> -static bool		have_boot_isolcpus;
> -
>  /* List of remote partition root children */
>  static struct list_head remote_children;
>  
> @@ -1686,15 +1680,16 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>   * @new_cpus: cpu mask
>   * Return: true if there is conflict, false otherwise
>   *
> - * CPUs outside of boot_hk_cpus, if defined, can only be used in an
> + * CPUs outside of HK_TYPE_DOMAIN_BOOT, if defined, can only be used in an
>   * isolated partition.
>   */
>  static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>  {
> -	if (!have_boot_isolcpus)
> +	if (!housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
>  		return false;
>  
> -	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
> +	if ((prstate != PRS_ISOLATED) &&
> +	    !cpumask_subset(new_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT)))
>  		return true;
>  
>  	return false;
> @@ -3824,12 +3819,9 @@ int __init cpuset_init(void)
>  
>  	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>  
> -	have_boot_isolcpus = housekeeping_enabled(HK_TYPE_DOMAIN);
> -	if (have_boot_isolcpus) {
> -		BUG_ON(!alloc_cpumask_var(&boot_hk_cpus, GFP_KERNEL));
> -		cpumask_copy(boot_hk_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
> -		cpumask_andnot(isolated_cpus, cpu_possible_mask, boot_hk_cpus);
> -	}
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
> +		cpumask_andnot(isolated_cpus, cpu_possible_mask,
> +			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
>  
>  	return 0;
>  }

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


