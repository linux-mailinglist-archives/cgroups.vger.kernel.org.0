Return-Path: <cgroups+bounces-3600-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CBF92D843
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 20:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BD32816A5
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B55195FE5;
	Wed, 10 Jul 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwIltSfA"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AE195B08
	for <cgroups@vger.kernel.org>; Wed, 10 Jul 2024 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636116; cv=none; b=Ey62TtACCjsvjzjLKJ76toNxO2hwTTCy1i4fpcEIC55e6o3W8yly7JecvRjDmc+2inc//VfeKO+pcFqnLsneoj6lD0wenTMIft/pGkCetjDqM9fcicc9UDZ7FKEX7l8AG21CNeOL0vBJfls/99LWKcuQlw+Z5Xm/bgT+8JKYoZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636116; c=relaxed/simple;
	bh=ZVpVZPoW5DhjzOavrR5GY0hpK7EfHLGxovPutWlyOEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lHZt5JALtVQPlE+e+4ZnfOJlPMl1pHL8HwUqBydsCpQWLXoy9lZb2oI00o224bknyw9hydWjwd7NaaP7tcR57s8CC6r8CWrobICjMQ4rlXsVl/GftFOtngI0RevRoUjVZooJ8+VT6TIoUsYr9YJpPVPqBy/pSPzVc4rcmuJxuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwIltSfA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720636113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qF8mAtiIKc1hNwFwVQgDd+xtcEIQ7/hxF8mGp9dv70U=;
	b=TwIltSfAKGJwUbarX3L/fJPIFvixN1FQnXtZ4Pvh3lGSwfsDIH/Cj8kpfv1WijIhvSEnxq
	1WdoRFDPfTUN6Hsp9YexXtLIU6zQ2P++Sb4I5NFO0tPloqfgUMXl0pBo1GD1QwR2J1tEy0
	GmNieRDl1V/vUSKsQfMWcI8lJNsqY5c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-kjVYtQYOOeyYt79GQJew1g-1; Wed,
 10 Jul 2024 14:28:30 -0400
X-MC-Unique: kjVYtQYOOeyYt79GQJew1g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C03519560BF;
	Wed, 10 Jul 2024 18:28:27 +0000 (UTC)
