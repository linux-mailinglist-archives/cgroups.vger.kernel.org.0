Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6521468B6D9
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 08:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjBFHvf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 02:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjBFHvQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 02:51:16 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D81E2BE;
        Sun,  5 Feb 2023 23:50:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiUOKde3JnExUrE//qUgKpl+6GpkO5kv1pyyyUfYMB8hhDLlGfutXJEAyycwzqwiZ/OYFN/7xneLVvSyxvxk0AIaIlWeGqFJwX5Qm5eWt8gUMaCep9dVNXoQtjYJOWAnM+g+YAxJaE+KvD2pLgtbpvdGagB8c5uh4lDb1skkiQc4+2dnN6pOluHlTSVt+6172q3uGTgUn45vgYPrc01+KyAgOY5UT0mc1knvOSvjXBqykHYGF20p6nqQxOhr2zYuJKMUbjIiuukEwAZrHOFWlpWs2+/ibNYf39Di1opEu306xWNQUIoGWyS4zFAVxX7SSEWwXCAdnB8Otgr5+jsQ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U8SJoSKDmLPXz4EfnAjwHkQK/6X73YSJ1HtmZ4UlyY=;
 b=XeuX1XoPJs1REchFnlDl+XV43L79W8E30JxFO2gD8QhCqTgoDRCwBCKp1YrMRCmrwWGhg4zeoiOT3oacHc6YMe625/RTLAjA+vrl2WNUXdbbIwRsQ7ygyIgkZQ1fc1sjM6/ljGGnTdjzKg6KwZ3B50ltsyCY7L5Es49XX8MQ71zfJnsI4zjMRpySqJ4RVj4k0BLtLFKPmzIyTqdS60M/OR5MXXPBeLdiXyqxmwtChy/44/NbJ6oomCWPLOhgJDh++8pxLSWD4a9Eingrcw9kIj2HtFjA0iwJSwjnWuaHU2lW8v6c0pnNBJ+aLNpJNTjZ3UuluK1wqc4zF6KctVun5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U8SJoSKDmLPXz4EfnAjwHkQK/6X73YSJ1HtmZ4UlyY=;
 b=dAAIMDW5Q0uOtcJk21Jl8UlVFM2xF6/6jf8SZTj7poyAZJEhAz+4IK3Gnjh8Kj7m5zHwcQdem7WNx94PYk768sb4b4ryluMsF9kSJBa1QHx+T99XapGI6gXMN69mZ9UomyDR8tA4WQ3g0l5YnammbpVFW0GI1ZDr3XV2Uo3QniO5T369TPCuPTi/lz+2EN0q9QOwLMvlxb9Wdy6yauSHCDpHAnqtzzT5mU3f7/JeuDXLFZgdyhevQ1y7OMHumnUNyzOF1xM/lj7cbestDuosqy7s4w+emoriYKZFsRnd00XTdrTsAVGkIjpw+w67IgyNslCJM4ohhfqvpJauUvxZ2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 07:49:53 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:49:53 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: [PATCH 15/19] mm/util: Extend vm_account to charge pages against the pin cgroup
