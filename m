Return-Path: <cgroups+bounces-17458-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EoywAzNQR2oJWAAAu9opvQ
	(envelope-from <cgroups+bounces-17458-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 08:01:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B35E6FEEA6
	for <lists+cgroups@lfdr.de>; Fri, 03 Jul 2026 08:01:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=HHi9bWNa;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17458-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17458-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 617CF30449A5
	for <lists+cgroups@lfdr.de>; Fri,  3 Jul 2026 05:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3E3603EF;
	Fri,  3 Jul 2026 05:56:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66624366553
	for <cgroups@vger.kernel.org>; Fri,  3 Jul 2026 05:56:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783058216; cv=none; b=Iz+dudHRlYfJh8UY5SWdnWa48enmQFsmv1AZKQjf3GePxHQDFgpRLBLZ86P+t9ml/8eLMVmxGQQZgFIrlVDGH//hnKBjn5JsES34TTQ7kZNvKGq83FHKMEkYG2Luk+yAjPlogUzpr+J8rqtoPJ/isTvKS+EFYJ3aBTXgwkiEE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783058216; c=relaxed/simple;
	bh=3sYzbaBmtugcRQJyp0gpMkQF6yclm1aMLvUq9SjdyiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b77FIU4dHDmkeHOEXwzllibBkdj/t+pwixoKddnew9r5s172/EUKSZ4x4/oO5kYzB6bm5PJ6JS6gT1vdRSFFMbLo0pzICdo7J6QrPjvdcnAS+c6JMRHBTKNzHGrClPT5z8gGkmU5uI4GKI8RmBq+NIWVuxXC9CzPM2QqJuw3MNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHi9bWNa; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783058213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y64fWAWHPb6LXJKvL5ApTJBG1MuBOUvs4HV2l3FDgHQ=;
	b=HHi9bWNaFSKsQ7M+9Qy4ymsDNyUpPHvH9fnSK1FCf6D0dA2xcpTybq6mlYH4l0Eji4uXOk
	kh2R+zPKgzV7v1GMt3opkZgHc//QIlAUgIMVM+FRX2X5ngkPlauDd0k19PkSA3jdVEhbbi
	k7prbBVDPaJLLDAFQRYcYXtHom5IQLk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-egeHS9_gM4S6XNtPCbOknQ-1; Fri,
 03 Jul 2026 01:56:49 -0400
X-MC-Unique: egeHS9_gM4S6XNtPCbOknQ-1
X-Mimecast-MFC-AGG-ID: egeHS9_gM4S6XNtPCbOknQ_1783058207
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B0F81944AB4;
	Fri,  3 Jul 2026 05:56:47 +0000 (UTC)
Received: from [10.2.16.58] (unknown [10.2.16.58])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EDE51800613;
	Fri,  3 Jul 2026 05:56:42 +0000 (UTC)
Message-ID: <7d40ab06-7f1c-4cd8-84a0-552c53e2ca20@redhat.com>
Date: Fri, 3 Jul 2026 01:56:41 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v10 10/11] cgroup/cpuset: Support multiple
 destination cpusets for cpuset_*attach()
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>
References: <20260702214757.579012-1-longman@redhat.com>
 <20260702214757.579012-11-longman@redhat.com>
 <5a8b4500-7cab-4ef6-ae96-b0f794ee51a9@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <5a8b4500-7cab-4ef6-ae96-b0f794ee51a9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17458-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:juri.lelli@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B35E6FEEA6

