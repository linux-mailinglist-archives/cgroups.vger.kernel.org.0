Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8068B6AF
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBFHtO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjBFHs7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:48:59 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C91CF64;
        Sun,  5 Feb 2023 23:48:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUcES+pqo8/gaEV3PIFIib52lHn/VOrsx8jpSMRqFVAbxhEWmN4n/jz1lmkOFPC+v/ona85JZMVKWGyE+dP7g9xQNODasZtLIrlPAxi9UppgdNPz3UgQph7F+qteVnFm4pHB5EAw5myrCcmPZnTm7Q1gPlGF05jgS5uwBghj9HRBvtHwIXf013ytQQX1ej6gO6PFu0BpVmnIc2ExWlXlKfcdzFRpf2ap6GQcXS2mebZ2FlhDYPwZG2Bk+zPf2I/6S1UjpvwuEkJJKyVRrirYE5jXT9HF36yC38RAijgrDQSbe8CpfSbVLAIhc3Ue79/nwmaL+hBOe9GS5KSorNhOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhgVGBn1pGz/qFGyTs5jsxzxhZjuaYEqMKugHfht1g8=;
 b=RTie0AH6Ja7bdpQzSh5zdBasN0/5ojxTsM9jwnwtNcwBVdEvFEXIKVV7+g+Wwcs8lVE76MB92ITe+WQ9Ruovaai+fX1EoQiJ24irLiDm+P+m9ShUuraEX7H5S/k0pGl0RhE82Ndwy9i/hdLXTX06EVQyPBOV9DD82Cu2cLYoKe6xHe0exusqZnzW0iWHqbZUnTqtE1e8Du2GBJNwuTRi6zh9bBwXu1o06TKN9fh4DhqNGenUMGwfT9ve7ljc+eFgo9dlvhzp4F3m/CsC/MtVKVxQ2qT+QN8a1AcZfZw/TQsBP2AuJOAemzXZ0gR0AZoPWUIXPEKs5AcrFqjghg2aqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhgVGBn1pGz/qFGyTs5jsxzxhZjuaYEqMKugHfht1g8=;
 b=EG2h74uw6Cq6Qi5G5zGTzvDShXAREPg8KHKhk+2GPaAzK+tFLY3MT14mM5g2K1/ZG3mh3Ft15z2j+U5iMcWXbGYi3uI4kckvs0M73U983ggfRMQFz/jQfcXKvt1JqMDvPkz8AxcYBo2atzcnlbTTj2JjXJtlSlz1FJot3i/WV9NKUsNBSU4jw17F/8pdWkkWKzc4NWnvBCZfWPVUBOXFN+Qp7Q67fVBe2bSs+Ig0BP+las8ZCbRLCsBGCTUUQQAF8l6GzjYxONrywhz24NlvhW5pLF87RqKW7dWXRpDpeVywpCGz9DUTlMD0qb+yfysENSEH1rJ6SM8TOV6+RHbbzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:63::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 07:48:35 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:48:35 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 03/19] drivers/vdpa: Convert vdpa to use the new vm_structure
