Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB0D679026
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbjAXFp2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbjAXFp0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:45:26 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3B33B3D4;
        Mon, 23 Jan 2023 21:44:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb3O+BkGV052ySnoKOa7LGiPh2Q84Rl3VxYSPCZyfCMfut4iT4sIDGkl0m0xkmmGCUUutkX30pHcOkY0zi5PeG9T9BxhydURS+/JEjrZy7ZbAS6PfXEwbKW/Ve8xD0hCXjTjuJJkSULQRd0U0exHZyIzl4n4TyEog8fju9JGQkUMxAyeO72CJmdAdQQafabNayo2i/0WHzsg47+q7/nz/pg8wp+Cvn5eWe+HueUP2k3g0d/tPn+Yp3Kc2bXjVCMWyFX8NGwJMPL3TUzWGD+glJjs6yk0n84hoTN1ii8hpSctLyz+a07gPOC9tPHR+jg90szeA7px7KBlhVkx0eSr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys/BSuVjvYg3vlQckN9qotw9N9puGnTTdwB3lsffmG0=;
 b=XcYRMNMgrw1kZusBBbteylsMkZYnSX4eKvlNjEzTBw3gs/8ojFq7VioI8U+nGpn+aD1qFyHZxW66vVb7jdzzV+ZElUZ7ap6+nWw6A9xlZ0+C8mIf0PJ5yxrJ2loS7SaJ1zIK0f31KT8+oyg3X7GAFTX1zlWhx8bCrftTlxHzWuqkLlq3wH2Pl3CakN/JaG2v3x4tZUjtoopH5xl3AoK+4k70TOMxEJomFgvBYl+s4VhqHUwypzi7HO9lucXbCuDvT0wWnF09x6Rzm6mZ1jLGg0FSaPpGAWPb1ZtJKg7WrDaKaW8/bKRQPbzxj+ezXWClmdHVkCPZ/XZRRdcqvVHEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys/BSuVjvYg3vlQckN9qotw9N9puGnTTdwB3lsffmG0=;
 b=VMqRAsovhuiP1xlHzwhCtlAjrD4l00fCvvvfVy44+q4zWKTW6AUznfapM3qZYyLL7Zo0TAow/blShV90PvoRb/xlIdIEcSWt1wjlefZcGYfPH0PNi0Nim0zEBTM+KQtfCZljuIo/dZej0/O7Lzij2jWwT/I+zJefY+jRSTh6d4LY/bwZvypcYNH2x98rb1c4MLPKTRRvBBYBeeXFeVkE8CAfo9r49jlyUqbQiDI8wo6tgtDIECAIdDXMM+gvgr5drIdK9BDxSZKUgWyhK6xcrjZyT5pIQHWglSQlxWrX4UxkJoj5AeQXqe3CsNNxgwNKwvj+DHbEuJ99Zl0nVNKhwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:44:27 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:44:27 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH 05/19] RMDA/siw: Convert to use vm_account
