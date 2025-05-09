Return-Path: <cgroups+bounces-8105-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB1DAB16D6
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 16:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CFA1BC3E1E
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E2A29117E;
	Fri,  9 May 2025 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3SklT4z"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D022F23D2A0
	for <cgroups@vger.kernel.org>; Fri,  9 May 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799709; cv=none; b=LXbDqGqKL7lmgnQU7JSAOYSD/m7AZIPj+tDpJ9bIdldRYp3TNrOsLsVM4P5E1yUT/dPgoqlW/JgFk1yskxXfW8cnBupL1kLB6wYcipLzt6KNI76zmcDTD7v/Xh/pjIFZ0dOsxL1sGR2FkXt7OLSiiAbLxqkQAcEh0C+Sgxhn0AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799709; c=relaxed/simple;
	bh=X9iz6P76WZ68MCdyBBEFJ8enInOF4Wt1tDNwUwmlQ7M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JZ9bFNa9cfXzH+VCumQG5b/IPeuKEHhek6LzfGBy7UgQKB9P8N9IUXPWFzC5mdpVTfwxBRzDix9yNqI4LKHO8ED+R+S2tlesja3rp/j4Y35DPWEGZ/ZrzClHGcub0Ne4H5A6W+Ch0uPsBnP5/E12k0FvJYOCreQzhnfw7LnO570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e3SklT4z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746799706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBV5n+cOtIYSXjAw/bARiUgJOPuRK0VrTiHcE+JbX9s=;
	b=e3SklT4z4QhswWmaY1M7zuQLfCOW1CWEEr/p7sgs2vS7sxgvNItcKikI4En/e48ZjGN9TM
	tZ4frwU1XhAB1uF3iSIEOGbC5FR41/KNz5c13q1TDLTVoj3CSyrR2DADWp+jF5/A2OQ0Y6
	M3UsttuA2v7loloLY/jkq75cjMdbg74=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-4K0HpFSCMlK2P2JyNROfzg-1; Fri, 09 May 2025 10:08:25 -0400
X-MC-Unique: 4K0HpFSCMlK2P2JyNROfzg-1
X-Mimecast-MFC-AGG-ID: 4K0HpFSCMlK2P2JyNROfzg_1746799705
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6f53d2613easo41663396d6.0
        for <cgroups@vger.kernel.org>; Fri, 09 May 2025 07:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746799705; x=1747404505;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBV5n+cOtIYSXjAw/bARiUgJOPuRK0VrTiHcE+JbX9s=;
        b=A9xYuelnS5TmGe7BGA22a4EmdY89XMpI7kwG4tCYvLObnc4TG1tidnneBVu5aaI7oO
         Zee/qDNW9lz95NsTzzKrvJHcuK5JAnV+/aeFrJV0z9IYw2GLsbqjQP64Cl7MLznURb5C
         J0TxAhPGQoba0sbGJzyeJjml1B4+jDzvEbEhQWicnfLf+sJvQIhQ+W97Y2VfYVlqHaty
         TqoUiBGlRC7yj7/NGMEdBx2j1KnkMXC/N6OTlkn57rMcl1MiiNSVKMVKkhtYU7Yjf/qQ
         ebXvk6haAVP6iByPVvSvM34bMJjSuhYHYTtNH/U88h+nVcra6hTu01dni0C3TIBOuZO6
         cY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1kvom/IrB8+aQdJ/mW0ZCyFTtBBZzydM5vEefWg1dzkwyS3Ub5cdnGIRB8opTQQ1XIvXjhW4v@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6uBXVc7BgULpdQAZXcNafM5nCpwzT6QVvpVkezeVaBnTnVwy
	nvpCPhA2bGX9BCRY/Bk/l/uwD0/pWLbzEmlmQ9lhdPGse/w84QYuxX61fzxGG6HHjF2gd21ubTI
	h7d9p0aoTHGCPnzngyTdQI0cd58PGBLxeVvyJxFpLww4XzjjJYJrSQHQ=
X-Gm-Gg: ASbGnctjuySDqSziKyQ8JmYmmL0dtZP1fB4ESgpMMm7PbbQheXshS81wwJCuVdzEOoJ
	kUihLNVvr5VdGCwl0EWZDxGLvS5J8unc/kRgjPB2Czdnen1miy7pH6WBOqDYs2mI0a62770tbiE
	E/gCIeDf12t5HWWg/RNa0olJJn3V+G/e9Wl1WeO40pNauLLDJ0QZLbRrHun9if4twuWydbyOuOw
	kXq32JW/pd5Yi23eVX99rfQW3RzMXKUV7BdvgpaVZpIu7w905ZVb0R8c+XvFq7vKvWJn1+qu92I
	ZvmyKSZEyWtvNW0rYSOdYuYh0Di90iABMN0T6/fMQSXMy8g1SWoSbc6ydw==
