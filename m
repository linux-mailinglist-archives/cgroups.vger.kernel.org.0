Return-Path: <cgroups+bounces-3675-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E0931645
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71901C22238
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AB91E861;
	Mon, 15 Jul 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMhe1Ovm"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9D18C166
	for <cgroups@vger.kernel.org>; Mon, 15 Jul 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052028; cv=none; b=XrTmXf+uaF4jbrBgNa7DAmLEo3zMWOWA5CwY9c5sV1PSJPvYEtwWa/GdhhD+nS9oc+poMH7xFH6OngJXOs0rhgUw87Q9TI+jBBy8PiG4RmrWxAq4KzSrYmjwMCvWG9+DPYktouSbx7jTG6V6aN9hmW9fHn0ygSGcP64tYsciph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052028; c=relaxed/simple;
	bh=RgfB9i51/BJ2f/wvWX+DMEe+gK+qdqWx8xFVzEBeYjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpasMx+HPHEXMEikphZ0bKK7ouVZrZFCPd8hzqsKUZ2sNoz9c5GQ/u5++0hJ1pHOrYF4i53nmX3ky3Upff6tWF3fpaxC0xiyMDGgNFVJ8230yFaivG41/HDcNXLM09BdYNKU2noI/SSqY7VA7tE3wFCrjdGPmiSddWD+tYjYv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMhe1Ovm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721052025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GVYJ4ne2AQmg1BRrD/nHV6rBCTnsNSLJ9SYDD3aJK7U=;
	b=aMhe1OvmBB8V0fsxFVN7B0ys+5dmdW1UzLDOaN2zaLhWQuqmzyh9m2Sh0va4qfkt29Xi8+
	EEWrHFF1sjqkY7X5l+99R18PPdL/NR0OnzXTcP4Qlq7owV6+QYQPLdAUpnKA2PHYE2ef44
	e/tWxGwFI1aybg9PHw2m3V7Dld3SHwQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-mbyqor8aNMOa0P2D-TnHjQ-1; Mon,
 15 Jul 2024 10:00:23 -0400
X-MC-Unique: mbyqor8aNMOa0P2D-TnHjQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 75D031955D4C;
	Mon, 15 Jul 2024 14:00:20 +0000 (UTC)
Received: from [10.22.9.29] (unknown [10.22.9.29])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 078DA1955D42;
	Mon, 15 Jul 2024 14:00:17 +0000 (UTC)
Message-ID: <3061f280-5a4a-4ff6-8b90-ab667a7e8e48@redhat.com>
Date: Mon, 15 Jul 2024 10:00:17 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-patch v6] cgroup: Show # of subsystem CSSes in cgroup.stat
To: Kamalesh Babulal <kamalesh.babulal@oracle.com>, Tejun Heo
 <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>
References: <20240712232959.2494935-1-longman@redhat.com>
 <8481d9d6-04dd-4c33-ad38-fc8ca1667d16@oracle.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <8481d9d6-04dd-4c33-ad38-fc8ca1667d16@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 7/13/24 11:50, Kamalesh Babulal wrote:
