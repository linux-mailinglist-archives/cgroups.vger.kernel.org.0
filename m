Return-Path: <cgroups+bounces-15921-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OjhMggHBWpRRgIAu9opvQ
	(envelope-from <cgroups+bounces-15921-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 01:19:36 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4917E53BE6B
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 01:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 707F5301982C
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 23:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F51459FA;
	Wed, 13 May 2026 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwTSNZ2d"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6072D29C8
	for <cgroups@vger.kernel.org>; Wed, 13 May 2026 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714372; cv=none; b=bQOsnB2BMds5TPuze9X0J2FQEr73Qq9bBoz+yg2iksDvUutrTfpH8SMoj6UA3D+yWXeZXtO5RafoVw2xW3e/LdHlcaxy3lct+zn/6+vVMgia26/n+MQrH0Y7CyKR4thg/lA+ps7VcVuKFPUFkK8khhBgUit1XUe/IQGT+mYe2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714372; c=relaxed/simple;
	bh=3uhEIPdnMU7KGazrzEMyDj6Qjxnp5LuVcvHLzjrnX9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMZ254W9CiVXYDtyntHfyE3xncmqzd2BpPMLzcnX4m3G41BX6mrM2Cwfh9Ko0Q5Le7i6VJxhIlWB5X8cI8pHS8FfAVDljqVG0wStDi/F3k2WtcjeTCqcuwvRWCmWtjMwAJ9lyes5BFFDR0LLzfQ80uujj7+8N3cdlbHfKD4oWoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AwTSNZ2d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778714369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbWjhWRRAD6ZqWp2yB7RTFthTtVuOIuBTOBGrRgF5UU=;
	b=AwTSNZ2d9uzDGpIvcv5u/XE+dVbmZMsoKTYR54y5nxdZhzhBIqfY3WIsO8XT9an/wznVOL
	G9Uv8cwz+eN0THOAgyYx9yZ1siFhKIPZZtDkD7GIjy6aZ8+CR7S77tMAF8BzwjnRQ4iDoY
	WYA9hPXhNN6CKl4FCVAk2rp3Ypz1wf0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-9vND738FNKyy_diFdqZ0MQ-1; Wed,
 13 May 2026 19:19:24 -0400
X-MC-Unique: 9vND738FNKyy_diFdqZ0MQ-1
X-Mimecast-MFC-AGG-ID: 9vND738FNKyy_diFdqZ0MQ_1778714362
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4CA5C195608B;
	Wed, 13 May 2026 23:19:22 +0000 (UTC)
Received: from [10.2.17.34] (unknown [10.2.17.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8D1921800240;
	Wed, 13 May 2026 23:19:19 +0000 (UTC)
Message-ID: <7ae7fe29-6405-41e3-9f3b-6c1d0255dc9e@redhat.com>
Date: Wed, 13 May 2026 19:19:18 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: Fix multi-source deadline task accounting and
 bandwidth bypass
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Aaron Tomlin <atomlin@atomlin.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: chenridong@huaweicloud.com, neelx@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260512010341.101419-1-atomlin@atomlin.com>
 <ddc8040f-2186-4c72-a69e-26b388cb7249@arm.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ddc8040f-2186-4c72-a69e-26b388cb7249@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 4917E53BE6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15921-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 12:22 PM, Dietmar Eggemann wrote:
> On 12.05.26 03:03, Aaron Tomlin wrote:
>> During a batch migration where threads in a taskset originate from
>> multiple source cpusets (e.g., via cgroup.procs), cpuset_can_attach()
>> and cpuset_attach() currently evaluate the source cpuset exactly once
>> by caching the first task's oldcs.
>>
>> This creates two distinct critical flaws for SCHED_DEADLINE tasks:
>>
>>      1.  oldcs->nr_deadline_tasks is decremented solely on the first
>>          source cpuset. If tasks originated from other cpusets, their
>>          counts are permanently leaked, and the first cpuset permanently
>>          underflows.
>>
>>      2.  cpumask_intersects() is evaluated strictly against the first
>>          task's source cpuset. This allows tasks originating from
>>          entirely isolated root domains to silently bypass the
>>          dl_bw_alloc() admission control.
>>
>> This patch refactors the deadline accounting to evaluate task_cs(task)
>> on a per-task basis during the cgroup_taskset_for_each() loops. To
>> achieve accurate accounting before the core cgroup migration actually
>> executes, the permanent nr_deadline_tasks increments/decrements are
>> shifted into cpuset_can_attach(). If the migration aborts, the counts
>> are gracefully reverted via an internal rollback loop or the
>> cpuset_cancel_attach() callback.
> Is there a testcase to provoke this issue in the current code?
>
> I tried to move a process with 6 DL tasks from one cpuset to another by:
>
> echo $PID > /sys/fs/cgroup/B/cgroup.procs
>
> but in this case old_cs is the same for all these tasks.
>
> [ 1991.852034] cgroup_migrate() (7) leader=[dl_batch_cgroup 823] threadgroup=1
> [ 1991.852068] cgroup_migrate_execute() tset->nr_tasks=7
> [ 1991.852238] cpuset_can_attach() (4) [dl_batch_cgroup 832] nr_migrate_dl_tasks=1 sum_migrate_dl_bw=104857 old_cs=ffff0000c4955200
> [ 1991.852246] cpuset_can_attach() (4) [dl_batch_cgroup 833] nr_migrate_dl_tasks=2 sum_migrate_dl_bw=209714 old_cs=ffff0000c4955200
> [ 1991.852248] cpuset_can_attach() (4) [dl_batch_cgroup 834] nr_migrate_dl_tasks=3 sum_migrate_dl_bw=314571 old_cs=ffff0000c4955200
> [ 1991.852249] cpuset_can_attach() (4) [dl_batch_cgroup 835] nr_migrate_dl_tasks=4 sum_migrate_dl_bw=419428 old_cs=ffff0000c4955200
> [ 1991.852249] cpuset_can_attach() (4) [dl_batch_cgroup 836] nr_migrate_dl_tasks=5 sum_migrate_dl_bw=524285 old_cs=ffff0000c4955200
> [ 1991.852250] cpuset_can_attach() (4) [dl_batch_cgroup 837] nr_migrate_dl_tasks=6 sum_migrate_dl_bw=629142 old_cs=ffff0000c4955200
> [ 1991.852328] cpuset_attach() (5) cs=ffff0000c1e9fc00 oldcs=ffff0000c4955200 cs->nr_deadline_tasks=6 oldcs->nr_deadline_tasks=6 cs->nr_migrate_dl_tasks=6
>
> dl_batch_cgroup     823     823  19      -   0 TS
> dl_batch_cgroup     823     832 140      0   - DLN
> dl_batch_cgroup     823     833 140      0   - DLN
> dl_batch_cgroup     823     834 140      0   - DLN
> dl_batch_cgroup     823     835 140      0   - DLN
> dl_batch_cgroup     823     836 140      0   - DLN
> dl_batch_cgroup     823     837 140      0   - DLN
>
> [...]

Multiple source or destination cpusets in task migration can only 
happens when the cpuset controller is enabled or disabled in a cgroup 
subtree. If there are DL tasks in 2 or more child cgroups, enabling or 
disabling of the cpuset controller for those child cgroups may lead to 
incorrect DL task accounting. This patch will probably fix the DL 
accounting aspect. However, there are also other issues unrelated to DL 
tasks that need to be addressed as well. So this patch is incomplete in 
this regard. I am working on a patch series to address these issues. 
Hopefully I can send it out in a day or 2.

Cheers,
Longman


