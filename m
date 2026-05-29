Return-Path: <cgroups+bounces-16411-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOfXNTX4GGqvpQgAu9opvQ
	(envelope-from <cgroups+bounces-16411-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 04:21:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D1F5FC56F
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 04:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35A86302C78B
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 02:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC7631D372;
	Fri, 29 May 2026 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qe1fJfOw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72672282F1C
	for <cgroups@vger.kernel.org>; Fri, 29 May 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780021298; cv=none; b=cQEHwPtHpHewsxohg6MtLz4YZ97Kb59IN9EHTm7lY7DN5BptOFBE8FFNo6xjj2BZ7bSdWCO9Iq5wcFCgLmJ7wKDAhN/pMO+eyhOLm1UIV6iPPYKGQuAA0I7iBBM2yQgl1+WmTrlS9bDAVx6XhCEdGJImc0Ej0+g1gvOfpbtnEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780021298; c=relaxed/simple;
	bh=EyQGvr2J6GXD5/IJXt+tAGdKHuOR2P3OEi9dy2YjAe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHihHqggl3KsJFhLaV9hDF2/Dx5Iz36ZZ+lILNNEZ6ciD4qd2ykkzT63ClqJ44WAfAc1uTLFDqQjQ3SSK2VCEoRzuUBRSpJh/eK4YFzM0ihuopULQM688QurABd2+pbzFtMaZ8OTx/KMoHCG8VSUX9P3Mr19xtM9B86co/EtxK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qe1fJfOw; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7954e78e-1146-4141-b39d-60b02f3efde3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780021294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zoKitNsl9nVOLxqk+A4i5syRWewX+PeHUE5Up6g+Too=;
	b=qe1fJfOwfaAtbUS538mtqbFis1RX5LjAdBAQEI3Eccx7Oqr29whk0XJxfOWYxhdYbDEw/K
	VnguaSns1J0xUUNf5Sg01PqZrahuTCWIofWCshRRnZhSIZdZjTzxpCizjf8/g9Thn6MRal
	XMX87CQKd1art7gPAcN1pWnPa2n64Rs=
Date: Fri, 29 May 2026 10:21:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH-next v3 4/5] cgroup/cpuset: Move
 mpol_rebind_mm/cpuset_migrate_mm() calls inside cpuset_attach_task()
To: Waiman Long <longman@redhat.com>, Chen Ridong
 <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Tomlin <atomlin@atomlin.com>
References: <20260527153800.1557449-1-longman@redhat.com>
 <20260527153800.1557449-5-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guopeng Zhang <guopeng.zhang@linux.dev>
In-Reply-To: <20260527153800.1557449-5-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16411-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 55D1F5FC56F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



在 2026/5/27 23:37, Waiman Long 写道:
> The cpuset_attach_task() was introduced in commit 42a11bf5c543
> ("cgroup/cpuset: Make cpuset_fork() handle CLONE_INTO_CGROUP properly")
> to enable the CLONE_INTO_CGROUP flag of clone(2) to behave more like
> moving a task from one cpuset into another one. That commits didn't
> move the mpol_rebind_mm() and cpuset_migrate_mm() calls for group leader
> into cpuset_attach_task().
> 
> When the CLONE_INTO_CGROUP flag is used without CLONE_THREAD, the new
> task is its own group leader. So it is still not equivalent to moving
> task between cpusets in this case. Make CLONE_INTO_CGROUP behaves
> more close to cpuset_attach() by moving the mpol_rebind_mm() and
> cpuset_migrate_mm() calls inside cpuset_attach_task(). As a result,
> cpuset_attach_old_cs, attach_cpus_updated and attach_mems_updated will
> also need to be updated in cpuset_fork().
> 
> Besides, the original code use cpuset_attach_nodemask_to for
> both nodemask returned by guarantee_online_mems() used only by
> cpuset_change_task_nodemask() and cs->effective_mems in all other cases.
> Such dual use is now impractical by merging the two task iteration loops
> into one. So keep cpuset_attach_nodemask_to for the nodemask returned
> by guarantee_online_mems() and reference cs->effective_mems directly
> in all the other cases.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 90 ++++++++++++++++++++++--------------------
>  1 file changed, 47 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index b233a71f9b7c..7100575927f6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3149,9 +3149,12 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>   */
>  static cpumask_var_t cpus_attach;
>  static nodemask_t cpuset_attach_nodemask_to;
> +static bool queue_task_work;
...
> @@ -3686,7 +3685,12 @@ static void cpuset_fork(struct task_struct *task)
>  	/* CLONE_INTO_CGROUP */
>  	mutex_lock(&cpuset_mutex);
>  	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
> +	/* Assume CPUs and memory nodes are updated */
> +	attach_cpus_updated = attach_mems_updated = true;
> +	cpuset_attach_old_cs = oldcs;
> +	oldcs->old_mems_allowed = oldcs->effective_mems;
>  	cpuset_attach_task(cs, task);
> +	attach_cpus_updated = attach_mems_updated = false;
>  
>  	dec_attach_in_progress_locked(cs);
>  	mutex_unlock(&cpuset_mutex);
Just a minor nit while running checkpatch --strict on this patch:

checkpatch reports:

CHECK: multiple assignments should be avoided

Perhaps the multiple assignments can be split to keep the patch
checkpatch-clean?

attach_cpus_updated = true;
attach_mems_updated = true;

and later:

attach_cpus_updated = false;
attach_mems_updated = false;

Just a style nit.

Best,
Guopeng

