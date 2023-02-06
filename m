Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315BC68B6E9
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjBFHw4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjBFHwy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:52:54 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6091E1557F;
        Sun,  5 Feb 2023 23:52:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyP2XQnz0N73PcQxjcUT4uAOGaufarRgV3t4vLzSzzaurNS9YOcieNt9HHUpRyhwuM0ST/JTfrnniUiAz2oiucF4XvGxWynkY75nZ+/jKnYF5jyJfTFHJLzLl+inSQwhMUp8KF/KTV6R0uHjgfrLSiQzdcb1w/PvSdL/whUjfUrVgoT0XHwiTaYRCpIpkuHalxJIBNxvQkJZ+M34gmal3k7aTaYlxnf1FZs2FlRsifhjhSiiUTTYgpp7TyZLepR00cZWTRFO5Vl65rxRkGfwPYmaCuzRjYw17K5klZ03gT+QESmo5i4AZg+VzA4BP9dJ3jf92mFMPCEYcQtJMJBfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJx4d6L32xsb7lM+TLJ9IAT+Zep1O/ydPt8JKIy3HJs=;
 b=ffHCQDtLu++R1E5ReQ7NDzjd2FnKcI31hET478cSznvJlv8G0gIdRGmRi5ovquC71bWDlL3D6+QbMGZacXA/lCwmCpeTFM13yhgSlUzhUUj9KSftTbmdDfMNVcPrh4lGp8gYIzzVm9MlilIb7XqLKIR+WCii0mBFs9TLYxqUTlGDY5ZlMzx3rW6jbN5nbnTOgzU78KBoqWZVQijbW2YIpB1a2PAihRChWoHiG6qBbl8fZ7Gtjnz7uWkLhJBs3AucxGtk52dUSy3xz+Kbyvj/mGn4YsqIkOTRx+jmFqkX+P8PUHkR5ft9LW0YSUvvdsqfYgbZBBhii8UPBuVSo4TIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJx4d6L32xsb7lM+TLJ9IAT+Zep1O/ydPt8JKIy3HJs=;
 b=ZtlV3xqkVCdEoJMfxTySEMtXYlBcu3RxzlI8GNdhznj8a3/UJ6829hjPsh6TZDRu2tpHt00m6JeVT9mO19xTSFl14OLTKMl2qMVxWKCQ08L7ww//5xTfGaLbzbp2s/s+uLONIvlAYGNugDKhqxzwxxpHpX1Q05Ec8ZZUZEusqbBXkWlLLK1Eb7YUEv1W9yawV01c44sPu3WlKPNxoO1W2hfj+pC9GmCitT/gDCXV23DrMjJW056Q12HoqU6w/6LxfLme95bxIla/oE9b5Tf8DZO97bHQwNjl3phF0Ws5x7pCH4BQc+7zmpLqeADSEpnxfCVrYTxZfdoWv2as/21C2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 07:50:13 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:50:13 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 18/19] mm/mmap: Charge locked memory to pins cgroup
