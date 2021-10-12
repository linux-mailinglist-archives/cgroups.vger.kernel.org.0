Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00DBF429A71
	for <lists+cgroups@lfdr.de>; Tue, 12 Oct 2021 02:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhJLAco (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Oct 2021 20:32:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233607AbhJLAcm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 11 Oct 2021 20:32:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 8057060E8B;
        Tue, 12 Oct 2021 00:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633998639;
        bh=iXamAR3fOA7VQC/GpSHRF6/u7s4lBhGHbC6Cnw6DOuQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bFZpKFaJw82WitBIVBZBU8Uud0FJmuYKKtLDihCqfOTJO6uRheR6yYvqwWPEllMza
         zf8z/QNxZ0URDuCUmLsEH+H2Bpca5kXKY4JYx91mvucQHy3uo+nUQ8hk9WrtatTcH0
         C0ydt+FD3Azn5eg3BBkaJNoT+aRAxrCQ7WKJ59JPFfbC/5OB6jbA/DfqSFWIsbR3/8
         WBnETl3Z7iSAShJii39Zqv4PyG0EkY0ph1GQBxHsRMTSWtbD8WKdsc+dXqr+Qfyz7/
         r47eGJpI+GwAwuq4LQ/oTmwDphbmE9ykk6O+jkxBsbRYd1wenzZSruhmQjuGGNMJTm
         uWpR/DgglXjWA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 76DFF60A45;
        Tue, 12 Oct 2021 00:30:39 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.15-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YWS0kcEY3MmKrZJk@slm.duckdns.org>
References: <YWS0kcEY3MmKrZJk@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YWS0kcEY3MmKrZJk@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15-fixes
X-PR-Tracked-Commit-Id: c0002d11d79900f8aa5c8375336434940d6afedf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 459ea72c6cb98164ccacd6d06e3121554c13ba5e
Message-Id: <163399863948.7007.18082768544664412722.pr-tracker-bot@kernel.org>
Date:   Tue, 12 Oct 2021 00:30:39 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 11 Oct 2021 12:02:57 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.15-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/459ea72c6cb98164ccacd6d06e3121554c13ba5e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
