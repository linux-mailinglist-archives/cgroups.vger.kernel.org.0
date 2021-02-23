Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F2D3223E4
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 02:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhBWByN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Feb 2021 20:54:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231343AbhBWByJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Feb 2021 20:54:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 642F764DE9;
        Tue, 23 Feb 2021 01:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614045209;
        bh=6KkHjAGzP9bucdCQQr0LgOlgOGwOkv+yNLuZ4SefiMs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AOFSbUYebd8kAr3vs1VhhghTmQG1o+BkT+uPG9hNj0lTuY3rbf/bOGupInUB4M2tu
         eATAeTSKcMlp6kCN8nwm9377edwnkPREVdVaf1ilKcnj4Dd2z8+xilGpoVpCqPkdCz
         38mB27zvViLY8U69lqKXEYk283kaWG+vQ3+LFhfxUNiPKvunAVgQN7Xs1KjfH5mT0u
         8N4H32R4w0YEs1lC8h+8h/5xU0yvntcS0fAmMpPq8JXq9OogKuILd5iEHlYCevwoJi
         b/yGyYmPBSgKRhP2r2ghAwZkMg5Rr2SwTvxs98NSFPhIoNC+Y/1mDLPdRRIKF3d7gy
         bTyZuJ9KeI3PQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5D742609DB;
        Tue, 23 Feb 2021 01:53:29 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.12-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YDLMthAFbC6OTeh9@slm.duckdns.org>
References: <YDLMthAFbC6OTeh9@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YDLMthAFbC6OTeh9@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.12
X-PR-Tracked-Commit-Id: 415de5fdeb5ac28c2960df85b749700560dcd63c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b3bd22b123b7a75e2d08e4eb45d406b0fa685cd
Message-Id: <161404520937.2827.13913957708392637295.pr-tracker-bot@kernel.org>
Date:   Tue, 23 Feb 2021 01:53:29 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Sun, 21 Feb 2021 16:12:22 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b3bd22b123b7a75e2d08e4eb45d406b0fa685cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
