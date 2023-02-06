Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54AB868B6DA
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjBFHvg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBFHvR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:51:17 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FCA1E1EB;
        Sun,  5 Feb 2023 23:50:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPMugDb3K7VLwP+qPD3IW09XSncxBAySSWi9HNMG3ZMxVRbB0cT2+2UGt8TO8pA4T+GtX+4v21zMIboTuxT2BpGRIjBWKot9cAM0m4h+q3a08A7is7pOtYZ9k5FeXqCLH4y7ChHRYEArS2mYFwmwM3Lp+HZcbSeaF2ffyUDSjQ/7eTB1U0gz+HFWjxWCirAUKlmZOB4b696k6WbMGawayw7i11sVtdKPXg1er6w/MMQ9b2yhmcx2u86vgOGwEd6A0be7Xfb0sBKEF3X42dOXmzl3A2HfgurTS2f2WV28rPOCXq46zb3EI3Oe+awdfGgW0QnUtljkvB5FqO3+hSAWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67W7G5XqVQ/WEqZY3BEK3/0UYthlxkah8cbfNm84T68=;
 b=iJfJt434uaasZGJCT4ix91v7/hDgybDtscIUYe7yZ/UhmIrrI8GsUytKMXkDhX+iDwtAzm+bVKgkGLJWAPXJaE28H6rvovANPz+nB0oLVo1qATP+OM8gjVbua+q6+QBNpQskwW1LvJ+yjh8NwMkeOvsVeC4V0tkzBaw9zvfLyu//e6HrbFuWdqb6u6r5aEKFYMPtiNv+eMAlFjKHiyHzWnKzDCSm/8gNpUWaf+iZWqeTh3Ntye54BrjHmi3DH6HPw4x5+rtFKG9t4YRPjk4B02BYI/3tnhS+rqCExumUz2ALGAQrr4lAU+7f9EwZQt/RRIyFY/n68dxS/WIMM3m/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67W7G5XqVQ/WEqZY3BEK3/0UYthlxkah8cbfNm84T68=;
 b=nbwt/S3UZ8XqtXWM0lOLCqHrD7InkYkc90zJhknYiD8orctYZvNKQDN82tCkVSJRF95vZJvbfPvqn4KeJVzW9PEN6NJ5u40Sk7cPDVoA56ULRpeG1klRlzqgr7Q22o8Ry8f5EBj1PziIK4VuT/TDO8qdvhynADmtxR6Ejr7oCVTU5EOiz+ZgqqyFPUjt5cnMRPBIjj7jOLEAoyTOmdtUaD+HpmhW6lpb2Vi59DRsGlF2/gAahgX0cGnky+LmIhINeU2xgfqJhD0QIj0vRR5fdJnkZQNmTfkF0Fsg5q/SNAXnvoz4TmoJQ3AC7rK0dpaJmbCxUVeTLBwWaNxGIklMBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 07:49:47 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:49:46 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Date:   Mon,  6 Feb 2023 18:47:51 +1100
