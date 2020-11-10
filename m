Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F23C2ACE4E
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 05:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgKJEId (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 23:08:33 -0500
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:57757
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732232AbgKJEId (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Nov 2020 23:08:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/oZZui8XqujsVDyhF0WP+W/pPGBseOJjLSRlWSXIW/UrmO+HwDj/WACoQkMEheyB6qKxsMATSJQtePcXnqRTY6f+dVYgpUbdU4eX7JZ6xhblMUbxzr9MKmvq9mwVujSEwMITforotJEO7fzZ8TD3aiqPIbJ5nTPPTwr/FVKLfUlU63sR4ls4481TjTq2XnunxCzFyQXQB1/iYnzeV1r8AnROGJD1V5JCpOWP4To64kqR6mzUeORTgKCD4FdrpWWsqf13Ue7JSEfwaLoBYmmfT112qCzmizZSKrQH8PmLhLEXEpqftz3Bgdcekc0ffM+c+LuX/KxRnyIPJPkvYCj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFSsm2jr4JRhYEyFiwGRdWnuSdL6qjQnvQIKhWnnw4c=;
 b=CeNf7opD2uSIcRA0Wtapooficx3Q1/A6pUnTwGtOIOpIb62HXty/6KgiGF8FW/fqOiZmNNhJ6zbE9fniXNyTimB4fO//NSivx0msJS9kl/arnMwPXPXW7bDf5j19FuLie2JR0QHImyXWKmyAIeoRka+r6g9ME0xm34PQCfOvOl7jHerQI0Ht295WhMlPhCjknW7NpuGTgw+zheyUkS3GFjRsk2o+NuJ/LJqAttUJaj+obLYBYOT7cL4c93h4mRUGpoer+PFZs8CJu1vLUAGjJnK/nN4vUnYfpKv5Q9YjyG1dYrdZ9axd7sHa6pH3dpxovg+g0YecPYqVoezBsSpTlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFSsm2jr4JRhYEyFiwGRdWnuSdL6qjQnvQIKhWnnw4c=;
 b=hHvIPjV4GKQF1MeCl1ATplInOuT0gXVXH0jeGkIVtE2nTn2zjphq9XFH69wXw07vQ1OW59ok5PF0mk0YFooKMo1WBJwFAzJAmTWdr3MumJO9QTUX+hQqXOKkqYUr0aUulmHDkk7H5e/lyFO6dpHVQMAZy6ov/sZ5MNhk65R6ux4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4489.namprd11.prod.outlook.com (2603:10b6:5:203::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 04:07:56 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 04:07:56 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, rdunlap@infradead.org,
        colin.king@canonical.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/4] cpumask: make "all" alias global and not just RCU
Date:   Mon,  9 Nov 2020 23:07:23 -0500
Message-Id: <20201110040725.1478297-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110040725.1478297-1-paul.gortmaker@windriver.com>
References: <20201110040725.1478297-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::15) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from t5610.wrs.com (128.224.252.2) by YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 04:07:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b213eac8-9662-4961-427c-08d8852e3440
X-MS-TrafficTypeDiagnostic: DM6PR11MB4489:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4489B3A1079BAA4761BE6F9883E90@DM6PR11MB4489.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JCFeKW6r8x29Jd9aHLJmcQ+cspUWkBzUDlrl2hpg6fbbARh4M7u8iHmkzcSQ0DuwMuMtWUKP2FcVixueyUeFiUmAHfB7dvDnwmEq89dImJJ+sDxNs9Lb1Mwd0BL7cBLNK0Ty1ZWjNTgVJhWohbQGJIm9Be2m/EXvMvR+oEK5xcxjA6h/LaauFoawNZDhhdsWJ4afLzpja8qijuNZd6Svmzj8eNhpVcefePtyJhJwb9cwZHvCJFa4DR+r/Jr5aB350Hi3PhNnaabw7koJ096y89SuORxHB7Wd3a7vqM6AgG90kdo24+dwfgMBEKbNlHvi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(366004)(136003)(2616005)(1076003)(956004)(107886003)(26005)(6506007)(16526019)(186003)(52116002)(6666004)(4326008)(6486002)(83380400001)(5660300002)(66556008)(66946007)(66476007)(8936002)(2906002)(6512007)(8676002)(36756003)(6916009)(316002)(86362001)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PFCbA20AK9zuswC0vRDMCP2k6D9SKLd2ojj8C56HienKjSIcPEbkOl6hrNlw1ck67vgBQXxkiaTYmRIVkjKuK0xJaSWnd3IvLbrn7TDgGlgF6N0eHfO5ZCv3DH5fC8yklU26RA3hp34u3yFR0qJbrLrvs5eyVe48E/B3iuE9dnBJgKoBzlt/igoNqHf4dut8ZHv9GY2Im5x2gxf7ZET5eIqozWhRfbteDbKcou+B3ECLv3qPGx5f5emb3v8rE0oik+f0sno5yPJG4/n7CR2YYBD+T5D4Ml16irYDZL5s/zceFPU38820wvxHtl/txwYFodnYsPsRqWAlYD+EoW/eeT3aroRPjCUjeSYVBycSvimmMf/ihfKvnz7t8FyvyQRDa4aj8RpexJ4g4ltOQK5mIU+ABJRD/9GlOY6q9uSD5Ct9QMeeRdsKGBXLppVK+0vVGxuf2zEbx0VNDsx1KlLR9nOeLhy/5u3yHsznBRH04+kWfc1XftcaHWn2cEfwoKRAa3CC4lVos4Qs5PF6k2OBy1pTOU00CzfshQ3vHVRq5oYTHgNuAdRZm1QjOQ26aqNFd4ID5oFJFbYD2nNTeYzlK1hQiS61BDdLy0KHIibCcp7qgJ0wngyPegsaXsF8BUzSWYPmSTKAuKWVe1EEvVdyUQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b213eac8-9662-4961-427c-08d8852e3440
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 04:07:56.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCJbE7V7vzINPXXzwTPO7pV/O2HW1Ay7XUaWSXUPxUhGD6pyfeBI4xgyoLRQ3GXRBqQR7ITW6UaZY0x4Z1fhCbpSc39k9+EkoZSpKvyAcBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4489
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is probably better that we don't have subsystem specific
abbreviations or aliases for generic CPU list specifications.

Hence we move the "all" from RCU out to lib/ so that it can be
used in any instance where CPU lists are being parsed.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.rst |  7 +++++++
 Documentation/admin-guide/kernel-parameters.txt |  4 +---
 kernel/rcu/tree_plugin.h                        | 13 ++++---------
 lib/cpumask.c                                   |  6 ++++++
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 6d421694d98e..ef98ca700946 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -68,6 +68,13 @@ For example one can add to the command line following parameter:
 
 where the final item represents CPUs 100,101,125,126,150,151,...
 
+The following convenience aliases are also accepted and used:
+
+        foo_cpus=all
+
+is equivalent to "foo_cpus=0-N" -- where "N" is the numerically last CPU on
+the system, thus avoiding looking up the value in "/sys/devices/system/cpu"
+in advance on each deployed system.
 
 
 This document may not be entirely up to date and comprehensive. The command
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..96eed72f02a2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4023,9 +4023,7 @@
 				see CONFIG_RAS_CEC help text.
 
 	rcu_nocbs=	[KNL]
-			The argument is a cpu list, as described above,
-			except that the string "all" can be used to
-			specify every CPU on the system.
+			The argument is a cpu list, as described above.
 
 			In kernels built with CONFIG_RCU_NOCB_CPU=y, set
 			the specified list of CPUs to be no-callback CPUs.
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fd8a52e9a887..b18f89f94fd3 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1463,20 +1463,15 @@ static void rcu_cleanup_after_idle(void)
 
 /*
  * Parse the boot-time rcu_nocb_mask CPU list from the kernel parameters.
- * The string after the "rcu_nocbs=" is either "all" for all CPUs, or a
- * comma-separated list of CPUs and/or CPU ranges.  If an invalid list is
- * given, a warning is emitted and all CPUs are offloaded.
+ * If the list is invalid, a warning is emitted and all CPUs are offloaded.
  */
 static int __init rcu_nocb_setup(char *str)
 {
 	alloc_bootmem_cpumask_var(&rcu_nocb_mask);
-	if (!strcasecmp(str, "all"))
+	if (cpulist_parse(str, rcu_nocb_mask)) {
+		pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
 		cpumask_setall(rcu_nocb_mask);
-	else
-		if (cpulist_parse(str, rcu_nocb_mask)) {
-			pr_warn("rcu_nocbs= bad CPU range, all CPUs set\n");
-			cpumask_setall(rcu_nocb_mask);
-		}
+	}
 	return 1;
 }
 __setup("rcu_nocbs=", rcu_nocb_setup);
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 5eb002237404..15599cdf5db6 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -2,6 +2,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -104,6 +105,11 @@ EXPORT_SYMBOL(cpumask_next_wrap);
  */
 int cpulist_parse(const char *buf, struct cpumask *dstp)
 {
+	if (!strcmp(buf, "all")) {
+		cpumask_setall(dstp);
+		return 0;
+	}
+
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
 EXPORT_SYMBOL(cpulist_parse);
-- 
2.25.1

