Return-Path: <cgroups+bounces-16123-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKwDNLGFDWo8ygUAu9opvQ
	(envelope-from <cgroups+bounces-16123-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 11:58:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDBD58B35A
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7232303276A
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2026 09:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD23D16EC;
	Wed, 20 May 2026 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlrnIGVf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81AE358363;
	Wed, 20 May 2026 09:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270747; cv=none; b=o36VZxedh2oLpDOr5ZDz6zVjpaRUqNthYEwke2nHt9ljEjdWzdq3WwTHvev/9Ikd9U43ZhzFywoFFCuJwC72uVAYgrSgkuuIn6Gt4mMEICre9AaJbIuAMxNnieGzIAzV/XINrCesg9DKLaKM6C8LTS9QkyNAp/sgRR7mq3YbE2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270747; c=relaxed/simple;
	bh=aFmAH3fj7VGX5PGKdCayjUDXHQ5zgyfD2+jqUXoGRsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W49pjXvw2m8303BvJhqs4bWBHSxhynQBRlYwoV7t8Bi72Do3iwNP8z+DrrZcpDBAnD6OcZ356wT6Hz3gwzRocWyZLnjqftGdfMUUTT9Y30TVUQ+8wG0YVCzWOu2RQWrGE9RTo2xW1ZbX3gBIn6sbANepxZ3tHHC3aQloHnwhid4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlrnIGVf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792091F000E9;
	Wed, 20 May 2026 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779270746;
	bh=SJETYFJkSCdwSSOgdJEmuUJWgEdHp6U1AWVfwQxLLkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HlrnIGVf6XsyMNZ/pPtkBiKeJMERcmBZFAMvEwErzc7/2e9rwW2EZ/YTNAmeIpAs+
	 +y3bziJlpZAlBql2M61qmmo3Q9pJyFFHSfAohmYGwr299Yo6WZP5lXQGoHS+W3on/b
	 gkWpV2sNBl2v5PicyBPWBGU5WAUgXgV7BYYOzv6YhpE2PVoPVFvP92jJ2kPaHrQFL+
	 Cmx7x86DbVP27txLoxmcqX9nngTEs+JwBbkPTxF4VotikOsesmld0FX9O+u+Ok00Dv
	 wAz/3gOQ6hr8o8w3VsHKN3feg1NKZ0Zdm5xuzPz5m6J/m+LLbOAXEJX8KvjayaW/Us
	 YFHdiIuz3AWKQ==
Date: Tue, 19 May 2026 23:52:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Maxime Ripard <mripard@kernel.org>,
	Natalie Vock <natalie.vock@gmx.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: implement dmem.high soft limit and
 throttling
Message-ID: <ag2EWbmlWhK2a3zz@slm.duckdns.org>
References: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-feature-dmem-high-v1-1-97ca0cb7f95a@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-16123-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 4FDBD58B35A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Wed, May 20, 2026 at 02:07:20PM +0800, Qiliang Yuan wrote:
...
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

I'm not sure about complicating dmem control model without implementing
reclaim. What are we slowing them down for if the only recovery action is
killing them?

Thanks.

-- 
tejun

