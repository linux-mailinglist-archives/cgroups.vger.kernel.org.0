Return-Path: <cgroups+bounces-17381-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yxSRMHPpQmq+HwoAu9opvQ
	(envelope-from <cgroups+bounces-17381-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 23:53:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98A6DEF3A
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 23:53:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=MNoCUqWQ;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17381-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17381-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 470273024C80
	for <lists+cgroups@lfdr.de>; Mon, 29 Jun 2026 21:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4B395AD1;
	Mon, 29 Jun 2026 21:53:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8D71D86FF
	for <cgroups@vger.kernel.org>; Mon, 29 Jun 2026 21:53:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782770028; cv=none; b=NlId/6gFEh8gqLHSAoJbxB5V6CpZmRVf09NQKCkVo1ibYZ3cJE3w1y2fkiy5Q09Rbl5JC2dk/f1SVGY3hVy52WFhaAb/GmwdTUGQpfN3lpulDHrDkSATvuCvoM4ZxUGA27oRV2vIw6LnqGbFyPBuwkiMVITcBvwQTaNkAcMNcio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782770028; c=relaxed/simple;
	bh=wasBTdd8nx0mRXb6YT0lGTl4aFtDFGM6b+Ib/lpt+Zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=spFidLePEMLnt2Yg975MEWiZlDZYAOxaV02x/uKFN4RYTXtIMIPHgO+PaSci8Z3VDcYS3YyZlnDZ5SCrABtyMNzuSNzSuMoN0rxSyZnbxBAyeaWcdfwlSgfWReR8d46d+cZywM8ufSeZGODnA52zP1Fx/NpFzgtpddfL0S8Lozw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNoCUqWQ; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782770024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBTk4qHa0L+voLkz/kKo0AZ7D22i9f0HHtiRO+oSlD4=;
	b=MNoCUqWQOqfyKAni8n/St9JNhBWnr9HoNwq6FBUr1tYaMiR0umEBgz11f9GS8+zt+nphRe
	z7NL6duWvQQC7srg4O2wkvqAXquUrBYFch+3Xl7qt+P6Prx0Ytm7KtTn9um1D09pyhq7Jp
	0EQfViIF1KKTNmdcNMIAHz9pIFUva2M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-48lN469jM1qP0yG1_S64Zw-1; Mon,
 29 Jun 2026 17:53:40 -0400
X-MC-Unique: 48lN469jM1qP0yG1_S64Zw-1
X-Mimecast-MFC-AGG-ID: 48lN469jM1qP0yG1_S64Zw_1782770018
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 202C8180A8C0;
	Mon, 29 Jun 2026 21:53:38 +0000 (UTC)
Received: from [10.2.16.200] (unknown [10.2.16.200])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 965663652A;
	Mon, 29 Jun 2026 21:53:34 +0000 (UTC)
Message-ID: <6b9c7f81-b77a-4ab6-9e35-ece3bf4ad475@redhat.com>
Date: Mon, 29 Jun 2026 17:53:33 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 03/11] cgroup/cpuset: Prevent race between task attach
 and cpuset state change
To: Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Farhad Alemi <farhad.alemi@berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>, Gregory Price <gourry@gourry.net>,
 David Hildenbrand <david@kernel.org>
References: <20260626181923.133658-1-longman@redhat.com>
 <20260626181923.133658-4-longman@redhat.com>
 <e856149c-e4cf-430f-80e0-a6f402faec99@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <e856149c-e4cf-430f-80e0-a6f402faec99@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17381-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:farhad.alemi@berkeley.edu,m:akpm@linux-foundation.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:gourry@gourry.net,m:david@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D98A6DEF3A

