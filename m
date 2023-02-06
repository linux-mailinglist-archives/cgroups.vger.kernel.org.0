Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B221668B6E1
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjBFHwG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjBFHvu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:51:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6521CF57;
        Sun,  5 Feb 2023 23:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWjQetCOL1IOxz7vpvyfK+0Cd33y/o/NEcpXxKh5P1+ZrQf+YsEjwinD1l9fg3ISZgzzYrDVQCLlPzl4l/i3OS5EoiAY/Gp3M7fqv6ksk2Em5l/xQpK9mvehByBXmbAqCEzGq/K2Hds8SeTYx/4vVaZ64XaSrrBnY34644XeCGSL7l/tsMZ50jKAAeBmZ/l6D6gQO+6gsndnaqgSdKA2V7Ap6vW4LjMQWqLD4Ho4TboPACcBG4PTJDoVp7hHWAG9lK3oS3OxkGyml2v62VRcByTpix8HzAlXv+aGhj5McyBO7lMLue7xjCPByVpT3lHRYeyxRx1UpAJHF7ValgfJWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QEHW8jtg1/hfxonS1lsmN1J+cQAP43J/WL1D3f0LfQQ=;
 b=jJvbWqLxgbYxhQptiGJXZQiYcU6kVPKGSIr5duSAFPMglMnxQvO3lj0Wt2kq646uuAaNQXn60s2CAYap/nh28jmW7CZxp20MCAuIEhs2HZOBMxbftTVfFT4Pw8KZk7nHXTqyOE8Tp6sDfUa+VAY3Q03AHtWdlijr37Lg+JF9Z5OcqrdIuaUYrLi3t4VosaRO3fyu/i9isf9y+SlhfEQ4r7N8eoUKsQE3yrBe779dFfl3xIVuFSwucYn7ocHk/SeBWYKz0phl6HuARJzbxrzH8Pp5lnAOQj/K77VCSzdqTYqxlqbf8cpQp0StmFpOF5pPRTjGMQCgsKr+BLfxtnsNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEHW8jtg1/hfxonS1lsmN1J+cQAP43J/WL1D3f0LfQQ=;
 b=XW8hnGQniuHn9VXIbENHf4WtjGwfzYug4MygncqFpMEtxF1AB+JDfJQ1Tkx2Z1NKd9y1GTZ51iOmErTZM6w6prtjsRFCVBSZg1hsJDgXKUb1Th6VDzUvEg2T3VP1bcZ3Lo3GLKGvYUh8ohsGixuvfGHKyUnQaZIpI+9O3muKXUBYJUmhq/4iyR95wj9mSBDig0OJy5h6iUf/27sY4hyBibl4jcQQVcf4W7F6y83+FPNdEuihY0/h/lsaIkmNJzeeR+Ag2vKMhiSBL9+BlpZ9iUbwG5fozIsD8hnjq5ILOrfmpSxFb8QwFkky4+FBBWx/GLbNeKUNFqVI6IBwKkrY5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 07:50:00 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:50:00 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 16/19] mm/util: Refactor account_locked_vm