Date:   Mon,  6 Feb 2023 18:47:40 +1100
Message-Id: <c40915698054f89d42d8deeb61f9854bd8c0d5ce.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0096.ausprd01.prod.outlook.com
 (2603:10c6:10:111::11) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f96889b-f944-4864-2769-08db08168d53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hQiwSvhTcfTWvrs7VXaaan5BN+DICeV4GPI0BBRWGC+rNyrbf9kpsKW3RLEeol7Zm81u8gvOfgIp9+UorH5S+tW77GrVIrWFc5xBmSvA66wy6zcYzGrjES+LLW6f/S8RoV4Q16obP7fudBNRHnzp3dQpAp2xEb9RFlMnEEJg46tzo/Jkga2phFSgq408NR46v0J5xbXQRl2Y4IH86wZHKA7M0X5vhsE1GREpdg5VJ+mz4P4Oeg6Ne496cn8OGdXhPF0c3nTFZdIAI1j4uDvg0bxuZke878M0+nwMPR8W1qlqqDAGphbGQ5w/64hTEHa/o2TNbNhhQJbN8jeZGgugVNV8ahzKYSzAvTF6DDLANRk7vFCUzWte9OjNa2T+h1gfeNYlbGulSS1bRH9taEbN3xiRB4nEw7aKy7droXDOw3xASWCHx8CS77JwTQEZqv4T77Zt3uVlpJEvK9Bcpr0LLlmav2S6sulz2EVhlnG/tIJsFxduGYg/IUy5VcX+xz6fcg1HkHc7uTDkWCLliHZZ2jFsNiHIEH2hNmFi7cMkO/ZMz00K6qmsV8JdTCVfp2yitw6v9NSyk3BhwVXPjz4aLoMk0bPu8QRxwcRdgLnNiEkQrCLNy3DJyns5wdebyCjZpCQwJX310T78qQPNLTtrpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199018)(38100700002)(36756003)(6506007)(6666004)(6512007)(26005)(186003)(478600001)(86362001)(6486002)(8676002)(66476007)(83380400001)(66946007)(2616005)(66556008)(4326008)(316002)(54906003)(7416002)(2906002)(8936002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k0mLF4eRyOue/HvSpJitpT6GorGUlHNMDaBeTwzcOkP+IHge4vG0XvM/3k1K?=
 =?us-ascii?Q?b112t12MKY8alY7sgvTb0cVZ6JGyRBoEINfXVWXFIYCEb8wzoZMeOOClB/gu?=
 =?us-ascii?Q?sKDqpGl2b57ZClnF5WLKbElPmkg9oVApmhw+IpF6a864u4Zu2dGSuTLj7JdH?=
 =?us-ascii?Q?wdafz+/saMGh8tM8ux/zj9KZ1lvakrUfhMSPYTDos48Foae+flFBFaljn3LF?=
 =?us-ascii?Q?1U+tzbjkJB9mB0wnOvbRrGKgntE85yz4xacN8W6bYt7aYKmRu3CfT5LEsJbU?=
 =?us-ascii?Q?ox6Mbh/Z6+S2y2Kl0sTLhODmz/sShp4Wdx5FbuKo/Y4hJQfKL05z0yu04Y+l?=
 =?us-ascii?Q?QuXIO61LwcsXKGWHjIrnvfss0He96SCwZ6tzSef0bBSWV6vAQQvXeo54moxZ?=
 =?us-ascii?Q?EQss9M27H4xA9lmsLapxTJUA1fcsIWk1+sbdKN6ldn58B/yAGRB7pDeKb4kf?=
 =?us-ascii?Q?eYcfM1Ucfs0u8gmX3S8Q2lGThhxrqrGfe6mvG09Fc+mDpjafH/4xH2a+4cvz?=
 =?us-ascii?Q?vOxeIPrf22qlAReo8MRbDjiWWzZpKtbZ0OrpuZE0QuU5WzgToM2YWFJiuUj2?=
 =?us-ascii?Q?0Vcw2cpi9k0/DM5FZTxtzlfAUptDhmqFF7zngut81gF7Xd3v7ibIhcmPjrIF?=
 =?us-ascii?Q?0NLG5Eh7LVJYs0ZpQvGgjih2M1DcU8Go3zJD2oU7xqLyqtG7wls/6/2xQIZ/?=
 =?us-ascii?Q?egtNv5mr6HTVLLjnWIFyzexYFRLRH1mi1Wo3KCy7raftkqlWqFTTHan4Cup/?=
 =?us-ascii?Q?3FHKmlIyDMjV5W+RfppMqo4j7/NltH/uBuvfKWH/Wk6yysL1QfsDzaq9zYW+?=
 =?us-ascii?Q?F4apMygtkVpYfCRGlrtt5XS6Nfy4l6hVnrfxMXLED88MoEeEFHhL6a4hyGZr?=
 =?us-ascii?Q?p+IFXkyDWD5Az2UFiXpGepgzb+slM1IU0vmGtN6okc8hO4PdpNlIKj4Eg+CH?=
 =?us-ascii?Q?0SLDRZdBO2yUpFb6Y7RkQzbYUpLuwcwH93QSDKVRsjmnaBA0dHK3zLGH7t2j?=
 =?us-ascii?Q?3luWzG1YTnS0CRppsmxRzxWAX9nbkI0Lg1luHKCEBzXhZPsh6pNkMYzcoqG4?=
 =?us-ascii?Q?pOm7LO4HvcMHEh8/G9bYZiuFfeB+Y5DvafNiDGNBrIRA7OcVjDaOIfcjQovd?=
 =?us-ascii?Q?a21+7+VNj07fOgNpqbg84TGmXdK/KacuSZnIbqn/pXnq07MYLn3T8cSqL20+?=
 =?us-ascii?Q?muD83tapi+knWpozP4qusz+d1XcVSpnhZBrytBEMUPp/Dq021szGeOunQvDU?=
 =?us-ascii?Q?POa48nfNRz9h0Jb+9j8fC+b3iO10iFB5Mk5mWqMJf6ToMMx9iznNs7S40TOY?=
 =?us-ascii?Q?sMkvITuxvlJYgKqx42N3bx0adFVt7pGhRfYe7KmGuInx1b1qwbx3u3hz/IkT?=
 =?us-ascii?Q?68Tx+bT9LeTCwWTrtd24dlCY7nvkEagZaw4Bhhwy3tt4oqTYFL0J0dQDMDq/?=
 =?us-ascii?Q?v7rDzkZAoodMLYPhfkUW7pHWKn9apDB5Hf+32yeHs6PXcKytAzyjLovbAdOz?=
 =?us-ascii?Q?SdhqAAAEfW+jxYFIRg3pkA4t5S20yL6tNfxT18yzbUqaMAV/9kTyVLFFj/3n?=
 =?us-ascii?Q?G7HWb9dMtoL/eaXXb3IrHlY50oNe1sECjTLg68V4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f96889b-f944-4864-2769-08db08168d53
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:48:35.7803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zukif6znujczilGtEBPn7wj4+KQRdgve8X5+fOdAxWvqS2ez0x9z6k+im9OFh3SMgIuhyXqLexI0/d6efbD8Rg==
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

Convert vdpa to use the new vm_structure and associated
account_pinned_vm() functions. This also fixes a bug where
vduse_dev_reg_umem() could exceed the rlimit due to non-atomically
checking and updating mm->pinned_vm which could lead to a race.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0c3b486..bc300e2 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -23,6 +23,7 @@
 #include <linux/nospec.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/mm.h>
+#include <linux/vm_account.h>
 #include <uapi/linux/vduse.h>
 #include <uapi/linux/vdpa.h>
 #include <uapi/linux/virtio_config.h>
@@ -70,7 +71,7 @@ struct vduse_umem {
 	unsigned long iova;
 	unsigned long npages;
 	struct page **pages;
-	struct mm_struct *mm;
+	struct vm_account vm_account;
 };
 
 struct vduse_dev {
@@ -950,8 +951,7 @@ static int vduse_dev_dereg_umem(struct vduse_dev *dev,
 	vduse_domain_remove_user_bounce_pages(dev->domain);
 	unpin_user_pages_dirty_lock(dev->umem->pages,
 				    dev->umem->npages, true);
-	atomic64_sub(dev->umem->npages, &dev->umem->mm->pinned_vm);
-	mmdrop(dev->umem->mm);
+	vm_unaccount_pinned(&dev->umem->vm_account, dev->umem->npages);
 	vfree(dev->umem->pages);
 	kfree(dev->umem);
 	dev->umem = NULL;
@@ -967,7 +967,7 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 	struct page **page_list = NULL;
 	struct vduse_umem *umem = NULL;
 	long pinned = 0;
-	unsigned long npages, lock_limit;
+	unsigned long npages;
 	int ret;
 
 	if (!dev->domain->bounce_map ||
@@ -990,8 +990,8 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
 
 	mmap_read_lock(current->mm);
 
-	lock_limit = PFN_DOWN(rlimit(RLIMIT_MEMLOCK));
-	if (npages + atomic64_read(&current->mm->pinned_vm) > lock_limit)
+	vm_account_init_current(&umem->vm_account);
+	if (vm_account_pinned(&umem->vm_account, npages))
 		goto out;
 
 	pinned = pin_user_pages(uaddr, npages, FOLL_LONGTERM | FOLL_WRITE,
@@ -1006,22 +1006,21 @@ static int vduse_dev_reg_umem(struct vduse_dev *dev,
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
