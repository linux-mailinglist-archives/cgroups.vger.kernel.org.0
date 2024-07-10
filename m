Return-Path: <cgroups+bounces-3605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5584992DD26
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 01:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DE691C2212D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 23:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6A15ECE3;
	Wed, 10 Jul 2024 23:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZhPQnR6"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157D15E5C2
	for <cgroups@vger.kernel.org>; Wed, 10 Jul 2024 23:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720655352; cv=none; b=FWeRwchgUY/+5uboCl0hK/X39mpayyXYh1CwOf8NFAnnekjjXTJgylzF2lmpOfsjjWo+AGRO0Vk29B8jqcfkd1arrLh/gtN0YQi3tO0S3ITuMMQFuWB+5fTnFW4j9r+n8mdQPPM56lsU6/QHabiJJxFM14kQHtbLHfjHGsS/gbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720655352; c=relaxed/simple;
	bh=xErRzgL2ci3yf1V+chWf3igrRYsqFLOzJFR6C1U9pkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJmKHIw9SEB5jzaNfsuIwkCoKPt/1DxeWZwpzW4d+d7P9gVwPhbJVojGpu+41AesA6h9UTcAXMAGwBriay3rKDCtZkXCHhACq2e+gTLi/Q8Gn/aRQjK4RSxVFxtS8QxLDvLorTeeiLZjkRLffrv0AfuScOkt2P/CoSyVXYvzYJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZhPQnR6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720655349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvMGbDK6gdZgu1QxmY35VViJYMc88dUgJ5oCbQmvDJs=;
	b=SZhPQnR6DWsOccj3GYstTt+GQcXQW7ZdJlqJ/6DNjjwFD52UVEKOLDu+9x+eEV8Ee4M3Lc
	utVeMoPA6rHOk2gWMaq5wacmjCYj5yyv9J3XwCWVXx/WKTGlyyjdvlxuaPTvz94U+frG4O
	CDyL3+klXyklJT/Gz50y0ea0lYgD2dk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-RbA8F_4XO52R5Ef7XlCXJA-1; Wed,
 10 Jul 2024 19:49:05 -0400
X-MC-Unique: RbA8F_4XO52R5Ef7XlCXJA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A330519560B6;
	Wed, 10 Jul 2024 23:49:03 +0000 (UTC)
Received: from [10.22.48.10] (unknown [10.22.48.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0AEFF3000181;
	Wed, 10 Jul 2024 23:49:00 +0000 (UTC)
Message-ID: <50b74abc-093b-467c-91bc-5ff786d3affd@redhat.com>
Date: Wed, 10 Jul 2024 19:49:00 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cgroup: Show # of subsystem CSSes in cgroup.stat
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kamalesh Babulal <kamalesh.babulal@oracle.com>
References: <20240710182353.2312025-1-longman@redhat.com>
 <Zo8AmTVEdirZdgol@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zo8AmTVEdirZdgol@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/10/24 17:43, Roman Gushchin wrote:
> On Wed, Jul 10, 2024 at 02:23:52PM -0400, Waiman Long wrote:
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
>> that have been bound to cgroup v2 as long as it is not zero.  The number
>> includes CSSes in the current cgroup as well as in all the descendants
>> underneath it.  This will help us pinpoint which subsystems are
>> responsible for the increasing number of dying (nr_dying_descendants)
>> cgroups.
>>
>> The cgroup-v2.rst file is updated to discuss this new behavior.
>>
>> With this patch applied, a sample output from root cgroup.stat file
>> was shown below.
>>
>> 	nr_descendants 54
>> 	nr_dying_descendants 44
>> 	nr_cpuset 1
>> 	nr_cpu 40
>> 	nr_io 40
>> 	nr_memory 54
>> 	nr_dying_memory 44
>> 	nr_perf_event 55
>> 	nr_hugetlb 1
>> 	nr_pids 54
>> 	nr_rdma 1
>> 	nr_misc 1
>>
>> Another sample output from system.slice/cgroup.stat was:
>>
>> 	nr_descendants 32
>> 	nr_dying_descendants 37
>> 	nr_cpu 30
>> 	nr_io 30
>> 	nr_memory 32
>> 	nr_dying_memory 37
>> 	nr_perf_event 33
>> 	nr_pids 32
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> I like it way more than the previous version, thank you for the update.
>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 14 ++++++-
>>   include/linux/cgroup-defs.h             |  7 ++++
>>   kernel/cgroup/cgroup.c                  | 50 ++++++++++++++++++++++++-
>>   3 files changed, 68 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 52763d6b2919..9031419271cd 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -981,6 +981,16 @@ All cgroup core files are prefixed with "cgroup."
>>   		A dying cgroup can consume system resources not exceeding
>>   		limits, which were active at the moment of cgroup deletion.
>>   
>> +	  nr_<cgroup_subsys>
>> +		Total number of live cgroups associated with that cgroup
>> +		subsystem (e.g. memory) at and beneath the current
>> +		cgroup.  An entry will only be shown if it is not zero.
>> +
>> +	  nr_dying_<cgroup_subsys>
>> +		Total number of dying cgroups associated with that cgroup
>> +		subsystem (e.g. memory) beneath the current cgroup.
>> +		An entry will only be shown if it is not zero.
>> +
>>     cgroup.freeze
>>   	A read-write single value file which exists on non-root cgroups.
>>   	Allowed values are "0" and "1". The default is "0".
>> @@ -2930,8 +2940,8 @@ Deprecated v1 Core Features
>>   
>>   - "cgroup.clone_children" is removed.
>>   
>> -- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" file
>> -  at the root instead.
>> +- /proc/cgroups is meaningless for v2.  Use "cgroup.controllers" or
>> +  "cgroup.stat" files at the root instead.
>>   
>>   
>>   Issues with v1 and Rationales for v2
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index b36690ca0d3f..62de18874508 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -210,6 +210,13 @@ struct cgroup_subsys_state {
>>   	 * fields of the containing structure.
>>   	 */
>>   	struct cgroup_subsys_state *parent;
>> +
>> +	/*
>> +	 * Keep track of total numbers of visible and dying descendant CSSes.
>> +	 * Protected by cgroup_mutex.
>> +	 */
>> +	int nr_descendants;
>> +	int nr_dying_descendants;
>>   };
>>   
>>   /*
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index c8e4b62b436a..18c982a06446 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -3669,12 +3669,34 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>>   static int cgroup_stat_show(struct seq_file *seq, void *v)
>>   {
>>   	struct cgroup *cgroup = seq_css(seq)->cgroup;
>> +	struct cgroup_subsys_state *css;
>> +	int ssid;
>>   
>> +	/* cgroup_mutex required for for_each_css() */
>> +	cgroup_lock();
> I *guess* it can be done under a rcu_read_lock(), isn't it?
> That would eliminate a need for the second patch as well, which
> is questionable (e.g. one unprivileged user can block others?)

I am just following the instruction in the for_each_css() macro:

  *
  * Should be called under cgroup_mutex.
  */

I think taking rcu_read_lock() should also work in this case. Will try 
it out and update the patch after some testing.

Thanks,
Longman


