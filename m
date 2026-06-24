Return-Path: <cgroups+bounces-17265-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3RGsJudiPGp0nggAu9opvQ
	(envelope-from <cgroups+bounces-17265-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 01:06:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEFE6C1DAB
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 01:06:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=fearLAs6;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17265-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17265-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB053302A07B
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 23:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D65728506C;
	Wed, 24 Jun 2026 23:06:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72740D57C
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 23:06:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782342372; cv=none; b=fp2HlE5DLzBOXknGohGRJHuOj59F8uNM6/ma0wpwYtncqEwxhnIEyMOc5ZIAA3RDLpiNZ1uq3xiUkM1xEQ6xPpNW9ozC/23A20UDW6sGBUBWeYtF/qIOf+61+iEIocyrgQTD/rNAYr4koUcQugmu/UGT4SOicrxF1yYgRKZ8ko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782342372; c=relaxed/simple;
	bh=dmqY8eWPh+ekdarjOka1+FiNuDA/fYcSsJIZYsUGjAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryrv+wWiafeYxYCQOhLcQMnE+9e3Q9Al3A0zZ7TYhkBpECqFyd+xbu/VA+IOm6M2w3QaT2unrKdjOoiKqAokAxyA3ums5ekTgsC/8gcgs1LughGYawCHmHV5Zd7aC2XCHWe9alT8JU3lYeQbM0P2NJJPC1yx/v62RLou4x023EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fearLAs6; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782342369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ctAF/cRGqZy47fl6Rso6AUMkvceLgU6qkk/r0m4+ao=;
	b=fearLAs6R+6VYKeIGCApdRt9U9WoKnh43VGvwU3CFq3a469PjdEvVXMi+e22xgKYw1mQeH
	88hT+KOuDZhO7//hJ6QJ50GKpRhp/yb0Me/lSD/KcOpMDfVhmWVJoIaNfb8UJIHnyzTT+y
	GMK1iDO4YMt1+KNvSfVkrPU/Tr8F3pk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-jqTIXzYUPwqrhMxN3-A7zQ-1; Wed,
 24 Jun 2026 19:06:07 -0400
X-MC-Unique: jqTIXzYUPwqrhMxN3-A7zQ-1
X-Mimecast-MFC-AGG-ID: jqTIXzYUPwqrhMxN3-A7zQ_1782342366
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EB3E195604F;
	Wed, 24 Jun 2026 23:06:05 +0000 (UTC)
Received: from [10.2.16.163] (unknown [10.2.16.163])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E292D763;
	Wed, 24 Jun 2026 23:06:01 +0000 (UTC)
Message-ID: <2541a9a9-44f0-4b70-bf3f-920d82bfda6b@redhat.com>
Date: Wed, 24 Jun 2026 19:06:00 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v5 6/6] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aaron Tomlin <atomlin@atomlin.com>,
 Guopeng Zhang <guopeng.zhang@linux.dev>, Ridong Chen <ridong.chen@linux.dev>
References: <20260602023203.248077-1-longman@redhat.com>
 <20260602023203.248077-7-longman@redhat.com>
 <ajutWBoJqkhktkvX@localhost.localdomain>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ajutWBoJqkhktkvX@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17265-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:peterz@infradead.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:atomlin@atomlin.com,m:guopeng.zhang@linux.dev,m:ridong.chen@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAEFE6C1DAB

On 6/24/26 11:45 AM, Michal Koutný wrote:
> Hello Waiman.
>
> On Mon, Jun 01, 2026 at 10:32:03PM -0400, Waiman Long <longman@redhat.com> wrote:
>> This problem is less an issue when enabling the cpuset controller as all
>> the newly created child cpusets will have exactly the same set of CPUs
>> and memory nodes except when deadline tasks are involved in migration
>> as the deadline task accounting data can be off.
>>
>> It can be more problematic when the cpuset controller is disabled as
>> their set of CPUs and memory nodes may differ from their parent or with
>> the moving of multi-threaded process from different threaded cgroups.
> When I generalize that it can be an issue for any threaded controller
> that somehow relies on the _difference_ between old and new thread
> membership.
>
> So I checked some: pids and perf_events look alright (no
> diff-dependency) but I noticed the very same issue is tackled in
> sched_change_group/scx_cgroup_move_task and that there is a member
> inside task_struct allocated for this state tracking already:
>    task_struct::scx::cgrp_moving_from
>
>> Fix that by tracking the set of source (old) and destination cpusets
>> in singly linked lists and iterating them all to properly update the
>> internal data. Also keep the current cs and oldcs variables up-to-date
>> with the css and task iterators.
> So there would be more than a single use for something conceptually
> like:
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 004e6d56a499a..740c02f220c75 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1326,6 +1326,9 @@ struct task_struct {
>   #ifdef CONFIG_PREEMPT_RT
>          struct llist_node               cg_dead_lnode;
>   #endif /* CONFIG_PREEMPT_RT */
> +#ifdef CONFIG_CGROUPS_MOVING_FROM
> +       struct cgroup                   *cgrp_moving_from;
> +#endif
>   #endif /* CONFIG_CGROUPS */
>   #ifdef CONFIG_X86_CPU_RESCTRL
>          u32                             closid;
> diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
> index 1a3af2ea2a794..5b63afe83f333 100644
> --- a/include/linux/sched/ext.h
> +++ b/include/linux/sched/ext.h
> @@ -240,9 +240,6 @@ struct sched_ext_entity {
>          bool                    disallow;       /* reject switching into SCX */
>   
>          /* cold fields */
> -#ifdef CONFIG_EXT_GROUP_SCHED
> -       struct cgroup           *cgrp_moving_from;
> -#endif
>          struct list_head        tasks_node;
>   };
>   
> diff --git a/init/Kconfig b/init/Kconfig
> index 2937c4d308aec..d7e7d4477f862 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1186,6 +1186,7 @@ config EXT_GROUP_SCHED
>          depends on SCHED_CLASS_EXT && CGROUP_SCHED
>          select GROUP_SCHED_WEIGHT
>          select GROUP_SCHED_BANDWIDTH
> +       select CGROUPS_MOVING_FROM
>          default y
>   
>   endif #CGROUP_SCHED
> @@ -1288,6 +1289,7 @@ config CPUSETS
>          depends on SMP
>          select UNION_FIND
>          select CPU_ISOLATION
> +       select CGROUPS_MOVING_FROM
>          help
>            This option will let you create and manage CPUSETs which
>            allow dynamically partitioning a system into sets of CPUs and
>
> I think this could simplify the before-after state tracking generally,
> WDYT?

I had actually introduced a new task_struct field in an early version to 
track the old cpuset to handle memory migration. However, Chen Ridong 
had shown me that we may not really need such granular detail. So I drop 
it in the newer versions. Also sharing a common field between cpuset and 
sched_ext can introduce complication as we have to make sure that we 
won't step into each other.

Thank for the suggestion anyway and I will reconsider it in case it is 
found that we really need such information to do the right thing.

Cheers,
Longman