> On 7/13/24 4:59 AM, Waiman Long wrote:
>> Cgroup subsystem state (CSS) is an abstraction in the cgroup layer to
>> help manage different structures in various cgroup subsystems by being
>> an embedded element inside a larger structure like cpuset or mem_cgroup.
>>
>> The /proc/cgroups file shows the number of cgroups for each of the
>> subsystems.  With cgroup v1, the number of CSSes is the same as the
>> number of cgroups.  That is not the case anymore with cgroup v2. The
>> /proc/cgroups file cannot show the actual number of CSSes for the
>> subsystems that are bound to cgroup v2.
>>
>> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
>> we can't tell by looking at /proc/cgroups which cgroup subsystems may
>> be responsible.
>>
>> As cgroup v2 had deprecated the use of /proc/cgroups, the hierarchical
>> cgroup.stat file is now being extended to show the number of live and
>> dying CSSes associated with all the non-inhibited cgroup subsystems
>> that have been bound to cgroup v2 as long as they are not both zero.
>> The number includes CSSes in the current cgroup as well as in all the
>> descendants underneath it.  This will help us pinpoint which subsystems
>> are responsible for the increasing number of dying (nr_dying_descendants)
>> cgroups.
>>
>> The CSSes dying counts are stored in the cgroup structure itself
>> instead of inside the CSS as suggested by Johannes. This will allow
>> us to accurately track dying counts of cgroup subsystems that have
>> recently been disabled in a cgroup. It is now possible that a zero
>> subsystem number is coupled with a non-zero dying subsystem number.
>>
>> The cgroup-v2.rst file is updated to discuss this new behavior.
>>
>> With this patch applied, a sample output from root cgroup.stat file
>> was shown below.
>>
>> 	nr_descendants 56
>> 	nr_subsys_cpuset 1
>> 	nr_subsys_cpu 43
>> 	nr_subsys_io 43
>> 	nr_subsys_memory 56
>> 	nr_subsys_perf_event 57
>> 	nr_subsys_hugetlb 1
>> 	nr_subsys_pids 56
>> 	nr_subsys_rdma 1
>> 	nr_subsys_misc 1
>> 	nr_dying_descendants 30
>> 	nr_dying_subsys_cpuset 0
>> 	nr_dying_subsys_cpu 0
>> 	nr_dying_subsys_io 0
>> 	nr_dying_subsys_memory 30
>> 	nr_dying_subsys_perf_event 0
>> 	nr_dying_subsys_hugetlb 0
>> 	nr_dying_subsys_pids 0
>> 	nr_dying_subsys_rdma 0
>> 	nr_dying_subsys_misc 0
>>
>> Another sample output from system.slice/cgroup.stat was:
>>
>> 	nr_descendants 32
>> 	nr_subsys_cpu 30
>> 	nr_subsys_io 30
>> 	nr_subsys_memory 32
>> 	nr_subsys_perf_event 33
>> 	nr_subsys_pids 32
>> 	nr_dying_descendants 32
>> 	nr_dying_subsys_cpu 0
>> 	nr_dying_subsys_io 0
>> 	nr_dying_subsys_memory 32
>> 	nr_dying_subsys_perf_event 0
>> 	nr_dying_subsys_pids 0
>>
> [...]
>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index c8e4b62b436a..73774c841100 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -3669,12 +3669,43 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>>   static int cgroup_stat_show(struct seq_file *seq, void *v)
>>   {
>>   	struct cgroup *cgroup = seq_css(seq)->cgroup;
>> +	struct cgroup_subsys_state *css;
>> +	int dying_cnt[CGROUP_SUBSYS_COUNT];
>> +	int ssid;
>>   
>>   	seq_printf(seq, "nr_descendants %d\n",
>>   		   cgroup->nr_descendants);
>> +
>> +	/*
>> +	 * Show the number of live and dying csses associated with each of
>> +	 * non-inhibited cgroup subsystems that is either enabled in current
>> +	 * cgroup or has non-zero dying count.
>> +	 *
>> +	 * Without proper lock protection, racing is possible. So the
>> +	 * numbers may not be consistent when that happens.
>> +	 */
>> +	rcu_read_lock();
>> +	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
>> +		dying_cnt[ssid] = -1;
>> +		if (BIT(ssid) & cgrp_dfl_inhibit_ss_mask)
>> +			continue;
>> +		css = rcu_dereference_raw(cgroup->subsys[ssid]);
>> +		if (!css && !cgroup->nr_dying_subsys[ssid])
>> +			continue;
> Sorry, If I have misread the discussion from the other thread about displaying
> nr_descendants and nr_dying_subsys_<subsys>. I believe the idea was to print
> them for enabled and disabled cgroup controllers, so the output stays consistent
> and does not vary depending on the enabled controllers or previously enabled
> controller with nr_dying_subsys > 0.
>
> For example, on a rebooted vm:
>
> # cd /sys/fs/cgroup/
> # cat cgroup.subtree_control
> cpu memory pids
>
> # mkdir foo
> # cat foo/cgroup.stat
> nr_descendants 0
> nr_subsys_cpu 1
> nr_subsys_memory 1
> nr_subsys_perf_event 1
> nr_subsys_pids 1
> nr_dying_descendants 0
> nr_dying_subsys_cpu 0
> nr_dying_subsys_memory 0
> nr_dying_subsys_perf_event 0
> nr_dying_subsys_pids 0
>
> # echo '+cpuset' > cgroup.subtree_control
>
> # cat foo/cgroup.stat
> nr_descendants 0
> nr_subsys_cpuset 1
> nr_subsys_cpu 1
> nr_subsys_memory 1
> nr_subsys_perf_event 1
> nr_subsys_pids 1
> nr_dying_descendants 0
> nr_dying_subsys_cpuset 0
> nr_dying_subsys_cpu 0
> nr_dying_subsys_memory 0
> nr_dying_subsys_perf_event 0
> nr_dying_subsys_pids 0

I am fine with fine with that. I will update the patch as suggested.

Thanks,
Longman

>> +
>> +		dying_cnt[ssid] = cgroup->nr_dying_subsys[ssid];
>> +		seq_printf(seq, "nr_subsys_%s %d\n", cgroup_subsys[ssid]->name,
>> +			   css ? (css->nr_descendants + 1) : 0);
>> +	}
>> +
>>   	seq_printf(seq, "nr_dying_descendants %d\n",
>>   		   cgroup->nr_dying_descendants);
>> -
>> +	for (ssid = 0; ssid < CGROUP_SUBSYS_COUNT; ssid++) {
>> +		if (dying_cnt[ssid] >= 0)
>> +			seq_printf(seq, "nr_dying_subsys_%s %d\n",
>> +				   cgroup_subsys[ssid]->name, dying_cnt[ssid]);
>> +	}
>> +	rcu_read_unlock();
>>   	return 0;
>>   }
>>   


