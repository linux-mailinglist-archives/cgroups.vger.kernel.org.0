Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4C68B6D2
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjBFHvF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBFHuv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:50:51 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67EA18AA4;
        Sun,  5 Feb 2023 23:50:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPvQxGiTkoiWrZ5zej42gaaZmCy0r2LFi2JJxCW5pegeXGXROCuhL+wljc/9MFIA8/zc3hF/gtTiy/fD0EDoeNIuKceTpu2APp8dCPhkK6GvkW5KQO6loRUhLjXAOL5AGClnyvFLB29kX49a5fe3wJrHH9RgYEDJOWucAgtRxXCKbIMxkhD7Fran/EhydcMnhw0mb5hAl7Te+S3ohdcQNIXeATXKBVZKU2lg8MTz17SCQeZeIEP7GQ0HMAeUSd+O249vEpkhcJdOAXtYhNvMy1qMOWBlZS+JM+q92jv3wFB/aOcqzc1QtIseO+8RVHXGt9FRcohfWEzqiIduevaT5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwomzvkBEgGdYf53g0ZL4eXFuNuoN5c1QyS6vm/9qcg=;
 b=HvGq/9Db+VX9JBQK9/VtN4fT1wA1SjRB/GMrkFnhITV9x2rN+I8CzIo6M9CeAes612bAqsi+LqiRgWnp1NNw6wD1ViQR/SN2BHl3XfKOeUEHR8Vua1djfXbISmMVO6wT4V43KysUbHvwhSMqzUOHeZVrZeJDXLXrl1uaOnPL0BI5s1vLxHvMHdGNwv5r6atA1RfOA83ieNVWlr1cWJ/myDWxVdBsIYwQzX3Ycze7WkKi2rpit+EUG7eWk3Z4kbMMPqg0TzbIPwwHMo8YpgqT8QaIB+qogAur3xBiw4uHW+F+bqIJ75vN8HpMpbzYa9g64iA1qaivvcEyfp4UeWD7QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwomzvkBEgGdYf53g0ZL4eXFuNuoN5c1QyS6vm/9qcg=;
 b=szKlcEMHt1BgLN5SGRfE+C6PmQoXkp0dTCEshpWFI/Smn6e5C+3VYLY2QZzhs3jW5Zr7Wb/+8xkUe/R4GNRV+cmPWyFKJL8Rtr9kBvKwp3wwldrosMOZQ3UIpx5OzAWgfJTO92qN5mGGd9qIo11rdP7k19YYqVqCHD9Jwlu5k6n83GJqUsitF+DtgNz/H+KWLy8+f5on9rsznstPZHuGI34hmt2ynwQbuw/phRbFl5Ax34Z1QisK+TUxM+R2451e3RmAO8/TsTWUYggivf2fiJuilRN4NluWPVknhV7EPnUE8NEfTowCMIVRHcPY5sjsFOxFtNnxAdD7+VElgb+BPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 07:49:40 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:49:40 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org
