Return-Path: <cgroups+bounces-16679-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Oe5/EvMEI2pjggEAu9opvQ
	(envelope-from <cgroups+bounces-16679-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 19:18:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDD064A14F
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 19:18:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=TSCr8lob;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16679-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16679-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC225301624A
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 17:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA3B397AEF;
	Fri,  5 Jun 2026 17:10:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51666390209
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 17:10:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679407; cv=none; b=RWjrt38LIuR4ilZYHQ1C1+PKC5yDUOf+Kj9GAJSItnmtXLBZQVqgQHhoxkXtXa+GR1LBk+GQA16RdDOYrZPh3tpS5jisu/8YSjVVD+PHNuIh+zcLHQ5XWQoELIO0pL6cdpbO320n1Z0Ti9mCkEdaBKhsSFCzL7JbfUK95n7pyRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679407; c=relaxed/simple;
	bh=0Mou83NrSv60OYimo0jX6jbTn7Lfbe2faKhiXssdUGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePoJNFTGy3G1EV7iU67CIrdXiqWuzmFNLu1f5CcPk0PGeTsGqnxlCjQO9ycsPf/QkvZyje/qgkOxA2zlNJW024KBbIoT5QQdGpLxD5PFwxp/e7cU/Drtv8K6H9oqV9vYKCTvNlj06h99d+oZzACCXV1PTRXYF883L/Pw99AwgsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TSCr8lob; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780679400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6Oty34tRnAzEOuZRmzGuGYIKhAYur1uI//yoqy6tss=;
	b=TSCr8loboEBQ45rOIVqXyJaPCGz3c+PbNphqY4rBONkRVGz/t8fHMR1YlQ8DYDiYiN+IP3
	EEgIC10BB6eO+7b9ldXEGokEjRRBhwQge/bRqRB1GQ/fzezPuCUA4GA01FwOef/ZQC6HUP
	9SlQgq/J2jeEt+IwmXcx2kVYram2/eM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-U8BiGN29PvCFJCcjHvkkNQ-1; Fri,
 05 Jun 2026 13:09:56 -0400
X-MC-Unique: U8BiGN29PvCFJCcjHvkkNQ-1
X-Mimecast-MFC-AGG-ID: U8BiGN29PvCFJCcjHvkkNQ_1780679394
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9527418002C8;
	Fri,  5 Jun 2026 17:09:54 +0000 (UTC)
Received: from [10.22.88.138] (unknown [10.22.88.138])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAEB71800367;
	Fri,  5 Jun 2026 17:09:51 +0000 (UTC)
Message-ID: <e9257ecd-00b2-4767-838e-b335c6df6a39@redhat.com>
Date: Fri, 5 Jun 2026 13:09:50 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v6 1/6] cgroup/cpuset: Fix node inconsistencies
 between cpuset_update_tasks_nodemask() and cpuset_attach()
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260604150229.414135-1-longman@redhat.com>
 <20260604150229.414135-2-longman@redhat.com>
 <fb65a2f6-8ab0-43d0-b9e7-d223ec1a671d@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <fb65a2f6-8ab0-43d0-b9e7-d223ec1a671d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16679-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBDD064A14F

