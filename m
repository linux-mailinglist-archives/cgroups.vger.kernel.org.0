Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04EB67902C
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjAXFpc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjAXFpa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:45:30 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C058B3B671;
        Mon, 23 Jan 2023 21:44:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqmD3Rpm28y2RWwRFZGqVCsa7JVofEmG9+7vMC8/3em1LeutbRYHlIiAYitZQVNNXOe7h1fCU229mkbFExwhIuQctBwxIJOQSWAa76VwY9VVm9VSnqxczChzCumh1K7MTK+VIhJeL0vpwjwLPb96t8fTCt7ucFYFgm+fDl50DaFggcY1rUwVevrIKB5PBkf14cOTvYb6vc4II/O8Io7H4ipWGHMt8DJbCyxirkRnq7I2VLJfcixCZPv8tvW6mHo+cz65KNzb0K1A9ST3iLXUKotChGrOXlp0tAso6+o9bFFg6xFv2mSejOIN8OERe3NwV3PXTtVowNQ80jiS88RStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVSTTv9ijFATl+Jf+OCS62NKLjuBKLo0e271Utsbdkw=;
 b=GMhqHZ30CKDgpv63T0QUgee2Wk0qR5+vJh3tsMAoYRyH2M9iidJ/HXwRSje1HHQ+7DBg9g7lS2KujpmMtnTVoz1kkqYQmVl8Tzf/kyLaxiJZEikNJ1da7U+WL820WsESMWxnb2KFfW7P09M1KJNoSQPliylQlzQiQtzOV54+SYEsCMiqWGFQqs3IHzXCiXSSk3o2mQdLokGa2NpNV94GetF9/1YpBk2vSLZN25xnP8bv580SDKirmDd9uy5/z4OTtZ4YWsN2oVqAiDqMiPCkpq5/6RRT3Fhx6sSK3H6zDTy3AX2P25+mzduNqFkjuiPEmnLo9UUpswPqnfdM/POaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVSTTv9ijFATl+Jf+OCS62NKLjuBKLo0e271Utsbdkw=;
 b=g6blWCgOw4iUL8iy6QPPIj9lyTmJs/dnfznW6R32Pmeru+gzBRXTerouGEqb7Z+3HZTfJnkY5dnd3tbrbOpFNGOlbpnijc87LlwZ5WL5u180Dalp1pgYj652yQ+DAJM5b5npClD9Xx9LD3Kw63lMR/ejDDl+FzkumRXJpgOjgG1klrGzgjNHW5QWAnZSvTqmIsokLExwf8MpAb16PIUQeip8FWzu5VXlJy5wQ8MLo28oBcCt7HsiOvb5phBbNs6/fSWYSmqAkWqj4awByCyxSGE4I01+waUt8CbOZ4ickPz61GsaKXaZqoQjuIV2l4Pl5VC/NDVJ63HGPGfW81C2zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:44:40 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:44:39 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [RFC PATCH 06/19] RDMA/usnic: convert to use vm_account
