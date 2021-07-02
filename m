Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477B93B9E00
	for <lists+cgroups@lfdr.de>; Fri,  2 Jul 2021 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhGBJWh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Jul 2021 05:22:37 -0400
Received: from mail-eopbgr1320111.outbound.protection.outlook.com ([40.107.132.111]:50832
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230351AbhGBJWh (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Jul 2021 05:22:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPG9SxTZ9ruBNt7K8e61mvEoUJLpftRm1ujb3Es9r3Ch8w6/g/V8Bpb8NTNsQv8R/+QywfcQ+FKHjHuSUc+MnGFYQzDbgqpBOoxWo5mwXUicpApaHSCen3mTYXAjCNfpupaBeMo9BfS0sGLIJMsq4PE8FHZQRfvy+E/sYhW2WMZ3c+XD0iyfmESbhoRK8ur6z0wg1Bq1pdRP/gSRmwr/I7Wc+1RxEQtKXeqCb2gskiQkKuTAA/ZYXEDzBISsE5d5Vb9KHnEMbla5i5dGyAMBAOdo6OKcG4n0fyldXYxfCQy0uwkGA9t4KqumR7Xgvc4x1DMF7ySgGWiTT9LljVm8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYkKuFIhnyWIyoJrGTPpBOke6zEuaYyrmL/Eg/xyoF0=;
 b=YxrXbZt5DVfra7aog9VNKCYMHWXMhwn9nLRQrtgDm5/fGB6WGeQ1QFYqblLPiW5P07PXjzGCEc8UWjkU42yfoV8fEXKVcW7/sw6r1fYmHuSbBgC8tR/fHUQqUxxzPSXQj+l7SN3qqGDMCDLCDx1RjdVQTfqJ4fUPb5n6wgDSTxvYSegEJ84+IzyfJy3TyU+T0vUISgz1Ypr937qEx0hXXGdKydFtVqZpAksEJHQ6AUWuB761xa2agH8y0vV1jZiZwFadNX/hniTjMo16IK5obfst/KvYgQILIeqABNmFFzFXwnKTf0ttntuEm42GQ1JD2egvdp62MU4R58YTJXhcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYkKuFIhnyWIyoJrGTPpBOke6zEuaYyrmL/Eg/xyoF0=;
 b=FB+2ETb5ycNf+9NKH/Q/YoBez9gaGRq5+vEP2w9uYPCiXW6OvMysVncdlqR2AVog6+Ahn8EwDGPbZrKi1WO6cp5cAVYV3QbVJ0zhLKHhRDS/9XTMtb0SsQKdCSTclcUDZAUESE5KTWwXbaEAWhzJ30fzLgMgAOKwApwEONMt20VH3J/ruPG0nr8jAkNTC11I7DqI7rpvw04lda2+TSZpmWlamvBDUDGbc2g1fbODCbUGj1FMb/ZhtsHzu0cp8T7oay6wwqsLvCzprtycjgFrE8BHW71fXR1YDrLzJYI+Vlc0WUxXXR+a3AOvrJtUq6LEzrppqoGxJ78pF7E7cSB/aA==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=zeku.com;
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR02MB4707.apcprd02.prod.outlook.com (2603:1096:820:39::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Fri, 2 Jul
 2021 09:20:00 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::883f:a6d7:92f5:c16b%3]) with mapi id 15.20.4287.023; Fri, 2 Jul 2021
 09:20:00 +0000
From:   Hui Su <suhui@zeku.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hui Su <suhui@zeku.com>
Subject: [PATCH] cgroup/pid: fix the pid_cgrp attach bug in cgroup v2
Date:   Fri,  2 Jul 2021 17:18:44 +0800
Message-Id: <20210702091844.737784-1-suhui@zeku.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.71]
X-ClientProxiedBy: HKAPR03CA0026.apcprd03.prod.outlook.com
 (2603:1096:203:c9::13) To KL1PR02MB4788.apcprd02.prod.outlook.com
 (2603:1096:820:5a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.71) by HKAPR03CA0026.apcprd03.prod.outlook.com (2603:1096:203:c9::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.11 via Frontend Transport; Fri, 2 Jul 2021 09:19:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2ee2735-2fb9-4085-7eef-08d93d3a90e9
X-MS-TrafficTypeDiagnostic: KL1PR02MB4707:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <KL1PR02MB4707E34E6824C36C6027AD7FC61F9@KL1PR02MB4707.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VcEdUOGR4QW5qMUTASZFDSxChUkiXETdCDsqs8W/4cfznTEQq1ETZOjJZIwIkWLfZUV8p8gfFLqXM048cUCtWnfE11fRz6vd2B1eBMUJAo7sKoWqkS5YPsq+bmx0LUadNKJJzoTgCbHMsHew4KVRn1v8DRHjBt0ebqneeJwUx8BYk/0X5aIeoTxm2JgnegnEYp4M6dpW6MeQZB8J55E4jyaEb20rp4YLGtxHdL0Na9QckppMIaxFhhThXZVgGLZ8KHnv3xDT+XsmxpeQbnmSV6u6hDcePXZWgRFW2uTy3gN+HxPZb69q6ajS6mg49jNwxJaQnbr2AAsf5yK/S73ZYsFyAH9nG5OVMn8wfpRr0vAZrtBO/DnpMrdcslIujmi7P68clTCfmvbQylyqojYYrVltJX2wbCEER1llg1oG4ms3fHswwxTeEN6Pwc+Pw2zZR8EqW2Pys0Oh68P7oagoYBXuYKeuDsalHb1pTzVFgozzyX8CYh8VtNkrVfZxgOttWggS5TMUc7hKIxAD3icxmSqSmSvyhpkemCp89/hs+QSdo/T/9c6ZL+M2QNoxCfapuV4SvCrJF2SLf83R3WYmq62kBwzKOSSrox+hYK9TmtleL1supHsH1QsU5flU+Q+p6A7REKhlmmw+y3oZliGNDNPbCkJcJOuq6zeU2qTIGJts0UHHq34q4y/znjkLb79MGcr3vxVhQ3KiOVpivg6durTusB4ohgqqc5wLpJtPtgcidJ/hhn4Xvo0Ifn7GAN5Np7v8xD1JMNpMzN0YGrz2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(346002)(136003)(376002)(6512007)(107886003)(2906002)(8936002)(66946007)(956004)(66476007)(86362001)(66556008)(6486002)(2616005)(1076003)(4326008)(316002)(38350700002)(16526019)(26005)(38100700002)(52116002)(6666004)(83380400001)(8676002)(478600001)(5660300002)(36756003)(6506007)(186003)(69590400013)(11606007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RRE4kP3wOPs1PTIk9iVIms/DtR98XPKMV/QhshJ6juj/99mbY2Ai23sHf3Fl?=
 =?us-ascii?Q?cfFRHwnscUgRktpIEainMQQpAGI2vNkQJe3Qw6qciChViUm3HFMsmDwDq042?=
 =?us-ascii?Q?pUTpt1YZmsapxRXyX3Q/GIhY3ue4856cZgMYkJSQSNDlm3ewjxRtTok4bQLb?=
 =?us-ascii?Q?KYgm5cTATtmk3tZxkEGfjQYJ9zLqvrUBPYp64HLxBNcuAqehxoFIziojRkoB?=
 =?us-ascii?Q?pwK0/Hcmos3NzGHZiUkDdr+6kNYLOjttgBtAxtDr7F2bgO7FOQn7JgevXtxF?=
 =?us-ascii?Q?G9nHxHEQZeUkFQwYSksRJZrcmX9s8ocwJPCJIFipuc4YsqSLZkLIsvdrJCOz?=
 =?us-ascii?Q?HjQULlTmgQB+DzHzTgoGkVVBB1ZZMT3X5IPBD2LE3ofBUcKOA5sTLYAa9FLm?=
 =?us-ascii?Q?aENBAsTh+mGEprNdynqeI1bMLXL/ywq/ja7+jrmRIw6ySdCsBaZT+NB6hPT/?=
 =?us-ascii?Q?DGvnKrgxHW3fEGlwdVT2Ak3Ui1Fr4oaTZ1WK8+WN4eanpcgNNtbo5PPqyxNO?=
 =?us-ascii?Q?OlJXJlPNO3pbQ6KoWBM3V4qGUpX2JCx9yCZe9JUPp/UF6zaL2N+FTblAaLO7?=
 =?us-ascii?Q?KeC0CjdKjfMUqN3DqZsjUEgEotWCAxhc8UHYr5ZNUimf+iPhUoKpJBUYEa7b?=
 =?us-ascii?Q?EUYmB7wsox1/kRcjQYESMFQQjhpL2T6kL2zcFKV1WKidAWLRoUvV+kih9rXs?=
 =?us-ascii?Q?+h6cSS9UnLh2ntJEUVmesy9c7SvJ8IogapdUSR1aavjh5WWcNsPnImSQWCA0?=
 =?us-ascii?Q?kw05l+eZEjdFHTHGvqWfduICn35xWRhfdAPgk6pQ+LJ2em2LtppBFWbGKXyT?=
 =?us-ascii?Q?JpSQRyMIvpTUYLlO9mzzkrHQxhLOBf2kz8Ad+/4HY82R2TQ48PRYiEyGOKBr?=
 =?us-ascii?Q?ejow+1Fm6Dgta/hdQSey8GlqxiE40CAyXUXPD8GAmG3K/lzdNPfvxEs+tONq?=
 =?us-ascii?Q?JQJULCFGt7NTyZrV8PtWDBSluWsgPyIEr37tqW26DXOnVLrsaxUwA6+apY9S?=
 =?us-ascii?Q?42894tuo50wkDfCtppIcK8y0nvCWK+Kr6PHwhLo/bMjLHyuAYiNZN92PjXa8?=
 =?us-ascii?Q?+6dtj1+5WTeolbsKfQOJV65s0KbHBqh1KKKXWjQXW1n0Jts9YDZnW9QGpe2j?=
 =?us-ascii?Q?aMIsvZnOvvhY7NJaMfaAr5ISmQPZkClVARdULvYTjBWSthVy6x++vv0oD818?=
 =?us-ascii?Q?4N6GnHZzXb4yw7g7+tR8AUnlYCddBYR7z0pfLeznHDxGJ1G1JyAGDY1z8lw8?=
 =?us-ascii?Q?3HRZoVNVdIAvqlt5LcUyFT8yHZ9Eyb/V3+/3beXPVhKEvV6sHFz5PrPfyrRS?=
 =?us-ascii?Q?wVVfYu4GTU+2pkufGBCXPetc?=
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ee2735-2fb9-4085-7eef-08d93d3a90e9
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 09:19:59.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgJ9w2tEwclKpjI6kHuy4/kI1J6+QTB1145x1jCUZumrJ5yyJt58RGzWIrfrUlgc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB4707
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

pids_can_attach() should make sure the pids->counter not bigger
than pids->limit, so we should use pids_try_charge() here.

without the change:
root@test:/sys/fs/cgroup/test# cat pids.max
3
root@test:/sys/fs/cgroup/test# sleep 1000 &
[1] 3379
root@test:/sys/fs/cgroup/test# sleep 1000 &
[2] 3380
root@test:/sys/fs/cgroup/test# sleep 1000 &
[3] 3381
root@test:/sys/fs/cgroup/test# sleep 1000 &
[4] 3382
root@test:/sys/fs/cgroup/test# echo 3379 > cgroup.procs
root@test:/sys/fs/cgroup/test# echo 3380 > cgroup.procs
root@test:/sys/fs/cgroup/test# echo 3381 > cgroup.procs
root@test:/sys/fs/cgroup/test# echo 3382 > cgroup.procs
root@test:/sys/fs/cgroup/test# cat pids.max
3
root@test:/sys/fs/cgroup/test# cat pids.current
4
root@test:/sys/fs/cgroup/test# cat cgroup.procs
3379
3380
3381
3382
root@test:/sys/fs/cgroup/test#

with this change:
root@test:/sys/fs/cgroup/test# cat pids.current
3
root@test:/sys/fs/cgroup/test# cat pids.max
3
root@test:/sys/fs/cgroup/test# cat cgroup.procs
2614
3683
3684
root@test:/sys/fs/cgroup/test# sleep 10000 &
[5] 3733
root@test:/sys/fs/cgroup/test# echo 3733 > cgroup.procs
bash: echo: write error: Resource temporarily unavailable
root@test:/sys/fs/cgroup/test# cat cgroup.procs
2614
3683
3684
root@test:/sys/fs/cgroup/test# cat pids.current
3
root@test:/sys/fs/cgroup/test# dmesg |tail -n 1
[  863.612162] cgroup: attach rejected by pids controller in /test

Signed-off-by: Hui Su <suhui@zeku.com>
---
 kernel/cgroup/pids.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 511af87f685e..5e24990f28de 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -172,6 +172,7 @@ static int pids_can_attach(struct cgroup_taskset *tset)
 {
 	struct task_struct *task;
 	struct cgroup_subsys_state *dst_css;
+	int ret = 0;
 
 	cgroup_taskset_for_each(task, dst_css, tset) {
 		struct pids_cgroup *pids = css_pids(dst_css);
@@ -186,11 +187,17 @@ static int pids_can_attach(struct cgroup_taskset *tset)
 		old_css = task_css(task, pids_cgrp_id);
 		old_pids = css_pids(old_css);
 
-		pids_charge(pids, 1);
+		ret = pids_try_charge(pids, 1);
+		if (ret) {
+			pr_info("cgroup: attach rejected by pids controller in ");
+			pr_cont_cgroup_path(dst_css->cgroup);
+			pr_cont("\n");
+			break;
+		}
 		pids_uncharge(old_pids, 1);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void pids_cancel_attach(struct cgroup_taskset *tset)
-- 
2.25.1

