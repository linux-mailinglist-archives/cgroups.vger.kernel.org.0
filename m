Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9C07C7AE9
	for <lists+cgroups@lfdr.de>; Fri, 13 Oct 2023 02:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjJMAju (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Oct 2023 20:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjJMAjt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Oct 2023 20:39:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E070FC0;
        Thu, 12 Oct 2023 17:39:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86E5AC433C8;
        Fri, 13 Oct 2023 00:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697157587;
        bh=fR00E7rM2JZPTT8rudt1QCQfjBs9sW/dyC4aN4lXNB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PgVK9Q4m9rKIum2GeXRHTp3lXSRniTaKhs88MxokBgckQMFi2ebti/m7PPSVjON3o
         /Z13Dr1MB5J4RCYLA6k0OiDxbdWPQWkaD896kTGz9v9ZVWcswwX0I0431A97xtmvTL
         /fqjHTYFRYPyReRVpx5nliiMDblAFHztEwr1LhiL7SlPu2IptqYeoJmaAyPScrZAXZ
         m63rvGcGas4vMxr1SLyEfus7c1xCWHjg3jqHHwjDq0ZNs98uEvhi5fzhTCUpu3CIbY
         zTNpK6Kl9N1rp6p2OsW51zPN96taEXbwDkVXZ8NniLrvbnpnJiog4aRLieP8WjgV5d
         A57UUy22yPliA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DF35C595C3;
        Fri, 13 Oct 2023 00:39:47 +0000 (UTC)
Subject: Re: [GIT PULL] Cgroup fixes for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSh_Vf5whzHV-H1S@slm.duckdns.org>
References: <ZSh_Vf5whzHV-H1S@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSh_Vf5whzHV-H1S@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.6-rc5-fixes
X-PR-Tracked-Commit-Id: 13cc9ee8f8ed58e563294d87d74a62006be40f21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20f4757fa5ed2d9a7746d01b8950cfe04d593a0a
Message-Id: <169715758744.17241.6223034096344205530.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 00:39:47 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 12 Oct 2023 13:20:53 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.6-rc5-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20f4757fa5ed2d9a7746d01b8950cfe04d593a0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