Date:   Tue, 24 Jan 2023 16:42:35 +1100
Message-Id: <03ed2d166826cd7055810c66a175e20fa2153c52.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0019.ausprd01.prod.outlook.com
 (2603:10c6:10:31::31) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 58502a66-ecb1-4092-f3a6-08dafdce1583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MY1gXIJLTFkqkhadHxZi5X+pDcRr+i4Yj0KNEWMYFe/Lz7wyEznPlryhZ7i9earuwU3RgTCbBJbxJZh3Cy9eRkuzcEvZzNRgK07/Q4vbbjnesKtWPEwqQ4gAMhUoOX6JjPrC3s/3MtSd4kMug6WveXXt3z0mZ8+ggxB0e6nejHMWHE+nkJdNhZbtvFInYFnSF5jV/LnJFd92VcYWhhYI86QeKM9A/QaJo33Hs9OyeLHuuch/i0uxmSWhC4vzve4MFjbXXoN+eqah002aiPwTF9XLDsiTL7xKeLQWguHM6rX4o2Kba+yikE4EK4zEQ2PJsFZacW/+2esVbvd24othnTPRm+CHQFAfgTv5Ga7Mz0p8NL1md5hvhgboNSV8bAS6JdHMOZLB90gwjgjr/bgI6PC/YUlYp8AcjIpza1NE/XCWnpDmSHBc5WBFv6EwA90CvGzeUYjF2TF/j3LEIshOE84X/2fMnnSLbdNqvDMZu2pvdUX/RX9TUYQC6c8wSsPyEgHxwkFjK28Y1RUjYInRJ4ygrrHwwHLpmurXMLZTGtlllWkHPec/0TKcTWNE2C7SJLCUUthJHPmKy52Q07lGSXXWf1I92R5LvKA8ThxVMgSba7AomTiyDHxjJUaYcLGJUZhva7MwTus5Yi8y6ET6Pw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(451199015)(2906002)(41300700001)(8936002)(66946007)(66476007)(66556008)(7416002)(5660300002)(54906003)(316002)(6512007)(478600001)(6486002)(6666004)(6506007)(26005)(186003)(2616005)(83380400001)(38100700002)(8676002)(4326008)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IFnCrbaLEJ+YkC6TFtIjvM/ty9nMjoS5C0rEiJzmuS5XONjK6OowLYw45Aks?=
 =?us-ascii?Q?HspKnJ1ZOqA0lFuyf3gG8YdVuNPhAKALvuIX/i0lzFlCuptefjn1RBYbeOPu?=
 =?us-ascii?Q?sXhqOKclQ0usF85lne57dCXJy/8aRJfkLUWRGkyjF5HdwrzE3Ss1kviZiABn?=
 =?us-ascii?Q?B5KbmoLWuH1nOZbXfqvm4VmkdaEnuIQrNAOK0/a4FtQcmqkm7aJ9tgLsnYgS?=
 =?us-ascii?Q?Cobc0PrZM2fO8NMH/5q5C55BMlq0RgXY83D+MPsGrN9YMRVfnwm7pVX7pFpN?=
 =?us-ascii?Q?6EyhJkXlEUNZiU3DztRqfAw8jaH7+y+DPebLE2g/7wjdzWOgvNNPMyyq5Qyj?=
 =?us-ascii?Q?QPKuZhh0O0aK4aQKlMVpYHsW/vUoTD8TfAqM1OsRtPF3+YG/ohnsvlPcnnF+?=
 =?us-ascii?Q?wx8KC7Py6MNxscj6s/jSvTmocSP1Rfg3b4Pk1l4R5HMMlIuLwZIRLdBJq+p3?=
 =?us-ascii?Q?4fhEKMjEYXvCWYKUS6UMVOL07AtB/IWSGpFKqL8+eWRsmG9Rq/6ZtQlQXcp8?=
 =?us-ascii?Q?ht2xGxJpT2p1NE0qe6OZmCFk1Tb77R3+5hlW02f2pc8GFYAOg9dWzIARFKI9?=
 =?us-ascii?Q?SPXEh3dCsxeRb5sxgA7A/V4uTwXmgGzpJ7b4L/zoCe2/mEqzLeK1Bi9kb5VE?=
 =?us-ascii?Q?o2y310oZ6c8MT6lLEgSnUN+8Crxs6lbBvUyBTeC1r3Nbyow2s2gxlhDl+bc/?=
 =?us-ascii?Q?lMvpvIN3X8h+ZkH18S3ZN0LK0pOt+VIbP2RKOUH4lccTKtjM6z2o1f5Lp16P?=
 =?us-ascii?Q?sf1ZUHWWv+ZfxGHFUJdYerA3M0AQsZWuO3E3Gqz28P00qRvNN4hwIHMaMq/n?=
 =?us-ascii?Q?FsK5B+iBhBqEFj9ootbLXuF0RkDsSMOM4twR9TscwPPQHvnzbakfI9zNAKYj?=
 =?us-ascii?Q?/twplzCDvKVsoRSCgiEyXQHtugfpzlZCIsGOUj64t8cYxhFM9wGsZ6NmEuEL?=
 =?us-ascii?Q?sXaR73JEPDOT20ezwon88uXr71jMpnkmubW1/sF5gc6ux/o2Bl8NzR+tIHVt?=
 =?us-ascii?Q?wNE7ZHg/BK1gWU3mGNWS3r2Rd7TqjbcrfA20s6SixSERQkHAqnkcsuXKudbm?=
 =?us-ascii?Q?plCsSQeiPhd3aPWbx41WiPSQ+mV4cctKrmeEChM1hkPYDUYasn4g4yT6+8ah?=
 =?us-ascii?Q?JCYfyE6qJHEtVf5Gpa9iNfUeDy+6jsj/108x2K7d7RnF8oHL4jlj3fYWm5YP?=
 =?us-ascii?Q?Gk9MJkM4g/yWx1Eou6r95dCu5hIG5DILuIWyjGSC7eEak64Jfc70rVR4WoN3?=
 =?us-ascii?Q?P8LZiUlUNCGQOAWR/xIdzRuFKGcxtrBaboEF5basRsGwVb3jT9bHEITXFBvt?=
 =?us-ascii?Q?43q3Ive7KJSUZ+Auadt8LxK5wxnA39MVNncdn6VjHHkADO7SdlN3GVfySNQW?=
 =?us-ascii?Q?Of+oLYIfRKYf4ls697sZRVCNStuI5C4Rpe1UKPiaKq3sg8taw07O0ynzjIA5?=
 =?us-ascii?Q?vz+cRdP0rLFqDTI5+9o9oZFIilQ/WKcmnsYk0ejhB29+QrE3bIBkZHs1xN5Q?=
 =?us-ascii?Q?eqAu/munHwV8PSHn7bxrx2u1aCSiXYBs8abipnXRdEbLp5UHXpVDtLxn/P/R?=
 =?us-ascii?Q?K0aZx19/vc8xEzKVnXPJx+4q8WyGFkg1rNfl1Fdj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58502a66-ecb1-4092-f3a6-08dafdce1583
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:44:39.4280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imSbUZwV9HUvtiRCcJ3HUSILYWMUenFLV2egkLFBu52lqOJzgY65CbSSEnx1zofFfPtwPTEMLpq73ZrQcRmxzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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
Cc: Christian Benvenuti <benve@cisco.com>
Cc: Nelson Escobar <neescoba@cisco.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 13 +++++--------
 drivers/infiniband/hw/usnic/usnic_uiom.h |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index c301b3b..250276e 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -89,8 +89,6 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 	struct page **page_list;
 	struct scatterlist *sg;
 	struct usnic_uiom_chunk *chunk;