On 6/5/26 3:48 AM, Ridong Chen wrote:
>
> On 6/4/2026 11:02 PM, Waiman Long wrote:
>> Whenever memory node mask is changed, there are 4 places where the node
>> mask has to be updated or used.
>>   1) task's node mask via cpuset_change_task_nodemask()
>>   2) memory policy binding via mpol_rebind_mm()
>>   3) if memory migration is enabled, migrate from old_mems_allowed to
>>      the new node mask via cpuset_migrate_mm().
>>   4) setting old_mems_allowed
>>
>> These memory actions are done in cpuset_update_tasks_nodemask() and
>> cpuset_attach(). However there are inconsistencies in what node masks
>> are being used in these 2 functions.
>>
>> In cpuset_update_tasks_nodemask(),
>>   - cpuset_change_task_nodemask(): guarantee_online_mems()
>>   - mpol_rebind_mm(): mems_allowed
>>   - cpuset_migrate_mm(): guarantee_online_mems()
>>   - old_mems_allowed: guarantee_online_mems()
>>
>> In cpuset_attach(),
>>   - cpuset_change_task_nodemask(): guarantee_online_mems()
>>   - mpol_rebind_mm(): effective_mems
>>   - cpuset_migrate_mm(): effective_mems
>>   - old_mems_allowed: effective_mems
>>
>> These inconsistencies dates back to quite a long time ago and it is
>> hard to say what should be the correct values.
>>
>> The guarantee_online_mems() function returns a node mask from current or
>> an ancestor cpuset that is a subset of node_states[N_MEMORY]. Nodes in
>> node_states[N_MEMORY] are all online, i.e. in node_states[N_ONLINE].
>> However, node in node_states[N_ONLINE] may not have memory. So
>> node_states[N_MEMORY] should be a subset of node_states[N_ONLINE].
>>
>> The guarantee_online_mems() function should only be useful for v1 where
>> mems_allowed is the same as effective_mems. With v2, the memory nodes
>> in effective_mems should always be a subset of node_states[N_MEMORY].
>> The only time that may not be true is when a memory hot-unplug operation
>> is in progress and a memory node is removed from node_states[N_MEMORY]
>> but not yet reflected in effective_mems as cpuset_handle_hotplug()
>> has not yet been called from cpuset_track_online_nodes(). When
>> cpuset_handle_hotplug() is called later, the memory node setting
>> of the relevant cpusets and tasks will be updated. So replacing the
>> guarantee_online_mems() call by just using cs->effective_mems should
>> be fine.
>>
> The message should be updated.
Could you be more specific about what message are you referring to?
>
>> Let use the following setup for both of them and make them consistent.
>>   - cpuset_change_task_nodemask(): guarantee_online_mems()
>>   - mpol_rebind_mm(): effective_mems
>>   - cpuset_migrate_mm(): guarantee_online_mems()
>>   - old_mems_allowed: guarantee_online_mems()
>>
>> So for v2, it is effectively all effective_mems. For v1, mpol_rebind_mm()
>> uses mems_allowed which may differ from what guarantee_online_mems()
>> returns.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 37 +++++++++++++++++++++++++------------
>>   1 file changed, 25 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 6bdb68689c24..8305b5830c3c 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -489,7 +489,10 @@ static void guarantee_active_cpus(struct task_struct *tsk,
>>    * Return in *pmask the portion of a cpusets's mems_allowed that
>>    * are online, with memory.  If none are online with memory, walk
>>    * up the cpuset hierarchy until we find one that does have some
>> - * online mems.  The top cpuset always has some mems online.
>> + * online mems.  The top cpuset always has some mems online. With v2,
>> + * effective_mems should always contain online memory nodes except
>> + * during the transition period where a memory node hotunplug operation
>> + * is in progress.
>>    *
>>    * One way or another, we guarantee to return some non-empty subset
>>    * of node_states[N_MEMORY].
>> @@ -498,6 +501,10 @@ static void guarantee_active_cpus(struct task_struct *tsk,
>>    */
>>   static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>>   {
>> +	if (cpuset_v2()) {
>> +		*pmask = cs->effective_mems;
>> +		return;
>> +	}
>>   	while (!nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]))
>>   		cs = parent_cs(cs);
>>   }
>> @@ -2616,6 +2623,13 @@ static void *cpuset_being_rebound;
>>    * Iterate through each task of @cs updating its mems_allowed to the
>>    * effective cpuset's.  As this function is called with cpuset_mutex held,
>>    * cpuset membership stays stable.
>> + *
>> + * - cpuset_change_task_nodemask(): guarantee_online_mems()
>> + * - mpol_rebind_mm(): effective_mems
>> + * - cpuset_migrate_mm(): guarantee_online_mems()
>> + * - old_mems_allowed: guarantee_online_mems()
>> + *
>> + * For v2, guarantee_online_mems() should just return effective_mems.
>>    */
>>   void cpuset_update_tasks_nodemask(struct cpuset *cs)
>>   {
>> @@ -2624,7 +2638,6 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>>   	struct task_struct *task;
>>   
>>   	cpuset_being_rebound = cs;		/* causes mpol_dup() rebind */
>> -
>>   	guarantee_online_mems(cs, &newmems);
>>   
>>   	/*
>> @@ -2650,7 +2663,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>>   
>>   		migrate = is_memory_migrate(cs);
>>   
>> -		mpol_rebind_mm(mm, &cs->mems_allowed);
>> +		mpol_rebind_mm(mm, &cs->effective_mems);
>>   		if (migrate)
>>   			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>>   		else
>> @@ -3148,17 +3161,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>   
>>   	/*
>>   	 * In the default hierarchy, enabling cpuset in the child cgroups
>> -	 * will trigger a number of cpuset_attach() calls with no change
>> -	 * in effective cpus and mems. In that case, we can optimize out
>> -	 * by skipping the task iteration and update.
>> +	 * will trigger a cpuset_attach() call with no change in effective cpus
>> +	 * and mems. In that case, we can optimize out by skipping the task
>> +	 * iteration and update.
>>   	 */
>> -	if (cpuset_v2() && !cpus_updated && !mems_updated) {
>> +	if (cpuset_v2()) {
>>   		cpuset_attach_nodemask_to = cs->effective_mems;
>> -		goto out;
>> +		if (!cpus_updated && !mems_updated)
>> +			goto out;
>> +	} else {
>> +		guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>>   	}
>>   
>> -	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>> -
> Nit.
>
> I prefer:
>
> 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> 	if (cpuset_v2() && !cpus_updated && !mems_updated)
> 		goto out;

This is fixed in patch 7. I may have to send a new version of the patch 
7 integrated back into individual patches.

Cheers,
Longman

>>   	cgroup_taskset_for_each(task, css, tset)
>>   		cpuset_attach_task(cs, task);
>>   
>> @@ -3168,7 +3182,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>   	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
>>   	 * not set.
>>   	 */
>> -	cpuset_attach_nodemask_to = cs->effective_mems;
>>   	if (!is_memory_migrate(cs) && !mems_updated)
>>   		goto out;
>>   
>> @@ -3176,7 +3189,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>   		struct mm_struct *mm = get_task_mm(leader);
>>   
>>   		if (mm) {
>> -			mpol_rebind_mm(mm, &cpuset_attach_nodemask_to);
>> +			mpol_rebind_mm(mm, &cs->effective_mems);
>>   
>>   			/*
>>   			 * old_mems_allowed is the same with mems_allowed
> Other than that, looks good to me.
>
> Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
>


