Return-Path: <cgroups+bounces-16810-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BWBbBF+AKWonYAMAu9opvQ
	(envelope-from <cgroups+bounces-16810-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:18:55 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D7966AA2D
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 17:18:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=DuqCRsg4;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16810-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-16810-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 674E531393DF
	for <lists+cgroups@lfdr.de>; Wed, 10 Jun 2026 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF194279FE;
	Wed, 10 Jun 2026 15:10:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0E3A450F
	for <cgroups@vger.kernel.org>; Wed, 10 Jun 2026 15:10:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104213; cv=none; b=B0PcTMjidDcPrN4tJA4O1BSsjDirtSHkXmSSmlEcZwLjDHtKHYEQbygpr6VWnt+77TLFeUyVBiGuiVc9Pae0FfRVvScoSYuJkKkqDGGjuwzYd4zuz7u0OjhZnmXxX/GXSCzSANgoJ2slD3LVsJ99U4OcpWL8CYgEb/KVL8sPSDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104213; c=relaxed/simple;
	bh=5+T1GEvAkC90qKkSbdecGqqHPzsvV49A0GJieKFJmMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLSBvq4cilvJd5VdUgdzC+VwcwAbM6E2Wv5Ys8FEoQvJlaOAMn4OOSO5GJmJYxdiNEDCYv7OV7tZNXEOa+Yp0LJuGXI/yIGHu717ysL7ZMpC6cEJ0aC/hZIB0/yvXz2gQP197COzHQm+Aw40LCY0lYYm8gDh3LYkFRyJ8sLIEHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuqCRsg4; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781104211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IOUcnZUw3N77mwJH6RqoUVWGFP1BcRpjcwVubeKVbus=;
	b=DuqCRsg43kInQxPWC/Wl5SS6HGoyp+mTy1rFpzC9EIGzhfbqE9NVShNuabEJTk2XBoYVHX
	Y6lkZowe2/Na1XfseB7Bo9rD1AzGw/obBuObVtfAZit7W+FrhxrOHbaI4cNLpZ3YMProBo
	DuUO0lI6WhpyxQhK/2SaF3TwB+5ctks=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-kh2Ic6bxNJm_MUWhjJGcMQ-1; Wed,
 10 Jun 2026 11:10:06 -0400
X-MC-Unique: kh2Ic6bxNJm_MUWhjJGcMQ-1
X-Mimecast-MFC-AGG-ID: kh2Ic6bxNJm_MUWhjJGcMQ_1781104204
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 24995195FDD4;
	Wed, 10 Jun 2026 15:10:04 +0000 (UTC)
Received: from [10.22.81.61] (unknown [10.22.81.61])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F427763;
	Wed, 10 Jun 2026 15:10:00 +0000 (UTC)
Message-ID: <d4ca5fe7-fd76-47c8-949a-a69916bfcbd4@redhat.com>
Date: Wed, 10 Jun 2026 11:09:59 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] sched/fair: Add cgroup_mode: max
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc: chenridong@huaweicloud.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, jstultz@google.com, kprateek.nayak@amd.com,
 qyousef@layalina.io
References: <20260605105513.354837583@infradead.org>
 <20260605124051.589618504@infradead.org>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260605124051.589618504@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16810-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:mingo@kernel.org,m:chenridong@huaweicloud.com,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 87D7966AA2D

On 6/5/26 8:40 AM, Peter Zijlstra wrote:
> In order to avoid the average CPU fraction avg(F_g_n) becoming tiny '1/N',
> assume each cgroup is maximally concurrent and distrubute 'N*weight', such
> that:
>
> 	F_g_n' = N * F_g_n
>
> Giving:
>
> 	avg(F_g_n') = N*avg(F_g_n) ~ N * 1/N = 1
>
> And while this sounds like it solves things, remember what that ~ meant. There
> is the corner case when a cgroup is minimally loaded, eg a single runnable
> task, therefore limit the CPU fraction to that of a nice -20 task to avoid
> getting too much load.
>
> This last bit is what makes it different from a previous proposal to allow
> raising cpu.weight to '100 * N', that would not limit the mininal concurrency
> case and results in a very large F_g_n. And just like F_g_n << 1 is
> problematic, so is F_g_n >> 1 for the exact same reasons (it would drown the
> kthreads, but it also risks overflowing the load values).
>
> So while this might appear to be a better scheme than the current default
> scheme, it doesn't really handle less than maximal concurrency nicely -- it
> clips and introduces artificially large weights. So where the traditional SMP
> mode works well when nr_tasks << nr_cpus, MAX doesn't work well in that regime
> and vice-versa.
>
> The meaning of "cpu.weight" would be: weight per allowed CPU.
>
> Included for completeness (and infrastructure).
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/cpuset.h |    6 +++++
>   kernel/cgroup/cpuset.c |   15 ++++++++++++++
>   kernel/sched/debug.c   |    1
>   kernel/sched/fair.c    |   52 ++++++++++++++++++++++++++++++++++++++++++++-----
>   4 files changed, 69 insertions(+), 5 deletions(-)
>
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -80,6 +80,7 @@ extern void lockdep_assert_cpuset_lock_h
>   extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
>   extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>   extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
> +extern int cpuset_num_cpus(struct cgroup *cgroup);
>   extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>   #define cpuset_current_mems_allowed (current->mems_allowed)
>   void cpuset_init_current_mems_allowed(void);
> @@ -216,6 +217,11 @@ static inline bool cpuset_cpus_allowed_f
>   	return false;
>   }
>   
> +static inline int cpuset_num_cpus(struct cgroup *cgroup)
> +{
> +	return num_online_cpus();
> +}
> +
>   static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
>   {
>   	return node_possible_map;
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4116,6 +4116,21 @@ bool cpuset_cpus_allowed_fallback(struct
>   	return changed;
>   }
>   
> +int cpuset_num_cpus(struct cgroup *cgrp)
> +{
> +	int nr = num_online_cpus();
> +	struct cpuset *cs;
> +
> +	if (is_in_v2_mode()) {
> +		guard(rcu)();
> +		cs = css_cs(cgroup_e_css(cgrp, &cpuset_cgrp_subsys));
> +		if (cs)
> +			nr = cpumask_weight(cs->effective_cpus);
> +	}
> +
> +	return nr;
> +}

I just have a question about cgroup v1 support. I am assuming that 
cgroup v1 without the cpuset_v2_mode mount option is not supported. To 
fully support cgroup v1, you may have to use guarantee_active_cpus() to 
return the actual set of CPUs that the task can run on. Also there is a 
caveat about the arm64 specific task_cpu_possible_mask() for certain 
arm64 CPUs. That is for 32-bit binary running on 64-bit core which are 
allowed only on a selected subset of cores within the CPU.

This is probably not what you want to focus on right now, but it will be 
good to have a comment to list items that are not fully supported here.

Cheers,
Longman


