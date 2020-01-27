Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B839C14ACC4
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2020 00:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgA0XzF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Jan 2020 18:55:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727453AbgA0XzF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 27 Jan 2020 18:55:05 -0500
Subject: Re: [GIT PULL] cgroup changes for v5.6-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580169304;
        bh=3SdWewBVSvuzKWiEBla4as+SFpY0eD1WuP00fFQYtUI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mFuWS+WCkneVMbDiNrDHkPoU7x2RP6ptgT3kdguTPMzvlPVXv/xcR6VQM9r5RC2+I
         uq8YpnulaUgJtsthyZQC9hJ8x5rjy4E5Ep6GEcHB3boEc3SI0TKyZsEMskwenWnCeK
         HlfhOsutCv9S0JUgJy+QRaMoeWsMxGLgb5XmAJWQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200127214749.GC180576@mtj.thefacebook.com>
References: <20200127214749.GC180576@mtj.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200127214749.GC180576@mtj.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6
X-PR-Tracked-Commit-Id: 9ea37e24d4a95dd934a0600d65caa25e409705bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03aa8c8cfaec1aab6b1ea7fde656bbc893f6cff8
Message-Id: <158016930470.17044.11355481776759878357.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Jan 2020 23:55:04 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 27 Jan 2020 16:47:49 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03aa8c8cfaec1aab6b1ea7fde656bbc893f6cff8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
