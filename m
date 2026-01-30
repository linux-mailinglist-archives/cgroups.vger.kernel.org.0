Return-Path: <cgroups+bounces-13538-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3rZjJzUrfGkYLAIAu9opvQ
	(envelope-from <cgroups+bounces-13538-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 04:53:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AB5B6EB9
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 04:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5753B3004C82
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 03:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1763331A6D;
	Fri, 30 Jan 2026 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiyI291R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwozaLmu"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03532E88B6
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769745198; cv=none; b=EHw6bJxLy8/waxX90/yduYorCzuDrJIfVU/binNcbDgOjN9wAnfP6f1w48apXEZuSwpe87vlVP/8ersG3jEwB8w2DiazVdqWiDGwJ6PBaP+phOm/ZIxsC6xhLfsBUmk1+y3jU2InIKhelCT42V/DxCjqs2ZslegMQ6X2FMtn1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769745198; c=relaxed/simple;
	bh=YUglP/1o0VFlP49CUtC5odsiRK0KtdguVL0uUKW80B0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Fq3zuZHjyN0dfYWTf+dpYg1NCz/dc88jAOoR2sao+EwzxugeNXpRvjJ8WC/s3xuYK0gZQ3LoRJ+Q+t3b8aMaG+YRGMWmB5CKNNbS+QHoPb8y/2JRrfO0up97rMyLQJlhC8rSZj7ZlrtHhkZkTH7s0S0qbGJoWKbBpfd0/dCXliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiyI291R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MwozaLmu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769745195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VgU+9mjJcQ6t3VpK1I61TTGyW0HQRG6T8xqgtO3yoQ=;
	b=HiyI291Rvf7i6dgD7bl9DGWNjj28kjK25H824QSil2Iu7T6YXFLccpnqiGFyvsDLGOF9CK
	/EUbMoV2vc+VpO3Dvi2t8/aGTLzPMRcayv9oGga2LjOmdz+WLJ5/GOlUJvj3E700XlsvUa
	fhfWL8fMDrnn22olluMadjjHU0Dy5eE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76--rYRQscdOS6iW78II6SDsA-1; Thu, 29 Jan 2026 22:53:14 -0500
X-MC-Unique: -rYRQscdOS6iW78II6SDsA-1
X-Mimecast-MFC-AGG-ID: -rYRQscdOS6iW78II6SDsA_1769745193
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-502d38a3e39so23231961cf.3
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 19:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769745193; x=1770349993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/VgU+9mjJcQ6t3VpK1I61TTGyW0HQRG6T8xqgtO3yoQ=;
        b=MwozaLmuSUIeBWHes+EVkydppBp9mBXyy4UVSCj/2sJ3qHvw/LYZtkBLMbEPa67/4B
         wOgCoenocYDjbRI5Y5pfS4seXA7f52otShnOVTv8bCKK3A/QSUVUBk0+biJpHhn67W0x
         I861x1lTGRZ5Ntv+EDTWi3eK3V7TNAlcKT/k1UojS61I8DgO8D/h1SZpNtuG8yYoUFjn
         13IH/BRqaVcoDaxyd/DMDcoHDELyCFhik7FzfjaonZPvF0t9Kh8Q5HHFXOCruYr3Rk1L
         knZ0CFF1CDfKQzTFCMCmL4Q8bTwTmmFQPwnFZwpMAHjx2Hny6HNSOqJPL5LnojkgyQu6
         U0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769745193; x=1770349993;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VgU+9mjJcQ6t3VpK1I61TTGyW0HQRG6T8xqgtO3yoQ=;
        b=ZUufUwkbCoSFrdP43pQQO0mUf4fmX1D7K5I7gtS5ngOmhSLDmym85H/HS1TdCd4L4r
         9qJWS1dmCJ6r5isdDUNgDLHhiDv6tTf4AVxcS7Wvc5K/9erebcVPE+nLJHuywVd2R1+q
         Uldpzs/lIAYG2lMuKZBj8CsABrN38X5/0kzi96bxZiDmbtj8yeW2mUHEI2hWP7ZcTiBk
         0E0LyXJxFltWKWq1I8cubwvkd4vGkoeqqMOUGITukfpt2Ftk3bNh4PSD7P6YVigR5sk7
         YnTpZBL42V6vEp9SeRgvGtjj645lKR2H+b9b+wRWfYK/cx71U9m0V/DChHMCAMq4A8mB
         oVuQ==
X-Gm-Message-State: AOJu0YyRKyI9+GQWwCJZtcOajLQMGK77Be4Htd3g7FBnFOGkWbZU1yIp
	CGotiBEvZXd4OEwRsDoPjDZSq2qJ59oLT748mk3UOgp/3oFl3WKZrm8omrENwrp3ulLlEaQuiHw
	syjDZfMJDILr/HF4DcRaSgQPkH+KAcVVOyXKuhFSJNrBXMaTlISlEsyIWqto=
X-Gm-Gg: AZuq6aK+Ou8CLjQ9vW6oe98mwVuD+chleYCwIcEKb9mXoWnmaThX2efq63quWOyjWtp
	a7Q/wflJW6kXtl1bc3E0RDT/qQtPbZ3JeoVUQxXof9YneOPW4hvn/yrKHmdEooejXEn4iUuZaE4
	bWIDbjNLl4jVCJFuqzH5J9YZ96vC9R+sB4VfRK7BStIKxuPyQVv2QpZ8GLxJ+GVMGzkcLmrHlmI
	W+eABUeIwoJYL1ERD4hDBjqVRnUjVwbNc7TR2RQkO3IR4bL0zLUE8TVQTkcJISV6WMoGfM5f6CJ
	JPhZ/+7dvfsLSNY9QItL2g9JXQm5Tj8g5BgQ0wlxL8iT+a9tW+gNnLznjosMq90TAlOZfZk70Kp
	mSWKXCffFLbKLb6qHlKctG1CFiDR3TDPvq2vZBq0Y2VBHCa9svJHHqnEF
X-Received: by 2002:ac8:7dc4:0:b0:4ec:f477:60e9 with SMTP id d75a77b69052e-505d22c8c79mr22427391cf.76.1769745193505;
        Thu, 29 Jan 2026 19:53:13 -0800 (PST)
X-Received: by 2002:ac8:7dc4:0:b0:4ec:f477:60e9 with SMTP id d75a77b69052e-505d22c8c79mr22427251cf.76.1769745193054;
        Thu, 29 Jan 2026 19:53:13 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375debasm51663666d6.42.2026.01.29.19.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 19:53:12 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f5adfdc9-4972-4437-8cc9-843b28e7414c@redhat.com>
Date: Thu, 29 Jan 2026 22:53:10 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next 2/2] cgroup/cpuset: Introduce a new top level
 isolcpus_update_mutex
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
References: <20260128044251.1229702-1-longman@redhat.com>
 <20260128044251.1229702-3-longman@redhat.com>
 <08c3fad6-b881-4089-b081-bde6efbafbd2@huaweicloud.com>
 <a6f6a5f6-ca71-424d-a56f-96a896a151ae@redhat.com>
 <11d8ff97-74e5-440e-b56a-af590da5a3f6@huaweicloud.com>
 <80842353-e054-4c70-a560-f67401c5b4a2@redhat.com>
 <7a67b419-1f94-441d-9d15-66dce03f9268@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <7a67b419-1f94-441d-9d15-66dce03f9268@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-13538-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B8AB5B6EB9
