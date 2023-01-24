Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1793F679067
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjAXFuU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjAXFuF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:50:05 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10403CE3B;
        Mon, 23 Jan 2023 21:49:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkW8CO5oKBeC31hC8SqYp1hdcPQ77SEEaemY6tPRsGgxa01LRZjW76UQaQ8XPTSviUdxK7FwwH51X7SRl7KrwiW+1jSyuijAtQSGqHEfQBr2sDJ0kuUo8XGxNRssXlif3T5T9I6mQSAf0msLJIjBhE8l+FrRcBOjj+CnBPDEt9hbVOg/DAEE8z1PQzpcFNyk+CiUIn9suBlAUjYCXbqDf9TQcPp1H5J/y153tfflUbvrpSYX2qewBHUTqWTOL/as+ciPLkcn/MYBULMhWvMd0tOd321FJYKHgjQyQGA4XFtc4cuT2St/QsJPypJ+9Pc3RnAb4GoSWmimYhQNv3WJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYENaESUmkouh77B5LvetjBP009/977IJw8aWG3YGvY=;
 b=axREdmO3jxkeMm8A8+eYDUKBGQ7HlYxXEuFNPsudsjQQYRwbhVZg9X33ZGoO1FWzntDP8rZLfWYlwFQnvV+M7BkPv0FTLid0WX9gU4aSxu0h3TdDJczHm2JwvcEa3Up12JKrZOnlys5FotPQ4SadJAtWzFTkK9ubwbZ5EvX8DWAQlS7AUVKAfsiURIUPKTXyHQ5cwy+jXRV8uKWz1iJsy+l0Myl8hqBDBN8EpkKbUXBIt0eZLWo4fbUvLsVrprl82ghPhoLavLnhtPKScT2UWHY3s1oA3ptsdpBxGLlF7zIhUWqdlLiI83Z/mxSET4LMXDTIrGKSempAHohsYhgrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYENaESUmkouh77B5LvetjBP009/977IJw8aWG3YGvY=;
 b=DZuLdAMwy1AlNDFcAukTIVBL2yrLQknf/VrgFP5xxffSlS22dm4r2ydYi27XErd8sffS51YQv6AHLQ0Ri7f+2Zu0OTuqafHOFr62th2AhBnMcnmbAnEy5yswKnkkZPGfZxMoA/mco/nIrQOZ1VknYcbokGBtJI+dxyaE1VYHu4yhkeKEz0N2ssTUF1CvkW3q/FKIbXI9iZ3u+xTiJtkMnj8f8oBPFb0m9Drl/SyABWMiqZvJ5athhjHx1/HCE4iv/C9fdUuJHTyKnFE6S+1v1IEPOEn2aEmwve3pZF138fYKdchB/SQdGD9F/+Mya7BBbKe/xUh0PQizUTUNwqjh9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:48:00 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:48:00 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 14/19] mm: Introduce a cgroup for pinned memory
