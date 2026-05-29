Return-Path: <cgroups+bounces-16412-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCT6LX/5GGqvpQgAu9opvQ
	(envelope-from <cgroups+bounces-16412-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 04:27:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EA55FC601
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 04:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 017A63017E7D
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 02:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A24131A045;
	Fri, 29 May 2026 02:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i+4KNKUH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD764AA4
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 02:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021610; cv=none; b=dTpaYaBSWDNdaOUpQHiU7vCEcyef7Ub3i2ZdMRYeu0wqe+wC3OQ61ZPvPk0JHL30LzcD8CfBt3kBlp2hioVzXPzcwufV788LscayuGogfECTarh2LhQZJ+Jjy2HIqMQrJRw64x19mNlzHCB+/FhRrO/7xN8cq9RMOFuFQWTo7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021610; c=relaxed/simple;
	bh=UGH2QqLPEp9zCv+ueUBAYKK95pJXS5iyVz7mk194fmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqNvoDyHEt4JdBnFwksT6EhCRlcv8AVzb5kIvOdTenzn0aeMYHF7uN8h8otQWXvglVZJfg4McQ4R6uv6/lXCwggw8cJWEHU+4iG42WbEOHOckD5mRd453Wx5FjtHJULDEXAu/SIjP3H1p2lAn0BZOtznFhN/s/UYcOdLRY5ELao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i+4KNKUH; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6ede505-e9a3-49a0-bfa5-e624c0aa7d6a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780021607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YxKcpUXYzU4Snw/p/J7gxPtzM9ieW643uvRPIyJMv1A=;
	b=i+4KNKUH0IeOrsRax3X5Oq7wxRPFQU151qB+1zKXpsaKpQxX08iQ0Y+yplxCJD7oQxviHS
	RRsABjE7/kuNzrvBd1tPAb2tYShUngHaamP8VdtFqYv+LfmT8ha3tbX2DaMqUnI0Dyw9Xj
	ECbsHCpGeKAqMTwdxToDYhubavNp3I8=
Date: Fri, 29 May 2026 10:26:36 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v3 5/5] cgroup/cpuset: Support multiple
 source/destination cpusets for cpuset_*attach()
To: Waiman Long <longman@redhat.com>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>
References: <20260527153800.1557449-1-longman@redhat.com>
 <20260527153800.1557449-6-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guopeng Zhang <guopeng.zhang@linux.dev>
In-Reply-To: <20260527153800.1557449-6-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16412-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 51EA55FC601
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/5/27 23:38, Waiman Long 写道:
> With cgroup v2, the cgroup_taskset structure passed into the cgroup
> can_attach() and attach() methods can contain task migration data with
> multiple destination or source cpusets when the cpuset controller is
> enabled or disabled respectively.
...
> -/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
> +/*
> + * Called by cgroups to determine if a cpuset is usable; cpuset_mutex held.
> + *
> + * With cgroup v2, enabling of cpuset controller in a cgroup subtree can
> + * cause @tset to contain task migration data from one parent cpuset to multiple
> + * child cpusets. Not much is needed to be done here other than tracking the
> + * number of DL tasks in each cpuset as the CPUs and memory nodes of the child
> + * cpusets are exactly the same as the parent.
> + *
> + * Conversely, disabling of cpuset controller can cause @tset to contain task
> + * migration data from multiple child cpusets to one parent cpuset. Here, the
> + * CPUs and memory nodes of the child cpusets may be different from the parent,
> + * but must be a subset of its parent.
> + *
> + * Another possible many-to-one migration is the moving of the whole
> + * multithreaded process with threads in different cpusets to another cpuset.
> + *
> + * For all other use cases, @tset task migration data should be from one source
> + * cpuset to one destination cpuset.
> + */
>  static int cpuset_can_attach(struct cgroup_taskset *tset)
>  {
>  	struct cgroup_subsys_state *css;
> @@ -3079,6 +3172,16 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>  		goto out_unlock;
>  
>  	cgroup_taskset_for_each(task, css, tset) {
> +		struct cpuset *newcs = css_cs(css);
> +		struct cpuset *new_oldcs = task_cs(task);
> +
> +		if ((newcs != cs) || (new_oldcs != oldcs)) {
> +			cs = newcs;
> +			oldcs = new_oldcs;
> +			ret = cpuset_can_attach_check(cs, oldcs, &setsched_check);
> +			if (ret)
> +				goto out_unlock;
> +		}
Just a minor nit while running checkpatch --strict on this patch:

checkpatch reports unnecessary parentheses here:

if ((newcs != cs) || (new_oldcs != oldcs)) {

Perhaps this can be simplified to:

if (newcs != cs || new_oldcs != oldcs) {
>  		ret = task_can_attach(task);
>  		if (ret)
...
>  	/*
>  	 * In the default hierarchy, enabling cpuset in the child cgroups
> -	 * will trigger a number of cpuset_attach() calls with no change
> -	 * in effective cpus and mems. In that case, we can optimize out
> -	 * by skipping the task iteration and update.
> +	 * will trigger a cpuset_attach() call with no change in effective cpus
> +	 * and mems. In that case, we can optimize out by skipping the task
> +	 * iteration and update, but the destination cpuset list is iterated to
> +	 * set old_mems_sllowed.
>  	 */
I also noticed one small typo in the added comment:

s/old_mems_sllowed/old_mems_allowed/

Best,
Guopeng