X-Rspamd-Action: no action

On 1/29/26 8:42 PM, Chen Ridong wrote:
>
> On 2026/1/30 9:35, Waiman Long wrote:
>> On 1/29/26 7:56 PM, Chen Ridong wrote:
>>> On 2026/1/30 5:16, Waiman Long wrote:
>>>> On 1/29/26 3:01 AM, Chen Ridong wrote:
>>>>> On 2026/1/28 12:42, Waiman Long wrote:
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
>>>>>> call housekeeping_update() without holding the cpus_read_lock()
>>>>>> and cpuset_mutex. One way to do that is to introduce a new top level
>>>>>> isolcpus_update_mutex which will be acquired first if the set of isolated
>>>>>> CPUs may have to be updated. This new isolcpus_update_mutex will provide
>>>>>> the need mutual exclusion without the need to hold cpus_read_lock().
>>>>>>
>>>>>> As cpus_read_lock() is now no longer held when
>>>>>> tmigr_isolated_exclude_cpumask() is called, it needs to acquire it
>>>>>> directly.
>>>>>>
>>>>>> The lockdep_is_cpuset_held() is also updated to check the new
>>>>>> isolcpus_update_mutex.
>>>>>>
>>>>> I worry about the issue:
>>>>>
>>>>> CPU1                CPU2
>>>>> rmdir
>>>>> css->ss->css_killed(css);
>>>>> cpuset_css_killed
>>>>>                   __update_isolation_cpumasks
>>>>>                   cpuset_full_unlock
>>>>> css->flags |= CSS_DYING;
>>>>> css_clear_dir(css);
>>>>> ...
>>>>> // offline and free do not
>>>>> // get isolcpus_update_mutex
>>>>> cpuset_css_offline
>>>>> cpuset_css_free
>>>>>                   cpuset_full_lock
>>>>>                   ...
>>>>>                   // UAF?
>>>>>
>>> Hi, Longman,
>>>
>>> In this patch, I noticed that cpuset_css_offline and cpuset_css_free do not
>>> acquire the isolcpus_update_mutex. This could potentially lead to a UAF issue.
>>>
>>>> That is the reason why I add a new top-level isolcpus_update_mutex.
>>>> cpuset_css_killed() and the update_isolation_cpumasks()'s unlock/lock sequence
>>>> will have to acquire this isolcpus_update_mutex first.
>>>>
>>> However, simply adding isolcpus_update_mutex to cpuset_css_killed and
>>> update_isolation_cpumasks may not be sufficient.
>>>
>>> As I mentioned, the path that calls __update_isolation_cpumasks may first
>>> acquire isolcpus_update_mutex and cpuset_full_lock, but once cpuset_css_killed
>>> is completed, it will release the “full” lock and then attempt to reacquire it
>>> later. During this intermediate period, the cpuset may have already been freed,
>>> because cpuset_css_offline and cpuset_css_free do not currently acquire the
>>> isolcpus_update_mutex.
>> You are right that acquisition of the new isolcpus_update_mutex should be in all
>> the places where cpuset_full_lock() is acquired. Will update the patch to do
>> that. That should eliminate the risk.
>>
> I suggest that putting isolcpus_update_mutex into cpuset_full_lock, since this
> function means that all the locks needed have been acquired.
>
> void cpuset_full_lock(void)
> {
> 	mutex_lock(&isolcpus_update_mutex);
> 	cpus_read_lock();
> 	mutex_lock(&cpuset_mutex);
> }
>
> void cpuset_full_unlock(void)
> {
> 	mutex_unlock(&cpuset_mutex);
> 	cpus_read_unlock();
> 	mutex_unlock(&isolcpus_update_mutex);
> }

That is what I had done.

Cheers,
Longman

>
> In the __update_isolation_cpumasks function, we can pair:
>
> ```
> 	...
> 	mutex_unlock(&cpuset_mutex);
> 	cpus_read_unlock();
> 	... Actions
> 	cpus_read_lock();
> 	mutex_lock(&cpuset_mutex);
> 	...
> ```
>