Date:   Tue, 24 Jan 2023 16:42:43 +1100
Message-Id: <183372b80aac73e640d9f5ac3c742d505fc6c1f2.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0128.ausprd01.prod.outlook.com
 (2603:10c6:10:5::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: dc182cd2-fdb2-42e0-4f57-08dafdce8d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aRdvV5lKgZRqv5YsUcdGL308yIc/tTqhp5JUegyzR1ML8QZUsB4e0FgFYg+JdbcsL84SBh2KbJnFRYZrjaRuI7JLIJpq7ip7cRffhfFurVVYrBsETVVeU3XClXQFV9CFCa34MtFfM73LOT3Atjj7HtDQOoD5AVVHKSv7ogG+duxVfrlFGMvZXn2sEmCN7sftSVX6j2C6lUZaIIJW6/zkcapb9ypcNn+slvL+59VetbpiLPLCLGfK795dJ+NEj81OzkdyksgfQj7c6fZmpwYO9JBDL27kAcNUgJqKYlB1Et/Cfje4re5yi4+TheU6MEI/Gpy32rBQjh/Kyv8FgaRJjEZdNwl+qrydozviYcWhNpD6OtjPQ5Wv9UKeaaoeLLsvhqBsfWl2oH2zOnDBz2GYQtkE38rjR9qaZlDRcuoqLpNehQhxoAhvaHEkF4uwdOdJiJVQjzmC5oC8orqzFARhVkrlGPIMdvy9PkR5oe0NFobarWSmFDy3cTC7PpKEryibzvSf1tr0SwahmcWmPec6eV+rM3XK5BbVFhAk937B9C0cxTXNd8bV3D8N3VpR+Wcjmj//b5+YQC+HEkiHxMN2jesj101nRAyWSdUUNq8BHZE0+sxPsF4yLrN/0PVHRe5i++Bs4crNqKakfQBnazHN8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(36756003)(316002)(4326008)(66556008)(66476007)(8676002)(86362001)(66946007)(186003)(54906003)(26005)(6512007)(6506007)(6666004)(83380400001)(6486002)(478600001)(2616005)(30864003)(7416002)(5660300002)(8936002)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CQy+/yePQeHckVtod6yxX+bR9BQnCfoLtXM9V4jO2WmlZfEAr0WHL+X45yZR?=
 =?us-ascii?Q?q93lFAUUsLDnXxh23L8XsM2/oMW4T32CdKVaT3KE23bA5NQIS8p9Tv15fpuE?=
 =?us-ascii?Q?dgZlI7vAsExBOXUMrnkPs/60vKgzywGYoTaqi4k+uH4KuyzuqMwXXqkNQavO?=
 =?us-ascii?Q?4BAulHy8qSEJ9n8VVK3yGc2u7gpq4mcHhEAIJlC8ZWrceb1FxQRd0+eB9Nz7?=
 =?us-ascii?Q?IiZnpHTAeGwrRRO2yPrGP/nyIjGV7XT1xBJR0RJT2Zbg4sD7bJ9XY+/vsyCE?=
 =?us-ascii?Q?NcIJewtF53OAQ433rvKOsq+hMpV5Om6yi2ecPv5YT+nMU9h8pGNvQmPXQViL?=
 =?us-ascii?Q?myz9Wztsouh/DuaP6Q5vVQsK7Pzjiu7zXa+LB/P07ZFOOxLjcj69Ich2NGe0?=
 =?us-ascii?Q?PukY6wiXDvbQDkmrwJtHPwh6jgB6E427/GOqQcM16j8jffoWfwAbFkjUhW4Z?=
 =?us-ascii?Q?3WTEoxlAtcxYWDxNEPFkEQp8y4HO4ySpnAsnkPrJydQXhtxkvUgiU7h4s0pS?=
 =?us-ascii?Q?vjZSWiJGhlyr3tmmhBeD7+V5+KPh9K0PsO9aFv7wCJCVkPuoHk8pkF7YMYO+?=
 =?us-ascii?Q?5KjgPQUL0gm9ma92F+vps9q8vxwMc64YnR4jVCNS3YTgDpmcUJHwmWxBzOKC?=
 =?us-ascii?Q?9ieMG010c2qLhEDulFpifQ/bLgIASy5g9mvzxSoTc+pyKmj+v8xrBR/7hHJU?=
 =?us-ascii?Q?9sBPEC0jazP0TZOsXReLnt0JWhaJxSJnr22GsMfJY5EnzxOrkuROR6GsVcfd?=
 =?us-ascii?Q?pHg70s1IjKG47UdM/FtTGp4lO1BU3+ie69SC6wkG+KiyiPCcEAuLM9Ic/i+6?=
 =?us-ascii?Q?OtSHVDjhWFOl5alv3mwfJD5qHqhBy02akCKEeTdb7cD81ij2FvoeqHGgJZo/?=
 =?us-ascii?Q?hBQ4kf+JOalA1K/9OCecJXusbGDwqpMh3wslhJi+HTVg/3fvzYyXSqAvC/7X?=
 =?us-ascii?Q?jwWyAZMjRv1S3gTnrGczpgF0aw3/W2g9jCDF/bg7gRRh3GfbcCiSsFW9sIot?=
 =?us-ascii?Q?ixtxOZlDMF0UyTqGu0zqZb4RW9rlcG6KywI/CduKAQGIuHzKi4z64LdlFnxm?=
 =?us-ascii?Q?fwEZ3DLqi3eKCKY23O/bbvZrw0K1edFcOq/RkdLCnr1THua3NAQ0j12wYmsa?=
 =?us-ascii?Q?tXsPojCSEhNMeEXwUQE6AnUm6PARfYGwXqIVEnUbT7xfBsjKr3Up5M8VSmiB?=
 =?us-ascii?Q?9XyxYR24aD+ScgNle+DIk7jqo+OWPSAxdXxvJHtFA5o6PFLs0JmgWo0iDg9O?=
 =?us-ascii?Q?srSvOPvzfPt07PwNjms4zebcm6p13/myN4i6c9m/PODJRb2rS/R3+Ii2g1rK?=
 =?us-ascii?Q?8IEV0/n7c7jdPhLhO6QiiQ5jCi/huQuGMmWxbpuU4KluHRFYHjp8d3hgS7VW?=
 =?us-ascii?Q?3CfVHvY7KXvWxVGiLB2cIqAPFfD2geW5PFRW/J5GZ/ZYdJv8Sy2+FfO0McFx?=
 =?us-ascii?Q?jOSH9wHkETYxOuqSG0f9qilG3253jSfgM7wgAKfRApkQeaENl8gfT/pxqHaT?=
 =?us-ascii?Q?unI92DXJBfGWf0444UQe8Vlbx+7D+Qlnip+SWP/TcDhnmZQlwPALqc7Lvyxz?=
 =?us-ascii?Q?y+NQCrtWMPmTcNH0xc4f11ddxRqa3y+cKqwcKPz/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc182cd2-fdb2-42e0-4f57-08dafdce8d1d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:48:00.2382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hd2QmQP+D9zTYrLzOiaB/8c6g9delxecZXAmg2+5JCEWG4eSPFQW7D+37Q9TUBPNgHSiN66n5apuNt0fUeYUvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If too much memory in a system is pinned or locked it can lead to
problems such as performance degredation or in the worst case
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
index 3410aec..440f299 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -857,4 +857,24 @@ static inline void cgroup_bpf_put(struct cgroup *cgrp) {}
 
 #endif /* CONFIG_CGROUP_BPF */
 
+#ifdef CONFIG_CGROUP_PINS
+
+struct pins_cgroup *get_pins_cg(struct task_struct *task);
+void put_pins_cg(struct pins_cgroup *cg);
+void pins_uncharge(struct pins_cgroup *pins, int num);
+int pins_try_charge(struct pins_cgroup *pins, int num);
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
+static inline int pins_try_charge(struct pins_cgroup *pins, int num) { return 0; }
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
index ff7b209..7a32b98 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1183,6 +1183,17 @@ config LRU_GEN_STATS
 	  This option has a per-memcg and per-node memory overhead.
 # }
 
+config CGROUP_PINS
+    bool "Cgroup for pinned and locked memory"
+    default y
+
+    help
+      Having too much memory pinned or locked can lead to system
+      instability due to increased likelihood of encountering
+      out-of-memory conditions. Select this option to enable a cgroup
+      which can be used to limit the overall number of pages locked or
+      pinned by drivers.
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
index 0000000..cc310d5
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
+ * the new value to exceed the hierarchical limit. Returns 0 if the charge
+ * succeeded, otherwise -EAGAIN.
+ */
+int pins_try_charge(struct pins_cgroup *pins, int num)
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
+	return 0;
+
+revert:
+	for (q = pins; q != p; q = parent_pins(q))
+		pins_cancel(q, num);
+	pins_cancel(p, num);
+
+	return -EAGAIN;
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
