Return-Path: <cgroups+bounces-899-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A218092AD
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 21:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E20A1F21169
	for <lists+cgroups@lfdr.de>; Thu,  7 Dec 2023 20:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0B14E1DE;
	Thu,  7 Dec 2023 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzF2Fid0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD04B12F
	for <cgroups@vger.kernel.org>; Thu,  7 Dec 2023 20:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DE1DC433C9;
	Thu,  7 Dec 2023 20:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701982015;
	bh=huiJO6F6nRuXA02F9eMS4nZvs8KvMmyXId3I5/P/bfo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=OzF2Fid0TXx/hs9RkG87aDX76EySV+f9lUclly3kVFPeXrTCaDU3ygZMzk2kEAZP9
	 IOfQQm5rFfhafrEvhnS8fDVzqMoj33su8u//RPGgK8/O8lGj7Uja1gNTTOgp21mSlk
	 tB3aV7wkkIVMZSsayby+9f/tEgAMQS04Qqx0fMAiQ0gR4vCcRDIZ3HHNUKhy9uuIwU
	 /SbxLTNhdb+brOPnNz4OXX9GAR7e6uxexpdkVjeDrY3Mq4Fl/mDzanYOeOP2LWdYzk
	 kRR0mK0CeaBYsy8AKgibOdUrh4ztS7Gip6UONXeDRL2L/d3fIuukKlCQNlVx78Z/ku
	 2MtxfBW+SjZvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72F5BC43170;
	Thu,  7 Dec 2023 20:46:55 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.7-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZXDNMJbgFHMiKkO_@slm.duckdns.org>
References: <ZXDNMJbgFHMiKkO_@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXDNMJbgFHMiKkO_@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7-rc4-fixes
X-PR-Tracked-Commit-Id: cff5f49d433fcd0063c8be7dd08fa5bf190c6c37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ace34a8e446c1a566f3b0a3e0c4c483987e39a6
Message-Id: <170198201546.1554.188470260825773393.pr-tracker-bot@kernel.org>
Date: Thu, 07 Dec 2023 20:46:55 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Dec 2023 09:36:16 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ace34a8e446c1a566f3b0a3e0c4c483987e39a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

