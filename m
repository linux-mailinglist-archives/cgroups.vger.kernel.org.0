Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2D38F8533
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 01:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfKLAaH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Nov 2019 19:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbfKLAaH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 11 Nov 2019 19:30:07 -0500
Subject: Re: [GIT PULL] cgroup fixes for v5.4-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573518606;
        bh=RqZ58pXyTwOBoreggkJiERbkQNHXSvU7CH9wxsfwQYo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lEeqwWbXl5oXSc9BMUnLxt8yjiQprQB515FX3ut2zjLsghw+7DnzQlm/oeQWtGhzn
         YgpHHJKQcmDxp7E8EdJZ9+WoOi/0V6TjI3RhNuh0dQsgRaLTLQKhnbG0+emca+8omD
         HYivfRXngFjobYr2ZJL0Fxm08h60k6euLZj5FVtI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191111202203.GC4163745@devbig004.ftw2.facebook.com>
References: <20191111202203.GC4163745@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191111202203.GC4163745@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.4-fixes
X-PR-Tracked-Commit-Id: 937c6b27c73e02cd4114f95f5c37ba2c29fadba1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de620fb99ef2bd52b2c5bc52656e89dcfc0e223a
Message-Id: <157351860653.22410.73967541645460298.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Nov 2019 00:30:06 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 11 Nov 2019 12:22:03 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de620fb99ef2bd52b2c5bc52656e89dcfc0e223a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
