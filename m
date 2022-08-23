Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B0259DE58
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355514AbiHWKxL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 06:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356125AbiHWKtY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 06:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E078E868A7
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 02:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E55260F50
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 09:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA80C43470;
        Tue, 23 Aug 2022 09:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661245950;
        bh=LY81cFa6Hp4+F4iWQfiCKjYWO2rDP4Jd5dOawMq0Nwc=;
        h=From:To:Cc:Subject:Date:From;
        b=O1Nt4fZnBO7pCWJ/0YHn8T1JzK6MWOqu5yTXEIaBYiqT0dttiA3Qqc18OeDWBBfUO
         C51XPExzytdanQidC5odOytcYLreYfrUtJ4eNZINIiccECXDVD1K/Bln8WjKiCZL9D
         cZQoXlSi84L3WUku3WM5PHKtTEhAYSEOf5nXgVYWMb1Am7+XVKstDO5nIiDVqZm0IJ
         Yk9kQx80VP3sxwz2ShXwXSIPJKbkVe4PMLhRnp3hILbIN3uwwXL+1ovtHIoCgLKEll
         2J5nA1cuwS0H6Ce3xpePezQ0R2NJL/b85HlQUf8tGruXaUy+cFMQVoKILOsjSdnz/v
         MusWPaylvnNdw==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] cgroup: simplify cleanup in cgroup_css_set_fork()
Date:   Tue, 23 Aug 2022 11:11:47 +0200
Message-Id: <20220823091147.846082-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=brauner@kernel.org; h=from:subject; bh=LY81cFa6Hp4+F4iWQfiCKjYWO2rDP4Jd5dOawMq0Nwc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSSzzLzQP32L86RLDx4I+fmUX7394sfmqUvezvyR9Ozy5XSb +feKbnaUsjCIcTHIiimyOLSbhMst56nYbJSpATOHlQlkCAMXpwBMZPZDhv8uX97fPepWzy6w6yvPqf lsravWppnIh4Tt1+bh0OAskRZh+Mk471n6/nVC4bxP9qcsVknOK/1pe+5I/inp591rrxxZk8QPAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The call that initializes kargs->cset is find_css_set() and it is the
last call in cgroup_css_set_fork(). If find_css_set() fails kargs->cset
is NULL and we go to the cleanup path where we check that kargs->cset is
non-NULL and if it is we call put_css_set(kargs->cset). But it'll always
be NULL so put_css_set(kargs->cset) is never hit. Remove it.

Fixes: ef2c41cf38a7 ("clone3: allow spawning processes into cgroups")
Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 kernel/cgroup/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ffaccd6373f1..2ba516205057 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6247,8 +6247,6 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	if (dst_cgrp)
 		cgroup_put(dst_cgrp);
 	put_css_set(cset);
-	if (kargs->cset)
-		put_css_set(kargs->cset);
 	return ret;
 }
 

base-commit: 1c23f9e627a7b412978b4e852793c5e3c3efc555
-- 
2.34.1

