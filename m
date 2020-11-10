Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74EB2ACE50
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 05:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgKJEIp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 23:08:45 -0500
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:57757
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732494AbgKJEIg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Nov 2020 23:08:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFZbPjaw87bdvTn6VcURYxLJYf0XB4ZjBumoqo4XnKr10w60d/0dOoAll59WNfSJ+SLaB+f4ZGwoSOf1JhhHtxdgit5cQObCFjRHegQlmm7Bi0xbQfbj4rfrruaZvxY2GtW1W+UKXlfnUYOmZOPRFqL6kq3yPiMS4sIxKRo4tdJsV/bJHJgrnadyPY6dpcxoDlKLvKbbkbmZBGIWjwQRWqO0Q59Fp8Hg71XJ/BUoGozt0AMB/hvhQ7JeTGtJ2x9+Hqtd6ZqWnT1XLuzfFXDbRqGr0tay3Ij59ZRCB84SHEZMjdX5tFAUdbo0q45SXBLiZKL9zFkfnYUbMqjKqk31nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zFtvUKYzBo1LRdjZVqEx1fqA9SOVULU4a8jZZziy74=;
 b=L8ssjjuf+zZNvfaBkOsngKDeKpmiEQwt4v+eW4jA9OkHc9fDnBVMdpC6erRY7fK928kjhrFoh3tMxyPXivoeB5fcRWbTxHBPT5ZmWCYj/Ckwv5bHffx/meVXQCJm4Fb7eguBFpMt81Pj7WYTRKTlhjtCHZC8W6dWl5zp9l0n90gXjZl/B3RHqQTj6viGLjPWtWYHK73Aexck6bWCeje/ckgyjuUqqAktwbiZqXLPtgwyCuwzj7pUc+TZjYg97IJw3EyGO65zToEKnISlEmLZo6BoNmNI+kIZtmM1kry/EgaDAR5wy5iW/KXsItQfuQ17mt5TyIRVhElMmue5j/0f2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zFtvUKYzBo1LRdjZVqEx1fqA9SOVULU4a8jZZziy74=;
 b=TmGkZ+YUoTyOjwcIStvIko0xUUqPnPhrSu7/rrIJAHEuewtiR4VQZNqH8LW7Fb1gLI8xlKLEdaeJbzTP9gfB1ijw+BMru71BRBmkyvkvX2RTOlHJqLrUg8oHEcpKnB6WvNxcZ+NoylRT0NXXHRhJyXPHtydNFBb2Hqnf6OP0DwI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4489.namprd11.prod.outlook.com (2603:10b6:5:203::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Tue, 10 Nov
 2020 04:07:57 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 04:07:57 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, rdunlap@infradead.org,
        colin.king@canonical.com,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/4] cpumask: add "last" alias for cpu list specifications