On 7/2/26 11:31 PM, Ridong Chen wrote:
>
>
> On 7/3/2026 5:47 AM, Waiman Long wrote:
>> The only case where the cgroup_taskset structure requires task migration
>> to multiple cpusets is when enabling a cpuset controller in cgroup v2
>> where the newly created child cpusets inherits the same effective CPUs
>> and memory nodes from the parent. In that case, task migration can 
>> happen
>> directly with no update to tasks' CPU and memory nodes assignment and no
>> further work needed from the cpuset side except updating 
>> nr_deadline_tasks
>> when DL tasks are involved and setting old_mems_allowed in the child
>> cpusets.
>>
>> Do that by tracking all the destination cpusets with a new dst_cs_head
>> singly linked list. The reset_migrate_dl_data() function is integrated
>> into clear_attach_data() so that it can be used for both source and
>> destination cpusets.
>>
>> It is assumed that a given cpuset cannot be both a source and a
>> destination cpuset. If such condition happens or when there are multiple
>> destination cpusets with CPU or memory nodes changes, the current code
>> will not handle it correctly. So it will print a warning and fail the
>> attach operation in these unexpected cases as we will have to enhance 
>> the
>> code to support this if such use cases are valid and not coding errors.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h |   1 +
>>   kernel/cgroup/cpuset.c          | 115 ++++++++++++++++++++------------
>>   2 files changed, 72 insertions(+), 44 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h 
>> b/kernel/cgroup/cpuset-internal.h
>> index e7d010661fd3..d1161b0a3d85 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -149,6 +149,7 @@ struct cpuset {
>>        * For linking impacted cpusets during an attach operation.
>>        */
>>       struct llist_node attach_node;
>> +    bool attach_source;
>>         /* partition root state */
>>       int partition_root_state;
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 4bbfae041b63..cf14dc506a40 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -366,10 +366,12 @@ static struct {
>>       bool cpus_updated;
>>       bool mems_updated;
>>       bool task_work_queued;
>> +    bool many_dest_cs;    /* Have many destination cpusets */
>>       struct cpuset *old_cs;    /* Source cpuset */
>>       nodemask_t nodemask_to;
>>   } attach_ctx;
>>   static LLIST_HEAD(src_cs_head);
>> +static LLIST_HEAD(dst_cs_head);
>
> Nit.
>
> Would it make sense to move src_cs_head/dst_cs_head into attach_ctx?

I had thought about it, but it is more simple to just use LIST_HEAD() 
macro than explicitly initialize just the two llist_head's in the structure.

Cheers,
Longman

>
>>   /*
>>    * Wait if task attach is in progress until it is done and then 
>> acquire
>> @@ -3044,8 +3046,23 @@ static int cpuset_can_attach_check(struct 
>> cpuset *cs, struct cpuset *oldcs,
>>       if (!oldcs)
>>           return 0;
>>   -    if (!llist_on_list(&oldcs->attach_node))
>> +    /*
>> +     * The same cpuset cannot be both a source and a destination.
>> +     * The current code does not support that, print a warning and
>> +     * fail the attach if so.
>> +     */
>> +    if (WARN_ON_ONCE((!oldcs->attach_source &&
>> +              llist_on_list(&oldcs->attach_node)) ||
>> +              cs->attach_source))
>> +        return -EINVAL;
>> +
>> +    if (!llist_on_list(&oldcs->attach_node)) {
>>           llist_add(&oldcs->attach_node, &src_cs_head);
>> +        oldcs->attach_source = true;
>> +    }
>> +
>> +    if (!llist_on_list(&cs->attach_node))
>> +        llist_add(&cs->attach_node, &dst_cs_head);
>>         cpus_updated = !cpumask_equal(cs->effective_cpus, 
>> oldcs->effective_cpus);
>>       mems_updated = !nodes_equal(cs->effective_mems, 
>> oldcs->effective_mems);
>> @@ -3075,35 +3092,31 @@ static int cpuset_can_attach_check(struct 
>> cpuset *cs, struct cpuset *oldcs,
>>       return 0;
>>   }
>>   -static int cpuset_reserve_dl_bw(struct cpuset *cs)
>> +static int cpuset_reserve_dl_bw(void)
>>   {
>> +    struct cpuset *cs;
>>       int cpu, ret;
>>   -    if (!cs->sum_migrate_dl_bw)
>> -        return 0;
>> +    llist_for_each_entry(cs, dst_cs_head.first, attach_node) {
>> +        if (!cs->sum_migrate_dl_bw)
>> +            continue;
>>   -    cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
>> -    if (unlikely(cpu >= nr_cpu_ids))
>> -        return -EINVAL;
>> +        cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
>> +        if (unlikely(cpu >= nr_cpu_ids))
>> +            return -EINVAL;
>>   -    ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
>> -    if (ret)
>> -        return ret;
>> +        ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
>> +        if (ret)
>> +            return ret;
>>   -    cs->dl_bw_cpu = cpu;
>> +        cs->dl_bw_cpu = cpu;
>> +    }
>>       return 0;
>>   }
>>   -static void reset_migrate_dl_data(struct cpuset *cs)
>> -{
>> -    cs->nr_migrate_dl_tasks = 0;
>> -    cs->sum_migrate_dl_bw = 0;
>> -    cs->dl_bw_cpu = -1;
>> -}
>> -
>>   /*
>>    * Clear and optionally apply (@cancel is false) the attach related 
>> data in the
>> - * source cpusets.
>> + * source or destination cpuset.
>>    */
>>   static void clear_attach_data(struct llist_head *head, bool cancel)
>>   {
>> @@ -3115,8 +3128,13 @@ static void clear_attach_data(struct 
>> llist_head *head, bool cancel)
>>           if (cs->nr_migrate_dl_tasks) {
>>               if (!cancel)
>>                   atomic_add(cs->nr_migrate_dl_tasks, 
>> &cs->nr_deadline_tasks);
>> +            else if (cs->dl_bw_cpu >= 0) /* && cacnel */
>> +                dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
>>               cs->nr_migrate_dl_tasks = 0;
>> +            cs->sum_migrate_dl_bw = 0;
>> +            cs->dl_bw_cpu = -1;
>>           }
>> +        cs->attach_source = false;
>>       }
>>   }
>>   @@ -3137,6 +3155,7 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>       mutex_lock(&cpuset_mutex);
>>       attach_ctx.cpus_updated = false;
>>       attach_ctx.mems_updated = false;
>> +    attach_ctx.many_dest_cs = false;
>>         /* Check to see if task is allowed in the cpuset */
>>       ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
>> @@ -3161,9 +3180,13 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>        * selected as attach_ctx.old_cs.
>>        */
>>       cgroup_taskset_for_each(task, css, tset) {
>> +        struct cpuset *new_cs = css_cs(css);
>>           struct cpuset *new_oldcs = task_cs(task);
>>   -        if (new_oldcs != oldcs) {
>> +        if ((new_oldcs != oldcs) || (new_cs != cs)) {
>> +            if (new_cs != cs)
>> +                attach_ctx.many_dest_cs = true;
>> +            cs = new_cs;
>>               oldcs = new_oldcs;
>>               ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
>>               if (ret)
>> @@ -3197,12 +3220,28 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>           }
>>       }
>>   -    ret = cpuset_reserve_dl_bw(cs);
>> +    /*
>> +     * The only case where there are multiple destination cpusets for
>> +     * task migration is when enabling a v2 cpuset controllers where
>> +     * tasks will be migrated to multiple child cpusets from a parent
>> +     * cpuset with the same effective CPUs and memory nodes. IOW,
>> +     * both attach_cpus_updated and attach_mems_updated should be 
>> false.
>> +     * If not, it is a condition that the current code cannot handled.
>> +     * Print a warning and abort the attach operation as further code
>> +     * change will be needed.
>> +     */
>> +    if (WARN_ON_ONCE(attach_ctx.many_dest_cs && (!cpuset_v2() ||
>> +             attach_ctx.cpus_updated || attach_ctx.mems_updated))) {
>> +        ret = -EINVAL;
>> +        goto out_unlock;
>> +    }
>> +
>> +    ret = cpuset_reserve_dl_bw();
>>     out_unlock:
>>       if (ret) {
>> -        reset_migrate_dl_data(cs); /* Destination cpuset only */
>>           clear_attach_data(&src_cs_head, true);
>> +        clear_attach_data(&dst_cs_head, true);
>>       } else {
>>           attach_ctx.in_progress++;
>>       }
>> @@ -3213,22 +3252,10 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>     static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>>   {
>> -    struct cgroup_subsys_state *css;
>> -    struct cpuset *cs;
>> -
>> -    cgroup_taskset_first(tset, &css);
>> -    cs = css_cs(css);
>> -
>>       mutex_lock(&cpuset_mutex);
>>       dec_attach_in_progress_locked();
>>       clear_attach_data(&src_cs_head, true);
>> -
>> -    if (cs->dl_bw_cpu >= 0)
>> -        dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
>> -
>> -    if (cs->nr_migrate_dl_tasks)
>> -        reset_migrate_dl_data(cs);
>> -
>> +    clear_attach_data(&dst_cs_head, true);
>>       mutex_unlock(&cpuset_mutex);
>>   }
>>   @@ -3311,25 +3338,25 @@ static void cpuset_attach(struct 
>> cgroup_taskset *tset)
>>        * In the default hierarchy, enabling cpuset in the child cgroups
>>        * will trigger a cpuset_attach() call with no change in 
>> effective cpus
>>        * and mems. In that case, we can optimize out by skipping the 
>> task
>> -     * iteration and update.
>> +     * iteration and updatebut the destination cpuset list is 
>> iterated to
>      updatebut -> update, but?> +     * set old_mems_allowed.
>>        */
>> -    if (cpuset_v2() && !attach_ctx.cpus_updated && 
>> !attach_ctx.mems_updated)
>> +    if (cpuset_v2() && !attach_ctx.cpus_updated && 
>> !attach_ctx.mems_updated) {
>> +        llist_for_each_entry(cs, dst_cs_head.first, attach_node)
>> +            cs->old_mems_allowed = attach_ctx.nodemask_to;
>>           goto out;
>> +    }
>>   +    /* Task iteration shouldn't happen with 
>> attach_ctx.many_dest_cs set */
>>       cgroup_taskset_for_each(task, css, tset)
>>           cpuset_attach_task(cs, task);
>>   -out:
>>       if (attach_ctx.task_work_queued)
>>           schedule_flush_migrate_mm();
>>       cs->old_mems_allowed = attach_ctx.nodemask_to;
>> -
>> -    if (cs->nr_migrate_dl_tasks) {
>> -        atomic_add(cs->nr_migrate_dl_tasks, &cs->nr_deadline_tasks);
>> -        reset_migrate_dl_data(cs);
>> -    }
>> -
>> +out:
>>       clear_attach_data(&src_cs_head, false);
>> +    clear_attach_data(&dst_cs_head, false);
>>       dec_attach_in_progress_locked();
>>         mutex_unlock(&cpuset_mutex);
>
> Reviewed-by: Ridong Chen <ridong.chen@linux.dev>
>


