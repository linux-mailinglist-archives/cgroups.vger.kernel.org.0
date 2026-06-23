Return-Path: <cgroups+bounces-17165-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wGVKFCbeOWp9yQcAu9opvQ
	(envelope-from <cgroups+bounces-17165-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:15:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 495556B319E
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:15:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=gdC9aSjh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17165-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17165-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B73CD302C5E4
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1467A2F745C;
	Tue, 23 Jun 2026 01:15:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E6321CA0D
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 01:15:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782177314; cv=none; b=NKaBTj/jhvE4lubGzYrF8oyhfhp+b1us8BnFibW9fG9VHTJ6wytUCC3lIgHZFOx5q9UHELG2+8OM0RQw3gOzkuRj32MvXwLyZFMl3QWUUuOqZCCTeF5nSMCUMDhdaeY9Co0bPT4FDlzcf//8Mf6qPKmpnJ48fG3uWJ9w6Xo34Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782177314; c=relaxed/simple;
	bh=CXlJ+IGAMu+WnGGoTqqoxMmqr9c6F6sSbek2igt/B6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiaowKGwITqjAKb8N46XkRvGSjUqdrHkVLyXLL23iSaPBr3ljVSJ4HhGfkLX/I2PTdQ6R7qcs2mGZGv7pb1OQHNuNE37FhKYdcunGC+156EI+n4TpiBxBAAhRCuC5r9Dfx9aymZ9OmMm6PwfDj1XIau3sR+72a7ib4J0pHAuRX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gdC9aSjh; arc=none smtp.client-ip=95.215.58.182
Message-ID: <e24b8145-7a67-4cc0-8ba0-24bd89243c04@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782177308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Xehzt1SVC9gtzjAb+OIQuJbK4C/O+ft3+abYnowKwg=;
	b=gdC9aSjhT98sWW65C9TYwDKrS0CCCEH4A1fyMutR88fuJ3iKvSjy6g9sUSAoNd+ZicS16i
	x85iujJC26C2a0jvFML5EHj4RfTN09hfMvmCsOaAuI0x/tUde2BB+2pH1QElf02gPcGMvn
	hdpDh8ZWpgpJzvEv3cFUtPh1lt/Vlck=
Date: Tue, 23 Jun 2026 09:14:59 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] cgroup/cpuset: Avoid unnecessary cpus & mems update
 in cpuset_hotplug_update_tasks()
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260622224509.1927419-1-longman@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260622224509.1927419-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17165-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:longman@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 495556B319E



On 6/23/2026 6:45 AM, Waiman Long wrote:
> As reported by sashiko [1], cpuset_hotplug_update_tasks() may perform
> unnecessary task iteration and updating of tasks' CPU and node masks
> when mems_allowed and/or cpus_allowed are not set in cpuset v2. It is
> due to the fact that the temporary new_cpus and new_mems masks do not
> inherit parent's effective_cpus/mems when they are empty which is the
> expected behavior for cpuset v2 since commit 4ec22e9c5a90 ("cpuset:
> Enable cpuset controller in default hierarchy").
> 
> Fix that and avoid unnecessay work by adding the empty mask checks and
> inheriting the parent's versions if empty.
> 
> [1] https://sashiko.dev/#/patchset/20260621032816.1806773-1-longman%40redhat.com
> 
> Fixes: 4ec22e9c5a90 ("cpuset: Enable cpuset controller in default hierarchy")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index aff86acea701..bc0207fd6e57 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3925,6 +3925,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
>   	compute_effective_cpumask(&new_cpus, cs, parent);
>   	nodes_and(new_mems, cs->mems_allowed, parent->effective_mems);
>   
> +	if (is_in_v2_mode()) {
> +		/* Inherit parent's effective_cpus/mems if empty */
> +		if (cpumask_empty(&new_cpus))
> +			cpumask_copy(&new_cpus, parent->effective_cpus);
> +		if (nodes_empty(new_mems))
> +			new_mems = parent->effective_mems;
> +	}
> +
>   	if (!tmp || !cs->partition_root_state)
>   		goto update_tasks;
>   

I noticed that compute_effective_cpumask(...) is called in several 
places, so I think the logic should be consolidated into that function.

```
static void compute_effective_cpumask(struct cpumask *new_cpus,
				      struct cpuset *cs, struct cpuset *parent)
{
	cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpus);
	if (cpumask_empty(&new_cpus) && is_in_v2_mode())
		cpumask_copy(&new_cpus, parent->effective_cpus);
}

```

Similarly, for new_mems, should we introduce a dedicated helper like 
compute_effective_nodemask? The same fallback logic is needed in 
update_nodemasks_hier:


```
static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
{
...
		bool has_mems = nodes_and(*new_mems, cp->mems_allowed, 
parent->effective_mems);

		/*
		 * If it becomes empty, inherit the effective mask of the
		 * parent, which is guaranteed to have some MEMs.
		 */
		if (is_in_v2_mode() && !has_mems)
			*new_mems = parent->effective_mems;
...
```

-- 
Best regards
Ridong


