Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F57567905D
	for <lists+cgroups@lfdr.de>; Tue, 24 Jan 2023 06:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAXFt5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Jan 2023 00:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjAXFtq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Jan 2023 00:49:46 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20620.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::620])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E969A6E9C;
        Mon, 23 Jan 2023 21:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU5A36UM2lrVBA/0kP3zI06rITBuQKvdIuH3Q/gEF0WHLjLCnRifZFtboOFDwpmtGu1XHQY/VWo8Zvy7JskpVlCrQC+qUxIVDWvu09TLDvZRa8OFvn7RZvGO6F0lAF3BUru7Buub9Wy0QBMJtJHTXZ4eILPEymmCvpt2qryUiF0uvsrxYDyR0KB37Sa3JflCEsckaL9deHkE8KPKy+ogvhplGqsm2yNes+memCD4QB+NErcV06J1p7Mb0YGqWcKkJo+nfPFJ8S5uGBW+cWtYFh9cPajYmNBAMRYb63jcC0TFymXD3qXJkdd/x12v2dKns2aO/xquNHeRxjKnXdm2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/5i1Fiv3xI56uStZR+8ynxVAuNk9x18QJkcNkaDcTA=;
 b=QMREMs1RpleKmCih1JA0gxtzPGXskts4Aip8+EsNPKh3frUUtlnL9fHBU14JFV8ZMbqbZJjOlEi8VOiCGj6GhAAsVMIxleyfbgJ2lW1y99SoKeyAVGJYz8agpW5hrS8Nw0DHnIobJm0lHNyPzsJiHelm64NQ3TSwG8J1Zk8l+sY9ADPVDx6L+MbV3Sc1kZhP8nagJ9y6ivNPO2O7PCz42e+GYsVt27VQtnJIqPDea7g3XtX99yUWiTAfzuzuciHoQFfH3Ri1A4acgFUvsV5ECpJfKxFEURHWuMkcrMC8SheNmDh4mmPjHNzaof/nN74f+46p7bYs5EV7CCzIsI4szg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/5i1Fiv3xI56uStZR+8ynxVAuNk9x18QJkcNkaDcTA=;
 b=noUdmKq7L7A1uoz1VAMekURGEuYiqz9E77tY/yHmYnMRvS6Zsgb+95kGUfa2NxDQNSLoF2NVF/64Df7Bjh4nTyZ9z70M5iKT9BHL0XywyGYEFmjorE5/B1FXeNYe5ARSelzarS6TeMbMKc2OuA45pIaVgiXWlOEKMeMA2+bFChR7MswdHhORfFQg6s22j/0h749Ev2Wct+25OoiQwpVu4tE1TYQxwbtsmTa5a4NHKaXBTBd77UgZ8/29HEJqw141QmiAdHyU5pflfRqHELOyBfrrSQ08q/DU3jHed2kS20B3KvZwif0/yOntBrzupPIbRoM5l9oP6Kn8khp7wlkavA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:48:14 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:48:14 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>
