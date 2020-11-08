Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67FE32AAC16
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 17:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKHQJB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 11:09:01 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:6816
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728083AbgKHQJA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 11:09:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdnWRkdMJv/bxNfAVxbqLpNwFWqVhHoaVud+6DSARsToR1Y8KXo+oDT0gkpRW5DQ7JfdSkK4h97ZxDZ4VCDChE48g0GY3GCROV995UHsnPMzbC5nG96XnPl0T9zLrz8Obct1popkriDHLJ7JeSbUyypTtR6TkAHC3yeclvRBCtnb3vZ3SCM4PEcY9xsw91hhIJXku5zuxspZU2w7IXZWgxTPbh6zgtvQC2xMp/pjeFQ+YvRhSvRwi8pFiAJmFzhwnmubYQAx89EE5MaUtyXoLFivHgmme6UDOKeo3+1NaHhLcwbbdanlfLLQKr1hNIPMgUsnehprfwi7UMCA+/xBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFSsm2jr4JRhYEyFiwGRdWnuSdL6qjQnvQIKhWnnw4c=;
 b=AKwiRavU7qkQeUWGkBb01ZKxN07dzKXiITnJC4rl5VL8PbsyTH6gbq8NEAueMAAgkqTExh0Ew9zOKhVdN7aT2ApWhw69mHJkqizYt8ppIXSzVeLEOtan8YjrcpIsSbaIgbO1rfbTZMOqt6kUMNEGMsRcygH/xQhyjHb7ipdPliFlbpz/S7Py1fFOehCLL9GXspJLKmLnYKdft7uVQQ+ghGme6yJEnuMh7K/lXaHXJd2WyaFMGgb5XhrI2vS9B1r4Kww6MrT7QIwuJgvnuLm9Mpck5tvwclLlH4OTKIR0Tn9q1L3KYDcsbBZ0E0RzGMriZewagcnlLj4kCpaE0po6SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFSsm2jr4JRhYEyFiwGRdWnuSdL6qjQnvQIKhWnnw4c=;
 b=Q+3BTfcoO1dVl/lKvIYqc76ucV+kf9zOLmXzNMe+a96WEYwrOFaTFjhYWd6b+hVwt7Cj4UvzhqeQCZSwNwUAymMBcrEmo2B3kZkbN92vtYBPz8yAFKMBevye2Fl++/sRZDbAE2DJljU2KhW12v9vkfwiuCLT81AMgzvbMhjlgOY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3579.namprd11.prod.outlook.com (2603:10b6:5:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 16:08:49 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 16:08:49 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/4] cpumask: make "all" alias global and not just RCU
Date:   Sun,  8 Nov 2020 11:08:14 -0500
Message-Id: <20201108160816.896881-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201108160816.896881-1-paul.gortmaker@windriver.com>
References: <20201108160816.896881-1-paul.gortmaker@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::38)
 To DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from t5610.wrs.com (128.224.252.2) by YT1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend Transport; Sun, 8 Nov 2020 16:08:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 344d0e70-75e3-46c6-ca00-08d88400945e
X-MS-TrafficTypeDiagnostic: DM6PR11MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB357914455B32DF6EF6CCD5AB83EB0@DM6PR11MB3579.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQaWAnYpHw32TNW1D6OQ4x68ov+mcruYRH1/mb5Ly36vH9Lwpdul8zEpoM8STG8fxJn58Hp8Uah1Hy9uCPobNuryxx7qxXOTXc+J4OCLFRaaH9qtfZxWPsvhAE0PgjpJycpB8pH58HX9OKM95ltndNsKQeU7BCUCSneBHgxjYk3laA+Sxu7TAPmIjiRTph/X8moQfSQSnPPvYMYsudxjDtsYHTu50rpVrN4oPYpCncxDO52DIXeWkLu4/i38nUpH/MtO7+wcij3bpp43Ri+FewTDZ99EyrkdEEg8FBH9jEcTcjRw+BAASJ5iBV7t9pRw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(396003)(376002)(136003)(346002)(450100002)(44832011)(1076003)(8936002)(6512007)(8676002)(86362001)(6666004)(2616005)(956004)(478600001)(52116002)(83380400001)(26005)(107886003)(316002)(6506007)(66556008)(66946007)(4326008)(6916009)(66476007)(6486002)(186003)(2906002)(36756003)(5660300002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9BoO49VRUNeZT9e7e8s2Fy1nnjtkMWgBlccYWfJzbDqSmIrYLk0y8m8XGe24MBwtzlAfvqLGEW7toN9Omp0ctAxSroIgDJwp3AtF3zGlZxqkYI8mejr523lSj2QBep+zbhR7zkhQ3kb7tDPbWWKz41T9p6r82bZIZ119Ua8zvhOKo59HkckotdpY8gIFi2WIoNX/0e9UgATcapHdhhv4n2wabFcSMyPF+jEkV5f1p0Cks2owxLtYLrDQPHEuzWif1CNLiVltvq/Rg7m9yLV8ATz0xWYSY7xMBKwe/XgYOEl289ky8GRs3w7upxu8wzea3wwwKhdQ7JS3gLMgcto/tGAkcs6A2uu+VAw2i7okZx7eQ72ILi1SfA8+kQ1S1keWzXb19d2MV5IjVx4lLLy+Y85CAVXZ2/7efbjVJQAO54H00N3JUaZVlAVCyBCh8vmgNtR9Qk/SM/bD/oSzHcqWcBiB1aZx71o6MxNuta968IqoeIGZPwKm3ufpT8+LPWH6UB5INd3iat3R7alxCHvzuS3rN0sdpvDdsFtaAWl4v1DQEQASbGDK0xtGXdmByVn9cboLQ8ckn5YnGSboP7EyNcqOVi2L3ONyb/croAMgKVZ2HZBpg1+ccSPiDs4cAAYAdY3xE9Gdjbtmy+zbFLOD4g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344d0e70-75e3-46c6-ca00-08d88400945e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 16:08:49.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9AFezSF65XMfLf1LFvh25qibe7OlBODCr//4Nf7hl4xni0IEEGWBgcNfhF1m09szMqkyJwh1RFO1JF4C3DKxOi5xtLFGH6HeKs9zH+yiNWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3579
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

