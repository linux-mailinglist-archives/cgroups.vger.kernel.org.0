Return-Path: <cgroups+bounces-5323-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7E09B5A13
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 03:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9948B22DDC
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3359199E9B;
	Wed, 30 Oct 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djsvBkzE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8022A1993BD;
	Wed, 30 Oct 2024 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256273; cv=none; b=kpRjTUwhiiqMN0ilApfq0fTtTHXXspO5ffMYe89mr+V2ui7Eb2CqB75Y3NMXvm3hK1ihXQGnFVub+h5HjkXCW2+GbWpovbsFhU9cLKnvDdx1XAqSJOucOgt1kqjcmXC3uFFykPLqKxsZluG30Z/6l5jGkYifk88/ysSZora6Z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256273; c=relaxed/simple;
	bh=0b1SewNA39A+vi05jRr7Gks7/PKdQLVrqEBxgqHSvaQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PCspIEs8G8UuCGjZF6OdSQoSNDCJw1rD8Yry/k4p/0mTZPV+qnocUWIUK5iN8iqx3wMdFUPiyspy9XeIc1CWk2Qypp5YZ1fJ4V1tyAk9QIbhu8RdYEJf0abJQzeBMXo2CiVeKq9v+o333cDPWV1bijEYT1gMSSfTHRlIgUM0PVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djsvBkzE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60642C4CEE3;
	Wed, 30 Oct 2024 02:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730256273;
	bh=0b1SewNA39A+vi05jRr7Gks7/PKdQLVrqEBxgqHSvaQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=djsvBkzEQuCVJzB2jXf3FnuXA9RRAhXiXbaZt7H3Sg4j1CBt1N+FNYVFVvnTZpQZs
	 syX8lklc/sF9k6+2X/9wQsb2oY9mRmEzvpzU1M6lLwKpMmdhXX78oTZTZM+O7rz2uL
	 HrQO9ZtCb/yQ/o0jVGKc17dZIvm+Pb8pqhJHBwQIC7rmC+UbJ8a1m87pL5iXVSHBK8
	 TytPz4/qKVg3sBCF6HFV18imWA54iHODZQctCDUI80CbSFwuMWZ9mZ/m/+kttee7sm
	 QQzbitnguqO/W4ifuMuDU9sSYb1jy0X9/vwqg+f/gW7YKWWg5dL2cGKiZ5JSkyrTQu
	 Wy7a2gCq8GPTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B0F380AC00;
	Wed, 30 Oct 2024 02:44:42 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Fixes for v6.12-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZyGCb34Fcj3yoVL2@slm.duckdns.org>
References: <ZyGCb34Fcj3yoVL2@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZyGCb34Fcj3yoVL2@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.12-rc5-fixes
X-PR-Tracked-Commit-Id: 3cc4e13bb1617f6a13e5e6882465984148743cf4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1e939a21eb111a6d6067b38e8e04b8809b64c4e
Message-Id: <173025628075.893735.7063624326411610735.pr-tracker-bot@kernel.org>
Date: Wed, 30 Oct 2024 02:44:40 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Oct 2024 14:48:47 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.12-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1e939a21eb111a6d6067b38e8e04b8809b64c4e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

