Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA668085B
	for <lists+cgroups@lfdr.de>; Mon, 30 Jan 2023 10:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbjA3JTX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 Jan 2023 04:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbjA3JTW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 Jan 2023 04:19:22 -0500
X-Greylist: delayed 719 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 01:19:21 PST
Received: from chinatelecom.cn (prt-mail.chinatelecom.cn [42.123.76.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B199E1703;
        Mon, 30 Jan 2023 01:19:21 -0800 (PST)
HMM_SOURCE_IP: 172.18.0.188:33308.583463876
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [172.18.0.188])
        by chinatelecom.cn (HERMES) with SMTP id DEF1B2800E5;
        Mon, 30 Jan 2023 16:58:29 +0800 (CST)
X-189-SAVE-TO-SEND: +liuq131@chinatelecom.cn
Received: from  ([36.111.64.85])
        by app0023 with ESMTP id df958312aad04f708bd79543179997c0 for tj@kernel.org;
        Mon, 30 Jan 2023 16:58:38 CST
X-Transaction-ID: df958312aad04f708bd79543179997c0
X-Real-From: liuq131@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Sender: liuq131@chinatelecom.cn
From:   liuq <liuq131@chinatelecom.cn>
To:     tj@kernel.org
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuq <liuq131@chinatelecom.cn>
Subject: [PATCH] cgroup: /proc/cgroups output alignment
Date:   Mon, 30 Jan 2023 16:58:18 +0800
Message-Id: <20230130085818.7847-1-liuq131@chinatelecom.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

/proc/cgroups output alignment for easy read

Signed-off-by: liuq <liuq131@chinatelecom.cn>
---
 kernel/cgroup/cgroup-v1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 52bb5a74a23b..ff82d61ae76f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -670,14 +670,14 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	struct cgroup_subsys *ss;
 	int i;
 
-	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
+	seq_puts(m, "#subsys_name        hierarchy     num_cgroups   enabled\n");
 	/*
 	 * Grab the subsystems state racily. No need to add avenue to
 	 * cgroup_mutex contention.
 	 */
 
 	for_each_subsys(ss, i)
-		seq_printf(m, "%s\t%d\t%d\t%d\n",
+		seq_printf(m, "%-20s%-14d%-14d%-14d\n",
 			   ss->legacy_name, ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
-- 
2.27.0

