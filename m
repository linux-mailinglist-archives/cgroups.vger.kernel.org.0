Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4067901F
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjAXFo5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjAXFo4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:44:56 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D63C3B3EE;
        Mon, 23 Jan 2023 21:44:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3m1K3OEaJE6HDt3yWKerlp6uEtIx3TIbG8xVEw2t6zYQMu8HEK0S2sPJ4a7tnI/LAKuGRik4sgj9euKhW5cxkSurXQugCv5HEugWMGys3d8BU92744bl+quPJnMSWVHLscM1EBAHKduhiCYe4/7vxqewVRZAXKMvr/HvlfdfIujLsyrphScDeFvFiKykUS+mKBpn5cRefLjs0bUiBGCAXGVKGZ7lg5jl/wc8wb5QEhNQv+BZfTrLDkM0uheytr9LyC+11yEGupylNkU0N86ifvvXceEdcUAaFt1YREeYWZVDZ/bpXWNoJMKGVHVU/sBxr+wmCsHqAyN7x7btL/aKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMvEWLA5MngzK2+7cVOKPt4IrdKvnbRxz60Bk/vscac=;
 b=ajCNE+NXxcJtcQOvPZ+lVkpEGV9Tc2kVMJCFWKTMGBdJErLvyDI3KRYjqEVzvxN47xeJB7LqHUwC7TJ9yCseWMJsZULMcLEvAtclSPZKelDGhwWkYP6SNvBudN92kuKiIgRCEYTZMzO4cW7oC2EuZ9iByTCbGeFFwvPTu+nIFInwbQMYfUeB68miGS0hZIRn5b5IYvDp13wNfRrVM6N/x8419241MqOjSTzU7Quq8jUfCI7H0k1qEvVl9xwfADqVJ84Iw8ks8Yf2EojPUBGkAl03yyBU89ZsupgANTT0z946mDrTK4gM4z05nKotwn1w4rtKRBA4S/kYjUf6Bq7xOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMvEWLA5MngzK2+7cVOKPt4IrdKvnbRxz60Bk/vscac=;
 b=PUtCVRp5axRVSwNeRP8p3B8IWqlmfZAq9ZQtbWmMDDnZ2q7GEAZU5xSokM6rdIQBZNqti/uqdPQCeQRvoH1G4/G5laKu7HD4KjhFGdFJ9DVHfZLEkcwenX84h7fKafAqd1ZP8wmmfzPFG0FiFsBueaXOnfDZEhN4ESlCr7GfGBtbgs4aToGR6CeAVgVw1w0w+kaDYrog5WWYkDdOaWjAG+58cytY0WUL4/ZEoypTXSLMNKle0MKVlhk4JhpfZmnlTGZJxzSlTBf1HMmgsV1HwbQH9cx/MyvDa8BTdD+BBCdng2Ze6wEpoz0mvfPrvEYYZKdZ4yAkDyvaRDqRkWC9/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:44:14 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:44:14 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH 04/19] infiniband/umem: Convert to use vm_account
