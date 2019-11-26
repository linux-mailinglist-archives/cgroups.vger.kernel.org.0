Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A92B4109851
	for <lists+cgroups@lfdr.de>; Tue, 26 Nov 2019 05:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfKZEZS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Nov 2019 23:25:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:59972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfKZEZN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 25 Nov 2019 23:25:13 -0500
Subject: Re: [GIT PULL] cgroup changes for v5.5-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574742312;
        bh=R/KFf5m9GbCJyVgo07wMJFyL07/ToffG8zlz88J6Riw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iQ0xkjoQN/3szAcEuN1tQANNbw/vlDWSHUYMcHes7Yped865JpLh6UtCPfaC5Tuy7
         Etnnwh5Kjq25L7TFOvZoq4kFovO/H2xJf5Jd+hV44JvryiOS9mN4wvnl+/NIHkCss0
         2a9+mZRjhPKHx1+/2VsgH3xU1Qnp6hdXD/RCmTpw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20191125161141.GC2867037@devbig004.ftw2.facebook.com>
References: <20191125161141.GC2867037@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20191125161141.GC2867037@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.5
X-PR-Tracked-Commit-Id: 40363cf13999ee4fb3b5c1e67fa5e6f0e9da34bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1b96a41b420972f8ba563373de8154d59d5b2208
Message-Id: <157474231271.2264.520778310881589506.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Nov 2019 04:25:12 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 25 Nov 2019 08:11:41 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1b96a41b420972f8ba563373de8154d59d5b2208

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
