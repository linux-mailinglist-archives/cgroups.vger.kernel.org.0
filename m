Return-Path: <cgroups+bounces-15518-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFCwHIr372mFMwEAu9opvQ
	(envelope-from <cgroups+bounces-15518-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 01:55:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3747BFC0
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 01:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3720308D6EA
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 23:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9873E275F;
	Mon, 27 Apr 2026 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O385ZwzR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC0F3B7B8C;
	Mon, 27 Apr 2026 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334033; cv=none; b=RCxXaicpMFAIXXf8iFrc57KxHfMYsL26gISfmYyQmjzOtzjFM5YQm4AQAz7j+iMIgO8oD5kAVqS0KG1NvLnuh9LWuBpKG6Hy9wKet6Ovi/u80J4OW/QLuSiqZgPUIMFAMWLDtxvRUR9qpMQgbRnt0xbT0uZANh6YQYIZuNv3ZiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334033; c=relaxed/simple;
	bh=ERGc9xz6M/CMxSabpi8OH2uKMysB2hKPK+8Z+AibBB4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hkmpxSaSi8jF+CnwqtN4ypOa1R9KJuPF2z6bCLa54QiId1ol9Y0HXpNSPYxHwItJY3GHYBWyl1qltAv9EkY6wJ/pN8xQS33xM5on4u2axjUtJTSFujFbhvuUqXlVL1h8kRX0dS/ZbL5dS5xNTXstJX4Hl3xeScil8/WcjcRxQeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O385ZwzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C232C19425;
	Mon, 27 Apr 2026 23:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334033;
	bh=ERGc9xz6M/CMxSabpi8OH2uKMysB2hKPK+8Z+AibBB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=O385ZwzRfdN6B4qr5GENalmNwvy1gkVXGKy+DzPUO/3UOn/Zv1cJGZ8/1qOq1rC8X
	 lbKT2PJXUzJ6iiqTzXaBvDOZQyDBEn4IC72BdvewtBpPfgtRdvDK/W7wwkm7/dOYde
	 xH7P2VJT2txSioFRXEkK9RS3KmR/c1SKMD7Y+bJax7WL2tIMqqokqrNlNnbD7gGlxP
	 JMOEF/D5D+2K5CoYs1i4CfugDaHMckawG9H0LocfXopkQqIOijp3lVqeX02RrdWUCZ
	 yNCWNiPJ3qyntI//a7FNdFYc6DuwoS6Hk3LwTAK5EV1v/1QZfdS3ofRTGNkDNjUUvx
	 JhGKw9L0CbC6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA05D392FFCA;
	Mon, 27 Apr 2026 23:53:11 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v7.1-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <4403616be923254d7f4c878973e44321@kernel.org>
References: <4403616be923254d7f4c878973e44321@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <4403616be923254d7f4c878973e44321@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc1-fixes
X-PR-Tracked-Commit-Id: 981cd338614c96070cf9854679014fd027c1fb1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b
Message-Id: <177733399029.159864.12974065630589256604.pr-tracker-bot@kernel.org>
Date: Mon, 27 Apr 2026 23:53:10 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: C3A3747BFC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15518-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The pull request you sent on Mon, 27 Apr 2026 08:59:34 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

