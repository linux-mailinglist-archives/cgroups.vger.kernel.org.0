Return-Path: <cgroups+bounces-3691-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A6931DDC
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 01:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A54BB2097E
	for <lists+cgroups@lfdr.de>; Mon, 15 Jul 2024 23:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03AC1448E4;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlSzFgLd"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CADC14431C;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721087784; cv=none; b=R64WPyMSVheLVB+olAcS72FuNoSABWd+a/p2TP/ks94iHYZ/mnNvuqhmvf+MVpdCTzp8dzwD1549TDMhfy5Vpgva6GWVYJ7/F2Az1mDSP+/XRSnnXp4UbxJY5kz45IZ1A+NwbcqesTWyDT+RBROs2neBhn/rjhXbETNveR1fFjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721087784; c=relaxed/simple;
	bh=pc/8BzQj0A7vfUq3SR2MBzBTt2nJEwVqY1XIsSDEDOE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=TX71rdwYS3rT5x/Hl5Vt5W/HA4vYsdENiatKLsUoXazDTXRK4+EDSPTOwxc5VjWTD78GF9WsqOx1fncbsC/d5rpC67ea6NIAsm+EmvByUW8rs8aV9fY7q40kMaliCaSYHutdBEFzd+rJHga9uP8jMrBb39KAYhWpa1JH/eXgLgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlSzFgLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63B07C4AF5F;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721087784;
	bh=pc/8BzQj0A7vfUq3SR2MBzBTt2nJEwVqY1XIsSDEDOE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hlSzFgLdIzrXltxiEOFvlDBacVBZEYmuRRZ+arZljrPuJWhERwTFvd+epqDYN/BhG
	 VI7tbh9iZSEVS2+sXOJ0iyAiTXzlK9jW13EINhM8b4DcXrhcySrjiaQw0HcZoR68Sf
	 jlknzNv4eUGSYlnecTYHWmvAtcNSNpgSut2JG08x88dY9YeeP13X6CZDirVVRWSdlG
	 YujMY1hzALNMN0NGknfGl1MHd3I+UcMHdReSUMYO/9KPxc2/GUqXs8DlI1UR4EM4IP
	 F/9qqM+7vt7ydVSJ5qfCIqq/DaRKa6aJrWC/yinvU/wyA0wSAQPEUpDUy9iyisBv25
	 L/lFrzd6RTy1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C8ECC4332D;
	Mon, 15 Jul 2024 23:56:24 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup: Changes for v6.11
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZpStAERL5IH0OAps@slm.duckdns.org>
References: <ZpStAERL5IH0OAps@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZpStAERL5IH0OAps@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.11
X-PR-Tracked-Commit-Id: 9283ff5be1510a35356656a6c1efe14f765c936a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 895b9b1207f26f020f18b5b54e072d119defffc4
Message-Id: <172108778437.25181.18383077803511988278.pr-tracker-bot@kernel.org>
Date: Mon, 15 Jul 2024 23:56:24 +0000
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 14 Jul 2024 19:00:48 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/895b9b1207f26f020f18b5b54e072d119defffc4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

