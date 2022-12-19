Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5987B650AD3
	for <lists+cgroups@lfdr.de>; Mon, 19 Dec 2022 12:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiLSLl2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Dec 2022 06:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiLSLlY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Dec 2022 06:41:24 -0500
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16571D79
        for <cgroups@vger.kernel.org>; Mon, 19 Dec 2022 03:41:22 -0800 (PST)
Received: from [192.168.16.45] (helo=fisk.sw.ru)
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <nikolay.borisov@virtuozzo.com>)
        id 1p7EVs-00EvES-UU;
        Mon, 19 Dec 2022 12:40:57 +0100
From:   Nikolay Borisov <nikolay.borisov@virtuozzo.com>
To:     tj@kernel.org
Cc:     cgroups@vger.kernel.org, paul@paul-moore.com, kernel@openvz.org,
        Nikolay Borisov <nikolay.borisov@virtuozzo.com>
Subject: [PATCH 1/2] devcg: Move match_exception_partial before match_exception PSBM-144033
Date:   Mon, 19 Dec 2022 13:40:51 +0200
Message-Id: <20221219114052.1582992-2-nikolay.borisov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219114052.1582992-1-nikolay.borisov@virtuozzo.com>
References: <20221219114052.1582992-1-nikolay.borisov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This is required as the latter would call the former in upcoming
patches.

Signed-off-by: Nikolay Borisov <nikolay.borisov@virtuozzo.com>
---
 security/device_cgroup.c | 66 ++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/security/device_cgroup.c b/security/device_cgroup.c
index bef2b9285fb3..2d234e7c0c70 100644
--- a/security/device_cgroup.c
+++ b/security/device_cgroup.c
@@ -312,34 +312,45 @@ static int devcgroup_seq_show(struct seq_file *m, void *v)
 }
 
 /**
- * match_exception	- iterates the exception list trying to find a complete match
+ * match_exception_partial - iterates the exception list trying to find a partial match
  * @exceptions: list of exceptions
  * @type: device type (DEVCG_DEV_BLOCK or DEVCG_DEV_CHAR)
  * @major: device file major number, ~0 to match all
  * @minor: device file minor number, ~0 to match all
  * @access: permission mask (DEVCG_ACC_READ, DEVCG_ACC_WRITE, DEVCG_ACC_MKNOD)
  *
- * It is considered a complete match if an exception is found that will
- * contain the entire range of provided parameters.
+ * It is considered a partial match if an exception's range is found to
+ * contain *any* of the devices specified by provided parameters. This is
+ * used to make sure no extra access is being granted that is forbidden by
+ * any of the exception list.
  *
- * Return: true in case it matches an exception completely
+ * Return: true in case the provided range mat matches an exception completely
  */
-static bool match_exception(struct list_head *exceptions, short type,
-			    u32 major, u32 minor, short access)
+static bool match_exception_partial(struct list_head *exceptions, short type,
+				    u32 major, u32 minor, short access)
 {
 	struct dev_exception_item *ex;
 
-	list_for_each_entry_rcu(ex, exceptions, list) {
+	list_for_each_entry_rcu(ex, exceptions, list,
+				lockdep_is_held(&devcgroup_mutex)) {
 		if ((type & DEVCG_DEV_BLOCK) && !(ex->type & DEVCG_DEV_BLOCK))
 			continue;
 		if ((type & DEVCG_DEV_CHAR) && !(ex->type & DEVCG_DEV_CHAR))
 			continue;
-		if (ex->major != ~0 && ex->major != major)
+		/*
+		 * We must be sure that both the exception and the provided
+		 * range aren't masking all devices
+		 */
+		if (ex->major != ~0 && major != ~0 && ex->major != major)
 			continue;
-		if (ex->minor != ~0 && ex->minor != minor)
+		if (ex->minor != ~0 && minor != ~0 && ex->minor != minor)
 			continue;
-		/* provided access cannot have more than the exception rule */
-		if (access & (~ex->access))
+		/*
+		 * In order to make sure the provided range isn't matching
+		 * an exception, all its access bits shouldn't match the
+		 * exception's access bits
+		 */
+		if (!(access & ex->access))
 			continue;
 		return true;
 	}
@@ -347,45 +358,34 @@ static bool match_exception(struct list_head *exceptions, short type,
 }
 
 /**
- * match_exception_partial - iterates the exception list trying to find a partial match
+ * match_exception	- iterates the exception list trying to find a complete match
  * @exceptions: list of exceptions
  * @type: device type (DEVCG_DEV_BLOCK or DEVCG_DEV_CHAR)
  * @major: device file major number, ~0 to match all
  * @minor: device file minor number, ~0 to match all
  * @access: permission mask (DEVCG_ACC_READ, DEVCG_ACC_WRITE, DEVCG_ACC_MKNOD)
  *
- * It is considered a partial match if an exception's range is found to
- * contain *any* of the devices specified by provided parameters. This is
- * used to make sure no extra access is being granted that is forbidden by
- * any of the exception list.
+ * It is considered a complete match if an exception is found that will
+ * contain the entire range of provided parameters.
  *
- * Return: true in case the provided range mat matches an exception completely
+ * Return: true in case it matches an exception completely
  */
-static bool match_exception_partial(struct list_head *exceptions, short type,
-				    u32 major, u32 minor, short access)
+static bool match_exception(struct list_head *exceptions, short type,
+			    u32 major, u32 minor, short access)
 {
 	struct dev_exception_item *ex;
 
-	list_for_each_entry_rcu(ex, exceptions, list,
-				lockdep_is_held(&devcgroup_mutex)) {
+	list_for_each_entry_rcu(ex, exceptions, list) {
 		if ((type & DEVCG_DEV_BLOCK) && !(ex->type & DEVCG_DEV_BLOCK))
 			continue;
 		if ((type & DEVCG_DEV_CHAR) && !(ex->type & DEVCG_DEV_CHAR))
 			continue;
-		/*
-		 * We must be sure that both the exception and the provided
-		 * range aren't masking all devices
-		 */
-		if (ex->major != ~0 && major != ~0 && ex->major != major)
+		if (ex->major != ~0 && ex->major != major)
 			continue;
-		if (ex->minor != ~0 && minor != ~0 && ex->minor != minor)
+		if (ex->minor != ~0 && ex->minor != minor)
 			continue;
-		/*
-		 * In order to make sure the provided range isn't matching
-		 * an exception, all its access bits shouldn't match the
-		 * exception's access bits
-		 */
-		if (!(access & ex->access))
+		/* provided access cannot have more than the exception rule */
+		if (access & (~ex->access))
 			continue;
 		return true;
 	}
-- 
2.34.1

