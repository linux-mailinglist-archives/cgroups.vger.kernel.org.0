Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45A679068
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjAXFuV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjAXFuM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:50:12 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59E43B0CC;
        Mon, 23 Jan 2023 21:49:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Djnvy2h5fFFFHewpifc5gQWX/zWH/4WryCmRgfW+fGx/AIxqCXqo4ka+LlxfngFsT9zWVut1PWvwmShbw1A3CydL2V4sXJVeww4mtorCL2xtWXlNDzKluXe0w8zoDW6AjrlWshKitqsiOFt0+EOyyTg3yEEegANEi3GI+h/KVFXsK4xvzt+CHOSpXovVdOEJoesLsr8GjmUzXjDcSon4oitk0jbx9O8BfdpIQ1e3oMk3pdmns5W1Xi4aBPSD+meneIz4s6/EVQJkL9drVbn/mpB0LMqUAviZ8KgWjK+9T2lFLIxNBLyy18oWXsMcxThTwDxpJV6tdX0ZLtTU9BVPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKauSACOmjp+bD2erTq7Z7sPoUZPfQj7diDqarD8XaI=;
 b=Y/RLQkN34TLLAkbOm4IEEmUYwogokuoJkJ448HsV6axmSseUK6ePM3giUVAnE7ipd/q13BGY975Szw8vvyNWcaWsEaPcbdgmbeWZN7byJ0CD7ro8tat1Ahhc+t1BckAIBKYk5R2J83FHauyLpH4enJxtM+HO04oun9FTm+E/A/tcbtWc4WWx2yQZ/wrekDbdZtY5QXwtkizpU7zQ96XFGpoCed2GjQmXiSVLuKMOhzUmCETf9hWcjh75OaGdtJ6HLh7L3m4GNfjioiFfOmhZtUvUzRQZguB4k3XysXvq5E1HDQKWJGx7nGKEPmH9e+BezBvzOiAQETSM7erTByy7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKauSACOmjp+bD2erTq7Z7sPoUZPfQj7diDqarD8XaI=;
 b=rrFIO2dS0S07TXuOCHnBa/xKtMzAh0p9Y/97yh58OAMl8kppEmSbpi+ehr6vt68Cru4vpnrl9UDqpLT/l/B7n/cMWZoLiEQlINqKV1v36BmetIPoK1TMi2aixQAKBeZlfAHbluielXfN/1hAIMbs9dcV7ME7Ixx10FKgk0x1ldVsYj18RJOtvtj+Uk1xQLUfRQawG6X0GV/+dM1FDRgG8yQoedt2IpadnqrskuIbWK0xrM//4ihzcBmrDQwCJD2BZ4cMkeDoP9VTrE+Z73WXW34ComVk+y9GcmOKp87FHhcTOGKQbl/XO+NuSqAJoiu7OVjKIsAONGbrX5BnuU7uXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:48:26 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:48:26 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>
