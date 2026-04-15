Return-Path: <cgroups+bounces-15318-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIRoBo7V32mYZQAAu9opvQ
	(envelope-from <cgroups+bounces-15318-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 20:14:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485D407033
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 20:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2973330FD8C8
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2026 18:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512093E869F;
	Wed, 15 Apr 2026 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U58AAif+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F33D891E;
	Wed, 15 Apr 2026 18:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776276778; cv=none; b=tpi+jg+2JKGVy/iLe6UZX83O+5qqq+5H5xkqckDB5k/8ZO39aYn+UwG2yhAzq0pFjtUpNXgBkuoNGEoGO7NS2jnAV7QO3ofjDIoL/En9NGlwq6XYSEyG3Gqu8NEZ1oQxrdyKisgctPnO1lx9XWqSdI2PXR/VAJNXUf9JhqPD4XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776276778; c=relaxed/simple;
	bh=MN1V7Dzlg2CGb2u32cQ7dEoPeDMgXKVdBlXvHVVxSWM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rxjp0qhe0EseTnE5ufmJ6TiXGwxK+A3WToxLhzpYuuq/swqpPC/TpVK4lF2R86/RG/NeFKoM1ZiW3FuF0jPd3kGWtl23RvkQcyHH/nzZ+KJbRup+BazgaNx0mMNJVOwHuYJLCAzW8dtddnyLlF6BuoPaNIPd9n+Gsp6x/AupCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U58AAif+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83B5C2BCB4;
	Wed, 15 Apr 2026 18:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776276777;
	bh=MN1V7Dzlg2CGb2u32cQ7dEoPeDMgXKVdBlXvHVVxSWM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U58AAif+oQkD4D49Dcj+56wR0yre8tglvhJ7zwGy5CuRcWT+ZPMGR5tSbqp876Ffb
	 etO4ow/4HygeZU8NWB3mxrruNvWw2j4H/drRmC6R5YP8YmhCGQjaQgyikhLTa1zL7u
	 cy2PsXgkT291Zug8UXBw2LujeeBy58P3LJwnUgGrktxdevCEZj4SGzehq+1vbTNq5r
	 YqQiZ8EIVvq8l+f/6chrajBI6xZk3YAw+3gjrAtj5wjSW+ofC+c9ljQwk4vTkZt7aM
	 VehaiCEGZ/PmYNgckzph/UJX1kXAXJGD5EALRhBw0bDWBBKY1T6wWONo5R5MjJzuX8
	 Wu8JM82K/5tcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0C0380A963;
	Wed, 15 Apr 2026 18:12:28 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <5c154b2c25e1dae88c419232ae1cc581@kernel.org>
References: <5c154b2c25e1dae88c419232ae1cc581@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <5c154b2c25e1dae88c419232ae1cc581@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1
X-PR-Tracked-Commit-Id: 3348e1e83a0f8a5ca1095843bc3316aaef7aae34
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b71f0be2d23d876648758d57bc6761500e3b9c70
Message-Id: <177627674711.2375850.3629261867492528155.pr-tracker-bot@kernel.org>
Date: Wed, 15 Apr 2026 18:12:27 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15318-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,cgroups@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6485D407033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Mon, 13 Apr 2026 07:07:42 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b71f0be2d23d876648758d57bc6761500e3b9c70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