Received: from [10.22.48.10] (unknown [10.22.48.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93A2D3000181;
	Wed, 10 Jul 2024 18:28:25 +0000 (UTC)
Message-ID: <bea18088-0417-4bfc-b7aa-48489bb6a1db@redhat.com>
Date: Wed, 10 Jul 2024 14:28:24 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v2] cgroup: Show # of subsystem CSSes in root
 cgroup.stat
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Kamalesh Babulal <kamalesh.babulal@oracle.com>, Tejun Heo
 <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240709132814.2198740-1-longman@redhat.com>
 <1c0d9ee1-e80a-46da-a48d-2ab23dd04673@oracle.com>
 <4291c0ed-bc37-46de-b081-271e8b299b1d@redhat.com>
 <20240709180231.GA251628@cmpxchg.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240709180231.GA251628@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/9/24 14:02, Johannes Weiner wrote:
> On Tue, Jul 09, 2024 at 12:09:05PM -0400, Waiman Long wrote:
>> On 7/9/24 11:58, Kamalesh Babulal wrote:
>>> On 7/9/24 6:58 PM, Waiman Long wrote:
>>>> The /proc/cgroups file shows the number of cgroups for each of the
>>>> subsystems.  With cgroup v1, the number of CSSes is the same as the
>>>> number of cgroups. That is not the case anymore with cgroup v2. The
>>>> /proc/cgroups file cannot show the actual number of CSSes for the
>>>> subsystems that are bound to cgroup v2.
>>>>
>>>> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
>>>> we can't tell by looking at /proc/cgroups which cgroup subsystems may be
>>>> responsible.  This patch adds CSS counts in the cgroup_subsys structure
>>>> to keep track of the number of CSSes for each of the cgroup subsystems.
>>>>
>>>> As cgroup v2 had deprecated the use of /proc/cgroups, the root
>>>> cgroup.stat file is extended to show the number of outstanding CSSes
>>>> associated with all the non-inhibited cgroup subsystems that have been
>>>> bound to cgroup v2.  This will help us pinpoint which subsystems may be
>>>> responsible for the increasing number of dying (nr_dying_descendants)
>>>> cgroups.
>>>>
>>>> The cgroup-v2.rst file is updated to discuss this new behavior.
>>>>
>>>> With this patch applied, a sample output from root cgroup.stat file
>>>> was shown below.
>>>>
>>>> 	nr_descendants 53
>>>> 	nr_dying_descendants 34
>>>> 	nr_cpuset 1
>>>> 	nr_cpu 40
>>>> 	nr_io 40
>>>> 	nr_memory 87
>>>> 	nr_perf_event 54
>>>> 	nr_hugetlb 1
>>>> 	nr_pids 53
>>>> 	nr_rdma 1
>>>> 	nr_misc 1
>>>>
>>>> In this particular case, it can be seen that memory cgroup is the most
>>>> likely culprit for causing the 34 dying cgroups.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++--
>>>>    include/linux/cgroup-defs.h             |  3 +++
>>>>    kernel/cgroup/cgroup.c                  | 19 +++++++++++++++++++
>>>>    3 files changed, 30 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>>> index 52763d6b2919..65af2f30196f 100644
>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>>> @@ -981,6 +981,12 @@ All cgroup core files are prefixed with "cgroup."
>>>>    		A dying cgroup can consume system resources not exceeding
>>>>    		limits, which were active at the moment of cgroup deletion.
>>>>    
>>>> +	  nr_<cgroup_subsys>
>>>> +		Total number of cgroups associated with that cgroup
>>>> +		subsystem, e.g. cpuset or memory.  These cgroup counts
>>>> +		will only be shown in the root cgroup and for subsystems
>>>> +		bound to cgroup v2.
>>>> +
>>>>      cgroup.freeze
>>>>    	A read-write single value file which exists on non-root cgroups.
>>>>    	Allowed values are "0" and "1". The default is "0".
>>>> @@ -2930,8 +2936,8 @@ Deprecated v1 Core Features
>>>>    
>>>>    - "cgroup.clone_children" is removed.
>>>>    
>>>> -- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
>>>> -  at the root instead.
>>>> +- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" or
>>>> +  "cgroup.stat" files at the root instead.
>>>>    
>>>>    
>>>>    Issues with v1 and Rationales for v2
>>>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>>>> index b36690ca0d3f..522ab77f0406 100644
>>>> --- a/include/linux/cgroup-defs.h
>>>> +++ b/include/linux/cgroup-defs.h
>>>> @@ -776,6 +776,9 @@ struct cgroup_subsys {
>>>>    	 * specifies the mask of subsystems that this one depends on.
>>>>    	 */
>>>>    	unsigned int depends_on;
>>>> +
>>>> +	/* Number of CSSes, used only for /proc/cgroups */
>>>> +	atomic_t nr_csses;
>>>>    };
>>>>    
>>>>    extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
>>>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>>>> index c8e4b62b436a..48eba2737b1a 100644
>>>> --- a/kernel/cgroup/cgroup.c
>>>> +++ b/kernel/cgroup/cgroup.c
>>>> @@ -3669,12 +3669,27 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>>>>    static int cgroup_stat_show(struct seq_file *seq, void *v)
>>>>    {
>>>>    	struct cgroup *cgroup = seq_css(seq)->cgroup;
>>>> +	struct cgroup_subsys *ss;
>>>> +	int i;
>>>>    
>>>>    	seq_printf(seq, "nr_descendants %d\n",
>>>>    		   cgroup->nr_descendants);
>>>>    	seq_printf(seq, "nr_dying_descendants %d\n",
>>>>    		   cgroup->nr_dying_descendants);
>>>>    
>>>> +	if (cgroup_parent(cgroup))
>>>> +		return 0;
>>>> +
>>>> +	/*
>>>> +	 * For the root cgroup, shows the number of csses associated
>>>> +	 * with each of non-inhibited cgroup subsystems bound to it.
>>>> +	 */
>>>> +	do_each_subsys_mask(ss, i, ~cgrp_dfl_inhibit_ss_mask) {
>>>> +		if (ss->root != &cgrp_dfl_root)
>>>> +			continue;
>>>> +		seq_printf(seq, "nr_%s %d\n", ss->name,
>>>> +			   atomic_read(&ss->nr_csses));
>>>> +	} while_each_subsys_mask();
>>>>    	return 0;
>>>>    }
>>>>    
>>> Thanks for adding nr_csses, the patch looks good to me. A preference comment,
>>> nr_<subsys>_css format, makes it easier to interpret the count.
>>>
>>> With or without the changes to the cgroup subsys format:
>>>
>>> Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>
>> Thanks for the review.
>>
>> CSS is a kernel internal name for cgroup subsystem state. Non kernel
>> developers or users may not know what CSS is and cgroup-v2.rst doesn't
>> mention CSS at all. So I don't think it is a good idea to add the "_css"
>> suffix. From the user point of view, the proper term to use here is the
>> number of cgroups, just like what "nr_descendants" and
>> "nr_dying_descendants" are referring to before this patch. The only
>> issue that I didn't address is the use of the proper plural form which
>> is hard for cgroup subsystem names that we have.
> It's not quite the same right? You could have 1 dying cgroup with
> multiple zombie subsys states. At least in theory. It could be
> confusing to add these counts without introducing the css concept.
>
> I also wonder if it would be better to just report the dying css
> instead of all of them. Live ones are 1) under user control and 2)
> easy to inspect in cgroupfs. I can see a scenario for the
> nr_descendants aggregation ("Oh, that's a lot of subgroups!"); and a
> scenario for dying css ("Oh, it's memory state pinning dead groups!").
> But not so much "Oh, that's a lot of live memory controlled groups!"
>
> I can't think of a good name for it though.
>
> nr_dying_memory_css is a mouthful
>
> nr_offline_memory?
>
> nr_zombie_memory?
>
> Should this be in debugfs?
>
I just have sent out a v3 patch that make this hierarchical and separate 
out live and dying csses. Let me know if you have other suggestions.

Thanks,
Longman