Date:   Mon,  6 Feb 2023 18:47:53 +1100
Message-Id: <f2037e35a6fabb4734a56ac4c63461dc75cf2264.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:10:3::33) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db330a4-1aa2-4d64-980f-08db0816bfd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5kM4XDhr1D/mKBdbDY2lMn7dtF5X4TVQ1MEhmUz9G4uhDzwM/fO9qVuffLHUmSXdIVbM4BCFQe648p+NeM3zfRwZ2Ra42/Dajim+M31nKdkWgb6v0pF3KuhTzGPfwlf6H75gVGI1T9SslnFNnGwQFbo/r9IZs12whuQKvpyzadBANlhPdYvzTiE6xzXT6LuGt6lT5ILcwtCYGNe5hhC4kpCwS0bS1jrggvM8zC17mU5xPpLfbpVdfaPgc+JCTnSRDsPN3rPlNX4/FQM+kdn/Cmy3zfuSQGd7XJXTaSN2VatDvI2/x+urvba8ndJroHF10ZAoo2f//rN8QMBwZKna7AgGGR5dQJN6SzeuLUjKvrCGDkvR6BSHLlK2JDfin7xVkeKAzQBlVouYhx3ARnvQSOgjMitv2LsXJ34qTPs9FHXtR/V0jfGFyd5q+bUz9X7LloOq1lb/iArV72f6ZI13t7NGPI2rGlC+coHWE95Ts6wUNAgVqe0mHbSwpXVFbqvnS+lW/cwJMMeXF4jYlj48nq7KrL8hwJw4ZlXi/fe5DTVEmiKXDUrWURnfdwd95SWoIbaDSfqJ/V2QvOhtpLErYVmTE4ASfMdmE00mlgk4cs+mlpNWZblJKfmHykx7F5/klB3UIl2K65XkI47f02oUhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(54906003)(316002)(86362001)(6666004)(107886003)(6486002)(38100700002)(186003)(2616005)(6506007)(26005)(478600001)(6512007)(7416002)(5660300002)(83380400001)(15650500001)(2906002)(36756003)(66946007)(8936002)(4326008)(41300700001)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0DxbcFt2BlVgcJiQ7dPYPczJRG/zZP8NGAJeoBO9QntBrkcy1PqALwI05MnO?=
 =?us-ascii?Q?hxHIy9VWSg1yEEvQMT/Rp5yOsnyG9IRhSj1UaptFhWXJ6zETbDr+aR4L/FXJ?=
 =?us-ascii?Q?yRqX02HVYIg41Dr6nyeXp1IdEyG0xypxg6s7tfHJYVv+mq4a9o6TVyfqfJQa?=
 =?us-ascii?Q?k4HhmllIeVmZvmAijsSClBS9b4ogCE3CiKtfEPi23WbUJUKvU55GuQ8rJHdw?=
 =?us-ascii?Q?49w571oX2FCpetlIj9Pl+oOb5yFljCSYPDJzgNfY93Ni0gjqyIlxzWCperGB?=
 =?us-ascii?Q?jNHAlfmiaBTGxY56CigvHkoYWNtH9y6P5a9ntKminn6n+Xx0qbI/8Sd+L2p0?=
 =?us-ascii?Q?4YEuH+BCPxUWeO+hYMtPV+uereZYjQRDfmgBnyPCTO9QR9Oy02TaDLUkQTY4?=
 =?us-ascii?Q?njj9geAhkm0gkzFND/Cf+x9O4eNci46b+E4WTKAeMVtQbMZHNClrg810xK+C?=
 =?us-ascii?Q?NCmaYYPQ/4WI2hDxQFuP5n/l6v+XhIXF6cb5RSOKYSNEdquVrpEeBtrEW4kN?=
 =?us-ascii?Q?pZPRNQjamUGIO1zxM5FC71W4XvxfF68S+WRvAY8MdgWSVE4Allrt9sL5qA5d?=
 =?us-ascii?Q?s8b7g5QOafpUip5W+B4TzU/UoXrNhC3SvcggmffchMZvpqnxF6Ff3rXYJLoF?=
 =?us-ascii?Q?P+toKnwrbwS2PiOd6REMsZt+sIS1LD/bF0OFNqZl9iRMsHf0APDv5IVt1wo0?=
 =?us-ascii?Q?1ikskyYC+SoNnenUxQb+XRyW4goZ2O71Rj5gkWlk9p/t7abRctWElOwK/o6W?=
 =?us-ascii?Q?Eajls3xHaU+iZW0zXrcaYpHlIsFRLKGqtpGzs43O5Xu9zNAessVUGWK9cVJA?=
 =?us-ascii?Q?V47L+viwktpKz9JCo+68kANabwYMGDF6zg8u4igHTH4iggYkTIwA3wPpZGaw?=
 =?us-ascii?Q?LAjdPIGtHZfuLOB5Fs/oDKtYtDCKxwWflFbBRQAMVawhAUaeTTdB+saZT69i?=
 =?us-ascii?Q?HrwMos7g1ZTTLlsRzTWKjZFWQIfPl6YDT5kpdWlu1QI9cfwG5MVlQIpFEIZ4?=
 =?us-ascii?Q?Cx4EmlGfY78rbFbXT9x29Ac92VAcfHxZbwkslg9YADFZTmxtGiIJeNu8GVWt?=
 =?us-ascii?Q?lpyxypX0wkV3yZCVZOKJzHJVt1BBknAdAllhPgRdWhPcwz04bcpgizG+v+im?=
 =?us-ascii?Q?LUG0aGQcWpXMjUBVLqEuk4nqOpEvzph4FxjUqOr0t68tgIroqdMxTvUnXTHq?=
 =?us-ascii?Q?K9/LISomVry0bssStRdqnPOeUB5zN0WRleQrqSvlibf5cBije3Hv7K7HHtMT?=
 =?us-ascii?Q?NxlzR1ZNtEFAu5/r1uRsIrPNdsQRAuorfJy9Medkx4tvYr5VUc/JXgk4ddIM?=
 =?us-ascii?Q?S9y3ujxgnCX3navWiSs0MyVxYftgXlXJPnhLGthXaCI7ZkHSuJr/5SNfV+ac?=
 =?us-ascii?Q?4NEcYYbo9mVNQl0LGuj/ZEosqHmsyMm5Xi/zZ8Hj1jG6GygZnYLFRZKV+doY?=
 =?us-ascii?Q?b372Amzc1DSRGHE6FPQA8yUxD2SuqqNXTSEP6/QKRdP+m4tBky0t4vshezrR?=
 =?us-ascii?Q?ANjGhpQl0JWn9dSSUoQHaQDPrh7rkeVyEaF7SfsSTcONN76wJcI+9mvcNDMI?=
 =?us-ascii?Q?uZAQnHzPpwMYKwWC2Sy/B8A58MbvnbWGYnUnH74W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db330a4-1aa2-4d64-980f-08db0816bfd3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:50:00.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AI9Z7Fltk+94VB3iChMgHrGBmz4J5uTx5CyN5GljI4YVl933AZgacw6g7m5Ot/i+vbp/LPl8YNNGjrar9RWcrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