Date:   Mon,  6 Feb 2023 18:47:52 +1100
Message-Id: <dea526f077ece04e3ff60249bc0d7d9c0cf5e5f7.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY2PR01CA0019.ausprd01.prod.outlook.com
 (2603:10c6:1:14::31) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 5304682a-003c-4ba0-7927-08db0816bbd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pqCY7aiHhVea1fBbDGml4HA2yjB9ffOiBCQiepLv3dI25PrVbY2Sc+mcQFlIQVWoTFS/HviX7kk1Dro9fbRIaOUm+n66DuTHAQZT3KoIYB+biaKJL5B1XTnPUIWTUoDqsg9Qc5kTrv82gvn31KM2YDmCA+tw6iFoKIjZ7zWt9dmMXDUvwryfRkDhlcJZ6D6+1aYSt4A9dw40Au2Lc8fTGnzCkjVspEC60iamkE+VvwFmvb7/g70gunuDZ9oNas97AQQLjpPDgWBUUK++89NkVBaW99yqUkIO41E9YPBGWOpmesmEZEjtS8zYgfTpgCvkBC4AZ1sfXxAFNizARkj3yvPlZ15YtDSsPFi37JaGnpz02cFh8Eb8nFu853VYLRjSBvFoLjjeI2gR/RqccVJjPrZGrJ5QlnkOWhY0TkLz4BMe+lAhKfuk2EOsWnueaF8oV/dAZw9AJ0X9kc+rJx4uk76trHBBoed5W7gmoHaHjDIoTfwR45Mm3uvavzbN9lxffomGK0R4CuxkGjkLaf0JPCempnwuJuTfI8qv4DZZQliTpvCa0AyS26JO6X9V0SG/45Eu7g46oK3SknhGQk6KAjASg/UGQLhCRG4b+GjIbsnf/gtcCNs7xE+lKDUJy+FNdxeKcuWqL5RFS0DqmKpXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(54906003)(316002)(86362001)(107886003)(6486002)(38100700002)(186003)(2616005)(6506007)(26005)(478600001)(6512007)(7416002)(5660300002)(83380400001)(2906002)(36756003)(66946007)(8936002)(4326008)(41300700001)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mnSJNOyeedE/vXRDi3G0lpuoTZbj75HMvgFQ9We9gTKg6PSYlqO74q6IDUFf?=
 =?us-ascii?Q?jFr04XmgDJczXXyKkSlm1WHJD9QJT87bVdC0vvGkqbdq8tlObilm55DTIPdT?=
 =?us-ascii?Q?7T56rBMmACPOdedBYkMjwEUf1D0kHHTK7vXMBgxXa9zKS8t5Rr5RyakdwiNt?=
 =?us-ascii?Q?nQXvcCGRQUYU/gYq3e+5v42CrLho6tKU1XjoXf8Mp0JEUv0tU1dO1szKt6bx?=
 =?us-ascii?Q?y43tduA92mxJcmOhGq6+59R3hVvdD5Ldhry54s0O6NY5+GzkbR2oFcN5ZQq6?=
 =?us-ascii?Q?nt5YVI2yAhneQRgYM2WJutbzOvKHGFQB3ZT3MNSUHX0Y1GBK7Ii8tEafl/lp?=
 =?us-ascii?Q?6TGOE2j7l18L51nXmH6+6o72Q0PeRecG18y/qqc8yyIQT7Po0xJeOm8RH6ZJ?=
 =?us-ascii?Q?05JjHH0madAq4Kyw9SDBZ+a/1A2/l5MSBoy6i2hscgznUYD9Yz6UWEGSUYwK?=
 =?us-ascii?Q?rryzITI5erB240FMiqdTBPy7orchmDrMTgK4EQ5HjJviKugamlGG2b1hfODM?=
 =?us-ascii?Q?iRsdmD1IvGiGtcbpRff5MOiVIimZeuDTCtBrplTZIVJ48LfSXDYGpp6r8P99?=
 =?us-ascii?Q?hFXy/Jn0lJ4837h7DhMNbS4Ddj99ZFOCzGMmiF6dUUx4+wk+U0UGSuBOfjw0?=
 =?us-ascii?Q?Z5TZ+z2vvcgYWyis8lL8qUMiErJFKJWwEQ0nRYi2EXp4+qdWcEH7f9pr+oKo?=
 =?us-ascii?Q?kqDnLeh8BD9nRmPK/TRKS9yclxVIJCIC/naf4HEQlW8EgT7Xg9TPUj+/LNmN?=
 =?us-ascii?Q?SzyD/zO8LrvsMQ2Be1RbQ+QlHpqdJqdQQr7bMPLS6kw+wLCyEIoPqvQwwBBI?=
 =?us-ascii?Q?gEg45Ys+qdV15Pj2hrPs3OCokR0pcJntdKvhEl/5hd99nMgkb1Dxg4Ay3av4?=
 =?us-ascii?Q?dvDwskkKKLH2hLgDkAeL8hC/8nE+YusfoYZ4L+3A2sZVvMdzpBhAH3mX82+/?=
 =?us-ascii?Q?LXctoI2lE/bf3pEhn2BMvRcIolnlhuYY+GX3+9c29lM+mdT6bsdHyTToDW/b?=
 =?us-ascii?Q?eidp8/ApntkXGpqDyNkTM1mnwGPjrKMWk0nOT4zafgmWTGI2webd/i6WoOG6?=
 =?us-ascii?Q?BNaDatc3uIg4SLuPfv5na3wT6GOVk8O82dlKrSy+hsodnMfN1uIGWIBnSkSy?=
 =?us-ascii?Q?fTSsOnPTl6CdjH/U2qShbHIPKXOBRWDo/0BkflZpb9mZqzXmPffzEpDYU4Vt?=
 =?us-ascii?Q?lapiZwJjdbs7obqLtDhVqqmkoJxBhVC1XGJlZaDkbga9JRyQvyLI9Yw4JWc6?=
 =?us-ascii?Q?uzM50GlzfDg4ZcQ92slsJCc4SY4NIWfvcgw06RBrQlgFdVHnZ3HgR3XWWsDT?=
 =?us-ascii?Q?0NfvK66AnYXmjjml2xusIn8iZY+6bePYmUSq66Hj63OSsfcooLX9v5jkwWiA?=
 =?us-ascii?Q?X2DY4woM+ASKUCOgdESB8aLiUPu2IBnlmlgT8A31xEWipizMrYxTZccj1c3s?=
 =?us-ascii?Q?4amn1G4ENuq6IhogmpQaVOwptN03wBicPN56TAoVy2zXxi/kum5R2MErlUin?=
 =?us-ascii?Q?wdU2pSH2ibmgeCoPYSbysohSURARiCQ2VMETOYLi1LvXzi8PEIJVDIkWc+Az?=
 =?us-ascii?Q?iJygpanCmlOiQnMEwRoZCsKAzwGw0re8gXWuYY5P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5304682a-003c-4ba0-7927-08db0816bbd2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:49:53.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pHiH4yNzHOKl8lB1/tqrFYEcZ5GZ7zB4hXjQDFhgsIZjYiBDDvs+db6oKKpdttdPxHrv69MlSjOmpFFByMTStQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 include/linux/vm_account.h |  1 +
 mm/util.c                  | 26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/linux/vm_account.h b/include/linux/vm_account.h
