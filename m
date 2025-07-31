Return-Path: <cgroups+bounces-8969-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D271B17A35
	for <lists+cgroups@lfdr.de>; Fri,  1 Aug 2025 01:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E21D7A8DB2
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26B928A73C;
	Thu, 31 Jul 2025 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sN9L9Cwj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6F28A72D;
	Thu, 31 Jul 2025 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005614; cv=none; b=pcR93Hbjbr8KJd8ZGXXuZMrWaG6VHHzdUr5fqXSPdc6BwLIulBCq9odbGflLd+VU5KJPhczg2l8XX3WvDN9NauPTovQhtdnVYQ9AC2hJFc+FJVT/BF2C9lAJk5DQe93hUdIz8CtMk66JNSfmBq8qObMlWaX1tW6uOygYPNpldHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005614; c=relaxed/simple;
	bh=kdQFErPhc1TPZUt8UhbMmXjPeOZ6hjqj1GSlMKGUn/8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K5WCdr4daJ4Xf+EqNl1V2pbU1wNlwaVtz9olXMTvU9JfoHUHiYBpDbkrUCv7N+d6QAQu4WanYAtyuvia2ALjNOC+fRA6WuwJIhyDWARrm2t48AQ7FeJ0jNRWK2zY0Bvh/rFDbnelwOHcoK/fdmv5w/MQ4qTLfInFW+jcoIzxHaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sN9L9Cwj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE06C4CEEF;
	Thu, 31 Jul 2025 23:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754005614;
	bh=kdQFErPhc1TPZUt8UhbMmXjPeOZ6hjqj1GSlMKGUn/8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sN9L9CwjEinOmbGxuKP4QtTsxJxDqjtNAwIwTTlgzUevFnMqNQrRuq/3/MNP+KnzW
	 i2xWOESWHEW4a94ZY/GTSz+IX5gUHWMqzzag3xPD6bNUwSRziBrpj8HasGNMbds15I
	 RZvOlCg6FjNicRwEgLoRjlEeKaZB7+to463zStoIHErWjDn7w7tkgk06Gk+IbMl5YE
	 QnCA8ZiZ4E8DpJ4U/W8bkQIRVzaUMDusHbnLdJpJRB4rBOKkvDrOp31MfgVUGvtE3y
	 5zFQQJpegkX6nvnR9M5mU84L0/CdaXAg0GdsEPa7cMqyaKP7q6WgSvXT2NfpkhXpV6
	 HXBOhFhVHQ3Fw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B35383BF51;
	Thu, 31 Jul 2025 23:47:11 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aIqmHVGyKjFG8agb@slm.duckdns.org>
References: <aIqmHVGyKjFG8agb@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aIqmHVGyKjFG8agb@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17
X-PR-Tracked-Commit-Id: 646faf36d7271c597497ca547a59912fcab49be9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6aee5aed2edd0a156bf060abce1bdbbc38171c10
Message-Id: <175400562984.3358753.1173255102120190980.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 23:47:09 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 13:09:17 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6aee5aed2edd0a156bf060abce1bdbbc38171c10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

