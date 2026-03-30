Return-Path: <cgroups+bounces-15110-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBByA2Ckymmx+gUAu9opvQ
	(envelope-from <cgroups+bounces-15110-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 18:27:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64ED035EC0B
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 323D5302172D
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62BC377555;
	Mon, 30 Mar 2026 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h3oHJpoe"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F21375ABC
	for <cgroups@vger.kernel.org>; Mon, 30 Mar 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774887317; cv=none; b=DkC8Q69kAm3g/lh0AAvc+pSEO3gnA/9Br/wpS1rSClse5T/PgAUeyqrGB8/y37eq3i2CTEDwoSsLbt6AgEECSSeNAnjBsgSiHWnYnqu9bvePTGD/Czw9/H3NLvfJX2u14IUKV8rdmvuDgMbyDBkBADyQM3yqJkb+tT3YutvJKvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774887317; c=relaxed/simple;
	bh=2IYPOMCPcEySjWZaopfH7SB5QUGeQ9+WDmP+Y5RZQEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEPmL27nnDlm5iFJLUS05MgrIsfPIA8pcLlIwqw6E16PBi1UI44POHj/u9CAP+n7fwv+E72dLON3r2jVaDUgKRhY429tPWwd4a1Kz2djsSnIg57jpCMzVNgGBS6AZ+3jAQei80FBETxIRFDt5xJWdDFqr6lhp9o4j52bQtdx2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h3oHJpoe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774887314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BeOzsJqYs4gpsf+ZHhY5fQfCfKwOvnECYf0CfuJTQng=;
	b=h3oHJpoe1w6Whz0NCPQv7Ozujy+gP/QBJa41BSwdiRi4vlQMsFiUVpkmJQX1+Jwzulc+Op
	zT29tAnvESkhHNqspi1IhusvtkKDjQZr67vDFksXZRGaDF0sOANK8adiOWYjyZhGFXsHq8
	0zvPpdbNgQ1V2htRUjOwCurpsveQrOw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-mSFUwzBOMFGPnBJKhP3OKw-1; Mon,
 30 Mar 2026 12:15:07 -0400
X-MC-Unique: mSFUwzBOMFGPnBJKhP3OKw-1
X-Mimecast-MFC-AGG-ID: mSFUwzBOMFGPnBJKhP3OKw_1774887304
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DCEB1800365;
	Mon, 30 Mar 2026 16:15:04 +0000 (UTC)
Received: from [10.22.64.128] (unknown [10.22.64.128])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE07A18001FE;
	Mon, 30 Mar 2026 16:15:02 +0000 (UTC)
Message-ID: <83e3d0fd-ab1c-4078-ae0a-e902e92fcdb6@redhat.com>
Date: Mon, 30 Mar 2026 12:15:01 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cgroup/cpuset: Skip security check for hotplug
 induced v1 task migration
To: Chen Ridong <chenridong@huaweicloud.com>,
 Chen Ridong <chenridong@huawei.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260329173958.2634925-1-longman@redhat.com>
 <20260329173958.2634925-3-longman@redhat.com>
 <c80c6838-e33e-4e5c-82ac-9bfa4d012dcb@huaweicloud.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <c80c6838-e33e-4e5c-82ac-9bfa4d012dcb@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15110-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64ED035EC0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/29/26 9:48 PM, Chen Ridong wrote:
>
> On 2026/3/30 1:39, Waiman Long wrote:
>> When a CPU hot removal causes a v1 cpuset to lose all its CPUs, the
>> cpuset hotplug handler will schedule a work function to migrate tasks
>> in that cpuset with no CPU to its ancestor to enable those tasks to
>> continue running.
>>
>> If a strict security policy is in place, however, the task migration
>> may fail when security_task_setscheduler() call in cpuset_can_attach()
>> returns a -EACCESS error. That will mean that those tasks will have
>> no CPU to run on. The system administrators will have to explicitly
>> intervene to either add CPUs to that cpuset or move the tasks elsewhere
>> if they are aware of it.
>>
>> This problem was found by a reported test failure in the LTP's
>> cpuset_hotplug_test.sh. Fix this problem by treating this special case
>> as an exception to skip the setsched security check as it is initated
>> internally within the kernel itself instead of from user input. Do that
>> by setting a new one-off CS_TASKS_OUT flag in the affected cpuset by the
>> hotplug handler to allow cpuset_can_attach() to skip the security check.
>>
>> With that patch applied, the cpuset_hotplug_test.sh test can be run
>> successfully without failure.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h |  1 +
>>   kernel/cgroup/cpuset-v1.c       |  3 +++
>>   kernel/cgroup/cpuset.c          | 14 ++++++++++++++
>>   3 files changed, 18 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index fd7d19842ded..75e2c20249ad 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -46,6 +46,7 @@ typedef enum {
>>   	CS_SCHED_LOAD_BALANCE,
>>   	CS_SPREAD_PAGE,
>>   	CS_SPREAD_SLAB,
>> +	CS_TASKS_OUT,
>>   } cpuset_flagbits_t;
>>   
>>   /* The various types of files and directories in a cpuset file system */
>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>> index 7308e9b02495..0c818edd0a1d 100644
>> --- a/kernel/cgroup/cpuset-v1.c
>> +++ b/kernel/cgroup/cpuset-v1.c
>> @@ -322,6 +322,9 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>   			return;
>>   		}
>>   
>> +		/* Enable task removal without security check */
>> +		set_bit(CS_TASKS_OUT, &cs->flags);
>> +
>>   		s->cs = cs;
>>   		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
>>   		schedule_work(&s->work);
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 58c5b7b72cca..24d3ceef7991 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3011,6 +3011,20 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>>   	setsched_check = !cpuset_v2() ||
>>   		!cpumask_equal(cs->effective_cpus, oldcs->effective_cpus) ||
>>   		!nodes_equal(cs->effective_mems, oldcs->effective_mems);
>> +	/*
>> +	 * Also check if task migration away from the old cpuset is allowed
>> +	 * without security check. This bit should only be set by the hotplug
>> +	 * handler when task migration from a child v1 cpuset to its ancestor
>> +	 * is needed because there is no CPU left for the tasks to run on after
>> +	 * a hot CPU removal. Clear the bit if set as it is one-off. Also
>> +	 * doube-check the CPU emptiness of oldcs to be sure before clearing
>> +	 * setsched_check.
>> +	 */
>> +	if (test_bit(CS_TASKS_OUT, &oldcs->flags)) {
>> +		if (cpumask_empty(oldcs->effective_cpus))
>> +			setsched_check = false;
>> +		clear_bit(CS_TASKS_OUT, &oldcs->flags);
>> +	}
>>   
> If there are many tasks in the cpuset that has no CPUs, they will be migrated
> one by one. I'm afraid that only the first task will succeed, and the rest will
> fail because the flag is cleared after processing the first one.

The setsched_check flag is used in the cgroup_taskset_for_each() loop 
below. That loop is going to iterate all the tasks to be migrated and so 
the flag will apply to all of them. So it is not just the first one.

Cheers,
Longman


