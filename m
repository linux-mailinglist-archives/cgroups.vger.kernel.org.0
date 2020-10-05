Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349E52831AA
	for <lists+cgroups@lfdr.de>; Mon,  5 Oct 2020 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJEIOg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Oct 2020 04:14:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57873 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgJEIOd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Oct 2020 04:14:33 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kPLde-0001Ih-5F
        for cgroups@vger.kernel.org; Mon, 05 Oct 2020 08:14:30 +0000
Received: by mail-wr1-f71.google.com with SMTP id 47so1415857wrc.19
        for <cgroups@vger.kernel.org>; Mon, 05 Oct 2020 01:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a3RK306ViIXSDm7E/OHB8KsWv3MXYnGA8qRg0vSmwRg=;
        b=QphLpueNc6S/c84uhmH2BRwhBWxJxZVJ3h87pMAq3MaDCaUKQp09BJYfDA/uq/u6yp
         Tvsmcbv7cPff9098JF//a3og/JumsijEGvmI2rC6cMcNABGqmXYQn6iajxlCEqIMDhUE
         SWA75/deI86cqXAXfQReM0QaubuyRFkS+vqPsO0WN9rQmIMtssTR902pcchb4fTobx42
         IjUyZkmkkjOdYDECfNyfTaqvAAw89BTEv1odY0zqQ0v84NkIwHFhdB8nTHwnXpjdr1FU
         E4N/kt5qmCBi7/nVXnyy713fsjnCgv5ajh3Gw25XaZyFZnIDDVxIRV9UR85G5scjlxtr
         Ad5Q==
X-Gm-Message-State: AOAM533iZqydnTyHSS48iJCCJhQaPQPSYOF2MHgRvY8ssGvUCvoAXIqN
        FLbtRbwtabSm4YxqqdveE05Yj3Fk/bW05fJXxdl708aFolVgOmrTtcpN0eMr0jsH/d2tN0n40uq
        jxtd713HeFlF6F3FBodySIrIk7h13DidvtzA=
X-Received: by 2002:a7b:c111:: with SMTP id w17mr16169201wmi.28.1601885669727;
        Mon, 05 Oct 2020 01:14:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK2e5XsCLt9z+P6jBHXXdu+RZxdp5xEs60J4eTYgbaA18QOia0wcIZVKu26ncPtxuUD2XYNA==
X-Received: by 2002:a7b:c111:: with SMTP id w17mr16169172wmi.28.1601885669454;
        Mon, 05 Oct 2020 01:14:29 -0700 (PDT)
Received: from xps-13-7390.homenet.telecomitalia.it (host-79-36-133-218.retail.telecomitalia.it. [79.36.133.218])
        by smtp.gmail.com with ESMTPSA id a15sm13168855wrn.3.2020.10.05.01.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 01:14:28 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luigi Semenzato <semenzato@google.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH RFC v2 2/2] mm: memcontrol: introduce opportunistic memory reclaim
Date:   Mon,  5 Oct 2020 10:13:13 +0200
Message-Id: <20201005081313.732745-3-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201005081313.732745-1-andrea.righi@canonical.com>
References: <20201005081313.732745-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Opportunistic memory reclaim allows user-space to trigger an artificial
memory pressure condition and force the system to reclaim memory (drop
caches, swap out anonymous memory, etc.).

This feature is provided by adding a new file to each memcg:
memory.swap.reclaim.

Writing a number to this file forces a memcg to reclaim memory up to
that number of bytes ("max" means as much memory as possible). Reading
from the this file returns the amount of bytes reclaimed in the last
opportunistic memory reclaim attempt.

Memory reclaim can be interrupted sending a signal to the process that
is writing to memory.swap.reclaim (i.e., to set a timeout for the whole
memory reclaim run).

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 18 ++++++++
 include/linux/memcontrol.h              |  4 ++
 mm/memcontrol.c                         | 59 +++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index baa07b30845e..2850a5cb4b1e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1409,6 +1409,24 @@ PAGE_SIZE multiple when read back.
 	Swap usage hard limit.  If a cgroup's swap usage reaches this
 	limit, anonymous memory of the cgroup will not be swapped out.
 
+  memory.swap.reclaim
+        A read-write single value file that can be used to trigger
+        opportunistic memory reclaim.
+
+        The string written to this file represents the amount of memory to be
+        reclaimed (special value "max" means "as much memory as possible").
+
+        When opportunistic memory reclaim is started the system will be put
+        into an artificial memory pressure condition and memory will be
+        reclaimed by dropping clean page cache pages, swapping out anonymous
+        pages, etc.
+
+        NOTE: it is possible to interrupt the memory reclaim sending a signal
+        to the writer of this file.
+
+        Reading from memory.swap.reclaim returns the amount of bytes reclaimed
+        in the last attempt.
+
   memory.swap.events
 	A read-only flat-keyed file which exists on non-root cgroups.
 	The following entries are defined.  Unless specified
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0b036123c6a..0c90d989bdc1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -306,6 +306,10 @@ struct mem_cgroup {
 	bool			tcpmem_active;
 	int			tcpmem_pressure;
 
+#ifdef CONFIG_MEMCG_SWAP
+	unsigned long		nr_swap_reclaimed;
+#endif
+
 #ifdef CONFIG_MEMCG_KMEM
         /* Index in the kmem_cache->memcg_params.memcg_caches array */
 	int kmemcg_id;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6877c765b8d0..b98e9bbd61b0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7346,6 +7346,60 @@ static int swap_events_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+/*
+ * Try to reclaim some memory in the system, stop when one of the following
+ * conditions occurs:
+ *  - at least "nr_pages" have been reclaimed
+ *  - no more pages can be reclaimed
+ *  - current task explicitly interrupted by a signal (e.g., user space
+ *    timeout)
+ *
+ *  @nr_pages - amount of pages to be reclaimed (0 means "as many pages as
+ *  possible").
+ */
+static unsigned long
+do_mm_reclaim(struct mem_cgroup *memcg, unsigned long nr_pages)
+{
+	unsigned long nr_reclaimed = 0;
+
+	while (nr_pages > 0) {
+		unsigned long reclaimed;
+
+		if (signal_pending(current))
+			break;
+		reclaimed = __shrink_all_memory(nr_pages, memcg);
+		if (!reclaimed)
+			break;
+		nr_reclaimed += reclaimed;
+		nr_pages -= min_t(unsigned long, reclaimed, nr_pages);
+	}
+	return nr_reclaimed;
+}
+
+static ssize_t swap_reclaim_write(struct kernfs_open_file *of,
+				  char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long nr_to_reclaim;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &nr_to_reclaim);
+	if (err)
+		return err;
+	memcg->nr_swap_reclaimed = do_mm_reclaim(memcg, nr_to_reclaim);
+
+	return nbytes;
+}
+
+static u64 swap_reclaim_read(struct cgroup_subsys_state *css,
+			     struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return memcg->nr_swap_reclaimed << PAGE_SHIFT;
+}
+
 static struct cftype swap_files[] = {
 	{
 		.name = "swap.current",
@@ -7370,6 +7424,11 @@ static struct cftype swap_files[] = {
 		.file_offset = offsetof(struct mem_cgroup, swap_events_file),
 		.seq_show = swap_events_show,
 	},
+	{
+		.name = "swap.reclaim",
+		.write = swap_reclaim_write,
+		.read_u64 = swap_reclaim_read,
+	},
 	{ }	/* terminate */
 };
 
-- 
2.27.0

