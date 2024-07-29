Return-Path: <cgroups+bounces-3929-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EDC93F3E2
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2024 13:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 110BF1F227C1
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2024 11:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2749C146584;
	Mon, 29 Jul 2024 11:20:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D52E1487EF;
	Mon, 29 Jul 2024 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722252053; cv=none; b=vFq+Lf1+r6Tff530AlvWxCLRXM/q1DO9f/iytzMFv8v13ZC60BIrToug2z8dhulEGHqZsGAYdSb8DtC2PVlVcMCRJvSfXRrF/8qI6/LjH8sg5ClRlGhnZr6O9YjZVWHMQ2WB55xGFzJo4cNRuVMWcn3iDqzJclfHiyvKl8cU23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722252053; c=relaxed/simple;
	bh=3o+xGQr03Jf+1hwzWOtExoVKrWWhSy5uzL5gBhqxjfc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kEyyWxoDS1awjA1P0cOAaKBfWJfR/kex+Gy1ACjjC2GlvkLIMBTZMDg77SI00NYfI0OsEdM6+H/hLnJEwYwJj2mA+A1Nm2jftPkLPYh0OjfKFlVcmoyY0bW0UaqdGLonWp6T+bWHZ6HEkzDKzQwtUuukj2D5GGysWwucKA+DjfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WXbWV0HvHz4f3jt8;
	Mon, 29 Jul 2024 19:20:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9A2D41A07B6;
	Mon, 29 Jul 2024 19:20:46 +0800 (CST)
Received: from [10.67.110.112] (unknown [10.67.110.112])
	by APP2 (Coremail) with SMTP id Syh0CgCn3r0Me6dm7i++AA--.9139S2;
	Mon, 29 Jul 2024 19:20:46 +0800 (CST)
Message-ID: <9ffe2032-4910-e991-64c7-28486d6c969d@huaweicloud.com>
Date: Mon, 29 Jul 2024 19:20:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup/cpuset: Remove cpuset_slab_spread_rotor
Content-Language: en-US
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: longman@redhat.com, lizefan.x@bytedance.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240713085916.3373085-1-xiujianfeng@huawei.com>
In-Reply-To: <20240713085916.3373085-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCn3r0Me6dm7i++AA--.9139S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1UAw13Cr4kZF17trWrXwb_yoW5AFy7p3
	WqkFW5Jr48JFyUuw4DJw1DAryY9w18XF45G3WFgwn5JFW2yF4qkF1kArnxXry09r98Crsx
	GFZxGrs09asFqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU92b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07URq2NUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

Hi,

Friendly ping...


On 2024/7/13 16:59, Xiu Jianfeng wrote:
> Since the SLAB implementation was removed in v6.8, so the
> cpuset_slab_spread_rotor is no longer used and can be removed.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  include/linux/cpuset.h |  6 ------
>  include/linux/sched.h  |  1 -
>  kernel/cgroup/cpuset.c | 13 -------------
>  kernel/fork.c          |  1 -
>  4 files changed, 21 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index de4cf0ee96f7..2a6981eeebf8 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -113,7 +113,6 @@ extern int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
>  			    struct pid *pid, struct task_struct *tsk);
>  
>  extern int cpuset_mem_spread_node(void);
> -extern int cpuset_slab_spread_node(void);
>  
>  static inline int cpuset_do_page_mem_spread(void)
>  {
> @@ -246,11 +245,6 @@ static inline int cpuset_mem_spread_node(void)
>  	return 0;
>  }
>  
> -static inline int cpuset_slab_spread_node(void)
> -{
> -	return 0;
> -}
> -
>  static inline int cpuset_do_page_mem_spread(void)
>  {
>  	return 0;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 75138bf70da3..e151da1675fe 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1248,7 +1248,6 @@ struct task_struct {
>  	/* Sequence number to catch updates: */
>  	seqcount_spinlock_t		mems_allowed_seq;
>  	int				cpuset_mem_spread_rotor;
> -	int				cpuset_slab_spread_rotor;
>  #endif
>  #ifdef CONFIG_CGROUPS
>  	/* Control Group info protected by css_set_lock: */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 40ec4abaf440..ba7f7f967565 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -5028,19 +5028,6 @@ int cpuset_mem_spread_node(void)
>  	return cpuset_spread_node(&current->cpuset_mem_spread_rotor);
>  }
>  
> -/**
> - * cpuset_slab_spread_node() - On which node to begin search for a slab page
> - */
> -int cpuset_slab_spread_node(void)
> -{
> -	if (current->cpuset_slab_spread_rotor == NUMA_NO_NODE)
> -		current->cpuset_slab_spread_rotor =
> -			node_random(&current->mems_allowed);
> -
> -	return cpuset_spread_node(&current->cpuset_slab_spread_rotor);
> -}
> -EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
> -
>  /**
>   * cpuset_mems_allowed_intersects - Does @tsk1's mems_allowed intersect @tsk2's?
>   * @tsk1: pointer to task_struct of some task.
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 08e13b919d80..559e8df1672a 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2313,7 +2313,6 @@ __latent_entropy struct task_struct *copy_process(
>  #endif
>  #ifdef CONFIG_CPUSETS
>  	p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
> -	p->cpuset_slab_spread_rotor = NUMA_NO_NODE;
>  	seqcount_spinlock_init(&p->mems_allowed_seq, &p->alloc_lock);
>  #endif
>  #ifdef CONFIG_TRACE_IRQFLAGS


