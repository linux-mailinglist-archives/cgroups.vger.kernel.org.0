Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546ED68B6B1
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjBFHtf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBFHtP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:49:15 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F8B1E1FE;
        Sun,  5 Feb 2023 23:48:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3zRX50/Lp7tD2TtC29nYwzq6A4eIeezs2ezZLJbj5liFzIktI7OS/65Hdh0xdp/PbjYV4dFv+Sfu+uAVbcPXM8eyXcRocoD2zYb2z/CjuVbgm8wovpcT3YDm8Xc6nM8tbGiKCvwSE23Wky+fOWMCzGDoPVmQRD3fA1WLL3UwycdPIC5/p+uybOlCh1MzBl+B75jF/G774DNZqcRUJ+0Op60U7lfa4JnFF0616GDdrUQxuI69isqjPKJaTg25VkAYWAM4tk6zwg9aJvrbGYMRcMXK9TLfMTmDixIohIc98CIWnJmGhPE8kG3ZO3sYzL8rIXc/P5PRKjgvYqAmfNTMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ggww8xGqVkEn1m6fFSqIeGeKfBiyQH3gSOfKyWdB+MU=;
 b=nRqcU8SlI5ozKvuRTjwIW7R1YRuy+MsMXgCydX2k1NVuRPIGWcYO8v5Xv4jnYToHxkvADsrPTDLwrUvNDhxWy8WF0yPBNQPUG+jlpNQTy7572cdqNHgV+oP/R2sRd05uPR3VcyUY/5LKmnMIkDEz0ta3etjkfVH4U8FOVAI/uD8OqMf6iaK8edHggSwZSUXatrSS6TxXu3XNiH8Z/RTEtSkKO7FZBpkm/7kMghp8mEqm0sECRqs5QO4kYWsHR3s1zM61ZQCwbZKmhjgXiYWJm2i6jVGaV4H+Gyxw2V9KsoEGgTDt1E4tWgvsWNXfQ5u9CVTPHm9aVfyXpwIVtnLWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggww8xGqVkEn1m6fFSqIeGeKfBiyQH3gSOfKyWdB+MU=;
 b=Y4HQgHQbpd91DuQaDucY1BFD5ChpJLapbErCJK2J+Qdg5Zx3stAKxZfg6VuRoL8s4vyXjQXCzFra6r6nA+gOs06zJbufQur7eGvFXmHJbzoSFxkGL6DF+KhHE3q3v1ciT5JfcQtrpuAa7n1zHzaXkTUZEZfvuMMfQKE71BIrdvzHusNUsFlE0TrMLO/PV0c0lXrVjw4CBw7P+B5+SVnn04YuhMPSKptsOCYFvaEaexRvZykf3inWlxlrpw8GKCfR1+2MVlVy2sYAd831w0X9oO2VtIruCF1GfWwqfQyAItcM+2e0HwP31U+iWy2oh1Y/G8H42/B1RHbxRGtzlWnuuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 07:48:42 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:48:42 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 04/19] infiniband/umem: Convert to use vm_account
