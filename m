Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2858D1E4CDE
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2020 20:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388404AbgE0SKE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 May 2020 14:10:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389335AbgE0SKD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 27 May 2020 14:10:03 -0400
Subject: Re: [GIT PULL] cgroup fixes for v5.7-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590603003;
        bh=vojHFnMMz8hyLfzKK6LRKHehXCIZSleUECj1iH2E5mo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Kpj0RccbiVhD3f/4/ZGk5DdE6tEaAJsSC2SlbbbjSxsj3kaN5amVc1QtEyNm+Y88h
         /wOS+5tBELc1enQL7nrAPJjYCNbH7sLEvidQYJCOwYaWkQNfXJt49ndi0QTpLC2n8c
         qVDsdL/UI50FeZ7DJ2CBo450FbSyOxc8EAsFU5eg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200527142119.GJ83516@mtj.thefacebook.com>
References: <20200527142119.GJ83516@mtj.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200527142119.GJ83516@mtj.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.7-fixes
X-PR-Tracked-Commit-Id: eec8fd0277e37cf447b88c6be181e81df867bcf1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3301f6ae2d4cb396ae0c103329a5680d14f7a5c6
Message-Id: <159060300337.13466.2319321521651445048.pr-tracker-bot@kernel.org>
Date:   Wed, 27 May 2020 18:10:03 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Wed, 27 May 2020 10:21:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3301f6ae2d4cb396ae0c103329a5680d14f7a5c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
