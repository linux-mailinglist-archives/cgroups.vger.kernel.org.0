Return-Path: <cgroups+bounces-15464-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCUgD8tx6WlhZwIAu9opvQ
	(envelope-from <cgroups+bounces-15464-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 03:11:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1544C0BF
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 03:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0DBD302D5B0
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 01:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A7283FEF;
	Thu, 23 Apr 2026 01:11:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78ECA4E;
	Thu, 23 Apr 2026 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776906676; cv=none; b=bJxtXhPF/aRmVHnDnmsNXEjRrF9L3DVByYLyfZjx3CApYaQCx+xkYZuOFw4ZWOURhkA3HqP3W9o+bk+2xMe2+OjbjcQUJPLBIx8ttK+sqclIOhjlhtblop6NN3XoU9t7nbP8HKFY8Y4Za1BTBJ270cmoE0QmGK+9BpqsSd/IFFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776906676; c=relaxed/simple;
	bh=6IEjWa5Bp2HmWAT63DqZwaxugME+cvx69VMEGChpnTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVRejSmhhCgsxKtvPEj58Bj3JmWHQnjc2iachVRVjxev+oxqR+ZeQwazuZfDNjxSM9mBV/KwnyRB11mXfm+zcSxImBubeMqKL+uVwQe2Za2GMLYtKCSiaw7vnd6FaE8Xw61t+cNEL0fO965Kjc3CNVrVsAchaY6qqNJtaXLkdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g1J0p05thzYQtjP;
	Thu, 23 Apr 2026 09:10:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C684140561;
	Thu, 23 Apr 2026 09:11:00 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgAnHbehcelp3eGGBQ--.59173S2;
	Thu, 23 Apr 2026 09:10:59 +0800 (CST)
Message-ID: <e8824498-f8ec-496a-a21c-d1dc594f4c8e@huaweicloud.com>
Date: Thu, 23 Apr 2026 09:10:57 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] cgroup/cpuset: Improve check for calling
 housekeeping_update()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Guenter Roeck <linux@roeck-us.net>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Qiliang Yuan <realwujing@gmail.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-20-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260421030351.281436-20-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAnHbehcelp3eGGBQ--.59173S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw1UJF1UurW7urWktr13urg_yoW5AFy5pr
	yUWrW3t345trs7u343Xwn7Wry0gw48GF17KasxG3WrGF9rZFn2yry0kFnxCry8uwnxGryU
	ZF9rWws29a4UArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWrXVW8
	Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUVZ2-UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15464-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BC1544C0BF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/21 11:03, Waiman Long wrote:
> By making sure that isolated_hk_cpus matches isolated_cpus at boot time,
> we can more accurately determine if calling housekeeping_update()
> is needed by comparing if the two cpumasks are equal. The
> update_housekeeping flag still have a use in cpuset_handle_hotplug()
> to determine if a work function should be queued to invoke
> cpuset_update_sd_hk_unlock() as it is not supposed to look at
> isolated_hk_cpus without holding cpuset_top_mutex.
> 

Currently, isolated_hk_cpus is updated within the cpuset_mutex critical section
(before mutex_unlock(&cpuset_mutex)) in cpuset_update_sd_hk_unlock. Therefore, I
think update_housekeeping can now be removed.

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a4eccb0ec0d1..1b0c50b46a49 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1339,26 +1339,29 @@ static void cpuset_update_sd_hk_unlock(void)
>  	__releases(&cpuset_mutex)
>  	__releases(&cpuset_top_mutex)
>  {
> +	update_housekeeping = false;
> +
>  	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
>  	if (force_sd_rebuild)
>  		rebuild_sched_domains_locked();
>  
> -	if (update_housekeeping) {
> -		update_housekeeping = false;
> -		cpumask_copy(isolated_hk_cpus, isolated_cpus);
> -
> -		/*
> -		 * housekeeping_update() is now called without holding
> -		 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
> -		 * is still being held for mutual exclusion.
> -		 */
> -		mutex_unlock(&cpuset_mutex);
> -		cpus_read_unlock();
> -		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
> -		mutex_unlock(&cpuset_top_mutex);
> -	} else {
> +	if (cpumask_equal(isolated_hk_cpus, isolated_cpus)) {
> +		/* No housekeeping cpumask update needed */
>  		cpuset_full_unlock();
> +		return;
>  	}
> +
> +	cpumask_copy(isolated_hk_cpus, isolated_cpus);
> +
> +	/*
> +	 * housekeeping_update() is now called without holding
> +	 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
> +	 * is still being held for mutual exclusion.
> +	 */
> +	mutex_unlock(&cpuset_mutex);
> +	cpus_read_unlock();
> +	WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
> +	mutex_unlock(&cpuset_top_mutex);
>  }
>  
>  /*
> @@ -3692,10 +3695,11 @@ int __init cpuset_init(void)
>  
>  	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>  
> -	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
>  		cpumask_andnot(isolated_cpus, cpu_possible_mask,
>  			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
> -
> +		cpumask_copy(isolated_hk_cpus, isolated_cpus);
> +	}
>  	return 0;
>  }
>  

-- 
Best regards,
Ridong