Date:   Mon,  9 Nov 2020 23:07:25 -0500
Message-Id: <20201110040725.1478297-5-paul.gortmaker@windriver.com>
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
Received: from t5610.wrs.com (128.224.252.2) by YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 04:07:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec6accbb-6f18-4a60-c173-08d8852e34f9
X-MS-TrafficTypeDiagnostic: DM6PR11MB4489:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB4489F4F69ED6376BC1DC9DED83E90@DM6PR11MB4489.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UtIWmRKYP9E3Q+qX0SfDOqaEcZFRwEl5G2hxdI+GQqo7C0HlmJUMP8zhca7wtUoNRuA5npe8pno5UTaPD6c6WTQizRWjt9IdmiYaWhVKZR9ZP+FE85ccDHKYm5EqDEMAYCyZyC2TG1ESD7kChmEg79y2M5Mfrdt7tdoLJcIQBiTqMs58ACW/JaNofJnSqAYnBe6A6VBhgLQnJ4S4CcCdDQSHErpFxWafu8EoZVZiYSXFx6Z4etDzaied5UBU0peIGaXg1E8P1OwABsmoEktbmtn8yFmbf4Dq4ULFPZExuow5vRx8W9aZ0tmK/FmsxViv/DStw4W/GvySq9dCDOPaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(366004)(136003)(2616005)(1076003)(956004)(107886003)(26005)(6506007)(16526019)(186003)(52116002)(6666004)(4326008)(6486002)(83380400001)(5660300002)(66556008)(66946007)(66476007)(8936002)(2906002)(6512007)(8676002)(36756003)(6916009)(316002)(86362001)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: r9Eqogh7SFXFF5lmmz/yNMZ7l/wv0WggAlsVcexpODr2oqFAucR5GM3SNqRmweSD+h0QomHCYPmx7m8mTJIpiyNgy20i1y1iuwhiwoIXZ0dDjAkIw5hInJOpJX6q9jZ1zv5uoANUcQwOdiL/vjIII9An5PSK6of+Dz3ekbjz2yPkZ6AOJtGUuVuK13VkqUsgY9MUFW4FURgacPiuop8l1eCUx+f7f3AOsM4YHqlmPzQ/m4UThSBlXh4q0eU/M6mVZhjYhyFeFXS+LUEkP+2RTQykPwTsMV9dUnhO+Z9pXOGXJP6fchyBbqelKP9AdakOYIQZEFZaIVy62V4zrIX+uwSgjBeavgws2P5/07psk31EchJJd1jJlszzEPg7qrod3Y/L4K4dlHkedZJEgE/qq0SZZdewqI/Tp5AidHDsLck5tTB+5JbVJlzCIwzbDAro38vl8aey/v++AJ8mrEE/dMdZ+6VpXJYnzjBVHsh69Mt3tASgn5iFK8GlqufKfSsZOy2xohjERfeqHMkGvgZePI41JbldLUYWXrtTgCv7weAtFInVepVd1L+6Uc9zHheu2R06B/tr/CqibkO+KVmKoJY5UpUWnl2UFXmx8l57M7wp2BT9EBd5hHJdOOarJewGa91mU0+ZEqQLHv+Fdv+Xow==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6accbb-6f18-4a60-c173-08d8852e34f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 04:07:57.8331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKPvyOwUY6bBDHcuqs6bWsmfsK/IvRdSdLGFhykmrMyGnMHPzyZX9XZMcC+H0C3M2y0z7WioU7ZvslvHHN9PgwVR5GIhNfZNZSKGEW6kcPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4489
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It seems that a common configuration is to use the 1st couple cores
for housekeeping tasks, and or driving a busy peripheral that generates
a lot of interrupts, or something similar.

This tends to leave the remaining ones to form a pool of similarly
configured cores to take on the real workload of interest to the user.

So on machine A - with 32 cores, it could be 0-3 for "system" and then
4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
setting up the worker pool of CPUs.

But then newer machine B is added, and it has 48 cores, and so while
the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.

Deployment would be easier if we could just simply replace 31 and 47
with "last" and let the system substitute in the actual number at boot;
a number that it knows better than we do.

No need to have custom boot args per node, no need to do a trial boot
in order to snoop /proc/cpuinfo and/or /sys/devices/system/cpu - no
more fencepost errors of using 32 and 48 instead of 31 and 47.

A generic token replacement is used to substitute "last" with the
number of CPUs present before handing off to bitmap processing.  But
it could just as easily be used to replace any placeholder token with
any other token or value only known at/after boot.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 .../admin-guide/kernel-parameters.rst         |   7 ++
 lib/cpumask.c                                 | 112 +++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 9e1c4522e1f0..362dea55034e 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -83,6 +83,13 @@ will provide an empty/cleared cpu mask for the associated boot argument.
 Note that "all" and "none" are not necessarily valid/sensible input values
 for each available parameter expecting a CPU list.
 
+        foo_cpus=1,3,5,16-last
+
+will at runtime, replace "last" with the number of the last (highest number)
+present CPU on the system.  Thus a common deployment can be used on multiple
+systems with different total number of cores present, without needing to
+evaluate the total core count in advance on each system.
+
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
 module. Loadable modules, after being loaded into the running kernel, also
diff --git a/lib/cpumask.c b/lib/cpumask.c
index eb8b1c92501e..fa56d622c1d8 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/bitops.h>
 #include <linux/string.h>
+#include <linux/ctype.h>
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/memblock.h>
@@ -96,15 +97,97 @@ int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 }
 EXPORT_SYMBOL(cpumask_next_wrap);
 
