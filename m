Return-Path: <cgroups+bounces-16250-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDDBKllUFGp2MgcAu9opvQ
	(envelope-from <cgroups+bounces-16250-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 15:53:29 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3915CB604
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 15:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFFAF3016818
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 13:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641DA3845B3;
	Mon, 25 May 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZofNUtFm"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388881CFBA;
	Mon, 25 May 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779717206; cv=none; b=eRKvU0iasMd2rvVg+paxaq46qOJ3GsmJ1P094N57gODeCZzB08vE5UTMKDgJgs8c/AuUof64GBYEM3W/Rzp61ysj1qw68YswzTbU3jex3YuWDWRVN4OF0yWd8Nz1t4xs3R6fl6bx+Hs+zvvIE6aRiRWWSR992YDZSXJUYwWQMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779717206; c=relaxed/simple;
	bh=bjoUdqXw5ZZA2qoB+sLV+XrCCuZWsgMzhcFViEhm+EY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A2DhANjhc9mCYIXyzJ/vg3vtsHwrhdXnVIGTKTpx6Zrdmlfn0BXB1SDS4ci2UW8aJqoXO7QCaJYBilmzcbzlo6LD/tXIgJHOdW5QtTVNDYdI26oOzqvRBSmzKwBDLKK6FH328zOmFZhoC6eKKiSFAdyy4Kxpoq6shXtrJAuyCYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZofNUtFm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24481F00A3A;
	Mon, 25 May 2026 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779717204;
	bh=0qi46Rt48Kr9CUNAuhE8+AogLbpV9sC1dRJVHiMwYPc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZofNUtFm5U/XV4i9kVPHrrDIXF9313RyDI8LJtiwZSy9/VhGCaigGL6511xRPjTtS
	 VbsCFniamG+JHdoMqb3VHy0QF9svac365gfi3bRU804rnpYgUIsCe1aksCmXhsp55X
	 2ArU1lADUxPY8Ysx16tJ0PzesohFt8ilBMjWcKzs0rHbwZjfHSAtzs5gajQ48yQ9P1
	 6f836RPtX0W1yiiLlo57ydsr01vaaRXFZHLiFY4+2OyosenF5uFoOswutUbPxqw+vT
	 wDq0yb4p90aVyNabCjOeX0ezVG3PI0np44ocTc6tGPJvCdX+p5El8uP89EkNlzyzcS
	 wkWPXq4ZXBzGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0ECC380AA60;
	Mon, 25 May 2026 13:53:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] cgroup/rstat: validate cpu before css_rstat_cpu()
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177971721165.2579362.15091579325825161865.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 13:53:31 +0000
References: <20260516070849.106141-1-a0yami@mailbox.org>
In-Reply-To: <20260516070849.106141-1-a0yami@mailbox.org>
To: Qing Ming <a0yami@mailbox.org>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, hannes@cmpxchg.org,
 mkoutny@suse.com, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, akpm@linux-foundation.org,
 ast@kernel.org, haoluo@google.com, yosry@kernel.org, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16250-lists,cgroups=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F3915CB604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to bpf/bpf.git (master)
by Tejun Heo <tj@kernel.org>:

On Sat, 16 May 2026 15:08:49 +0800 you wrote:
> css_rstat_updated() is exposed as a BPF kfunc and accepts a
> caller-provided cpu argument. The function uses cpu for per-cpu rstat
> lookups without checking whether it refers to a valid possible CPU.
> 
> A BPF iter/cgroup program with CAP_BPF and CAP_PERFMON can pass an
> invalid cpu value. On an unfixed UBSCAN_BOUNDS test kernel, cpu ==
> 0x7fffffff triggers:
> 
> [...]

Here is the summary with links:
  - [v2] cgroup/rstat: validate cpu before css_rstat_cpu() access
    https://git.kernel.org/bpf/bpf/c/8817005efbdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



