Return-Path: <cgroups+bounces-15505-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMndJX2362kJQgAAu9opvQ
	(envelope-from <cgroups+bounces-15505-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:33:33 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A8462774
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 20:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3016300BE16
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2026 18:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11033F54C9;
	Fri, 24 Apr 2026 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsY4k99C"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC433F54AE
	for <cgroups@vger.kernel.org>; Fri, 24 Apr 2026 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777055587; cv=none; b=lg4NBHYPMaUJEXJuaB6J3XzKfcDr8pMS5yIFlnIhqBxSXP+JhjJPph00ee0m6Da3YAVA4Kb7qvaJIukzz/jIDpDS2d6S66mdtxPcmIOzbiRayUGyJAMTfdKX2QlNfLIeuCXdZt24KSz/Ij8x1skeaDWPs+AzXXjH4pvJRiaP26g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777055587; c=relaxed/simple;
	bh=5KKtAI6jaBrVREHQpySmvtkbvTyy3jqrl7fEoimPtZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4qsShSvgJru8jko/P6eH0Dftiwz8Af2jkgFwS+Z4GMbEK4GNd/t2b0EGaFH0wBXuAurfabwnRajC4IYIM3FljO0BMkM8xGWV1rk6/4QLA/WYpHpBO5ZDjhBUAYNmokrA1Ln35ymst11bmbaLjoBR8G370kiDtkQmSXY72lRkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZsY4k99C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777055585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/+Ofdg4jOEN9y2ToBzvsak04ExFbOMNwCGnfdG4OLXM=;
	b=ZsY4k99CZJT5QLk0OY+0xPrRWjzR+XnDmjBBvS8AUaV/oztFw0G2/jSWYC5vX7NnyJJWcx
	KDKXwnmlwTNkhySjBOEKimxNKab0D47uP9xsVeEENd1LCCgg0tKNIBUrkNqSkWd8AZ2+i1
	dgc5xX3pJDw/+bnPQDUfGf0DnOjNvHM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-wNN_jrdwPo6U_kJxLlYKOg-1; Fri,
 24 Apr 2026 14:33:03 -0400
X-MC-Unique: wNN_jrdwPo6U_kJxLlYKOg-1
X-Mimecast-MFC-AGG-ID: wNN_jrdwPo6U_kJxLlYKOg_1777055577
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7825195608B;
	Fri, 24 Apr 2026 18:32:55 +0000 (UTC)
Received: from [10.22.88.143] (unknown [10.22.88.143])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4304319560AB;
	Fri, 24 Apr 2026 18:32:45 +0000 (UTC)
Message-ID: <2658f7a3-5156-4cc5-86c4-b23627e4b5f2@redhat.com>
Date: Fri, 24 Apr 2026 14:32:45 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] cgroup/cpuset: Improve check for calling
 housekeeping_update()
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
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
 <e8824498-f8ec-496a-a21c-d1dc594f4c8e@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <e8824498-f8ec-496a-a21c-d1dc594f4c8e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: C33A8462774
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_TO(0.00)[huaweicloud.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-15505-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]

On 4/22/26 9:10 PM, Chen Ridong wrote:
>
> On 2026/4/21 11:03, Waiman Long wrote:
>> By making sure that isolated_hk_cpus matches isolated_cpus at boot time,
>> we can more accurately determine if calling housekeeping_update()
>> is needed by comparing if the two cpumasks are equal. The
>> update_housekeeping flag still have a use in cpuset_handle_hotplug()
>> to determine if a work function should be queued to invoke
>> cpuset_update_sd_hk_unlock() as it is not supposed to look at
>> isolated_hk_cpus without holding cpuset_top_mutex.
>>
> Currently, isolated_hk_cpus is updated within the cpuset_mutex critical section
> (before mutex_unlock(&cpuset_mutex)) in cpuset_update_sd_hk_unlock. Therefore, I
> think update_housekeeping can now be removed.

That is true. I will remove in the next version.

Thanks,
Longman

>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 36 ++++++++++++++++++++----------------
>>   1 file changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index a4eccb0ec0d1..1b0c50b46a49 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1339,26 +1339,29 @@ static void cpuset_update_sd_hk_unlock(void)
>>   	__releases(&cpuset_mutex)
>>   	__releases(&cpuset_top_mutex)
>>   {
>> +	update_housekeeping = false;
>> +
>>   	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
>>   	if (force_sd_rebuild)
>>   		rebuild_sched_domains_locked();
>>   
>> -	if (update_housekeeping) {
>> -		update_housekeeping = false;
>> -		cpumask_copy(isolated_hk_cpus, isolated_cpus);
>> -
>> -		/*
>> -		 * housekeeping_update() is now called without holding
>> -		 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
>> -		 * is still being held for mutual exclusion.
>> -		 */
>> -		mutex_unlock(&cpuset_mutex);
>> -		cpus_read_unlock();
>> -		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
>> -		mutex_unlock(&cpuset_top_mutex);
>> -	} else {
>> +	if (cpumask_equal(isolated_hk_cpus, isolated_cpus)) {
>> +		/* No housekeeping cpumask update needed */
>>   		cpuset_full_unlock();
>> +		return;
>>   	}
>> +
>> +	cpumask_copy(isolated_hk_cpus, isolated_cpus);
>> +
>> +	/*
>> +	 * housekeeping_update() is now called without holding
>> +	 * cpus_read_lock and cpuset_mutex. Only cpuset_top_mutex
>> +	 * is still being held for mutual exclusion.
>> +	 */
>> +	mutex_unlock(&cpuset_mutex);
>> +	cpus_read_unlock();
>> +	WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus, BIT(HK_TYPE_DOMAIN)));
>> +	mutex_unlock(&cpuset_top_mutex);
>>   }
>>   
>>   /*
>> @@ -3692,10 +3695,11 @@ int __init cpuset_init(void)
>>   
>>   	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>>   
>> -	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT))
>> +	if (housekeeping_enabled(HK_TYPE_DOMAIN_BOOT)) {
>>   		cpumask_andnot(isolated_cpus, cpu_possible_mask,
>>   			       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
>> -
>> +		cpumask_copy(isolated_hk_cpus, isolated_cpus);
>> +	}
>>   	return 0;
>>   }
>>   


