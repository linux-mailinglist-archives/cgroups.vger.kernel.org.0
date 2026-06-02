Return-Path: <cgroups+bounces-16560-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GA3oBoGjHmq3IwAAu9opvQ
	(envelope-from <cgroups+bounces-16560-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 11:33:53 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC0862BA17
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 11:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1E28304E250
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94983C73DD;
	Tue,  2 Jun 2026 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GfOarAxj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090C428A72F
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 09:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392475; cv=none; b=hXwubI9VxudgfnOFArDPZO+r/EIOaJ60sJAl461t0vkawJ6JqiDVmSLaaZSk42ePtKw465kIM7WG0vyCUvTssK6BAVLVNIe8/hiJy4tNPajxBWkISgpIChcGEavOGIpAw2pI6po/6Rs1ugqQTCDT2CZ7GalnNO/njaUSCXUyFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392475; c=relaxed/simple;
	bh=o0dInHLxDrOP/PQSoOYN9Tnyap42b+JbKTG1Rj7NRAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qc5Mkcvd6NSIaYQy6dnSnxUGgq9Ergf0PxHjSPWW0JowF8UK9Cb2AmLXUBdHlEO0yyCp4BwARK1Ri/sD3trKVGaU3FV3DYNUPGKYiEXoiECSfs80BeUcNaWBFjdbHlAImIZFOHUFVWei58R84nZCoUdeJ/vBArVahr0h2MbmEq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GfOarAxj; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7775e634-7667-4184-9d5a-cd17162ef402@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780392471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNzDqkRptSQL7P61FVRdJ+sZX3qCFMf52BBPiR1VjPs=;
	b=GfOarAxj8b8ArNpP13ZDurfiNRdc21fweiidAYk1JY6CRu1LEy2+F7zF+yn0dMyz5shMGW
	fYWJ6aBU4p670Jjdu+Y/hY8LDpNCOHjXI/Y3iL7py8WYUDQi9AjefNRIp7Lr7Hguq/wUc8
	oXEoXEFCryTR9FrUUu4/2zIH8tkVMPw=
Date: Tue, 2 Jun 2026 17:27:10 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] cgroup/cpuset: Free sched domains on rebuild guard
 failure
To: Guopeng Zhang <guopeng.zhang@linux.dev>, Waiman Long
 <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guopeng Zhang <zhangguopeng@kylinos.cn>
References: <20260528093742.1792456-1-guopeng.zhang@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ridong Chen <ridong.chen@linux.dev>
In-Reply-To: <20260528093742.1792456-1-guopeng.zhang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 7CC0862BA17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16560-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ridong.chen@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action



On 2026/5/28 17:37, Guopeng Zhang wrote:
> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
> 
> generate_sched_domains() returns sched-domain masks and optional
> attributes that are normally handed to partition_sched_domains(), which
> takes ownership of them.
> 
> rebuild_sched_domains_locked() has a WARN guard after
> generate_sched_domains() and before partition_sched_domains() to avoid
> passing offline CPUs into the scheduler domain rebuild path. If that
> guard fires, the function currently returns directly without freeing
> the generated doms and attr.
> 
> Free the generated sched-domain masks and attributes before returning
> from the guard failure path.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  kernel/cgroup/cpuset.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 51327333980a..c5fdebc205d8 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1004,8 +1004,11 @@ void rebuild_sched_domains_locked(void)
>  	* prevent the panic.
>  	*/
>  	for (i = 0; doms && i < ndoms; i++) {
> -		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
> +		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask))) {
> +			free_sched_domains(doms, ndoms);
> +			kfree(attr);
>  			return;
> +		}
>  	}
>  
>  	/* Have scheduler rebuild the domains */

Thank you. This helps prevent a memory leak in this abnormal scenario. I
should have included it when I originally added this check.

-- 
Best regards,
Ridong

