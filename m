Return-Path: <cgroups+bounces-16119-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPeXA7xyDWpUxgUAu9opvQ
	(envelope-from <cgroups+bounces-16119-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 10:37:16 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 893BC589E86
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 10:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A86930C61B9
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158D43A9618;
	Wed, 20 May 2026 08:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UGNcUCZ2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D0343886
	for <cgroups@vger.kernel.org>; Wed, 20 May 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265794; cv=none; b=T+JDIqjW7dIqD0Y5J0HEa+0Rxd841YUSfWfSsLY9/Q5oj8vwg6LTlRupgPUL6ynv8vqQle6abhwdPOI+UaZJ/ycfSw2K42ESPU+9IeI7yy5s3P93PhDPqNIM0Iwy55iE5jsCqkQzV45FcTqVWGmie0dmemDpU6Rjt3SWWvmD1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265794; c=relaxed/simple;
	bh=4dGHBUaC0lXk8XhGqBlJBgVqSawjCbWxlCP4Jnu68H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LVmi6uziFqLp81wkWNhabU7q4gnDH+Rfb270AcmiGVBR+NVy2lTyn50UohwzyJwn1DX/31re2+r45n9TcN7+I7jT82DAp0B5lqeU50Gaf2djb90EW0vdBzcpz3aJmX+A/smM40EZ62mx7TSQTdN7VD6nnpCMax+JkTxhVMe2N1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UGNcUCZ2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3936b856-cf88-41a9-bb3f-4f48440e2692@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779265791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLY4P9cX/pTfkn1UIOKp2eNoI0Xihn/4il/vBJw2HU4=;
	b=UGNcUCZ2pAW6+J0nsQcqj4+quri8tmEa5KgswvcVDemJr2H+oLBSo3wcPgrJyjutmKjbSu
	2f2rhREO/K3Pw0OODn4sVIw4XKWSEPbqUC7I3T6aqlHqCY3HO5JqfA9GUvAkhvZJokIs5N
	7ALh0q2qIzv3/mJKfKjksKQLQvr8skw=
Date: Wed, 20 May 2026 16:29:40 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH cgroup/for-next v2 0/5] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
To: Waiman Long <longman@redhat.com>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>
References: <20260516042448.698216-1-longman@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260516042448.698216-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16119-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 893BC589E86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/16 12:24, Waiman Long wrote:
> Sashiko AI review of another cpuset patch had found that cpuset_attach()
> and cpuset_can_attach() can be passed a cgroup_taskset with tasks
> migrating from one source cpuset to multiple destination cpusets and
> vice versa.  Further testing of the cpuset code indicates that this is
> indeed the case when the v2 cpuset controller is enabled or disabled.
> 
> Unfortunately, cpuset_attach() and cpuset_can_attach() still assume that
> there will be one source and one destinaton cpuset which may result in
> inocrrect behavior.
> 

Hi Longman,

I am thinking whether we can use the pids subsystem's approach to solve 
this issue, which I think could be much simpler.

For the DL task accounting, we can handle it the same way 
pids_can_attach() does - just call task_cs(task) for each task 
individually inside the can_attach() loop and do the nr_deadline_tasks 
adjustment right there. This eliminates the need to pass per-task source 
cpuset information to the attach() callback entirely for DL accounting 
purposes.

For cpuset_migrate_mm(), I don't think we need per-task oldcs storage in 
task_struct either. The scenarios where multiple source cpusets are 
involved are:

enable cpuset controller: child cpusets inherit parent's effective_mems, 
so attach_mems_updated is false and cpuset_migrate_mm() is never called.

disable cpuset controller: tasks move from children to parent. Since 
children's effective_mems is always a subset of parent's effective_mems, 
even if cpuset_migrate_mm() is triggered, it's effectively a noop (no 
pages need to move from a subset to its superset).

cgroup.procs write with threads in different cpusets: this is a 
many-to-one migration with a single process, so there is only one 
group_leader and one mm. We only need to record the leader's oldcs, 
which a single static variable can handle.

So in all cases, the migration path only needs one oldcs for the leader. 
We don't need to add a field to task_struct.

What do you think?



> This patch series is created to fix this issue. The first 2 patches are
> just preparatory patches to make the remaining patches easier to review.
> 
> Patch 3 adds a new attach_old_cs field into task_struct to track the
> old cpuset to be used in case when cpuset_migrate_mm() needs to be
> called in cpuset_attach().
> 
> Patch 4 moves mpol_rebind_mm() and cpuset_migrate_mm() inside
> cpuset_attach_task() to make CLONE_INTO_CGROUP flag of clone(2) works
> more like moving task from one cpuset to another one, while also make
> supporting multiple source and destination cpusets easier.
> 
> Patch 5 makes the necessary changes to enable the support of multiple
> source and destination cpusets by keeping all the source and destination
> cpusets found during task iterations in two singly linked lists for
> source and destination cpusets respectively.
> 
> Waiman Long (5):
>    cgroup/cpuset: Add a cpuset_reserve_dl_bw() helper
>    cgroup/cpuset: Expand the scope of cpuset_can_attach_check()
>    cgroup/cpuset: Replace cpuset_attach_old_cs by a new attach_old_cs
>      field in task_struct
>    cgroup/cpuset: Move mpol_rebind_mm/cpuset_migrate_mm() calls inside
>      cpuset_attach_task()
>    cgroup/cpuset: Support multiple source/destination cpusets for
>      cpuset_*attach()
> 
>   include/linux/sched.h           |   3 +
>   kernel/cgroup/cpuset-internal.h |   6 +
>   kernel/cgroup/cpuset.c          | 358 +++++++++++++++++++++-----------
>   3 files changed, 249 insertions(+), 118 deletions(-)
> 

-- 
Best regards,
Ridong

