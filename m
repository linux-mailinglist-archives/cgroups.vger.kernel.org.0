Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13D2AAC14
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgKHQI6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 11:08:58 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:6816
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbgKHQI6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 11:08:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdLejLUoPrCq4WL+qMGROU1rQ+Ji85TiepG4JnTHItAe9FoI1gJWzUC8tgFR6bNkV0DshpGgbyXdjxZXxLvpBCuTscLPDOwQN5KOydwCdq/Kpuk6G32tOFUzweKkGjZ70sJaHSm8f24BMqxg9AqQrqgZ95h97q6WeRGNrZGHHK2yCirJk2bTvZ9tzzpRRbCUVwllL//OHlk10p3EBNhjOWKmTvktO/T4j6IiywuRS1e6H/Zf0WPs5B9FLraC2oV+TS+h/crUVVf/n4m3VnJbVHTBizemAbmUOPj7u6AkkM5Sm1gHZxCoaui/WOwBdMOkSnxsESYGZJ+f1bsFMt+yVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbGv485UyrW7cjxqwewbTE6kA1TMdSQnkaCXAHlPqhA=;
 b=AIxJpO4GWW0Ee677mtdg5WIInB+PM64vuZl+Igcai0iv7aYaQ6dylduNmtgic+z4Be5pZJIKBlsq2o2a/j9Aq2wSWFWIGp8xy7JtOEFdGspjl0ITGXDa9vjeXBtbhuWXYDyEGBROAHvoCN53tJ3/WBgdk0Fe5Im2hgA5Zy6F+RmBZul6HRLyni6rKHbbrI3xfeiiEx+QjuUZYWwpxKkzEtHB70RK1+Lt2xUt6v+1+W3MTwmMg40j6Hr/kg1PYG4PR36Z8znuDUg3p/wgtQCOl2vxsK3reYVQgOHCDGXhG8/7wQl+7QcMr9P3m7nZGPr4n7mJI8lNeSrU2Yr+zBO7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbGv485UyrW7cjxqwewbTE6kA1TMdSQnkaCXAHlPqhA=;
 b=qAZmdGYjO2tL9SZV3DH+j+iNg4Y7ww6/7yCwUlcduKpnKvHE0Am+IIHwsQmqZdxsOJCJkvMgIdT2jJ4CqdZxVx7gD3TOsAAAIFbiPIlDaWsTdMWY4Bz5o5MFhf1n9tDIxDnWcgjUGO6YqVthmaaNYph49V9vA55flMUj5iqzMfQ=
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
Subject: [PATCH 1/4] cpumask: un-inline cpulist_parse; prepare for ascii helpers
Date:   Sun,  8 Nov 2020 11:08:13 -0500
Message-Id: <20201108160816.896881-2-paul.gortmaker@windriver.com>
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
Received: from t5610.wrs.com (128.224.252.2) by YT1PR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.32 via Frontend Transport; Sun, 8 Nov 2020 16:08:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dde41eee-3b52-4b57-8583-08d8840093fa
X-MS-TrafficTypeDiagnostic: DM6PR11MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3579E759A88C8C360A7F2B2483EB0@DM6PR11MB3579.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPm08ATFmzWisi+vKQ2rRwot4BBEhNCKI2a6+LtT0E8oa7kevZf3+uDgIQW9gY3qWNX8w89AF9uqK0K5LzzxCrEoSzg3yqgv9qqaGF3mhak/eKVorKL2eqaBPezFUz1Eik1Ua7Fa+8MP358Q0HiiNfcvNOpeeXZiHS8H/xys7l1nyFor1hqwiKfb44bv4rmOv3fhQBoPA/k9zGGYc9TU8ECj0WpgvmDed/x8+ijuC28Vr3AdiKp7cPoa1yvGg+0C3/qJjBHT5d/K4oAF0Pxkq5uZNim7U4n+rrDTFhUXl9idFzj1w4Md4ffigxPVdtxtzxMiD14bspNEfFC4PDiq0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(396003)(376002)(136003)(346002)(450100002)(44832011)(1076003)(8936002)(6512007)(8676002)(86362001)(6666004)(2616005)(956004)(478600001)(52116002)(83380400001)(26005)(107886003)(316002)(6506007)(66556008)(66946007)(4326008)(6916009)(66476007)(6486002)(186003)(2906002)(36756003)(5660300002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wLCZyIDNGHNG3NbK2qNQDNHVNjW3hli4mV1K0vd56tvbfrP4hho3sFTquRu3GfqXalStMxldQXe2RU7IzHwfF7dpsepCHZnIMRvfPeGY6qBJl3quOdUrCssS2VS2DE6grB+eBrhH6fi8DiaGNmrs5drR/Ph3yr+8C7bV9uQMlZdFkj2AUXqGi2I8YCXQOdYkN1iedEO49//GgsmoOFeCc03tX3/t8fUI3h561BAbpbigh2h1IEFoAEYF6Q5edoSKprwo39bftvnVJCrsuKuaw+qRHGhnMyS4W2ssNejqkIvRAUQRfLAbCgu1/KAbZtwLx53FtjNupHv0BJIbuG9Ka9e9rTcar6aagObzI5xBZQxsCS27uvpPWozRn1UA9bo7+uvDhWoDnX3+//KyGC7MID+TkkV3mjqqwPp24zQXEihA4pqJIi4mfaX4yYsGD5sWc664om7NxfoF0rjjkdcJl1tXiC31t8PfY8+fGWMoz0nDowsBx5Sn+MYR/c6laVsULhPlRc/aptcwxP0kNdhiQy7GjEJONOlOHfroo/+OkrLxLhbwyB7nv3/FQz4PtJ0HoNS0H3sBtaBIdXZ8VsBndpdfAyrxd60cRh2NKg8eYvDosW0+jXg9Ml8/LU+bWzdWTYHIwtrnxk5CbK+DVLKqGw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde41eee-3b52-4b57-8583-08d8840093fa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 16:08:49.2700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9DI5bliu7VmcGNe5MEwPgSNKAEX25Xf3mzdzNrU3IUJRfImH1Q5APS0ksdQeoP5qdECG1M/VhNtoLIKs9YzMW/KNcLOFPSj4CEkillxFVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3579
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In order to support convenience tokens like "all", and "none" and
"last" in CPU lists, we'll have to use string operations and expand on
what is currently a simple wrapper around the underlying bitmap
function call.

Rather than add header dependencies to cpumask.h and code more complex
operations not really appropriate for a header file, we prepare by
simply un-inlining it here and move it to the lib dir alongside the
other more complex cpumask functions.

Aside from an additional exported symbol, no functional changes are
anticipated with this move.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/cpumask.h | 12 +-----------
 lib/cpumask.c           | 13 +++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d6ac39..6656019cce0f 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -673,17 +673,7 @@ static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
 	return bitmap_parse(buf, UINT_MAX, cpumask_bits(dstp), nr_cpumask_bits);
 }
 
-/**
- * cpulist_parse - extract a cpumask from a user string of ranges
- * @buf: the buffer to extract from
- * @dstp: the cpumask to set.
- *
- * Returns -errno, or 0 for success.
- */
-static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
-{
-	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
-}
+int cpulist_parse(const char *buf, struct cpumask *dstp);
 
 /**
  * cpumask_size - size to allocate for a 'struct cpumask' in bytes
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 85da6ab4fbb5..5eb002237404 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -95,6 +95,19 @@ int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
 }
 EXPORT_SYMBOL(cpumask_next_wrap);
 
+/**
+ * cpulist_parse - extract a cpumask from a user string of ranges
+ * @buf: the buffer to extract from
+ * @dstp: the cpumask to set.
+ *
+ * Returns -errno, or 0 for success.
+ */
+int cpulist_parse(const char *buf, struct cpumask *dstp)
+{
+	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
+}
+EXPORT_SYMBOL(cpulist_parse);
+
 /* These are not inline because of header tangles. */
 #ifdef CONFIG_CPUMASK_OFFSTACK
 /**
-- 
2.25.1

