Return-Path: <cgroups+bounces-17212-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X69JEi1xO2qjXwgAu9opvQ
	(envelope-from <cgroups+bounces-17212-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 07:54:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA6E6BB9BE
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 07:54:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=PJvOU0yi;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17212-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17212-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 627C030BDC24
	for <lists+cgroups@lfdr.de>; Wed, 24 Jun 2026 05:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2186B3290D2;
	Wed, 24 Jun 2026 05:52:26 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D4D327C09
	for <cgroups@vger.kernel.org>; Wed, 24 Jun 2026 05:52:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280345; cv=none; b=J/ssKK+WaqlaL7h6WUZanPQUA11fyiVf7ClVgCGHYhqiIt4NGiN0qZrHNGJhtHwHX34nJ+OK7CdT8xk2DaL51YrUjrFbeG1x6ynkVEbDwWQhLb2aaOwF8sZvLD4ie1PDoqATkz11BXx0+9X3vM58BbVnb69KIWJfh1BPLxsjCA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280345; c=relaxed/simple;
	bh=lNutLdgBVcfzaSe0zfB/rgX3VF9ibBXkW6a8qpgoRD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ccZ3P32wu8H+rowFxMyfwhNLGcI0cg5jfVDlDJa57qbn/Ih0P/eKVsI3kR/ai4uirI0gjWymgNoFFbdxEQ7IgY296wAULeZTjD45VWnvyC8ZbMOq7z6G31DXQ6ymNJvZZxXM6Zha4BVgql4mD6XBbfBiCHaRQh/2EWyrXXh9uhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PJvOU0yi; arc=none smtp.client-ip=95.215.58.172
Message-ID: <2c59b7b7-a3c0-4799-8c39-2288299b117e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782280332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsiEnXmUmSVLGgTWzqORpnaRJ3h8lAWFGgmjylcqD+Q=;
	b=PJvOU0yiGiDiKEW2Cb5tXVqblMIshjWRqG6uo7ZDMW152GopB276SmE7xkoKyNWI4DywHc
	b6yPTTd6geCzZqYA4BUq8qaXuq7K4NLe69u8o2SBvIt/JVE8YtJA4zKgpBjrfPcrcdhHDr
	vZ88B4C/16mQFWAd+iLuwxOdNBAqETI=
Date: Wed, 24 Jun 2026 13:51:46 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] cgroup/cpuset: Avoid unnecessary cpus & mems
 update in cpuset_hotplug_update_tasks()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260623230413.1984188-1-longman@redhat.com>
 <20260623230413.1984188-2-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260623230413.1984188-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17212-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAA6E6BB9BE



