Return-Path: <cgroups+bounces-15098-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PCnzGZDWyWnE2wUAu9opvQ
	(envelope-from <cgroups+bounces-15098-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 03:49:04 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A78354A5E
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 03:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDAF5300B068
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 01:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A82254B18;
	Mon, 30 Mar 2026 01:49:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070526DCE1;
	Mon, 30 Mar 2026 01:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774835340; cv=none; b=lZBU67m2f0iA0TQiAL5fjitDu4fAj2or1vyogK3lKbp/iRSVz+GI6dCoVYvhDKDrxc3zYrsopHmuu/CPyvHagKFWayFcdNmSZG8dbDlA+Pt64W+P/RRvKbSdHYtleP8YuTwEE9vSByEy5lo4sxGkV2Lqv3KAVxu5umlRDL4Fz7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774835340; c=relaxed/simple;
	bh=O4S9DQ4/Sw38eGYqAXr40GNp1o8gol7Zg1etvO162bs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VY8NsKevbmTo8dH5nMkqSK8uKcNEZbbFskUld6OTwGG7j7kUXKa7hsqF3cVLUK0S3qPblLVk0P9i0iLFujmmuFB0YjTUH8Kr6Vf30kPP3rHj8wL+r2HXf1kGHwTHuKgN72m5tRhrmacwME7CfPBAW+bVundf4INmjLd+D0W6nHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fkYzk6MGqzKHMVg;
	Mon, 30 Mar 2026 09:48:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AEDFF40572;
	Mon, 30 Mar 2026 09:48:48 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDHoEt_1slpEJzwCg--.6825S2;
	Mon, 30 Mar 2026 09:48:48 +0800 (CST)
Message-ID: <c80c6838-e33e-4e5c-82ac-9bfa4d012dcb@huaweicloud.com>
Date: Mon, 30 Mar 2026 09:48:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cgroup/cpuset: Skip security check for hotplug
 induced v1 task migration
To: Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huawei.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260329173958.2634925-1-longman@redhat.com>
 <20260329173958.2634925-3-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260329173958.2634925-3-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHoEt_1slpEJzwCg--.6825S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF18uF1ftr1xGw1kKrW8Crg_yoWrJrykpF
	W8Ga45Ar45G3Wjk347t3yDWryrKw4kJF17G3Z8trn8AF9xt3W09F1jgwn8Xry0yF4UW3W2
	yF4ava1a93WDtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15098-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51A78354A5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/30 1:39, Waiman Long wrote:
> When a CPU hot removal causes a v1 cpuset to lose all its CPUs, the
> cpuset hotplug handler will schedule a work function to migrate tasks
> in that cpuset with no CPU to its ancestor to enable those tasks to
> continue running.
> 
> If a strict security policy is in place, however, the task migration
> may fail when security_task_setscheduler() call in cpuset_can_attach()
> returns a -EACCESS error. That will mean that those tasks will have
> no CPU to run on. The system administrators will have to explicitly
> intervene to either add CPUs to that cpuset or move the tasks elsewhere
> if they are aware of it.
> 
> This problem was found by a reported test failure in the LTP's
> cpuset_hotplug_test.sh. Fix this problem by treating this special case
> as an exception to skip the setsched security check as it is initated
> internally within the kernel itself instead of from user input. Do that
> by setting a new one-off CS_TASKS_OUT flag in the affected cpuset by the
> hotplug handler to allow cpuset_can_attach() to skip the security check.
> 
> With that patch applied, the cpuset_hotplug_test.sh test can be run
> successfully without failure.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset-internal.h |  1 +
>  kernel/cgroup/cpuset-v1.c       |  3 +++
>  kernel/cgroup/cpuset.c          | 14 ++++++++++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index fd7d19842ded..75e2c20249ad 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -46,6 +46,7 @@ typedef enum {
>  	CS_SCHED_LOAD_BALANCE,
>  	CS_SPREAD_PAGE,
>  	CS_SPREAD_SLAB,
> +	CS_TASKS_OUT,
>  } cpuset_flagbits_t;
>  
>  /* The various types of files and directories in a cpuset file system */
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 7308e9b02495..0c818edd0a1d 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -322,6 +322,9 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>  			return;
>  		}
>  
> +		/* Enable task removal without security check */
> +		set_bit(CS_TASKS_OUT, &cs->flags);
> +
>  		s->cs = cs;
>  		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
>  		schedule_work(&s->work);
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 58c5b7b72cca..24d3ceef7991 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3011,6 +3011,20 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	setsched_check = !cpuset_v2() ||
>  		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
>  		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
> +	/*
> +	 * Also check if task migration away from the old cpuset is allowed
> +	 * without security check. This bit should only be set by the hotplug
> +	 * handler when task migration from a child v1 cpuset to its ancestor
> +	 * is needed because there is no CPU left for the tasks to run on after
> +	 * a hot CPU removal. Clear the bit if set as it is one-off. Also
> +	 * doube-check the CPU emptiness of oldcs to be sure before clearing
> +	 * setsched_check.
> +	 */
> +	if (test_bit(CS_TASKS_OUT, &oldcs->flags)) {
> +		if (cpumask_empty(oldcs->effective_cpus))
> +			setsched_check = false;
> +		clear_bit(CS_TASKS_OUT, &oldcs->flags);
> +	}
>  

If there are many tasks in the cpuset that has no CPUs, they will be migrated
one by one. I'm afraid that only the first task will succeed, and the rest will
fail because the flag is cleared after processing the first one.

-- 
Best regards,
Ridong


