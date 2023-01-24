Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690FE67901C
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjAXFoa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjAXFo2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:44:28 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56B83B674;
        Mon, 23 Jan 2023 21:44:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUGDgmtl8dsT/u9CvbmSWFgb7U3oMh5dpC/CL9vTtLijmPBCNyUaKalNxiaDwx+U3gGUQjHslA8lca2fx4GPMSW/ceFgArZtfi5JFMRzp3zKTQ8d//DasO2csAGMKPa7MIoTMKoGqHZT1CjACVCqwJNUNlM7tCTzp6d4R8qn7OdMuTFhS9XVxeJi9ZCixH3Lhn13RIu9Z+bOO1X7g4w8zRoNY0ROmkYbLGNI/dh9TIbBezhyUDOyhi3qrYgghUcBPo8ErIghrdZAJYsq93cuvscKm1pobq/A7DWhs0QKse16kZ2g7oA53DJ0HqlCGZ1FWSsSRonyuUOQyKE+/mbgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj03mWpjbAOXnJWeiB3fprYyHO3IklPc7NSwtjAmNx4=;
 b=MBtJ7D3DkQ+7V4GjhmwEI5eSaKA8rPxVSgHC7hN0bOncNlO/m4QHHH6S0RgcP/SZsgMlIhxP1sWzhY9k1mSGKRFZXqlMMTOIZzrk0pj3G/VhgRNoV3xUobhegPaiLwllNMCUsuWLIuqjunHbs5gP2SYribCvtt42iOGA4TyPjsQHgAELeq9X6pe6j8UBh6v+VmbQj/IYXXGCZNqzftiSdcP+4FroE0+xeIJ5rE/Ir3kEQo9OmSDwcnlIBZ84ipKwPZR9BLWUNmP3O0o59GR1/jI143JrTvITwMIHASbM3xCxoqPZXMG6V4S4C8Vtlottbupdk+OYVl/XRTPxSbxeOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj03mWpjbAOXnJWeiB3fprYyHO3IklPc7NSwtjAmNx4=;
 b=LzeyY9O0+J+Ac/U78/4IatA7OJOeOWnXD//j74OXheYmfCQ9eT/hMwCD/3nPYnMZ4zpWMZrcvyMdpoaIT/0vM7OaYlTpkl1JMvO+1I2wrTSusoKtk1COMCzG7LOx7yscRyYRF8XIgMDYs3MyVDTKXlEup8RaYOgF2v8vMHgnrAfd0rzd1UB7Lnm+/MZqpQjdh8vN3h4WnZjuuf6yVvWBXii2iHHvXVmlctRAweN9qN6BvGuiA6gM5huoPUNg8qH+tvekIyb5i4hrAsAlSiTJgtUXxo5fehQU8E0YIgv1KoGQFk2zx4oBYpyAU1KEgOR0h8M0PslFl0ju5WJKj5QzCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by MW3PR12MB4540.namprd12.prod.outlook.com (2603:10b6:303:52::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:44:02 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:44:02 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 03/19] drivers/vdpa: Convert vdpa to use the new vm_structure
