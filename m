Return-Path: <cgroups+bounces-15085-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI/FFmMxx2mNUAUAu9opvQ
	(envelope-from <cgroups+bounces-15085-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 02:39:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73B634CEEA
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 02:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7823019810
	for <lists+cgroups@lfdr.de>; Sat, 28 Mar 2026 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC4338906;
	Sat, 28 Mar 2026 01:39:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07543331A66;
	Sat, 28 Mar 2026 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774661974; cv=none; b=plRQliQ3QJO+0EZLQaiTQtCZceloqPJXF0wOv8GAwfVJmUYhFEZmN2xUICeBrOlpX0q0clyTYIRmLG/q/6aTpL4G7+o76I8RP23iOxigqOYjVeztRCTLiUiMqZRK7zESnmXOHSE87tf2xx8qzhjGpFW2v5M8LWCwG24OguJsS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774661974; c=relaxed/simple;
	bh=HAwqI20SKHFf4785AZOE+iQ1MQWmGhexB3LwShAe4UQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+XvQ8gsj98brLcLsHnYhb2k7zJeatFkKz1YiN06u0jY9aft0GlzHPDOgugmoAvmwJUgrv5vTLRRdEMK1UmH5NCzEGGUvp7U7nc5wSNcBzshcSpohJN3R97jndMaIyZHmNbG79M00AdAKoXI82DOTmqoO+dVwVNsK8kHcHA2hfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fjKtN3CLszYQtM5;
	Sat, 28 Mar 2026 09:39:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 202684056F;
	Sat, 28 Mar 2026 09:39:23 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgBXWNhJMcdpAfLnCQ--.25011S2;
	Sat, 28 Mar 2026 09:39:23 +0800 (CST)
Message-ID: <d3c226f3-dd92-40a3-95a4-3e9e5f0adeb4@huaweicloud.com>
Date: Sat, 28 Mar 2026 09:39:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Skip security check for hotplug induced v1
 task migration
To: Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huawei.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260327201546.2463644-1-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260327201546.2463644-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXWNhJMcdpAfLnCQ--.25011S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF18uF1fuFWktw4rKF13twb_yoW5Cw15pF
	W0kFyUtrWYkFy29w4xt39rWw1Fgws3t3WUKrs8tw15Ja43K3W09F1xG3Z8ZryrtryUWa12
	vF4Yvw42gF4DAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cpuset_hotplug_test.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15085-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B73B634CEEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/3/28 4:15, Waiman Long wrote:
> When a CPU hot removal causes a v1 cpuset to lose all its CPUs, the
> cpuset hotplug handler will schedule a work function to migrate tasks
> in that cpuset with no CPU to its parent to enable those tasks to
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
> internally within the kernel itself instead of from user input. With that
> patch applied, the cpuset_hotplug_test.sh test can be run successfully
> without failure.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Should we add a Fixes tag?

> ---
>  kernel/cgroup/cpuset.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d21868455341..88ce7ed91cd1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2989,6 +2989,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	struct cpuset *cs, *oldcs;
>  	struct task_struct *task;
>  	bool cpus_updated, mems_updated;
> +	bool kthread_move_task_from_empty_cs;

This name is too long. How about `kthread_nocpus`?

>  	int ret;
>  
>  	/* used later by cpuset_attach() */
> @@ -3006,6 +3007,14 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	cpus_updated = !cpumask_equal(cs->effective_cpus, oldcs->effective_cpus);
>  	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
>  
> +	/*
> +	 * Set to true if a kthread is moving tasks away from a v1 cpuset with
> +	 * no CPUs
> +	 */
> +	kthread_move_task_from_empty_cs = !cpuset_v2() &&
> +					  cpumask_empty(oldcs->effective_cpus) &&
> +					  (current->flags & PF_KTHREAD);
> +
>  	cgroup_taskset_for_each(task, css, tset) {
>  		ret = task_can_attach(task);
>  		if (ret)
> @@ -3015,8 +3024,15 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  		 * Skip rights over task check in v2 when nothing changes,
>  		 * migration permission derives from hierarchy ownership in
>  		 * cgroup_procs_write_permission()).
> +		 *
> +		 * In the special case of forced cpuset1 task migration to
> +		 * parent via workqueue because of empty cpuset.cpus caused by
> +		 * hotplug, skip the task check to prevent restrictive security
> +		 * policy from denying the task migration. Otherwise those
> +		 * tasks will have no CPU to run on.
>  		 */
> -		if (!cpuset_v2() || (cpus_updated || mems_updated)) {
> +		if (!kthread_move_task_from_empty_cs &&
> +		   (!cpuset_v2() || cpus_updated || mems_updated)) {
>  			ret = security_task_setscheduler(task);
>  			if (ret)
>  				goto out_unlock;

-- 
Best regards,
Ridong