Date:   Mon,  6 Feb 2023 18:47:41 +1100
Message-Id: <e0783b0b0f869cea19b45ee58f10618862daf6be.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0103.ausprd01.prod.outlook.com
 (2603:10c6:0:2d::12) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a73dbe3-3319-4ce2-5ac6-08db08169148
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/B80LQTVpL3jSLjBEjJ9QzNuXDWASskW1lHet9GroRZuF0YWlRLQJ2l6+dKcvBNT4uIdj3tgA50O6uDks7H3QyeQQ2mmNBfrQwGddxplhOX+lzizG0xwlfnhw733kRTbNW5m9EF7VmCDQU/ksswQ0Xvfq8Zq5s/1UC4s79qXLLvWzyRqJah4PaY4VukpAf2mK2sTLhRsGaV6p8fdYqI3lR4POWM93c/dKkAxlQRI1TzhldgsdwWxlXfew/fjG+QalrH9eRuTwPNLzgF/9s4+R239SOVYyzPdOq//F8y2RIxBal2+R78/9ZQkj7F/8dFZ0z8ET88cIyClSZIqNkOYA8/1YeyVWPGUG84L8qdhCssAy54zvJBGXlpzMkl4XjBp0yo9xqHAqwmu84/gql6ORMSdWpkFbleqf0pxocB31fOAliRLE26qLtbqQ5/1Lca0tKOMITqd7aBQJe8IrKMOSwTmj4A+z8CJ1yt7E9cQo19MW0LjJsqd5DhISCVs0UdExjs44vaMeUT/xLHO1DHOzY/Sbk/juEiillJDTHT6z++t33Sss25mBfe3AwjY4SPgZ2HzujYCccPx1VNfUfWbHNgowcQCR+Y6K0iLAeGv3EktxQpf8nahk4jzTTFBrN2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(38100700002)(36756003)(6506007)(6512007)(26005)(186003)(478600001)(86362001)(6486002)(8676002)(66476007)(83380400001)(66946007)(2616005)(66556008)(4326008)(316002)(54906003)(7416002)(2906002)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ubW3xrU0eGbFRq+G6RJcwlsfu6Ao+kgomSilgOyEGWZ8GnBsXzXYNDlWM32S?=
 =?us-ascii?Q?9LpWG3caLY+45OVebDiKsG9RjYQeSCNLseBRz9Q/nsngnSZ44QPcejoiJJjH?=
 =?us-ascii?Q?zbe+9ASDL3KZ8Vd0FbNgelO3asfiSNs0ykO57Hd+OOqppUqmwpg7qGk4FHDR?=
 =?us-ascii?Q?1rZAQZHVxbyBswPbqdDLmXVPJRxyCYz4g/dIWPObS6YibcM90G1kPud6Gd5b?=
 =?us-ascii?Q?lcwePU/DQnD4ZbnfqTi9NAxTLz826/zRE4QvOemkr6fxeGr3PGVoSADxhqbu?=
 =?us-ascii?Q?3CVMSY0Gq+0slPx+k9H6FuCEXqCS+wCVlcLsb3rNn4KJzc9RR6qwUx1IAXOL?=
 =?us-ascii?Q?DhhxzkHWeRWm7RpWkM353mwqX5pqx7c2zklTbKFIvUzos4hva0ZzNjGOZJKk?=
 =?us-ascii?Q?XRguAFsTKMyK8Tt26D/Ns1IxMBNu0ogQD9zsGTvBcvoq2mdnjJkH+x8SU8+r?=
 =?us-ascii?Q?2xdUC2IC48OwBPfd9O68iZybjp5hi0m69EU3qrtcrReabHCrO8UdlOL7243A?=
 =?us-ascii?Q?CaNmlyABkfU7nkpKepp9R/Y+ScXtI7UMtyNAuVB5UluoNjLx5SATikTtw3Pt?=
 =?us-ascii?Q?XPj7herx2KK1/o4QHS4ytiLWQRauR0Ws5IsuY34yrO46U72rdx1OhHXfLQ5F?=
 =?us-ascii?Q?fPdDIYm+ygPb5/6WSDtwnf6pYl/41nKB46r8CqJpsGKRxl+fXlc6aLTc0HUf?=
 =?us-ascii?Q?X++4VycAwoCRmWeM3cQXQehFj22YVnMpSUZ72bvYKsBKZvBwAS2e6VpDieFx?=
 =?us-ascii?Q?3qm2e7di/Q7qfeNmeY3uMX91421Vq9H+jPqS6i2NbI84Z8PkJPevUu+1jyhZ?=
 =?us-ascii?Q?F6+MZ2fee+SoP0ej9TZOPhjjP6k0bUJHvHRgNXNrfe5doszBcgA8QxcXajOI?=
 =?us-ascii?Q?PoQDnzbS/aADmmNO0lmPTRh3sfBtZo+Y/9OywcgJS2X/JKVA+KWID+sg/Mj8?=
 =?us-ascii?Q?JQT6Mf0B+7Yc9IrP76s7IdRSyVbwCBhqFbSnSRy6NbEGh8EPkIQs/coWPsjz?=
 =?us-ascii?Q?qdN77uueeJ19G3sj6OZTe4kcqMm/bmGB4ckjmBJ919mPyo55zKyQWnDcjsPx?=
 =?us-ascii?Q?CzWlkzdNhB3K5qPbi7G3kAaz8qYId16bwGZPrtOwpf5EelwU35o2B7ndMRLq?=
 =?us-ascii?Q?lEyGSpWH7fNS6fW9hlNlG+jcFpO6rRe79QlXH8I9m4iEbxiySI3St6d0lzO+?=
 =?us-ascii?Q?cUX8H+0kcAMswl5HYwzMJpYKvRsQMEnzR255R2ocS4daaQwzJsP1RBaLJ52c?=
 =?us-ascii?Q?us8zYbOpvYvQSjy2a5LDeu73N4hMIbrEhUQT5ChLS1NLaVdjr8gbt1akfdL6?=
 =?us-ascii?Q?bpbbMnnWV8bv0aC54TcvNKS+Ea8b5udNZfZWD1J4odCyKsX2QXxwIs4UP5+C?=
 =?us-ascii?Q?wYxbY4AGVtxB5nc1i9UQRCLplKteBtBcmzKOF6ugM99Dyo8d1JzOejv5dkdX?=
 =?us-ascii?Q?CneCfDsamuTe/PKBihj2UHA0YSZdSzOY3vjXsyfib9hdwrNQmS+uL+u6Rxer?=
 =?us-ascii?Q?WAXuDRWa7M8M0C/HudBP80dHFEgxiVEn7NnRTfXODB3v3WRylzD02OaypRCs?=
 =?us-ascii?Q?1sYhWDuc649+9Wfhf4wF6+wFKVpWik+fdBDInjfZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a73dbe3-3319-4ce2-5ac6-08db08169148
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:48:42.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xkdaR23n6b0+bhaWr+Avl1uc+gTnm7SJDHdHr2AR6iQKfTKWkLr3YjTvCIVM1p3eNklwHEvskiS3YS7BrKIEA==
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

