Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54283E501D
	for <lists+cgroups@lfdr.de>; Tue, 10 Aug 2021 01:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhHIXu1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Aug 2021 19:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhHIXu0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Aug 2021 19:50:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C6C1D60F55;
        Mon,  9 Aug 2021 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628553005;
        bh=EHOL9A1aBI5KIa5FdaEjjBEzOjXUoNnELHudAH9K6dI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=irL+MMhIn8yEpZMmkx4jBN1B7HCT5QPC6Q5Nf6L38zNLrvTXfk5ZpbJ2fqt1zY2MY
         UebCS/Oz5+/JicCecJgJfM9CHWp2EF+PJQ65xUPa7XC0q/9bV1t0gz5mYVJxKXtERc
         6L7xDJtaIX0nYQB+a5VYRnt5KZuoyU7Iw6sGcWNIibzf48Ac9GtBfbGVwvSoUbH9iW
         3saCKsQTOA6gR8nlvm+5EzWQNAqB5ckuwOdl6cb6/ImxNH2HZa/mgeprY02HiNp9tE
         HPvCRZKpXjsJDCHFoGXf5FepFN4LdhBqS9TJ/x03LjMwYyad98RDZQMnFm7jKxai2I
         JIUSWDsJqd4JA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B0EDF609B8;
        Mon,  9 Aug 2021 23:50:05 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.14-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YRGz4nmDZNhsKSr1@mtj.duckdns.org>
References: <YRGz4nmDZNhsKSr1@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YRGz4nmDZNhsKSr1@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14-fixes
X-PR-Tracked-Commit-Id: c3df5fb57fe8756d67fd56ed29da65cdfde839f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9a73fa375d58fee5262dd16473c8e7522bdf44de
Message-Id: <162855300565.3012.18118515429703452059.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Aug 2021 23:50:05 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 9 Aug 2021 13:01:54 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.14-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9a73fa375d58fee5262dd16473c8e7522bdf44de

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
