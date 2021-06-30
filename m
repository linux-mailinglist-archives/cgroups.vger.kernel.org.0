Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3727B3B8139
	for <lists+cgroups@lfdr.de>; Wed, 30 Jun 2021 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhF3LY1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Jun 2021 07:24:27 -0400
Received: from mail-eopbgr1300125.outbound.protection.outlook.com ([40.107.130.125]:39715
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233706AbhF3LY1 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 30 Jun 2021 07:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMmP+LJNTh3dM48QqdSNUsTBEE2ZRH5sxBlNLIS+5x4fQ4NJxd5m7L+7l90k+0zKh2rBIL2xWYt/ehVoEHZjFLKUfSlLYXaW4cAa0wl8nhsh8qB1kva9onOkfcCYe/JEvFx5xuMV6/KjAwswKjuUfOR0YrzKf5bYvmxEUF2ZdFY1ozlKV8jfyrS6XE1gpO8D5Skqbiu6LwdYDs79Yo/CVgI45fMcJ2hOiqtRplQuuplPnXySMvGJ79gEIcTvZGFuze3rYvr6gLGag8PWMOCeh2t0SpIOsKI7shmrcrU5/GHYZ6jbTYGXmmk/HBe5z7TadDsVybZv5NzT68QVImIXwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4A1xbMNMfs/THCNCt4kbEv5T6d8BiyHM+cW9TXku4w=;
 b=WtMVqSTZCAtT2dzdhXqJLt9HTidFfB+UeckBmWg3Y137DwQY4xd93wU+tzKaSCYIH2Yr/j6KRL/40JrnrJFjVKmtSpY1wnsTxXnbH18wZ4AuTloFoIYPg4w9F3T6lBhN21eCodhtR4QTrtjLEL0hfmyStG/Ui2nDvttXCvR8puPYpt+OokRm8JituiCDTV9egAz3EDZ3Ug7b0yR1OHDGMEw8Rw+8WmM/rESZCmAYC97B5oFI+hT3CgmdQUw505c0z/M/360H0tLBgPYLEFIVnqhttSzFiJt+ZzCW7Dklq8R0kIBvZSL8lTNRxk7WGCZkQLi8FbroJ8DzqA1SiQK1gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zeku.com; dmarc=pass action=none header.from=zeku.com;
 dkim=pass header.d=zeku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zeku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4A1xbMNMfs/THCNCt4kbEv5T6d8BiyHM+cW9TXku4w=;
 b=Djl3+E762yAHA7ADyKit8gdArKbylXmm5EayNakJvV+wSnSHxC/xse6WfIT63DZUtzzcDvD8EUeNU61kdsv6nln6FvirGkPv60VOpXqU8Pc+hoArpM9VBiWDhKdCLXxj6wM6wqwZHfwDwvNlg0QYNRFYIcpC9GsStoTrDVLgbO9NLlnMN/UK85Cncvh9d/RaoTv/oY7+2X3jAP4SNqCBOtVFrL0IpVekaBSGLcOFfNUMPxkQwouFPx0/u4uEE8rfxQlIEbsPEzuxopJe24gKQQhSVBZSK/R/l6rLntAhK4hdNF0gXsvIW0/MYGXX5XU15s0OH/vVrzD7VG7OtspksQ==
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=zeku.com;
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com (2603:1096:820:5a::11)
 by KL1PR0201MB2135.apcprd02.prod.outlook.com (2603:1096:802:4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Wed, 30 Jun
 2021 11:21:56 +0000
Received: from KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::9820:5a53:ccb4:31d]) by KL1PR02MB4788.apcprd02.prod.outlook.com
 ([fe80::9820:5a53:ccb4:31d%9]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 11:21:56 +0000
From:   Hui Su <suhui@zeku.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, suhui@zeku.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm/vmpressure: replace vmpressure_to_css() with vmpressure_to_memcg()
Date:   Wed, 30 Jun 2021 19:21:46 +0800
Message-Id: <20210630112146.455103-1-suhui@zeku.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.71]
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To KL1PR02MB4788.apcprd02.prod.outlook.com
 (2603:1096:820:5a::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.71) by HK0PR01CA0070.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 11:21:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24438c66-914d-45b8-b793-08d93bb944e8
