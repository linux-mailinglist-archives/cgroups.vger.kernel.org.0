Return-Path: <cgroups+bounces-16877-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sOQfIj8hK2o33AMAu9opvQ
	(envelope-from <cgroups+bounces-16877-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 22:57:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEA8675557
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 22:57:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bIB09NDg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16877-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16877-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DAA6312B20B
	for <lists+cgroups@lfdr.de>; Thu, 11 Jun 2026 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E41344CAC9;
	Thu, 11 Jun 2026 20:57:32 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4636F437
	for <cgroups@vger.kernel.org>; Thu, 11 Jun 2026 20:57:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781211451; cv=none; b=H4in/hXNI75BooQ3cW5va34eGTCp4tfTsdIFbeihnuuO+Y2qESXuY7slitOGC0YlwnS9csVagNEDJyiNHKFzIgZnT0UL1KPLqD8WXg++zYpW+t3FR07fTtnACM0v/ra2VYUAt3dsbLLi7Xq0KKLyfe5r9FwyhnoLqisBbDUmXYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781211451; c=relaxed/simple;
	bh=UlA7E7NbDSnbp6daveohZX66tA+tlaAGsgHpQP8n1DI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAU4oRVYMqG04OVq0hNPVISdF722uWVgUYtBaf8LlVLmhQCeAeTbXKXIGPefyarCBOHZr+gELI4QoeDHxyH5i4/Dud9jjqba/Qf1WQbnmoeI5H8ATmgapiIPKLjQY7n+yizenl+cKaQNwQxMQbpiDK+P4kRjZqjFJsRJPqX5whM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIB09NDg; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781211449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m+QAUPgzRX/aZ+sMnzyXeZCn4csLtyPznM7PH7Z1STA=;
	b=bIB09NDgCSuA8DQpecWCKHpA/9p330anumR+p3Mj8vSY3MhsS/VbIOv3TPhaBTJoOBL/1d
	8J12HzDvm32DbLe0YoPwKkiX8T48iE2YXsORRyRbq4r0XjyVLJzpSGjyhuyByoOd7gq/ul
	/8cYvvtab3pMnOG8VazG3O/7gLW+pIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-vd5UOKKrMTyLLmt_Nc_w4w-1; Thu,
 11 Jun 2026 16:57:26 -0400
X-MC-Unique: vd5UOKKrMTyLLmt_Nc_w4w-1
X-Mimecast-MFC-AGG-ID: vd5UOKKrMTyLLmt_Nc_w4w_1781211444
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6050618004D8;
	Thu, 11 Jun 2026 20:57:23 +0000 (UTC)
Received: from [10.22.88.176] (unknown [10.22.88.176])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56EB930A8;
	Thu, 11 Jun 2026 20:57:19 +0000 (UTC)
Message-ID: <72602b83-9053-4f19-8b87-2516bf23ea03@redhat.com>
Date: Thu, 11 Jun 2026 16:57:18 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] sched/fair: Add cgroup_mode: max
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@kernel.org, chenridong@huaweicloud.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com,
 qyousef@layalina.io
References: <20260605105513.354837583@infradead.org>
 <20260605124051.589618504@infradead.org>
 <d4ca5fe7-fd76-47c8-949a-a69916bfcbd4@redhat.com>
 <20260611134724.GK48970@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260611134724.GK48970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16877-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@kernel.org,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDEA8675557

On 6/11/26 9:47 AM, Peter Zijlstra wrote:
> On Wed, Jun 10, 2026 at 11:09:59AM -0400, Waiman Long wrote:
>
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -4116,6 +4116,21 @@ bool cpuset_cpus_allowed_fallback(struct
>>>    	return changed;
>>>    }
>>> +int cpuset_num_cpus(struct cgroup *cgrp)
>>> +{
>>> +	int nr = num_online_cpus();
>>> +	struct cpuset *cs;
>>> +
>>> +	if (is_in_v2_mode()) {
>>> +		guard(rcu)();
>>> +		cs = css_cs(cgroup_e_css(cgrp, &cpuset_cgrp_subsys));
>>> +		if (cs)
>>> +			nr = cpumask_weight(cs->effective_cpus);
>>> +	}
>>> +
>>> +	return nr;
>>> +}
>> I just have a question about cgroup v1 support. I am assuming that cgroup v1
>> without the cpuset_v2_mode mount option is not supported.
> Correct.
>
>> To fully support
>> cgroup v1, you may have to use guarantee_active_cpus() to return the actual
>> set of CPUs that the task can run on.
> Except this is group based, we'd need an iteration of all tasks in the
> group and compute a union of guarantee_active_cpus(). Which all seems
> far too expensive and not worth the effort.
I thought so.
>
>> Also there is a caveat about the arm64 specific
>> task_cpu_possible_mask() for certain arm64 CPUs. That is for 32-bit
>> binary running on 64-bit core which are allowed only on a selected
>> subset of cores within the CPU.
>>
>> This is probably not what you want to focus on right now, but it will be
>> good to have a comment to list items that are not fully supported here.
> Will add a comment!
Thanks,
Longman


