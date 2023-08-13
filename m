Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F238977899F
	for <lists+cgroups@lfdr.de>; Fri, 11 Aug 2023 11:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbjHKJUd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 05:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjHKJUc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 05:20:32 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id C385BC5;
        Fri, 11 Aug 2023 02:20:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id B570C605E83FB;
        Fri, 11 Aug 2023 17:20:29 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li kunyu <kunyu@nfschina.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?cgroup:=20cgroup:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20res?=
Date:   Sun, 13 Aug 2023 09:51:42 +0800
Message-Id: <20230813015142.3095-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

res is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index cdda2a147d6b..3a8802921bcb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1419,7 +1419,7 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
 static struct cgroup *
 current_cgns_cgroup_from_root(struct cgroup_root *root)
 {
-	struct cgroup *res = NULL;
+	struct cgroup *res;
 	struct css_set *cset;
 
 	lockdep_assert_held(&css_set_lock);
-- 
2.18.2

