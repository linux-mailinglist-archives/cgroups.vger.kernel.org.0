Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1775A68B6B5
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBFHtm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBFHtZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:49:25 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCBF1E1FC;
        Sun,  5 Feb 2023 23:48:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKJrhrOon4wlA5wPX4OgjWNUpE9E+c1jOh93c/zCGBbeLn07FIVt4YX4sE9IqemJ8c1yi4CZPKt0xXD7GRr6bnwCbvQWGE+romi83aNMzkn7FIwS+6DIIP0gHwBnU9MwQ8bkLRWWA4nQYrLmRKRG+pfpB+4QqxHU775Gyy7ET3SyaZAFYL92xfkMtWpb6jcU3lK08/z17bV/BE1gESDWEn3n+MGEhwrCo1e6WRyetwzNmxLTL4TgFZ+6pb4TA3uYMh5xj/X7wjH3ywcPiAfAN5pkKKef7c8jxhYV074amLxtrWlO8Oo7lBZTDIncmGl//0COup14QuwThztkNPhh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/0d5FeS1Bthw7AbdBW2nD+WSiMSiecdaEvA9kRz1hA=;
 b=kkoj2JaYpXi8X54ed9xTPQErejMk9izMe09As2gSABGWKF2gbe0vkJ0/Yf8hdBVRkMRvK4ihURt2xIJ28eH3vPgVFvnrR2UdcNpkVwaz5M3P01HK8iPs5/AoBawMFuxWHVlArSOFCurC0Fxnl79VXpKr0khtqxQ7P569snIGkstxE8cpdXfQEPjJH75ydxqcM0bpy9Zi9IzhkralT+QLsYB0hRvdxE8n1+0qHCGiLAcWYa0uEpwgArGZqHVLGF6mYOTba31eVPmS5Q7SyyRFG1OPwWMwawXjHJTio1hBoh15fySLC+JbauswPUcvpifky5+T+wFUQpR2VMJF9oyJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/0d5FeS1Bthw7AbdBW2nD+WSiMSiecdaEvA9kRz1hA=;
 b=aw/rHJr2ROPaFuGDV679uXnmMAVYxwJKSnQkyoLcw8StHbziYVi6NRsPvM7sHHS79m9ckuv3d6jk6AyVcrVplCXNH2/eOIUyD1MHXph6KJdLz3w+i6r1thkA4iEvEh/pOzTSma4LyfpC5NvgHsNmEyJ4/SJHbq+gRw4rcuRP1l7UPCrbfN9Puxz7MpQE66lA5G+iGGp5+qml0eX5+gb0lKtSyvK9lgOjo2gm/o/4Utv+ZrX/BBBV7wNZvVMxRJPzU+2mEOXR43REOdP+pgdN1f+k4vl/C/zk4yDCxxgb78jXMhY66NgnALKtjhQg2MCeNVwe978L/CV7THEfMW2Ibw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5118.namprd12.prod.outlook.com (2603:10b6:5:391::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Mon, 6 Feb
 2023 07:48:54 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:48:53 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH 06/19] RDMA/usnic: convert to use vm_account
