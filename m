Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8632567905F
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjAXFt6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjAXFti (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:49:38 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DD03B3DF;
        Mon, 23 Jan 2023 21:49:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVqeVIchqhUITUKkoCUTolmxFecSRzVJZDvyy/ZDkH2/IGyl1z+Lp9QpW9tfHapgXFAuAJlUcaUtHuD8XlUd6QDmQjxOQhgiAsiQDv68pgFa5V2b7Sm50VOBhXu7K+2DoTVjjJllZTkX47pfxiAOhKojHqpnB+RF08hm3q60pvEAmAmFbkgA3e15zOA+VDLQZOaYGkuKcBPmperjcQlodhTNaFNqnzpdz1bWz+VJVcrmxcvOX2aHRiGoTGChnwsMhGAi4G8BF+bRCpHFQdhVfXuylLjG955vFtJ+kchMAg+oEmUQhE1mh99viLHoSAUR/8CLsvoElhFnJcSgwnW0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHkCArMXy0OdvLO0RAQFjr57zAUQQNccPb96BhM7l+4=;
 b=Bz9+IR2B11qVnhOMtNVdOUdnxuv55O84hSKQSIZxrTOdjqL29LPDt0X6VW6pe3vCaimEWeEoBx5pYcvZVeB+fN1YdOAMmAQrfs/SKabBk+Hw6NsZ4Zv91orhdN+ibu8tj42/9VQM/lEa1XxthG6EdZQ/kBzotkZE02jdrDgbIUh6N9+MSGoxz35DFFbVLABd6/YnqVc6XH54DNwj7RXvMGUmq5icx7QAP4HsnxiWXPR5No/ZCmWBj/zsAHa9Blw0cuSnxZ9ZWKw5BsxWPiJ7c31jvxfM9iN60wGIgabh4CaVw2q+rMYNd7aCYSvVxjb52EVRglV5awH7GCmpELghUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHkCArMXy0OdvLO0RAQFjr57zAUQQNccPb96BhM7l+4=;
 b=OkXIWNgxDiDGgLHMtSXGhlKxx0DPyHdvKoo49YG7qSKBVhYDH7Jtf/cYs2RfT4U6O176yq+tfUybhgU98BeBOSnKW8EMf+NhWXp89QLNQhE9d6v19q0GBmTVyQaGNZ21AmS0Pm5J1lUc8uRpV2+AYq2oxyJzG7ljaEHxgdUzPqxx3IOXGPyXhs5GN7OI5HaFG8igNzgTxI6cg+3KJNaM7ehzmpYXV4IzFbmbZETJyM4p4uNW0xQtnhxPnfypsAFvgtPbmJXiU5tkyo8S+qfbCTqA7rF7JFrRQwXPy0Lnhig8hG1GkHE4s/xSAWw6/N1DD4+J1Hf74Gh//3INslQcbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:47:46 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:47:46 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 13/19] fpga: dfl: afu: convert to use vm_account
Date:   Tue, 24 Jan 2023 16:42:42 +1100
Message-Id: <ab87fe6056db226f92cff3dc76ad215d33fee1c7.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYXPR01CA0110.ausprd01.prod.outlook.com
 (2603:10c6:0:2d::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: dce7c2be-5135-40c5-3e67-08dafdce8503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xx0ryKRawWeSDLJ1jfK2YfejLjG2YGUuJIFGocK9qFPO6LFXIQa6pGyWvAteg3TyAjGb9QDAIoET8ZHzwoJK5UKnLm6zwgR1BtNb/IQ8CZIBBxSedQMbF9fBTDEeigXhbNBh5SDfNOMXzkdCPyY9vPhbSOgtnLqPfH3Hok+nLBpV834cVNTfcO79tDVWTLjWibg6661F/wu64nlbeoD0pdISPfHC/BvIx6R3qKrjFqGD6Lvw0GS2WZMmXgs9YI422xAVHq62ix2/UEj1zhuRk/8h2vD9pCFjBbeLXHyY6nwzsB+OfyacNkY01z9hjksk3X9rn3QYQMTg7gQ9279pKPwdqY1/ri2f4Rkdzu+BUw+t5qj+qTThDURT4hvuh04UQEY6cXIdVANkkxICM+swzFBvP14j2kEHCufaG3Q0AXFS9G0whourcFL2yi5FwRqLtvXCZ0iRQPZxilCuxIWfDAHvnbaTQXArAxtVodpwMCTXeCH4yt6qcMn97/wm0YvVD5Ui9bwGZBrxUoJEsJkmmhnJE8nLMamEsNRr4nxbSZL2IjC5oSOHjTCtO0bxHSHUGv86p2OjkuEIDx8qx2oCE1tb5F1qUR/n+AiuQijIPUTTBZ3CyjqDaA/8UbFGQq1CnZCNZtcgHTB8+2yeouzF+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(36756003)(316002)(4326008)(66556008)(66476007)(8676002)(86362001)(66946007)(186003)(54906003)(26005)(6512007)(6506007)(6666004)(83380400001)(6486002)(478600001)(2616005)(7416002)(5660300002)(8936002)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MQ0ezOYSN034l3p28FXn9xIG1zjnD+nzp8ve8u/q26gNVCmwhrhkGLwDRnrq?=
 =?us-ascii?Q?p1AtXvYt6x/iLcAdmtxVTGrekY/9B0H9e17dxTWvSs3ro7XH8OqnYvgjctyi?=
 =?us-ascii?Q?hAT3DEMK9jmaKcfeXEUN+UORJZNR5VraPLJUxgeq33AXN0/Ga3esEnzCfWF8?=
 =?us-ascii?Q?cYmUX8VATXTbdjEHTo904LOYb9sIjpV+MOdnVQiSjEfYibCYQbeKxTBaRWON?=
 =?us-ascii?Q?0RAh9jaXnB5dOvOs+UDLOs++aee8K/IuF4mJ6jP2jPyasm75UasyO1I1SwXF?=
 =?us-ascii?Q?IAYNDpjF2eWfe8Z5dXbKGBIR96hkLqe93RCzDKTkh3Tq2UO/QxeHNCXaJgJX?=
 =?us-ascii?Q?phkaFh0qtO/cs1Mg35Ogmo4/b0ejWOAu83OUYvJuasejH19cE22TYsYtVYoZ?=
 =?us-ascii?Q?Efl7akGX8LVPlw1Bwi/A67N4wABTQLbvisg0QFhb5j1dA/gxpNa7LfDyHX//?=
 =?us-ascii?Q?hkXOHAvSP/85YNldEaE26tN8y/z1V6EUbcb3s1OLBUbxjSxaFFVnzO06TrTv?=
 =?us-ascii?Q?t6x80T1cOyYQgEKTzXE7eqTXUGHVww3NTSVObs4z9lUaC9oYbZriCv4nFIYp?=
 =?us-ascii?Q?Z16doudhLC/C/apYgEyUQx7hPvYBxNduXuN2cvJahRgXYsnuVhMA9tHRUNjr?=
 =?us-ascii?Q?INN+nCy++GOsCue9kxUPXIaCFivgSZpU/y+bj/o/+svexykZP5/WZRR2EXUs?=
 =?us-ascii?Q?kZRgJ+t9PLByafVQln1tx4OpghfxpbwxDXOE3XQpQacgh12G3RrBvSR2NqNS?=
 =?us-ascii?Q?yzk/tCpqPuXko+DISmwSMKh19Pi6jJ+23Fc1JZrzGxiS89tNHu4rk3oIesTG?=
 =?us-ascii?Q?FZZkKW1VkOW4s4CyvWXguVePo3V/1jhYCK1P4tPL8u4/mfV3wWbttT/tfSMO?=
 =?us-ascii?Q?9CwS5ey5YgpUAjnsM8R1Dv3bWKq9gct+EoxzkRVBPZem35as14plIoKtrCfF?=
 =?us-ascii?Q?kAd+SBpTwewmP6iNe0v1t2RfjAfp2jI2Y1UModLM9k6/o/dYgTsiuEgxLq8j?=
 =?us-ascii?Q?l7kjz8+ibVkma/XC3RGzFByPyDm5PFy4gPCsg3Mj6yllmW099rLBc7aiH0rg?=
 =?us-ascii?Q?3NQFddsdNn06b0F5K25kUQ9v/YlyjdwqoCCekvydxBY7XBBxtJQ6eGoOSIzl?=
 =?us-ascii?Q?NzCNJei0FZPQAyeQWJmiVXslP8hpWzM0hQULaPaFRqFZRa/Ojp5aDFycaWm3?=
 =?us-ascii?Q?nqRn/Y0Vqht8geaqXa3MccYSUO0upskWcGEmbh0k68iafYKAqgqFpm7CBRiI?=
 =?us-ascii?Q?1K8TVxxgMeW83bzpWCaxGwSOD3ozlhuJoScG1mBQhFJTDjQGI4eeqPT42UBU?=
 =?us-ascii?Q?/dCjv18jwSZ2YiHOWR6QmHT3w4MCY+DZ4uTNMF9UbTkB/v49ccAOk3sRRHFx?=
 =?us-ascii?Q?j9WEMGz1xr9Fg4TEzE6dwzPrObi8MmRKX8zZsrfK76d9UGXLZ166CNjXzxeI?=
 =?us-ascii?Q?7vpqfIXEAtVQyIpmJwREa+lO/u7gqnEJ776XLxlG4/h6wD+D8iK3gsxUx6Jl?=
 =?us-ascii?Q?L4ZtG0q8EWPypBPeP/ev6XYcXZJ9N4pOdECcBeYFzCwU7O9TdcnpGTmzdLvG?=
 =?us-ascii?Q?zFj+re8+MIjLq+7tOMx1qNwAz8177nmTeFUYPRUh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce7c2be-5135-40c5-3e67-08dafdce8503
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:47:46.4737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4bUO7RKaOO6s4F4e1iuGBwzHgY6c56ikphacUw6tEg55g8qiUZhyhJ5szsNdzx7+4LaiP2JM4fwr7+DRYiellw==
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
 drivers/fpga/dfl-afu.h            |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

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
index e5020e2..b1554e0 100644
--- a/drivers/fpga/dfl-afu.h
+++ b/drivers/fpga/dfl-afu.h
@@ -51,6 +51,7 @@ struct dfl_afu_mmio_region {
  * @in_use: flag to indicate if this region is in_use.
  */
 struct dfl_afu_dma_region {
+	struct vm_account vm_account;
 	u64 user_addr;
 	u64 length;
 	u64 iova;
-- 
git-series 0.9.1
