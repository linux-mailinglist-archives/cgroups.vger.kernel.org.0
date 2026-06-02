Return-Path: <cgroups+bounces-16582-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0WwIBm4kH2o+iAAAu9opvQ
	(envelope-from <cgroups+bounces-16582-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:43:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4146312D0
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 20:43:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=BKnYeyG+;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16582-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16582-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19B39300D750
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 18:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24897396D25;
	Tue,  2 Jun 2026 18:43:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC7439769A
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 18:43:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425833; cv=none; b=aZds4fNqOtp+w+Sb6EpbDN1mZQSYZBs7KJ4qFgfvUGA941II5O+a9QqSgTxX2mjnsMzko8fcxjkBBRvokBgVRXrRRVDu8+0iBf7+BN524njFYscq92BfJe7Sphqx2RFk9AwjygzlgYN1OkjNSaAT66wJjtSJ7/EFHdoOS7eChbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425833; c=relaxed/simple;
	bh=zElxct/1WT2b2tunA3asgRCmTw4qu4z24mKu4YFjIZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MEVwxp5m/X2Y4iv6wPEthyM1mG9jNu+dCnj8IH4/08yiG+7UlEHr6Z1v7jcjOcM154fX2dUBniUCN6M0+qgQogbYOso+TrjUQvSJSdxkxUhucsdNg8csskVnkcoAi3YGXzdDUCKg43Anm4kXD+pFLjt4cG5+PjOsxoxBfIo8nRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BKnYeyG+; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780425830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pt/RaQD8UDkqYaD1i19wIsnd5MdkfcYYg50zQvKOJS0=;
	b=BKnYeyG+eMCqZCtYYmYzwFYt7xcXeK2omkxa4G90J/uKwmeHF3tqOp44uLqC/nSYH2qqee
	Sr7SvPjal9DjpFLHZt0ZhY0/uN7YYA6knUnlfqZqnu1IQatAyRrCD4dVHraNpFqAft6ojN
	Ku3RkUT57hQorwxP7t3k39t7KNmj9dY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-4n9xTPoDMvexAsgRHxX0zw-1; Tue,
 02 Jun 2026 14:43:46 -0400
X-MC-Unique: 4n9xTPoDMvexAsgRHxX0zw-1
X-Mimecast-MFC-AGG-ID: 4n9xTPoDMvexAsgRHxX0zw_1780425823
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DE4D51956079;
	Tue,  2 Jun 2026 18:43:41 +0000 (UTC)
Received: from [10.22.80.32] (unknown [10.22.80.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 274B31800352;
	Tue,  2 Jun 2026 18:43:38 +0000 (UTC)
Message-ID: <3f44a33e-dc4b-479c-9572-a02cacfc7af2@redhat.com>
Date: Tue, 2 Jun 2026 14:43:38 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v5 1/6] cgroup/cpuset: Fix node inconsistencies
 between cpuset_update_tasks_nodemask() and cpuset_attach()
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>, Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260602023203.248077-1-longman@redhat.com>
 <20260602023203.248077-2-longman@redhat.com>
 <a69816f1-6cce-4123-92ec-1ade963061f9@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <a69816f1-6cce-4123-92ec-1ade963061f9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16582-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AA4146312D0

On 6/2/26 9:37 AM, Ridong Chen wrote:
>
> On 2026/6/2 10:31, Waiman Long wrote:
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
> I noticed this pattern in several places:
>
> ```
> if (cpuset_v2())
> 	newmems = cs->effective_mems;
> else
> 	guarantee_online_mems(cs, &newmems);
> ```
>
> Would it be simpler to move the v2 logic into guarantee_online_mems?
>
> ```
> static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
> {
> 	if (cpuset_v2()) {
> 		*pmask = cs->effective_mems;
> 		return;
> 	}
> 	while (!nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]))
> 		cs = parent_cs(cs);
> }
> ```
Yes, it makes sense to put it directly into guarantee_online_mems().
>> Let use the following setup for both of them and make them consistent.
>>   - cpuset_change_task_nodemask(): guarantee_online_mems()
>>   - mpol_rebind_mm(): effective_mems
>>   - cpuset_migrate_mm(): guarantee_online_mems()
>>   - old_mems_allowed: guarantee_online_mems()
>>
>> So for v2, it is effectively all effective_mems. For v1, mpol_rebind_mm()
>> uses cpus_allowed which may differ from what guarantee_online_mems()
> 	^
> mems_allowed?

Thanks for catching it. Will fix that and update your email address in 
the next version.

Cheers,
Longman

>> returns.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 32 +++++++++++++++++++++-----------
>>   1 file changed, 21 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 6bdb68689c24..987456b6d879 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -2616,6 +2616,13 @@ static void *cpuset_being_rebound;
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
> I agree, but the implementation is not as simple as what I mentioned above.
>
>>    */
>>   void cpuset_update_tasks_nodemask(struct cpuset *cs)
>>   {
>> @@ -2625,7 +2632,10 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>>   
>>   	cpuset_being_rebound = cs;		/* causes mpol_dup() rebind */
>>   
>> -	guarantee_online_mems(cs, &newmems);
>> +	if (cpuset_v2())
>> +		newmems = cs->effective_mems;
>> +	else
>> +		guarantee_online_mems(cs, &newmems);
>>   
>>   	/*
>>   	 * The mpol_rebind_mm() call takes mmap_lock, which we couldn't
>> @@ -2650,7 +2660,7 @@ void cpuset_update_tasks_nodemask(struct cpuset *cs)
>>   
>>   		migrate = is_memory_migrate(cs);
>>   
>> -		mpol_rebind_mm(mm, &cs->mems_allowed);
>> +		mpol_rebind_mm(mm, &cs->effective_mems);
>>   		if (migrate)
>>   			cpuset_migrate_mm(mm, &cs->old_mems_allowed, &newmems);
>>   		else
>> @@ -3148,17 +3158,18 @@ static void cpuset_attach(struct cgroup_taskset *tset)
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
>>   	cgroup_taskset_for_each(task, css, tset)
>>   		cpuset_attach_task(cs, task);
>>   
>> @@ -3168,7 +3179,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>   	 * if there is no change in effective_mems and CS_MEMORY_MIGRATE is
>>   	 * not set.
>>   	 */
>> -	cpuset_attach_nodemask_to = cs->effective_mems;
>>   	if (!is_memory_migrate(cs) && !mems_updated)
>>   		goto out;
>>   
>> @@ -3176,7 +3186,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>   		struct mm_struct *mm = get_task_mm(leader);
>>   
>>   		if (mm) {
>> -			mpol_rebind_mm(mm, &cpuset_attach_nodemask_to);
>> +			mpol_rebind_mm(mm, &cs->effective_mems);
>>   
>>   			/*
>>   			 * old_mems_allowed is the same with mems_allowed


