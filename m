Return-Path: <cgroups+bounces-16687-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zNiFEB/kJGq9BAIAu9opvQ
	(envelope-from <cgroups+bounces-16687-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 07 Jun 2026 05:23:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF764EBD7
	for <lists+cgroups@lfdr.de>; Sun, 07 Jun 2026 05:23:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=DXZwWh1t;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16687-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16687-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E9A73015D0B
	for <lists+cgroups@lfdr.de>; Sun,  7 Jun 2026 03:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23A7293B5F;
	Sun,  7 Jun 2026 03:22:48 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0380A4071C6
	for <cgroups@vger.kernel.org>; Sun,  7 Jun 2026 03:22:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780802568; cv=none; b=q4bnEfHSI4CMBlGAtAy0+8ppa/tBWvFxglvZbIgGHQtDXq2CRr1MzuW9DsScEy6sMvSIpAapkIfAx+ukA/MxUELWAA41kDE9nY8IQQ1/YQkrVFxInkp2HQ9iMpW+auWR/kHiMF5HKmtiFxQqNlpND+eC4xXoNrW0iMoFOM7N6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780802568; c=relaxed/simple;
	bh=2iYitQ3EAuqmG5mpV4S9eiK+HHz/npGnNPUPUvusTrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXUp3OdVHqImb5FWhBUxeG4Pk/ooaj8QcFHzNEXqdfyrjRFtt3hVPJD06KZB9Sm+Vxal7MoxcEphmyeDmiCnL8GJ2vfAtAQ2H581hJ+GRoD/bQ2t+k/TJPZJ+uloKY4Dgz4Nq8ZSWs4P9yWqAXAJtrqG6zLDbHGf+lmxIn0rCK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DXZwWh1t; arc=none smtp.client-ip=91.218.175.172
Message-ID: <67d1668e-432a-49cf-b0ae-3d0e7fcb255c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780802555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fzlwgXS2lpLzEKxOHoepV1OUxj5LliQU2tgHbNstAJs=;
	b=DXZwWh1tKiBu8Gbo2ogNHIU/5F533WrxAKQ4KfKa9EkH4nQw4OZCBjuDTmH22Mi6dDtVtS
	UtqXFz0iYjDm/4IkCX4078FBVus5xu62SrEsQdLFObE3uGyYYjvlU3kWipvPwVhuHEdjto
	Hylyn9LL3bxAkp3OEBwbfAUokWEuj2U=
Date: Sun, 7 Jun 2026 11:22:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] cgroup/cpuset: Support multiple source/destination
 cpusets using pids pattern
To: Waiman Long <longman@redhat.com>
Cc: cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org
References: <20260602023203.248077-7-longman@redhat.com>
 <20260603102604.177503-1-ridong.chen@linux.dev>
 <07bfe9cc-b8ab-4c4c-bfe0-b974abd3ff08@redhat.com>
 <d708fb7a-d12f-40da-95ca-fbc6d0552f07@linux.dev>
 <110456d5-7164-4032-ae4f-81a97ed96504@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <110456d5-7164-4032-ae4f-81a97ed96504@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:cgroups@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16687-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:from_mime,linux.dev:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2CF764EBD7



On 6/6/2026 1:15 AM, Waiman Long wrote:
> On 6/5/26 3:35 AM, Ridong Chen wrote:
>>
>> On 6/4/2026 2:47 AM, Waiman Long wrote:
>>> On 6/3/26 6:26 AM, Ridong Chen wrote:
>>>> The current cpuset_can_attach() and cpuset_attach() functions assume
>>>> task
>>>> migration is from one source cpuset to one destination cpuset. This
>>>> can be
>>>> wrong in several scenarios:
>>>>    - Moving a multi-threaded process with threads in different cpusets
>>>>    - Disabling the cpuset controller (many children to one parent)
>>>>    - Enabling the cpuset controller (one parent to many children)
>>>>
>>>> Fix this by adopting the pids subsystem's per-task accounting pattern.
>>>> In cpuset_can_attach(), use task_cs(task) to get the correct source
>>>> cpuset
>>>> for each task (like pids_can_attach uses task_css), adjust
>>>> nr_deadline_tasks
>>>> and reserve DL bandwidth per-task, and increment attach_in_progress
>>>> per-task
>>>> on the destination cpuset. In cpuset_attach(), handle destination
>>>> cpuset
>>>> changes within the task iteration loop.
>>>>
>>>> A shared helper cpuset_undo_attach() reverses the per-task
>>>> operations for
>>>> both partial rollback in cpuset_can_attach() and full reversal in
>>>> cpuset_cancel_attach().
>>>>
>>>> When multiple source cpusets are detected in can_attach(), set
>>>> attach_many_sources so that cpuset_attach() forces cpus_updated and
>>>> mems_updated to true, ensuring all tasks get properly updated
>>>> regardless
>>>> of which source cpuset cpuset_attach_old_cs points to.
>>>>
>>>> This eliminates the need for nr_migrate_dl_tasks, sum_migrate_dl_bw,
>>>> and
>>>> dl_bw_cpu fields in struct cpuset.
>>>>
>>>> Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default
>>>> hierarchy")
>>>> Signed-off-by: Ridong Chen <ridong.chen@linux.dev>
>>> It is not a problem doing per-task DL BW allocation and eliminating the
>>> *dl_bw* fields. However, updating nr_deadline_tasks before it is
>>> committed can be problematic.
>>>
>> Good to hear that.
>>
>>> nr_deadline_tasks is used in dl_rebuild_rd_accounting() which is called
>>> by partition_sched_domains_locked(). After the release of cpuset_mutex
>>> at the end of cpuset_can_attach() and before cpuset_attach() or
>>> cpuset_cancel_attach() is called, it is possible
>>> that partition_sched_domains_locked() can be called
>>> and dl_rebuild_rd_accounting() is not getting the right DL BW accounting
>>> information. So unless there is a way to confirm that this situation
>>> cannot happen, we can't change nr_deadline_tasks before the attach is
>>> commited.
>>>
>> We can keep the nr_migrate_dl_tasks field and update nr_deadline_tasks
>> once migration is complete. I think this will be much simpler than
>> fixing the issue using lists.
>>
> But we still need to track the set of source and destination cpusets to
> commit or cancel the change. Doing it task-by-task will add code in the
> cpuset_attach() and cpuset_cancel_attach() to check if a task is a DL
> task and act accordingly. So we are just trading task-by-task code with
> code to handle the lists.
> 

I resend a patch [1] that keeps nr_migrate_dl_tasks but eliminates
sum_migrate_dl_bw, dl_bw_cpu, attach_node, and attach_llist_head from
the cpuset structure by doing per-task dl_bw_alloc directly in
cpuset_can_attach().

I just offer a way to discuss whether we can solve this issue in a
simpler way.

[1]
https://lore.kernel.org/cgroups/20260602023203.248077-1-longman@redhat.com/T/#mb2c6a3ae44f34f571db5dffa888212eaeaaea17a
-- 
Best regards,
Ridong


