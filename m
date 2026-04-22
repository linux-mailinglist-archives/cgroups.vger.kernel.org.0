Return-Path: <cgroups+bounces-15455-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P7UODCX6GnVNAIAu9opvQ
	(envelope-from <cgroups+bounces-15455-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 11:38:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA7444175
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 11:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52BEB306F918
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 09:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBFB3C3C00;
	Wed, 22 Apr 2026 09:35:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF3138839F;
	Wed, 22 Apr 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776850506; cv=none; b=C1PBQwJ5BuIs+Ja24+S4JPWrSujpZ4J7Nl7Rfgb30TxVZRqQ0IOQIu48tqGQNf/QTERQWqEVe0MW5g76CaYbkJ+c4MRZfLCSEtxJbYLv6HPz0RrkwfKPtTkJsJeeiIcSKXhpiuDgOH1QMOXquQ8coYk4kMSv2twetUrZWN9T4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776850506; c=relaxed/simple;
	bh=p7P8V6Ltow3mGw8KRZMBasw50nMRtXyR1TO6duHL6BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIw5WC2SJhrqZZNPSvmb/d+lSaY1KbySphunpRj8BXoB9ZKt7bD8Z8iO+9ItQNQT+82Hjp0SB3Hk47C7CSnfrQu06LxFzhTOlnOcWl33UtgoMVBPKNjuoSQNp4dhusPLMSRsTAa2Vb71E3bndj504qVAYIf48zxBWrddb757rPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g0vFR72LmzKHMd7;
	Wed, 22 Apr 2026 17:34:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 773F1405F2;
	Wed, 22 Apr 2026 17:34:56 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgD3mwY+luhpInw6BQ--.28182S2;
	Wed, 22 Apr 2026 17:34:55 +0800 (CST)
Message-ID: <e37620c6-b198-48e1-a991-ad614058e882@huaweicloud.com>
Date: Wed, 22 Apr 2026 17:34:54 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/23] arm64: topology: Use RCU to protect access to
 HK_TYPE_TICK cpumask
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
 <20260421030351.281436-9-longman@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260421030351.281436-9-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3mwY+luhpInw6BQ--.28182S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrurW5uryUCr4UKF1UGFg_yoW8tw18pr
	45Gws0krWjgFnrA343X3ZF9r1F93s3Jwn0ka93CF1Fkw43CF18KFnYkr15Wr4xuw1Dur4I
	yrZ5tFWSga47JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU0EksDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15455-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9AEA7444175
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/21 11:03, Waiman Long wrote:
> As the HK_TYPE_TICK cpumask is going to be changeable at run time, we
> need to use RCU to protect access to the cpumask to prevent it from
> going away in the middle of the operation.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/arm64/kernel/topology.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index b32f13358fbb..48f150801689 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -173,6 +173,7 @@ void arch_cpu_idle_enter(void)
>  	if (!amu_fie_cpu_supported(cpu))
>  		return;
>  
> +	guard(rcu)();
>  	/* Kick in AMU update but only if one has not happened already */
>  	if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
>  	    time_is_before_jiffies(per_cpu(cpu_amu_samples.last_scale_update, cpu)))
> @@ -187,11 +188,16 @@ int arch_freq_get_on_cpu(int cpu)
>  	unsigned int start_cpu = cpu;
>  	unsigned long last_update;
>  	unsigned int freq = 0;
> +	bool hk_cpu;
>  	u64 scale;
>  
>  	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
>  		return -EOPNOTSUPP;
>  
> +	scoped_guard(rcu) {
> +		hk_cpu = housekeeping_cpu(cpu, HK_TYPE_TICK);
> +	}
> +

Should we put this into a while loop, since cpu might be changed to ref_cpu?

>  	while (1) {
>  
>  		amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> @@ -204,16 +210,21 @@ int arch_freq_get_on_cpu(int cpu)
>  		 * (and thus freq scale), if available, for given policy: this boils
>  		 * down to identifying an active cpu within the same freq domain, if any.
>  		 */
> -		if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> +		if (!hk_cpu ||
>  		    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
>  			struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +			bool hk_intersects;
>  			int ref_cpu;
>  
>  			if (!policy)
>  				return -EINVAL;
>  
> -			if (!cpumask_intersects(policy->related_cpus,
> -						housekeeping_cpumask(HK_TYPE_TICK))) {
> +			scoped_guard(rcu) {
> +				hk_intersects = cpumask_intersects(policy->related_cpus,
> +							housekeeping_cpumask(HK_TYPE_TICK));
> +			}
> +
> +			if (!hk_intersects) {
>  				cpufreq_cpu_put(policy);
>  				return -EOPNOTSUPP;
>  			}

-- 
Best regards,
Ridong


