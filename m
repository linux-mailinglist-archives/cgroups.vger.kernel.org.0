Return-Path: <cgroups+bounces-13678-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL5NF6Cxg2n9swMAu9opvQ
	(envelope-from <cgroups+bounces-13678-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 21:52:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6892EC980
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 21:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79BDF3012E88
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262DD43C068;
	Wed,  4 Feb 2026 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J2eegVJ4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7xKx7+D"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B006E33B6CC
	for <cgroups@vger.kernel.org>; Wed,  4 Feb 2026 20:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770238364; cv=none; b=jvCJXEEC1VtPMpWF02VOEPeZsE+nuX8Qa9mv/CC8mpvfVWsWRZc1VqL74dT/rxU157ooULkCsJHcPN0nae+ErmcOXvbQ2reIoKxkKzZtHCHD+sHii5bBqZpusRZkoyjK7DB9QtJX4MFNnCG/9dcTnJnhA+3YiSrXZRseCzyrwpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770238364; c=relaxed/simple;
	bh=ssjpbHI6cmL89OobZPvwmulDP1yFOlYxVlbl3xV+dX4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y8q3FfxroBDsTUEFJKWg7fAGkjxqkrKXEYeBHbjAPY9R3TfKzsjjPFwgsak0ImyH7WwRyEohJIykOCxydHv/VBISCAi+depZu28X8yS73JAR9vMSi3LC6ZBSPAZHs9BbqzZiJq6obZKlu1vD/zmdPbE7Q3THkzkffWv5sk6A8BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J2eegVJ4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7xKx7+D; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770238363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kj81cXJqBPfu+ZIYdvgIP8qNzuLUngM2uUz9tsRLLUQ=;
	b=J2eegVJ4zK1kUvjfwfwKP8veNklD5Pxfq16gRvNz5PyfHzCEgj/Ooa34pv3lqvSGNtv7qp
	HTCkhH39QwoeId29qpUJhjRuKlCQrSJaPSuYoqmv/1VgmxVSyqPibPhVmJ6cFykviJrmbL
	pvrv0sn5p6ZmQ59kPpcgilCsIMioBeE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-pp1gwk7lPPi36OUrRQmaJg-1; Wed, 04 Feb 2026 15:52:41 -0500
X-MC-Unique: pp1gwk7lPPi36OUrRQmaJg-1
X-Mimecast-MFC-AGG-ID: pp1gwk7lPPi36OUrRQmaJg_1770238361
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50148a2a5baso7464591cf.2
        for <cgroups@vger.kernel.org>; Wed, 04 Feb 2026 12:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770238361; x=1770843161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Kj81cXJqBPfu+ZIYdvgIP8qNzuLUngM2uUz9tsRLLUQ=;
        b=N7xKx7+DZ9ddWeeQDe3yLHGf+t5a0kQgwgiJPcGGL8Rbf4ye6gNW6L+xTUi/D18MFV
         sE11YGDeZhJLVeEjru8LsJqdgpbrL93WV5gfwgxtMjcSOGrTEtnAexDm481O4+ictpXL
         PjkMB2VLhtsQoFs5Rb/IuFe2wLPI5uoaaeoXiq0oO84MgT2o5ls/elBWQHniKJBIGutR
         mWMUwnqB4U+gRM27URIAlRrb6UoPZbhYycoU/PmH5ORrEtpwFp/+UPGuIqjyCjCtZF/9
         lVuP4iJRjrwTIoTJY9ds5W1SIJCEODpyU6cAQLRdeD8Ivf7FVqn7JZ5wU3USw43EGTjD
         8zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770238361; x=1770843161;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kj81cXJqBPfu+ZIYdvgIP8qNzuLUngM2uUz9tsRLLUQ=;
        b=hCSvWec/nAypSiSc2ILw3s0Xby8+6fUj/NWKkI+/OaS77h54NXvdwk78TaXJWOD8OG
         khCTSsBzyki7WVDJcOBhIDkbGjmN8VSuzxa2LQocfI5j9cDO1GAkxA137DYEp9rdKkl6
         XX5EbLaInb4gbf4mA/UcBk9Lm3FbzISZeZKFBuAmvll1uc616w57pRSAMmK2VLCN7KwV
         5QAXLaDhkwcE7LSYxa8aDaxTNCS7sRqlQEQV5bo64/RUTTPxZUWyUj2co+THgvUSYXRE
         Oo/+z8Exv/Omsr4axv3HFe7STVGUKhbcbIakOMO/tTCwLzJLpus7xZ0tUBYh/s1fS8jc
         rkow==
X-Gm-Message-State: AOJu0YyfFSZ1BBkSjzyo5eccj/1fUMjD6oaD/T2mupKmoXHbBmcfVsSl
	ImPcWLQ1KsK6xDHwWIqcUYwxkTZVrNiGdO2Zoam/tPcTbYzI+gGJCJ5J8RcD1+40klPOQWDNhTn
	tML1B1jStZVFtAD5oLb/FsXFEvb+RVjeY0uBN7+WLNLh+E6I8gWcEJyp49lo=
X-Gm-Gg: AZuq6aJRneAeaDlFIuDNjGm4LOphUCmP1ogB4b2fMQ89gSlmzeaeDL7n/Xb/u9IkbNY
	oxHNAiuDdjsNTdVbf9n1FKcTsgxa6xuecOiVy62ikhSgjAC38Bp4CmUmNo3pBjgVH4LmqBY96dd
	9+oUfhPwKNG/hqZtArCgE81LAYk5r9Zm5bhirAH/1va5MVKmsq5IkZ6alViFaSiJ6A1PePYUvxJ
	//HC+SufqktOv/fqoKv8j9Zny4dmkXp+m4DkQpPBSggjtAau2GdUh1/+vVD6AIkbHouuor0btZS
	yimhZx3kViMRwnCT5AfpS+dq/5Z29K9/ar9+PQXf6JrJjsiy/CosxkqQLj9Fsa7J6CTyEEXu2W2
	M/twPE9IbCxrORm/MDdvX2KAJ+90PtWK2U6I1gIInGZchhuH08ff/nugf
X-Received: by 2002:ac8:57c8:0:b0:4ee:1aab:fd6 with SMTP id d75a77b69052e-5061c0c6ea3mr56224801cf.3.1770238360464;
        Wed, 04 Feb 2026 12:52:40 -0800 (PST)
X-Received: by 2002:ac8:57c8:0:b0:4ee:1aab:fd6 with SMTP id d75a77b69052e-5061c0c6ea3mr56224391cf.3.1770238359987;
        Wed, 04 Feb 2026 12:52:39 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d3e54bsm27050946d6.56.2026.02.04.12.52.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 12:52:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e9d49c28-dbfe-4145-9030-5b6c8168475d@redhat.com>
Date: Wed, 4 Feb 2026 15:52:38 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v2 2/2] cgroup/cpuset: Introduce a new top level
 cpuset_top_mutex
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260130154254.1422113-1-longman@redhat.com>
 <20260130154254.1422113-3-longman@redhat.com>
 <62022397-287c-4046-94de-058ff87ad728@huaweicloud.com>
 <a2fc3448-dd5c-42fe-ac21-c8e1c10e94b4@redhat.com>
 <0c26006b-fe0f-4743-88d0-29b21fa82ee7@huaweicloud.com>
 <c8a56031-023d-4bbe-b7af-53e91c6d1dfc@redhat.com>
 <1264cf4a-0acd-475b-9f0a-57b816cdd504@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <1264cf4a-0acd-475b-9f0a-57b816cdd504@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-13678-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B6892EC980
