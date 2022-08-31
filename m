Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D1E5A8936
	for <lists+cgroups@lfdr.de>; Thu,  1 Sep 2022 00:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbiHaWtR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 31 Aug 2022 18:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiHaWtQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 31 Aug 2022 18:49:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3095BD91EC
        for <cgroups@vger.kernel.org>; Wed, 31 Aug 2022 15:49:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k126-20020a253d84000000b0068bb342010dso3126425yba.1
        for <cgroups@vger.kernel.org>; Wed, 31 Aug 2022 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=Ipn4iHe/yg+mxny4c01g7Po8t+R0aRPugnC10Z422Fk=;
        b=p2AFOEi5vGtb1tUhtbYlZ00F68mil8VLs1Lo6ATVSmPdszXyCTRaayeQPRhLYq+tb4
         2BU0EHsinRDXn7QQtVcOjaYfomxoAKYknKBD/vtrXVN00hCBJSPaxOJXQWffslTgrkw+
         9PlpVdZoxZ4xyvUiGv3eo5+6U+maaN+achNbh1vmJDxZuCtb86Zb55Qwz0ZVC8EUh0Xc
         AFvv8Eb0w/a3rfdHIS9BfzXyfcV9staK9ZdwJxgpBoIm0r+mhmLAXCtvBWpRphL2UbBQ
         klas0NiDWrY1Qstm9kx09OPX3GwNhdNGfUwlRwXQwp3forhXV6wko2ESn8fqSQ+kA0zN
         MG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Ipn4iHe/yg+mxny4c01g7Po8t+R0aRPugnC10Z422Fk=;
        b=YY7lBza1l0kuChMqnE6z6zV++ILU7fYm1S+5rI7DzmEjVPlA79xPM15Wb+lY8j0SLy
         PYFakzI3ql0k7nVIaFHqahrLkGODYAfV2wGh2XG875HXFO50/6nx/KQgc4oIiMBg05Kc
         pT0XDN3aQdeyqXwpOiinLzbjH5bghojHh7jLaEprKPQniAisRxVxWrjafk05vKUYQ8P+
         6+qXe95WAIVj1b73hAe+O0W04I42ODQq1X/JI1LwPuqlm3HSkw9MFMS7gf8yIVVWZTMW
         kayHACN99zX2BD2GdnkpBvuIywGW5Tafp18BXf7VU5DvYfY0qRaJBxpII00EXWv7/cNB
         Y2QQ==
X-Gm-Message-State: ACgBeo3ZOmPCV5Whozdq/L3hKf3t1xHjOhsUtK7AmuzoTjByDJdQWSj7
        z1oP9Y9NGczp8rVP7gU2HiXlHZSb1I9w
X-Google-Smtp-Source: AA6agR7/V3nJns03/37pPbe+xIfXuklzJsVz03pu5XaQu2MQjjDInOYRowUTTaCUCdXK0dOyWlhwtNuaITE2
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:aa74:a917:f27:6c1c])
 (user=joshdon job=sendgmr) by 2002:a25:3b46:0:b0:69c:a60e:2e57 with SMTP id
 i67-20020a253b46000000b0069ca60e2e57mr5457884yba.364.1661986154491; Wed, 31
 Aug 2022 15:49:14 -0700 (PDT)
Date:   Wed, 31 Aug 2022 15:49:03 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831224903.454303-1-joshdon@google.com>
Subject: [PATCH] cgroup: add pids.peak interface for pids controller
From:   Josh Don <joshdon@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

pids.peak tracks the high watermark of usage for number of pids. This
helps give a better baseline on which to set pids.max. Polling
pids.current isn't really feasible, since it would potentially miss
short-lived spikes.

This interface is analogous to memory.peak.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/cgroup/pids.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 511af87f685e..7695e60bcb40 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -47,6 +47,7 @@ struct pids_cgroup {
 	 */
 	atomic64_t			counter;
 	atomic64_t			limit;
+	int64_t				watermark;
 
 	/* Handle for "pids.events" */
 	struct cgroup_file		events_file;
@@ -85,6 +86,16 @@ static void pids_css_free(struct cgroup_subsys_state *css)
 	kfree(css_pids(css));
 }
 
+static void pids_update_watermark(struct pids_cgroup *p, int64_t nr_pids)
+{
+	/*
+	 * This is racy, but we don't need perfectly accurate tallying of
+	 * the watermark, and this lets us avoid extra atomic overhead.
+	 */
+	if (nr_pids > READ_ONCE(p->watermark))
+		WRITE_ONCE(p->watermark, nr_pids);
+}
+
 /**
  * pids_cancel - uncharge the local pid count
  * @pids: the pid cgroup state
@@ -128,8 +139,11 @@ static void pids_charge(struct pids_cgroup *pids, int num)
 {
 	struct pids_cgroup *p;
 
-	for (p = pids; parent_pids(p); p = parent_pids(p))
-		atomic64_add(num, &p->counter);
+	for (p = pids; parent_pids(p); p = parent_pids(p)) {
+		int64_t new = atomic64_add_return(num, &p->counter);
+
+		pids_update_watermark(p, new);
+	}
 }
 
 /**
@@ -156,6 +170,12 @@ static int pids_try_charge(struct pids_cgroup *pids, int num)
 		 */
 		if (new > limit)
 			goto revert;
+
+		/*
+		 * Not technically accurate if we go over limit somewhere up
+		 * the hierarchy, but that's tolerable for the watermark.
+		 */
+		pids_update_watermark(p, new);
 	}
 
 	return 0;
@@ -311,6 +331,14 @@ static s64 pids_current_read(struct cgroup_subsys_state *css,
 	return atomic64_read(&pids->counter);
 }
 
+static s64 pids_peak_read(struct cgroup_subsys_state *css,
+			  struct cftype *cft)
+{
+	struct pids_cgroup *pids = css_pids(css);
+
+	return READ_ONCE(pids->watermark);
+}
+
 static int pids_events_show(struct seq_file *sf, void *v)
 {
 	struct pids_cgroup *pids = css_pids(seq_css(sf));
@@ -331,6 +359,11 @@ static struct cftype pids_files[] = {
 		.read_s64 = pids_current_read,
 		.flags = CFTYPE_NOT_ON_ROOT,
 	},
+	{
+		.name = "peak",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_s64 = pids_peak_read,
+	},
 	{
 		.name = "events",
 		.seq_show = pids_events_show,
-- 
2.37.2.672.g94769d06f0-goog