Subject: [PATCH 13/19] fpga: dfl: afu: convert to use vm_account
Date:   Mon,  6 Feb 2023 18:47:50 +1100
Message-Id: <4c3fcdfd0617ca7e21bb826c8749adcf00bfe956.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0093.ausprd01.prod.outlook.com
 (2603:10c6:10:111::8) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6822060c-def8-45db-664e-08db0816b399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CDx0ysmFC40w7m91S+8U0DYJ94WMQ65n7J0cRFi/UtBy+LhuTz1paH0LNMooPPPAwwoUiWDvrBRLq6zdNVn3EgJnZ3/WM+gt/leFaI1d8EJLYnBapMlpCaKp0JsEoLLxw5Js6bRcx5q0d0q1PrvIpltXVuzWguf+Z3HP3cFF7A0AgKY7vJkFRRAiOFon/UFq7VC2+gAZVr0iFCk8cqRV4AziMgAJx+qPcKOj4qrHeaK6AEOLeAQ7SsEsopTKcU8mRvs8f7E72FKGmVUadgCFf4LGKb6RKep4Do/GxPfcp0XFfh0YoUYbzj1mRNdOpwDXDJePg5juc1Q8Ja4E4BKxOeZHny8+oaYfVAiZ9HdKjdgCZNhpk8FNYrMuN0Ac7e+DoGV7jXm2m/8zJvYzD/8QokrSWJcmktaKERy43LJSTorXKNLcjHSQm9NU4/Y0G8o/Ayb+0Qflj4ad3fvypFFATZJnCjATWTBg4zpCNmD+MRHVaexhn172/4x7+3aKBxJV8nRYyVISxSgQywE3l+zsi+bOQXTApmge0Eu8ZdoDpCN0pDuzmMLqpT9D1OxAWuae/Qi1/SBgotzY/hbwQtB9RvjSUJ2ZQvvpPBndsbz05Ohs0cGfiTCVVDV78pzDgNLv21gTnsFJoZNyEV8dae6TTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(54906003)(316002)(86362001)(6666004)(6486002)(38100700002)(186003)(2616005)(6506007)(26005)(478600001)(6512007)(7416002)(5660300002)(83380400001)(2906002)(36756003)(66946007)(8936002)(4326008)(41300700001)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NUtzb5X5UNLvv4FIgh9XzomWui5nSY1LhzIKgG5erK9DlDJ2L/PSsivDrcH0?=
 =?us-ascii?Q?cHzGAlnAYoXc5X7cdLoCEcShz3j2GEdKTPozqdOxrqfoVCEbAUl73y16R7IK?=
 =?us-ascii?Q?BFEBrb2RU/SrJnLmxLzyex5ex3hzR425ULvO1bxKFtC6RIjqqvzIrYcVchUZ?=
 =?us-ascii?Q?OjC31sqHbLGzUZx8tBOAFDagaoUPKa79Q9RUdjJzsqIRNXG+kojmlRmYgKQq?=
 =?us-ascii?Q?cNlE2voSqhZ6npKQt+zE/+EdwjHvYw+MoLR/O0/aHteZ38qlkQPRqsEs099J?=
 =?us-ascii?Q?0nxRTZNpV9Nk4m9luE7fx3DimDybanGTnOoOkLf5WgY7mfkVec0ZmyIqx6Wl?=
 =?us-ascii?Q?+QOsWuJ0bhM8vmk2wOYgu+sxjhosYCXzhyfmBE2OtdnPcjHH591A94RZ6wX6?=
 =?us-ascii?Q?4k+CSW0Bcsr5kxY+b8A/4FNvBa79Ea3gI+alzRlVOeH1pnyyEvQCu0uBSzCt?=
 =?us-ascii?Q?9ra9uJDZd/HTrEt892XabY9oqxdqKvJXrWYl0FaViLtsZMbuuyY34kmSXHwz?=
 =?us-ascii?Q?7tx+2ke+ewFK3GxZCmMRQevOA8ZS8FGKP3ShhHYOI5nMpHEvR1eaBKa1oyuu?=
 =?us-ascii?Q?Vh4rUxWACeXzBBExcz4tnU24gOjlRvRXOrVM6V13DktiQ9GDDKBNcCSy1PVz?=
 =?us-ascii?Q?iLToEVduz3c7T8liZYjE1lJw0uy/ifOcf0y3MKWLqGBUoA7zzMoO35UwWTbq?=
 =?us-ascii?Q?YuFD45Bhy2X18OIWIRVP/d6rsn3N8MvWlwIzghJhP1lHaKGY/IzfN5wtoQiO?=
 =?us-ascii?Q?Z+4Ry932Yk9h2fP7DWpSTQHCDUpp6fc4c3NQnbtWtZud64goBnp26McW9/mu?=
 =?us-ascii?Q?/pFXXq1HsSa+FE2lb5JOz8svDn2aS9UHsuJ5MT4e7idfU5KmT0adRrsHHbz1?=
 =?us-ascii?Q?QMiAvG1d639nXZmwJ251V/rhT2JNC2yS4BvxbsbvNgCr6uAxpFGGK9VC/+nm?=
 =?us-ascii?Q?7SPK5G7V3z2oDCKrEBwre/lXGRWg+c780adQSNmFS+JmUngkQwLBUFPMbXQY?=
 =?us-ascii?Q?4gVjzsrZy4rMageeG/Y5ZX5sZ5nomG0H1BXGtM8gy5WyftyeHCEpLO5bPfSz?=
 =?us-ascii?Q?dV3+LEuuuItsLc2bT1WXgZppQMrIntUkmLk/jiiEdf+PjciuIorbOuOjvWko?=
 =?us-ascii?Q?USE5AtXVFvLa5DWl49dcT+gtbmaSDi7wcWIn96RezwuZ7pjDVZ9hpUgvY0dm?=
 =?us-ascii?Q?TF3AR+x1RyA4aY7hAgLuaCesRFZkTquRwfnNAsAG2SWCCxv9l8vs3dfoHrdR?=
 =?us-ascii?Q?t6YCRsybyMzG4ZVmP4YgWIcUBF7YzRoUwHn16BJ1VfBwSb/1XHdn5s68Pa0w?=
 =?us-ascii?Q?7zN2A3afidhBy3FqUKas6utRFSSPvLsian1jnJ8TnHrJJiodu5mY9qya1j53?=
 =?us-ascii?Q?KKs77rlOw9RhkTTAkEUmTMx0GvF/98S3p/C2rm+cC+HSbPkR1up32LhW7WNt?=
 =?us-ascii?Q?c0ckcjYXza4YLoenZe41C3qw+y8KAFsBG6V5tD5Nj3BqVZndmE3K/4NC8McS?=
 =?us-ascii?Q?cDBnUCYfrnxeRHumNpOKCHjgn7wOAcTwMS+Nnx7aig2S6pnEtLWNshmWNeCi?=
 =?us-ascii?Q?qV+d3htScxdnes0VaAJMeYxKlpF2KAVDPl9y6uu2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6822060c-def8-45db-664e-08db0816b399
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:49:40.0254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CuSL9rlvFjl/HyfoUGZRCwT31ulEpvCM2H5SkvAPmqtVS9b6f+w2qAPpJbKBV/EgUo2/N114qMiod9Bw2sS2cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

