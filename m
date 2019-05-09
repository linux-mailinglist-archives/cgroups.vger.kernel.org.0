Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF27194B0
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 23:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfEIVfQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 17:35:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfEIVfP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 9 May 2019 17:35:15 -0400
Subject: Re: [GIT PULL] cgroup changes for v5.2-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557437714;
        bh=fbvGp1O/NrVth7VQNBezCWE6xsmE3bsEJsgNrQSf8gM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ldOq1tJujkL5T2sO2Pek6IDJm4dkU3Moto48MsN2NWYYd3/XcUloqPJfsz9hqp44A
         uW4TZEPHMigHCu3dSAGhOCLuWmxzQ9jHGxxA2zpIO/zPRuQDfItaawFFypBFEScNXk
         t6vuu++q9h45bypW6gb27jpndxui1HyhiD0OUn+Y=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20190509173642.GA374014@devbig004.ftw2.facebook.com>
References: <20190509173642.GA374014@devbig004.ftw2.facebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20190509173642.GA374014@devbig004.ftw2.facebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2
X-PR-Tracked-Commit-Id: f2b31bb598248c04721cb8485e6091a9feb045ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abde77eb5c66b2f98539c4644b54f34b7e179e6b
Message-Id: <155743771473.19196.4472489485491678704.pr-tracker-bot@kernel.org>
Date:   Thu, 09 May 2019 21:35:14 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Roman Gushchin <guro@fb.com>, Oleg Nesterov <oleg@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 9 May 2019 10:36:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abde77eb5c66b2f98539c4644b54f34b7e179e6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