Message-Id: <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0092.ausprd01.prod.outlook.com
 (2603:10c6:10:3::32) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e4a522-d38f-420b-49e5-08db0816b79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzr5rw2KFFgMukaQWx8cTx2cDDmEyKDDI8Db41e3wffekUhWiQ0KxQPG967Ny1rCKcsIF3HVTcdjjbE/PxltjyLQc/hoVAD4rEH5XjPboqRy12efrJyo+D2oRRAhMVDbta+ZeM8nYs9dj94DORztZzQ73nO/JSslxm3FySEtLjlsJCC+ToHZUaJD6hxQs0iUyIWOXsG1xU8LrL4J+BWkePxLzp0ab9nlkw52mbN453b3UfOkprggTiGo6PjewO4u3jxRJl+V7sPS8zMOH2jlrSwcgi10QTTz+hz58nWBXkVSOi04euM5PBDByVKNkouEKCvsPJY6aw4fCxBcby6+lrqaFEzeUctNt9JkIbJC7yfx9VdRpJjKgN/M+f6yZzJiTqMGUAcY6Asg4Kdy7RENW9+W9YaioKABJTH6E9kmyMTutXi1bzY4IR9pbiEBRrh4JTl2cmcTF2m223vuIPLCcMFAN4aBZR86mSN28m08LUEOU5e6G48arSv4dgHTj4LRNGCLQqU9FKqGqmvGddzn0yh1RTalKGM4Ai8ht3yfVYMwkZ4ReOM6+s8qQSkOuMB2v0mjqPij5AyHY0plXg95wTjiUBzNYsresxHGs6fZfj8wjEbKyKG7aQmwBEqFZEdX6pASnqKyiwCSVYGGvXUOLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(54906003)(316002)(86362001)(6666004)(6486002)(38100700002)(186003)(2616005)(6506007)(26005)(478600001)(6512007)(7416002)(5660300002)(83380400001)(30864003)(2906002)(36756003)(66946007)(8936002)(4326008)(41300700001)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jskS2os3I4atajsRYYf6bHzyGFPYQQsZWmjNoxEVxmjCTpPufXCrGIrz0lBP?=
 =?us-ascii?Q?XQRqpjjNJQ6zXuOzSr8X1Z7x/nlQmpNfVQMXg2hWovWTw39sjr/fNi+KVRTM?=
 =?us-ascii?Q?4ygLPHUa6Bx2H4CcCImgifxMNlzJaDJq1eFPkbqefQn5v73RJgYBqM3fZ0Fu?=
 =?us-ascii?Q?REe8/48abH5UMot19UtSQ58oKLqSghtIwvf4DCs3FpNbB+W9Y6+SG8WXsRVY?=
 =?us-ascii?Q?yG+YQbbofcH+5ijujmOZpm2uTzVGgEF/wP0ITLrAna4R4E0V7UHzAOxV9XyV?=
 =?us-ascii?Q?BKvSbMlsUTsWttJ9vnc/ON/m9aJR+PcJqicHqPFvyUOJM3Pd77Or2kWPmx+k?=
 =?us-ascii?Q?S4e88FJeMxddxXi9VIHL7bLBdYbMi+loTvJhYF8Pi4AndLT9mFGjIejJ3puy?=
 =?us-ascii?Q?ThJL3xpdciJotKBj1LkfdG3wuUHgLq41/ArCZ5I3Q/IKLrZwpOQtdJC7v4sf?=
 =?us-ascii?Q?llAJBka7OPrTzPXOuTEdHWeEoPXXjdI64nQ/1ahz6JtnJhO1MtlBdJwshJY7?=
 =?us-ascii?Q?F4CDqREtuZgTRyXyYBv2CftL3umhymPhA1kVvrSTofu7Wpn8EFRk6Wxama+N?=
 =?us-ascii?Q?xD3YWsk3N7grFVfrQLqw6uECd4AYgDXX2WxFxhvSPE9ai3kBrQVpQRW8FuGt?=
 =?us-ascii?Q?dbHRs8ui4Je01XNBzR/TRzIrQ8NgOUgR5Pu7jOMmvIXiyXOldbicXOqwf/pk?=
 =?us-ascii?Q?0xbcxnr6hxd+y2XnYk5KRMvMukLH5W0DZq9JZ9q4WIcwoiuUxTCuPDauIrbO?=
 =?us-ascii?Q?lq2wEQvwWLU30c2NTIa+XuxLut1bDuE0Sz0Diehqb8hF7zXo26bQe2g6ieYo?=
 =?us-ascii?Q?xIwt7s/RzGAAwzmj3Im9Qxu6vMmLn0khKxd9MbmbfxSDdHNotdxWgB5jLiCO?=
 =?us-ascii?Q?wXolO0wnwhfgHj7vc0bt4/rMMBj9vXpX/DZ5Jfi4qONYptEEtkIU5+bwE9Yj?=
 =?us-ascii?Q?OE8Cu38uBSedi0kuC8YjzsSD4gQusqPLV0aDkNWYbDuEY5PtstwZYqCqR4wZ?=
 =?us-ascii?Q?KOp2qYX934BLDcJOlSr4PHbJqcclbtfP7QPnaFNQFWHSYaZ7mN8BtA0P2vr6?=
 =?us-ascii?Q?j+NzyUlenBqEav7MhU1FYhPEjaniYxZ3GbiGYPsr7DE5HSrpVyYTOJxPnB3y?=
 =?us-ascii?Q?UcM3apOHHSK02U/QGhtKY26ZITxUK9r/YXNC77fOt1iLFB9xB66aJM1/zwtU?=
 =?us-ascii?Q?+p3W7vW8P0JiJRfcI2U3sHtQq4w9rvbxmy/9n0D9SfRQO9KQcA9zN01mFCdS?=
 =?us-ascii?Q?XQ1PvdZDf1ofuC2IwMCmrz4lKVm2W1dPa2ZR3XiA1zDZ9j3mJui5vVtZNyyR?=
 =?us-ascii?Q?dnpOjgQi4WFUcJIUjN7f4pp6XDsgXWmxo4HKIl18UXnfErBqynfhvveBKFip?=
 =?us-ascii?Q?aVwmIVGezk44shcvMoLTH+QnB69iltd7BUgmF9Ib4k72U5I0MtTsrZahtolS?=
 =?us-ascii?Q?TFAZvId4LXQXnc+lAYPRa1a/Cc0RobnXNoYoK61BHOhXsl7081Nbb69KUKM9?=
 =?us-ascii?Q?CVw8Y3hlJhKJfZfNcetWYCKPSjmrKlPhLI8wLshCs0Qn02n1WkpkpfIdQbYi?=
 =?us-ascii?Q?+zr/gzsDjmXFpe9CGBOZtYTdDpS5rwcJ/MJ0fIFN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e4a522-d38f-420b-49e5-08db0816b79f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:49:46.8841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uw7shkhp0nozyKHfhCyagx37WKAuCW97CcAMHQEQlN5RJCzM4EjouQI4LsjKCvBkTM6QDSpdTe51pNaCtdCbbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If too much memory in a system is pinned or locked it can lead to
