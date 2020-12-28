Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40A02E6C2D
	for <lists+cgroups@lfdr.de>; Tue, 29 Dec 2020 00:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgL1Wzr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Dec 2020 17:55:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbgL1TtA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 28 Dec 2020 14:49:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C937F204EF;
        Mon, 28 Dec 2020 19:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609184899;
        bh=yd/ZS0ejJylDvYi3mJmgufdq6c0/tnkh+6k5buIhhs8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=skNfMl/zgqc+PDdZ9sjqmGyBc+ebgOvZG10vEq1cRqZKjam9Qov3Adw3eaTq/PmaX
         4vQySezeQgRJTWdD787YA0L7gXDsPgD54fm6sY/OZlbbY/czSyeXyLzQ5RtxEkrtRe
         d9O7i1fitrFJ144ZvT214+TTsO0fzmAWzcevZGiQP2I1q0uqfVHjI+OwQ8n/Ov1DuP
         aEIbRhqZks4DaZw4nfftaR8EZWLVgb4LpGNZmafP+ZdwtFLHJOteyQqyZa/l813pfR
         KvC2x45HEkXdrhytIvIeFOD1/vamJ6XcikBP4CNhufqnje58aUQepdhi6BaVhK9A5l
         4m4hbVIHjJVcg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id B636D60108;
        Mon, 28 Dec 2020 19:48:19 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X+oZuAwO1/GcBeqy@mtj.duckdns.org>
References: <X+oZuAwO1/GcBeqy@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X+oZuAwO1/GcBeqy@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.11
X-PR-Tracked-Commit-Id: 2d18e54dd8662442ef5898c6bdadeaf90b3cebbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91afe604c15405a7b15d1464f224372cd82d3e2c
Message-Id: <160918489967.31247.15729691714983862490.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Dec 2020 19:48:19 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 28 Dec 2020 12:45:28 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91afe604c15405a7b15d1464f224372cd82d3e2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
