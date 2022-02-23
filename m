Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A724C05CD
	for <lists+cgroups@lfdr.de>; Wed, 23 Feb 2022 01:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiBWARl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Feb 2022 19:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiBWARk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Feb 2022 19:17:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9E4D251;
        Tue, 22 Feb 2022 16:17:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1657F61295;
        Wed, 23 Feb 2022 00:17:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 787CAC340E8;
        Wed, 23 Feb 2022 00:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645575432;
        bh=8wzu0JREd+WI4OEqlUPmmFcnJbwpU6nBYy8pt0Im36I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XGXgcvFsLHeSwIkky++uILk3vpYi83Jm4PAX8fZJVMrFe486An/DUcDHB/ryVfzkF
         wX3zeBli8eswc6PL2dtr3xEo432f3fzXwUiGcweCJLDZNKSnIeZhSklNFT+qSDhVPj
         sC/j+ffkrW0xWxsCboVLYoFZRJU7KWQYO4z6lV4P7UMexnKwLHzw+m2lGXal08YSPG
         PN6nBOHWJenfx2mTLce39ZnDjwvKNO9wtsw4otmsMzxaGgK2qvBeFWAemFAzyuWMgG
         hqBHAZqD0IU47qlqgq9YjNvUUjCC3bPCQGGKkG3VcJHFC8E1gpP0EFzeFcPT9Z0lYc
         9pvg7LdhBs2lQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FD1DE73590;
        Wed, 23 Feb 2022 00:17:12 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhVcqpUHepfxgL88@slm.duckdns.org>
References: <YhVcqpUHepfxgL88@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhVcqpUHepfxgL88@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17-fixes
X-PR-Tracked-Commit-Id: c70cd039f1d779126347a896a58876782dcc5284
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c1ee569660d4a205dced9cb4d0306b907fb7599
Message-Id: <164557543238.4632.8759932396758171778.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Feb 2022 00:17:12 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Tue, 22 Feb 2022 11:59:06 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.17-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c1ee569660d4a205dced9cb4d0306b907fb7599

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
