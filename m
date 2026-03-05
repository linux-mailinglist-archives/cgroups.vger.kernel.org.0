Return-Path: <cgroups+bounces-14675-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA+qN0nXqWnHGAEAu9opvQ
	(envelope-from <cgroups+bounces-14675-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 20:19:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE162175E7
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 20:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6730C300B12C
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D252F5A12;
	Thu,  5 Mar 2026 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVPoiA7Y"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6818024
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772738193; cv=none; b=DPURi0yH+7/f/lp8LtqgMqpt7XTZ2SqrYT7RLz47JI5kqnUieK4+xJzpVOLWyorEGA0xASEMfRsszJEWM1dAYthKgC57M2yNlOj/LRifWiV8vGRDeZYduKqucSmsVqwkmteev1t3GRV+9v8S/264kuYfsZw4LpxO82O95QKpdf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772738193; c=relaxed/simple;
	bh=558Ea8k86MCkNDGlGfvOHDj377jokcoY0+behIHlvNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rM/nOHGUrLcsWvX2u3nqUzREKsu7HVmUA/ZNO3rbeKNbpMxV7F7bqAsNNpNeHiYYV9sUu9PmOZ6x/C5WdSyEfuYI47WbwDZ1w/dB5xVJf/u3hkvCTeX7o2UtYUujeTfykVkFCbx3F77n3O3wlXowwI8JQhWkIQy13G6eEgLWDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SVPoiA7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772738190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGPFVJZmXPRxRQtePLH5HEESukRKS+ushQ2bbw2CUMQ=;
	b=SVPoiA7YPHkLqtG9AKJA4Fb11ru9IXPCyZ4i30SIupsoAbiDJvYY7ThozYs7mWRGoksOiv
	cUSnHoJUhs6xKeS5qOjkh1+LLbM20F5ooucxKeqNGxiuwa39cmQ/omxFb8LI9HTltM/CT3
	fK8MgYoUSMTIauYUBH5ofVKOl08qBAw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-VQ3hfTccM3ewV7VTLCq-MQ-1; Thu,
 05 Mar 2026 14:16:27 -0500
X-MC-Unique: VQ3hfTccM3ewV7VTLCq-MQ-1
X-Mimecast-MFC-AGG-ID: VQ3hfTccM3ewV7VTLCq-MQ_1772738185
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C0D1180061E;
	Thu,  5 Mar 2026 19:16:25 +0000 (UTC)
Received: from [10.22.88.171] (unknown [10.22.88.171])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8C1A13003E9F;
	Thu,  5 Mar 2026 19:16:23 +0000 (UTC)
Message-ID: <99dc8422-6d9f-4a5a-bc60-c6d632b01802@redhat.com>
Date: Thu, 5 Mar 2026 14:16:22 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Call rebuild_sched_domains() directly in
 hotplug
To: Chen Ridong <chenridong@huaweicloud.com>,
 Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jon Hunter <jonathanh@nvidia.com>
References: <20260304184100.71015-1-longman@redhat.com>
 <f7fe97bb-05ca-4187-99a3-537ddad718ee@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <f7fe97bb-05ca-4187-99a3-537ddad718ee@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 3FE162175E7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14675-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,huaweicloud.com:email]
X-Rspamd-Action: no action


