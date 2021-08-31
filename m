Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A563FCFBE
	for <lists+cgroups@lfdr.de>; Wed,  1 Sep 2021 01:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbhHaXBh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Aug 2021 19:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235399AbhHaXBg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 31 Aug 2021 19:01:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E5DFF61008;
        Tue, 31 Aug 2021 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630450840;
        bh=gdaSmJNmRz3weSmAKZW1QEM4T57zFfZvaBorbSUYCZk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nT7tdGL/Ou9gN7N2w1DMM7fQdlORqP1wJS411JSyjg+KdPEKVrp0xVC0z6b8XTRTS
         OCkEB3J4a3t1SsFhqg7/NMAk30DlMFFMUKOq/bl6uROe/CObKAU71yUonEy3xQb/dt
         LKU6SEnJdJSVR8GVNqo6UQBiFiizV73tUTUVcaPmlEnlXJrfwyzThviju73auxcI8W
         D2iVYYSTnPYZqEzYzcRoypWoIAyRy8AVsLzazJChAgg1dYPCv2INDC7WrhqaSpL6fb
         TTR2+5CFKKXzliJfo1fdLFLEBGg4lfa6rMbdXVGBv+UJgVw5rgCiYkL3eg9D+hGq0v
         tKhQg210637Kg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D5F3360A6C;
        Tue, 31 Aug 2021 23:00:40 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.15-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YS5b98kN6updRd3u@slm.duckdns.org>
References: <YS5b98kN6updRd3u@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YS5b98kN6updRd3u@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15
X-PR-Tracked-Commit-Id: d20d30ebb199354729c64c86945ed25c66ff4991
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69dc8010b8fca475170650a4ebbc0074541df859
Message-Id: <163045084081.6589.9831216519329234712.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Aug 2021 23:00:40 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Tue, 31 Aug 2021 06:42:31 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69dc8010b8fca475170650a4ebbc0074541df859

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
