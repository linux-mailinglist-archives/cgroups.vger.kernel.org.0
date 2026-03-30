Return-Path: <cgroups+bounces-15112-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HP7MiHAymk//wUAu9opvQ
	(envelope-from <cgroups+bounces-15112-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 20:25:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 752E135FBD1
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 20:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B47063016AFB
	for <lists+cgroups@lfdr.de>; Mon, 30 Mar 2026 18:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAADF3DDDB0;
	Mon, 30 Mar 2026 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSBBGQvk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD573793BC;
	Mon, 30 Mar 2026 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895134; cv=none; b=Lwe1Hjl0xeSQIQ7v5iRlruv9YEwNAJ8cZwYseTEROHgu37+tdo01WuCyR0jCurVIFNlStvmlBtfJWRiMR7O+a8gVZYzkzKvon4sQxmb8sR51WN1X2CrmfpVLypUaGk5ZyAdxvA22W2PKgp+I9M2yVQ4UVsVQ7DjhgAkyrDUEKSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895134; c=relaxed/simple;
	bh=UwS46kvZz7zAALyqpuT/TLsQuPGbk3L1gG9aFrfpz7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3z7hfSmkIqUeZ+qijaGIDLin6KDVyABvS2n1NIcBa9mkF38cyYhj/kY9meXuTmdbact8SIg/fkAzX9MYNbqbeDQ6lyRAQaI49wHM567A6E1YJNkMNr1stEF57yVsLwMLGlntYialAYgdHAK3z+pn3P0ZLa01hDYnuwyHiPByhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSBBGQvk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E144C4CEF7;
	Mon, 30 Mar 2026 18:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774895134;
	bh=UwS46kvZz7zAALyqpuT/TLsQuPGbk3L1gG9aFrfpz7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSBBGQvkpdUBTrvMULUFuZdS54JeFCXif1WB5SXiyQTNQbanzeNFgm0OsPqSZ/Fwv
	 X0k+iCL4rYeYDfTbc60Bj2rzCRuqQDs8IbskZDlCj6v0wuq7d7UcfRp8eQGYTNtZUt
	 CU8fX/PpQ0Uvks+RjT+FnZGA2DMK7hwyfkZpzYjl1HLIZS2bg5KkGcji6p1x1kdFxB
	 xIPo8eg/h+s9r/Dw5ckgc1jEx7PwskA+Sp5Pc8wiuLlniIc6Zhde8+Jud6E0PmtXuS
	 aH5vDvb71AsX+U7CBAuND38myI6wSkcddp+IKe2HeXyPYFUKa9RX6noUJa1cmZr/1Y
	 TzAZ+VsVGeCxg==
Date: Mon, 30 Mar 2026 08:25:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Chen Ridong <chenridong@huawei.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] cgroup/cpuset: Improve check for v1 task
 migration out of empty cpuset
Message-ID: <acrAHQ5EOecgZVOg@slm.duckdns.org>
References: <20260329173958.2634925-1-longman@redhat.com>
 <20260329173958.2634925-4-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329173958.2634925-4-longman@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15112-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 752E135FBD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 01:39:58PM -0400, Waiman Long wrote:
> With the "cpuset_v2_mode" mount option, cpuset v1 will emulate v2 in
> how it handles the management of CPUs. As a result, the effective_cpus
> can differ from cpus_allowed and an empty cpus_allowed will cause
> effective_cpus to inherit the value from its parent. Therefore task
> migration out of a cpuset with empty "cpuset.cpus" should no longer
> be needed in this case.
> 
> The current code doesn't handle this particular case. Update the code to
> correctly detect that the cpuset has really no CPUs left by checking
> effective_cpus instead of cpus_allowed.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset-v1.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index 0c818edd0a1d..9855de37d011 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -261,7 +261,7 @@ static void remove_tasks_in_empty_cpuset(struct cpuset *cs)
>  	 * has online cpus, so can't be empty).
>  	 */
>  	parent = parent_cs(cs);
> -	while (cpumask_empty(parent->cpus_allowed) ||
> +	while (cpumask_empty(parent->effective_cpus) ||
>  			nodes_empty(parent->mems_allowed))
>  		parent = parent_cs(parent);
>  
> @@ -297,14 +297,16 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>  
>  	/*
>  	 * Don't call cpuset_update_tasks_cpumask() if the cpuset becomes empty,
> -	 * as the tasks will be migrated to an ancestor.
> +	 * as the tasks will be migrated to an ancestor. If cpuset_v2_mode mount
> +	 * option is used, effective_cpus can differ from cpus_allowed. So
> +	 * checking effective_cpus is more accurate for determining emptiness.
>  	 */
> -	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
> +	if (cpus_updated && !cpumask_empty(cs->effective_cpus))
>  		cpuset_update_tasks_cpumask(cs, new_cpus);
>  	if (mems_updated && !nodes_empty(cs->mems_allowed))
>  		cpuset_update_tasks_nodemask(cs);
>  
> -	is_empty = cpumask_empty(cs->cpus_allowed) ||
> +	is_empty = cpumask_empty(cs->effective_cpus) ||
>  		   nodes_empty(cs->mems_allowed);

Are these meaningful changes? cpuset1_hotplug_update_tasks() is called by
cpuset_hotplug_update_tasks() when !is_in_v2_mode(). As is_in_v2_mode() says
yes on cpuset_v2_mode, the above change doesn't really change anything, no?

Thanks.

-- 
tejun

