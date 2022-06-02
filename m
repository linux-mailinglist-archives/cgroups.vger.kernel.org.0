Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD43453BCA4
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 18:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbiFBQft (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 12:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbiFBQfs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 12:35:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF42B12D7;
        Thu,  2 Jun 2022 09:35:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gd1so5404810pjb.2;
        Thu, 02 Jun 2022 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=NPlK307c48MdlGmg7luqnrkmG504nwebNc0iVQuTMyY=;
        b=R45ge7K/GujP+0NWTnSdk8mJOV4UMKO7d6UUPo6iz8UstLYz3d8u2YLlad32RkzkjU
         j2mu8e54JF3vFiaSWeLeSKE0h68IkHwmtS8nySJ03CtYeH5XO6ICnj38kr6MLKKPvca+
         lL4PbU6Viq2oVeGX5PPkuP2iRmWdmGwYApAdKj6GDJbCPLZ6FxCdFFj1CtWjJhkL/oja
         N6AURuaiOph5XVI9tXu4GbDWKgJvh6z3Gk1p7+BrORp1hBzb5Zf4yj60nhkKYLApv6U7
         PGvdWAzM2zm0/rNgPd/3iLxHedl9TQnp44ExUZVpRHBVsZzpVqJSIGXVSBm454y6fhxc
         pAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NPlK307c48MdlGmg7luqnrkmG504nwebNc0iVQuTMyY=;
        b=akceX80+8MAZUc+a28WcMStIDLq4k8+cPWCq/NBlaDTaVzBpWyWIgi29JdGC3nlP8W
         eibQaz2c0BDCJWxhtNEhhZAfEXXwsPVOndVCK3joABTwHBw5l8W8GRinps7zW4Oggv+q
         fYl7CgyZY1eYhmWgpE+j395fDLTTPPEDasUrMno18Vv2k7xwqK1AuAv63KX7cVsjmsJp
         OEWcPDP+guOQKBm5YhAERPbOQHb4S473nwbK9/Z+0++LqnwoQh+4TSkRDTK7xaa8rXPO
         21j5xz2nW77jrdBMPGw4SKws7+5Nb6fiIUQRBXRAmwBzUWcBzflrn/fxmal1TxU65tZF
         vsIw==
X-Gm-Message-State: AOAM53075XvzI+bE1MhK4cnHXjCpCDOXE09BsxkcZGQq2FeUcb8Vrgoy
        TugETIabgbxsm0qvfqjfUUQ=
X-Google-Smtp-Source: ABdhPJzviwECzgv7IfyBv3nsLhdM05WbfKVPsoMlqMaPOsr5m9LClLIefzbFpdob8MDyHe3Q0Pti7A==
X-Received: by 2002:a17:902:c402:b0:163:fa50:b345 with SMTP id k2-20020a170902c40200b00163fa50b345mr5798902plk.94.1654187747663;
        Thu, 02 Jun 2022 09:35:47 -0700 (PDT)
Received: from ssy-OptiPlex-7050.mioffice.cn ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902d59100b0016242b71e9fsm3715190plh.158.2022.06.02.09.35.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jun 2022 09:35:47 -0700 (PDT)
From:   shisiyuan <shisiyuan19870131@gmail.com>
X-Google-Original-From: shisiyuan <shisiyuan@xiaomi.com>
To:     tj@kernel.org, hannes@cmpxchg.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shisiyuan <shisiyuan@xiaomi.com>
Subject: [PATCH] cgroup: handle cset multiidentity issue when migration
Date:   Fri,  3 Jun 2022 00:34:48 +0800
Message-Id: <1654187688-27411-1-git-send-email-shisiyuan@xiaomi.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Bug code flow:
cset X's initial refcount is 1.
1. cgroup_attach_task()
2. [For thread1]
   cgroup_migrate_add_src()
   [For thread2]
   cgroup_migrate_add_src()
     cset X is thread2's src_cset , ref->2,
     and its mg_preload_node is added to
     mgctx->preloaded_src_csets.
3. cgroup_migrate_prepare_dst()
   [For thread1]
   find_css_set()
     cset X is thread1's dst_cset, ref->3
   put_css_set()
     ref->2 because cset X's mg_preload_node is not
     empty(already in mgctx->preloaded_src_csets).
   [For thread2]
   find_css_cset()
     cset X is also thread2's dst_cset, ref->3
     then drop src_cset, ref->1
[cgroup_free] ref->0
4. cgroup_migrate_execute
   [For thread1]
   ref -> 0xc0000000(UAF)
The issue occurs because cset X's refcount should
not be substraced by one in this case. So mark a flag
'multiidentity' to this cset and call put_css_set()
one more time if 'multiidentity' marked in cleanup
progress.

Signed-off-by: shisiyuan <shisiyuan@xiaomi.com>
---
 include/linux/cgroup-defs.h |  5 +++++
 kernel/cgroup/cgroup.c      | 23 +++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8c19303..c9f2237 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -280,6 +280,11 @@ struct css_set {
 
 	/* For RCU-protected deletion */
 	struct rcu_head rcu_head;
+
+	/* Indicate if the css_set is the src_cset of one thread and
+	 * the dst_cset of anonther thread during migration process.
+	 */
+	bool multiidentity;
 };
 
 struct cgroup_base_stat {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e914646..cfdd12e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2593,6 +2593,10 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
 		cset->mg_dst_cgrp = NULL;
 		cset->mg_dst_cset = NULL;
 		list_del_init(&cset->mg_preload_node);
+		if (cset->multiidentity == true) {
+			cset->multiidentity = false;
+			put_css_set_locked(cset);
+		}
 		put_css_set_locked(cset);
 	}
 
@@ -2648,6 +2652,18 @@ void cgroup_migrate_add_src(struct css_set *src_cset,
 	list_add_tail(&src_cset->mg_preload_node, &mgctx->preloaded_src_csets);
 }
 
+static bool list_contains(struct list_head *node, struct list_head *head)
+{
+	struct list_head *tmp;
+
+	list_for_each(tmp, head) {
+		if (tmp == node)
+			return true;
+	}
+
+	return false;
+}
+
 /**
  * cgroup_migrate_prepare_dst - prepare destination css_sets for migration
  * @mgctx: migration context
@@ -2700,6 +2716,13 @@ int cgroup_migrate_prepare_dst(struct cgroup_mgctx *mgctx)
 		if (list_empty(&dst_cset->mg_preload_node))
 			list_add_tail(&dst_cset->mg_preload_node,
 				      &mgctx->preloaded_dst_csets);
+		/* If dst_cset is already in mgctx->preloaded_src_csets,
+		 * it means the dst_cset has multi identities. Keep it
+		 * in mgctx->preloaded_src_csets, and mark it.
+		 */
+		else if (list_contains(&dst_cset->mg_preload_node,
+					&mgctx->preloaded_src_csets))
+			dst_cset->multiidentity = true;
 		else
 			put_css_set(dst_cset);
 
-- 
2.7.4

