Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF5431ADFA
	for <lists+cgroups@lfdr.de>; Sat, 13 Feb 2021 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhBMUe1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 13 Feb 2021 15:34:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229818AbhBMUeX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 13 Feb 2021 15:34:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 827CF60202;
        Sat, 13 Feb 2021 20:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613248422;
        bh=UdqFlA5f1dhkoDkbOpBQvT6LUv/DrayKpSZ4UV27eFI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JztK/goCusB+LPYTHWl6Vjk2fxuv9YCx//5JubGtreceShuq0cDW1POxWLaBX8rQJ
         70nV/FxO9lChG9yRm+kBjlcjEqN022JK22dVe8uGjfiucP10lWOISf4HujAjSHnUMx
         ABrmZ5UeQgGy4nJvQEDVmqNQY47OjZCh6Gy+17GTEvlYO17vo8HHxV6JFoMtc4iGpe
         Radw6typmRbMNKCJIAOz0EntMG+JvIHoFOFfrv5g+ftPdIkaklDPN4ftKu3TefDYHi
         zjny1btmjYO4cztEegHmd9zSrVKU+HaYfZgMImNI9hiOFVNAYKhfDAt3x/wmvb4OyL
         KtZ+0Vi0cVjHQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 71C5860970;
        Sat, 13 Feb 2021 20:33:42 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.11-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YCgwkyRWS5fM0Xtj@mtj.duckdns.org>
References: <YCgwkyRWS5fM0Xtj@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YCgwkyRWS5fM0Xtj@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.11-fixes
X-PR-Tracked-Commit-Id: 74bdd45c85d02f695a1cd1c3dccf8b3960a86d8f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac30d8ce28d61c05ac3a8b1452e889371136f3af
Message-Id: <161324842240.29494.3043101433487963584.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Feb 2021 20:33:42 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Sat, 13 Feb 2021 15:03:31 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.11-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac30d8ce28d61c05ac3a8b1452e889371136f3af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