Converts the infiniband core umem code to use the vm_account structure
so that pinned pages can be charged to the correct cgroup with
account_pinned_vm().

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/infiniband/core/umem.c     | 16 ++++++----------
 drivers/infiniband/core/umem_odp.c |  6 ++++++
 include/rdma/ib_umem.h             |  2 ++
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 755a9c5..479b7f0 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -149,8 +149,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 {
 	struct ib_umem *umem;
 	struct page **page_list;
-	unsigned long lock_limit;
-	unsigned long new_pinned;
 	unsigned long cur_base;
 	unsigned long dma_attr = 0;
 	struct mm_struct *mm;
@@ -186,6 +184,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	umem->writable   = ib_access_writable(access);
 	umem->owning_mm = mm = current->mm;
 	mmgrab(mm);
+	vm_account_init_current(&umem->vm_account);
 
 	page_list = (struct page **) __get_free_page(GFP_KERNEL);
 	if (!page_list) {
@@ -199,11 +198,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 		goto out;
 	}
 
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-	new_pinned = atomic64_add_return(npages, &mm->pinned_vm);
-	if (new_pinned > lock_limit && !capable(CAP_IPC_LOCK)) {
-		atomic64_sub(npages, &mm->pinned_vm);
+	if (vm_account_pinned(&umem->vm_account, npages)) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -248,12 +243,13 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 
 umem_release:
 	__ib_umem_release(device, umem, 0);
-	atomic64_sub(ib_umem_num_pages(umem), &mm->pinned_vm);
+	vm_unaccount_pinned(&umem->vm_account, ib_umem_num_pages(umem));
 out:
 	free_page((unsigned long) page_list);
 umem_kfree:
 	if (ret) {
 		mmdrop(umem->owning_mm);
+		vm_account_release(&umem->vm_account);
 		kfree(umem);
 	}
 	return ret ? ERR_PTR(ret) : umem;
@@ -275,8 +271,8 @@ void ib_umem_release(struct ib_umem *umem)
 
 	__ib_umem_release(umem->ibdev, umem, 1);
 
-	atomic64_sub(ib_umem_num_pages(umem), &umem->owning_mm->pinned_vm);
-	mmdrop(umem->owning_mm);
+	vm_unaccount_pinned(&umem->vm_account, ib_umem_num_pages(umem));
+	vm_account_release(&umem->vm_account);
 	kfree(umem);
 }
 EXPORT_SYMBOL(ib_umem_release);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index e9fa22d..4fbca3e 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -130,6 +130,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
 	umem->ibdev = device;
 	umem->writable = ib_access_writable(access);
 	umem->owning_mm = current->mm;
+	vm_account_init_current(&umem->vm_account);
 	umem_odp->is_implicit_odp = 1;
 	umem_odp->page_shift = PAGE_SHIFT;
 
@@ -137,6 +138,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_device *device,
 	ret = ib_init_umem_odp(umem_odp, NULL);
 	if (ret) {
 		put_pid(umem_odp->tgid);
+		vm_account_release(&umem->vm_account);
 		kfree(umem_odp);
 		return ERR_PTR(ret);
 	}
@@ -179,6 +181,7 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root, unsigned long addr,
 	umem->address    = addr;
 	umem->writable   = root->umem.writable;
 	umem->owning_mm  = root->umem.owning_mm;
+	umem->vm_account = root->umem.vm_account;
 	odp_data->page_shift = PAGE_SHIFT;
 	odp_data->notifier.ops = ops;
 
@@ -239,6 +242,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
 	umem_odp->umem.address = addr;
 	umem_odp->umem.writable = ib_access_writable(access);
 	umem_odp->umem.owning_mm = current->mm;
+	vm_account_init_current(&umem_odp->umem.vm_account);
 	umem_odp->notifier.ops = ops;
 
 	umem_odp->page_shift = PAGE_SHIFT;
@@ -255,6 +259,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct ib_device *device,
 
 err_put_pid:
 	put_pid(umem_odp->tgid);
+	vm_account_release(&umem_odp->umem.vm_account);
 	kfree(umem_odp);
 	return ERR_PTR(ret);
 }
@@ -278,6 +283,7 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 		kvfree(umem_odp->pfn_list);
 	}
 	put_pid(umem_odp->tgid);
+	vm_account_release(&umem_odp->umem.vm_account);
 	kfree(umem_odp);
 }
 EXPORT_SYMBOL(ib_umem_odp_release);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 92a673c..065cd2c 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -10,6 +10,7 @@
 #include <linux/list.h>
 #include <linux/scatterlist.h>
 #include <linux/workqueue.h>
+#include <linux/vm_account.h>
 #include <rdma/ib_verbs.h>
 
 struct ib_ucontext;
@@ -19,6 +20,7 @@ struct dma_buf_attach_ops;
 struct ib_umem {
 	struct ib_device       *ibdev;
 	struct mm_struct       *owning_mm;
+	struct vm_account vm_account;
 	u64 iova;
 	size_t			length;
 	unsigned long		address;
-- 
git-series 0.9.1
