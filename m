Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F036F391CD4
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhEZQUJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 12:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhEZQUJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 12:20:09 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB58C061574
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso637506pjq.3
        for <cgroups@vger.kernel.org>; Wed, 26 May 2021 09:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afnfUzVttge2WkHYKcBQlzvu8O2ytUcvyB9H4FdbWXU=;
        b=X3GhEbmocCb8p8S0ucrVTE84kBDM82YugbsYUoQHT19gsMXNTUyAMtLprQNzuYGWCE
         x0rE9FbyR+KdNisBlcRGT/JR7W7L0eOgvaVvOxTQRHpNIwqDUl199S5Vc/5YR2PxMnKB
         PjGa4KOTAqtb3o8ScD87ijaVHRfi9CrvmYOpxeeGbL4RbEd6HdIpigI6f5tawGg19AP7
         sCfzlWOSYzOGpZc9KaySf1qRcdSXWWuJAiOsin2gZGjdHPV0P5myN3xRj8NaBUndOPQU
         J5VkPv5Qns4/N2i6EdqWtNs42u1gE42yqpKpmf4vzA9Ae0bmkmmMhcUZ6GCwBg+2/Ara
         X/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afnfUzVttge2WkHYKcBQlzvu8O2ytUcvyB9H4FdbWXU=;
        b=LQr9yOln/AGOSPxviFbkUcPDWSvajtnxKTDNM+QpW/Qy8TrOHGwp+eYtNnmI4oQIXq
         vF2wegNCQfjABMn3kzrldSD5atlDP1E4na49+yrdgKb+9BeqOEsJbKtKPAKowIIki4/0
         W52eGFmmBi8d61sM/+rBQ9mBeWZVLsgbMeU9jQbzch4nPOMdVhfKwY7OGtO3NFIBflFw
         ZvkgXPo6ENwiV5boUbcqfbOblrG2GGOv9CzKbB2YwTa84W1f83BmgsLCqtkBg/Vl7DzI
         SRlK2toZCn+s9ZcTtsgJcLvnnyqSHMk888G6jly5KFSXY/w/qS+4qd9PzItsVASC5s0y
         NDyg==
X-Gm-Message-State: AOAM531C76ggIwGeYCHvyo+e+V9DmV1IbrmA4EDLYAFdoCraA1rp23IJ
        NzWEkGJ7CbiR58K0y1AXtxo=
X-Google-Smtp-Source: ABdhPJyLSSLthvWx4C7vC4nbNL2VtKzdoleDluV5juhDeqDIpMSL1vksGYbLQMY/LPHhmwPBMrr+BQ==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr37120303pjo.108.1622045916543;
        Wed, 26 May 2021 09:18:36 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id v2sm15950447pfm.134.2021.05.26.09.18.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 09:18:36 -0700 (PDT)
From:   yulei.kernel@gmail.com
X-Google-Original-From: yuleixzhang@tencent.com
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        christian@brauner.io
Cc:     cgroups@vger.kernel.org, benbjiang@tencent.com,
        kernellwp@gmail.com, Yulei Zhang <yuleixzhang@tencent.com>
Subject: [RFC 2/7] mm: introduce alloc_bps to memcg for memory allocation speed throttle
Date:   Thu, 27 May 2021 00:17:59 +0800
Message-Id: <6633783bc0900ce095ff75dbe603946ee900d5fb.1622043596.git.yuleixzhang@tencent.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1622043596.git.yuleixzhang@tencent.com>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yulei Zhang <yuleixzhang@tencent.com>

Add read/write attribute memory.alloc_bps to configure the allowable
memory allocation speed of the memory cgroup in bytes.

Signed-off-by: Jiang Biao <benbjiang@tencent.com>
Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
---
 include/linux/memcontrol.h | 10 ++++++++++
 mm/memcontrol.c            | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c193be760709..4938397f321d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -230,6 +230,12 @@ struct obj_cgroup {
 	};
 };
 
+#ifdef CONFIG_MEM_SPEED_THROTTLE
+struct mem_spd_ctl {
+	unsigned long mem_spd_lmt;
+};
+#endif
+
 /*
  * The memory controller data structure. The memory controller controls both
  * page cache and RSS per cgroup. We would eventually like to provide
@@ -349,6 +355,10 @@ struct mem_cgroup {
 	struct deferred_split deferred_split_queue;
 #endif
 
+#ifdef CONFIG_MEM_SPEED_THROTTLE
+	struct mem_spd_ctl msc;
+#endif
+
 	struct mem_cgroup_per_node *nodeinfo[0];
 	/* WARNING: nodeinfo must be the last member here */
 };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7ef6aa088680..d59abe15d89d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1393,6 +1393,28 @@ static int memcg_page_state_unit(int item)
 }
 
 #ifdef CONFIG_MEM_SPEED_THROTTLE
+static u64 mem_cgroup_mem_spd_lmt_read(struct cgroup_subsys_state *css,
+				       struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return (u64)(memcg->msc.mem_spd_lmt << PAGE_SHIFT);
+}
+
+static int mem_cgroup_mem_spd_lmt_write(struct cgroup_subsys_state *css,
+					struct cftype *cft, u64 val)
+{
+	struct mem_cgroup *memcg;
+	unsigned long lmt;
+
+	memcg = mem_cgroup_from_css(css);
+	lmt = val >> PAGE_SHIFT;
+
+	memcg->msc.mem_spd_lmt = lmt;
+
+	return 0;
+}
+
 static unsigned long mem_cgroup_mst_get_mem_spd_max(struct mem_cgroup *memcg)
 {
 	struct page_counter *c = &memcg->memory;
@@ -4805,6 +4827,14 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write_u64 = mem_cgroup_hierarchy_write,
 		.read_u64 = mem_cgroup_hierarchy_read,
 	},
+#ifdef CONFIG_MEM_SPEED_THROTTLE
+	{
+		.name = "alloc_bps",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = mem_cgroup_mem_spd_lmt_read,
+		.write_u64 = mem_cgroup_mem_spd_lmt_write,
+	},
+#endif
 	{
 		.name = "cgroup.event_control",		/* XXX: for compat */
 		.write = memcg_write_event_control,
@@ -6358,6 +6388,14 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_oom_group_show,
 		.write = memory_oom_group_write,
 	},
+#ifdef CONFIG_MEM_SPEED_THROTTLE
+	{
+		.name = "alloc_bps",
+		.write_u64 = mem_cgroup_mem_spd_lmt_write,
+		.read_u64 = mem_cgroup_mem_spd_lmt_read,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+#endif
 	{ }	/* terminate */
 };
 
-- 
2.28.0

