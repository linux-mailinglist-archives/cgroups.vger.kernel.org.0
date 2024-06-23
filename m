Return-Path: <cgroups+bounces-3295-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38995913E36
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 22:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52A41F214A7
	for <lists+cgroups@lfdr.de>; Sun, 23 Jun 2024 20:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A693E184131;
	Sun, 23 Jun 2024 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7oQ9ghl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF426ACA
	for <cgroups@vger.kernel.org>; Sun, 23 Jun 2024 20:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719175933; cv=none; b=G0QFqc/7oLj1kfQs4ebkDJ87lWKjayinSHMjIyIyx3XSyJ4HvJtMIiiOp6Umt0rJCiqSH1SFgTcQafAzY1e43x0kGVAubd2yTCV8UKcNrMWqiR72pGcjgTZ/1vDUXIYhGvz/4pN0OKRcEXVvSPJPpOhFEehb03mYziDURguE2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719175933; c=relaxed/simple;
	bh=5LZ4oxgkvtqUP+H6P8Voll0XUVPkh8sPYUQn8FfiIsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9ypsPJZ7mgkCiTX6dm1XTtEtYlWY7hdIdzm4cQOndbS2Bx2ySXd/2NPdPxA8gnppBNVnVG2eEw1tF7+1LSzioLQN07+h0/D6eOcidxMiuJHXipumE2+wCZ43NeI1CyFUuZRctIxXuWdBpnsC/RWwEZgYlrxvl1QdxIvYURb/mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7oQ9ghl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719175930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxNDjDlKRoE7zO5kxxC/YRHIs3V83UmtXsw3pjNyLs8=;
	b=c7oQ9ghlpyUfHk/lb/cqLaBHaNEW8dqh8b/L8PA/3FuEU70JG6QJW8/eMizGkNHolc5yLO
	TAp7KRJoSkoU4xrFYWOf/7B1jZ/YAIPtZ/QwiYj5zE5F/0DaVpc7028/zO45/+nPFTQH2V
	zwlXoiWhyW3maorpqYElEIpN7EBvxM8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-MprzqK63PtWKbblUu_VSgQ-1; Sun,
 23 Jun 2024 16:52:07 -0400
X-MC-Unique: MprzqK63PtWKbblUu_VSgQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E788C195609D;
	Sun, 23 Jun 2024 20:52:04 +0000 (UTC)
Received: from [10.22.16.52] (unknown [10.22.16.52])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D0431956087;
	Sun, 23 Jun 2024 20:52:01 +0000 (UTC)
Message-ID: <77d4299e-e1ee-4471-9b53-90957daa984d@redhat.com>
Date: Sun, 23 Jun 2024 16:52:00 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcg: Add a new sysctl parameter for automatically
 setting memory.high
To: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Alex Kalenyuk <akalenyu@redhat.com>,
 Peter Hunt <pehunt@redhat.com>, linux-doc@vger.kernel.org
References: <20240623204514.1032662-1-longman@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240623204514.1032662-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Correct some email addresses.

