Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DF05FA397
	for <lists+cgroups@lfdr.de>; Mon, 10 Oct 2022 20:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiJJSsJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 14:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJJSsD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 14:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFA3753A7;
        Mon, 10 Oct 2022 11:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EAD3960DF3;
        Mon, 10 Oct 2022 18:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5156DC433D6;
        Mon, 10 Oct 2022 18:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665427681;
        bh=/Py6ESRtICN91Jb9M97//qpI/8ZRofKXGr3GK+ybBK4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KgMIsaWKihVaygu59Fl8W6KqgkCm5kIe7mc0+KsvGmFUhnioNujFryGlK8EQZJ9W1
         7lct/dtjXaN5BFsLYcMWE9KXf0id4jfanCRkhgYFXV/ijtdzjgY+ozTiroh04tHEf9
         dHpxQ5L6QtH/1ypnrkxfIBbSHV1t+/H7fgbxWuvBSZhCmXK1TRxnw4yF1vyJ4YuCj3
         bH6LrC1qqNAfrGq7B212SuKh0Ac0xCjkSe6bfcKPv3f7YgvxQCIHZitr8xia3JwEIc
         PMcTOcReb9/cf4+wu93ru/3YddHyBpaQZuUxyiqG/7SUHxSn76GN0HPv9W+v7OH/Lm
         Tyr6OPszzXQ4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3FEB4E4D022;
        Mon, 10 Oct 2022 18:48:01 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzsmLRxPvYQlwtZo@slm.duckdns.org>
References: <YzsmLRxPvYQlwtZo@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzsmLRxPvYQlwtZo@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.1
X-PR-Tracked-Commit-Id: 8619e94d3be376bb5e8f20988c0e6e3309d2b09a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adf4bfc4a9ab86be0b72fa9cadc9e7ab6ad15dfe
Message-Id: <166542768125.29715.10610347781123624678.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 18:48:01 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 08:13:01 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adf4bfc4a9ab86be0b72fa9cadc9e7ab6ad15dfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
