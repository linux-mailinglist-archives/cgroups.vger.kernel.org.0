Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2E81587BD
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2020 02:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBKBKZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Feb 2020 20:10:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:59872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727641AbgBKBKZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 Feb 2020 20:10:25 -0500
Subject: Re: [GIT PULL] cgroup fix for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581383425;
        bh=guCa2llgRydWfRl+c7oA1nbkgyMewINUy/9UmgXfW5E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cjj1Yopaow2AIBEyw7jSrcBzsAtrcznLw5WuhPfwESJNNd/OFCLehxY6AwMChwevL
         Fvt3UWMWykSN2DdIbC5b2wFbKw2haJZysOQHcw3Bi+E5SZ3uSs8kqN0qjBS3BUBJ7+
         ZCoxD/Nr+/c1u359mDekzkZ/05Ix+MrHMsaVEQas=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200210225512.GA9161@mtj.thefacebook.com>
References: <20200210225512.GA9161@mtj.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200210225512.GA9161@mtj.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6-fixes
X-PR-Tracked-Commit-Id: 0cd9d33ace336bc424fc30944aa3defd6786e4fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a679e13ea30f85a1aef0669ee0c5a9fd7860b34
Message-Id: <158138342496.12297.2527992854131955626.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Feb 2020 01:10:24 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 10 Feb 2020 17:55:12 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a679e13ea30f85a1aef0669ee0c5a9fd7860b34

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
