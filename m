Return-Path: <cgroups+bounces-3615-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EE092E7E3
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 14:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F992288003
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 12:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E815B13D;
	Thu, 11 Jul 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSn3Am3L"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57AB156C61
	for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699317; cv=none; b=It1bZlAAtJ74g88GWjqKL2uwdhB1LQUgZFUOJ6E8igqJM1PueCRE1FqC/DsmoyymM65RUXudZtpELRYrPMe9N98WEE6lQ8L2MKpubuA/+2Tg/+vB38sG7iqIoDGYluEHpzpl7yDshHlWmc4GkJyHSDY/Oy3BAWv9xQLRvTD2fYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699317; c=relaxed/simple;
	bh=Z8Zu1MuuCsAoz8wY+M2/IHJXE89ApUwo9wW/ZJu5+Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqcRgKn9vk96MQMNvedPXTj4ii49Ffx1Z/mV+BY/t01rRc6n7slbCIx4E5al653SQdnJArHtX9f3lVMLpR+cOpEjsU3lgNrDtBrNsSCfSzSgbafPz17Lv8Yzra+qulhKqolcUOr2piD7PzYI9PQ/8EYyv3iNGWfiami7T3VI2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QSn3Am3L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720699314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3hsTSToU221bSTHS9CNBLjLLyQbtM9RUDOv5TNNRoLc=;
	b=QSn3Am3LKliRhHzaCTOGh4vUGxwda8YghHEi7K04cCgcflozHOn9zA0ZUDEHxCGcNSHAW6
	ZBPQHVrTny76fFG08Ii3dsyfiN1kzsgUeQMpYhdzfRmhdjD3P1992n4O54Q3G35qAt8cvH
	KcF33oEumBUkvfr0lI7PKbmj50Igzvg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-JnR5L0dBPMOJ_wJRKOt5tA-1; Thu,
 11 Jul 2024 08:01:52 -0400
X-MC-Unique: JnR5L0dBPMOJ_wJRKOt5tA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 760B419560AA;
	Thu, 11 Jul 2024 12:01:47 +0000 (UTC)
Received: from [10.22.64.119] (unknown [10.22.64.119])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66EAF3000185;
	Thu, 11 Jul 2024 12:01:45 +0000 (UTC)
Message-ID: <6f7a6bc0-8cf5-4f28-8fa1-aae0996f73da@redhat.com>
Date: Thu, 11 Jul 2024 08:01:44 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kamalesh Babulal <kamalesh.babulal@oracle.com>
References: <20240711025153.2356213-1-longman@redhat.com>
 <Zo9Q063eF8CdVyR1@google.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <Zo9Q063eF8CdVyR1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


