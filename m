Return-Path: <cgroups+bounces-16680-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QUyjDe0GI2oOgwEAu9opvQ
	(envelope-from <cgroups+bounces-16680-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 19:27:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DFB64A26F
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 19:27:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=iwR+0vdj;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16680-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16680-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5EA53012768
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 17:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A96125F994;
	Fri,  5 Jun 2026 17:15:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5652609E3
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 17:15:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679723; cv=none; b=JYEG6yHeUP4bp0ID90AScChjWR4/C1vpXvQFImx8ETJJKXTsoTsIj26/jmom4EpsitSqUDyMr9Fh+BsIB38ZdzzinplrDNSBgGQzL9uxYwxMf7KpJxyP7noKSRQZrKuLZWtyUgxvfNDulovWmahPtvXNbwtEuHShqnTt0p+rOFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679723; c=relaxed/simple;
	bh=rXO1IgPDwyskP9LKa9E1FGheOzKC5kK7/KM3PSbVEzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os6isTNq64hIBmNoAPL3x0TJk7FpMoGtE+Rpzfui3LKsP95Pg8gjkJmUO/ACj8tLAnMJI54pAPZ0lhIbKrBd4JCa7NeKeDa3ek+s/zDrHVLdeZ/L7xPxW8P31CJS/r33E/wtVn3uLy3rzpKG+T280R0FNORatQ7wsEIPZ47Qcu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwR+0vdj; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780679721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ND/KY/zDuUAt/6GSQ9sPyULvTHr9wx/ujFiBIrZZ0dg=;
	b=iwR+0vdj3ZmK/iiycn6V5YvauQUf1n+qiO17FJhoZaXsEovruWKNQV0x/FaBrxBC9gVk6e
	osweiJadEjzi9UEwqxZMZF35aPZgehAg2ZJqE8R9zVsuFmkS5s29WmCimefs24DgracJwo
	JLcQc/zfUGX5V3grL2zEl6A07G0WXzk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-pzu3ij8IOimTGU6lVY4Ing-1; Fri,
 05 Jun 2026 13:15:16 -0400
X-MC-Unique: pzu3ij8IOimTGU6lVY4Ing-1
X-Mimecast-MFC-AGG-ID: pzu3ij8IOimTGU6lVY4Ing_1780679715
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 624BF19560A1;
	Fri,  5 Jun 2026 17:15:15 +0000 (UTC)
Received: from [10.22.88.138] (unknown [10.22.88.138])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D8D43000233;
	Fri,  5 Jun 2026 17:15:14 +0000 (UTC)
Message-ID: <110456d5-7164-4032-ae4f-81a97ed96504@redhat.com>
Date: Fri, 5 Jun 2026 13:15:13 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Support multiple source/destination
 cpusets using pids pattern
To: Ridong Chen <ridong.chen@linux.dev>
Cc: cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
References: <20260602023203.248077-7-longman@redhat.com>
 <20260603102604.177503-1-ridong.chen@linux.dev>
 <07bfe9cc-b8ab-4c4c-bfe0-b974abd3ff08@redhat.com>
 <d708fb7a-d12f-40da-95ca-fbc6d0552f07@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <d708fb7a-d12f-40da-95ca-fbc6d0552f07@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16680-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ridong.chen@linux.dev,m:cgroups@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36DFB64A26F

On 6/5/26 3:35 AM, Ridong Chen wrote:
>
> On 6/4/2026 2:47 AM, Waiman Long wrote:
>> On 6/3/26 6:26 AM, Ridong Chen wrote:
>>> The current cpuset_can_attach() and cpuset_attach() functions assume task
>>> migration is from one source cpuset to one destination cpuset. This
>>> can be
>>> wrong in several scenarios:
>>>    - Moving a multi-threaded process with threads in different cpusets
>>>    - Disabling the cpuset controller (many children to one parent)
>>>    - Enabling the cpuset controller (one parent to many children)
>>>
>>> Fix this by adopting the pids subsystem's per-task accounting pattern.
>>> In cpuset_can_attach(), use task_cs(task) to get the correct source
>>> cpuset
>>> for each task (like pids_can_attach uses task_css), adjust
>>> nr_deadline_tasks
>>> and reserve DL bandwidth per-task, and increment attach_in_progress
>>> per-task
>>> on the destination cpuset. In cpuset_attach(), handle destination cpuset
>>> changes within the task iteration loop.
>>>
>>> A shared helper cpuset_undo_attach() reverses the per-task operations for
>>> both partial rollback in cpuset_can_attach() and full reversal in
>>> cpuset_cancel_attach().
>>>
>>> When multiple source cpusets are detected in can_attach(), set
>>> attach_many_sources so that cpuset_attach() forces cpus_updated and
>>> mems_updated to true, ensuring all tasks get properly updated regardless
>>> of which source cpuset cpuset_attach_old_cs points to.
>>>
>>> This eliminates the need for nr_migrate_dl_tasks, sum_migrate_dl_bw, and
>>> dl_bw_cpu fields in struct cpuset.
>>>
>>> Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default
>>> hierarchy")
>>> Signed-off-by: Ridong Chen <ridong.chen@linux.dev>
>> It is not a problem doing per-task DL BW allocation and eliminating the
>> *dl_bw* fields. However, updating nr_deadline_tasks before it is
>> committed can be problematic.
>>
> Good to hear that.
>
>> nr_deadline_tasks is used in dl_rebuild_rd_accounting() which is called
>> by partition_sched_domains_locked(). After the release of cpuset_mutex
>> at the end of cpuset_can_attach() and before cpuset_attach() or
>> cpuset_cancel_attach() is called, it is possible
>> that partition_sched_domains_locked() can be called
>> and dl_rebuild_rd_accounting() is not getting the right DL BW accounting
>> information. So unless there is a way to confirm that this situation
>> cannot happen, we can't change nr_deadline_tasks before the attach is
>> commited.
>>
> We can keep the nr_migrate_dl_tasks field and update nr_deadline_tasks
> once migration is complete. I think this will be much simpler than
> fixing the issue using lists.
>
But we still need to track the set of source and destination cpusets to 
commit or cancel the change. Doing it task-by-task will add code in the 
cpuset_attach() and cpuset_cancel_attach() to check if a task is a DL 
task and act accordingly. So we are just trading task-by-task code with 
code to handle the lists.

Cheers,
Longman