+/*
+ * Basically strstr() but given "foo", ignore "foobar", "myfoo", "foofoo"
+ * and "foo2bar" -- i.e. any case where the token is a word fragment.
+ */
+static char *cpumask_find_token(const char *str, const char *token)
+{
+	char *here = strstr(str, token);
+	size_t tlen = strlen(token);
+
+	if (!here)
+		return NULL;
+
+	while (here) {
+		size_t offset = here - str;
+		char prev, next = str[offset + tlen];
+
+		if (offset)
+			prev = str[offset - 1];
+		else
+			prev = '\0';
+
+		if (!(isalnum(prev) || isalnum(next)))
+			break;
+
+		here = strstr(here + tlen, token);
+	}
+
+	return here;
+}
+
+/*
+ * replace old token with new token: Given a convenience or placeholder
+ * token "last" and an associated value not known until boot, of say 1234,
+ * replace instances of "last" with "1234".
+ *
+ * For example src = "1,3,last,7-last,9,lastly,last-2047\0"  results in a
+ *            dest = "1,3,1234,7-1234,9,lastly,1234-2047\0"
+ *
+ * The destination string may be shorter than, equal to, or longer than
+ * the source string -- based on whether the new token strlen is shorter
+ * than, equal to, or longer than the old token strlen.
+ * The caller must allocate dest space accordingly with that in mind.
+ */
+
+static void cpulist_replace_token(char *dest, const char *src,
+			   const char *old_token, const char *new_token)
+{
+	const char *src_start = src;
+	char *dest_start = dest, *here;
+	const size_t olen = strlen(old_token);
+	const size_t nlen = strlen(new_token);
+
+	here = cpumask_find_token(src_start, old_token);
+	if (!here) {
+		strcpy(dest, src);
+		return;
+	}
+
+	while (here) {
+		size_t offset = here - src_start;
+
+		strncpy(dest_start, src_start, offset);
+		dest_start += offset;
+		src_start += offset;
+
+		strcpy(dest_start, new_token);
+		dest_start += nlen;
+		src_start += olen;
+
+		strcpy(dest_start, src_start);	/* remainder of string */
+		here = cpumask_find_token(src_start, old_token);
+	}
+}
+
 /**
  * cpulist_parse - extract a cpumask from a user string of ranges
  * @buf: the buffer to extract from
  * @dstp: the cpumask to set.
  *
  * Returns -errno, or 0 for success.
+ *
+ * Marked __ref because memblock_*() are __meminit and we use them for
+ * any early calls before slab is available.
  */
-int cpulist_parse(const char *buf, struct cpumask *dstp)
+int __ref cpulist_parse(const char *buf, struct cpumask *dstp)
 {
+	int r;
+	char *cpulist, last_cpu[5];	/* NR_CPUS <= 9999 */
+	size_t len = strlen(buf) + 1;	/* don't forget '\0' */
+	bool early = !slab_is_available();
+
 	if (!strcmp(buf, "all")) {
 		cpumask_setall(dstp);
 		return 0;
@@ -115,7 +198,32 @@ int cpulist_parse(const char *buf, struct cpumask *dstp)
 		return 0;
 	}
 
-	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
+	/*
+	 * strlen("last") means "len" is OK up to NR_CPUS <= 9999.
+	 */
+	if (early)
+		cpulist = memblock_alloc(len, SMP_CACHE_BYTES);
+	else
+		cpulist = kzalloc(len, GFP_KERNEL);
+
+	if (cpulist == NULL)
+		return -ENOMEM;
+
+	/*
+	 * bitmap_parselist has no concept of "last" CPU, so we have to
+	 * replace "last" with a real number in dest copy of the string.
+	 */
+	sprintf(last_cpu, "%d", cpumask_last(cpu_present_mask));
+	cpulist_replace_token(cpulist, buf, "last", last_cpu);
+
+	r = bitmap_parselist(cpulist, cpumask_bits(dstp), nr_cpumask_bits);
+
+	if (early)
+		memblock_free((phys_addr_t)cpulist, len);
+	else
+		kfree(cpulist);
+
+	return r;
 }
 EXPORT_SYMBOL(cpulist_parse);
 
-- 
2.25.1