Subject: [RFC PATCH 15/19] mm/util: Extend vm_account to charge pages against the pin cgroup
Date:   Tue, 24 Jan 2023 16:42:44 +1100
Message-Id: <76d61af0219560c03910a189f1ffa340d108858e.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0074.ausprd01.prod.outlook.com
 (2603:10c6:10:110::7) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 921cc3e1-df6a-4199-5a56-08dafdce9594
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5U+Jr9jzrcFyJyohas6fcBRUBR9I73TMDKEU/OxxJWuD7BLW92CMnUMWaQgkP1pO381eZWp8FpYNC4IKtiMd3jNH8urTQpiFVYVe8Vuo44alsDM8TFRzsSkHbEe1XID4ULS4PdRe3EfVmo1bRNzGRxkdWousPed4xn6aBnUZmTCOfqQRxqaUs0W9XiQXGFXTT6G5DaqWpwGReRgl87cyVjbwIr/uHmytKSXLs7tv6FtmlL7oFMM811ntU7eXQuKFyz0mospnbcHLeXETsaEiVEbr9r59kfg3l7mEPLcSqoUsTPWC9KhUvtiavfS/n/cEZ5GY4EgygWiPcGnzL7wkBQm6JP6rJTvkuu7n99C9MGjuZZr95vq3es1aAABbrDWIUzbYv0LQPzLxI3mSmbEQOyM2y4MxM3lr2VhkLQdp9md5WwosDSv5VLCRaEYsJQ4/3XS03OEi1d2zH+JJS7QQ4HOkr5H1HXg1k5dEYhROMmP2vwjhJDINMpG09wAIfeB7UsYG2qNUMbpZxLvKOZZGjFt1bKzAX4ZeMXSnBiTjUN7SuniEBNGQj+ZbyIAatLTKETo0TltAx282LpxVIUDDWy3RP0oz+3h2kd7X+ErHDLiH5a8hovZdqRErP5kJKKbw8ZPVEvPfGVLpeUsB4PtTjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(36756003)(316002)(4326008)(66556008)(66476007)(8676002)(86362001)(66946007)(186003)(26005)(6512007)(6506007)(6666004)(107886003)(83380400001)(6486002)(478600001)(2616005)(5660300002)(8936002)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5SXMR27HWV1PyxQSabaLithcZT6h1UUawtSIZjMAIM3jWe6xlsJ9J9Lhd9sY?=
 =?us-ascii?Q?Ej9opYw9IoYPQi5fLmQg0nu6zMSoqJd1Tg2WTz9mrTaHsPFFfhsmNW+wK6x6?=
 =?us-ascii?Q?rOEB/7mliJyqV9YJDReSBujc7AVBe66USJysbGf2m4bnrwj1y8NoYFsU9/L+?=
 =?us-ascii?Q?Gm0JrdvClR2b+geovaKY/ICNifR3M/Ufj3cU08kG9jZ2iGQdSodqoF6sCjbR?=
 =?us-ascii?Q?H7cYNq+9ov8FbEgKifnY8ZqeLuv+V8893i2RswH/ojQQHYA2GZ+ALbHpaFPS?=
 =?us-ascii?Q?qS8+mYGoFjHDfoHRPk6xdUOK7kq13buhgw0iv9ueNM2/oC0Z01nBM0C5M8c+?=
 =?us-ascii?Q?URl5KzfrC7LkCcWRR/KHbcnGqdOBaHRznGQ+MBRu7/YFIW6AEKVMSSwxDbJs?=
 =?us-ascii?Q?7Xb3pULaFcRek+DFHWeii6p6G6gXgoQUiZ85owtZoEyqB66VWEuHbU5cFbM0?=
 =?us-ascii?Q?GCBKx6MzB5+9CR2ZVcfy2Iee6I/fwwUQlg3RfWQ2k6bAUUUrGC0Bw06HNGDA?=
 =?us-ascii?Q?jBQv5ptUTin26QyPiG4uiL0Wp5d3DHc4WIfHyDBPkDl5gBKBrUymDjETJhSj?=
 =?us-ascii?Q?9wNHqtn5s2MBNCGf0Tn6OClbBmizMOxAwuwHeM7ZpRLHSxD8iDv8krAOqZm7?=
 =?us-ascii?Q?txNdfvrReJdVL1UhoFNj61W8YQwfaWqp2GQRc1MtlycteaOB9SOKIBD2V9NJ?=
 =?us-ascii?Q?KQYK2mssX8RKgLUZFMmWxnJ/BJgsR3EzxDi0jCb3kJ/f950akaIJ6arXbM1N?=
 =?us-ascii?Q?WQCUMgzOckwMqsod1n5UuACdlJ/bBgsH1qL6EmQLqMyMH4VKA0Bvp6jUQjdD?=
 =?us-ascii?Q?p5GcnpUYT/trHe6f4PWnwPoAkukxjpFLBCwh33yjTfxdSsBH3zvD9V9Ffb0+?=
 =?us-ascii?Q?Ds/nVaSSt0bQC89jD8fI3zEttKoo+RcN7ZwjQyeLLUcMuZSmfR51v+goMJBE?=
 =?us-ascii?Q?zdwAw+UTeWkcNxnwWomrAvnKWmG6/7Mz8gxVFqPJx7+JEfz7hfW0O0QRphaJ?=
 =?us-ascii?Q?GorxB/+9R8d97OgiAofHV3mRyDFZ+b8jWI5UNo5m9VtdFB8mYUL14ugdDYYW?=
 =?us-ascii?Q?MzieTxeGqzigk894I5bCKHXur8t2BtJvn6s+9FEnNBMdzYBHlbmQ6rIISK96?=
 =?us-ascii?Q?rclotekefodEzt0zbecxcA5Bc5Mt0WG9VazL3QnA0UR7oEXKQL1rq3mss2HV?=
 =?us-ascii?Q?YWQNFRaq5pjFVq9YAp+ga3gfSytpDH7LF6WI3rw9pXZMCd2EK5h8uI0DW34Z?=
 =?us-ascii?Q?cNkhXb9geWK9xozY8iD2HO8zfwb4AGPbxG3XXN3TOqT/oSykiZh/nDAIOHNZ?=
 =?us-ascii?Q?2H0enszIQEKggYko2gtq/DIL+GAfnarYszbjjuYq3HIO3i2Qy2KW8Xyy3lvK?=
 =?us-ascii?Q?SF6B43DzP0Tli6aZmooRU+gpzWec5GiUKMPvW1BPd3HYlssCPq3l9o+vevIc?=
 =?us-ascii?Q?0zqFvy1QGbFUbuaAzX6MrxWsh0tuM2suHs86zAqtZsy3TMgY315EIgRI5qHY?=
 =?us-ascii?Q?kw/goUmj0aEnfoyjbx97gSwU9IyFITFp7csQgUOwCRG/f9lX7QyMTUPLzVDr?=
 =?us-ascii?Q?OhJB9c08Cs4qG6tf9q5axVzsLV1JJsqJviZzMveL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921cc3e1-df6a-4199-5a56-08dafdce9594
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:48:14.2683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ociP2uGxEjGDegyYimdwoiteg4BG2tUPDOEZoQkTvDngSvjkWfUbs3CGjoDzboeYOuCZ6BdQtam3fDnPuzITiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The vm_account_pinned() functions currently only account pages against
pinned_vm/locked_vm and enforce limits against RLIMIT_MEMLOCK. Extend
these to account pages and enforce limits using the pin count cgroup.