Date:   Tue, 24 Jan 2023 16:42:32 +1100
Message-Id: <f2e4696380f6678527a14e885556cb1bbd314737.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCP282CA0017.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:80::29) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|MW3PR12MB4540:EE_
X-MS-Office365-Filtering-Correlation-Id: 24006492-bfad-41e4-3b6f-08dafdcdff55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qtu5lNwzDpfFSTZfcYElaRJuqPb+FfsC7U+LCaFWASikDq+74jIAFIeYZ4pF8NehbZANRomB0wbU3i3hm7buJFJwUl2kORfQymkvtAjL0GMSA7114n06rO5J3iAvPKrzMTqzrWMRcer1kwdoU9gQGOpJu5Uz8BfMMAByr3RySGYSl8HSCcs4rprPlDt6YseBCnuYiaKkwd3uFtfjy7eC1nPwn7PTQcMx8AvklFHs6+/oRM+85srmwpNs666NBXk3pQ/3u+fTcGx/E7/nFKvUNPf//0aWh6Z3Sd17+sNlYQUBtBHD5epB74h7E+c+mKQFZ9t1VUkmDOfH+smvC5NuhqfmhckjBWLe6mAUAYa8X4fjCp6g2u8HN4JKZGs2GEqRywsCOsuWOnWeuOuwp6NbkIvRJzdUfVpqx0gR90lnQnmjtxpKrZkd9R3pOs7kmCRb+bHTK5zI1YJ97AEuFO301Bhma40tJ0JeqlbX5XyavRmnFpUx0p6TupohTFh3Lh1+NmmxV05SpjJ57B5CSI0j03bhmvKWmQ4sBUcZrhDxqsAzoWO6Uw+/msVJA3Mbn+5VdkJQvHOTAalIV3YIXa1Oxnh9vIzonfbu5XCY9Mynvfawb4rkfzT7HkzMFJ5avVQT5THg0Dp+6ja8LqMEtEPPgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(451199015)(36756003)(86362001)(5660300002)(38100700002)(2906002)(4326008)(8936002)(7416002)(83380400001)(41300700001)(66476007)(478600001)(6486002)(66556008)(6506007)(6512007)(8676002)(26005)(186003)(316002)(66946007)(2616005)(54906003)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?09jR9PI1lj6ImPdYgdurnvVWyQmwF8yK6cqvkXMJQcMaFLpkefqMWP0YwvN/?=
 =?us-ascii?Q?bQ7qAPruiAskTOlbhi0yL/aKQkuL4OpWauD9ew09ROBuRrwmfefncraB/ZgL?=
 =?us-ascii?Q?RJXVZYuG4jtuWoWf7CbY5ICB5N/+wRZbMun52SRqnEcH6qffqfRvfZGoOkiD?=
 =?us-ascii?Q?ixWc2AHy55Qh1+oFj2GrrSeW/W7BPN5SZh0AUeixCj0TE5W0SC2zLI/u8+CD?=
 =?us-ascii?Q?Q3FZJq4vxjUd20eG7RFt6a/rlQ3yUOxhG2uCCDfnUolx3c/ajFx2f5JaI23N?=
 =?us-ascii?Q?L6cx9cepRhmNblCqC+moPnH+7BD7FQfiZ5Ic4eOGz283VpiRdE/QGZbLeDdT?=
 =?us-ascii?Q?2CyStyI6qHbF2gCVjVXEs0rbrtwXFT2VVZ2RWuwVtb2K2cfWXMFTbJerEJfi?=
 =?us-ascii?Q?z43Tx38pwKawOidmKYGLPMVBjqRdqpWgT4wM3XMrnfayLke9D7rxDkePEp0g?=
 =?us-ascii?Q?1t+eX34+i1Brt52oGYLxW8K1GyJw6dBRIGPMROQHRu2bZkw73AnCK00jVczS?=
 =?us-ascii?Q?2rkf4nWd+qDF5clgBamCCuElN9spORSSwmQxpoytdv5TbjVuboNqw7zeUf/t?=
 =?us-ascii?Q?r8jwEi/zOfbha8IwjPCBM6RG+jC9/P0JAg0JAT8U64DxI1sRFrKNC19GSxLI?=
 =?us-ascii?Q?UiTvwlsSdpurFvO3ZHz4rDb7wyxjzo/FxWIeBG8RVtQ3GiI+n/AUPEbiVlZP?=
 =?us-ascii?Q?xEWXMrMZ7xSz82pm/WLYxSIjJKtyM32/hF+ketZBp/K/JJDDRMlmseI3iPfh?=
 =?us-ascii?Q?JcIw6uex2BttOr1aQYfSK8Ab/+ianeC5ltt3cBlV7J+2WBYTF36XbewYohgN?=
 =?us-ascii?Q?gcn9ZI53HAxSKyP4zPJQGy1qTQVBoyMpVshPhSQ9MhtulEXfP2w3DaVE25ri?=
 =?us-ascii?Q?RGUhT4obIxlHnPIMCzLrQprppCJ3v8H0M+QUlo2YJY2r54ChOIBbjh1SDgGn?=
 =?us-ascii?Q?2ogzBhqoVEP1W+0CG4nJzMDprOvVsU8XL7UqX45vn8TmzAty61KPv3Cv3LW7?=
 =?us-ascii?Q?7la7RXZ1IHVv3Z2H9LRswzJdk23LjqN9mt/7sviePGHxvR18oluPx9hw7BTa?=
 =?us-ascii?Q?NiPVJIxCaEHk8tbssju1T3/cnkz2mD4XmIznIjTksLsTLrWDTRWiAiF1Tfzw?=
 =?us-ascii?Q?zb5g+yVFbGCMoygp9DDeBM/Bsk3Pm8mYKsI7pGG2TBrHcp9Ny+I2mnZv+5k1?=
 =?us-ascii?Q?+C89ezxXVoEtLFEQ1Yx9/OrXJIniTaQEN3ZTlPB8r5WVhDEXzEa5E1etWBa+?=
 =?us-ascii?Q?EzCuDvLus4CimprWb26Tmy097Npg2SIlK5KhSewS/4lFtu4We+1lhccAxAfP?=
 =?us-ascii?Q?yN86gHgmXik2Lsyc/DaRBcnfqt3vMy0uk59nrdGTwyBBP7f3Tro1WenmemEX?=
 =?us-ascii?Q?HGgtvI89a6pZWEE4gwMmgBPau0HATidbWMRha/6Wz8S7j1/RgDLtvt4LogZn?=
 =?us-ascii?Q?APJjbnH+4bSxEPYE6KbJFBRyGS5DvIFcU3e5brSll3emglpCE6Oc9UYYGTe4?=
 =?us-ascii?Q?pT+yfP8Riy0LKuJRX+74N/Kc76zrjvKzJ6v3Zz5T5meJaqGwn4wfTyNnjwBA?=
 =?us-ascii?Q?pULOiMHqX/yh9yF9L2B8/T8IJqNNbu62pUvuBE4x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24006492-bfad-41e4-3b6f-08dafdcdff55
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:44:02.1963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4VZpmcdkvheaXLTWXT5dYSDMcC4hIHru8WPmM/kXvTHe/xFHI7/3hanI9zuHmZSP9tKv4v17io7kN11YXB23Q==
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