X-Received: by 2002:ad4:5cc3:0:b0:6f4:f157:40ad with SMTP id 6a1803df08f44-6f6e472aeefmr47633496d6.2.1746799704168;
        Fri, 09 May 2025 07:08:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjW5ihql95VIFn4D6lluOrxDlaaWN63vachESmfkEf+xj2cH8flgqNMrUnq3ak28c50V49oA==
X-Received: by 2002:ad4:5cc3:0:b0:6f4:f157:40ad with SMTP id 6a1803df08f44-6f6e472aeefmr47631366d6.2.1746799701726;
        Fri, 09 May 2025 07:08:21 -0700 (PDT)
Received: from ?IPV6:2601:188:c102:9c40:1f42:eb97:44d3:6e9a? ([2601:188:c102:9c40:1f42:eb97:44d3:6e9a])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e39e070bsm14154226d6.10.2025.05.09.07.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 07:08:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <71c45a3d-747a-4e47-8c65-2b982656ab3a@redhat.com>
Date: Fri, 9 May 2025 10:08:20 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/cpuset: Extend kthread_is_per_cpu() check to
 all PF_NO_SETAFFINITY tasks
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xi Wang <xii@google.com>
References: <20250508192413.615512-1-longman@redhat.com>
 <aB4AmUtEM-qQ1Xoa@localhost.localdomain>
Content-Language: en-US
In-Reply-To: <aB4AmUtEM-qQ1Xoa@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/9/25 9:18 AM, Frederic Weisbecker wrote:
> Le Thu, May 08, 2025 at 03:24:13PM -0400, Waiman Long a écrit :
>> Commit ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask()
>> on top_cpuset") enabled us to pull CPUs dedicated to child partitions
>> from tasks in top_cpuset by ignoring per cpu kthreads. However, there
>> can be other kthreads that are not per cpu but have PF_NO_SETAFFINITY
>> flag set to indicate that we shouldn't mess with their CPU affinity.
>> For other kthreads, their affinity will be changed to skip CPUs dedicated
>> to child partitions whether it is an isolating or a scheduling one.
>>
>> As all the per cpu kthreads have PF_NO_SETAFFINITY set, the
>> PF_NO_SETAFFINITY tasks are essentially a superset of per cpu kthreads.
>> Fix this issue by dropping the kthread_is_per_cpu() check and checking
>> the PF_NO_SETAFFINITY flag instead.
>>
>> Fixes: ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d0143b3dce47..967603300ee3 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1130,9 +1130,11 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>>   
>>   		if (top_cs) {
>>   			/*
>> -			 * Percpu kthreads in top_cpuset are ignored
>> +			 * PF_NO_SETAFFINITY tasks are ignored.
>> +			 * All per cpu kthreads should have PF_NO_SETAFFINITY
>> +			 * flag set, see kthread_set_per_cpu().
>>   			 */
>> -			if (kthread_is_per_cpu(task))
>> +			if (task->flags & PF_NO_SETAFFINITY)
>>   				continue;
>>   			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>
> But this makes me realize I overlooked that when I introduced the unbound kthreads
> centralized affinity.
>
> cpuset_update_tasks_cpumask() seem to blindly affine to subpartitions_cpus
> while unbound kthreads might have their preferences (per-nodes or random cpumasks).
>
> So I need to make that pass through kthread API.
AFAIU, the kthread_bind_mask() or the kthread_bin_cpu() functions will 
set PF_NO_SETAFFINITY.
>
> It seems that subpartition_cpus doesn't contain nohz_full= CPUs.
> But it excludes isolcpus=. And it's usually sane to assume that
> nohz_full= CPUs are isolated.
Most users that want isolated CPUs will set both isolcpus and nohz_full 
to the same set of CPUs. I do see that RH OpenShift can set nohz_full 
for a collection of CPUs that may be dynamically isolated later on via 
cpuset partition.
>
> I think I can just rename update_unbound_workqueue_cpumask()
> to update_unbound_kthreads_cpumask() and then handle unbound
> kthreads from there along with workqueues. And then completely
> ignore kthreads from cpuset_update_tasks_cpumask().

I guess we can do that. Right now, update_unbound_workqueue_cpumask() is 
only called to excluded isolated CPUs. The 
cpuset_update_tasks_cpumasks() will updated affinity for both isolated 
and scheduling partitions. I agree that there is code duplication here. 
To suit Xi Wang use case, we may have to add a sysctl parameter, for 
instance, to decide if we have to update unbound kthreads in the 
scheduling partition case.

Cheers,
Longman

> Let me think about it (but feel free to apply the current patch meanwhile).
>
> Thanks.
>