Accounting of pages will fail if either RLIMIT_MEMLOCK or the cgroup
limit is exceeded. Unlike rlimit enforcement which can be bypassed if
the user has CAP_IPC_LOCK cgroup limits can not be bypassed.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm_types.h |  1 +
 mm/util.c                | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7de2168..4adf8dc 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1116,6 +1116,7 @@ struct vm_account {
 		struct mm_struct *mm;
 		struct user_struct *user;
 	} a;
+	struct pins_cgroup *pins_cg;
 	enum vm_account_flags flags;
 };
 
diff --git a/mm/util.c b/mm/util.c
index af40b1e..e5fb01a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -442,6 +442,7 @@ void vm_account_init(struct vm_account *vm_account, struct task_struct *task,
 		vm_account->a.mm = task->mm;
 	}
 
+	vm_account->pins_cg = get_pins_cg(task);
 	vm_account->flags = flags;
 }
 EXPORT_SYMBOL_GPL(vm_account_init);
@@ -459,6 +460,7 @@ void vm_account_release(struct vm_account *vm_account)
 		free_uid(vm_account->a.user);
 	else
 		mmdrop(vm_account->a.mm);
+	put_pins_cg(vm_account->pins_cg);
 }
 EXPORT_SYMBOL_GPL(vm_account_release);
 
@@ -489,6 +491,15 @@ static int vm_account_cmpxchg(struct vm_account *vm_account,
 	}
 }
 
+static void vm_unaccount_legacy(struct vm_account *vm_account,
+				unsigned long npages)
+{
+	if (vm_account->flags & VM_ACCOUNT_USER)
+		atomic_long_sub(npages, &vm_account->a.user->locked_vm);
+	else
+		atomic64_sub(npages, &vm_account->a.mm->pinned_vm);
+}
+
 int vm_account_pinned(struct vm_account *vm_account, unsigned long npages)
 {
 	unsigned long lock_limit = RLIM_INFINITY;
@@ -506,16 +517,19 @@ int vm_account_pinned(struct vm_account *vm_account, unsigned long npages)
 			return ret;
 	}
 
+	if (pins_try_charge(vm_account->pins_cg, npages)) {
+		vm_unaccount_legacy(vm_account, npages);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vm_account_pinned);
 
 void vm_unaccount_pinned(struct vm_account *vm_account, unsigned long npages)
 {
-	if (vm_account->flags & VM_ACCOUNT_USER)
-		atomic_long_sub(npages, &vm_account->a.user->locked_vm);
-	else
-		atomic64_sub(npages, &vm_account->a.mm->pinned_vm);
+	vm_unaccount_legacy(vm_account, npages);
+	pins_uncharge(vm_account->pins_cg, npages);
 }
 EXPORT_SYMBOL_GPL(vm_unaccount_pinned);
 
-- 
git-series 0.9.1