On 6/23/24 16:45, Waiman Long wrote:
> With memory cgroup v1, there is only a single "memory.limit_in_bytes"
> to be set to specify the maximum amount of memory that is allowed to
> be used. So a lot of memory cgroup using tools and applications allow
> users to specify a single memory limit. When they migrate to cgroup
> v2, they use the given memory limit to set memory.max and disregard
> memory.high for the time being.
>
> Without properly setting memory.high, these user space applications
> cannot make use of the memory cgroup v2 ability to further reduce the
> chance of OOM kills by throttling and early memory reclaim.
>
> This patch adds a new sysctl parameter "vm/memory_high_autoset_ratio"
> to enable setting "memory.high" automatically whenever "memory.max" is
> set as long as "memory.high" hasn't been explicitly set before. This
> will allow a system administrator or a middleware layer to greatly
> reduce the chance of memory cgroup OOM kills without worrying about
> how to properly set memory.high.
>
> The new sysctl parameter will allow a range of 0-100. The default value
> of 0 will disable memory.high auto setting. For any non-zero value "n",
> the actual ratio used will be "n/(n+1)". A user cannot set a fraction
> less than 1/2.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   Documentation/admin-guide/sysctl/vm.rst | 10 ++++++
>   include/linux/memcontrol.h              |  3 ++
>   mm/memcontrol.c                         | 41 +++++++++++++++++++++++++
>   3 files changed, 54 insertions(+)
>
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index e86c968a7a0e..250ec39dd5af 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -46,6 +46,7 @@ Currently, these files are in /proc/sys/vm:
>   - mem_profiling         (only if CONFIG_MEM_ALLOC_PROFILING=y)
>   - memory_failure_early_kill
>   - memory_failure_recovery
> +- memory_high_autoset_ratio
>   - min_free_kbytes
>   - min_slab_ratio
>   - min_unmapped_ratio
> @@ -479,6 +480,15 @@ Enable memory failure recovery (when supported by the platform)
>   0: Always panic on a memory failure.
>   
>   
> +memory_high_autoset_ratio
> +=========================
> +
> +Specify a ratio by which memory.high should be set as a fraction of
> +memory.max if it hasn't been explicitly set before.  It allows a range
> +of 0-100.  The default value of 0 means auto setting will be disabled.
> +For any non-zero value "n", the actual ratio used will be "n/(n+1)".
> +
> +
>   min_free_kbytes
>   ===============
>   
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 030d34e9d117..6be161a6b922 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -221,6 +221,9 @@ struct mem_cgroup {
>   	 */
>   	bool oom_group;
>   
> +	/* %true if memory.high has been explicitly set */
> +	bool memory_high_set;
> +
>   	/* protected by memcg_oom_lock */
>   	bool		oom_lock;
>   	int		under_oom;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 71fe2a95b8bd..2cfb000bf543 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -48,6 +48,7 @@
>   #include <linux/swap.h>
>   #include <linux/swapops.h>
>   #include <linux/spinlock.h>
> +#include <linux/sysctl.h>
>   #include <linux/eventfd.h>
>   #include <linux/poll.h>
>   #include <linux/sort.h>
> @@ -6889,6 +6890,35 @@ static void mem_cgroup_attach(struct cgroup_taskset *tset)
>   }
>   #endif
>   
> +/*
> + * The memory.high autoset ratio specifies a ratio by which memory.high
> + * should be set as a fraction of memory.max if it hasn't been explicitly
> + * set before. The default value of 0 means auto setting will be disabled.
> + * For any non-zero value "n", the actual ratio is "n/(n+1)".
> + */
> +static int sysctl_memory_high_autoset_ratio;
> +
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table memcg_table[] = {
> +	{
> +		.procname	= "memory_high_autoset_ratio",
> +		.data		= &sysctl_memory_high_autoset_ratio,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE_HUNDRED,
> +	},
> +};
> +
> +static inline void memcg_sysctl_init(void)
> +{
> +	register_sysctl_init("vm", memcg_table);
> +}
> +#else
> +static void memcg_sysctl_init(void)	{ }
> +#endif /* CONFIG_SYSCTL */
> +
>   static int seq_puts_memcg_tunable(struct seq_file *m, unsigned long value)
>   {
>   	if (value == PAGE_COUNTER_MAX)
> @@ -6982,6 +7012,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>   		return err;
>   
>   	page_counter_set_high(&memcg->memory, high);
> +	memcg->memory_high_set = true;
>   
>   	for (;;) {
>   		unsigned long nr_pages = page_counter_read(&memcg->memory);
> @@ -7023,6 +7054,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>   	unsigned int nr_reclaims = MAX_RECLAIM_RETRIES;
>   	bool drained = false;
>   	unsigned long max;
> +	unsigned int high_ratio = sysctl_memory_high_autoset_ratio;
>   	int err;
>   
>   	buf = strstrip(buf);
> @@ -7032,6 +7064,13 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>   
>   	xchg(&memcg->memory.max, max);
>   
> +	if (high_ratio && !memcg->memory_high_set) {
> +		/* Set memory.high as a fraction of memory.max */
> +		unsigned long high = max * high_ratio / (high_ratio + 1);
> +
> +		page_counter_set_high(&memcg->memory, high);
> +	}
> +
>   	for (;;) {
>   		unsigned long nr_pages = page_counter_read(&memcg->memory);
>   
> @@ -7977,6 +8016,8 @@ static int __init mem_cgroup_init(void)
>   		soft_limit_tree.rb_tree_per_node[node] = rtpn;
>   	}
>   
> +	memcg_sysctl_init();
> +
>   	return 0;
>   }
>   subsys_initcall(mem_cgroup_init);


