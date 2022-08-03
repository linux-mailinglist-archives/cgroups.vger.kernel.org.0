Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733C35891BA
	for <lists+cgroups@lfdr.de>; Wed,  3 Aug 2022 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbiHCRtC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Aug 2022 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbiHCRtB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Aug 2022 13:49:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E347B87;
        Wed,  3 Aug 2022 10:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 875F5CE23E6;
        Wed,  3 Aug 2022 17:48:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7523C433C1;
        Wed,  3 Aug 2022 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659548935;
        bh=u9D3HXwYpkIOSgSomdJlMh6BP7cUaAJf9Ee/peFm6tg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oBY5P2UQbY2x3x+P2dsFYRV0Z8BGz80l6S9KuhDH4aIu2DNeIWR6sf3dJ2FdIbQcj
         D5juWFSvDhTwZiY4Fe12TBbeZETNHLlIUWwQLGzczMPwqCmL8howfoXu9+EeIqjWPv
         ETNFvg3MarJANJqumHAaUIXyxc+5QqALoDEsfokWCW3fqjezpWxKZ+090+K3FS+O+3
         G0XzOMz+dMM1Eb6NDlYKqHjfthLtf/PqjOMKitke2GntXqtYkNh5NEcoq//euBaKl+
         vumX1UvSZgkhMrfv0Iyz1g8wIqaumaT31Tky8XX8HXCn9VeA11c+mF0hyIZVy254ra
         +lMEVhL4x3GQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B18B2C43140;
        Wed,  3 Aug 2022 17:48:55 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v5.20-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YugH95n04DM6yRta@slm.duckdns.org>
References: <YugH95n04DM6yRta@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YugH95n04DM6yRta@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-5.20
X-PR-Tracked-Commit-Id: 265792d0dede9259f0ca56bb3efcc23eceee7d01
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6bb70f9ab80a11161252bf217993d2c40ea5eb2
Message-Id: <165954893571.32324.18329134908008598700.pr-tracker-bot@kernel.org>
Date:   Wed, 03 Aug 2022 17:48:55 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 1 Aug 2022 07:05:59 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6bb70f9ab80a11161252bf217993d2c40ea5eb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
