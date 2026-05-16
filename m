Return-Path: <cgroups+bounces-15995-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CG9dCGT0B2q6RQMAu9opvQ
	(envelope-from <cgroups+bounces-15995-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:36:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D955A35D
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 06:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32044301DAE0
	for <lists+cgroups@lfdr.de>; Sat, 16 May 2026 04:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B552D7D59;
	Sat, 16 May 2026 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjIV4Emo"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE9242D6B
	for <cgroups@vger.kernel.org>; Sat, 16 May 2026 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778906179; cv=none; b=PyiA49CwIJ1YZw7+8oPV5c6Xpcv1SW59gB6Sa8lQW/zXGcfRxNER3VFcv89x1bHQAD4WUWu9rTzpq+wsYjXZ6YQBubWLB2r1pai3+Hg7lf1Ot0H+Im7D7rEJFWB0dctwyiKJy5+7QIB+OJQS+DdODbti/KeHNgZ3zjfGoSpmjfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778906179; c=relaxed/simple;
	bh=EumMv958u6WFgQoAbYddJahq8sxAYgschaxIgCjxmI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fds1kKxLOTVTW6MazqGgJiYe3Rb74IU+QTX6H2DY+AKUrGtqCETXePoqAJ34p8Cdn8xT75P8iLK20zNd9pRIAYKi3BAxDpm/LB4vJNcK7RtruT0zJIwirgoaKPCxN7OKxz2//5ry4Y+5uvdvZeMzFKS+jh7E9TxnGpchbXH6oJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjIV4Emo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778906177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bgnrVTKye5LKooEivoS4UZIbyKmBRGGYjO2dcA8RwEg=;
	b=BjIV4EmotOkdcqkhplTAMz5XlQ3NLtW8KuhJn7P6BpFXH9/ugHTW9KAsMkK/CFFBtupu5D
	krEbsw0BF9fcXBqMUq+FwapwBHYBjl0QvFMfD02llasYZlr7zwvMrXQs9t3/58q2B2NAIF
	2+1IEtLucaWk3Xn3wUZw0MqROL2FsMQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-TqtxovQTM8Ktmk-2YBmC6w-1; Sat,
 16 May 2026 00:36:12 -0400
X-MC-Unique: TqtxovQTM8Ktmk-2YBmC6w-1
X-Mimecast-MFC-AGG-ID: TqtxovQTM8Ktmk-2YBmC6w_1778906168
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F7EE1956080;
	Sat, 16 May 2026 04:36:08 +0000 (UTC)
Received: from [10.2.16.156] (unknown [10.2.16.156])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 796001956053;
	Sat, 16 May 2026 04:36:02 +0000 (UTC)
Message-ID: <318fc8b9-87d1-4288-9881-7a83a521b2c2@redhat.com>
Date: Sat, 16 May 2026 00:36:02 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next v2 0/5] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
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
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260516042448.698216-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 821D955A35D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-15995-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/16/26 12:24 AM, Waiman Long wrote:
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

Sorry, I forgot to add the change log. It is basically to address all 
the AI review comments [1] for my v1 patch.

The 2 major changes are to move cpuset_migrate_mm() into 
cpuset_attach_task() and add a new field in task_struct to record the 
old cpuset to be used by cpuset_migrate_mm(). There also some other 
minor changes.

[1] 
https://lore.kernel.org/lkml/4f49602d35d987e029b8e92a577f0c60@kernel.org/

Cheers,
Longman

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