Date:   Tue, 24 Jan 2023 16:42:34 +1100
Message-Id: <4f8b1d54ab5d6909c46ba5470065f8326f9fcc62.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0005.ausprd01.prod.outlook.com (2603:10c6:10::17)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 90992122-bf85-4cfb-bbac-08dafdce0e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPoVJFoi2Q5dygKTO+tA+wp3wYXP9Odmw4uNetAYU4PsftNIGUxGUSIGMDEW66kbv0L2pSv8IZjHerNBaTqA5BYNpiMVI5B0Hq1KDbrtgEYfIOmjrCbE9o1Gy66CvMgAQWSSnDjRI4vKUhN6AH1ANkK2Gcq6AxxGPJhBjNZ4PWb74q+wDutA68XJ3+qsGGufYgOukDkgeO809WDn5iWQdOMgF6bAi0c7p2Tc18KbyVMSI0xfykAiXcSOM/LhUll1taz4rr5qY6CPR6ZU1Ax6bOiaOyg5lysmjGowykz0T9yVTX884HzXeCOzlLeJG2IgDJgDft/LMh1zMxh8wYhUqmEjIfSjW7Ts+8NYvTuyPwM9aO3BUym3YQVYX/FtBuC7YdHUG9LGX0CAGY0Ak9PH79YJDLqglVlzK/sQaUcEZdAkPBH2i2ML2OcN4TQGnvMzEIt42NY3seep/YvCG8Tz6av5ZRBs5qF75zuUCFW9qMPWaisSprb57iJaalEWYqGDbk98sOkxIJIlgHv6Y3OBlk7LUI1zYj/nUwKHogF5HbJiLDSkAf6sSRnffjlwYOzZrE3CJ4LCsA4mciMOSwHysuMd6cNPB6K9Nje3vwCF3YvK3AuVoCmB2neSiiIYdpvz++SDX2Rl0IN+Cm9SHV8yhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(36756003)(86362001)(5660300002)(38100700002)(2906002)(4326008)(8936002)(7416002)(83380400001)(41300700001)(66476007)(478600001)(6486002)(66556008)(6506007)(6512007)(8676002)(26005)(186003)(316002)(66946007)(2616005)(54906003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7INmr83+joiH8mGAyXhiTEKLgagnKOtAuPSs35DKgMe51e2kS33fbUWuaCDt?=
 =?us-ascii?Q?jViRoxUpqVo1pOgkJxQY0rGOIOG5X861wNtgV7tX9idG2Z3nQ/mQV6g8gnuV?=
 =?us-ascii?Q?rJfy0fS36QCEUBVwpvuvVQPIS1suhS1pTgZmoCPFuFlUMnGYd7+ZqpEcCj6J?=
 =?us-ascii?Q?nZTtILSzltnzZySskWf6iLV66xj+NAxsUgLlrrq9fFRXrEgM5OBfGYoWp7Gq?=
 =?us-ascii?Q?GtEMVGw9BnwkAA+nChegXAC9jbvpal3V7vEUo/5BRjUt3eaWbXE72P/MFtWM?=
 =?us-ascii?Q?PAR5VnG0B6H/VwTdMSJA1T1uVDSQYUyH7crXfv47Q09NAaWK3n7IE4CsQ09E?=
 =?us-ascii?Q?k8pw9FG4Pz3LMeeeoSjFtpwWHz301Ya7dafRTqfiLJgIDeJ4A7Js9CAsXWyS?=
 =?us-ascii?Q?qOSYSC5jf03idiW/PoZABpMOchr+S41KTQN102Pb5ge8sUZ1eTuoRpfQXhJ5?=
 =?us-ascii?Q?/gT17z+Z+aSxVdlv+4VuURtVdEnINALsORK64gTgRrU5lsGrQ1WNvVw/ajyM?=
 =?us-ascii?Q?AzAqvvkkIoqLhHhwqVAhO+uHsnHCaRreRtD0JvQ3CBsuj1sf7QvEIop9aCaA?=
 =?us-ascii?Q?CT5Q3x4H3W0YeRUfrkK7yhSYnk5oyonPDzsPxuCGGSYouLNhRbvm09eQGbfx?=
 =?us-ascii?Q?PUL7HHcQQCP9CfRatdBrxe0XqspdxXGou8Sfo+/AecJ2u0pmnDx0xETm43qT?=
 =?us-ascii?Q?1LJLyb3dsxnmtwJ0YFTe/qFIXSqCoAX1ojr7StL7AGRbiVZu+DRtOGjhBZ8t?=
 =?us-ascii?Q?CA/DVbHoneq1J8FGedSTHTQzzjuhVzZKkDZXtJL86tJyHWZ4klqw0XjGKFjP?=
 =?us-ascii?Q?/+ON514Zd6vpNYwDuqjU+XAUWAeBKbDcMJmQXbVmK79W7S9krG/eXvDGYJGt?=
 =?us-ascii?Q?bCefdiiP4jx+OO9eVzgtTiTgpUBQw8AHPczYgd7Wxcyfx3HfcH73kcgWZtTF?=
 =?us-ascii?Q?F4eVraYb5cioQ40FT/oV+Bbo/fT4aCftSI81r9hUwTLlgmtMlgaOgcfY+qB1?=
 =?us-ascii?Q?76mjqhgIv8bfWriwOFawZjJxIY+QSO6Ld883nMuD8f4uFmOTdOPjXRYWSV6T?=
 =?us-ascii?Q?p031k5ShYEPrbs5kivclLPnES47Dfdxi1JOFIVvN3Qd0jqEIWUb4Q510Cywc?=
 =?us-ascii?Q?oWZf3B1IhWN4TjLWv+4ZXKM+4m8xUu7wVkqbVo/oOLX35vQyZojGDBmCXkpl?=
 =?us-ascii?Q?z3IRzsvVje7dwCuXFx/7Ani3FB97FW36RzPkm/t4f69CP0djQOcgCr4lBRLb?=
 =?us-ascii?Q?VAe4m0vdCzu85nuaD4gewwowQzpykrJWXIjnmYOP0YvEGie3xyu/SqYVeKxb?=
 =?us-ascii?Q?YLW8bbD9052o1egjKcLyStEhIauRNHSjU5DSianf1ueeNODGOs+Fc7OMLKan?=
 =?us-ascii?Q?JG9d1n8UAlpBgzMZlhqc0caF5A3nOItY2wP65A+X+mfpF8oEF4GcTCxIj5Gh?=
 =?us-ascii?Q?ntDQrMKiGKyq67ghzWGMjY0cXyPLOm0RuxDnQ6r1DhOXixTPO6iPcXH+sIu5?=
 =?us-ascii?Q?XZKhzpiUPwiFnFeGtqWG91VKBxyG/NLL3yzdMa4Lo6bujdGeta40XrCOQMhX?=
 =?us-ascii?Q?Y86m0rhApeqgbDFgjs+taJ9YlGhwGtiRMS7UZGxi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90992122-bf85-4cfb-bbac-08dafdce0e2f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:44:27.2570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfimHfBEj5y93A4hAuyjqPMkRtt0veLtE4+3AW9Jcl3CCT/FaZIc5uyx7oJJGClA2Xa69XYBm4Y+udtVvo/ePg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4540
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert to using a vm_account structure to account pinned memory to
both the mm and the pins cgroup.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: Bernard Metzler <bmt@zurich.ibm.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/infiniband/sw/siw/siw.h       |  2 +-
 drivers/infiniband/sw/siw/siw_mem.c   | 20 ++++++--------------
 drivers/infiniband/sw/siw/siw_verbs.c | 15 ---------------
 3 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 2f3a9cd..0c4a3ec 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -124,7 +124,7 @@ struct siw_umem {
 	int num_pages;
 	bool writable;
 	u64 fp_addr; /* First page base address */
-	struct mm_struct *owning_mm;
+	struct vm_account vm_account;
 };
 
 struct siw_pble {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index b2b33dd..9c53fc3 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -68,7 +68,6 @@ static void siw_free_plist(struct siw_page_chunk *chunk, int num_pages,
 
 void siw_umem_release(struct siw_umem *umem, bool dirty)
 {
-	struct mm_struct *mm_s = umem->owning_mm;
 	int i, num_pages = umem->num_pages;
 
 	for (i = 0; num_pages; i++) {
@@ -79,9 +78,9 @@ void siw_umem_release(struct siw_umem *umem, bool dirty)
 		kfree(umem->page_chunk[i].plist);
 		num_pages -= to_free;
 	}
-	atomic64_sub(umem->num_pages, &mm_s->pinned_vm);
+	vm_unaccount_pinned(&umem->vm_account, umem->num_pages);
+	vm_account_release(&umem->vm_account);
 
-	mmdrop(mm_s);
 	kfree(umem->page_chunk);
 	kfree(umem);
 }
@@ -365,9 +364,7 @@ struct siw_pbl *siw_pbl_alloc(u32 num_buf)
 struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 {
 	struct siw_umem *umem;
-	struct mm_struct *mm_s;
 	u64 first_page_va;
-	unsigned long mlock_limit;
 	unsigned int foll_flags = FOLL_LONGTERM;
 	int num_pages, num_chunks, i, rv = 0;
 
@@ -385,20 +382,16 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 	if (!umem)
 		return ERR_PTR(-ENOMEM);
 
-	mm_s = current->mm;
-	umem->owning_mm = mm_s;
 	umem->writable = writable;
 
-	mmgrab(mm_s);
+	vm_account_init_current(&umem->vm_account);
 
 	if (writable)
 		foll_flags |= FOLL_WRITE;
 
-	mmap_read_lock(mm_s);
+	mmap_read_lock(current->mm);
 
-	mlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-	if (num_pages + atomic64_read(&mm_s->pinned_vm) > mlock_limit) {
+	if (vm_account_pinned(&umem->vm_account, num_pages)) {
 		rv = -ENOMEM;
 		goto out_sem_up;
 	}
@@ -429,7 +422,6 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 				goto out_sem_up;
 
 			umem->num_pages += rv;
-			atomic64_add(rv, &mm_s->pinned_vm);
 			first_page_va += rv * PAGE_SIZE;
 			nents -= rv;
 			got += rv;
@@ -437,7 +429,7 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 		num_pages -= got;
 	}
 out_sem_up:
-	mmap_read_unlock(mm_s);
+	mmap_read_unlock(current->mm);
 
 	if (rv > 0)
 		return umem;
diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 906fde1..8fab009 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1321,8 +1321,6 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 	struct siw_umem *umem = NULL;
 	struct siw_ureq_reg_mr ureq;
 	struct siw_device *sdev = to_siw_dev(pd->device);
-
-	unsigned long mem_limit = rlimit(RLIMIT_MEMLOCK);
 	int rv;
 
 	siw_dbg_pd(pd, "start: 0x%pK, va: 0x%pK, len: %llu\n",
@@ -1338,19 +1336,6 @@ struct ib_mr *siw_reg_user_mr(struct ib_pd *pd, u64 start, u64 len,
 		rv = -EINVAL;
 		goto err_out;
 	}
-	if (mem_limit != RLIM_INFINITY) {
-		unsigned long num_pages =
-			(PAGE_ALIGN(len + (start & ~PAGE_MASK))) >> PAGE_SHIFT;
-		mem_limit >>= PAGE_SHIFT;
-
-		if (num_pages > mem_limit - current->mm->locked_vm) {
-			siw_dbg_pd(pd, "pages req %lu, max %lu, lock %lu\n",
-				   num_pages, mem_limit,
-				   current->mm->locked_vm);
-			rv = -ENOMEM;
-			goto err_out;
-		}
-	}
 	umem = siw_umem_get(start, len, ib_access_writable(rights));
 	if (IS_ERR(umem)) {
 		rv = PTR_ERR(umem);
-- 
git-series 0.9.1