Date:   Tue, 24 Jan 2023 16:42:33 +1100
Message-Id: <eedd939d8ff89dd5d8cac0bd2a4d14e6f34a592c.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYAPR01CA0047.ausprd01.prod.outlook.com (2603:10c6:1:1::35)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e42a4d-43cf-432c-e806-08dafdce06be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBYv9oGtcnNGEOsgD3DowtILQGny8oO3+jIWJmhR6fN488+hTxa4W9le8XuLCmP4Z0mVzgB+BvDS3L06m0WRaD8Ly/9z4XALjk9qKDZAb4ZWdqSaQzwHgYikyNWZ9b1WOrXGbDKQpR33NNeBFsIr0PepoQK4V4lw+3hnyKCD5nIC50+dKR5ttWvunPe8cT73RuUgyM7UnLaOPHGv7LWiL0DI753n/eUTi74aNMYAmCdiQf+/XZZJcdISmamrvFU7zYBXSEjU1z82XQ5ldGZS3yDLLfdB7ZmZv/peP8LxUEUJCraue3na5/ARUKkoH/gk14fXhritwuv/0wpoFvk2zPGQfsdMkT1pXCquW7dST6HHnWvWqMkIPQqEAvXFVg4Ky7c8rI8nyzuUtE8/zTxqluUfc4zA24FXidAb0rJAJ1pStZw0lIwZX3qGm9pX62Whe0vcBP1+C1fbnBtMEmssMAs9XcVSFi9TfsegvIMgx+5mtHa3g/2DhUcNRJkKog6T9eu7PlLwL7UlHA9ODTax913cp26bMXE3dpK9nwV5mzR+ynOxMpwnKEXP9c5BHf4JqsHwBxYRpcJaujLsXtgcrwMPdZhy+9DMTirjQ+9pw8pnSZ5ngOfnEcAjvAfHcltG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(36756003)(86362001)(5660300002)(38100700002)(2906002)(4326008)(8936002)(7416002)(83380400001)(41300700001)(66476007)(478600001)(6486002)(66556008)(6506007)(6512007)(8676002)(26005)(186003)(316002)(66946007)(2616005)(54906003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MT+N3d/4mSlKuRr2m9nmAjRq63EiccwwQQ7lZmvY7j5qqyUP9+N1VbbJCOHb?=
 =?us-ascii?Q?qR8u0/RQPg1so28uvrxGS46AeMFG8saRrrNleX3+BZTlWmMUGP8DQObElSKZ?=
 =?us-ascii?Q?pwD2xsKLuMiFtPZK/Ehg6ZQroSgDBF0p5yqufvdTaqKSLAdncnHCSofONqvh?=
 =?us-ascii?Q?IxSmMmtLYGVhc3O3UwxXDHlOvhX3Zd+ngHD1l7DHcyQDklRAE3pV/Hc2CFoB?=
 =?us-ascii?Q?EA57r7A4ZddYzm6BflhsiLx7a0fE4C4jllEOqfJNInIg+Ucm7KF8mloDS9eX?=
 =?us-ascii?Q?3SIyM7wSFa8UX6WpUHNAZ3RNMft+LxRBZQsJuEcSV7DdrdpEKyTfj6oSu1hb?=
 =?us-ascii?Q?GsBOjuh43m5fAgy3TY/UF0v8DJFHfKUh3XW4s3+6ZsnHEuvsxf3r4AUqQa3v?=
 =?us-ascii?Q?yrDkNOnLId1JxX0At5SVkAv3pBZd40+ldQoaFb2AKIp080ElC7cKAQVEMETq?=
 =?us-ascii?Q?89w0s2rF0ZMPl2BviJ6MWXlHCpzXBMR5jqC9f1zcva8R3mUqfJ+cP4UnG6wI?=
 =?us-ascii?Q?Hp/ZwNRPXkuc+3M65tstBRn3s/p/JI8k0QLCTKdOIMJm6jTtwotQ9981CxvP?=
 =?us-ascii?Q?FHosOYFr4BBkcJvyVbmCNDzZP6sBHOZN9So1rJG2z1pOUkhst+efbY1l9RSz?=
 =?us-ascii?Q?TWq+4GuOY3rjOljR5emi+8aWVwqw3KTSLpoMTayrZIoGb2NRhqvF2uLWYcSp?=
 =?us-ascii?Q?GPFcYdvI/5fXuVVuGQpZq3K5CBfQnuGdS2rAPHqsP79R/P/lWgLTyXK3bwsa?=
 =?us-ascii?Q?GiutCU/sq9Gn0xkuWfs/k6Fzh7hVi3QkN3m7bk8Z5HXp5qRl42a+3vY5ZYGe?=
 =?us-ascii?Q?1KAMyjBSv21Dyf4P9jd9dX1Xy7av5W2zDdQtbU3rJpjpO/8Fu1yKoSXMDwYY?=
 =?us-ascii?Q?uoeXrdr1u8+XiZhXv6fLc6L6rZ9FDHHFHZqLs9cNDqcA8QcySHQhWanlwPhz?=
 =?us-ascii?Q?0Sl+9EMR/aYGG9Cf5lmlTJR0jrDMIz+bLeOybZFR14vEBj7PqT9VPNqqze7c?=
 =?us-ascii?Q?zmM1Br6Zr0PloI79Sq4w7xzTjVqZXwgQA/akL5oUbZfL0gjlsIkGSvs90LUb?=
 =?us-ascii?Q?GU7jQ3IcSzknRl+kn6QzD0BJMtRfgghdxMmF5B4JrSv52nFw2Do5Nrj22gJ0?=
 =?us-ascii?Q?L3ptbHdG3ELzt6c7PK4hcOsw2fGvJ/AyuGtFTVP6TOxZh4OnKKbElCOdw5Av?=
 =?us-ascii?Q?dWezAUYcRVbmeKoDraCFW8vC8y88A8uiHYdFVK3e3jNtXXhWgeZCzuzQtpkW?=
 =?us-ascii?Q?+3PJgPhFYc46VjisdvmrkGcIc7YpaZsQxfECDRoml0rMI2E4PKrMzPMYyrJ7?=
 =?us-ascii?Q?hTJYLwT9nYrCP4e2sBXbMZmmWgdV37sclyQihcxU9MGJ8Xs9OWoE+5KiV2sU?=
 =?us-ascii?Q?EyXA/CFYEKi/Thv7ssN51lqU7EKQuU7Js3wvPgpmJDtEm9fmvgRMsij6Xorc?=
 =?us-ascii?Q?CrhSAHTEyPun97fxMsSjIwEXLVXyyJnz6cdyTzwEbo/YeP5091UXu78KVUlK?=
 =?us-ascii?Q?f/Bo1IlKpyNK3lITN08h9vGYpY8OawjlNU4wmAjyiPDC77CcqjULpBUuqmbt?=
 =?us-ascii?Q?WlBsh6wRwGMMlrexQSlgdFiekDAPM4WQWdEKXQRZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e42a4d-43cf-432c-e806-08dafdce06be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:44:14.7111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6WdbGYEZ+nXsvkLIvlU/MYyEp4s32vlCTCrm0ONclheAVhWnpmFK5z/ud6LIQAcYJJQegeK+EQZ/gnCveB0deA==
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
 include/rdma/ib_umem.h             |  1 +
 3 files changed, 13 insertions(+), 10 deletions(-)

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
index 92a673c..de51406 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -19,6 +19,7 @@ struct dma_buf_attach_ops;
 struct ib_umem {
 	struct ib_device       *ibdev;
 	struct mm_struct       *owning_mm;
+	struct vm_account vm_account;
 	u64 iova;
 	size_t			length;
 	unsigned long		address;
-- 
git-series 0.9.1
