Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1E68B6B9
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBFHtv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjBFHtj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:49:39 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E01CF58;
        Sun,  5 Feb 2023 23:49:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XN2jl/HppWe2WbAIMAP0hRU+gmLJ8m8azfsx4T2fHkNR61TRgEGZ44NeyHuSbxda6NryeHkfrWbq63Vxtp1zXYaIkorIk8m+cIHfVF9x+iK5W6jnd2ZbN6theKf2u8keLZvndkprY04XDl5viaWga8GkM/1JzZqbofc7wLr599/RxToXo8xHr6NDWknk9LomxzBcEFh+cZVmE+1Be2lwAAVUTxYMJ1bLDhlFFOHNhgV+87aFoNzJVqcta71Ay3wcfPnP0binqM8sLAYd6Jo4Wf9mZTVype8SzRHoY3kAiujeU+eQ0qnwTOUnpQMsEro88ABOrH6Ez5PXTwe2psLoGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbbfhEFK8Y5g+MZUUcF50R2sJRtJy6ACgT2r4mlmBvQ=;
 b=mnTUGofFQWPhl3fcsDP3n2cRv3qzr1bRl0HVJ02Lxc8TzF93TRVBXbMXUU68lt4Tx648Gdq1bubNI8fKhBrukIS+8b4U5kyE+hCXuNUo2i0A/KSCacXQ2mbfIvpCFeplwLyBjmYs2CovgCqVnhgyzUUS+PXCHc95FcN0yXfM5WMh7IZPFXkxRsN0WCLgqRLn1F+PK3ALsDdLsqyMyAJDdIfUx3IFmGVSgnlEi0rcwPKFBrOoVCYn79FfvwcLrxEB3dmXdpSvi3sYHFG7tf7q/pVLJ3An8d+GxeuUV0VRKMVEWrhmRfPQmkN64dH2yug2qGlQZNdg9xzBtQ4jLPq3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbbfhEFK8Y5g+MZUUcF50R2sJRtJy6ACgT2r4mlmBvQ=;
 b=VGMmwdNVNSN3VYOHfasKm4H2Vx/Wsl7VT43FSwx/C/VBjckm7Z0Ur3KvfO19Ogny3/QHdBpZR2TxH1cyjqViL8X1LvbN7064TIHNBeh5EjfdDvEfA9S3YswQnr4H1rsB9do+VmEPmu6pR+CKJrKAesYOh7UiZhgT6Xw1jeOcZwImkHzmAKb+GtfQH0O95kt1BZek0Szut/nml4gDoO4uPrTyJpYp8S8EaeFo1NPKt7hQA+eomC/TPpsGxux4huucOmRA290Iagg9Fe09yDrmQVpkKxf8qRnjTtgW/tFPs/ooArhZWI/x21/myiFVMKdhOB7I3OyX/xtuxucWY24OvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 07:48:48 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:48:48 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 05/19] RMDA/siw: Convert to use vm_account