Date:   Mon,  6 Feb 2023 18:47:55 +1100
Message-Id: <fa58b745a597a32b434b0d92d55cf0b97317cfec.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0114.ausprd01.prod.outlook.com
 (2603:10c6:10:1::30) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 427e0896-7913-4612-52a1-08db0816c76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8UuAVBxTWt5/pJf6aD+fYRN9CGKIzqzua+ZekDKIw+u7Cw+ngRBnvwoB9EW06W5OR0HXypCbToXB/cTcd5hiyTJ4YX4oO9HDgWQ64BG1KiuYLkpOYZfB9slmftj8NkWdQMDICe4WBXEAudCmcOSQpCOVpdMi/UhZdvuH1pZtbZrSg0jh32quXs3bIsZh/I+WAET/3XXCpMr4+ZnA1P14qXZR1GGx+UvgPTLunxC0V3bx9EMasETCjCThtsfLbPoQlyi/xXMFqF4N5AMD6+Ggcx/PYVi46aL5nnpIQS1piY4WVYUz6r/yGju67Hw2klWH6/UgXbVn6p2oPQOrUVL/DkCe/WilMc60kJsFbu/ASymE+K8BUoQBoqefccmV2J5IQab1Nm5oQ6n6h4dYvPMCzFxe/uZ6DscTTIgCKgE3W/bhaglxgsPWqQG5+aCypZ4hqCrRcjKkIJ5hu2vhB1yUq4iQsDz1zDM6T/dgbV26YW+Jrusm+AVcjKbr59XR4/09BclrJ0OjBoo7tyF8XARfOT4an4oPbYDJvUzT34OHJaTUSauIUkw6aBmCNAH5iLUWR5hsrxp3vf3lAG59oP4GKI5Z6z2vAHJDaOLw+36QOOi0Ayqvl0QKAnlu1SkoOoCznQ1YH5U4TKxwNkqESttoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(54906003)(316002)(86362001)(6666004)(107886003)(6486002)(38100700002)(186003)(2616005)(6506007)(26005)(478600001)(6512007)(7416002)(5660300002)(83380400001)(2906002)(36756003)(66946007)(8936002)(4326008)(41300700001)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8l7kC3OaK8BVTwVGt5goAI8wanQmAamsLKwN4NQpQIf4Omil0phmccbSqFeG?=
 =?us-ascii?Q?1Zj6ueoJx6xMDXquKDcQe5Er2cYvwVL4XX+2VHao5jZOwFkVnR28N1Sn4fn0?=
 =?us-ascii?Q?tSRX1+dzFIipP5IPwtwykErOR0e3SkceMaAVzAQtlErlGG3oyjrFLk8oqRyf?=
 =?us-ascii?Q?Sp6gJpZZw+8PQWV9V1LO6JuAIUrR/CTzXD79JZnPtEBmhASDkMQHjJoUQ5TO?=
 =?us-ascii?Q?xO5ONGXsnwI+n6lyNQm5W9G/fVdR3JBwGneg3qghzZf8j50sqW5ZOOiTAa4k?=
 =?us-ascii?Q?xg8orZXUEuTgdmYGeAgWNpCtE2HQSKk1vvxJEJYsHzROorPqUshOjTR6tdE+?=
 =?us-ascii?Q?QrGL5cuytzC+/2qr+X1Pit8TjfmyvELisUPWATl7QwbXwk4yOOBRCnCbW2FN?=
 =?us-ascii?Q?SIzcYCDmt39TTs4w6RPni5BgIjHahkFqf5q4NFxlmctuxuHZ5eFe4T11pSkB?=
 =?us-ascii?Q?RpqdK1cVGKu0J9ulk2cBYqJ9BNm8uW8eLEYWTXUG+C8fZ89hUQxsappHro1K?=
 =?us-ascii?Q?basRoaW5vum5BgCfWUBHNcU5aMcGJVQX8rrPQ5MwtgFllVkVtAj7RWLpfe0F?=
 =?us-ascii?Q?60pGmjJyN6g+97czYDhflfKCZW7gbDXBJP8l8MFpLc6fNTJNNtm6jhsK9ZYy?=
 =?us-ascii?Q?yS3KRgKwRF+gRJk2BBcjoi0Djtpx2dOJlX+F4Ioo8q4GvL0cKkLrXbH5g6Q5?=
 =?us-ascii?Q?KNBtmmNjf3YpDhxpekbGluthLLUc2v5CCpKr9/ArAtsUb089j0p6582e7zMi?=
 =?us-ascii?Q?kLUgOQhOJ79dy9LNIY3hqH1wKTO5ieCBb/VsE5LpJpP4+WmZ0bKchrCLR2lE?=
 =?us-ascii?Q?QShlUg4cSvKBX36Zo33V0/f1MtH/lr8xbj+BrwvlrpHbSHHelW3vZf9S7bVl?=
 =?us-ascii?Q?qXuCzjKH/ulZdQDcAw+MvUsTD4vddgzeEBIE5+BoB4NxoR+FJbzLNPBGF1xv?=
 =?us-ascii?Q?/OC2WXsNaOXRWGO24ASTDFKdpJBRWDSAs51qCJ2LqdhVJqwQZ6HOr5zz8VG3?=
 =?us-ascii?Q?PTKVvQUKbflh2hf0LzJ0UDeGJ/+5xt81MysKO6VIcEElzItaP+lrrwX9ooJ+?=
 =?us-ascii?Q?sTQWdI8Htq9Lxus9hnccpTFqmaVqQfxIhDIfSyqxv2qiaAUmWYENztI8W/pd?=
 =?us-ascii?Q?TYAvSX+6Dmj4U3QQguzMoHuY/A9xU0ZXsadHFEhGh0KF2W8A5LPt4WSB6Uol?=
 =?us-ascii?Q?J8T1uaNfmqZHKrMjZ9P004V0HSzhoV3uo6ZD0Pa8I73QgtzYTsKMjTacKcbX?=
 =?us-ascii?Q?ZgbPhGioZvLA4EZTdjWrS2lzZ5HJPAT/FO8Gm2C5UWy/2Y4ndsjX+Haq9k5c?=
 =?us-ascii?Q?07U8wL0Le846YqGhqna+JnRUPv+xoJNaKPqpiutkX9qoF7mRn31zGwTrz8YY?=
 =?us-ascii?Q?XtQL+by/WxJZOa6XPJSR9TAIG0g9xFEIVNuPlXyCkNJv2CptGfhmkYmsH+3G?=
 =?us-ascii?Q?r4cF1eOWtFDCPDAkkQPXJV+ubu4+1Q4mQMhH6v5DN3cF2YZ6EV5MphqpPQOl?=
 =?us-ascii?Q?r9u3GhFBBwt0x4RCVlUeFqdEoU88XsrsQxekmUkMCAP54hc8+2jswdSuEFxk?=
 =?us-ascii?Q?vPyie5g73YQgJQXm/7CKzyMT0q01G3Bv2NS8CUew?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427e0896-7913-4612-52a1-08db0816c76f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:50:13.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tD8S4PSSN2NXQP7cLnr9ez07RFo1dGSONbQ2/RD76uWwk7J/TTGeB0H+KUhyxz4kuaksMFWXf+J2eqKvEedMsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
index 1ca0dfe..755bada 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -589,15 +589,21 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
 			struct task_struct *task, bool bypass_rlim)
 {
 	unsigned long locked_vm, limit;
+	struct pins_cgroup *pins_cg = get_pins_cg(task);
 	int ret = 0;
 
 	mmap_assert_write_locked(mm);
 
+	if (pins_cg && !pins_try_charge(pins_cg, pages))
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
@@ -607,6 +613,12 @@ int __account_locked_vm(struct mm_struct *mm, unsigned long pages,
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
@@ -622,8 +634,18 @@ void __unaccount_locked_vm(struct mm_struct *mm, unsigned long pages)
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
