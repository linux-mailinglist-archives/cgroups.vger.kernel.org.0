Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E623F9B6C
	for <lists+cgroups@lfdr.de>; Fri, 27 Aug 2021 17:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245459AbhH0PF1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 Aug 2021 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245446AbhH0PFS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 Aug 2021 11:05:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA8CC0613CF
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 08:04:29 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 2so5907691pfo.8
        for <cgroups@vger.kernel.org>; Fri, 27 Aug 2021 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAECcBr13A7/Y2OTRwW1tphAS3RtXLfsmJpN2+1wV/g=;
        b=eOcsJSkR3Tcwg/sysGWZjHB3j7i5r7/PV9NeUpJgrJbmyULq0nH9YQOHu6OfxzbHKe
         +pqjyGtX5lbERmDoDn0TFryW9eiklpbv+vwxUDsCmYqm2vAmc+UOnTUPjndIWDtzZGE6
         1I4m3oFj3B4WBm9sPNSoqOuPlO6sKlxv2tj0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAECcBr13A7/Y2OTRwW1tphAS3RtXLfsmJpN2+1wV/g=;
        b=AcihAduLA97A+kJ8B5FwzmPLS3cPlxh1oyOWBGK2T/r0MHCxAL00H2zM5trgON4+CV
         DpZTQAqqQOmA8WWn9TyRpp/YHEo7JUsFDz7kk9QCdBfV8l8N8JwOPoYCB+Ff7vtKhnxL
         mdCnG+ZEBBNPgF6Pb6F9vUAabbgqo6+WT89QKFsbSol7/x4rpwFbYouGIuwPu+ttwmSm
         OXHUQSgEXyUF9IaTuyk/vr5TjxRzP/E8onr5cWnCMgfVg23g2HNtrjYSVc1qEgi607Pj
         vIGOrjqkLdD1REPx+QF6LxXXeT86CdueENWhhxnLSFgAFGNPaeNHGfsdyR53t7aiItrb
         e1Og==
X-Gm-Message-State: AOAM533GVhMxhD9xRzKHUCqb71qKwjI78jvjAccJQ95C8ADiJ5ueyKq2
        JkEzZI0ViDR9p6OjpCvLDTW1pg==
X-Google-Smtp-Source: ABdhPJx3Th/aWz4EKkeULbF3x4SNVKUYkcYbm9Af9rvuqm06QYk8iV99LuIHbCBgC2+RnLK8ojmnXw==
X-Received: by 2002:aa7:850c:0:b0:3e2:edf3:3d09 with SMTP id v12-20020aa7850c000000b003e2edf33d09mr9710410pfn.42.1630076668808;
        Fri, 27 Aug 2021 08:04:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm7411290pgf.18.2021.08.27.08.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 08:04:28 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] cgroup: Avoid compiler warnings with no subsystems