To charge pinned pages against the pins cgroup drivers must use the
vm_account_pinned() functions which requires initialisation of a
struct vm_account. Convert the dfl-afu-region code to do this and
charge any pins to the pins cgroup.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: Wu Hao <hao.wu@intel.com>
Cc: Tom Rix <trix@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>
Cc: Xu Yilun <yilun.xu@intel.com>
Cc: linux-fpga@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/fpga/dfl-afu-dma-region.c | 11 ++++++++---
 drivers/fpga/dfl-afu.h            |  2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 02b60fd..3b99784 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -38,7 +38,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 	struct device *dev = &pdata->dev->dev;
 	int ret, pinned;
 
-	ret = account_locked_vm(current->mm, npages, true);
+	ret = vm_account_pinned(&region->vm_account, npages);
 	if (ret)
 		return ret;
 
@@ -67,7 +67,7 @@ static int afu_dma_pin_pages(struct dfl_feature_platform_data *pdata,
 free_pages:
 	kfree(region->pages);
 unlock_vm:
-	account_locked_vm(current->mm, npages, false);
+	vm_unaccount_pinned(&region->vm_account, npages);
 	return ret;
 }
 
@@ -87,7 +87,7 @@ static void afu_dma_unpin_pages(struct dfl_feature_platform_data *pdata,
 
 	unpin_user_pages(region->pages, npages);
 	kfree(region->pages);
-	account_locked_vm(current->mm, npages, false);
+	vm_unaccount_pinned(&region->vm_account, npages);
 
 	dev_dbg(dev, "%ld pages unpinned\n", npages);
 }
@@ -223,6 +223,7 @@ void afu_dma_region_destroy(struct dfl_feature_platform_data *pdata)
 			afu_dma_unpin_pages(pdata, region);
 
 		node = rb_next(node);
+		vm_account_release(&region->vm_account);
 		kfree(region);
 	}
 }
@@ -322,6 +323,8 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 	region->user_addr = user_addr;
 	region->length = length;
 
+	vm_account_init_current(&region->vm_account);
+
 	/* Pin the user memory region */
 	ret = afu_dma_pin_pages(pdata, region);
 	if (ret) {
@@ -365,6 +368,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 unpin_pages:
 	afu_dma_unpin_pages(pdata, region);
 free_region:
+	vm_account_release(&region->vm_account);
 	kfree(region);
 	return ret;
 }
@@ -399,6 +403,7 @@ int afu_dma_unmap_region(struct dfl_feature_platform_data *pdata, u64 iova)
 	dma_unmap_page(dfl_fpga_pdata_to_parent(pdata),
 		       region->iova, region->length, DMA_BIDIRECTIONAL);
 	afu_dma_unpin_pages(pdata, region);
+	vm_account_release(&region->vm_account);
 	kfree(region);
 
 	return 0;
diff --git a/drivers/fpga/dfl-afu.h b/drivers/fpga/dfl-afu.h
index e5020e2..2ca6117 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -18,6 +18,7 @@
 #define __DFL_AFU_H
 
 #include <linux/mm.h>
+#include <linux/vm_account.h>
 
 #include "dfl.h"
 
@@ -51,6 +52,7 @@ struct dfl_afu_mmio_region {
  * @in_use: flag to indicate if this region is in_use.
  */
 struct dfl_afu_dma_region {
+	struct vm_account vm_account;
 	u64 user_addr;
 	u64 length;
 	u64 iova;
-- 
git-series 0.9.1
