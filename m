Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9794BE1B0
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 18:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378961AbiBUPRP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 10:17:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242537AbiBUPRP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 10:17:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E9A1C121
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 07:16:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D050AB81215
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 15:16:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CDEC340E9;
        Mon, 21 Feb 2022 15:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645456609;
        bh=7ju0dRgH/yYPJtn4KOG60za9bLFOf4tZUIskehK0LyI=;
        h=From:To:Cc:Subject:Date:From;
        b=C4JlmNoX87DCg4yP2xOZVFwBCLHDl95bGvlr++KOG3/OG56RRxg0dPXqYJryh2fF1
         oes715dVRKo4OUXGVfMtq3QQsswPlV54cuhEF5awvdSH6AIIaBOSSxvUBskVrZUz7h
         W820oYXs+87vrrLFjiJ7NUXDt0xFwhapunn35UhwCpGeJOQbluHwd7ISenQO9OKqZl
         I4w/BhFuSGsjzNv5BpFU1PFkHil4UzxUCH7IbVsOKeKoDVdUjBMXwZmlKyaUVyb890
         Ycpo1dp0QCJICQOFusySwOjs4eUloM8rUVokO4v1xX72osvV+KSHmAEWgFlIpDnqi0
         v+zI3ct3z3Umg==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: [PATCH] cgroup: clarify cgroup_css_set_fork()
Date:   Mon, 21 Feb 2022 16:16:39 +0100
Message-Id: <20220221151639.3828143-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; h=from:subject; bh=7ju0dRgH/yYPJtn4KOG60za9bLFOf4tZUIskehK0LyI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQJr3J1W2Xaf+XqhDfMExM5e3z++i9fXmNudUvsyFr/CdcW 9T3g6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIxj1Ghjm1Lw7xvfkelLFcREWAKy 1v2S7XCZctjSWe1zxTCtus+53hf8DnuGRmQ79qjU27F/74mXrY6JdUwzF9A3Mbo5Q1spKVzAA=
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

With recent fixes for the permission checking when moving a task into a cgroup
using a file descriptor to a cgroup's cgroup.procs file and calling write() it
seems a good idea to clarify CLONE_INTO_CGROUP permission checking with a
comment.

Cc: Tejun Heo <tj@kernel.org>
Cc: <cgroups@vger.kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/cgroup/cgroup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9d05c3ca2d5e..0f8bd120be17 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6166,6 +6166,18 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	if (ret)
 		goto err;
 
+	/*
+	 * Note, spawning a task directly into a cgroup works by passing a file
+	 * descriptor to the target cgroup directory. This can even be an
+	 * O_PATH file descriptor. But it can never be a cgroup.procs file
+	 * descriptor. This was done on purpose so spawning into a cgroup could
+	 * be conceptualized as an atomic
+	 * fd = openat(dfd_cgroup, "cgroup.procs", ...);
+	 * write(fd, <child-pid>, ...);
+	 * sequence, i.e. it's a shorthand for the caller opening and writing
+	 * cgroup.procs of the cgroup indicated by @dfd_cgroup. This allows
+	 * us to always use the caller's credentials.
+	 */
 	ret = cgroup_attach_permissions(cset->dfl_cgrp, dst_cgrp, sb,
 					!(kargs->flags & CLONE_THREAD),
 					current->nsproxy->cgroup_ns);

base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.32.0