X-Rspamd-Action: no action

On 2/3/26 8:55 PM, Chen Ridong wrote:
>
> On 2026/2/3 2:29, Waiman Long wrote:
>> On 2/1/26 8:11 PM, Chen Ridong wrote:
>>> On 2026/2/1 7:13, Waiman Long wrote:
>>>> On 1/30/26 9:53 PM, Chen Ridong wrote:
>>>>> On 2026/1/30 23:42, Waiman Long wrote:
>>>>>> The current cpuset partition code is able to dynamically update
>>>>>> the sched domains of a running system and the corresponding
>>>>>> HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
>>>>>> "isolcpus=domain,..." boot command line feature at run time.
>>>>>>
>>>>>> The housekeeping cpumask update requires flushing a number of different
>>>>>> workqueues which may not be safe with cpus_read_lock() held as the
>>>>>> workqueue flushing code may acquire cpus_read_lock() or acquiring locks
>>>>>> which have locking dependency with cpus_read_lock() down the chain. Below
>>>>>> is an example of such circular locking problem.
>>>>>>
>>>>>>      ======================================================
>>>>>>      WARNING: possible circular locking dependency detected
>>>>>>      6.18.0-test+ #2 Tainted: G S
>>>>>>      ------------------------------------------------------
>>>>>>      test_cpuset_prs/10971 is trying to acquire lock:
>>>>>>      ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at:
>>>>>> touch_wq_lockdep_map+0x7a/0x180
>>>>>>
>>>>>>      but task is already holding lock:
>>>>>>      ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at:
>>>>>> cpuset_partition_write+0x85/0x130
>>>>>>
>>>>>>      which lock already depends on the new lock.
>>>>>>
>>>>>>      the existing dependency chain (in reverse order) is:
>>>>>>      -> #4 (cpuset_mutex){+.+.}-{4:4}:
>>>>>>      -> #3 (cpu_hotplug_lock){++++}-{0:0}:
>>>>>>      -> #2 (rtnl_mutex){+.+.}-{4:4}:
>>>>>>      -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
>>>>>>      -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:
>>>>>>
>>>>>>      Chain exists of:
>>>>>>        (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex
>>>>>>
>>>>>>      5 locks held by test_cpuset_prs/10971:
>>>>>>       #0: ffff88816810e440 (sb_writers#7){.+.+}-{0:0}, at:
>>>>>> ksys_write+0xf9/0x1d0
>>>>>>       #1: ffff8891ab620890 (&of->mutex#2){+.+.}-{4:4}, at:
>>>>>> kernfs_fop_write_iter+0x260/0x5f0
>>>>>>       #2: ffff8890a78b83e8 (kn->active#187){.+.+}-{0:0}, at:
>>>>>> kernfs_fop_write_iter+0x2b6/0x5f0
>>>>>>       #3: ffffffffadf32900 (cpu_hotplug_lock){++++}-{0:0}, at:
>>>>>> cpuset_partition_write+0x77/0x130
>>>>>>       #4: ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at:
>>>>>> cpuset_partition_write+0x85/0x130
>>>>>>
>>>>>>      Call Trace:
>>>>>>       <TASK>
>>>>>>         :
>>>>>>       touch_wq_lockdep_map+0x93/0x180
>>>>>>       __flush_workqueue+0x111/0x10b0
>>>>>>       housekeeping_update+0x12d/0x2d0
>>>>>>       update_parent_effective_cpumask+0x595/0x2440
>>>>>>       update_prstate+0x89d/0xce0
>>>>>>       cpuset_partition_write+0xc5/0x130
>>>>>>       cgroup_file_write+0x1a5/0x680
>>>>>>       kernfs_fop_write_iter+0x3df/0x5f0
>>>>>>       vfs_write+0x525/0xfd0
>>>>>>       ksys_write+0xf9/0x1d0
>>>>>>       do_syscall_64+0x95/0x520
>>>>>>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>>>
>>>>>> To avoid such a circular locking dependency problem, we have to
>>>>>> call housekeeping_update() without holding the cpus_read_lock() and
>>>>>> cpuset_mutex. The current set of wq's flushed by housekeeping_update()
>>>>>> may not have work functions that call cpus_read_lock() directly,
>>>>>> but we are likely to extend the list of wq's that are flushed in the
>>>>>> future. Moreover, the current set of work functions may hold locks that
>>>>>> may have cpu_hotplug_lock down the dependency chain.
>>>>>>
>>>>>> One way to do that is to introduce a new top level cpuset_top_mutex
>>>>>> which will be acquired first.  This new cpuset_top_mutex will provide
>>>>>> the need mutual exclusion without the need to hold cpus_read_lock().
>>>>>>
>>>>> Introducing a new global lock warrants careful consideration. I wonder if we
>>>>> could make all updates to isolated_cpus asynchronous. If that is feasible, we
>>>>> could avoid adding a global lock altogether. If not, we need to clarify which
>>>>> updates must remain synchronous and which ones can be handled asynchronously.
>>>> Almost all the cpuset code are run with cpuset_mutex held with either
>>>> cpus_read_lock or cpus_write_lock. So there is no concurrent access/update to
>>>> any of the cpuset internal data. The new cpuset_top_mutex is aded to resolve the
>>>> possible deadlock scenarios with the new housekeeping_update() call without
>>>> breaking this model. Allow parallel concurrent access/update to cpuset data will
>>>> greatly complicate the code and we will likely missed some corner cases that we
>>> I agree with that point. However, we already have paths where isolated_cpus is
>>> updated asynchronously, meaning parallel concurrent access/update is already
>>> happening. Therefore, we cannot entirely avoid such scenarios, so why not keep
>>> the locking simple(make all updates to isolated_cpus asynchronous)?
>> isolated_cpus should only be updated in isolated_cpus_update() where both
>> cpuset_mutex and callback_lock are held. It can be read asynchronously if either
>> cpuset_mutex or callback_lock is held. Can you show me the  places where this
>> rule isn't followed?
>>
> I was considering that since the hotplug path calls update_isolation_cpumasks
> asynchronously, could other cpuset paths (such as setting CPUs or partitions)
> also call update_isolation_cpumasks asynchronously? If so, the global
> cpuset_top_mutex lock might be unnecessary. Note that isolated_cpus is updated
> synchronously, while housekeeping_update is invoked asynchronously.

update_isolation_cpumasks() is always called synchronously as 
cpuset_mutex will always be held. With the current patchset, the only 
asynchronous piece is CPU hotplug vs the the housekeeping_update() call 
as it is being called without holding cpus_read_lock(). AFASICS, it 
should not be a problem. Please let me if you are aware of some 
potential hazard with the current setup.

Cheers,
Longman