Date:   Mon,  6 Feb 2023 18:47:42 +1100
Message-Id: <d1a04938f4ef21d48345d1d3614be10fc75d8536.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0180.ausprd01.prod.outlook.com
 (2603:10c6:10:52::24) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: d1719398-e6af-44b3-bd37-08db081694c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mEgnJ2byJYYRp5TDKz4QiINbbC95btTBNqenhr792EFCNVZ5vubMIiUg9pa5i8+JU4s6qxBvrlhVt62u/Zl0xs1+bEMXnhrKqnvck8WgN666G9HSZaXadccoWUbVd/7M5ctXxwfasjKap9ptYFuOcMnI8YWN7oJ9/3//X5c5lNJXiG02aE4Kb9/DLSlFMKNINOUdY71D44WUnVevEHmNItB9w0LfSU4UEynLrCz4RHyQyCupVnofIhNqzbqySBF4Px441wauBPi0JNCdYF/88QHoquXb+bfHXE+zJhh53sxPAtT6G3Rnjb3OY9Cy91M8Im96+qROqIa4V8TSSL7ZBEoFpw14soRTthjWO6wFthqoDpsDjzaXwsMScJkeOCwpnyOKvjj/I9D/Se1J1X/il9oow1t1+HtvqbvTtb6m5jZgJh+mKl96Or9M5Y9VQGnFTKAiLM5cMQr/h6B7Xex0+lGlc7+7ziT2i09YSsdW5CTYPtkUsLwIQ6/oBjJM0vQC3ZvG8QvkcNzbbw4Y6YLW2CbcfHtJ/Jh9jmkkGcIMc93pXD2LrFY4qtS4GYO+JuwRXmFJQuiHkUNI9oxN5kewX2Ez7C9QmUzbRRMy38siwC5FFdLW7tl0QR9JjSXHcQAyO4f+QOF/1jys2tDj8jYDeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(38100700002)(36756003)(6506007)(6666004)(6512007)(26005)(186003)(478600001)(86362001)(6486002)(8676002)(66476007)(83380400001)(66946007)(2616005)(66556008)(4326008)(316002)(54906003)(7416002)(2906002)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kr2qioBvqyrNtr6voJ4NIWmH7hfXk5CZrJHSm+qHv3srTYOWKjzA1CpgwZCg?=
 =?us-ascii?Q?qcJVQ4YkXGff1cPcWGA37PI2bs2wtH7njipEtd6uKWj1jGmbSbjS0BDjK5rV?=
 =?us-ascii?Q?5YbzHXvHtpui72aQ1hrrI07TWwP7XA5fMLzs5GniW6Rc/dBNkp5gtgDHQCMM?=
 =?us-ascii?Q?DPfHSRK8/R53VuVQjPKMSwTs9mrUAzUI/xQG7PavAhIG+bIg4iSwSKLQj7MV?=
 =?us-ascii?Q?aNZ3WMiEDt8sHxLADR/Opb5zOxgMXOGTCExol0A0Dvu8Kj6DgJMs7QeL+8pf?=
 =?us-ascii?Q?T9jB0YkUvqzD4unMyaXyrbLEfJgKF3SLwbI0oRGAZE1Z8mRBLKl7X1VjtGr/?=
 =?us-ascii?Q?iJu+G8qN5teztyw3lobuTIHY/hoLX1LZFkWYgw94RjvPHE4kDdc4HuaR5nnG?=
 =?us-ascii?Q?SCGovylAiDdUPhxLWZSm/AwEkfTO4iCByHjOJPlU3ZT6d8JJzriZTBNCbSwe?=
 =?us-ascii?Q?qkLhW5D8m8hj1rcqIbdSynWpkp8KVMSdHP3dVr+Thb8mPemNz+IVfyKyW/Ec?=
 =?us-ascii?Q?pUzvkEk5rUhBLcILG5SnTP3TK6V2yEw0PaldIfrWNcC6jv017vh6KYz3dL84?=
 =?us-ascii?Q?1DsEGSfZ42AfhH8ry9oGXCgK/GIG4sgxMebqbIU27Vbj9xajK7lDu1NVtP9a?=
 =?us-ascii?Q?7ZKqg0pYccepGekpoL1t6i4V+78mWdTwgBzJEoud/OBNRXCKYeyvCC8Y/Fs8?=
 =?us-ascii?Q?F61pzLfE9Nj58os52ijNdSK44nUFMdP0Zk6/lbD76rx4U0ewygMRlryukzDU?=
 =?us-ascii?Q?1aFSsiGRcVxeZd/f+okJWuJSau/vsxGL0TzXqefEKr+kyF+Z2SmlUbfJYE1v?=
 =?us-ascii?Q?gTdDSOJ3FcbNkTRt94j2JUJtTW/jV5FTrBRiJ0KO53X9VjhAl7KJ9Wfp5e+y?=
 =?us-ascii?Q?XVWy2DeatsgGkqDL4LMSdWL978est4D8SCl7I3+p4w/Wxg4ndosb3+nKoiFa?=
 =?us-ascii?Q?kMfM3Hnv6Unb9D5Rtf3LtJsfZ+vTNldIcKGY11RgdDVgsT1E8qw3QB3SRRvb?=
 =?us-ascii?Q?zbr4ysQ2FCXxE+SeJuQMPyE+B5XykMfwVyPLCAqypLzNwHL5BD/htEZg2Ea5?=
 =?us-ascii?Q?XApVVFCgNlsWnYQ4xOfA4DEB5VDMjfrF4Lt96O8VZukD03QHEXxk6dXd8wN0?=
 =?us-ascii?Q?YsgVpUsqCjZ48uYbpNFjGyUfffGy1YPE5l+vj7rW8C7Uno20VN+1ou1JIv/s?=
 =?us-ascii?Q?BYR1gyxc7ZTm9KyPQ/rs7HcIaDkhQ7zms8yQ8VsD2Kil+OAftlXJsypAw/wY?=
 =?us-ascii?Q?ZvZAirWFGaOjaHmCsN/bdfw7mHn7VI11bFi88VhUklQFUkQrNAO3wE2xKKtB?=
 =?us-ascii?Q?MuHxXyBA9lFXsQErduHwoHy3eRbW3gWQkchIDeHPEhEiHjPOosZvzogl+SLp?=
 =?us-ascii?Q?x9Da5rHvqo73UsF6sUTYk43A9O/hfrur8OTrExrN3M0aFu6o9Ly+kXtRZi86?=
 =?us-ascii?Q?zzMdLsH0Xnea1al5RwYUZ4vV7p5ypIGwmu30mR4zzu8kderGOKFxHzFycWeC?=
 =?us-ascii?Q?9pp7KPnFInUaGgg9Qp4VcigyW/5yN2LOisgkIzHfeO0E+cLWwKuJ3YiGdRgL?=
 =?us-ascii?Q?MDovtfbzmIS01cDomgzsAo0btV+7j5qIGD3lGr4L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1719398-e6af-44b3-bd37-08db081694c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:48:48.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sPTS0ifI+wgKwzc8U+7q4QMN/tEOXb02+weR/NeNFNKlKfv+KJERpFtqaAe3R5M1A2XI8D6T5oQAMoc8J3A+vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/infiniband/sw/siw/siw.h       |  3 ++-
 drivers/infiniband/sw/siw/siw_mem.c   | 21 +++++++--------------
 drivers/infiniband/sw/siw/siw_verbs.c | 15 ---------------
 3 files changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 2f3a9cd..6d4aabd 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -13,6 +13,7 @@
 #include <crypto/hash.h>
 #include <linux/crc32.h>
 #include <linux/crc32c.h>
+#include <linux/vm_account.h>
 
 #include <rdma/siw-abi.h>
 #include "iwarp.h"
@@ -124,7 +125,7 @@ struct siw_umem {
 	int num_pages;
 	bool writable;
 	u64 fp_addr; /* First page base address */
-	struct mm_struct *owning_mm;
+	struct vm_account vm_account;
 };
 
 struct siw_pble {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index f51ab2c..be90121 100644
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
-	if (atomic64_add_return(num_pages, &mm_s->pinned_vm) > mlock_limit) {
+	if (vm_account_pinned(&umem->vm_account, num_pages)) {
 		rv = -ENOMEM;
 		goto out_sem_up;
 	}
@@ -434,14 +427,14 @@ struct siw_umem *siw_umem_get(u64 start, u64 len, bool writable)
 		}
 	}
 out_sem_up:
-	mmap_read_unlock(mm_s);
+	mmap_read_unlock(current->mm);
 
 	if (rv > 0)
 		return umem;
 
 	/* Adjust accounting for pages not pinned */
 	if (num_pages)
-		atomic64_sub(num_pages, &mm_s->pinned_vm);
+		vm_unaccount_pinned(&umem->vm_account, num_pages);
 
 	siw_umem_release(umem, false);
 
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
