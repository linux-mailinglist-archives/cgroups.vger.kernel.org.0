Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC928E913
	for <lists+cgroups@lfdr.de>; Thu, 15 Oct 2020 01:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgJNXCP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Oct 2020 19:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgJNXCN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 14 Oct 2020 19:02:13 -0400
Subject: Re: [GIT PULL] cgroup changes for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602716532;
        bh=2nxBPtYac7uucAdtkiu+QNJuECqVhe/RG3bQmOI5zEg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=0KekNbbFqESC0u97wkiAXGPSSwpWY7pHPKYp4DuYS5HvBi1Qcd3a/9XwyDA563+lI
         uwoT37CxY5GFG2TPYy963SD3NDvfwbxfygo82WXk6F6uwHBntgJUOiVJ81qwHHzlZ2
         GaSNYZOruw61ozEfpFw+2MbGgWeGJLyTPoYtQIeI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013140703.GA3845@mtj.thefacebook.com>
References: <20201013140703.GA3845@mtj.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013140703.GA3845@mtj.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.10
X-PR-Tracked-Commit-Id: 65026da59cda16baf6c3e98b74ec439f366e468f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f6c6d0891b472bbda70dfcc51fbb3147b6f54a0
Message-Id: <160271653246.18101.14377599341492008109.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 23:02:12 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 10:07:03 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f6c6d0891b472bbda70dfcc51fbb3147b6f54a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
