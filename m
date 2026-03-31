Return-Path: <cgroups+bounces-15119-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDV0Bc0dy2kEEAYAu9opvQ
	(envelope-from <cgroups+bounces-15119-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 03:05:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A9362F9C
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 03:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 060573010DBD
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 01:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CA723A9BD;
	Tue, 31 Mar 2026 01:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9xWemdy"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AFE199EAD
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774919114; cv=none; b=MwB8x7U0OqjAG1HOOLI6IXcAPM55emiFYj37qdQ3i7NuncsMHOfe3+T6nSM0AjzOOxWMD6eXBwgASynpLXuezUzIHd5OIZGC72qfdVeTJoMcGDehtn1vhAoHORyJQAGCEoKB8q0zPc/IHB4Aq1UW3y22/WimZRz+6yK8SiPZq/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774919114; c=relaxed/simple;
	bh=KdkmwfmKrvwrbcPquPDdKLOwKfZTktAWssADTf4EJmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iToyX7Q6yO55CExXafYNAt6a8+usN0e8B5rbFdt3bnfNIlJN7U7KYno/4HgAMCI3Qrg2eVhgRAzV7tey8hZTGFv4LghC2dBjR1HV5QU3yR99AS+NiLJ6g0JfpqOfQNVZj5Xvke9a+MtWPRTWGvneDieZaK1a+CD4QzK+2Piu/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9xWemdy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774919112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SX38vnS1+tzyZc3Js6IfBjhxP3WWNyUYQxTa5nQuAsw=;
	b=Z9xWemdyE6gQZlndDQJW5tG8qD10C5BKEZ3THl+K3iTnAPw+wInRVE4VQInDUbCBtd1b8h
	h376QP1+RkjcszkzmtVbQe8Biw/civJACfPPc4zymHReTncuoPPRz6EvS6+N/d6zeCQgjN
	rz9QyHtOHieurVtn8ByeY9hnztlZP+g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-335-saKPWvr2Ph-FHuy-rs2NQw-1; Mon,
 30 Mar 2026 21:05:08 -0400
X-MC-Unique: saKPWvr2Ph-FHuy-rs2NQw-1
X-Mimecast-MFC-AGG-ID: saKPWvr2Ph-FHuy-rs2NQw_1774919106
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68E0B1800365;
	Tue, 31 Mar 2026 01:05:06 +0000 (UTC)
Received: from [10.22.64.128] (unknown [10.22.64.128])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F39730001A1;
	Tue, 31 Mar 2026 01:05:05 +0000 (UTC)
Message-ID: <4495aa7c-7d06-412f-82ce-345e5743955e@redhat.com>
Date: Mon, 30 Mar 2026 21:05:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cgroup/cpuset: Improve check for v1 task migration
 out of empty cpuset
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huawei.com>, Johannes Weiner
 <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260329173958.2634925-1-longman@redhat.com>
 <20260329173958.2634925-4-longman@redhat.com>
 <acrAHQ5EOecgZVOg@slm.duckdns.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <acrAHQ5EOecgZVOg@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15119-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 706A9362F9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 2:25 PM, Tejun Heo wrote:
> On Sun, Mar 29, 2026 at 01:39:58PM -0400, Waiman Long wrote:
>> With the "cpuset_v2_mode" mount option, cpuset v1 will emulate v2 in
>> how it handles the management of CPUs. As a result, the effective_cpus
>> can differ from cpus_allowed and an empty cpus_allowed will cause
>> effective_cpus to inherit the value from its parent. Therefore task
>> migration out of a cpuset with empty "cpuset.cpus" should no longer
>> be needed in this case.
>>
>> The current code doesn't handle this particular case. Update the code to
>> correctly detect that the cpuset has really no CPUs left by checking
>> effective_cpus instead of cpus_allowed.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset-v1.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>> index 0c818edd0a1d..9855de37d011 100644
>> --- a/kernel/cgroup/cpuset-v1.c
>> +++ b/kernel/cgroup/cpuset-v1.c
>> @@ -261,7 +261,7 @@ static void remove_tasks_in_empty_cpuset(struct cpuset *cs)
>>   	 * has online cpus, so can't be empty).
>>   	 */
>>   	parent = parent_cs(cs);
>> -	while (cpumask_empty(parent->cpus_allowed) ||
>> +	while (cpumask_empty(parent->effective_cpus) ||
>>   			nodes_empty(parent->mems_allowed))
>>   		parent = parent_cs(parent);
>>   
>> @@ -297,14 +297,16 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>   
>>   	/*
>>   	 * Don't call cpuset_update_tasks_cpumask() if the cpuset becomes empty,
>> -	 * as the tasks will be migrated to an ancestor.
>> +	 * as the tasks will be migrated to an ancestor. If cpuset_v2_mode mount
>> +	 * option is used, effective_cpus can differ from cpus_allowed. So
>> +	 * checking effective_cpus is more accurate for determining emptiness.
>>   	 */
>> -	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
>> +	if (cpus_updated && !cpumask_empty(cs->effective_cpus))
>>   		cpuset_update_tasks_cpumask(cs, new_cpus);
>>   	if (mems_updated && !nodes_empty(cs->mems_allowed))
>>   		cpuset_update_tasks_nodemask(cs);
>>   
>> -	is_empty = cpumask_empty(cs->cpus_allowed) ||
>> +	is_empty = cpumask_empty(cs->effective_cpus) ||
>>   		   nodes_empty(cs->mems_allowed);
> Are these meaningful changes? cpuset1_hotplug_update_tasks() is called by
> cpuset_hotplug_update_tasks() when !is_in_v2_mode(). As is_in_v2_mode() says
> yes on cpuset_v2_mode, the above change doesn't really change anything, no?

You are right. I missed that part. So it is really a no-op then. Will 
drop this patch.

Thanks!
Longman


