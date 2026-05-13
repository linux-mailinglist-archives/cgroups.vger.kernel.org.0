Return-Path: <cgroups+bounces-15899-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICyBIwCoBGogMQIAu9opvQ
	(envelope-from <cgroups+bounces-15899-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 18:34:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D83537218
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 18:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2204F3040CB7
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566C040F8C5;
	Wed, 13 May 2026 16:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rQWbM2eM"
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E2031716B;
	Wed, 13 May 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689353; cv=none; b=Ir7dgDm+HpdGvVdfo/JpFtVSKGY6mSchNtSHoZxaKtTG5as3EU9VWwn7eOPC4IxraeunSCdPNV0V8WTHqHAAOdNKdl9nfJZRfMQWCb/EfxIuqy7YPLAxLW0Yqu11F+PAm+u36TbVqAscHiWjVTeIxd3gKyIt5FGQe1aECgMyCYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689353; c=relaxed/simple;
	bh=Plq95R/wAEP8nhKnZG1BjP5GE/BC+nUVBIIvhmbio6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+ZMeFt8KDsnXIXGtc1R2y+LqjciqFZx9eWni6ke7TidyQA+ZmiUwpIpkD2LIK0u37W+JABzdHQCoZXjb2FBt03g8lolkpQIp7gYNXPb1/fSn9owG8D4bky0jAEb0M0/bkCYF9aiZSsRq9v15htawqQu99EgM8gfJ3tGYyxa/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rQWbM2eM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BBAE1595;
	Wed, 13 May 2026 09:22:23 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF6563F7B4;
	Wed, 13 May 2026 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778689348; bh=Plq95R/wAEP8nhKnZG1BjP5GE/BC+nUVBIIvhmbio6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rQWbM2eMeI4iv8LWtmhsQ1sR/42LGPNG29QFWdtqHzlQvexunAoiEdz069c1N9fxk
	 etvpXgU3Jli6BRuFkX6M2NiI+dDYm4X35u4dbwyJX1XsTh80cUcU7pBevfMucKeHfz
	 PwGM2mteJDFjYBm1i7nPwiynIEnv1zbuEo7/Ff6s=
Message-ID: <ddc8040f-2186-4c72-a69e-26b388cb7249@arm.com>
Date: Wed, 13 May 2026 18:22:25 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuset: Fix multi-source deadline task accounting and
 bandwidth bypass
To: Aaron Tomlin <atomlin@atomlin.com>, longman@redhat.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: chenridong@huaweicloud.com, neelx@suse.com, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260512010341.101419-1-atomlin@atomlin.com>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20260512010341.101419-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D8D83537218
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15899-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dietmar.eggemann@arm.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim]
X-Rspamd-Action: no action

On 12.05.26 03:03, Aaron Tomlin wrote:
> During a batch migration where threads in a taskset originate from
> multiple source cpusets (e.g., via cgroup.procs), cpuset_can_attach()
> and cpuset_attach() currently evaluate the source cpuset exactly once
> by caching the first task's oldcs.
> 
> This creates two distinct critical flaws for SCHED_DEADLINE tasks:
> 
>     1.  oldcs->nr_deadline_tasks is decremented solely on the first
>         source cpuset. If tasks originated from other cpusets, their
>         counts are permanently leaked, and the first cpuset permanently
>         underflows.
> 
>     2.  cpumask_intersects() is evaluated strictly against the first
>         task's source cpuset. This allows tasks originating from
>         entirely isolated root domains to silently bypass the
>         dl_bw_alloc() admission control.
> 
> This patch refactors the deadline accounting to evaluate task_cs(task)
> on a per-task basis during the cgroup_taskset_for_each() loops. To
> achieve accurate accounting before the core cgroup migration actually
> executes, the permanent nr_deadline_tasks increments/decrements are
> shifted into cpuset_can_attach(). If the migration aborts, the counts
> are gracefully reverted via an internal rollback loop or the
> cpuset_cancel_attach() callback.

Is there a testcase to provoke this issue in the current code?

I tried to move a process with 6 DL tasks from one cpuset to another by:

echo $PID > /sys/fs/cgroup/B/cgroup.procs

but in this case old_cs is the same for all these tasks.

[ 1991.852034] cgroup_migrate() (7) leader=[dl_batch_cgroup 823] threadgroup=1
[ 1991.852068] cgroup_migrate_execute() tset->nr_tasks=7
[ 1991.852238] cpuset_can_attach() (4) [dl_batch_cgroup 832] nr_migrate_dl_tasks=1 sum_migrate_dl_bw=104857 old_cs=ffff0000c4955200
[ 1991.852246] cpuset_can_attach() (4) [dl_batch_cgroup 833] nr_migrate_dl_tasks=2 sum_migrate_dl_bw=209714 old_cs=ffff0000c4955200
[ 1991.852248] cpuset_can_attach() (4) [dl_batch_cgroup 834] nr_migrate_dl_tasks=3 sum_migrate_dl_bw=314571 old_cs=ffff0000c4955200
[ 1991.852249] cpuset_can_attach() (4) [dl_batch_cgroup 835] nr_migrate_dl_tasks=4 sum_migrate_dl_bw=419428 old_cs=ffff0000c4955200
[ 1991.852249] cpuset_can_attach() (4) [dl_batch_cgroup 836] nr_migrate_dl_tasks=5 sum_migrate_dl_bw=524285 old_cs=ffff0000c4955200
[ 1991.852250] cpuset_can_attach() (4) [dl_batch_cgroup 837] nr_migrate_dl_tasks=6 sum_migrate_dl_bw=629142 old_cs=ffff0000c4955200
[ 1991.852328] cpuset_attach() (5) cs=ffff0000c1e9fc00 oldcs=ffff0000c4955200 cs->nr_deadline_tasks=6 oldcs->nr_deadline_tasks=6 cs->nr_migrate_dl_tasks=6

dl_batch_cgroup     823     823  19      -   0 TS
dl_batch_cgroup     823     832 140      0   - DLN
dl_batch_cgroup     823     833 140      0   - DLN
dl_batch_cgroup     823     834 140      0   - DLN
dl_batch_cgroup     823     835 140      0   - DLN
dl_batch_cgroup     823     836 140      0   - DLN
dl_batch_cgroup     823     837 140      0   - DLN

[...]