On 7/10/24 23:26, Roman Gushchin wrote:
> On Wed, Jul 10, 2024 at 10:51:53PM -0400, Waiman Long wrote:
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
>> 	nr_descendants 55
>> 	nr_dying_descendants 35
>> 	nr_subsys_cpuset 1
>> 	nr_subsys_cpu 40
>> 	nr_subsys_io 40
>> 	nr_subsys_memory 55
>> 	nr_dying_subsys_memory 35
>> 	nr_subsys_perf_event 56
>> 	nr_subsys_hugetlb 1
>> 	nr_subsys_pids 55
>> 	nr_subsys_rdma 1
>> 	nr_subsys_misc 1
>>
>> Another sample output from system.slice/cgroup.stat was:
>>
>> 	nr_descendants 32
>> 	nr_dying_descendants 33
>> 	nr_subsys_cpu 30
>> 	nr_subsys_io 30
>> 	nr_subsys_memory 32
>> 	nr_dying_subsys_memory 33
>> 	nr_subsys_perf_event 33
>> 	nr_subsys_pids 32
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst | 14 ++++++-
>>   include/linux/cgroup-defs.h             |  7 ++++
>>   kernel/cgroup/cgroup.c                  | 52 ++++++++++++++++++++++++-
>>   3 files changed, 70 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 52763d6b2919..356cd430c888 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -981,6 +981,16 @@ All cgroup core files are prefixed with "cgroup."
>>   		A dying cgroup can consume system resources not exceeding
>>   		limits, which were active at the moment of cgroup deletion.
>>   
>> +	  nr_subsys_<cgroup_subsys>
>> +		Total number of live cgroups associated with that cgroup
>> +		subsystem (e.g. memory) at and beneath the current
>> +		cgroup.  An entry will only be shown if it is not zero.
>> +
>> +	  nr_dying_subsys_<cgroup_subsys>
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
>> index c8e4b62b436a..cf4fc1c109e2 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -3669,12 +3669,36 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
>>   static int cgroup_stat_show(struct seq_file *seq, void *v)
>>   {
>>   	struct cgroup *cgroup = seq_css(seq)->cgroup;
>> +	struct cgroup_subsys_state *css;
>> +	int ssid;
>>   
>>   	seq_printf(seq, "nr_descendants %d\n",
>>   		   cgroup->nr_descendants);
>>   	seq_printf(seq, "nr_dying_descendants %d\n",
>>   		   cgroup->nr_dying_descendants);
>>   
>> +	/*
>> +	 * Show the number of live and dying csses associated with each of
>> +	 * non-inhibited cgroup subsystems bound to cgroup v2 if non-zero.
>> +	 *
>> +	 * Without proper lock protection, racing is possible. So the
>> +	 * numbers may not be consistent when that happens.
>> +	 */
>> +	rcu_read_lock();
>> +	for_each_css(css, ssid, cgroup) {
>> +		if ((BIT(ssid) & cgrp_dfl_inhibit_ss_mask) ||
>> +		    (cgroup_subsys[ssid]->root !=  &cgrp_dfl_root))
>> +			continue;
>> +
>> +		seq_printf(seq, "nr_subsys_%s %d\n", cgroup_subsys[ssid]->name,
>> +			   css->nr_descendants + 1);
>> +		/* Current css is online */
>> +		if (css->nr_dying_descendants)
>> +			seq_printf(seq, "nr_dying_subsys_%s %d\n",
>> +				   cgroup_subsys[ssid]->name,
>> +				   css->nr_dying_descendants);
>> +	}
>> +	rcu_read_unlock();
>>   	return 0;
>>   }
>>   
>> @@ -5424,6 +5448,8 @@ static void css_release_work_fn(struct work_struct *work)
>>   	list_del_rcu(&css->sibling);
>>   
>>   	if (ss) {
>> +		struct cgroup_subsys_state *parent_css;
>> +
>>   		/* css release path */
>>   		if (!list_empty(&css->rstat_css_node)) {
>>   			cgroup_rstat_flush(cgrp);
>> @@ -5433,6 +5459,14 @@ static void css_release_work_fn(struct work_struct *work)
>>   		cgroup_idr_replace(&ss->css_idr, NULL, css->id);
>>   		if (ss->css_released)
>>   			ss->css_released(css);
>> +
>> +		WARN_ON_ONCE(css->nr_descendants || css->nr_dying_descendants);
>> +		parent_css = css->parent;
>> +		while (parent_css) {
>> +			parent_css->nr_dying_descendants--;
>> +			parent_css = parent_css->parent;
>> +		}
>> +		css_put(css->parent);	/* Parent can be freed now */
>>   	} else {
>>   		struct cgroup *tcgrp;
>>   
>> @@ -5517,8 +5551,11 @@ static int online_css(struct cgroup_subsys_state *css)
>>   		rcu_assign_pointer(css->cgroup->subsys[ss->id], css);
>>   
>>   		atomic_inc(&css->online_cnt);
>> -		if (css->parent)
>> +		if (css->parent) {
>>   			atomic_inc(&css->parent->online_cnt);
>> +			while ((css = css->parent))
>> +				css->nr_descendants++;
>> +		}
>>   	}
>>   	return ret;
>>   }
>> @@ -5540,6 +5577,19 @@ static void offline_css(struct cgroup_subsys_state *css)
>>   	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
>>   
>>   	wake_up_all(&css->cgroup->offline_waitq);
>> +
>> +	/*
>> +	 * Get a reference to parent css to ensure reliable access to its
>> +	 * nr_dying_descendants until after this child css is ready to be
>> +	 * freed.
>> +	 */
>> +	if (css->parent)
>> +		css_get(css->parent);
> I think this blob can be dropped: css has a reference to their parent up to
> very last moment, see css_free_rwork_fn().
> And the corresponding css_put() can be dropped too.
>
> With this thing fixed, please, feel free to add
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev> .

You are right. I missed that. Will remove the unnecessary css_get/put.

Thanks,
Longman


