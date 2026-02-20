Return-Path: <cgroups+bounces-14054-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM6tLMp6mGnlJAMAu9opvQ
	(envelope-from <cgroups+bounces-14054-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 16:16:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AB0168D0E
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F5533036612
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 15:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D682475F7;
	Fri, 20 Feb 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngyze6Dx"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3521F8AC5;
	Fri, 20 Feb 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771600575; cv=none; b=bNfA3lnGpkZ1MaFdgY5JWkbM5OZI9TuZfCH9gZOdkreytpYb73C1tKCvYTZS+7tn7cnEu4DvAOkQcCE9ly+Is3y4kw+PW2Ny70J9qBWziD4ALkn8PRdg578rkW14kvogCr4Un90l99/WYRBAW4OkNxOEegeA3+egbSPi4HhqP5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771600575; c=relaxed/simple;
	bh=oJZ5mIZ3ij+o3W18OBkwZ5UnpiFkSZVFTsT01xsl0to=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYkGS2xdlCfKKUO6KKLn4YKvoTsMSixQ3OV54s809H3QI3hHgzpimkOiwMKKm9T0V8VyBtW4wJvIKo/FkoZe/uSpjfVjfTi/H6zdBXygR6vMOiHvDfSdkDb8bnPOjstlgsgwfrr9OM9DoNQ8ZZSOgdfHzBBDoCeem+M8cXmtoZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngyze6Dx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73915C116C6;
	Fri, 20 Feb 2026 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771600574;
	bh=oJZ5mIZ3ij+o3W18OBkwZ5UnpiFkSZVFTsT01xsl0to=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ngyze6Dxy3vg+Zm+5uszt9yY4cI2qmN5WCKD9pctPfF3+S4X9NW/CtMsr64KtJZvC
	 zyuiWJeFZ8mz94+2BYnvUFNEklpAp1hmoM/4HVo2Q/LqwJCqQZBzTkrr1JvgEeH7M/
	 GqjFk0pGtIJNy0yXPFpwWXRSePQG12JwLIB3SktQFnui0cGxVc9eRkjKaEvTvI24SW
	 nIcvmGS/X8d8295PxHBgzArP30Nry01Y/krJMKjDF3MDaBVByRw9mqdCUrpj4xUqtk
	 XY8zBLfF1pHNZFJJTP1hEviYPhNB/RgMkPUIZmhr6zKIAxDJiS/sL2YLmzZ3H0M0G7
	 g9+SHAl6MDf5w==
Date: Fri, 20 Feb 2026 05:16:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>
Subject: Re: [PATCH 2/4] cgroup: add bpf hook for attach
Message-ID: <aZh6vebjDcrccqNP@slm.duckdns.org>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-work-bpf-namespace-v1-2-866207db7b83@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14054-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10AB0168D0E
X-Rspamd-Action: no action

Hello,

On Fri, Feb 20, 2026 at 01:38:30AM +0100, Christian Brauner wrote:
> Add a hook to manage attaching tasks to cgroup. I'm in the process of
> adding various "universal truth" bpf programs to systemd that will make
> use of this.
> 
> This has been a long-standing request (cf. [1] and [2]). It will allow us to
> enforce cgroup migrations and ensure that services can never escape their
> cgroups. This is just one of many use-cases.

From cgroup POV, this looks fine to me but I'm curious whether something
dumber would also work. With CLONE_INTO_CGROUP, cgroup migration isn't
necessary at all. Would something dumber like a mount option disabling
cgroup migrations completely work too or would that be too restrictive?

Thanks.

-- 
tejun

