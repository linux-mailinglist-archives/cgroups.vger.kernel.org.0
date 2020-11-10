Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BAD2ACE49
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 05:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbgKJEIg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 23:08:36 -0500
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:63329
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731890AbgKJEIf (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 9 Nov 2020 23:08:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJnHFkQkOXCcTgeEIH9Qap+2vfbQpunuULVm4XRuM/E2BGEjsFEVaJMVMuyG/oQAK8l8w/pymyB5HfFlCHmP28mdxYFpgdWiPX4iOFKOyGIP6afoU3kSYoVAPycLEDCMionTUTdQqhfdX8IdSwqH8OkOoPiPDOWxy0pVftC7boY1JIY8IFAEbaj1M4gD7Ao0asmCrvOZRTfEm6EJbbgOzcTmHbGZYR9sTM6P78Bhe93sewCoTwaT/lpZyoSn+D8rV2YtLhiDTcr4uqnYVAKk55UJP58yY0fef/yzAumi2aNuX3pIGnRqRvSWowd3gDYCB4zaS+qyOzpIf+z7uYh0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JSSphesTb40yiOoxATbxgdKTgj+bWwkRQo82fq+wEQ=;
 b=jfPCUsrr4PgMx5R/XxgmXZ1N8FjKj4t1o3Mlpx2VshQveV7mcwCMeAQRJnYu1Hi75F9vl1XI1pSakzd/vLR0xMh7bCWY8orTGIem5dfH7MbLPCHPkMVcqLDxGfjQ1GIUU3/0IZZ97FH//UmhJdlOJzAmdQShY4pdSvR7OHhNZv4zed6WhQcGE2yvX9EjseMCRDPW4HLpbgv1N9RtK8cWH2Zg5HeXbSZxNn56Ae6sh/tJ8rb7p8ELnC8Pi2sW6UTvFpKQaPtlj048rbOucYsQ1yKWlYkyr1paF7xl3ebxuEIDA21aYYiYQAFcIewWWdHjsxgbCmgjMX0MpOaLSbGnAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JSSphesTb40yiOoxATbxgdKTgj+bWwkRQo82fq+wEQ=;
 b=WF80hWKRC/CAt1yhYaOS9SRcTZRFY8oFMY8GUUVZBPEXWp3PjqJtwP7OQr0ijjQ1SRtr49fKK0OOF7InWcpZcHYGgRzYYiYFf/Dzbcu2x1I9JiLSjSwBuo6uEtYnYkriFMC5WWQfyr8eHPBDD5CuVUnZ/M4kB/nmAXeVuVhwlNM=
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
Subject: [PATCH 1/4] cpumask: un-inline cpulist_parse for SMP; prepare for ascii helpers
Date:   Mon,  9 Nov 2020 23:07:22 -0500
Message-Id: <20201110040725.1478297-2-paul.gortmaker@windriver.com>
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
Received: from t5610.wrs.com (128.224.252.2) by YT1PR01CA0136.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 04:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0fcb32e-6506-4bd2-ca93-08d8852e33eb
X-MS-TrafficTypeDiagnostic: DM6PR11MB4489:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB44897CBBAB0C29B3A873A14A83E90@DM6PR11MB4489.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFHFWP3dCOpm0EjyQ1r4mQpa/HPbYDPSM1+KbhYbDOj5J5UiKIxkb8Igu67CFHnLRxR8XTqh74dD9eYSRc/jwhFYHe3eNg6jgZsBiwy2zuCAAaTSVBVFkn5+gGy0fklZ+hcmIylqpMBQfFjPoU4PYJI1FsZA23CDgqCZMH3G4Awl+TVhRpN5GYMwEG2eUo07MXA3Xmc4HNM9EKh9ZABtUa9A048YVYZQfZ+GLn86WDoThGqRRijWvr4W6uruQgBcttHpAPZjfiZxs2IoBDuy4lyPKcetuYWCyBvi30ssm1scWkcw3JYSb3mt+ZwFa97e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(366004)(136003)(2616005)(1076003)(956004)(107886003)(26005)(6506007)(16526019)(186003)(52116002)(6666004)(4326008)(6486002)(83380400001)(5660300002)(66556008)(66946007)(66476007)(8936002)(2906002)(6512007)(8676002)(36756003)(6916009)(316002)(86362001)(478600001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: nfY63ilMEGrHc0RKq8KQQEHAcyqP3VP1r2pjoluT9g/UlVrSF1xv/tdKhEt/Qy91aJ8zLVMNHHux1glu2HU9D34qKl5GRKhBpTKeVvjjuE5oC04QBFp1n/5D5PBJ3CbGSNu1Jj7Joks5v3jhkhmG0MEQHBFUJ960EYfQyvLR2RSmgeNqRJtPMACQAHcj5bzRBgmt4FQ30BWoS1DRCr5MdEfAouY3zO3pR4eqH339lC8s1Dyim7NhbxEqyJUs7xpWQWxet3Sq5XHR5J/PmbiLRoDsvqCINVYmfn+kF0CUJjizohUP9FjDz3j/lpyAAQ2OyP22ARFXqMsC7LYlLjkeJ2uI74mFCFBKHEsUTGGOdoWMORLKX2VSw3rBUNBaRFRzEhQKzHr6ixfruEfYuUIvDU6HMCP0u6xuMApn0n7eh3dxnQlL1iQvmnhnQ91e8sxg5B+7M5TBXEjgsEx010CoZ1VUOcFCmYkRlyFab7tJggGnqUGuim1SE63Fuqr74DvLRZhb31IKVD+yVLdmNdyTDRpDKlrj6jpltjDq4zuXN78QQjJ6G6+VHJ8kGT6pHUFsrEKwiqGWFwepD0Dq9z9Vxy28qmRb1XIB0UHBVzdIETaYslL6N2crBKsHYvPHnvK0TI4fEWYek1pOkv33DXubbA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0fcb32e-6506-4bd2-ca93-08d8852e33eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 04:07:56.0210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0cNVstv3zyM7oxmkZEHmlpde+ytKAn6F2hyhTUgSOp8ZX2MSMHnbHDB/2sb/WvtdCOECgk8iwYbRa1dqPodIGrwmPZsSBGjjPhrCXhgc6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4489
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In order to support convenience tokens like "all", and "none" and
"last" in CPU lists, we'll have to use string operations and expand
on what is currently a simple wrapper around the underlying bitmap
function call.

Rather than add header dependencies to cpumask.h and code more complex
operations not really appropriate for a header file, we prepare by
simply un-inlining it here and move it to the lib dir alongside the
other more complex cpumask functions.

Since lib/cpumask.c is built conditionally on CONFIG_SMP, and there
are non-SMP callers, we leave the one-line stub behind for that case.
If they want to check "0-0" is a valid range, they can still do it.
In the meantime, we can add the ascii helpers for CONFIG_SMP users.
The use of NR_CPUS vs. CONFIG_SMP is consistent with the existing file.

Aside from an additional exported symbol in the SMP case, no functional
changes are anticipated with this move.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/cpumask.h |  8 ++++++++
 lib/cpumask.c           | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index f0d895d6ac39..d2e370c5ce99 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -679,11 +679,19 @@ static inline int cpumask_parse(const char *buf, struct cpumask *dstp)
  * @dstp: the cpumask to set.
  *
  * Returns -errno, or 0 for success.
+ *
+ * There are instances of non-SMP callers of this, and the easiest way
+ * to remain 100% runtime compatible is to let them continue to have the
+ * one-line stub, while the SMP version in lib/cpumask.c gets improved.
  */
+#if NR_CPUS == 1
 static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
 {
 	return bitmap_parselist(buf, cpumask_bits(dstp), nr_cpumask_bits);
 }
+#else
+int cpulist_parse(const char *buf, struct cpumask *dstp);
+#endif
 
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

