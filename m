Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51C2ACE4F
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 05:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgKJEIg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 23:08:36 -0500
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:57757
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731341AbgKJEIe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Nov 2020 23:08:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlfLCKuxg4ISmhe846SqAA2BoKFKhZYxRYB12i/kDCvUfv6eVzO8qAXcHiErssV5dhvvsUbdTZXAfNmzc0ZuAqzKtDVSNj38motNW/T8RyXw7Eez0K8ebq29isF+WqKBr96UjsLg97n1LQWSd4GkHzmUi7asM19LQIcXxE3Mk2/ZWLqa0kExVeJCbGhXe6Uf8cc1VCUJY7PBkFJ+WcaI+dyY8QnNf1IvOKd36tAFLben+RzL1H35sC8C55liH375PU3961RyGgA080xGJHyCc042ZCHoGjeB8t+Vm8fGH+iSsA/Wva3aL2RIy0vwxPeWQdiytk7pAQDR7xF+naSbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JEJ9GSK90PQQnTECfuTh4QZmvo5Nm6q52rlJOv2lK8=;
 b=Ljf2ILJSXqzCeP1JO/gGMOLfv96zJ7Dwhu6JBV+1q9vBs5YnFr6cX/rZOEenAYecblvBAC4Rr+8dfrys5tehByFpa5HnOIxk26bOyhe/05QBg67AclcOu2F/Srt8tnw8O9K5EDUzawy18FyJJ8UxoGmual2IAtV9XqmmmxqUwzeb4lzSjUP7pQ0tnPcd1ELkkv6SAbWRNuWaqReqHjL9p2ad85h6fKjw0nyv0LbngVfEOPLmdH7V2saBTrkOH81eQEtGHBy5IZmAQSrXult60Ul1IYW3CamKRElF9ljCNVYxP8wcRhJgcfvikLPviF0/Bcu3kL+65u9jmCP580sNEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JEJ9GSK90PQQnTECfuTh4QZmvo5Nm6q52rlJOv2lK8=;
 b=WaQqDdo5f7OoQOmW1ttaj+fEeGaEf04/pl9ar1jLh5BNSwPUBKXyuPdHb85XFMT0tUXbl8Q8tACbpjm3vFYL05YiC4itV5qU7UPQBEwtX9Ho6hTObx1CNLEE7K3hTfe04lVJgQWVR92zCnrE3672hYsrkvSV55lJivfL/hNcCeA=
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
Subject: [PATCH 3/4] cpumask: add a "none" alias to complement "all"
Date:   Mon,  9 Nov 2020 23:07:24 -0500
Message-Id: <20201110040725.1478297-4-paul.gortmaker@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 659dd764-cb9d-4707-96e7-08d8852e3499
X-MS-TrafficTypeDiagnostic: DM6PR11MB4489:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB44896E70B28B79EDA9F7C9B983E90@DM6PR11MB4489.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cn3rfZfpUP8Mw8ivIukzR3nxQ98aKkd9EZyu5y93V1Wq3TjnZo0oZO90xP/PZSOYrkzOqmmBNlVA+hCNHCUxDOkVj/Nb/vAol4CCB1M8VNK+/Ay1CtsOuPX+QEjDry6Evtj8wl02p3GChKpyfuudL8VJ3wK9U4Ct5neO10qIa/JeYhFr5uNhsUHhOtOyX6EfRIdP8RzbE5R7sj+ZBRj514nC1grk8EhPzAxqIERqeKDgJpuNIg6bZX2/tAKHQIcqwXy23/Qup1DSmVcnxklMG9JoFvbLWYvDEWJ3YypdDi7CyPM2O7WMEEILHqsyNeuzVMI8dV8JbHaLxiEA7KWm3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(366004)(136003)(2616005)(1076003)(956004)(107886003)(26005)(6506007)(16526019)(186003)(52116002)(6666004)(4326008)(6486002)(83380400001)(5660300002)(66556008)(66946007)(66476007)(8936002)(2906002)(6512007)(8676002)(36756003)(6916009)(316002)(86362001)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gRgx2d4Ur/mE1ErNP1zrECso+9FSGrHaPjUjakUH1floJP46gZhQ4qC8fEv4/WG3tvioWmUl1EcOHnGL3ZobOtyInmqB2at3KRIGUS1RwzPdFAOIYWqtjBl2geRGP5+7/2BisQQnQGSxiUzZSzg77gpAW7++7qzsrz6VvSlYchVn1UUg1+lsIxBmAnkhp1xyCxzlcLQZmfgX8LCAnHywB6eIW/Em6ws2tGONbS1uUtOg0xM5f4TX/uTKpq+NhMU6VcInRQD22j+xR/NhthMLYGrHdM++UngB0MJste7FTq04smpRABKIdYAthF6m06APOoEY4LhSK1bLiE6QABvoBEQzJzggAaZdKEYw0gwcVm7qLiIYASdOwXE02QgkBdU9Ly4xC+HhPKmjti+4jCDw1gsvrQBOiepF0k/usnZaMoJdkCGtdN3VNA3H2mYJxBaRP+uK7hVhlgavJyNlP7hSeb7I/BlWynckwwGs4i7u6jleACVgL7Ps4fSpEEBwBCppVoFLpkhk9YF60luu/acQv5beH3iIcgZ8B6OmjLdVht6vKoJkUVwFBWNfC+dmJbG4M3bYZ3eQMOINXTx05PF+k6krDjMGLxPrwrypXp+0lixk6tbR86qT5YQkFiS3Nk/M5BH0lNdhIB1yqzuUI0/uRw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659dd764-cb9d-4707-96e7-08d8852e3499
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 04:07:57.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epLOmmDBqWAmeQP4Wg3vBu5phDV6MEr+SM3gOMm8OZ4PpeR7n0UoUFiC3mhIbDe2PAF1lS5LKN68sZGhuIvW5cx2Dmzjp84a+85/imI6an0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4489
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