Subject: [RFC PATCH 16/19] mm/util: Refactor account_locked_vm
Date:   Tue, 24 Jan 2023 16:42:45 +1100
Message-Id: <e72f46bd6be4f3e3c85ba6a560201cf23bdb39a9.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0006.ausprd01.prod.outlook.com
 (2603:10c6:1:14::18) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1ed208-4dce-44b8-cc7a-08dafdce9ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MUrLMQP6VYi2FshBWZPFDHh5/5FgB1z7nhp2c4Zk/uXkKXeIB29602GWxBFidb4r1xNk9BYI+0WWBhejAXYMsycA050IGUMKPyIL8V2TgCO2Oc07nQ8uMQsUrAVkziW7QA66Tplh3DvHRmp99glIZeFO8CaUgHUBR95BpKoFJQq5Om2ncQNn4cQaULkii2S5MVrvOrMviwaJ9UCD9qS+8tQP5B2KQ/6DV1Jy39/hx/zVRsTWAf8mq2/F8cFYf+X/LPCal2DYTtj0tJMFrO5h2omEPSXMgGoaCu5U6UGdUFCMuaXCYOcSf6lqxyQUTfC4ftz/7x33kvOdI0EleJfPKRqOW+GpbEgEIGcisIR+i/v1LuAoXj08sqS8gZyEy4+2bTny6Qovj8bZpREcveHQMjmwHKU6oN7aWtmy3cjq6VFYcbuTQOUb77XYCIgPNxgeZoljP0vFYpXICpbdYmfqQ8jnay6h+A1wsCDfkdUUozTrzT5QgoNvRPTSEPmYkBIae2dvdhxFZu87dxHnxB56U1+h//f46OHME37+RIqIwmxFtLg0ZYVfpvKybCgOuxD9um/u8LtrnsOO822z+Pgb7ranOqAKrZHH3GmYVwmtGfZWQWpnO+0EvOmlhmY0y7cpTgfgUFy1skHqhVANf5dRFw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(36756003)(316002)(4326008)(66556008)(66476007)(8676002)(86362001)(66946007)(186003)(26005)(6512007)(6506007)(6666004)(107886003)(83380400001)(6486002)(478600001)(2616005)(5660300002)(8936002)(41300700001)(2906002)(15650500001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ai++sjTIWs1atPu1MeV9PIHS2Xj47DNdNs+opiD2JENbcFfLRnGaIaBNWalr?=
 =?us-ascii?Q?NYbNW5qlwSod5fDph7bITQducoMS8MIaJPmfQTKDteepo71LzWTkwJzNSyis?=
 =?us-ascii?Q?xIS8+g38+NuCL4swIAUA5qGRcpxs3e0uE78OwA95pXOFNHp8h7RkcItbmVtB?=
 =?us-ascii?Q?bSz1dstUzfzfyU9LPEEE7rk8iwMZm4R1T8YanCOZqs6lX0uMv5bxG5AUoRI3?=
 =?us-ascii?Q?+qe/kXaubVeIbJDzaqU+K8kqrFVC2MOPQPJGVX+2DFPZUTgERl+dCwEEZC2c?=
 =?us-ascii?Q?7NZPCipqnq9CcWc9LnV+4pV8kSMwk+IgRPy7iVXw0YSiGQRAz3ORFW3Vbpan?=
 =?us-ascii?Q?ouHno1KZSCtIhP3zgtmYCh5PRKrCADLOl3WGLohBJuMI0bDngAut5gv4zy+N?=
 =?us-ascii?Q?yd1qG7aSLFqAsmTSyNfDyqU2/Q1meKYiadgzXlzocHj5qC4BFqRyszK9RExh?=
 =?us-ascii?Q?owQDeLUQu5/2YKoba0ea5C0WGQ4uhzty9YXYr2rV8/9gPfVCXz7k1p52BV6l?=
 =?us-ascii?Q?wUglvSnSpJAiT9QiXvfdLcF8yVZ0KnF0ZNyh11HcVbp3KaQs4y2skYp1r0k6?=
 =?us-ascii?Q?HWYtSz9m3+uyk+CeB4QP1EeWLkHmPpm+X0xa9iL/6sCx+r8h/wY9eHZ2h31g?=
 =?us-ascii?Q?iHWFwMP7RdIk3onJ8nOLZhyvdMtZHT+Nudj9asqoK786sC1zEX9dwU2F7TJJ?=
 =?us-ascii?Q?iN8U0N2kBz7EV7YsocZlmvm/820bsWNg0kSVN7CXUo72L7C2h0YQ9XgorGGw?=
 =?us-ascii?Q?+WLpeCjWQlSN3B7DS4349pFaxckNaTk61JYEjWF1e7gQ9DIUqqzy5YZ5A5oY?=
 =?us-ascii?Q?mCyqOkVVE7ireZe7mkXNJYuZf8dGrUAPAJfDw0RU5optYGr8TgFS0XK8bjaH?=
 =?us-ascii?Q?GR4HnpIVE5SNrMLjdAJMmj4gsWWSdzE3SbWiGuZItR9P7/ZaDCwNq6WCH/dc?=
 =?us-ascii?Q?gvV6lroKdOKJvM8vlpgXGTO0tjWIBmTEqPSJcujMgjQ1KEcdQhnqGMqDadw9?=
 =?us-ascii?Q?omUxLpo+b4MUSyiZeWBfz6yOOx+d8uyZO9JS659rwThMxwH9SV56CpSHiGac?=
 =?us-ascii?Q?Ae+C/XXdLEiiS6XvhoLE17oIsxSScBidL5zJRNa6+iBLW9AEG1sWv7wG/P7G?=
 =?us-ascii?Q?eob8jp7KgfCD/V3iprV7Wq2UmiDgCaA0xakX11AcvApojzpmZuLh/LDnIaX8?=
 =?us-ascii?Q?Zm3USeGzUcIdlzN0J7YXuQ2n1VTfzy0DDKaejPhID0LhyVei8cgbUS7dE7D6?=
 =?us-ascii?Q?D1zEJH0QLIqp3nhJLukBs/ZFM/Rtb9W5nmOxve7EZOAwYlsjQFEMZCTm9kEp?=
 =?us-ascii?Q?/sHNXjgCp4HJx1NSmizWJVaPcwEsYR0VaNlDKFpjmjA8LIN3q38fawGjQhzy?=
 =?us-ascii?Q?f4Jg8aWe2NBkQW2/tJH4Kpz5nY4rcGg3FrR6tEcZDfGZpfVY0bRQQ8a2iseM?=
 =?us-ascii?Q?PCCxnCWXwJX3f5jnZ4F8n2U+wH+HfuF5NOYfB7to0deIXnkvr1PRQz45x1uN?=
 =?us-ascii?Q?8rePH5Mex1h/us9di+KmFVyQH7TbKVYW0r+ryPVlmPzOLIhWuMjy5VpzsziJ?=
 =?us-ascii?Q?a66kxaczNDMBK3iq/5GKes5xkxeXR8feziT4MFGd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1ed208-4dce-44b8-cc7a-08dafdce9ca5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:48:26.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YX/Ay4g83eSbAYhQHqkCH48N0bksO9HCgAgprE2g3sLqJrFhcA94gFmb0QaiG+LL+lswkhmHNq1wwwj3DEtixg==
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
index e5fb01a..78b060d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -537,7 +537,6 @@ EXPORT_SYMBOL_GPL(vm_unaccount_pinned);
  * __account_locked_vm - account locked pages to an mm's locked_vm
  * @mm:          mm to account against
  * @pages:       number of pages to account
- * @inc:         %true if @pages should be considered positive, %false if not
  * @task:        task used to check RLIMIT_MEMLOCK
  * @bypass_rlim: %true if checking RLIMIT_MEMLOCK should be skipped
  *
@@ -548,7 +547,7 @@ EXPORT_SYMBOL_GPL(vm_unaccount_pinned);
  * * 0       on success
  * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
  */
-int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
+int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
 			struct task_struct *task, bool bypass_rlim)
 {
 	unsigned long locked_vm, limit;
@@ -557,33 +556,44 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
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
@@ -591,7 +601,7 @@ EXPORT_SYMBOL_GPL(__account_locked_vm);
  * * 0       on success, or if mm is NULL
  * * -ENOMEM if RLIMIT_MEMLOCK would be exceeded.
  */
-int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc)
+int account_locked_vm(struct mm_struct *mm, unsigned long pages)
 {
 	int ret;
 
@@ -599,14 +609,35 @@ int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc)
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