On 6/24/2026 7:04 AM, Waiman Long wrote:
> As reported by sashiko [1], cpuset_hotplug_update_tasks() may perform
> unnecessary task iteration and updating of tasks' CPU and node masks
> when mems_allowed and/or cpus_allowed are not set in cpuset v2. It is
> due to the fact that the temporary new_cpus and new_mems masks do not
> inherit parent's effective_cpus/mems when they are empty which is the
> expected behavior for cpuset v2 since commit 4ec22e9c5a90 ("cpuset:
> Enable cpuset controller in default hierarchy").
> 
> Fix that and avoid unnecessay work by enhancing
> compute_effective_cpumask() to add the empty cpumask check
> and inheriting the parent's versions if empty when in v2. A new
> compute_effective_nodemask() helper is also added to perform similar
> function for new effective_mems.
> 
> Add new test_cpuset_prs.sh test cases to confirm that effective_cpus
> will inherit the parent's version if cpuset.cpus is empty.
> 
> [1] https://sashiko.dev/#/patchset/20260621032816.1806773-1-longman%40redhat.com
> 
> Suggested-by: Ridong Chen <ridong.chen@linux.dev>
> Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default hierarchy")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c                        | 45 +++++++++++--------
>   .../selftests/cgroup/test_cpuset_prs.sh       | 11 ++++-
>   2 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aff86acea701..044ddbf66f8e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1094,12 +1094,35 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>    * @cs: the cpuset the need to recompute the new effective_cpus mask
>    * @parent: the parent cpuset
>    *
> + * For v2, the parent's effective_cpus is inherited if cpumask empty.
>    * The result is valid only if the given cpuset isn't a partition root.
>    */
>   static void compute_effective_cpumask(struct cpumask *new_cpus,
>   				      struct cpuset *cs, struct cpuset *parent)
>   {
> -	cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
> +	bool has_cpus;
> +
> +	has_cpus = cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
> +	if (!has_cpus && is_in_v2_mode())
> +		cpumask_copy(new_cpus, parent->effective_cpus);
> +}
> +
> +/**
> + * compute_effective_nodemask - Compute the effective nodemask of the cpuset
> + * @new_cpus: the temp variable for the new effective_mems mask
> + * @cs: the cpuset the need to recompute the new effective_mems mask
> + * @parent: the parent cpuset
> + *
> + * For v2, the parent's effective_mems is inherited if nodemask empty.
> + */
> +static void compute_effective_nodemask(nodemask_t *new_mems,
> +				       struct cpuset *cs, struct cpuset *parent)
> +{
> +	bool has_mems;
> +
> +	has_mems = nodes_and(*new_mems, cs->mems_allowed, parent->effective_mems);
> +	if (!has_mems && is_in_v2_mode())
> +		nodes_copy(*new_mems, parent->effective_mems);
>   }
>   
>   /*
> @@ -2148,15 +2171,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   			goto update_parent_effective;
>   		}
>   
> -		/*
> -		 * If it becomes empty, inherit the effective mask of the
> -		 * parent, which is guaranteed to have some CPUs unless
> -		 * it is a partition root that has explicitly distributed
> -		 * out all its CPUs.
> -		 */
> -		if (is_in_v2_mode() && !remote && cpumask_empty(tmp->new_cpus))
> -			cpumask_copy(tmp->new_cpus, parent->effective_cpus);
> -
>   		/*
>   		 * Skip the whole subtree if
>   		 * 1) the cpumask remains the same,
> @@ -2704,14 +2718,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
>   	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
>   		struct cpuset *parent = parent_cs(cp);
>   
> -		bool has_mems = nodes_and(*new_mems, cp->mems_allowed, parent->effective_mems);
> -
> -		/*
> -		 * If it becomes empty, inherit the effective mask of the
> -		 * parent, which is guaranteed to have some MEMs.
> -		 */
> -		if (is_in_v2_mode() && !has_mems)
> -			*new_mems = parent->effective_mems;
> +		compute_effective_nodemask(new_mems, cp, parent);
>   
>   		/* Skip the whole subtree if the nodemask remains the same. */
>   		if (nodes_equal(*new_mems, cp->effective_mems)) {
> @@ -3923,7 +3930,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   
>   	parent = parent_cs(cs);
>   	compute_effective_cpumask(&new_cpus, cs, parent);
> -	nodes_and(new_mems, cs->mems_allowed, parent->effective_mems);
> +	compute_effective_nodemask(&new_mems, cs, parent);
>   
>   	if (!tmp || !cs->partition_root_state)
>   		goto update_tasks;
> diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> index 0d41aa0d343d..ca9bc38fdb95 100755
> --- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> +++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
> @@ -495,13 +495,20 @@ REMOTE_TEST_MATRIX=(
>   	# Narrowing cpuset.cpus to previously sibling-excluded CPUs should
>   	# not return CPUs that were never actually owned.
>   	"  C1-4:P1   .   C1-2:P1  C1-3:P2  .       .  \
> -	      .      .     .         C3    .       .     p1:4|c11:1-2|c12:3 \
> +	      .      .     .       C3      .       .     p1:4|c11:1-2|c12:3 \
>   							 p1:P1|c11:P1|c12:P2 3"
>   	# Expanding cpuset.cpus to include a previously sibling-excluded CPU
>   	# after the sibling has become a member should correctly request it.
>   	"  C1-4:P1   .   C1-2:P1  C1-3:P2  .       .  \
> -	      .      .      P0     C2-3    .       .     p1:1,4|c11:1|c12:2-3 \
> +	      .      .     P0      C2-3    .       .     p1:1,4|c11:1|c12:2-3 \
>   							 p1:P1|c11:P0|c12:P2 2-3"
> +	# Cpusets with empty cpuset.cpus should inherit parent's effective_cpus
> +	"  C1-4:P1 C5-6   C1-2     .       C5      .  \
> +	      .      P1    P1      .       .       .     p1:3-4|p2:5-6|c11:1-2|c12:3-4|c21:5|c22:5-6 \
> +							 p1:P1|p2:P1|c11:P1"
> +	"  C1-4:P1 C5-6   C1-2     .       C5      .  \
> +	      .      P1    P1      .      O5=0     .     p1:3-4|p2:6|c11:1-2|c12:3-4|c21:6|c22:6 \
> +							 p1:P1|p2:P1|c11:P1"
>   )
>   
>   #

LGTM.

Reviewed-by: Ridong Chen <ridong.chen@linux.dev>

-- 
Best regards
Ridong


