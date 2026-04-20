Return-Path: <cgroups+bounces-15363-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMiNHCyO5WnXlQEAu9opvQ
	(envelope-from <cgroups+bounces-15363-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:23:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6BC42639E
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F41C30065C6
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B87837757F;
	Mon, 20 Apr 2026 02:23:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AD35F5E6;
	Mon, 20 Apr 2026 02:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776651816; cv=none; b=fWigHwCAOTskONUgGUd7YFQPYYHuHILfdxQn2f1rnmKSroQZeKs9roopTqtIIg57+wx73aifJRyEJj+gGnDvFbzdxccbF1uNQ+I+Z/3yyXVCI5Z/jPU99QgD8In0bVljx1LHvUdqhwRE5+HfP4U/v+vmlRIgMOYBaTCcuf43E/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776651816; c=relaxed/simple;
	bh=We0NdkqnffqFfI6FJIozzZZhzeSlEXKk9wGlrAJiz8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UelKKZT/pk+BwNjaMF3oVi210l7pe8v1eF5BOkoGd+FyDgycET2gA8c4dAKRjFvD4vzGJc+G9i8vkHBl33xE0+Oca18zrbjRKTwCCZ/UWODWYFoeMpFtbo3WDrMrgvrHqeJ+hq9oXaSglimwErOuJX4pH78FrVk2Yt8IkyyyOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fzTlt6QkPzYQtmt;
	Mon, 20 Apr 2026 10:22:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AE60F405D1;
	Mon, 20 Apr 2026 10:23:28 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgB3GwYfjuVpZJYlBA--.57762S2;
	Mon, 20 Apr 2026 10:23:28 +0800 (CST)
Message-ID: <b1b18b0b-3694-4c90-a30e-24d898d67194@huaweicloud.com>
Date: Mon, 20 Apr 2026 10:23:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cgroup/cpuset: record DL BW alloc CPU for attach
 rollback
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, longman@redhat.com,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
 arighi@nvidia.com, changwoo@igalia.com, shuah@kernel.org
Cc: cgroups@vger.kernel.org, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
 <20260417033742.40793-2-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260417033742.40793-2-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgB3GwYfjuVpZJYlBA--.57762S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFW7Aw1xJr4xur15Zw18Zrb_yoW5uw47pF
	4kWFyUtrW5Xry7Ga47J3yUWF1S9ws7t3W2kFnIq3s5XF9xKF109F1DG3Z8Wr9YkrnrG3W5
	AF4qv3y29a1qyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15363-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_HAS_DN(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A6BC42639E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/17 11:37, Guopeng Zhang wrote:
> cpuset_can_attach() allocates DL bandwidth only when migrating
> deadline tasks to a disjoint CPU mask, but cpuset_cancel_attach()
> rolls back based only on nr_migrate_dl_tasks. This makes the DL
> bandwidth alloc/free paths asymmetric: rollback can call dl_bw_free()
> even when no dl_bw_alloc() was done.
> 
> Rollback also needs to undo the reservation against the same CPU/root
> domain that was charged. Record the CPU used by dl_bw_alloc() and use
> that state in cpuset_cancel_attach(). If no allocation happened,
> dl_bw_cpu stays at -1 and rollback skips dl_bw_free(). If allocation
> did happen, bandwidth is returned to the same CPU/root domain.
> 
> Successful attach paths are unchanged. This only fixes failed attach
> rollback accounting.
> 
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  kernel/cgroup/cpuset-internal.h |  5 +++++
>  kernel/cgroup/cpuset.c          | 13 +++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index fd7d19842ded..bb4e692bea30 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -168,6 +168,11 @@ struct cpuset {
>  	int nr_deadline_tasks;
>  	int nr_migrate_dl_tasks;
>  	u64 sum_migrate_dl_bw;
> +	/*
> +	 * CPU used for temporary DL bandwidth allocation during attach;
> +	 * -1 if no DL bandwidth was allocated in the current attach.
> +	 */
> +	int dl_bw_cpu;
>  
>  	/* Invalid partition error code, not lock protected */
>  	enum prs_errcode prs_err;
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 1335e437098e..e3a081a07c6d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -288,6 +288,7 @@ struct cpuset top_cpuset = {
>  	.flags = BIT(CS_CPU_EXCLUSIVE) |
>  		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>  	.partition_root_state = PRS_ROOT,
> +	.dl_bw_cpu = -1,
>  };
>  
>  /**
> @@ -579,6 +580,8 @@ static struct cpuset *dup_or_alloc_cpuset(struct cpuset *cs)
>  	if (!trial)
>  		return NULL;
>  
> +	trial->dl_bw_cpu = -1;
> +
>  	/* Setup cpumask pointer array */
>  	cpumask_var_t *pmask[4] = {
>  		&trial->cpus_allowed,
> @@ -2980,6 +2983,7 @@ static void reset_migrate_dl_data(struct cpuset *cs)
>  {
>  	cs->nr_migrate_dl_tasks = 0;
>  	cs->sum_migrate_dl_bw = 0;
> +	cs->dl_bw_cpu = -1;
>  }
>  
>  /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
> @@ -3056,6 +3060,8 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  			reset_migrate_dl_data(cs);
>  			goto out_unlock;
>  		}
> +
> +		cs->dl_bw_cpu = cpu;
>  	}
>  
>  out_success:
> @@ -3080,12 +3086,11 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>  	mutex_lock(&cpuset_mutex);
>  	dec_attach_in_progress_locked(cs);
>  
> -	if (cs->nr_migrate_dl_tasks) {
> -		int cpu = cpumask_any(cs->effective_cpus);
> +	if (cs->dl_bw_cpu >= 0)
> +		dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
>  
> -		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
> +	if (cs->nr_migrate_dl_tasks)
>  		reset_migrate_dl_data(cs);
> -	}
>  
>  	mutex_unlock(&cpuset_mutex);
>  }

Good catch.

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


