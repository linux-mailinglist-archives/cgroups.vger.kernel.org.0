Return-Path: <cgroups+bounces-13098-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8399D15495
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 21:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9843730B0289
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 20:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789934B40F;
	Mon, 12 Jan 2026 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4mRNJW+"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B755B347BCC;
	Mon, 12 Jan 2026 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250311; cv=none; b=fcqgt2zX2LVkD3MMGkQWdrMUysFtK6dmWVDRqdutYGFhEdR8mUZZP0z8hNTsYb9f42CYXNj2yqzKP/Ls8TNM8t6VRAuO13E18h0KsRkJq3AJ3Iz+NxdgmXwvP29dE0vgB9a1xa+NuHs4Pnmw1p62nuDJUxOLbMNpnku4nNqReAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250311; c=relaxed/simple;
	bh=t4k2CLh2Z5mwSE2b73BW/uwohBfwukuGnMeeyKWBLQM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=kN+nUqMJIyPWh7SeXkTFaBI/0a4owmXeXuczpvphnUztI2miYkma30TfoMKfFzEQTnQ7OwkIuEbTl9WMa4FZHwwlPEMhXnvDrO5RMyh1L+kJcKnWXN6RmdMAUqe62L5FEmpMVySFm9ZFajpJeYV9cFufxjNEMdOQO1XBxTlLV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4mRNJW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576A0C16AAE;
	Mon, 12 Jan 2026 20:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768250311;
	bh=t4k2CLh2Z5mwSE2b73BW/uwohBfwukuGnMeeyKWBLQM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V4mRNJW+PASPjmRI/zOnzwApJZqj6d0lCoPqKpVDHvA+FPhXmNaYH6uJ78a9HPmdE
	 Q2ay2n26nWv9ei4l59yGML+c6kgaBOepB0WwHrMGadYgCILEW2+FjJfixmARs47Pya
	 ISeahKVmor6mfvLA5qWCZcU9YX7Vo5UsoLNYz2Ab/r4wrS0b3/k06lGTzXzz944Ouc
	 hTS1sUvNJGxSBkAEIFOsYB3Etg5Ckg2X3IyJYxb5OnlO+Sp1tlh+0CuhDzQqOjj3zw
	 Pk4o7de5jrJq9I8wxr5VaJtBI5NRN39PD8zhQ8ukJ0MjZSICALXKY1q6XkVkZTl/xj
	 dkOyHUk1BjDSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7BACC380CFD3;
	Mon, 12 Jan 2026 20:35:06 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.19-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <2b67728dc00d11baa695ce60bbbd0e71@kernel.org>
References: <2b67728dc00d11baa695ce60bbbd0e71@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2b67728dc00d11baa695ce60bbbd0e71@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc5-fixes
X-PR-Tracked-Commit-Id: ef56578274d2b98423c8ef82bb450223f5811b59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b71e635feefc852405b14620a7fc58c4c80c0f73
Message-Id: <176825010524.1530057.15779103410166351311.pr-tracker-bot@kernel.org>
Date: Mon, 12 Jan 2026 20:35:05 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>, Waiman Long <longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 12 Jan 2026 09:53:44 -1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git tags/cgroup-for-6.19-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b71e635feefc852405b14620a7fc58c4c80c0f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