Convert vdpa to use the new vm_structure and associated
account_pinned_vm() functions.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0c3b486..bd87b58 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -70,7 +70,7 @@ struct vduse_umem {
 	unsigned long iova;
 	unsigned long npages;
 	struct page **pages;
-	struct mm_struct *mm;
+	struct vm_account vm_account;
 };
 
 struct vduse_dev {
@@ -950,8 +950,7 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 	vduse_domain_remove_user_bounce_pages(dev->domain);
 	unpin_user_pages_dirty_lock(dev->umem->pages,
 				    dev->umem->npages, true);
-	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
-	mmdrop(dev->umem->mm);
+	vm_unaccount_pinned(&dev->umem->vm_account, dev->umem->npages);
 	vfree(dev->umem->pages);
 	kfree(dev->umem);
 	dev->umem = NULL;
@@ -967,7 +966,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	struct page **page_list = NULL;
 	struct vduse_umem *umem = NULL;
 	long pinned = 0;
-	unsigned long npages, lock_limit;
+	unsigned long npages;
 	int ret;
 
 	if (!dev->domain->bounce_map ||
@@ -990,8 +989,8 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 
 	mmap_read_lock(current->mm);
 
-	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
-	if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
+	vm_account_init_current(&umem->vm_account);
+	if (vm_account_pinned(&umem->vm_account, npages))
 		goto out;
 
 	pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
@@ -1006,22 +1005,21 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	if (ret)
 		goto out;
 
-	atomic64_add(npages, &current->mm->pinned_vm);
-
 	umem->pages = page_list;
 	umem->npages = pinned;
 	umem->iova = iova;
-	umem->mm = current->mm;
-	mmgrab(current->mm);
 
 	dev->umem = umem;
 out:
-	if (ret && pinned > 0)
+	if (ret && pinned > 0) {
 		unpin_user_pages(page_list, pinned);
+		vm_unaccount_pinned(&umem->vm_account, npages);
+	}
 
 	mmap_read_unlock(current->mm);
 unlock:
 	if (ret) {
+		vm_account_release(&umem->vm_account);
 		vfree(page_list);
 		kfree(umem);
 	}
-- 
git-series 0.9.1
