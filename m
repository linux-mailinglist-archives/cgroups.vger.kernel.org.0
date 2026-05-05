Return-Path: <cgroups+bounces-15632-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMgLLc2D+mkEPgMAu9opvQ
	(envelope-from <cgroups+bounces-15632-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 01:57:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBBC4D4D46
	for <lists+cgroups@lfdr.de>; Wed, 06 May 2026 01:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78A3C3054A35
	for <lists+cgroups@lfdr.de>; Tue,  5 May 2026 23:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D62C332918;
	Tue,  5 May 2026 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a1tUbJlc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DF233987E;
	Tue,  5 May 2026 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025410; cv=none; b=OKJe9djqVw6d+QO2SGt2nL26QP6N5FPRj1BAmhtwBlqsgT7xIFXbVMNGPvWKJi4zA2P60t5DrPiO8WeugFhny1cMESb8veKqvbDDnI6J+Qvgzi+R4AAhTR3tUgHZ+w4wR3UEd5/2+Q586ER4h1mTzRRfS6/3rOzMKiaDGidhtRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025410; c=relaxed/simple;
	bh=8+tOBqtIPXEJNzZULBhYGJ3NATDp/POoZd6laGobaQo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fdg4pOlm2BrYcKFzYGZCGUhiuTJ4FKE27Fz0QLQ+3aZ3fexzSBQPYQPFHmlD8hkIB/IolPnh0frJHgRb4xQtxVPbkG8P+xZhq2FsoknW5snHppfXf+2sGoCuX+GukW1MXha5KxCDEeWZdNUIC4JnyrTRsgboRBNn0l+j3Z/9w9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a1tUbJlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59B7C2BCB4;
	Tue,  5 May 2026 23:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025409;
	bh=8+tOBqtIPXEJNzZULBhYGJ3NATDp/POoZd6laGobaQo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=a1tUbJlcJcz1/tInjUvBt3rqnc32ucof9QLh7C3q//kIkvec+yHo7gWOEZ6Gf/D51
	 4WSVTK5bb42o5Eju1nnt4P/io3tNub8TJL3ukWejQOjDqD/cCh2wwgMftpcJKuRq6f
	 mirbFDApT1C1yhgoK3cfgrRgajoMlYL7GYfzw2S8QXwhM/jlybEt8moaPu0BafUZ63
	 bCsWG+NZo430lZ6g4O10Y2n2lpkRM9RQ5jmHemWWWSON/efGQCpc+SnLjile+tl2z/
	 r5hLDsboQbXj0YYsovQ/a0qhHAfrNUiLA6dhjExy4T+TplP3J8RUIFPEJK8tia+hZ4
	 PZYbuB5KVUHqg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC5739302FF;
	Tue,  5 May 2026 23:56:01 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v7.1-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <f5258b93b0a513c90b4129177a2eb50d@kernel.org>
References: <f5258b93b0a513c90b4129177a2eb50d@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <f5258b93b0a513c90b4129177a2eb50d@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc2-fixes
X-PR-Tracked-Commit-Id: d8769544bde51b0ac980d10f8fe9f9fed6c95995
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 11f00074f72a977274c64c100372764eb04e6a3f
Message-Id: <177802535993.2314843.17011475582292546360.pr-tracker-bot@kernel.org>
Date: Tue, 05 May 2026 23:55:59 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 2EBBC4D4D46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15632-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

The pull request you sent on Tue, 05 May 2026 12:05:39 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/11f00074f72a977274c64c100372764eb04e6a3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

