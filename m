Return-Path: <cgroups+bounces-17029-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EBQpAvOHMmpj1gUAu9opvQ
	(envelope-from <cgroups+bounces-17029-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 13:41:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6910A699367
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 13:41:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Jlw47906;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17029-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17029-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CF633326525
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABCD3DD513;
	Wed, 17 Jun 2026 11:25:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548363CF1F2;
	Wed, 17 Jun 2026 11:25:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695558; cv=none; b=ZJgbItM7Rx9iif5x7D1VkAh/abEU0Bja5oFWJDbuxdSJdwrzEL43SZ0H80RCSIXbB+ffPeqo5kHz6RL5s/lEoIO7PJ5mnCi9rt1DRslF9ZTdN6IQHntSFO3dzRV2mVYJD76pRnugUxfR8MHXnoCxLtrOf3p1GerZZWXWOrfNfkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695558; c=relaxed/simple;
	bh=Bhn+AIDF83oIsJubpKUP63QBgWxFSp8I+aJegIgHEY0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dBErazJNPv5NjIvY7Xtrofa/9u3TedPm8CUV/HwbrN+RWGYAd2O2e4wzERHRn5RbKFn3lg6N73XMaBWCu/ujWy1fG3XMt/mUE3A+cdAOfA7ge3C1lpmQ3A5IGjsOU8ooh+/qEf4I9O+toEBQbJ6zSc7bUHkQGRfWWQVDAl6RyZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlw47906; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B181F000E9;
	Wed, 17 Jun 2026 11:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695557;
	bh=kDfAEBbS2XgKIOeFfr41yo9BKQczd+dlVWMu5KYOGMw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Jlw47906SaspngeHu/N92fhmCJol6hnUGr5Qgbj5qTeh74Ncrmvlld04VDdcLm6k2
	 aZl3ejWUh2oWuPfCC1xFhA3XVWOqbHUyesR6/vKzxgneAQoooq2Ld55QzLSLw5+tT/
	 ovUv7ZTpgQpW8ZN1/PmHY+0VVz8HhAiHZHZWo4aOrajjVXhAAwrNk1bbZwW3bJxUXg
	 JyRw3qUt3Ezapo2YJkxfg//2mH5psX0hPHUiX6kawLInSzWPCvvoRd+nuIskjhTA+D
	 0uQpqcYiuvE8zZQsEF9aJBicqdfQRrR7sH5iqjbNK0FiVvVvo//UQDnN1jlKYqXvq4
	 HBML5ZadjMPog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9389E3930E03;
	Wed, 17 Jun 2026 11:25:52 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <b935100af77c4a118f8180ca31627e35@kernel.org>
References: <b935100af77c4a118f8180ca31627e35@kernel.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <b935100af77c4a118f8180ca31627e35@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.2
X-PR-Tracked-Commit-Id: a99ce697ea5e27b867c9ba4ee55fa5ba3b8d1188
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83476cc97bc635a3ff502bd194c79bfb1f1ae050
Message-Id: <178169555132.1566750.7088063571239906149.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 11:25:51 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17029-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:torvalds@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:longman@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6910A699367

The pull request you sent on Mon, 15 Jun 2026 12:01:08 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83476cc97bc635a3ff502bd194c79bfb1f1ae050

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

