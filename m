Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5FB679070
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjAXFuw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbjAXFud (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:50:33 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D61F360A8;
        Mon, 23 Jan 2023 21:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g08ONDz8RF9X3Ehc4Y8ZmLl5NTpcsTw1TM/qBe4O2dcMfbXBzRMP+urpb69k9AME17Y+tW7+orDNWQLDqMCE5AjWF1hYiuVPrGBdWA8eC0mRPzZzVnsV8LQC5/aJwYADVqa7Op/f/VuN69I+oXcXXxfq/yLtRDkjNAUHcf3kZJ7CewzatflfRogjW58Jis7jtV6q9Gev2zfd/cM3OBZX3ugy3KcyEw3HTkzXUiuZHdGdlu0UEl4fEuHrYrY7P63XGDigBTSJxQERG2b1k/OBJPA1lwPLctXlvrgwGIE/ukMCz5KAXxBAdpnRC+2UQk4nZ0V6+Y0kvIBwFjdvHOxaug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cwo0tfKFqlSjGojYIjz88S7pf4ONV6bklIA6oByAF4=;
 b=lsB35nKfttiyjjrkW6zSuBBAWPHzIX+qclbw6bgthp4n3j57c/QaBOo/UrObW3d89FGwSRNXy8NjC397VAmwQeICkHomFx52YZCxgmfKmg/akd8F2lJSDvCU29i6tXVhNvHJrr9t7bZ3MPfICRebhuMDNIL9jJNpSVIVVU1dqn0y2OcYzCXSlq85k5pWXHLvivEsKzz/O7bgqVzRcRylFuH7GIzfhc7AHSVU7gOkGYlUPYG2BX1qiSqeEwHRacFQ0AamUUt7OSu34A0ZCHK3PN4pmav+VBrDCmLVLLrX6+Ay8yy8jKyxDDURMJ0OEcwgL9PJuESylaBg4BXkaCx9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cwo0tfKFqlSjGojYIjz88S7pf4ONV6bklIA6oByAF4=;
 b=WoL9BiR2yLNy912yNr/5ywnnEnSpU2Z8QQ09z74/o96XY8GFpmvaleX/P6bu79Lz7wVe/onJp9mjlz/S51BLQhrttZ1wSTdMoUU6m6H8QsDbEEmCNKbbCdLoi6a6LGNgOX66QCRaZhXBDHv5oVPZZy2sp1b29um1b2kLvETMNLiYZf8GxEi8kfMFsbJCa4d18m0NTrEije59aOH3TSLCQtL1RnrOFau0EYJ2QlqS8gxnCLmlW0Mwlm1v9Zupyi1+0lmNi/4Q/eBjWZs3hhuBZfG5caU6vYTDTIS4e8pAY3yn3k3U6ij+9hT7K3ggAp2Pnr5L33ahHmBgdA2sFQqmVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:48:49 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:48:49 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>
Subject: [RFC PATCH 18/19] mm/mmap: Charge locked memory to pins cgroup
Date:   Tue, 24 Jan 2023 16:42:47 +1100
Message-Id: <3883f8fefba4fa039c8bb5ea1882aaf4585dbc07.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0086.ausprd01.prod.outlook.com
 (2603:10c6:10:110::19) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: df3d31c9-199d-47a4-8ac5-08dafdceaac1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVqAUNH3AQV7YF8agzDLryko40gLhCW9ldfty/HINCSttBJYg30cPg6g1cKMeJf9jQgavmvD7iUmOOVAFjsPg4bADZzGQmEf8SeBy+DiRi1+A7t2Vt/4aM5qSUSkEMAaD8AHxP9DzBfWa8goZZSO5NdNPvb1WigibWDSo7BW9hXbeHuOCFKcsaJ3oe64Lo5EuDP/TlFlAZG3H6ZQNID4I7VEjHxjfcCZLtUPwLj4X8CpuUXvomL09AghoV8s90bnOAAzzjFLiQos913e65Sb4gWxeypcbLclkfjviuewpisM8Tb1fdc3YgAApy+VjdvhL+W8mqjVHZkTWr7K+Wyfh2INzPkUSyichiYviFMqhI5c37jy4gYdPGihcos0WiRMRAp/3qm9Awwx1NqBa4meifcsvRgIvdtRpnKzGxWFTNQ1D25LlK2dkVVY3NOgozXCMOL6JUxvRiUbsW5oVWExvWAjHzd8baqnKHoZf+nJCiSgn9Jf2ORKw8R2466IYUZtrgbGLUc3sVKDuQwYYwm8blRN7IWWQ3GlZJATcj3EYoZABOUqolE44rjRuFb3z5809cPQbEFSevdi7n8TAMaHyIDH/FwlF6TUGnfm0tFI6tNwXJTOK97CuWLcSiq4N1P/GLsAHbSBvM+3JjPQypRQUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(36756003)(316002)(4326008)(66556008)(66476007)(8676002)(86362001)(66946007)(186003)(26005)(6512007)(6506007)(107886003)(83380400001)(6486002)(478600001)(2616005)(5660300002)(8936002)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2xoZ+UxT1JWl6ziSaM2I9RqoUmuQbusQjqYIZo2umK8rHZCZnYP8sNTObxND?=
 =?us-ascii?Q?5/PF2zW6gut2lXEpua5w4E9DItYZvXoK8iiar+382IPUBOLEA/0Difwpllrk?=
 =?us-ascii?Q?kF/6aXN+WeyJjOoSj5U/j7sQf3BspFwFNzWYoci0CMsiMDGzfMe+hbjDDu9M?=
 =?us-ascii?Q?3mdM09KY8l6kFqhzhC7K6iCohR/MXkC/x0nAXTAaDCQF6dROB2Isc8WrWj8A?=
 =?us-ascii?Q?66Ul+0TF5409COjv7CskMIIbpkTSMb686MrMTTfOc+yqSi+VQi0Gftmv0Quh?=
 =?us-ascii?Q?z54gK89BvEOE2INpYoXmk7WSb9F93f4soZyqIgw1dYYzPmaN1hRYrl4e8AJX?=
 =?us-ascii?Q?eryzVGpvl4FhR0DIL4rBjhM40zMk2kQ/VrLGZBbgCS54D8Slym1d34bmQHuE?=
 =?us-ascii?Q?hvpvNwfI7TKKKqOs5j1DHOIh8NA6c409Q5ibS/lYsj0aHKVixnwZjcVKbBez?=
 =?us-ascii?Q?fWQpvqkqqWr0Um8zohwZtf4VFmm4gEfCjYTFmPoTQslzD4+8/SBXgEDegnsU?=
 =?us-ascii?Q?3bGoiAHq2fcT2FSavrY2n/ZA/NvcEVfpETZ/YHRWLpLEjP/wcuDruNrM1mgn?=
 =?us-ascii?Q?8fDk8tCLgsqj5jf5JeqGzud9U+uXgK6PbEE0vMs/8mXzO7qMIeSQOAgPe0jF?=
 =?us-ascii?Q?gW5gzh1hRcQNN94bSNpOeqw/aU/SkPl+5Dn5DNu4jE6gbomvemwv7P2BAmay?=
 =?us-ascii?Q?owX1EtXna4R/j0CrmIDzDMA09XQV/a4HXj7iM8oKHmunlpeWnZpZCobeWxNE?=
 =?us-ascii?Q?3vLy6pcVG6ea8xNCEbEN5nUHl5vdmDgSDVNah8rE+bLM+cgDkbLFOcCBut9O?=
 =?us-ascii?Q?yhjfgWQKltR7KqGDDrWKnzN97b1Er033SjvE7MtS28npx5u3w2LNSyJCdl3Z?=
 =?us-ascii?Q?cyb/OHbZQBK3rKZ7sWorx3uH5JyN/Ar77GuVI/lLeMGtz0er7bkXiesVRaM2?=
 =?us-ascii?Q?y7I+vvcW7Fy4V67Zc2tPNjrkUAa/CY8sRDdcdmJBpqbNYMmsj1yw0Ra2Su9O?=
 =?us-ascii?Q?p/DVD1OTCO8e+buRr0c5zer1LJ/nocozG34zFSfpDOCDbC62lQpuJkjuWC8W?=
 =?us-ascii?Q?EXSpsFBi/Dvi0jURyTc/G8iQePOJb3nzsEAXK+IgqhloR8akzgNsqdpL4Nq+?=
 =?us-ascii?Q?09BtBD023OrmKZzS2Oo0fNdUi+BlrhL4Hw8lzi0nRZcDDEcXRQbI3+hMmTna?=
 =?us-ascii?Q?OvYaqJYAzSy1MOc1y4RBZ5+Oz9L9gg4xBOgZ4qAAloyCYuGO3AHcIbuAVQHW?=
 =?us-ascii?Q?iD4GSH56mM8PbtUp9xvL1w+frFDWvfqC/udZkld4J9gRAGRhFIo+ooZBJDaF?=
 =?us-ascii?Q?SuGPzmXQ6La41lkOl8uZIAYW5/p54C0mVYuyU+zOepxdIEBeq1kxaWxULkSh?=
 =?us-ascii?Q?/J1/i6KW/5yLiuH4FI3rJFQmOTnHNG93cD0j/EgdmcsaJdTqJNz8SGbKzsQz?=
 =?us-ascii?Q?YGVOMO9F1XPW34qwb7LclCAHHe1fNKM3zcQcGhJf0qvKjNHhoX5YlSxzFJ1R?=
 =?us-ascii?Q?nlIbqxYCKWWrb3FZkV8HgDnrC33j77I5EkxYbRn1++X2YTV6DTC+Nmw1+FAE?=
 =?us-ascii?Q?TdBu0Knh+MZ/qFOtV3BKwufqp17BkAZvCic71s1C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3d31c9-199d-47a4-8ac5-08dafdceaac1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:48:49.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uIQPRqr7jcxV645b/6A2tvrxcxKneDs/uGpW3WazBaTYZOTgAc6dwKVOfj2nSafkEBSEsG7MOoXFdAM8kwdMzw==
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

account_locked_vm() is used to account memory to mm->locked_vm. This
adds accounting to the pins cgorup as it behaves similarly and should
be accounted against the same global limit if set.

This means memory must now be unaccounted for correctly, as the cgroup
typically outlives both the mm and the task. It is assumed that
callers of account_locked_vm() only do accounting against the current
task. Callers that need to do accounting against remote tasks should
use account_pinned_vm() and associated struct vm_account to hold
references to the cgroup.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/util.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 78b060d..d6159e3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -551,15 +551,21 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
 			struct task_struct *task, bool bypass_rlim)
 {
 	unsigned long locked_vm, limit;
+	struct pins_cgroup *pins_cg = get_pins_cg(task);
 	int ret = 0;
 
 	mmap_assert_write_locked(mm);
 
+	if (pins_cg && pins_try_charge(pins_cg, pages))
+		return -ENOMEM;
+
 	locked_vm = mm->locked_vm;
 	if (!bypass_rlim) {
 		limit = task_rlimit(task, RLIMIT_MEMLOCK) >> PAGE_SHIFT;
-		if (locked_vm + pages > limit)
+		if (locked_vm + pages > limit) {
+			pins_uncharge(pins_cg, pages);
 			ret = -ENOMEM;
+		}
 	}
 
 	if (!ret)
@@ -569,6 +575,12 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
 		 (void *)_RET_IP_, pages << PAGE_SHIFT, locked_vm << PAGE_SHIFT,
 		task_rlimit(task, RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
 
+	pr_debug("%s: [%d] caller %ps %lu %lu/%lu%s\n", __func__, task->pid,
+		 (void *)_RET_IP_, pages << PAGE_SHIFT, locked_vm << PAGE_SHIFT,
+		task_rlimit(task, RLIMIT_MEMLOCK), ret ? " - exceeded" : "");
+
+	if (pins_cg)
+		put_pins_cg(pins_cg);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__account_locked_vm);
@@ -584,8 +596,18 @@ void __unaccount_locked_vm(struct mm_struct *mm, unsigned long pages)
 {
 	unsigned long locked_vm = mm->locked_vm;
 
+	/*
+	 * TODO: Convert book3s vio to use pinned vm to ensure
+	 * unaccounting happens to the correct cgroup.
+	 */
+	struct pins_cgroup *pins_cg = get_pins_cg(current);
+
 	mmap_assert_write_locked(mm);
 	WARN_ON_ONCE(pages > locked_vm);
+	if (pins_cg) {
+		pins_uncharge(pins_cg, pages);
+		put_pins_cg(pins_cg);
+	}
 	mm->locked_vm = locked_vm - pages;
 }
 EXPORT_SYMBOL_GPL(__unaccount_locked_vm);
-- 
git-series 0.9.1
