Return-Path: <cgroups+bounces-15713-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ocWBH6dDAWo8TQEAu9opvQ
	(envelope-from <cgroups+bounces-15713-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 04:49:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9855074F9
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 04:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09ADB300C937
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 02:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96422E8E09;
	Mon, 11 May 2026 02:49:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415AA26AE5;
	Mon, 11 May 2026 02:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467746; cv=none; b=MkwsJr7JxgJz5FMKvczi5bk17/8I44z+zM4ktSKMdoc5TwGkkyUsp6zHojtShnFs9n3sxC/LAdzUyeO3QoGSSnP2gDokEBosWvxdbasiRh+7JAU4ejMonuWe1Gl/K3qUOX2kecE0QpuIKHtryAhPHW77BZ3T/6h91eNay4bGzI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467746; c=relaxed/simple;
	bh=PMCKqL+CyZ9NJ756AdbeqOPUzfrb2PIhA0pZIxeKOpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKchMQPhTvZKN701CBqGkZ6ENZYZsGS+lv520Av4gBW+I2C7Nqh2ccNLgM5i9dKCITYbj7HwUzefsfjtyKK4udWXqgpAH/oxy0vVayWrIoRgkM6PirPWFGXFNmvrbmrOH0mLLFgaXt+FDGleBGXWJqrTH5yhwEZED/rI9mV2FDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gDPKT05KZzKHLwn;
	Mon, 11 May 2026 10:47:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3D9084056E;
	Mon, 11 May 2026 10:48:47 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgBXsyuNQwFqB7NUBw--.56418S2;
	Mon, 11 May 2026 10:48:46 +0800 (CST)
Message-ID: <5e0b49be-72b8-4be8-b72d-13d19bc471e5@huaweicloud.com>
Date: Mon, 11 May 2026 10:48:45 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup/cpuset: reset DL migration state on
 can_attach() failure
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20260509102031.97608-1-zhangguopeng@kylinos.cn>
 <20260509102031.97608-2-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260509102031.97608-2-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBXsyuNQwFqB7NUBw--.56418S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18Zry5JryDAry8tw4rGrg_yoW8ZrW3pF
	ykW348ta45ZFyUWa17tay7Wry0gw18Xw17KFn8tw1rZFnruF1jkr1DK3Z8ur1YyrnrC3W3
	ZF4a93y2ga1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: AE9855074F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-15713-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 2026/5/9 18:20, Guopeng Zhang wrote:
> cpuset_can_attach() accumulates temporary SCHED_DEADLINE migration
> state in the destination cpuset while walking the taskset.
> 
> If a later task_can_attach() or security_task_setscheduler() check
> fails, cgroup_migrate_execute() treats cpuset as the failing subsystem
> and does not call cpuset_cancel_attach() for it. The partially
> accumulated state is then left behind and can be consumed by a later
> attach, corrupting cpuset DL task accounting and pending DL bandwidth
> accounting.
> 
> Reset the pending DL migration state from the common error exit when
> ret is non-zero. Successful can_attach() keeps the state for
> cpuset_attach() or cpuset_cancel_attach().
> 
> Fixes: 2ef269ef1ac0 ("cgroup/cpuset: Free DL BW in case can_attach() fails")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  kernel/cgroup/cpuset.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e3a081a07c6d..b9c839538900 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3050,16 +3050,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
>  
>  		if (unlikely(cpu >= nr_cpu_ids)) {
> -			reset_migrate_dl_data(cs);
>  			ret = -EINVAL;
>  			goto out_unlock;
>  		}
>  
>  		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -		if (ret) {
> -			reset_migrate_dl_data(cs);
> +		if (ret)
>  			goto out_unlock;
> -		}
>  
>  		cs->dl_bw_cpu = cpu;
>  	}
> @@ -3070,7 +3067,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  	 * changes which zero cpus/mems_allowed.
>  	 */
>  	cs->attach_in_progress++;
> +
>  out_unlock:
> +	if (ret)
> +		reset_migrate_dl_data(cs);
>  	mutex_unlock(&cpuset_mutex);
>  	return ret;
>  }

LGTM.
Thanks.

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