problems such as performance degradation or in the worst case
out-of-memory errors as such memory cannot be moved or paged out.

In order to prevent users without CAP_IPC_LOCK from causing these
issues the amount of memory that can be pinned is typically limited by
RLIMIT_MEMLOCK. However this is inflexible as limits can't be shared
between tasks and the enforcement of these limits is inconsistent
between in-kernel users of pinned memory such as mlock() and device
drivers which may also pin pages with pin_user_pages().

To allow for a single limit to be set introduce a cgroup controller
which can be used to limit the number of pages being pinned by all
tasks in the cgroup.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 MAINTAINERS                   |   7 +-
 include/linux/cgroup.h        |  20 +++-
 include/linux/cgroup_subsys.h |   4 +-
 mm/Kconfig                    |  11 +-
 mm/Makefile                   |   1 +-
 mm/pins_cgroup.c              | 273 +++++++++++++++++++++++++++++++++++-
 6 files changed, 316 insertions(+)
 create mode 100644 mm/pins_cgroup.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f781f93..f8526e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5381,6 +5381,13 @@ F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_kmem.c
 F:	tools/testing/selftests/cgroup/test_memcontrol.c
 
+CONTROL GROUP - PINNED AND LOCKED MEMORY
+M:	Alistair Popple <apopple@nvidia.com>
+L:	cgroups@vger.kernel.org
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	mm/pins_cgroup.c
+
 CORETEMP HARDWARE MONITORING DRIVER
 M:	Fenghua Yu <fenghua.yu@intel.com>
 L:	linux-hwmon@vger.kernel.org
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 3410aec..d98de25 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -857,4 +857,24 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 #endif /* CONFIG_CGROUP_BPF */
 
+#ifdef CONFIG_CGROUP_PINS
+
+struct pins_cgroup *get_pins_cg(struct task_struct *task);
+void put_pins_cg(struct pins_cgroup *cg);
+void pins_uncharge(struct pins_cgroup *pins, int num);
+bool pins_try_charge(struct pins_cgroup *pins, int num);
+
+#else /* CONFIG_CGROUP_PINS */
+
+static inline struct pins_cgroup *get_pins_cg(struct task_struct *task)
+{
+	return NULL;
+}
+
+static inline void put_pins_cg(struct pins_cgroup *cg) {}
+static inline void pins_uncharge(struct pins_cgroup *pins, int num) {}
+static inline bool pins_try_charge(struct pins_cgroup *pins, int num) { return 1; }
+
+#endif /* CONFIG_CGROUP_PINS */
+
 #endif /* _LINUX_CGROUP_H */
diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index 4452354..c1b4aab 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -65,6 +65,10 @@ SUBSYS(rdma)
 SUBSYS(misc)
 #endif
 