account_locked_vm() takes a flag to indicate if pages are being
accounted or unaccounted for. A flag is also provided to bypass
rlimits. However unaccounting of pages always succeeds and the flag to
ignore the limits is ignored. The flags make calling code harder to
understand so refactor the accounting and unaccounting paths into
separate functions.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/mm.h |  5 +--
 mm/util.c          | 73 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f85716..126b756 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2090,9 +2090,10 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
 int pin_user_pages_fast(unsigned long start, int nr_pages,
 			unsigned int gup_flags, struct page **pages);
 
-int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
-int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
+int account_locked_vm(struct mm_struct *mm, unsigned long pages);
+int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
 			struct task_struct *task, bool bypass_rlim);
+void __unaccount_locked_vm(struct mm_struct *mm, unsigned long pages);
 
 struct kvec;
 int get_kernel_pages(const struct kvec *iov, int nr_pages, int write,
diff --git a/mm/util.c b/mm/util.c
index 0e93625..1ca0dfe 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -575,7 +575,6 @@ EXPORT_SYMBOL_GPL(vm_unaccount_pinned);
  * __account_locked_vm - account locked pages to an mm's locked_vm
  * @mm:          mm to account against
  * @pages:       number of pages to account
- * @inc:         %true if @pages should be considered positive, %false if not
  * @task:        task used to check RLIMIT_MEMLOCK
  * @bypass_rlim: %true if checking RLIMIT_MEMLOCK should be skipped
  *
@@ -586,7 +585,7 @@ EXPORT_SYMBOL_GPL(vm_unaccount_pinned);
  * * 0       on success
  * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
  */
-int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
+int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
 			struct task_struct *task, bool bypass_rlim)
 {
 	unsigned long locked_vm, limit;
@@ -595,33 +594,44 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 	mmap_assert_write_locked(mm);
 
 	locked_vm = mm->locked_vm;
-	if (inc) {
-		if (!bypass_rlim) {
-			limit = task_rlimit(task, RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-			if (locked_vm + pages > limit)
-				ret = -ENOMEM;
-		}
-		if (!ret)
-			mm->locked_vm = locked_vm + pages;
-	} else {
-		WARN_ON_ONCE(pages > locked_vm);
-		mm->locked_vm = locked_vm - pages;
+	if (!bypass_rlim) {
+		limit = task_rlimit(task, RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+		if (locked_vm + pages > limit)
+			ret = -ENOMEM;
 	}
 
-	pr_debug("%s: [%d] caller %ps %c%lu %lu/%lu%s\n", __func__, task->pid,
-		 (void *)_RET_IP_, (inc) ? '+' : '-', pages << PAGE_SHIFT,
-		 locked_vm << PAGE_SHIFT, task_rlimit(task, RLIMIT_MEMLOCK),
-		 ret ? " - exceeded" : "");
+	if (!ret)
+		mm->locked_vm = locked_vm + pages;
+
+	pr_debug("%s: [%d] caller %ps %lu %lu/%lu%s\n", __func__, task->pid,
+		 (void *)_RET_IP_, pages << PAGE_SHIFT, locked_vm << PAGE_SHIFT,
+		task_rlimit(task, RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__account_locked_vm);
 
 /**
+ * __unaccount_locked_vm - unaccount locked pages to an mm's locked_vm
+ * @mm:          mm to account against
+ * @pages:       number of pages to account
+ *
+ * Assumes @mm are valid and that mmap_lock is held as writer.
+ */
+void __unaccount_locked_vm(struct mm_struct *mm, unsigned long pages)
+{
+	unsigned long locked_vm = mm->locked_vm;
+
+	mmap_assert_write_locked(mm);
+	WARN_ON_ONCE(pages > locked_vm);
+	mm->locked_vm = locked_vm - pages;
+}
+EXPORT_SYMBOL_GPL(__unaccount_locked_vm);
+
+/**
  * account_locked_vm - account locked pages to an mm's locked_vm
  * @mm:          mm to account against, may be NULL
  * @pages:       number of pages to account
- * @inc:         %true if @pages should be considered positive, %false if not
  *
  * Assumes a non-NULL @mm is valid (i.e. at least one reference on it).
  *
@@ -629,7 +639,7 @@ EXPORT_SYMBOL_GPL(__account_locked_vm);
  * * 0       on success, or if mm is NULL
  * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
  */
-int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc)
+int account_locked_vm(struct mm_struct *mm, unsigned long pages)
 {
 	int ret;
 
@@ -637,14 +647,35 @@ int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc)
 		return 0;
 
 	mmap_write_lock(mm);
-	ret = __account_locked_vm(mm, pages, inc, current,
-				  capable(CAP_IPC_LOCK));
+	ret = __account_locked_vm(mm, pages, current, capable(CAP_IPC_LOCK));
 	mmap_write_unlock(mm);
 
 	return ret;
 }
 EXPORT_SYMBOL_GPL(account_locked_vm);
 
+/**
+ * unaccount_locked_vm - account locked pages to an mm's locked_vm
+ * @mm:          mm to account against, may be NULL
+ * @pages:       number of pages to account
+ *
+ * Assumes a non-NULL @mm is valid (i.e. at least one reference on it).
+ *
+ * Return:
+ * * 0       on success, or if mm is NULL
+ * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
+ */
+void unaccount_locked_vm(struct mm_struct *mm, unsigned long pages)
+{
+	if (pages == 0 || !mm)
+		return;
+
+	mmap_write_lock(mm);
+	__unaccount_locked_vm(mm, pages);
+	mmap_write_unlock(mm);
+}
+EXPORT_SYMBOL_GPL(unaccount_locked_vm);
+
 unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
 	unsigned long flag, unsigned long pgoff)
-- 
git-series 0.9.1
