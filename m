Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC55338F29C
	for <lists+cgroups@lfdr.de>; Mon, 24 May 2021 19:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhEXRzn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 May 2021 13:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233616AbhEXRzm (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 24 May 2021 13:55:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 74E8A613D2;
        Mon, 24 May 2021 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621878854;
        bh=LILkxj8USR+Zx8wc8LGa6rOtLihl/NC+O1pusxGj/WY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PVdX9xPQOfi8qbzP2z0mkbbl8P8f6RuY49oYEpX3WCBF+kyt0VpDUvmIxvFS3jah1
         6npF7vNVXlRH4OXPFdLherSbl3t5jSj2FaSUnLXtBeII+jc3rodqhZDC0GrRMzAIfR
         g2b74fw6WjMw5py4CbOT2A/i+eIBZZMeBy/WVWnMBVbkEdknGPr5Ha+cRyKVaaTbyx
         Sp0H8Kd7Jqv5PD4FKRUrO6PmBWGbUgFLUBXdM4ZlPTWAAYAHLAOKFMcIR6BWhsOyc5
         ErU2cVG5+SoFSdnJisVuEWY5e8FEDDgCvNa0gKQmUC196F8vwhgd/wlSSE45baausJ
         Zfxjt3oU4wD6Q==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 6029660A0B;
        Mon, 24 May 2021 17:54:14 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.13-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YKvlx7PZs6EplU1D@slm.duckdns.org>
References: <YKvlx7PZs6EplU1D@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YKvlx7PZs6EplU1D@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13-fixes
X-PR-Tracked-Commit-Id: 08b2b6fdf6b26032f025084ce2893924a0cdb4a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1434a3127887a7e708be5f4edd5e36d64d8622f8
Message-Id: <162187885432.20633.884131319559198358.pr-tracker-bot@kernel.org>
Date:   Mon, 24 May 2021 17:54:14 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 24 May 2021 13:43:35 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.13-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1434a3127887a7e708be5f4edd5e36d64d8622f8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
