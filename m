Return-Path: <cgroups+bounces-16150-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMpLEpndDmoVCwYAu9opvQ
	(envelope-from <cgroups+bounces-16150-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 12:25:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1FE5A3414
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 12:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 467BA321B56A
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2026 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890D37F74B;
	Thu, 21 May 2026 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="WO2Ax2Bn"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46E37F8DD;
	Thu, 21 May 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779357265; cv=none; b=VB+xPNfTlowAxvZxIJ0OmlSAp2J0cskMXLiaSGs7aZ0/ReDE0YiGjnBnD15C2DKHtHRBBUOIBzyoTiE+VZAEO8SSm7rQO9aWSzIa81N+DQwcw1ud29POxyJOVM2alWX0XOEu6oW/LUY6bacwQi7Vgd38w9lSBrxOKKZ8Xxndq2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779357265; c=relaxed/simple;
	bh=4isyDSU2yKa1nmv4Pvr9FM416ghQXAnaNHpmgxxin50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gkrV2y3HrfrOPu0vHFSynx7LK5nQWRwYEIcDLfFTbwSKoEyVbOwqAlx9EBntKo2AlxiGQStjpev2AMVg1Lh13s5BLFfzPGp/MzFz/E/aOT+u4MfqoNRw9mQI4M72TP1BDjTaOePfiPAKcMxNx3aM1LJxl3tbhIgI1krjYdwN5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=WO2Ax2Bn; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1779356756;
	bh=4isyDSU2yKa1nmv4Pvr9FM416ghQXAnaNHpmgxxin50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WO2Ax2BnzpAIfdf9+avS8EvsulN1b3fhEzPLipJmppmnT95ZDOg4H96OfW4MBtbBs
	 yk5Pr9Q1HF+nvyQSqDZOagUZEqEbVI/Z3mXH1Fvd2TTfY5F5V8K59eu9ENhDjUsS3g
	 ZuhyuRNVSOfqmzrVUyd7eaFrJn8xKoTl1VlVh9ARPjYMhJn5q1yn+riNXMJPxS8UlY
	 SoKNjXivMxxFNz73HjZVT3nkUWR/x4xzut1Si9Edv3yD8PKy34vc5dR7yET19w1dKV
	 57Uojx9JgT8Pj6tfUlFoUwmTLfkkG21yk2D+765J4RwL+TCGNNpDhBSZjsBUWzwfM5
	 toF1Dk77lk4Tg==
Message-ID: <63878874-39d2-43d5-9fc3-68addf9ebbdd@lankhorst.se>
Date: Thu, 21 May 2026 11:45:50 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and
 throttling
To: Qiliang Yuan <realwujing@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16150-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,gmx.de,cmpxchg.org,suse.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email]
X-Rspamd-Queue-Id: 9E1FE5A3414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Qiliang,

Den 2026-05-20 kl. 08:07, skrev Qiliang Yuan:
> Introduce the "high" soft limit for the dmem cgroup v2 controller.
> When a cgroup's device memory usage exceeds its high limit, tasks
> belonging to that cgroup are throttled by being forced into a sleep
> before returning to user space, instead of being failed outright
> as with the "max" limit.
> 
> Key changes:
> - Add high counter configuration to dmem_cgroup_pool.
> - Add over-high check in the try_charge path and set TIF_NOTIFY_RESUME.
> - Inject the dmem throttling handler into resume_user_mode_work.
> - Implement the handler to perform a 100ms interruptible sleep for
>   over-limit tasks.
> 
> This mechanism provides smoother over-subscription support for device
> memory resources.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
> ---
> This series introduces the "high" soft limit and associated task
> throttling mechanism to the dmem cgroup v2 controller.
> 
> The device memory (VRAM) management currently only supports hard limits
> (max), which leads to immediate allocation failures when reached. This
> can be disruptive for GPU-bound AI workloads. By introducing a soft
> limit, we allow cgroups to exceed their quota temporarily while
> applying backpressure via task throttling before the process returns
> to user space.
> 
> The mechanism is inspired by the memory cgroup's high limit:
> - When usage > high, the task is marked with TIF_NOTIFY_RESUME.
> - Upon returning to user space, it triggers a 100ms sleep.
> - This provides a smoother over-subscription model for GPU resources.
> 
> Qiliang Yuan (1):
> 
> cgroup/dmem: implement dmem.high soft limit and throttling
> ---
> To: Maarten Lankhorst <dev@lankhorst.se>
> To: Maxime Ripard <mripard@kernel.org>
> To: Natalie Vock <natalie.vock@gmx.de>
> To: Tejun Heo <tj@kernel.org>
> To: Johannes Weiner <hannes@cmpxchg.org>
> To: Michal Koutný <mkoutny@suse.com>
> Cc: cgroups@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> ---

I think the concept of allowing userspace to throttle on high
is interesting.

It's the approach I'm more worried about. I believe that it's
better if we punish exceeding their high limit by preferentially
evicting those.

It would make eviction run in 3 passes on the affected cgroup tree:
- Round 1: Clients above their 'high' limit
- Round 2: Clients above their 'low/min' limits
- Round 3: Clients at or below their 'low' limit

And the same client's cgroup, below 'min' limit as well.

I'm open for other ideas as well. Perhaps a flag that would allow
allocation or binding to an address space to fail if it would need
to evict, or a notification sent to the affected client that they
went over high.

Have you tried any other approaches before this one?

Kind regards,
~Maarten Lankhorst

