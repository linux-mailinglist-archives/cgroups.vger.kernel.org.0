Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB048B4D8
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 19:04:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbiAKSDt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 13:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344727AbiAKSDj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 13:03:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D396C061748;
        Tue, 11 Jan 2022 10:03:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1863B81CB7;
        Tue, 11 Jan 2022 18:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F903C36AEF;
        Tue, 11 Jan 2022 18:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641924216;
        bh=RIEvO+lu/c6byH6TbiqIk/TJbZa6trUs7uHuTuSBNCE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tKQAIRmDvWar8KwwqT3Zt/mK7WApvcBX/130EjGQUq7XAkUbLSdvaakyVIDsPS6rc
         oZKj2gg7mYQUAtDHmAgA2FOAeJjqX5Y0oDRB7JoWM2X4FRBeMo4xuAH5OCXf/7FerF
         NWO0TE7c3ndQqWnLzQvLPiyBke3jDrKcA5DUSz9xCwfJAWErFp7qdYnjTRuuDJu+Od
         GDnlW2jDvULAK2gP/P4hCZIkN+xzU4d7BBOn9FkhX0lw8eG51ki0eDzlA6CIgGwQAJ
         cfLUxTzv+bV8QKsvA5hEVnFgfZyaZgT6lTKdBSdKyV7+/Q4B+rXWQD/QiPO8ytEPC8
         qnpAtwksTz0Pw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E436F6078E;
        Tue, 11 Jan 2022 18:03:36 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.17-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ydxw+LLhEmi5B/Re@slm.duckdns.org>
References: <Ydxw+LLhEmi5B/Re@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ydxw+LLhEmi5B/Re@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17
X-PR-Tracked-Commit-Id: d4296faebd337e5f76c0fddb815de33d2b0ad118
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ea1ca66d3cc07b00241fcee82328f387359f32f5
Message-Id: <164192421656.4972.10327505878896077725.pr-tracker-bot@kernel.org>
Date:   Tue, 11 Jan 2022 18:03:36 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 10 Jan 2022 07:46:32 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ea1ca66d3cc07b00241fcee82328f387359f32f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
