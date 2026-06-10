Return-Path: <cgroups+bounces-16828-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ywGZFzuPKWomZgMAu9opvQ
	(envelope-from <cgroups+bounces-16828-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 18:22:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEC766B61B
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 18:22:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=esb2t0XX;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16828-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16828-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D3036FDD9D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC57495506;
	Wed, 10 Jun 2026 15:43:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1B44963B5
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 15:43:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781106182; cv=none; b=oPhj9zwEpiSayLCejCI95YgWBYAyPXa+3bLWpMGCYCbnwujeKtnk6DCgnXD9lnluCwZ1Tw8yFcuzjB4+ugBRsMMuNF/gMg3J1bMCWhoOv4vPx6lRFgSjoQTXE2U3iE4MtZAtz9flgVVODu/RmXJj/98ygPj/BwYGJw18Ky6Fcmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781106182; c=relaxed/simple;
	bh=0oR1qvb22dc+OExU0QYrrizxoPflOHo+J/KXjQ88hvY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SL5LshvCBSxO50ntQHjsXmRSFFPo46o6EG0w/iVr3PklLpx2B2/wDh7kmGySmNCdndSTVCkTXYZxMrV7l+OgsW6/qJ40CYzxi4JJ43GFV0mPgFJ3gR3ra+H7OniGYMSQN+fiUHO01vZnwQYFvj7Xd/+MirHVh5LedwjTE0BzCdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esb2t0XX; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781106180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHR5VsZRG/XRONgVNxWJZvyiTccBL9d9QwrMa6akIoQ=;
	b=esb2t0XXshxdaeNx/hw2B/r4/Cx1ahd7fkAdYko8k7I8r53sifofZDeQk0LBGoAmR4ikUD
	vGSqRuIXFsxa7SW0otmSMh630t0kMJlJkrX8nWQzelff0TOPI7DxHANaCeKFIcuTBciYuN
	ktvrQ7dfZwj0t1dsVWf7WCoySke7/Vg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-76zeZShlOGWp1FmRFNxjtQ-1; Wed,
 10 Jun 2026 11:42:54 -0400
X-MC-Unique: 76zeZShlOGWp1FmRFNxjtQ-1
X-Mimecast-MFC-AGG-ID: 76zeZShlOGWp1FmRFNxjtQ_1781106172
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1C3C1964CFE;
	Wed, 10 Jun 2026 15:42:51 +0000 (UTC)
Received: from [10.22.81.61] (unknown [10.22.81.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2B87D18005B7;
	Wed, 10 Jun 2026 15:42:48 +0000 (UTC)
Message-ID: <0cbc8a90-8e88-4227-bea5-f12fb0f293db@redhat.com>
Date: Wed, 10 Jun 2026 11:42:47 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] sched/fair: Add cgroup_mode: max
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc: chenridong@huaweicloud.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com,
 qyousef@layalina.io
References: <20260605105513.354837583@infradead.org>
 <20260605124051.589618504@infradead.org>
 <d4ca5fe7-fd76-47c8-949a-a69916bfcbd4@redhat.com>
Content-Language: en-US
In-Reply-To: <d4ca5fe7-fd76-47c8-949a-a69916bfcbd4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
	TAGGED_FROM(0.00)[bounces-16828-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@kernel.org,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACEC766B61B

On 6/10/26 11:09 AM, Waiman Long wrote:
> On 6/5/26 8:40 AM, Peter Zijlstra wrote:
>> In order to avoid the average CPU fraction avg(F_g_n) becoming tiny 
>> '1/N',
>> assume each cgroup is maximally concurrent and distrubute 'N*weight', 
>> such
>> that:
>>
>>     F_g_n' = N * F_g_n
>>
>> Giving:
>>
>>     avg(F_g_n') = N*avg(F_g_n) ~ N * 1/N = 1
>>
>> And while this sounds like it solves things, remember what that ~ 
>> meant. There
>> is the corner case when a cgroup is minimally loaded, eg a single 
>> runnable
>> task, therefore limit the CPU fraction to that of a nice -20 task to 
>> avoid
>> getting too much load.
>>
>> This last bit is what makes it different from a previous proposal to 
>> allow
>> raising cpu.weight to '100 * N', that would not limit the mininal 
>> concurrency
>> case and results in a very large F_g_n. And just like F_g_n << 1 is
>> problematic, so is F_g_n >> 1 for the exact same reasons (it would 
>> drown the
>> kthreads, but it also risks overflowing the load values).
>>
>> So while this might appear to be a better scheme than the current 
>> default
>> scheme, it doesn't really handle less than maximal concurrency nicely 
>> -- it
>> clips and introduces artificially large weights. So where the 
>> traditional SMP
>> mode works well when nr_tasks << nr_cpus, MAX doesn't work well in 
>> that regime
>> and vice-versa.
>>
>> The meaning of "cpu.weight" would be: weight per allowed CPU.
>>
>> Included for completeness (and infrastructure).
>>
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> ---
>>   include/linux/cpuset.h |    6 +++++
>>   kernel/cgroup/cpuset.c |   15 ++++++++++++++
>>   kernel/sched/debug.c   |    1
>>   kernel/sched/fair.c    |   52 
>> ++++++++++++++++++++++++++++++++++++++++++++-----
>>   4 files changed, 69 insertions(+), 5 deletions(-)
>>
>> --- a/include/linux/cpuset.h
>> +++ b/include/linux/cpuset.h
>> @@ -80,6 +80,7 @@ extern void lockdep_assert_cpuset_lock_h
>>   extern void cpuset_cpus_allowed_locked(struct task_struct *p, 
>> struct cpumask *mask);
>>   extern void cpuset_cpus_allowed(struct task_struct *p, struct 
>> cpumask *mask);
>>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>> +extern int cpuset_num_cpus(struct cgroup *cgroup);
>>   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>>   #define cpuset_current_mems_allowed (current->mems_allowed)
>>   void cpuset_init_current_mems_allowed(void);
>> @@ -216,6 +217,11 @@ static inline bool cpuset_cpus_allowed_f
>>       return false;
>>   }
>>   +static inline int cpuset_num_cpus(struct cgroup *cgroup)
>> +{
>> +    return num_online_cpus();
>> +}
>> +
>>   static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
>>   {
>>       return node_possible_map;
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -4116,6 +4116,21 @@ bool cpuset_cpus_allowed_fallback(struct
>>       return changed;
>>   }
>>   +int cpuset_num_cpus(struct cgroup *cgrp)
>> +{
>> +    int nr = num_online_cpus();
>> +    struct cpuset *cs;
>> +
>> +    if (is_in_v2_mode()) {
>> +        guard(rcu)();
>> +        cs = css_cs(cgroup_e_css(cgrp, &cpuset_cgrp_subsys));
>> +        if (cs)
>> +            nr = cpumask_weight(cs->effective_cpus);
>> +    }
>> +
>> +    return nr;
>> +}
>
> I just have a question about cgroup v1 support. I am assuming that 
> cgroup v1 without the cpuset_v2_mode mount option is not supported. To 
> fully support cgroup v1, you may have to use guarantee_active_cpus() 
> to return the actual set of CPUs that the task can run on. Also there 
> is a caveat about the arm64 specific task_cpu_possible_mask() for 
> certain arm64 CPUs. That is for 32-bit binary running on 64-bit core 
> which are allowed only on a selected subset of cores within the CPU.
>
> This is probably not what you want to focus on right now, but it will 
> be good to have a comment to list items that are not fully supported 
> here. 

FYI, you may have to take the callback_lock to ensure the stability of 
the effective_cpus mask.

Cheers,
Longman


