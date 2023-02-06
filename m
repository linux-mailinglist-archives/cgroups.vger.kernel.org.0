Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A268C94C
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 23:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBFWXA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 17:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjBFWW6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 17:22:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3942311E9C;
        Mon,  6 Feb 2023 14:22:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAB186101A;
        Mon,  6 Feb 2023 22:22:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 357E5C433D2;
        Mon,  6 Feb 2023 22:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675722177;
        bh=77eH0dObGsmGIQ6H5Q/e/w+lwpEpf0OEqQVQWCaEWuw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dicnAoPT6MkxCXv2eo5ewyQnaR8dWQZJNxmeFWE6zSCEbeUX2FVIixj7K579AK9DH
         qP80IcHi9lY8D3Yhcax0qEMh1JmvOPHTkLi6Zx2tdYHU4RTuxEK55aijc+IocnXJP9
         0ROkmSrZK7oUTZNbbTIMqvc5USR6knwPE+XZIvX5ojUHxMjbKZ7R9Nr4eGtkTeTmUD
         mWt5rwxMgN+0Ht0CNYkjXgP/7ki2zyR9BSuUoAslncCMy51JAKksiZhRLU5eNnLGxG
         wBopdj4GRfOGwX9o4aZQnoVFmnai11D0EKF4nCKk42IZnSiernvMZIAARLhkDQk6Ro
         Nz6KsbVZ+d9dA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22E39E55EFB;
        Mon,  6 Feb 2023 22:22:57 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes for v6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y+F149pNVNcMJQIn@slm.duckdns.org>
References: <Y+F149pNVNcMJQIn@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y+F149pNVNcMJQIn@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2-rc7-fixes
X-PR-Tracked-Commit-Id: 7a2127e66a00e073db8d90f9aac308f4a8a64226
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a
Message-Id: <167572217713.7822.15849062504890125362.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Feb 2023 22:22:57 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Mon, 6 Feb 2023 11:49:23 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05ecb680708a1dbe6554d6fc17e5d9a8a7cb5e6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