On 6/29/26 3:14 AM, Ridong Chen wrote:
>
>
> On 6/27/2026 2:19 AM, Waiman Long wrote:
>> Commit e44193d39e8d ("cpuset: let hotplug propagation work wait for
>> task attaching") was introduced to let hotplug operation to wait
>> until the completion of task attach operation. However, it is still
>> possible that the states of the source or destination cpuset can
>> be changed between the cpuset_can_attach() call and the subsequent
>> cpuset_attach()/cpuset_cacnel_attach() call.
>>
>> As a result, data gathered during cpuset_can_attach() cannot be reliably
>> used in the subsequent cpuset_attach()/cpuset_cacnel_attach()
>> call at all. Make the task attach operation more robust
>> and allow the sharing of data between cpuset_can_attach() and
>> cpuset_attach()/cpuset_cacnel_attach() by making cpuset_write_resmask()
>> and cpuset_partition_write() wait for the completion of task attach
>> as well.
>>
>> Ideally, an ongoing task attach operation should block any cpuset write
>> operation that can change its internal state until the operation is
>> completed. However, the attach_in_progress flag is currently per cpuset
>> and only the destination cpuset will have this flag set. The flag is not
>> set in the source cpuset where the tasks will be moved from. Even if we
>> extend the scope to include the source cpuset, it will not block cpuset
>> operation that changes the state of one of its ancestor cpuset which may
>> indirectly impact the state of the source or destination cpuset. It may
>> be too costly to set the flag for the whole subtree, it is far easier
>> to just make the flag global and block all the cpuset write operation
>> whenever a task attach operation is in progress. Make that change by
>> creating a new cpuset attach context (attach_ctx) structure to hold the
>> global in_progress flag and use it for blocking cpuset write operation
>> if a cpuset attach operation is in progress.
>>
>> The comments about validate_change() are no longer valid as it won't
>> be called at all if an attach operation is in progress. So the comments
>> can be removed.
>>
>> The per-cpuset attach_in_progress flag is also currently used in
>> partition_is_populated() and cpuset_is_populated() to determine if
>> an empty cpuset will have incoming task. This check will no longer be
>> needed as this function will not be called when there is a task attach
>> in progress. So the flag check is now removed.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h | 11 +-----
>>   kernel/cgroup/cpuset.c          | 68 +++++++++++++++++++++------------
>>   2 files changed, 44 insertions(+), 35 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h 
>> b/kernel/cgroup/cpuset-internal.h
>> index f7aaf01f7cd5..817b86ba7019 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -145,12 +145,6 @@ struct cpuset {
>>        */
>>       nodemask_t old_mems_allowed;
>>   -    /*
>> -     * Tasks are being attached to this cpuset.  Used to prevent
>> -     * zeroing cpus/mems_allowed between ->can_attach() and ->attach().
>> -     */
>> -    int attach_in_progress;
>> -
>>       /* partition root state */
>>       int partition_root_state;
>>   @@ -269,10 +263,7 @@ static inline int nr_cpusets(void)
>>   static inline bool cpuset_is_populated(struct cpuset *cs)
>>   {
>>       lockdep_assert_cpuset_lock_held();
>> -
>> -    /* Cpusets in the process of attaching should be considered as 
>> populated */
>> -    return cgroup_is_populated(cs->css.cgroup) ||
>> -        cs->attach_in_progress;
>> +    return cgroup_is_populated(cs->css.cgroup);
>>   }
>>     /**
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d108c2083e86..dec9785d0271 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -356,6 +356,14 @@ static struct workqueue_struct 
>> *cpuset_migrate_mm_wq;
>>     static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
>>   +/*
>> + * Cpuset task attach context
>> + * Protected by cpuset_mutex
>> + */
>> +static struct {
>> +    int in_progress;
>> +} attach_ctx;
>> +
>>   static inline void check_insane_mems_config(nodemask_t *nodes)
>>   {
>>       if (!cpusets_insane_config() &&
>> @@ -368,22 +376,22 @@ static inline void 
>> check_insane_mems_config(nodemask_t *nodes)
>>   }
>>     /*
>> - * decrease cs->attach_in_progress.
>> - * wake_up cpuset_attach_wq if cs->attach_in_progress==0.
>> + * decrease attach_ctx.in_progress.
>> + * wake_up cpuset_attach_wq if attach_ctx.in_progress==0.
>>    */
>> -static inline void dec_attach_in_progress_locked(struct cpuset *cs)
>> +static inline void dec_attach_in_progress_locked(void)
>>   {
>>       lockdep_assert_cpuset_lock_held();
>>   -    cs->attach_in_progress--;
>> -    if (!cs->attach_in_progress)
>> +    attach_ctx.in_progress--;
>> +    if (!attach_ctx.in_progress)
>>           wake_up(&cpuset_attach_wq);
>>   }
>>   -static inline void dec_attach_in_progress(struct cpuset *cs)
>> +static inline void dec_attach_in_progress(void)
>>   {
>>       mutex_lock(&cpuset_mutex);
>> -    dec_attach_in_progress_locked(cs);
>> +    dec_attach_in_progress_locked();
>>       mutex_unlock(&cpuset_mutex);
>>   }
>>   @@ -432,8 +440,7 @@ static inline bool 
>> partition_is_populated(struct cpuset *cs,
>>        * nr_populated_domain_children may include populated
>>        * csets from descendants that are partitions.
>>        */
>> -    if (cgroup_has_tasks(cs->css.cgroup) ||
>> -        cs->attach_in_progress)
>> +    if (cgroup_has_tasks(cs->css.cgroup))
>>           return true;
>>         rcu_read_lock();
>> @@ -3091,11 +3098,7 @@ static int cpuset_can_attach(struct 
>> cgroup_taskset *tset)
>>       cs->dl_bw_cpu = cpu;
>>     out_success:
>> -    /*
>> -     * Mark attach is in progress.  This makes validate_change() fail
>> -     * changes which zero cpus/mems_allowed.
>> -     */
>> -    cs->attach_in_progress++;
>> +    attach_ctx.in_progress++;
>>     out_unlock:
>>       if (ret)
>> @@ -3113,7 +3116,7 @@ static void cpuset_cancel_attach(struct 
>> cgroup_taskset *tset)
>>       cs = css_cs(css);
>>         mutex_lock(&cpuset_mutex);
>> -    dec_attach_in_progress_locked(cs);
>> +    dec_attach_in_progress_locked();
>>         if (cs->dl_bw_cpu >= 0)
>>           dl_bw_free(cs->dl_bw_cpu, cs->sum_migrate_dl_bw);
>> @@ -3226,7 +3229,7 @@ static void cpuset_attach(struct cgroup_taskset 
>> *tset)
>>           reset_migrate_dl_data(cs);
>>       }
>>   -    dec_attach_in_progress_locked(cs);
>> +    dec_attach_in_progress_locked();
>>         mutex_unlock(&cpuset_mutex);
>>   }
>> @@ -3246,10 +3249,19 @@ ssize_t cpuset_write_resmask(struct 
>> kernfs_open_file *of,
>>           return -EACCES;
>>         buf = strstrip(buf);
>> +retry:
>> +    wait_event(cpuset_attach_wq, attach_ctx.in_progress == 0);
>> +
>>       cpuset_full_lock();
>>       if (!is_cpuset_online(cs))
>>           goto out_unlock;
>>   +    /* Don't race with task attach */
>> +    if (attach_ctx.in_progress) {
>> +        cpuset_full_unlock();
>> +        goto retry;
>> +    }
>> +
>>       trialcs = dup_or_alloc_cpuset(cs);
>>       if (!trialcs) {
>>           retval = -ENOMEM;
>> @@ -3377,7 +3389,17 @@ static ssize_t cpuset_partition_write(struct 
>> kernfs_open_file *of, char *buf,
>>       else
>>           return -EINVAL;
>>   +retry:
>> +    wait_event(cpuset_attach_wq, attach_ctx.in_progress == 0);
>> +
>>       cpuset_full_lock();
>> +
>> +    /* Don't race with task attach */
>> +    if (attach_ctx.in_progress) {
>> +        cpuset_full_unlock();
>> +        goto retry;
>> +    }
>> +
>
> Would it make sense to add a helper like wait_attach_done_locked()?

I guess we can add a helper to do that.

Thanks for the suggestions.

Cheers,
Longman



