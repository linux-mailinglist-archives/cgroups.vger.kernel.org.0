Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9407A391CD7
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 18:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhEZQUM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 12:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhEZQUM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 12:20:12 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4535C061756
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y202so1304632pfc.6
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7jHJGvj/WunXhmGaK7ypZOWSz/zhiqTHcN3tpdvjCAw=;
        b=ngG0ihAClNo2fzXIbvlPnBmLwfBE7y16n8auMPGCMtFfHMyTNpElOHxPpHVgcAzt5o
         1OUWctHEbMTDeUIIWIbodxS2MDIcXepDUjQuOesYx9I/ov4uoB01HtRiCsgyhp7YbPU+
         pojYfFVVqN0kKt23gxLlcKlyJgDGnFdlXXeoaNDTYPQ6f9PBDGDm1dZKyvZrzHG9KPN4
         l8syiplNm6BInR7jIy81nCUv0qNU1Hcq1V/eL/kWZV7HisyIaVyxVkY4MsAkQw2LPFVz
         c7OWb20kJiNYNXsD88lo1gBy4jJaTS1HaLoe4vc1ZrtZiCqpPEphwgkz/BPmriD7Eapc
         HnHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7jHJGvj/WunXhmGaK7ypZOWSz/zhiqTHcN3tpdvjCAw=;
        b=Z7K3+DxqQ/a+wug/b9NnMnNNg2hnEeCyDH/PmsVjBJQ53kx2Po1c2eENOrjdUszzBW
         RSXXFZmx5IGSMMvqGcKI/1eLCHlrnHEPlyhsHGkJLCGEwZU74DvEi2XDyzpxjoKpflwT
         6w1AlkRNXVhSnJjxi5X/7Kb3tyC4cgWRL+Dnvf+AKv2+YHcc0+H2MEyIrgiH5e7viEp3
         vP9g3KHZklOV4oJGFfeGMVExCUueQtpvIV4vIsnn4AVBrntTZOLt6PDObXE4ehT9+Cwv
         CHPIkvJHpwy4VaOWAKx5dNiUlg/jvshLyHnVPlXs+GJzNS9BhDUccOO5x0eAX4o2lWox
         mvXw==
X-Gm-Message-State: AOAM5315ptWKoY0UDBdNRe6DPXAE7Pp9eshnttlOtzPGnWM00GIoUp5R
        /15LGgnSa1K6s3ZitQdqnQg=
X-Google-Smtp-Source: ABdhPJwp4Qvi6Fv8jZzgrtiLLoDxP7JFP7Elol+L1o6q+gobx8eUqag1lj8Wog3hVvychfm/eilQIA==
X-Received: by 2002:a62:31c7:0:b029:2e9:2c05:52d3 with SMTP id x190-20020a6231c70000b02902e92c0552d3mr3222357pfx.78.1622045920552;
        Wed, 26 May 2021 09:18:40 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id v2sm15950447pfm.134.2021.05.26.09.18.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 09:18:40 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC 3/7] mm: memory allocation speed throttle setup in hierarchy
Date:   Thu, 27 May 2021 00:18:00 +0800
Message-Id: <5607e3530bc25307dd0e77bd73ae70fc6f33a146.1622043596.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1622043596.git.yuleixzhang@tencent.com>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Init the memory allocation speed throttle parametersi to
make sure the throttle feature works in hierarchy structure.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/memcontrol.h |  1 +
 mm/memcontrol.c            | 50 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 4938397f321d..435515b1a709 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -233,6 +233,7 @@ struct obj_cgroup {
 #ifdef CONFIG_MEM_SPEED_THROTTLE
 struct mem_spd_ctl {
 	unsigned long mem_spd_lmt;
+	int has_lmt;
 };
 #endif
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d59abe15d89d..9d7a86f7f51c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1393,6 +1393,35 @@ static int memcg_page_state_unit(int item)
 }
 
 #ifdef CONFIG_MEM_SPEED_THROTTLE
+static void mem_cgroup_mst_msc_reset(struct mem_cgroup *memcg)
+{
+	struct mem_spd_ctl *msc;
+
+	if (mem_cgroup_is_root(memcg))
+		return;
+
+	msc = &memcg->msc;
+	msc->has_lmt = 0;
+	msc->mem_spd_lmt = 0;
+}
+
+static void mem_cgroup_mst_has_lmt_init(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup *iter = memcg;
+	struct cgroup_subsys_state *css = &memcg->css;
+
+	rcu_read_lock();
+	while (!mem_cgroup_is_root(iter)) {
+		if (iter->msc.mem_spd_lmt != 0) {
+			memcg->msc.has_lmt = 1;
+			return;
+		}
+		css = css->parent;
+		iter = mem_cgroup_from_css(css);
+	}
+	rcu_read_unlock();
+}
+
 static u64 mem_cgroup_mem_spd_lmt_read(struct cgroup_subsys_state *css,
 				       struct cftype *cft)
 {
@@ -1404,7 +1433,7 @@ static u64 mem_cgroup_mem_spd_lmt_read(struct cgroup_subsys_state *css,
 static int mem_cgroup_mem_spd_lmt_write(struct cgroup_subsys_state *css,
 					struct cftype *cft, u64 val)
 {
-	struct mem_cgroup *memcg;
+	struct mem_cgroup *memcg, *iter;
 	unsigned long lmt;
 
 	memcg = mem_cgroup_from_css(css);
@@ -1412,6 +1441,14 @@ static int mem_cgroup_mem_spd_lmt_write(struct cgroup_subsys_state *css,
 
 	memcg->msc.mem_spd_lmt = lmt;
 
+	/* Sync with mst_has_lmt_init*/
+	synchronize_rcu();
+
+	if (lmt) {
+		for_each_mem_cgroup_tree(iter, memcg)
+			iter->msc.has_lmt = 1;
+	}
+
 	return 0;
 }
 
@@ -1439,6 +1476,14 @@ static void mem_cgroup_mst_show_mem_spd_max(struct mem_cgroup *memcg,
 		   mem_cgroup_mst_get_mem_spd_max(memcg));
 }
 #else /* CONFIG_MEM_SPEED_THROTTLE */
+static void mem_cgroup_mst_has_lmt_init(struct mem_cgroup *memcg)
+{
+}
+
+static void mem_cgroup_mst_msc_reset(struct mem_cgroup *memcg)
+{
+}
+
 static void mem_cgroup_mst_show_mem_spd_max(struct mem_cgroup *memcg,
 					    struct seq_file *m)
 {
@@ -5198,6 +5243,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
+	mem_cgroup_mst_has_lmt_init(memcg);
+
 	return 0;
 }
 
@@ -5287,6 +5334,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	memcg->soft_limit = PAGE_COUNTER_MAX;
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
+	mem_cgroup_mst_msc_reset(memcg);
 }
 
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
-- 
2.28.0

