Return-Path: <cgroups+bounces-16068-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHMlCA8gDGphWwUAu9opvQ
	(envelope-from <cgroups+bounces-16068-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 10:32:15 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97857A1F0
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2953030516C8
	for <lists+cgroups@lfdr.de>; Tue, 19 May 2026 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14E83E0C5A;
	Tue, 19 May 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZvZnhg/X"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4573E0C61
	for <cgroups@vger.kernel.org>; Tue, 19 May 2026 08:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178768; cv=none; b=dTlC4KWR3dPGC+6kn4ByXL2Cx9xOQ2Uk3djd8guUAkhOk/zpdPI8fg9iU/D+HdGdI8G8TL9IhEcSlOefcsc6ggT18gdBZe0p/ZfAHgmHfmZ0qmLFTDRiDwGJgEw2MKZv18EplsQ5WRIwK8NK38ov6DfMZf9aKJJTxu0PayncOGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178768; c=relaxed/simple;
	bh=R1vcqeeG7/hQHJLv1r+bmnaPhnzRRIjvTbPqwHc4SR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1UtHQKJWMsswOygTliwWXJyAyjuO3+eMbnd7z8dvQxMPKOu81rTBTnq6HF6gAagwvBNkLSLRRA5iF3cv0oTTm6ivNhijByI1bw/qNJs1MzD3YLhnH2C40HWOYMFIDphU7K9O7quPZE+HTtBMehWTaakB02Yrit0qVNMQEW6MKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZvZnhg/X; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <31f6d872-f213-41de-92d4-ffef3c2500df@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779178754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfF4+CHBJFTM7KSWTXE/6gxfxKsnNbc8ryPp1TwkXQ8=;
	b=ZvZnhg/XMgtSI66DjjZsXP8W9Qu2giyWy2FLpZWcBWTUUVg62eDm1Y7eSDoPUOIdGjrqHT
	eryO1W38q3Go4LbB8YdLTOEy6JciqKZui3U+ovbDGwszmJbpKzAgfA20ztd0mwtrvprzRC
	1yKc4L2HnMORzWinWGlD/jq7qEowoOE=
Date: Tue, 19 May 2026 16:19:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH cgroup/for-next v2 1/5] cgroup/cpuset: Add a
 cpuset_reserve_dl_bw() helper
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
 <20260516042448.698216-2-longman@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260516042448.698216-2-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16068-lists,cgroups=lfdr.de];
	R_DKIM_ALLOW(0.00)[linux.dev:s=key1];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,huaweicloud.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED97857A1F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/5/16 12:24, Waiman Long wrote:
> Extract the DL bandwidth allocation code in cpuset_attach() to a new
> cpuset_reserve_dl_bw() helper to simplify code.
> 
> No functional change is expected.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 53 ++++++++++++++++++++++++------------------
>   1 file changed, 30 insertions(+), 23 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index bcefc9f50ac5..7cae47829013 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2980,6 +2980,25 @@ static int cpuset_can_attach_check(struct cpuset *cs)
>   	return 0;
>   }
>   
> +static int cpuset_reserve_dl_bw(struct cpuset *cs)
> +{
> +	int cpu, ret;
> +
> +	if (!cs->sum_migrate_dl_bw)
> +		return 0;
> +
> +	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> +	if (unlikely(cpu >= nr_cpu_ids))
> +		return -EINVAL;
> +
> +	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> +	if (ret)
> +		return ret;
> +
> +	cs->dl_bw_cpu = cpu;
> +	return 0;
> +}
> +
>   static void reset_migrate_dl_data(struct cpuset *cs)
>   {
>   	cs->nr_migrate_dl_tasks = 0;
> @@ -2994,7 +3013,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   	struct cpuset *cs, *oldcs;
>   	struct task_struct *task;
>   	bool setsched_check;
> -	int cpu, ret;
> +	int ret;
>   
>   	/* used later by cpuset_attach() */
>   	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
> @@ -3050,31 +3069,19 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
>   		}
>   	}
>   
> -	if (!cs->sum_migrate_dl_bw)
> -		goto out_success;
> -
> -	cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
> -	if (unlikely(cpu >= nr_cpu_ids)) {
> -		ret = -EINVAL;
> -		goto out_unlock;
> -	}
> -
> -	ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
> -	if (ret)
> -		goto out_unlock;
> -
> -	cs->dl_bw_cpu = cpu;
> -
> -out_success:
> -	/*
> -	 * Mark attach is in progress.  This makes validate_change() fail
> -	 * changes which zero cpus/mems_allowed.
> -	 */
> -	cs->attach_in_progress++;
> +	ret = cpuset_reserve_dl_bw(cs);
>   
>   out_unlock:
> -	if (ret)
> +	if (ret) {
>   		reset_migrate_dl_data(cs);
> +	} else {
> +		/*
> +		 * Mark attach is in progress.  This makes validate_change() fail
> +		 * changes which zero cpus/mems_allowed.
> +		 */
> +		cs->attach_in_progress++;
> +	}
> +
>   	mutex_unlock(&cpuset_mutex);
>   	return ret;
>   }

LGTM.

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong

