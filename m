Return-Path: <cgroups+bounces-16652-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KrteA1bTIWrbPAEAu9opvQ
	(envelope-from <cgroups+bounces-16652-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 21:34:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59779642ED8
	for <lists+cgroups@lfdr.de>; Thu, 04 Jun 2026 21:34:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j1uc8j3k;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16652-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16652-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D21530276B8
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2026 19:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AD83C1F5E;
	Thu,  4 Jun 2026 19:31:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184A3C09E7;
	Thu,  4 Jun 2026 19:31:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780601502; cv=none; b=s70/lw1WEdegdgISn78JGX3+cLzCyKrjgHTPiVWc8eIK25BYeLjlviUBNe8ahZlNVNSZSqfZC4xvIZznxSyWUN0Nm3lnfn8x8yWxolQiYWIX/YLEJfMBwN4uVTXYzzBpwQtgbps/MMmodiYY6pq4iOYq+pHJOjvMkNhsimptNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780601502; c=relaxed/simple;
	bh=OAPSFlTzyDGeJiyfpnOYgq0q8v7xFBw+GkGB9Hh1+Ys=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RimcU5cVbLf0yTGkfER3wmrPpW1hVGM58Bl3Kef0aO28da/DyMWz+sCCMwHBQ0YN+gwXBRfFicSwYQm0v8NOqz8B/nz3p5ijcAjkB+ZG7Rha2zbulKrVAih61oXT6P+b8A6bLnY70IUWes73iCLDBIJXkZUTeACceAxboe3OWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1uc8j3k; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C871F00893;
	Thu,  4 Jun 2026 19:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780601501;
	bh=TLQmD9vCgVmThmuPA/QVw0Rz7WDxMHmEcMm0k2V0m8k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=j1uc8j3k0HjQAIK6WerSzGtebX1FlzqNMYgKq3MIjgW+yMIwkVFd8MONBgUsRanu4
	 ZXDvu+d2Y+meyqm294ZYWWBSv/KQjMcU1dHb9QvuB2r34U0MjIkrsGDCy9UkutWA8i
	 lpTk1J9ul8CjcCxcvuqKgoq68EmsA/FEOtgsMlqnHvILm3/Wv/gXpJxE0RXaX2AlC1
	 juLJrbYgJWISALQWi9kpR8bYmEV3rpNt1PWfv3FEwRxYpwWwlBTWitoL6N9GNFxEus
	 LSQrRFkZA2uuZ15Kj0axlWtRAPrn4TIEUgHi+1xlZLp9b4uP+7gdbtsdz6fWJvKYQW
	 R8Cnp4UIGY9bQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BD93930A18;
	Thu,  4 Jun 2026 19:31:43 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <547622bc7e85cf6c2c3a2f95bf146f5e@kernel.org>
References: <547622bc7e85cf6c2c3a2f95bf146f5e@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <547622bc7e85cf6c2c3a2f95bf146f5e@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc6-fixes
X-PR-Tracked-Commit-Id: 57aff991119693e09b414aff3267c0eae5e81da0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e7524845cda3c0713c0e61681dcd5263f0270fbe
Message-Id: <178060150245.2990765.14926213268493189472.pr-tracker-bot@kernel.org>
Date: Thu, 04 Jun 2026 19:31:42 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tj@kernel.org,m:torvalds@linux-foundation.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:longman@redhat.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pr-tracker-bot@kernel.org,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16652-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59779642ED8

The pull request you sent on Tue, 02 Jun 2026 12:47:53 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-7.1-rc6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e7524845cda3c0713c0e61681dcd5263f0270fbe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

