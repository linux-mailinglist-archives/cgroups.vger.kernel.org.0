Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44372B1A69
	for <lists+cgroups@lfdr.de>; Fri, 13 Sep 2019 11:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfIMJFH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Sep 2019 05:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387613AbfIMJFH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 13 Sep 2019 05:05:07 -0400
Subject: Re: [GIT PULL] cgroup fixes for v5.3-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568365506;
        bh=y9zosm6Emxt7qS4zMnO2PZBMmj/UTTpSTgH+rozrYxY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qh+GPIuJXLFL+TLXp0P4fh/pWOakYAA83ToIlMeidNJucguuimgAT5TMrcW5WYBoe
         I4tPNpNZerfoOJ4V2lMvlo34qVx9M9Vgz9kxp3MEvCaRx3oP6Hr5jrYNLyQYW3bIT2
         5ilQt6psn5DHj0AP1pNkaJohdaim/LixCa/R0Z0o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190912211150.GB3084169@devbig004.ftw2.facebook.com>
References: <20190912211150.GB3084169@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190912211150.GB3084169@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.3-fixes
X-PR-Tracked-Commit-Id: 97a61369830ab085df5aed0ff9256f35b07d425a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7f89616b7376495424f682b6086e0c391a89a1d
Message-Id: <156836550667.13985.9782542852327752376.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Sep 2019 09:05:06 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 12 Sep 2019 14:11:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7f89616b7376495424f682b6086e0c391a89a1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
