Return-Path: <cgroups+bounces-3590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B992C79D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 02:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F869B22D7D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 00:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB21362;
	Wed, 10 Jul 2024 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWxtYZLG"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98EB1C32
	for <cgroups@vger.kernel.org>; Wed, 10 Jul 2024 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720571020; cv=none; b=LVM1x9MhgkUoZZu6ouAidxk0y4yhbFTSJHmfm1v3nkV7blasa4qzotKqR3NcL4ytYD/W6EI50dMC9mcqRosiEzIXXrRhL+CDk2sli3+kr2Ox7VWEY+dMbeCrPELVy9l6i/ha8fpBXon0J0/GCNra2ijj7njTTIxEYBJ7BuEpJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720571020; c=relaxed/simple;
	bh=V/QakQQ7p4VjkeFT81ZqacA3tqktDnAZO8yv5atGPzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGAlLFDxozeoOHRzX9/KvcP6V1HC68aqeD83j5J5BFPMPQLe7tDvg4abGx686ABCM5Qhun1bLq7JeWj88Be2xvPAGcfpX8R2VInSoRFq2wWzZeDBBDhkymiCtgoitUlo3z516M7JNcj5ftdmu/aBooKukn+Ejt5VTMmoHO88wC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWxtYZLG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720571017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m98QTRZcoM7cdLTRv8nzQmeQDuHjle0ViPXCEKEAop4=;
	b=XWxtYZLGDFqHx0PEVYQ7i4BAXPYpA5ur6B2IS0UbGB6Wqd1+ceYoz8J0hyZ09s1aZSp4Pf
	1jUn36momq6MQOxNv46g3F1RpXktPPTY+JccvKZ5EwmnxgxXRRByQlbWoKVx6u2HfewxTC
	Mztv+0Ix/ORC3vF5YzRRQXppZe0w5RA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-YXwUBUYfMx6dbCnPTyBczQ-1; Tue,
 09 Jul 2024 20:23:33 -0400
X-MC-Unique: YXwUBUYfMx6dbCnPTyBczQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 762891954B14;
	Wed, 10 Jul 2024 00:23:31 +0000 (UTC)
Received: from [10.22.34.7] (unknown [10.22.34.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EF0819560AE;
	Wed, 10 Jul 2024 00:23:29 +0000 (UTC)
Message-ID: <3dd64de1-8762-4870-84b3-fb2c5234f736@redhat.com>
Date: Tue, 9 Jul 2024 20:23:28 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v2] cgroup: Show # of subsystem CSSes in root
 cgroup.stat
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240709132814.2198740-1-longman@redhat.com>
 <Zo3C-77TnViiOi6d@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zo3C-77TnViiOi6d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 7/9/24 19:08, Roman Gushchin wrote:
> On Tue, Jul 09, 2024 at 09:28:14AM -0400, Waiman Long wrote:
>> The /proc/cgroups file shows the number of cgroups for each of the
>> subsystems.  With cgroup v1, the number of CSSes is the same as the
>> number of cgroups. That is not the case anymore with cgroup v2. The
>> /proc/cgroups file cannot show the actual number of CSSes for the
>> subsystems that are bound to cgroup v2.
>>
>> So if a v2 cgroup subsystem is leaking cgroups (usually memory cgroup),
>> we can't tell by looking at /proc/cgroups which cgroup subsystems may be
>> responsible.  This patch adds CSS counts in the cgroup_subsys structure
>> to keep track of the number of CSSes for each of the cgroup subsystems.
>>
>> As cgroup v2 had deprecated the use of /proc/cgroups, the root
>> cgroup.stat file is extended to show the number of outstanding CSSes
>> associated with all the non-inhibited cgroup subsystems that have been
>> bound to cgroup v2.  This will help us pinpoint which subsystems may be
>> responsible for the increasing number of dying (nr_dying_descendants)
>> cgroups.
>>
>> The cgroup-v2.rst file is updated to discuss this new behavior.
>>
>> With this patch applied, a sample output from root cgroup.stat file
>> was shown below.
>>
>> 	nr_descendants 53
>> 	nr_dying_descendants 34
>> 	nr_cpuset 1
>> 	nr_cpu 40
>> 	nr_io 40
>> 	nr_memory 87
>> 	nr_perf_event 54
>> 	nr_hugetlb 1
>> 	nr_pids 53
>> 	nr_rdma 1
>> 	nr_misc 1
>>
>> In this particular case, it can be seen that memory cgroup is the most
>> likely culprit for causing the 34 dying cgroups.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 10 ++++++++--
>>   include/linux/cgroup-defs.h             |  3 +++
>>   kernel/cgroup/cgroup.c                  | 19 +++++++++++++++++++
>>   3 files changed, 30 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 52763d6b2919..65af2f30196f 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -981,6 +981,12 @@ All cgroup core files are prefixed with "cgroup."
>>   		A dying cgroup can consume system resources not exceeding
>>   		limits, which were active at the moment of cgroup deletion.
>>   
>> +	  nr_<cgroup_subsys>
>> +		Total number of cgroups associated with that cgroup
>> +		subsystem, e.g. cpuset or memory.  These cgroup counts
>> +		will only be shown in the root cgroup and for subsystems
>> +		bound to cgroup v2.
>> +
>>     cgroup.freeze
>>   	A read-write single value file which exists on non-root cgroups.
>>   	Allowed values are "0" and "1". The default is "0".
>> @@ -2930,8 +2936,8 @@ Deprecated v1 Core Features
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
>> index b36690ca0d3f..522ab77f0406 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -776,6 +776,9 @@ struct cgroup_subsys {
>>   	 * specifies the mask of subsystems that this one depends on.
>>   	 */
>>   	unsigned int depends_on;
>> +
>> +	/* Number of CSSes, used only for /proc/cgroups */
>> +	atomic_t nr_csses;
> I believe it should be doable without atomics because most of css
> operations are already synchronized using the cgroup mutex.
css_create() was protected under cgroup_mutex, but I don't believe 
css_free_rwork_fn() is. It is called from the kworker. So atomic_t is 
still needed.
>
> Other than that, I believe that this information is useful. Maybe
> it can be retrieved using drgn/bpf iterator, but adding this functionality
> to the kernel makes it easier to retrieve and the overhead is modest.
>
> Also, if you add it to the cgroupfs, why not make it fully hierarchical
> as existing entries in cgroup.stat. And if not, I'd agree with Johannes
> that it looks like the debugfs material.

To make it hierarchical, I would have to store a nr_descendants and 
nr_dying_descendants in each css, just like the corresponding ones in 
cgroup. I think it is doable, but the patch will be much more complex.

Cheers,
Longman

>
> Thanks!
>


