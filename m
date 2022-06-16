Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66C554DF42
	for <lists+cgroups@lfdr.de>; Thu, 16 Jun 2022 12:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiFPKjY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 16 Jun 2022 06:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiFPKjX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 16 Jun 2022 06:39:23 -0400
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net (zg8tmtyylji0my4xnjqunzqa.icoremail.net [162.243.164.74])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 27AB75B3EC;
        Thu, 16 Jun 2022 03:39:18 -0700 (PDT)
Received: from fedora33.wangsu.com (unknown [59.61.78.232])
        by app2 (Coremail) with SMTP id SyJltAAnHAgyCKtikEYEAA--.7274S2;
        Thu, 16 Jun 2022 18:38:49 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linf@wangsu.com
Subject: [PATCH] cgroup.c: add helper __cset_cgroup_from_root to cleanup duplicated codes
Date:   Thu, 16 Jun 2022 18:38:30 +0800
Message-Id: <20220616103830.197458-1-linf@wangsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: SyJltAAnHAgyCKtikEYEAA--.7274S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFykWw4fZFyfWrWkAF43Jrb_yoW8tF4fpF
        srArZ3tw4rW3W5Ww4Sq3y0va4Sgay8Xw17KrW7Zw4rAr1xArWYqF1xu34fXryYyasrG3W3
        KF4YkrWSgw1IqaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r4j6F4UMcIj6x8ErcxFaVAv
        8VW8GwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
        IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8twCF04k20xvY
        0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        fUFdb1DUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

No funtionality change, but save us some lines.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 kernel/cgroup/cgroup.c | 58 ++++++++++++++++++++----------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..a8a46eb66f21 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1376,6 +1376,31 @@ static void cgroup_destroy_root(struct cgroup_root *root)
 	cgroup_free_root(root);
 }
 
+static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
+					    struct cgroup_root *root)
+{
+	struct cgroup *res_cgroup = NULL;
+
+	if (cset == &init_css_set) {
+		res_cgroup = &root->cgrp;
+	} else if (root == &cgrp_dfl_root) {
+		res_cgroup = cset->dfl_cgrp;
+	} else {
+		struct cgrp_cset_link *link;
+
+		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
+			struct cgroup *c = link->cgrp;
+
+			if (c->root == root) {
+				res_cgroup = c;
+				break;
+			}
+		}
+	}
+
+	return res_cgroup;
+}
+
 /*
  * look up cgroup associated with current task's cgroup namespace on the
  * specified hierarchy
@@ -1391,22 +1416,8 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
 	rcu_read_lock();
 
 	cset = current->nsproxy->cgroup_ns->root_cset;
-	if (cset == &init_css_set) {
-		res = &root->cgrp;
-	} else if (root == &cgrp_dfl_root) {
-		res = cset->dfl_cgrp;
-	} else {
-		struct cgrp_cset_link *link;
-
-		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
-			struct cgroup *c = link->cgrp;
+	res = __cset_cgroup_from_root(cset, root);
 
-			if (c->root == root) {
-				res = c;
-				break;
-			}
-		}
-	}
 	rcu_read_unlock();
 
 	BUG_ON(!res);
@@ -1422,22 +1433,7 @@ static struct cgroup *cset_cgroup_from_root(struct css_set *cset,
 	lockdep_assert_held(&cgroup_mutex);
 	lockdep_assert_held(&css_set_lock);
 
-	if (cset == &init_css_set) {
-		res = &root->cgrp;
-	} else if (root == &cgrp_dfl_root) {
-		res = cset->dfl_cgrp;
-	} else {
-		struct cgrp_cset_link *link;
-
-		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
-			struct cgroup *c = link->cgrp;
-
-			if (c->root == root) {
-				res = c;
-				break;
-			}
-		}
-	}
+	res = __cset_cgroup_from_root(cset, root);
 
 	BUG_ON(!res);
 	return res;
-- 
2.31.1

