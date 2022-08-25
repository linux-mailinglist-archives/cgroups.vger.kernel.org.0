Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351775A1867
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 20:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243100AbiHYSKI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 14:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243147AbiHYSKH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 14:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D080F8A7DE;
        Thu, 25 Aug 2022 11:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A8D861CFF;
        Thu, 25 Aug 2022 18:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDE70C43470;
        Thu, 25 Aug 2022 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661451003;
        bh=ZVR5xrFNODgOGtlOwF7CVvqTORNDv05nmbMAui53Pbg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O2duMY3zJ3OKgTe2104EpV5xWJ4WJCzoV2JvQMI7874wNKC4BQXyPEBiaX0qvVjOg
         P3xzkUP4HsN++pleDsallKIbUT6QmoYIMo/Wiq4OdK9umcJ+EMer81TRWuOpqc0+i+
         /xINj/yuafUo6WtLzcI7tJbP97zDg6x7nJX8cCVM5AMKZlSRXJPkzj+WQ/1RGQySPp
         TzMPbZTSOz0wTXknhzeFJQEHhdX3AhXYKjbHkO9BDi4IcMI/HRauC4cXiH5VmlLKWk
         o3neU4xnWZHBbeCWoONckHoHVIKa+GArP4J7SB1eJUVvl/tFpB0S7ekhvDpjHglBUR
         nzlgK2Ks6Z3lA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A58A7C4166E;
        Thu, 25 Aug 2022 18:10:03 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup fixes #2 for v6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Ywe0v0YWJSVAs5FT@slm.duckdns.org>
References: <Ywe0v0YWJSVAs5FT@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Ywe0v0YWJSVAs5FT@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc2-fixes-2
X-PR-Tracked-Commit-Id: 43626dade36fa74d3329046f4ae2d7fdefe401c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f5c20055a640b3758ece75dcaa6ac974fcae26d
Message-Id: <166145100367.12987.17556677305087800210.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Aug 2022 18:10:03 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The pull request you sent on Thu, 25 Aug 2022 07:43:27 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.0-rc2-fixes-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f5c20055a640b3758ece75dcaa6ac974fcae26d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
