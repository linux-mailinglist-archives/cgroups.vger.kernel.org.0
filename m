Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D03B9A37
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 02:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhGBAtH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Jul 2021 20:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234579AbhGBAtD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 1 Jul 2021 20:49:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 133CD6140A;
        Fri,  2 Jul 2021 00:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625186792;
        bh=9BP/JTFH+8Nl/vasNq3220FOic+vTHzzsyfkbY/4oIA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H03wKnGmW8Tu2LszP20DdrhvLejpO+nYLhYCagRrUK6TpuaiYDfD1Hs8mb9EbZSqZ
         DRyoXvXD6FoIHl/r19JH4mehhnP/xOHR0SYJArQCHHJZxeKO+AGM4xTBb2GngX/tP/
         4338XNAod8Ely8HhnGDS9A4vEj+EY5SKWqLFlVWmS9vRwRtTEIzWjPoiw5DbmYr56c
         MlxkYcqxgSLQEMxwFBo/OFITzM7qYWIWGjWqoYWKxC1IUHnDZsiD582uP0pCwqilnS
         x/ROCws7g8Mhd+hoF/1qJ0IdZYqSTggqxMwrcnVadu2XAGPtwaq51LgOtXNKLXVWXp
         nwubbxOO81RXA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 0C1096095D;
        Fri,  2 Jul 2021 00:46:32 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.14-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
References: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YN4rzCdUR+/2LgaP@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14
X-PR-Tracked-Commit-Id: 3958e2d0c34e18c41b60dc01832bd670a59ef70f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3dbdb38e286903ec220aaf1fb29a8d94297da246
Message-Id: <162518679204.2278.1195383988351883655.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Jul 2021 00:46:32 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 1 Jul 2021 10:55:40 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3dbdb38e286903ec220aaf1fb29a8d94297da246

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