X-MS-TrafficTypeDiagnostic: KL1PR0201MB2135:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <KL1PR0201MB21359F50C4F791F7CA77DB96C6019@KL1PR0201MB2135.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5OxrrxTIro8MhKh19clSr3X1uRfkyAPt2vIty0ZbXUvzWFTk8YjpSfVmC7WEfahHkaltkPHMtsMAV4k7o7eLe4jXzwniSOk+Oc8TeZaP0nds4ZHStSwTOimBF5SuIzC6YxanUj9cneNeu8t2uU72oQ/yPBOrAQ57CtKcJxWXD5OLUEi+PzkrP7DQRyvkxDvJMsqg8mFTjtNhdymEexkbmAbe9QaIDXZcuvykNh0qohcPgCHLcO4HiEIYuPR+BzCdQ5yygfFjlqJQGx/+EVzPV0KjFRAR+iqhr781TagTuM9GtgqhFwr4natYI21Dn8gmc5bZ/uXI0X2PaJqwPPQtnpziyxUMAUfaoKRhn4l9q5fI8Q++T7rUyj5jIlbzO1dSQQMWpYhAr5ykV31N/OG+dNepX+nXLaOHbW5DBcSDyHbFQHiDYjmyQ8eTDYHqSbNMLAF8XKV2/JNXfvLXF/t+trgeC6qu7r1RMBj98iEVfMwwWQ2fgqsNiAlntgpQmbylb9QAqYwQj+Yv08VWIXQAMhCUlnLDqu9Lhkx87sVK9lkgfrbUphay7xw56eb6H+MJdsTF+eR96WNeMh3Y9viwfLrCBfO03eS028tsrc6o5EK27eYxujA5JyZoUtwfYL1eRCI655EBLtYO1Q1oN0BArPaOs35SQDUxHdVtimNU9jKUD4p2bOV7U4xYftTO6hmNaSxTgcKDsmdcZZknGYUhbpBV+hLsd6H6enshKOIaNPNAQFAR4fylriAZJebGiROM0DSChJp0WcJTDN4ncZplQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB4788.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(396003)(136003)(366004)(376002)(66556008)(5660300002)(1076003)(66476007)(6506007)(38350700002)(26005)(8676002)(36756003)(66946007)(6486002)(316002)(38100700002)(6666004)(2906002)(52116002)(86362001)(83380400001)(6512007)(2616005)(186003)(956004)(478600001)(8936002)(16526019)(69590400013)(11606007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tNIrBlgILuKb0WE1/hFLMtFEFnLAck5ZVh57yvljs2F0hx+arTFXqHWSQHAR?=
 =?us-ascii?Q?LgWj0BHpL31am+dVnFLGiExaBbqHrBUCCPA4m+9hyVqIEDH2s3Dy8WyRghm8?=
 =?us-ascii?Q?W8McL4CVo1Z86Ov1GefQsCeUmPspRDi/B/FulfwgmDKi+r7ck0d7uni0KOCx?=
 =?us-ascii?Q?mLNILfXF5BoDv8RsIzIMZ3mgfOkR+4KhRjg9XzMkmzzTLOyk3lpI8yESE+wn?=
 =?us-ascii?Q?WudQ3m1RxQFQole+YovqRzeyMA0yXT2nKu+DZLOc6CZU9a6TV722c2y69syL?=
 =?us-ascii?Q?ec0JtVg8pndouNSTBmQzb3hbnvi6+yCTovFVXhRFl3mrTw81yvDn/BXdp1a6?=
 =?us-ascii?Q?YhdhrZ0liqGbAkuFi1CvcaWsvODvjAHFVP2A0LbfZ2KLKP9Rb+PpyTd2aoer?=
 =?us-ascii?Q?m1rsuykdkF+yM0v0xBbutNHBopaaqJaeb4VTP5288g636Hf08exOkKoCfMPj?=
 =?us-ascii?Q?mRUTcuJxHgm2PE1P0wLd5Unkb16bKpyI7YAiHFXMdtB9VyZjOqkaJ+x8Xw1Z?=
 =?us-ascii?Q?VMJLD3vW8QTLikZh0he13+UKKWOTWNl9jFXudtpsauXZzPHHMU3bM09MP4XE?=
 =?us-ascii?Q?46/52JgO2RI6uReu/Dn6Ed7cy2Z/1ygZrH+RKqvI3gVZPqxs/tBOHui7vkP8?=
 =?us-ascii?Q?xRYwBxg6eaWTTYfi91iB6aXi9GSuXaTproiTbELWOwcC/sETpHRJJn6MWcWX?=
 =?us-ascii?Q?gAmYA5GFgKxAnBOgbvSnN12ygANyELxb3jAR8xKZxZHzJCxDkr25g3kZSOri?=
 =?us-ascii?Q?DdAYd98d3yfbcmvE8or2GSHt8smMxj4ngLDtoV420yhMwaQ7/qTnm3hW+6zq?=
 =?us-ascii?Q?ZNdnTME3b247875Jsom8F5csED6ygntBC0eL84lJazu93PX2SscUw5fzDQLG?=
 =?us-ascii?Q?S3sfgLsMPlhHUjD9hetogOLnmvjR8QruTm+aIgReZ4QmrYF4fRxMj/F55WRb?=
 =?us-ascii?Q?WQTYWGkaNIicH3CTtVFNHVCpuuB/oCDdJ2q3LtUScYEQFd3lAAKQLrjUoBkW?=
 =?us-ascii?Q?b9FfBw+SWjIjvl0Rxs7VTGFwoVhNeE8hmSZymX5nTLpHCvX0TETNLVlADi5D?=
 =?us-ascii?Q?CjgBjg3Rx4WwIbyhbTD8IWQWuXeKB7SjcgmhdDhDaxa0bJ0T+tG6+JvHoHLe?=
 =?us-ascii?Q?46sywCCV8beYWmN0pyJ61S02F7uukacX+LxdtJ+3AWA0q7DDxaDvUEoPN4wq?=
 =?us-ascii?Q?ZsYso1aQe7LTG1LExmgEPTJ1BIqzwVaXWi9LLs5gHML4lx8tP1vzkVoWLAYo?=
 =?us-ascii?Q?kATe/vVCLXf2KFXCsGwd96JNvucD8rra5WTWsn2mPpP6RSSiguELgCRgBYK5?=
 =?us-ascii?Q?iiOOoRm6HKtaw6egyVJcP6g2?=
X-OriginatorOrg: zeku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24438c66-914d-45b8-b793-08d93bb944e8
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB4788.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 11:21:56.2349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 171aedba-f024-43df-bc82-290d40e185ac
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYe+lnRAemnaAW09ySU9x9NLPft3FLJHWh1E8gRWuvzDqJ3SRSNvl2Nplz07J2Fw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0201MB2135
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We can get memcg directly form vmpr instead of vmpr->memcg->css->memcg,
so add a new func helper vmpressure_to_memcg().
And no code will use vmpressure_to_css(), so delete it.

Signed-off-by: Hui Su <suhui@zeku.com>
---
 include/linux/vmpressure.h | 2 +-
 mm/memcontrol.c            | 4 ++--
 mm/vmpressure.c            | 3 +--
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/linux/vmpressure.h b/include/linux/vmpressure.h
index 6d28bc433c1c..6a2f51ebbfd3 100644
--- a/include/linux/vmpressure.h
+++ b/include/linux/vmpressure.h
@@ -37,7 +37,7 @@ extern void vmpressure_prio(gfp_t gfp, struct mem_cgroup *memcg, int prio);
 extern void vmpressure_init(struct vmpressure *vmpr);
 extern void vmpressure_cleanup(struct vmpressure *vmpr);
 extern struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg);
-extern struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr);
+extern struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr);
 extern int vmpressure_register_event(struct mem_cgroup *memcg,
 				     struct eventfd_ctx *eventfd,
 				     const char *args);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 64ada9e650a5..62163a9cee63 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -247,9 +247,9 @@ struct vmpressure *memcg_to_vmpressure(struct mem_cgroup *memcg)
 	return &memcg->vmpressure;
 }
 
-struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
+struct mem_cgroup *vmpressure_to_memcg(struct vmpressure *vmpr)
 {
-	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
+	return container_of(vmpr, struct mem_cgroup, vmpressure);
 }
 
 #ifdef CONFIG_MEMCG_KMEM
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index d69019fc3789..04e81ac6d5d8 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -74,8 +74,7 @@ static struct vmpressure *work_to_vmpressure(struct work_struct *work)
 
 static struct vmpressure *vmpressure_parent(struct vmpressure *vmpr)
 {
-	struct cgroup_subsys_state *css = vmpressure_to_css(vmpr);
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct mem_cgroup *memcg = vmpressure_to_memcg(vmpr);
 
 	memcg = parent_mem_cgroup(memcg);
 	if (!memcg)
-- 
2.25.1