-	unsigned long locked;
-	unsigned long lock_limit;
 	unsigned long cur_base;
 	unsigned long npages;
 	int ret;
@@ -123,10 +121,8 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 	uiomr->owning_mm = mm = current->mm;
 	mmap_read_lock(mm);
 
-	locked = atomic64_add_return(npages, &current->mm->pinned_vm);
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
+	vm_account_init_current(&uiomr->vm_account);
+	if (vm_account_pinned(&uiomr->vm_account, npages)) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -178,7 +174,8 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 out:
 	if (ret < 0) {
 		usnic_uiom_put_pages(chunk_list, 0);
-		atomic64_sub(npages, &current->mm->pinned_vm);
+		vm_unaccount_pinned(&uiomr->vm_account, npages);
+		vm_account_release(&uiomr->vm_account);
 	} else
 		mmgrab(uiomr->owning_mm);
 
@@ -430,7 +427,7 @@ void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr)
 {
 	__usnic_uiom_reg_release(uiomr->pd, uiomr, 1);
 
-	atomic64_sub(usnic_uiom_num_pages(uiomr), &uiomr->owning_mm->pinned_vm);
+	vm_unaccount_pinned(&uiomr->vm_account, usnic_uiom_num_pages(uiomr));
 	__usnic_uiom_release_tail(uiomr);
 }
 
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index 5a9acf9..5c296a7 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -72,6 +72,7 @@ struct usnic_uiom_reg {
 	struct list_head		chunk_list;
 	struct work_struct		work;
 	struct mm_struct		*owning_mm;
+	struct vm_account               vm_account;
 };
 
 struct usnic_uiom_chunk {
-- 
git-series 0.9.1