Date:   Mon,  6 Feb 2023 18:47:43 +1100
Message-Id: <f21d73f37dd795c558feb9e1b6efe62fd46509e2.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::20) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DM4PR12MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cfeabc-8a1a-4d0c-50c3-08db081697b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Em9qIZeJCfdgX0Lzj0VhOFmFq2EkCQRhWl4EGeJW5wv581NiTeB3qWDj/2KkrcOuqtnmFNpvGMPFFyDafJpKhr+yt/lAAuBJTJ/0EzEpVBbFXaEKjBPdT8BU15HuRumyMEkfx0BbYoM13wDthnNA6deYNF03KPugeUqFR/I0H/AkMobrm96K5PVwrC9EMyq3fWTwYdoaiC5isDXTd+NxsDCazGyi2fhfraxkB1aBbOL3n/bla6jM91LeGZ1TBDL49o9MzdNaU1Jk3xGfusYQzrtK2Ich94VqN9la43JjIqT7gGPSFwJZreNCddsabmeeOgh/CDMOwN5NWo6GocFPptuxXA/Y4dXehbxWHiDOFfKWaTiOXLaceClgOu+74ccrL7CuMW7EPomjUDZ0Wo1YO6Wcp3Xn1l66TW7tZ+PuPx/Zmj0jdjbPhsyIa2Jshmgi1/ED3XyYzgPOOc11ED/Od6E5UhrWw6Eb3yKNrFiSrRsIg/bTzQfg4DYVtF2G6Y/+eaXfatkPWJCVHbvNABN0QB2Wmz1KVr3xq+sAjruExCxNLGNfxo8qG4bAh+feJBni5/mNiWzqM2sHFV+LC0elXXDi2YMCYt42jrBcVAnIayEzChmu5f4Qr1uBNlx+a5o0wDkbisjqLX1cmwX5jrDrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199018)(66946007)(66476007)(4326008)(41300700001)(8676002)(38100700002)(8936002)(6506007)(6512007)(26005)(316002)(54906003)(7416002)(66556008)(6666004)(5660300002)(478600001)(6486002)(83380400001)(186003)(2616005)(86362001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gu/4IBsNj6nwZ9YzlHu6d9380Bnoq2pXo6uSCdgiZzrOqndXqixi020w2Sj8?=
 =?us-ascii?Q?cE73xa6O2iU1HKpzwDh7IPVhsmrfRVv9scORa8lbM05alj5/eGk6hqAA4ZXv?=
 =?us-ascii?Q?FTyZZQMzmJ443F58pP6X/ksLqkOGBmofIqLQui79wP0fHuFMPFsitEYe5rEV?=
 =?us-ascii?Q?4UU3q0pNDCxHIH9Vdox5/A7GhucomumQ0UTZxAsMVK2o/uPMY2F8EFm4BzAa?=
 =?us-ascii?Q?11Eq86IK/V3qatq/7m6oWNgu8HTl7K+f4+XT+SrHR3WTA2DUKzc7m/mBtu0y?=
 =?us-ascii?Q?KBUTMao7cXxYyN7zvOjeAunli9mohjjqbm+ZK0wFNEGPwWUprLWxDcPLyBDL?=
 =?us-ascii?Q?dASwBf89GFqJmlAcb/OXVQMVc0eszVaPnagi2/KES6bOrw7JfdM2wS9ClD6u?=
 =?us-ascii?Q?ywGFNTKR/cUt3IAGmMIY4F7ksZWsQvThrIi8Mufu7EXylLXMHZy7kGe9W+yO?=
 =?us-ascii?Q?aMfmIxW0plIRntqLQrYLf6Zsk3oZ7j/kZiqQs8jN/Gsk86xCXoptqmjnikwI?=
 =?us-ascii?Q?WKtcfg5a2to/VWNRxrNFi8pH0sE+XtgsWuUZz2DYZU4HaEP8HiLEUzo+huZB?=
 =?us-ascii?Q?9aJYR93BWdlGTd0LQ81nb4vdEQwHrTmhegnZ5YTCD7H6Cdb3rvMIrM1XZ5IF?=
 =?us-ascii?Q?bbjzdvl8cD9PS7++e1BwXXSavFJw59HfV0xcTRJQL+E9lR2DC5Uz54/Wll1B?=
 =?us-ascii?Q?aA3WFx8f6j4WSohCdUDtGg6sbkxZ5t9KiWb/LcYrNDF+qQlJMYDatxJZuvpU?=
 =?us-ascii?Q?1FX5stzve/QDAxxnLTl6hqHAK2y+EJ1C++A+iZ21ar9+rnn4PTZk4WX5G61Y?=
 =?us-ascii?Q?VM9rArSqvkZvv7p/Z8ac3BdeWx04yZMXZPREVV6rtR4ufkIzD47j2PehoS4a?=
 =?us-ascii?Q?IMW9pd7NkyFSjy1WYMJ89bT1YKAtETZ4aki+Ptyld8hY38dQRupiZqYPHupW?=
 =?us-ascii?Q?JnAWsSqgfZegpTd8KI1Q5gZ1F65I939hxvDz9ze81xTeieVyeca/aULBeDVC?=
 =?us-ascii?Q?EaU86lWNzPjWG+ui0c0NJneqiNWKutHdnBeaJlQrrdkILvRCJ4gBH1M643iy?=
 =?us-ascii?Q?qUqYUtmQKdefHahsOAwjC8GWZDVs3A06wourOGendz91To4N0psczC2gEU8B?=
 =?us-ascii?Q?ZGbURHU2vMw2IkkoHlBOJ/qxWsfuAPA0P9Pj8QwlfcjoMHConJBJ2PvfMN/2?=
 =?us-ascii?Q?2KY01FPsc1T1u4Qf55dhIgKBjGhmfDsJ8QJ+ei6dJfKU5c13AuUYl/imwrTf?=
 =?us-ascii?Q?XsgrF0PYYbwYEDrdsXjEOvgP4ZG6za+/Aj4AcPBtELI9TWZUjqnMluJWpiGa?=
 =?us-ascii?Q?1CgngFO0V7XQNfSZSOiJmXwir430Hgti9Qqx0O/bMFXh/BP7iYGkrRvFHZwn?=
 =?us-ascii?Q?Vjc8/Rw5CkTjydK+ViI/Eq9uOKXHN9JVwy1sDvhWNozutF1xH7aij8vS2Oub?=
 =?us-ascii?Q?OPV2i27wRLE3iRPClIQRlMD8+SXng7ECiMuAy4LQHDzIaDaJsjRo+QihH0Uh?=
 =?us-ascii?Q?wiEacDtR9n4maS6wB57XlSwBGX25NBNqhWgZS0X8+09xky6KnQAH+A26Uxt6?=
 =?us-ascii?Q?nR+L7sCb79CYN8i2ZJFS2XyA2+/hIbKVFqZvv0Om?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cfeabc-8a1a-4d0c-50c3-08db081697b5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:48:53.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAeyFeiJEkHUn1ZeyVxeCBngdX4GNzhLl6PF7Zc0nYgz31KSrcPpqt+6HXJvWuZhTRt7P2ZNwHdFXo6uVF7lsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5118
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
Cc: Christian Benvenuti <benve@cisco.com>
Cc: Nelson Escobar <neescoba@cisco.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/infiniband/hw/usnic/usnic_uiom.c | 14 ++++++--------
 drivers/infiniband/hw/usnic/usnic_uiom.h |  2 ++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index c301b3b..8952ee5 100644
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
@@ -123,10 +121,9 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 	uiomr->owning_mm = mm = current->mm;
 	mmap_read_lock(mm);
 
-	locked = atomic64_add_return(npages, &current->mm->pinned_vm);
-	lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-
-	if ((locked > lock_limit) && !capable(CAP_IPC_LOCK)) {
+	vm_account_init_current(&uiomr->vm_account);
+	if (vm_account_pinned(&uiomr->vm_account, npages)) {
+		npages = 0;
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -178,7 +175,8 @@ static int usnic_uiom_get_pages(unsigned long addr, size_t size, int writable,
 out:
 	if (ret < 0) {
 		usnic_uiom_put_pages(chunk_list, 0);
-		atomic64_sub(npages, &current->mm->pinned_vm);
+		vm_unaccount_pinned(&uiomr->vm_account, npages);
+		vm_account_release(&uiomr->vm_account);
 	} else
 		mmgrab(uiomr->owning_mm);
 
@@ -430,7 +428,7 @@ void usnic_uiom_reg_release(struct usnic_uiom_reg *uiomr)
 {
 	__usnic_uiom_reg_release(uiomr->pd, uiomr, 1);
 
-	atomic64_sub(usnic_uiom_num_pages(uiomr), &uiomr->owning_mm->pinned_vm);
+	vm_unaccount_pinned(&uiomr->vm_account, usnic_uiom_num_pages(uiomr));
 	__usnic_uiom_release_tail(uiomr);
 }
 
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.h b/drivers/infiniband/hw/usnic/usnic_uiom.h
index 5a9acf9..5238d06 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.h
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.h
@@ -36,6 +36,7 @@
 
 #include <linux/list.h>
 #include <linux/scatterlist.h>
+#include <linux/vm_account.h>
 
 #include "usnic_uiom_interval_tree.h"
 
@@ -72,6 +73,7 @@ struct usnic_uiom_reg {
 	struct list_head		chunk_list;
 	struct work_struct		work;
 	struct mm_struct		*owning_mm;
+	struct vm_account               vm_account;
 };
 
 struct usnic_uiom_chunk {
-- 
git-series 0.9.1