On 3/5/26 1:45 AM, Chen Ridong wrote:
>
> On 2026/3/5 2:41, Waiman Long wrote:
>> Besides deferring the call to housekeeping_update(), commit 6df415aa46ec
>> ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug
>> to workqueue") also defers the rebuild_sched_domains() call to
>> the workqueue. So a new offline CPU may still be in a sched domain
>> or new online CPU not showing up in the sched domains for a short
>> transition period. That could be a problem in some corner cases and
>> can be the cause of a reported test failure[1]. Fix it by calling
> Miss Link [1]?
I thought I did. Will update it with the link.
>
>> rebuild_sched_domains_cpuslocked() directly in hotplug as before. If
>> isolated partition invalidation or recreation is being done, the
>> housekeeping_update() call to update the housekeeping cpumasks will
>> still be deferred to a workqueue.
>>
>> In commit 3bfe47967191 ("cgroup/cpuset: Move
>> housekeeping_update()/rebuild_sched_domains() together"),
>> housekeeping_update() is called before rebuild_sched_domains() because
>> it needs to access the HK_TYPE_DOMAIN housekeeping cpumask. That is now
>> changed to use the static HK_TYPE_DOMAIN_BOOT cpumask as HK_TYPE_DOMAIN
>> cpumask is now changeable at run time.  As a result, we can move the
>> rebuild_sched_domains() call before housekeeping_update() with
>> the slight advantage that it will be done in the same cpus_read_lock
>> critical section without the possibility of interference by a concurrent
>> cpu hot add/remove operation.
>>
> Nice.
>
>> As it doesn't make sense to acquire cpuset_mutex/cpuset_top_mutex after
>> calling housekeeping_update() and immediately release them again, move
>> the cpuset_full_unlock() operation inside update_hk_sched_domains()
>> and rename it to cpuset_update_sd_hk_unlock() to signify that it will
>> release the full set of locks.
>>
>> Fixes: 6df415aa46ec ("cgroup/cpuset: Defer housekeeping_update() calls from CPU hotplug to workqueue")
>> Tested-by: Jon Hunter <jonathanh@nvidia.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++--------------------
>>   1 file changed, 31 insertions(+), 28 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 271bb99b1b9d..f7657b325490 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -881,7 +881,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>   	/*
>>   	 * Cgroup v2 doesn't support domain attributes, just set all of them
>>   	 * to SD_ATTR_INIT. Also non-isolating partition root CPUs are a
>> -	 * subset of HK_TYPE_DOMAIN housekeeping CPUs.
>> +	 * subset of HK_TYPE_DOMAIN_BOOT housekeeping CPUs.
>>   	 */
>>   	for (i = 0; i < ndoms; i++) {
>>   		/*
>> @@ -890,7 +890,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>   		 */
>>   		if (!csa || csa[i] == &top_cpuset)
>>   			cpumask_and(doms[i], top_cpuset.effective_cpus,
>> -				    housekeeping_cpumask(HK_TYPE_DOMAIN));
>> +				    housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
>>   		else
>>   			cpumask_copy(doms[i], csa[i]->effective_cpus);
>>   		if (dattr)
>> @@ -1331,17 +1331,22 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>   }
>>   
>>   /*
>> - * update_hk_sched_domains - Update HK cpumasks & rebuild sched domains
>> + * cpuset_update_sd_hk_unlock - Rebuild sched domains, update HK & unlock
>>    *
>> - * Update housekeeping cpumasks and rebuild sched domains if necessary.
>> - * This should be called at the end of cpuset or hotplug actions.
>> + * Update housekeeping cpumasks and rebuild sched domains if necessary and
>> + * then do a cpuset_full_unlock().
>> + * This should be called at the end of cpuset operation.
>>    */
>> -static void update_hk_sched_domains(void)
>> +static void cpuset_update_sd_hk_unlock(void)
>> +	__releases(&cpuset_mutex)
>> +	__releases(&cpuset_top_mutex)
>>   {
>> +	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
>> +	if (force_sd_rebuild)
>> +		rebuild_sched_domains_locked();
>> +
>>   	if (update_housekeeping) {
>> -		/* Updating HK cpumasks implies rebuild sched domains */
>>   		update_housekeeping = false;
>> -		force_sd_rebuild = true;
>>   		cpumask_copy(isolated_hk_cpus, isolated_cpus);
>>   
>>   		/*
>> @@ -1352,22 +1357,19 @@ static void update_hk_sched_domains(void)
>>   		mutex_unlock(&cpuset_mutex);
>>   		cpus_read_unlock();
>>   		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
>> -		cpus_read_lock();
>> -		mutex_lock(&cpuset_mutex);
>> +		mutex_unlock(&cpuset_top_mutex);
>> +	} else {
>> +		cpuset_full_unlock();
>>   	}
>> -	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
>> -	if (force_sd_rebuild)
>> -		rebuild_sched_domains_locked();
>>   }
>>   
>>   /*
>> - * Work function to invoke update_hk_sched_domains()
>> + * Work function to invoke cpuset_update_sd_hk_unlock()
>>    */
>>   static void hk_sd_workfn(struct work_struct *work)
>>   {
>>   	cpuset_full_lock();
>> -	update_hk_sched_domains();
>> -	cpuset_full_unlock();
>> +	cpuset_update_sd_hk_unlock();
>>   }
>>   
>>   /**
>> @@ -3232,8 +3234,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>   
>>   	free_cpuset(trialcs);
>>   out_unlock:
>> -	update_hk_sched_domains();
>> -	cpuset_full_unlock();
>> +	cpuset_update_sd_hk_unlock();
>>   	if (of_cft(of)->private == FILE_MEMLIST)
>>   		schedule_flush_migrate_mm();
>>   	return retval ?: nbytes;
>> @@ -3340,8 +3341,7 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
>>   	cpuset_full_lock();
>>   	if (is_cpuset_online(cs))
>>   		retval = update_prstate(cs, val);
>> -	update_hk_sched_domains();
>> -	cpuset_full_unlock();
>> +	cpuset_update_sd_hk_unlock();
>>   	return retval ?: nbytes;
>>   }
>>   
>> @@ -3515,8 +3515,7 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
>>   	/* Reset valid partition back to member */
>>   	if (is_partition_valid(cs))
>>   		update_prstate(cs, PRS_MEMBER);
>> -	update_hk_sched_domains();
>> -	cpuset_full_unlock();
>> +	cpuset_update_sd_hk_unlock();
>>   }
>>   
>>   static void cpuset_css_free(struct cgroup_subsys_state *css)
>> @@ -3925,11 +3924,13 @@ static void cpuset_handle_hotplug(void)
>>   		rcu_read_unlock();
>>   	}
>>   
>> -
>>   	/*
>> -	 * Queue a work to call housekeeping_update() & rebuild_sched_domains()
>> -	 * There will be a slight delay before the HK_TYPE_DOMAIN housekeeping
>> -	 * cpumask can correctly reflect what is in isolated_cpus.
>> +	 * rebuild_sched_domains() will always be called directly if needed
>> +	 * to make sure that newly added or removed CPU will be reflected in
>> +	 * the sched domains. However, if isolated partition invalidation
>> +	 * or recreation is being done (update_housekeeping set), a work item
>> +	 * will be queued to call housekeeping_update() to update the
>> +	 * corresponding housekeeping cpumasks after some slight delay.
>>   	 *
>>   	 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work item that
>>   	 * is still pending. Before the pending bit is cleared, the work data
>> @@ -3938,8 +3939,10 @@ static void cpuset_handle_hotplug(void)
>>   	 * previously queued work. Since hk_sd_workfn() doesn't use the work
>>   	 * item at all, this is not a problem.
>>   	 */
>> -	if (update_housekeeping || force_sd_rebuild)
>> -		queue_work(system_unbound_wq, &hk_sd_work);
>> +	if (force_sd_rebuild)
>> +		rebuild_sched_domains_cpuslocked();
>> +	if (update_housekeeping)
>> +		queue_work(system_dfl_wq, &hk_sd_work);
>>   
>>   	free_tmpmasks(ptmp);
>>   }
> This means that rebuild schedule domains are decoupled from HK updates, right?
Yes.
> I'm wondering again whether we can do the same for changes to
> cpus/partition/cpus.exclusive. If we can defer the HK update, then the
> cpuset_top_mutex might no longer be necessary.
>
> This patch looks good to me.
>
> Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
>
Thanks,
Longman


