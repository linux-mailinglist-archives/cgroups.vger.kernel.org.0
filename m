Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6E32AAC18
	for <lists+cgroups@lfdr.de>; Sun,  8 Nov 2020 17:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgKHQJE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Nov 2020 11:09:04 -0500
Received: from mail-bn8nam08on2044.outbound.protection.outlook.com ([40.107.100.44]:6816
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbgKHQJC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 8 Nov 2020 11:09:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SupdODGx5lNkgarOHHJU/8W1HRbxJ/IU7tZ3dthkhGWc/8PZtSwmqAOzEkya24p/nvbHcTCHceIdBxnw33nADLsGQbevz2k/0RSaxfa/Z8MmvhR+ZVRVniVdwFWNcveO4sHD6yciICXBmnDqwASkmpQAG4GFflr/thpCldie6SLIPalm3/SMuSyRuSN1wmo631peYM5Ptv5xikfpKOLtIwhj9zW/RnCuu1kDOjkj7hFZySJvLRDL16lbUCd78fDbba94viGSr3c32Ymb1xaf7lKm+bY2iDu5TSTHxT0BbtK4Sj4vHIBrZn5FKv6jiK0dv8m98za5ZmMP58WpA6RzeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JEJ9GSK90PQQnTECfuTh4QZmvo5Nm6q52rlJOv2lK8=;
 b=ZphOkx+9bn55FUTK9ZFO6VkO6x5Uuj87RTvjC9mVuePMbp+DbzTArYJQrDTaMn+yLncbzuvnunc2QQQMW0V3ULv1+6vfvnlVO9JsYyeC7qW4ZRMiiFEAPGYCf+myU6mJBAdukrGpVCl4sYCFlpcmvlyefCOfdO0iaru4lF/5N8QhtglQfg3/51Sy1jYZs4r2bLV2j7UUILi+RrWRGMX1W96sfIHa1vW4Y8r2lHu8k+LSyQiq36/opcmHsXV1weGk5ab2VKShXpIhOLHXqJoWU/29f1bIw562QFTcJCZf+924VIYTYp3ddWtLj3H3Wr3uvQo90cKZhz+sihltQ9/ktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JEJ9GSK90PQQnTECfuTh4QZmvo5Nm6q52rlJOv2lK8=;
 b=PecqzqNZmc7zhBIgRnQz8FvBlVXbVjjEuSKOvDtSf75Rpbm4T2VpyOhieHXwKEyQvkbDUOIDBRe8xUAQ28lXFmRxiDPFurpZOtuKPvFkmmpE0qjkrr/Lm7PTAjKpAYS5/eledK4dxEmr+QkmE+GfFuv3ru8QAwjJX8wu1sQMMOs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3579.namprd11.prod.outlook.com (2603:10b6:5:13c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 16:08:50 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::4985:c74a:ffcb:6f40%4]) with mapi id 15.20.3541.024; Sun, 8 Nov 2020
 16:08:50 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/4] cpumask: add a "none" alias to complement "all"
Date:   Sun,  8 Nov 2020 11:08:15 -0500
Message-Id: <20201108160816.896881-4-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8b6baa68-c6ca-43e7-35c9-08d8840094cf
X-MS-TrafficTypeDiagnostic: DM6PR11MB3579:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB357985B498CE8BA784BBFBDB83EB0@DM6PR11MB3579.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: to1J/uYjqxzPABCG+SiTzurbOiDaJuFg1viULf1C5Z2ILN0a1AjdlXl/pf/2AD/q7R275vrzZiTKBZ9VDPq9UZycT0JqX+4WqKmd4Uhgy/ekRZMERcHaNfuBBPXMsSV8C2TgVaixZE+o7ob0j9+kmyP1Anl21ImAA/bxZltvkyYp+xQl97PplOSSImtz3Hl1/rML0xHqgUIVsvWZiFDKJLQATs3eBiSk69TRnDa4rLmir795gifbRvwJ0Q990YZFibg3fPikvhahQQSZ7PBAsTFfKrYB6PYhk/5FIjD9gGDcN23AH4mfRVPewmN7YDjfrtbb8I4cm8SNOPke07qGBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(396003)(376002)(136003)(346002)(450100002)(44832011)(1076003)(8936002)(6512007)(8676002)(86362001)(6666004)(2616005)(956004)(478600001)(52116002)(83380400001)(26005)(107886003)(316002)(6506007)(66556008)(66946007)(4326008)(6916009)(66476007)(6486002)(186003)(2906002)(36756003)(5660300002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BqPFGwLaSsc0F2qXiUV4ogBsmnGvOpZ/PKbtMeqH0Ly5/hy2p2evoPa0LlKgltSnhschnbZS40au46nWM7C2gHn20vE0X96kQO6GH+xOK1JdBEKfW+5VtL+o2SANl1YpxnSaZ+h+u4DBi6gBPAv/1lEQpnxRtzAcfWd2cjM1qE9W2IHWT0vcqaVrvh8gqYs0Tj7446b/lf1wjwq/UM03nr3RbWR9wBLrOONTi56RqGnkKScbfx2v9rVgX+L3E/g/xo4rvbvKKcX4dOGDWCal26355g56G+H3wVSs+0i/SQ5mw92QY02+NdDOexhkEsB6iLrpFxO1BH2kARi1+iGhsjo3QJnBSpMMCv+gtU09n7O2pFeT9+xwpxnnM5iboq1T1BwCPhSOicbxl9+DGaClUtut0Qdif+tJ+E9du8xTDGZIu9gCrjgq/YeW/zQ1itu7m1KaE6PxfmPVpDDoZOY0LTJV5KOymMU6f4QbdPPPfJCAYqUEBkS+ChGvi1cPCyGNV9y2a6P1sPZj+zWZlFlm/o7T1zvMPqtdKdJ1D0BVNv4v0NlfQJoc3g6oCbeNrBMsFR2RbO4SJStCegDpZcRClXXFSRAf2y3z1xffl+W/LG4lLYKmrJYpnyJuikdZxT7cTAwcPfFEetbqiijEXZkgMw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6baa68-c6ca-43e7-35c9-08d8840094cf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2020 16:08:50.5484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PqPnRZWIqYTqCglAoAnW4j8+1LyT9hfJ6cvPXR/wPx7wdU1/TUy/EwkV22BVwKEE8prXSrwPkppWn633iVIh/FSr4zzLOPypFCQdXaBOpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3579
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With global support for a CPU list alias of "all", it seems to just make
sense to also trivially extend support for an opposite "none" specifier.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 Documentation/admin-guide/kernel-parameters.rst | 6 ++++++
 lib/cpumask.c                                   | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index ef98ca700946..9e1c4522e1f0 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -76,6 +76,12 @@ is equivalent to "foo_cpus=0-N" -- where "N" is the numerically last CPU on
 the system, thus avoiding looking up the value in "/sys/devices/system/cpu"
 in advance on each deployed system.
 
+        foo_cpus=none
+
+will provide an empty/cleared cpu mask for the associated boot argument.
+
+Note that "all" and "none" are not necessarily valid/sensible input values
+for each available parameter expecting a CPU list.
 
 This document may not be entirely up to date and comprehensive. The command
 "modinfo -p ${modulename}" shows a current list of all parameters of a loadable
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 15599cdf5db6..eb8b1c92501e 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -110,6 +110,11 @@ int cpulist_parse(const char *buf, struct cpumask *dstp)
 		return 0;
 	}
 
+	if (!strcmp(buf, "none")) {
+		cpumask_clear(dstp);
+		return 0;
+	}
+
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
 EXPORT_SYMBOL(cpulist_parse);
-- 
2.25.1

