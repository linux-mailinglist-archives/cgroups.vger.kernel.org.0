Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841CE46E11
	for <lists+cgroups@lfdr.de>; Sat, 15 Jun 2019 06:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbfFOEFG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 15 Jun 2019 00:05:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfFOEFG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sat, 15 Jun 2019 00:05:06 -0400
Subject: Re: [GIT PULL] cgroup fixes for v5.2-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560571505;
        bh=b/a8q+CufRJOz/FcqspHWxNUkU3OrCBVs4vkAypASqQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=otnN/L1LY0F94t/dI+qB38ZzdW7FYqv3bIFyVAeJjWDOdwGJ+NvFu/zAGw8no7Qlf
         coDpQUqN9fmObXv4xW0QCLzheSm+fDrYqdGme9kwfyv7pEN/ePErevz7nbdjpyQHig
         HOVxsodcqUnskYLizcCGQHyd0Us8V7ySu/wR8oTk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190614200253.GB657710@devbig004.ftw2.facebook.com>
References: <20190614200253.GB657710@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190614200253.GB657710@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2-fixes
X-PR-Tracked-Commit-Id: d477f8c202d1f0d4791ab1263ca7657bbe5cf79e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0011572c883082a95e02d47f45fc4a42dc0e8634
Message-Id: <156057150566.28747.12493884345585916211.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jun 2019 04:05:05 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Fri, 14 Jun 2019 13:02:53 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0011572c883082a95e02d47f45fc4a42dc0e8634

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
