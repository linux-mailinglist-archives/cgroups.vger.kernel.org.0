Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C42AAC1A
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 17:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgKHQJI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 11:09:08 -0500
Received: from mail-bn8nam08on2064.outbound.protection.outlook.com ([40.107.100.64]:39873
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728723AbgKHQJG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 11:09:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRd8DBgvWmtJXL0KXrzLxB8V8JcQUCsxtebKa5FjcOKgVFpVKA0e8kaf11e/RZc6qpuQ3Urm1RlTvAFG+boAdoy1/AS7NwH/+C0QK1hD+0AVSLrFas/Zvf5ifI0VhvKkAXlulKeEQZxYYAgvc8t8BnMStI4BpXrwNYbklwbLCXiTpbnx7L7pUyFrJyqOXdpAohUneIP0rlooxg0CKHSv9R7PPbnkt46Vg27fyeV2tD37KG4aLZh5tpxbKmAwaRVSl0/qfeawNSK98wzt5R8DlbFc4vgcEFeFgLC1AtXZ4PjZmrmv22yguNAnHUqQ1ARC28yqXO2lpOhArAyv3Y1EGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WykKvcqbvTY6kSAz8674fRALtTrM0Zihu/UGCgQGqCQ=;
 b=RYPJzUZPS1c11+yN0xM4itXj2HxraOE1pDELcrsp7Gb3TbDgzpxm3zkGkMSRFhrlRXcI8znyr9TEhC6NLYMjk+InOJ7nWxUpJGedRWwjy/k9GQpR1DSqH9gtstxwP25MSwODdDM938flEbwyvcpOQ1FoqD13lbkgxSegNQOSq/Ip+VUjOjbq7yZnMyyje7LZMfJi3jA5cOKETa4TE5YvPTaMLFBmO04oDOIyo6lrz1jQ7F9bDX5y9x1ghoHbCL9c7pYM6QFzzMWxdsHfU2JxwbiMi9qmYpwyKP/qFcSuwX0S9NwlSzjai8yz8K30hhRMp432CBlx+I1Il/VO1yNqWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WykKvcqbvTY6kSAz8674fRALtTrM0Zihu/UGCgQGqCQ=;
 b=b0o1xxSj3UMKR/LJgWmzXTt3SMkaJYr+Njs7+mhJmXcaro9B5UZKWQgU2yG1o7CzIlB+tSP39CrIYNnvI61/PjSNkcyxpGxD+vXkle4r+dKEMpPfr1KLyIcdB3ajQJqVkFpWRzDaNSNd4CWq0qVsvc9xA7vYdAv0f7fQ//KcZ/Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3579.namprd11.prod.outlook.com (2603:10b6:5:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 16:08:51 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 16:08:51 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 4/4] cpumask: add "last" alias for cpu list specifications
Date:   Sun,  8 Nov 2020 11:08:16 -0500
Message-Id: <20201108160816.896881-5-paul.gortmaker@windriver.com>
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
Received: from t5610.wrs.com (128.224.252.2) by YT1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend Transport; Sun, 8 Nov 2020 16:08:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2786c887-f761-4625-4c10-08d88400951d
X-MS-TrafficTypeDiagnostic: DM6PR11MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB357992F193F9BDF0E449912E83EB0@DM6PR11MB3579.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qqZsVZCnaHZ09kJMY2Qj/1h5gxIGVdjhXRWxsikNXJYRm7mCGT2XWdGOvAz6frRF2nRFqY0hSiKjr3xg1DBKA8bObRp5moF/rz54rJYZ23xPt7z3qL3FVJp6TelZbBBVa8snDnDX+ahj8koe4xRNmoWr5V5nsPpx6nTc8oHiNuMmwLuBTohL+c/2qcsmy/9E+7bLRbOhyIkcAdvJfFlPw0acIwL7511AKDh1BXfIcu75gZybVtloL/7qooT0uDVxZiVaHqeUal6oA3A1H9DbNT6H/FukSh8S2fL2qOLQidOD7QyZJ7wheBp1Gj8zokSkbufDG4v0Che5RwXvnuLaOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(396003)(376002)(136003)(346002)(450100002)(44832011)(1076003)(8936002)(6512007)(8676002)(86362001)(6666004)(2616005)(956004)(478600001)(52116002)(83380400001)(26005)(107886003)(316002)(6506007)(66556008)(66946007)(4326008)(6916009)(66476007)(6486002)(186003)(2906002)(36756003)(5660300002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tCNJDI3QxE5d0r65djIpdNHY32ccFS/poShCVLwGRx86NEvBP69Q2H9XWC4iO/CbGf8J+JncWdpk2K+/f2858wQLfTpK0YTb4CPPRJx8ycV0QbMhb7arTIW6kK0k3kxv5J5952kQGrSaVZbYh6E0jbBiB4ffYQQN6bFqwswJbbxJOORvsBELe82KrtVjnWh9k2vLR/OqPFUEkXtBPUjQ78ZfGQwCU7XVoWqIqdk2rNWu1Xpyb/i9CExJ5Nu3w3RgFnDU205UBjgkaHue47glQxFOi6IcGrKnWhRODNLEZ5DZVqFAyr6jZoK1T9GEqebTA2r6dedGf2E1yZ55MDlei+Ra63cJc6pQgrJv/kc8ZAUg9PKTLrSBi10sTyS2tkE36uwiKKUOZV59BiAOGW1z4zm9vhWSXQ7lOS55Nxd3aFPuSkfsmyCccEVHaVLVirw9k1cnHsUi0CfCoHDMIrfbr7zS+YUjweDg1fEW70L93OrPX6hMhC7Cf1sIgJLA5cMMdcOJD1JPeJFX4Ukt5rlIhIB80nxCJ/Z2403ddH7d1hxflSZklRrXwbkEhZLr7ddn8SDGDgBeyJcdSKvio2p8FfOSSA7E6DbbJckjEzl/CDmB3sYT6hCjeLMCOK6JOTbXQJNHKhoTKlkkZkSVKjUtyw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2786c887-f761-4625-4c10-08d88400951d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 16:08:51.0870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLAkrUpfrwb8BUv0haPdnywMiboJMeDgHEVRPjCXEDwrlgc0NRHtWJ82hHiK9L8wpt2blTivUSG4K9A8GeIBrDwKfHzZxNiDvJr1jME2RSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3579
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
index eb8b1c92501e..6c66f94b701d 100644
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
+	size_t len = strlen(buf);
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