Date:   Fri, 27 Aug 2021 08:04:24 -0700
Message-Id: <20210827150424.2729274-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3945; h=from:subject; bh=GFK3BETQmfQB9ONseeh+QxRF9yf/a6MqKtjDJoZzqeA=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhKP74SaubLPqskWOEDTayM2+b9dEi4jnuGNQvHGBR dbuO1zCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYSj++AAKCRCJcvTf3G3AJs/ZD/ 4nZI7nyxeKoS/vLqeVHPIvoLfK1l5E/MD6+mX9oxiTv2+rWvwB+LEqyQsAeWZhefkPXXtHMlSKlfZf wfngNKG3xBkDUzhHgrPH6rw0jXrzoxLQ+RziHvHD05OqAzdfEn9rqkpTRMDklEEuWtApzTu7d+e6Dk +MXPDo7l+RrVk3CHNyjvM5sz5dHE4Yx8J9WISnfgMxfKymmCsm9hW/ekMILXJhLObzsCBxtpLrhJA6 X7ghcNxXlrFlvwnteEiSYkz+8Lo5+rKXwL8DagDfwkxuCGzDQ0G86atUitohjKT70bvqKK3XlpUl+A R3/njlqqexcL9f1UoODTtGPU0rnYsj2GXoOH/iRX1wJD95tG9hOa/h7/FDkVUC8E7RhboN/0EyX57/ oswoRaZlkjUWKfHZQXYzFCl6vYIdPX8bCzqqvVXNMkwojxLHqCJ521sBuGKKMmfo86PbNOQAq6OcSW fWhNjsjZ/pgqnROVQGFyXA/Yu+9P7F34MJlrpzItf55SYOtML5fiObXzJPoG7AU6woH0md7QjAJW1i lfXc9OGmU3RqAyGV6XEo7tjbUGZ4uxhAqtQVnBdTva2n88emli1eqk6j111Hb1uEhqkLJhey4K96QQ 42Myh/Q9bRh4WDV+hP4sfQ0Aub1+R4QMdLj+6ppDmC0jhcsvC/gDYadUhqig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As done before in commit cb4a31675270 ("cgroup: use bitmask to filter
for_each_subsys"), avoid compiler warnings for the pathological case of
having no subsystems (i.e. CGROUP_SUBSYS_COUNT == 0). This condition is
hit for the arm multi_v7_defconfig config under -Wzero-length-bounds:

In file included from ./arch/arm/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:264,
                 from include/uapi/linux/swab.h:6,
                 from include/linux/swab.h:5,
                 from arch/arm/include/asm/opcodes.h:86,
                 from arch/arm/include/asm/bug.h:7,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:13,
                 from include/asm-generic/current.h:5,
                 from ./arch/arm/include/generated/asm/current.h:1,
                 from include/linux/sched.h:12,
                 from include/linux/cgroup.h:12,
                 from kernel/cgroup/cgroup-internal.h:5,
                 from kernel/cgroup/cgroup.c:31:
kernel/cgroup/cgroup.c: In function 'of_css':
kernel/cgroup/cgroup.c:651:42: warning: array subscript '<unknown>' is outside the bounds of an
interior zero-length array 'struct cgroup_subsys_state *[0]' [-Wzero-length-bounds]
  651 |   return rcu_dereference_raw(cgrp->subsys[cft->ss->id]);

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: avoid "converting the enum constant to a boolean" warnings
    https://lore.kernel.org/lkml/202108271524.oOIHtG9S-lkp@intel.com/
v1: https://lore.kernel.org/lkml/20210827034741.2214318-1-keescook@chromium.org/
---
 kernel/cgroup/cgroup.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d0725c1a8db5..76693a86e8b7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -472,7 +472,7 @@ static u16 cgroup_ss_mask(struct cgroup *cgrp)
 static struct cgroup_subsys_state *cgroup_css(struct cgroup *cgrp,
 					      struct cgroup_subsys *ss)
 {
-	if (ss)
+	if (CGROUP_SUBSYS_COUNT > 0 && ss)
 		return rcu_dereference_check(cgrp->subsys[ss->id],
 					lockdep_is_held(&cgroup_mutex));
 	else
@@ -550,6 +550,9 @@ struct cgroup_subsys_state *cgroup_e_css(struct cgroup *cgrp,
 {
 	struct cgroup_subsys_state *css;
 
+	if (!CGROUP_SUBSYS_COUNT)
+		return NULL;
+
 	do {
 		css = cgroup_css(cgrp, ss);
 
@@ -577,6 +580,9 @@ struct cgroup_subsys_state *cgroup_get_e_css(struct cgroup *cgrp,
 {
 	struct cgroup_subsys_state *css;
 
+	if (!CGROUP_SUBSYS_COUNT)
+		return NULL;
+
 	rcu_read_lock();
 
 	do {
@@ -647,7 +653,7 @@ struct cgroup_subsys_state *of_css(struct kernfs_open_file *of)
 	 * the matching css from the cgroup's subsys table is guaranteed to
 	 * be and stay valid until the enclosing operation is complete.
 	 */
-	if (cft->ss)
+	if (CGROUP_SUBSYS_COUNT > 0 && cft->ss)
 		return rcu_dereference_raw(cgrp->subsys[cft->ss->id]);
 	else
 		return &cgrp->self;
@@ -2372,7 +2378,7 @@ struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 	struct css_set *cset = tset->cur_cset;
 	struct task_struct *task = tset->cur_task;
 
-	while (&cset->mg_node != tset->csets) {
+	while (CGROUP_SUBSYS_COUNT > 0 && &cset->mg_node != tset->csets) {
 		if (!task)
 			task = list_first_entry(&cset->mg_tasks,
 						struct task_struct, cg_list);
@@ -4643,7 +4649,7 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 	it->ss = css->ss;
 	it->flags = flags;
 
-	if (it->ss)
+	if (CGROUP_SUBSYS_COUNT > 0 && it->ss)
 		it->cset_pos = &css->cgroup->e_csets[css->ss->id];
 	else
 		it->cset_pos = &css->cgroup->cset_links;
-- 
2.30.2