+#if IS_ENABLED(CONFIG_CGROUP_PINS)
+SUBSYS(pins)
+#endif
+
 /*
  * The following subsystems are not supported on the default hierarchy.
  */
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209..4472043 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1183,6 +1183,17 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config CGROUP_PINS
+    bool "Cgroup controller for pinned and locked memory"
+    depends on CGROUPS
+    default y
+    help
+      Having too much memory pinned or locked can lead to system
+      instability due to increased likelihood of encountering
+      out-of-memory conditions. Select this option to enable a cgroup
+      controller which can be used to limit the overall number of
+      pages procceses in a cgroup may lock or have pinned by drivers.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/Makefile b/mm/Makefile
index 8e105e5..81db189 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -138,3 +138,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_CGROUP_PINS) += pins_cgroup.o
diff --git a/mm/pins_cgroup.c b/mm/pins_cgroup.c
new file mode 100644
index 0000000..2d8c6c7
--- /dev/null
+++ b/mm/pins_cgroup.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Controller for cgroups limiting number of pages pinned for FOLL_LONGETERM.
+ *
+ * Copyright (C) 2022 Alistair Popple <apopple@nvidia.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/threads.h>
+#include <linux/atomic.h>
+#include <linux/cgroup.h>
+#include <linux/slab.h>
+#include <linux/sched/task.h>
+
+#define PINS_MAX (-1ULL)
+#define PINS_MAX_STR "max"
+
+struct pins_cgroup {
+	struct cgroup_subsys_state	css;
+
+	atomic64_t			counter;
+	atomic64_t			limit;
+
+	struct cgroup_file		events_file;
+	atomic64_t			events_limit;
+};
+
+static struct pins_cgroup *css_pins(struct cgroup_subsys_state *css)
+{
+	return container_of(css, struct pins_cgroup, css);
+}
+
+static struct pins_cgroup *parent_pins(struct pins_cgroup *pins)
+{
+	return css_pins(pins->css.parent);
+}
+
+struct pins_cgroup *get_pins_cg(struct task_struct *task)
+{
+	return css_pins(task_get_css(task, pins_cgrp_id));
+}
+
+void put_pins_cg(struct pins_cgroup *cg)
+{
+	css_put(&cg->css);
+}
+
+static struct cgroup_subsys_state *
+pins_css_alloc(struct cgroup_subsys_state *parent)
+{
+	struct pins_cgroup *pins;
+
+	pins = kzalloc(sizeof(struct pins_cgroup), GFP_KERNEL);
+	if (!pins)
+		return ERR_PTR(-ENOMEM);
+
+	atomic64_set(&pins->counter, 0);
+	atomic64_set(&pins->limit, PINS_MAX);
+	atomic64_set(&pins->events_limit, 0);
+	return &pins->css;
+}
+
+static void pins_css_free(struct cgroup_subsys_state *css)
+{
+	kfree(css_pins(css));
+}
+
+/**
+ * pins_cancel - uncharge the local pin count
+ * @pins: the pin cgroup state
+ * @num: the number of pins to cancel
+ *
+ * This function will WARN if the pin count goes under 0, because such a case is
+ * a bug in the pins controller proper.
+ */
+void pins_cancel(struct pins_cgroup *pins, int num)
+{
+	/*
+	 * A negative count (or overflow for that matter) is invalid,
+	 * and indicates a bug in the `pins` controller proper.
+	 */
+	WARN_ON_ONCE(atomic64_add_negative(-num, &pins->counter));
+}
+
+/**
+ * pins_uncharge - hierarchically uncharge the pin count
+ * @pins: the pin cgroup state
+ * @num: the number of pins to uncharge
+ */
+void pins_uncharge(struct pins_cgroup *pins, int num)
+{
+	struct pins_cgroup *p;
+
+	for (p = pins; parent_pins(p); p = parent_pins(p))
+		pins_cancel(p, num);
+}
+
+/**
+ * pins_charge - hierarchically charge the pin count
+ * @pins: the pin cgroup state
+ * @num: the number of pins to charge
+ *
+ * This function does *not* follow the pin limit set. It cannot fail and the new
+ * pin count may exceed the limit. This is only used for reverting failed
+ * attaches, where there is no other way out than violating the limit.
+ */
+static void pins_charge(struct pins_cgroup *pins, int num)
+{
+	struct pins_cgroup *p;
+
+	for (p = pins; parent_pins(p); p = parent_pins(p))
+		atomic64_add(num, &p->counter);
+}
+
+/**
+ * pins_try_charge - hierarchically try to charge the pin count
+ * @pins: the pin cgroup state
+ * @num: the number of pins to charge
+ *
+ * This function follows the set limit. It will fail if the charge would cause
+ * the new value to exceed the hierarchical limit. Returns true if the charge
+ * succeeded, false otherwise.
+ */
+bool pins_try_charge(struct pins_cgroup *pins, int num)
+{
+	struct pins_cgroup *p, *q;
+
+	for (p = pins; parent_pins(p); p = parent_pins(p)) {
+		uint64_t new = atomic64_add_return(num, &p->counter);
+		uint64_t limit = atomic64_read(&p->limit);
+
+		if (limit != PINS_MAX && new > limit)
+			goto revert;
+	}
+
+	return true;
+
+revert:
+	for (q = pins; q != p; q = parent_pins(q))
+		pins_cancel(q, num);
+	pins_cancel(p, num);
+
+	return false;
+}
+
+static int pins_can_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *dst_css;
+	struct task_struct *task;
+
+	cgroup_taskset_for_each(task, dst_css, tset) {
+		struct pins_cgroup *pins = css_pins(dst_css);
+		struct cgroup_subsys_state *old_css;
+		struct pins_cgroup *old_pins;
+
+		old_css = task_css(task, pins_cgrp_id);
+		old_pins = css_pins(old_css);
+
+		pins_charge(pins, task->mm->locked_vm);
+		pins_uncharge(old_pins, task->mm->locked_vm);
+	}
+
+	return 0;
+}
+
+static void pins_cancel_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *dst_css;
+	struct task_struct *task;
+
+	cgroup_taskset_for_each(task, dst_css, tset) {
+		struct pins_cgroup *pins = css_pins(dst_css);
+		struct cgroup_subsys_state *old_css;
+		struct pins_cgroup *old_pins;
+
+		old_css = task_css(task, pins_cgrp_id);
+		old_pins = css_pins(old_css);
+
+		pins_charge(old_pins, task->mm->locked_vm);
+		pins_uncharge(pins, task->mm->locked_vm);
+	}
+}
+
+
+static ssize_t pins_max_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off)
+{
+	struct cgroup_subsys_state *css = of_css(of);
+	struct pins_cgroup *pins = css_pins(css);
+	uint64_t limit;
+	int err;
+
+	buf = strstrip(buf);
+	if (!strcmp(buf, PINS_MAX_STR)) {
+		limit = PINS_MAX;
+		goto set_limit;
+	}
+
+	err = kstrtoll(buf, 0, &limit);
+	if (err)
+		return err;
+
+	if (limit < 0 || limit >= PINS_MAX)
+		return -EINVAL;
+
+set_limit:
+	/*
+	 * Limit updates don't need to be mutex'd, since it isn't
+	 * critical that any racing fork()s follow the new limit.
+	 */
+	atomic64_set(&pins->limit, limit);
+	return nbytes;
+}
+
+static int pins_max_show(struct seq_file *sf, void *v)
+{
+	struct cgroup_subsys_state *css = seq_css(sf);
+	struct pins_cgroup *pins = css_pins(css);
+	uint64_t limit = atomic64_read(&pins->limit);
+
+	if (limit >= PINS_MAX)
+		seq_printf(sf, "%s\n", PINS_MAX_STR);
+	else
+		seq_printf(sf, "%lld\n", limit);
+
+	return 0;
+}
+
+static s64 pins_current_read(struct cgroup_subsys_state *css,
+			     struct cftype *cft)
+{
+	struct pins_cgroup *pins = css_pins(css);
+
+	return atomic64_read(&pins->counter);
+}
+
+static int pins_events_show(struct seq_file *sf, void *v)
+{
+	struct pins_cgroup *pins = css_pins(seq_css(sf));
+
+	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&pins->events_limit));
+	return 0;
+}
+
+static struct cftype pins_files[] = {
+	{
+		.name = "max",
+		.write = pins_max_write,
+		.seq_show = pins_max_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "current",
+		.read_s64 = pins_current_read,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "events",
+		.seq_show = pins_events_show,
+		.file_offset = offsetof(struct pins_cgroup, events_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{ }	/* terminate */
+};
+
+struct cgroup_subsys pins_cgrp_subsys = {
+	.css_alloc = pins_css_alloc,
+	.css_free = pins_css_free,
+	.legacy_cftypes = pins_files,
+	.dfl_cftypes = pins_files,
+	.can_attach = pins_can_attach,
+	.cancel_attach = pins_cancel_attach,
+};
-- 
git-series 0.9.1