index b4b2e90..4fd5d3a 100644
--- a/include/linux/vm_account.h
+++ b/include/linux/vm_account.h
@@ -31,6 +31,7 @@ struct vm_account {
 	struct task_struct *task;
 	struct mm_struct *mm;
 	struct user_struct *user;
+	struct pins_cgroup *pins_cg;
 	enum vm_account_flags flags;
 };
 
diff --git a/mm/util.c b/mm/util.c
index d8c19f8..0e93625 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -453,6 +453,7 @@ void vm_account_init(struct vm_account *vm_account, struct task_struct *task,
 
 	mmgrab(task->mm);
 	vm_account->mm = task->mm;
+	vm_account->pins_cg = get_pins_cg(task);
 	vm_account->flags = flags;
 }
 EXPORT_SYMBOL_GPL(vm_account_init);
@@ -472,6 +473,7 @@ void vm_account_release(struct vm_account *vm_account)
 		free_uid(vm_account->user);
 
 	mmdrop(vm_account->mm);
+	put_pins_cg(vm_account->pins_cg);
 }
 EXPORT_SYMBOL_GPL(vm_account_release);
 
@@ -502,6 +504,17 @@ static int vm_account_cmpxchg(struct vm_account *vm_account,
 	}
 }
 
+static void vm_unaccount_legacy(struct vm_account *vm_account,
+				unsigned long npages)
+{
+	if (vm_account->flags & VM_ACCOUNT_USER) {
+		atomic_long_sub(npages, &vm_account->user->locked_vm);
+		atomic64_sub(npages, &vm_account->mm->pinned_vm);
+	} else {
+		atomic64_sub(npages, &vm_account->mm->pinned_vm);
+	}
+}
+
 /**
  * vm_account_pinned - Charge pinned or locked memory to the vm_account.
  * @vm_account: pointer to an initialised vm_account.
@@ -537,6 +550,11 @@ int vm_account_pinned(struct vm_account *vm_account, unsigned long npages)
 	if (vm_account->flags & VM_ACCOUNT_USER)
 		atomic64_add(npages, &vm_account->mm->pinned_vm);
 
+	if (!pins_try_charge(vm_account->pins_cg, npages)) {
+		vm_unaccount_legacy(vm_account, npages);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vm_account_pinned);
@@ -548,12 +566,8 @@ EXPORT_SYMBOL_GPL(vm_account_pinned);
  */
 void vm_unaccount_pinned(struct vm_account *vm_account, unsigned long npages)
 {
-	if (vm_account->flags & VM_ACCOUNT_USER) {
-		atomic_long_sub(npages, &vm_account->user->locked_vm);
-		atomic64_sub(npages, &vm_account->mm->pinned_vm);
-	} else {
-		atomic64_sub(npages, &vm_account->mm->pinned_vm);
-	}
+	vm_unaccount_legacy(vm_account, npages);
+	pins_uncharge(vm_account->pins_cg, npages);
 }
 EXPORT_SYMBOL_GPL(vm_unaccount_pinned);
 
-- 
git-series 0.9.1
