Return-Path: <cgroups+bounces-14567-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLSSHgEHp2k7bgAAu9opvQ
	(envelope-from <cgroups+bounces-14567-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 17:06:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B681F33EE
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 488CF3135EAC
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00B494A02;
	Tue,  3 Mar 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TkbPJX8l"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE74949F7
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553681; cv=none; b=bsfnb9mpUyhvuymJLdbkCKdotaMZ+y2BWMP6M/tDl+FKDiCbemIyVwBdtZz8FsfojcgmSWJ5IB8qQNY/U7Epue+Vr0pUUaCmcqrb6qTUNeRhmNkM4wWKduk1oqP5xQ/TtR1iQn27sQ0GgXOMYaCwpeXzJpVFM3rxyiEXEBP8Axg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553681; c=relaxed/simple;
	bh=kBs6YeVI4ZGaefGQXETZ1A0somIfTOLdEbAPV/EzfKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGRcYlnfhAAtAhDJACoeLb+/501gEZACLF25nTdEvCdMsYSyFpGYDH3uWB9+QxO56+leZmX1Nt+vVWC8HV8YRsBvyYRWR296oLJsdzjRnjvZYY3fsoq/LVB2QOwZsH/J+4FyCFPXqcAP2bzjLxp+WK+qoFP5wVJcWUyx4c5Gy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TkbPJX8l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772553679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dUXt5Ka5EUKQpjBNwUoDbUSHKGe/xh8PsikJk52ylI=;
	b=TkbPJX8lUHqtLIE79bw+yKxPN3ND2Kkj1iMIoTxj53A8vg91xJDznm71EzlpqvWO8yESQG
	V4kwgH89oYvNvI9OnWevKQC/RMbcsh633MplIfy6NUXvAiqjYbsRlmRoshjgJLYU4NtIOl
	nxHFaQKA4S0d/evEf5qCr0c5964xWTI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-H2VeZw1rPH6RKyeOnh0WCA-1; Tue,
 03 Mar 2026 11:01:15 -0500
X-MC-Unique: H2VeZw1rPH6RKyeOnh0WCA-1
X-Mimecast-MFC-AGG-ID: H2VeZw1rPH6RKyeOnh0WCA_1772553669
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D3CB31800266;
	Tue,  3 Mar 2026 16:01:08 +0000 (UTC)
Received: from [10.22.88.179] (unknown [10.22.88.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 333011956053;
	Tue,  3 Mar 2026 16:00:56 +0000 (UTC)
Message-ID: <c999838a-cfdf-4556-8416-cb21aa2b69e7@redhat.com>
Date: Tue, 3 Mar 2026 11:00:54 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls
 from CPU hotplug to workqueue
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
 <aaBvc4ikB1H-WQDd@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <aaBvc4ikB1H-WQDd@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 25B681F33EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-14567-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2/26/26 11:06 AM, Frederic Weisbecker wrote:
> Le Sat, Feb 21, 2026 at 01:54:17PM -0500, Waiman Long a écrit :
>> The cpuset_handle_hotplug() may need to invoke housekeeping_update(),
>> for instance, when an isolated partition is invalidated because its
>> last active CPU has been put offline.
>>
>> As we are going to enable dynamic update to the nozh_full housekeeping
>> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
>> allowing the CPU hotplug path to call into housekeeping_update() directly
>> from update_isolation_cpumasks() will likely cause deadlock.
> I am a bit confused here. Why would CPU hotplug path need to call
> update_isolation_cpumasks() -> housekeeping_update() for
> HK_TYPE_KERNEL_NOISE?

Oh, this is not the current behavior. However, to make nohz_full fully 
dynamically changeable in the near future, we will have to do that 
eventually.

Cheers,
Longman


>> So we
>> have to defer any call to housekeeping_update() after the CPU hotplug
>> operation has finished. This is now done via the workqueue where
>> the update_hk_sched_domains() function will be invoked via the
>> hk_sd_workfn().
>>
>> An concurrent cpuset control file write may have executed the required
>> update_hk_sched_domains() function before the work function is called. So
>> the work function call may become a no-op when it is invoked.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c                        | 31 ++++++++++++++++---
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 11 ++++++-
>>   2 files changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 3d0d18bf182f..2c80bfc30bbc 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1323,6 +1323,16 @@ static void update_hk_sched_domains(void)
>>   		rebuild_sched_domains_locked();
>>   }
>>   
>> +/*
>> + * Work function to invoke update_hk_sched_domains()
>> + */
>> +static void hk_sd_workfn(struct work_struct *work)
>> +{
>> +	cpuset_full_lock();
>> +	update_hk_sched_domains();
>> +	cpuset_full_unlock();
>> +}
>> +
>>   /**
>>    * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
>>    * @parent: Parent cpuset containing all siblings
>> @@ -3795,6 +3805,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>>    */
>>   static void cpuset_handle_hotplug(void)
>>   {
>> +	static DECLARE_WORK(hk_sd_work, hk_sd_workfn);
>>   	static cpumask_t new_cpus;
>>   	static nodemask_t new_mems;
>>   	bool cpus_updated, mems_updated;
>> @@ -3877,11 +3888,21 @@ static void cpuset_handle_hotplug(void)
>>   	}
>>   
>>   
>> -	if (update_housekeeping || force_sd_rebuild) {
>> -		mutex_lock(&cpuset_mutex);
>> -		update_hk_sched_domains();
>> -		mutex_unlock(&cpuset_mutex);
>> -	}
>> +	/*
>> +	 * Queue a work to call housekeeping_update() & rebuild_sched_domains()
>> +	 * There will be a slight delay before the HK_TYPE_DOMAIN housekeeping
>> +	 * cpumask can correctly reflect what is in isolated_cpus.
>> +	 *
>> +	 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work item that
>> +	 * is still pending. Before the pending bit is cleared, the work data
>> +	 * is copied out and work item dequeued. So it is possible to queue
>> +	 * the work again before the hk_sd_workfn() is invoked to process the
>> +	 * previously queued work. Since hk_sd_workfn() doesn't use the work
>> +	 * item at all, this is not a problem.
>> +	 */
>> +	if (update_housekeeping || force_sd_rebuild)
>> +		queue_work(system_unbound_wq, &hk_sd_work);
> Nit about recent wq renames:
>
> s/system_unbound_wq/system_dfl_wq
Good point. Will send additional patch to do the rename.
>
> But what makes sure this work is executed by the end of the hotplug operations?
> Is there a risk for a stale hierarchy to be observed when it shouldn't? Or a
> stale housekeeping cpumask?

If you look at the work function, it will make a copy of HK_TYPE_DOMAIN 
cpumask while holding rcu_read_lock(). So the current hotplug operation 
must have finished at that point. Of course, if there is another 
hot-add/remove operation right after the rcu_read_lock is released, the 
cpumask passed down to housekeeping_update() may not be the latest one. 
In this case, another work will be scheduled to call 
housekeeping_update() with the new cpumask again.

Cheers,
Longman



