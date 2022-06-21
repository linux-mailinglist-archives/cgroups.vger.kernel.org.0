Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBB9552E30
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 11:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348190AbiFUJYX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 05:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347838AbiFUJYR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 05:24:17 -0400
Received: from azure-sdnproxy-1.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0CDA521E3F;
        Tue, 21 Jun 2022 02:24:10 -0700 (PDT)
Received: from fedora33.wangsu.com (unknown [59.61.78.232])
        by app2 (Coremail) with SMTP id SyJltACXnuIyjrFip5sGAA--.10560S2;
        Tue, 21 Jun 2022 17:24:06 +0800 (CST)
From:   Lin Feng <linf@wangsu.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linf@wangsu.com
Subject: [PATCH] cgroup.c: remove redundant check for mixable cgroup in cgroup_migrate_vet_dst
Date:   Tue, 21 Jun 2022 17:23:58 +0800
Message-Id: <20220621092358.223594-1-linf@wangsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: SyJltACXnuIyjrFip5sGAA--.10560S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy8KrWfGFWfZrykAr13urg_yoW8JFW7pr
        4DArW2y3yFkF1Dtw40q3yqgFWFkw40qr1Utas5Ww1UZw17Jw1aqrna9a4UAr15AFZ7Kr1f
        JFWYyrWjkw4xtaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
        0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
        x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
        z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
        xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r1j6r4UMcIj6x8ErcxFaVAv
        8VW8GwAv7VCY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2
        IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF04k20xvY
        0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        fUzc_-DUUUU
X-CM-SenderInfo: holqwq5zdqw23xof0z/
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We have:
int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp)
{
...
	/* mixables don't care */
	if (cgroup_is_mixable(dst_cgrp))
		return 0;

	/*
	 * If @dst_cgrp is already or can become a thread root or is
	 * threaded, it doesn't matter.
	 */
	if (cgroup_can_be_thread_root(dst_cgrp) || cgroup_is_threaded(dst_cgrp))
		return 0;
...
}

but in fact the entry of cgroup_can_be_thread_root() covers case that
checking cgroup_is_mixable() as following:
static bool cgroup_can_be_thread_root(struct cgroup *cgrp)
{
        /* mixables don't care */
        if (cgroup_is_mixable(cgrp))
                return true;
...
}

so explicitly checking in cgroup_migrate_vet_dst is unnecessary.

Signed-off-by: Lin Feng <linf@wangsu.com>
---
 kernel/cgroup/cgroup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..ad4aa08ec988 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2570,10 +2570,6 @@ int cgroup_migrate_vet_dst(struct cgroup *dst_cgrp)
 	if (!cgroup_is_valid_domain(dst_cgrp->dom_cgrp))
 		return -EOPNOTSUPP;
 
-	/* mixables don't care */
-	if (cgroup_is_mixable(dst_cgrp))
-		return 0;
-
 	/*
 	 * If @dst_cgrp is already or can become a thread root or is
 	 * threaded, it doesn't matter.
-- 
2.31.1

