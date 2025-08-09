Return-Path: <cgroups+bounces-9054-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4C3B1F4E1
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 16:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106D93A7B1E
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0BF2BD598;
	Sat,  9 Aug 2025 14:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ewrkiywE"
X-Original-To: cgroups@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012044.outbound.protection.outlook.com [40.107.75.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E36237163;
	Sat,  9 Aug 2025 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754748856; cv=fail; b=AWTbvrJoP5cKD3yunxsV+ROTdOixK5/cJujOj0pH5zB+9NmjiAtdiIKOAYYKvJYIfYslm6IJ9tu+Ijji+jMy+Z0CyF52eJFPZtrl4R5ll50Db+V0smceD4rtOSG5HL/Ictc9zdU1jqUJYL7tZ1qboGojJbjVuyFOm2kT5pA+kyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754748856; c=relaxed/simple;
	bh=+fxGJ7pANNC6OQpHqZWszzn1V+QKvU++LeIWJZIQuSE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nTeCqLtSEuMzCCaGlFI0zfgHR0s64Whhv8+rRmkt+uDV4QXbALEcTJSHKJ73/3SbfKCYpy4SVHeXLiJw6vQKk6wds05DjP0sLd7EThzYv6yp7qsUeRpcFo7Qc6YobGB8/zzaCMgoHHm/qq8dlGq1oGc4IvdM2yrECZndCWRVFsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ewrkiywE; arc=fail smtp.client-ip=40.107.75.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/KuZc1LpahPsbrmwq3TD3CAg0qiLWycXgO6v44jnWcr6dfBKJTigWtaI+JL9mzjWGiwIh5uuLROEPB5FCQJVgN5FgOwM4VuHYRFCotBVtnYbFnHCi8CxdBAgEuw5uLOKOgdHSc9VZeJ97+8/lgf3hmW3Jyo54shhI+IdJyXsHvN1obvtBIfCQOSbLXLpxPJ/Ah6FDOeeSQt0XG+0Xxp+GNktFGRd3nbN0vQ4GOuFBjp7H53wiEmnEjmo3Qq9Zn5ACj06VQfNMkVQ8Zy6EOS2JBi6pr3gdIicp282V/TvMZdfvR5PrRexTSvBRyeTxI+YTG60ipj7ZCNHyy2iGxhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDPaQ5OXRYWeVnZCuZcINXul0l0GFcriC03mVkaD37g=;
 b=W+b/on3qmXjhBmkFmddMP6kGnb5z7HCgO6EVJYakJ7xYZvhxZtyo0rvKoUbNDre7wvBs7GTlJv7Aicz/vsWSpz252PIZTmswP9OuIAL3H8kx254EpxRR4QeG2DlFcAmziozQZf7APPZt7uYTFNlDQwPjLJ/zYa7/fzzoige8RhitKgy607JPlPpn+yX2uskDulps5lhtx1xm/a4DX5sR5FXjZ5caqlMLp0f3asJlyArytoiMoNFz5yRFdecxnUOtD2Ld7b1+9I2PAqflaWgIVrhvOtKMqMMt+IlR0GGx0TZX1aqMNd/ghtJH805iSdaJtrNH9e1u9ad3Gr0F5EbBLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDPaQ5OXRYWeVnZCuZcINXul0l0GFcriC03mVkaD37g=;
 b=ewrkiywEXG1RtBcxTqi9Jh3//ZLNV3R5bZu+zr5l9rX4rJDRRS76HrAIG9sl0Ez4BqCjzI3PXkshQs0RH4nj0YnWq/tCYTiRyvOxdqX+eh0XsBTAjMpIlswTVVXhL/T+2dvWGKAuhcCu592XLSwfP8CGNVeUKNN/FdOcoKyBgyitsGGHRLx0vWeTz0O+56lzmfMjPRd9c5Sx+njbSWOfMYfYtBW+fmqVxLuLGMonGssI8cxZZMl1kSvu+NtFQiMfZbfJAoCbB5Gs9k4QzLZWXJjqN36HX467YYTgJP+K/wtOG6FBapVRW/8GUIx8qnPMCZCwzvjJ3kR1zfZ99nnYlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYZPR06MB5760.apcprd06.prod.outlook.com (2603:1096:400:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Sat, 9 Aug
 2025 14:14:10 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 14:14:09 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] blk-cgroup: remove redundant __GFP_NOWARN
Date: Sat,  9 Aug 2025 22:13:58 +0800
Message-Id: <20250809141358.168781-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYZPR06MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: aacda000-0acf-48a3-c036-08ddd74f0245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lCepRXuZcQeaUsqvEaM81WtDxc9TKJciLEbqqAWTEOXWmzQeor0QzxRw6G5f?=
 =?us-ascii?Q?2nhE2DSeLTPsYgny2lM/fDbkGjGTJOfUx9ddXAwVMq5rGYL2I6GPMlhxasFo?=
 =?us-ascii?Q?fuHjKspoySJHkG0i+ev6IlZyn/zl4CT1WJcKU23bpnsuiPrlNwXdGCP8WIr0?=
 =?us-ascii?Q?vWLFjehD/+lRTZwXXX/Ny4zV1jn3+wSSkMEX0pxZjPjt2ncmjdszNOhzSHMi?=
 =?us-ascii?Q?OzrITTa+nvzRE78tapRtIYBgg9w5b6XahuZqC2Km6mHD48vdzi2EQGaS7uI9?=
 =?us-ascii?Q?syfhm5hSluAadB2WARIHeZTiX3xfJxHA+iWnQiVq90rZnOcyxoB2pxMjNFyq?=
 =?us-ascii?Q?rPRfbzTqTmaAIXoM+gWfNMoOQlQ+3dUOjdbJTxpvr9pCp7EaY6kqrsH3thdM?=
 =?us-ascii?Q?SWfA9RkoziPpW770KPbiWNHNT92UV0dJ/L1Bqyojf4IXXgImJtpr5iPcpZgr?=
 =?us-ascii?Q?qMMaUlZxYwJ1pw+t09GaG40O7fcp1mfwcs4NcJjHDIiIPkzGttE4RxdDBd6o?=
 =?us-ascii?Q?yrzuZltyp8wwo68PkHiiSpCp5gskbrtQHkxqKHuB5SzDWqpOnXZ+l+hhW5cF?=
 =?us-ascii?Q?V+yI8L2k1J/SKhbKQ7g7Hcq/m83+/pgbceM6foQ6HnXjV6GUbAhyi8NT8zOX?=
 =?us-ascii?Q?tDwRQ2550ZcXrgK06elIJ3WlW/JUM8XAfUuFo4R5ndTVwxZuBC6saPL34ALx?=
 =?us-ascii?Q?/1/x4pXru0+8LJwO9y2aXN6x2mZw9/ABFsmlCg0vOBcHGdB86/BXSXeoYZk0?=
 =?us-ascii?Q?8f3Oq/inRjtqYaXQXYw0qAQZIAyTN6hgpIHQJKBsGZKYVgyTXCTtHAlKmCIa?=
 =?us-ascii?Q?ekGTnOb1WMlrK182CZZpLmPyJU0DJ+y2g7udWyQ0hYRmo5DIhSmC2NU7Uxx0?=
 =?us-ascii?Q?3IFV5Omye5twTXr39pFMcx0ESJa/gKmcq7AbEM4efSQD6TiDRxmGPQH8OH2n?=
 =?us-ascii?Q?xIjEqDVnjSjKthi0JGlsA36yOmGeSxqI8w/wHlqOIF++GV2Jc3uaWvvX49vf?=
 =?us-ascii?Q?b3iyLRfzJzioDT7YWA/pPo+0a+a3SehfIlX17jgKrcjds7bsmAc+XtcdjZd3?=
 =?us-ascii?Q?a35Wc9Bcj4tyKlocA5mBrFTB4ZkEP2E+QUmMQMN+TaU/TVJqSrnXouVHdr2+?=
 =?us-ascii?Q?qumv+R0xSCQxdnETZc9i1CI697vso6DFPmg3pu3PoxdVEiN4INngd+Pkk/Fi?=
 =?us-ascii?Q?2xkXIYKyCk3hvKpgjfXsIbqQ1YKlu4UFhQUJHyPlAXPQsQbXKrYipPp0BMYB?=
 =?us-ascii?Q?1P7m8w7VlfsgAfLxTKqGNlFpp5ObfON5wQ19elgcDiKG1/jqYq29UBl5cpvQ?=
 =?us-ascii?Q?v9+l1Gy3St2drkh7nLrOm4VIizLpqp63+FlzIHDr3w5TFLVMnNdUJK41PP3k?=
 =?us-ascii?Q?WuhjAB+V9cCvTjjMg/rBoBRljvag3gjggcaVFMbGb1OmN8QvBjAsrAoTh4ZI?=
 =?us-ascii?Q?cjLGLAw0CNAjgYpjHrtUvEsa23Iz4KsrOod/ARR3pRpqYLwieWaHjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwMlYDVJAMSRD7MW+VCf4tjKbZztV0nIJ8wWAWLnQRo/57dk7NpDDVzyvESc?=
 =?us-ascii?Q?fxwP5zdAu1PmLIhtY3QqgBXsAQYc5nTW2BpZg5CzWki9TltBAVIdOQ0owWus?=
 =?us-ascii?Q?BnCVEGSH586W7R+thBTkN5+ypddSTfM8Y69f/WZdaYHPJ56QxedZ+paYjj0h?=
 =?us-ascii?Q?0gm842Tg/soQYvUGsxRg22F+HzYMQRcjI2Fx9Xr0F6dRBco+/6aAOhKhvcG7?=
 =?us-ascii?Q?KOWns44J1+Du9uqnoAi+GjD7wIUOfa25iRvfj19B+6cYAYmmXGd2dBCOHAAQ?=
 =?us-ascii?Q?4Me6h3A29WC83JB/GQZ+dFncuY636+581iRLBL5n8p4PMAfjxJDpV9FndY9t?=
 =?us-ascii?Q?H/ZECp4YAhYEvCw7Phip0Ae15lr7PFRwqC6pUZpDpeFKWF5Pd6h3PTsnd7Hz?=
 =?us-ascii?Q?xZp0ouh3iqSQ5iAss2rXyby3G8tZSJkJ4vz9f+7RO2kwijkntd1OVb98UnCy?=
 =?us-ascii?Q?OXwxMwzjvYNV6SPQKWSpoNzoJw61exjWqTfCzb6FXZUnymE0P80j4t+vDsOn?=
 =?us-ascii?Q?wIaTzzjGb0jg5r4qlsjVo+d5Jdo0YU4bfjO9D8L9PfHOMBYtVvN3D72wsZtg?=
 =?us-ascii?Q?0E1OMj7LnNYOJYDofi1ovJauTk0dafRhVzn1QEkjUrMNjhCdy/T5mwsMXu/t?=
 =?us-ascii?Q?yCod2pxNFDq+wfpxXPq3qMlcjzNT+vvHikrjxGygrlBTlcXMvm8xI4UjbvvH?=
 =?us-ascii?Q?xcukOOtYMKO47ilD2ANzy8p4tfGuFlhkeyVnj2tH66L9pq7BtDbvrWz6XzWy?=
 =?us-ascii?Q?3FZNpM1VYhPtbq+/0llb9fn2OACGWrWcGlMX+y/NMMGshd0ZPGez5V0WVM94?=
 =?us-ascii?Q?znQr49ItNRTj9bz+cBeY6W5K2rDRXCfGx4pTb4RCE16bflKBP97maik+EhI/?=
 =?us-ascii?Q?dE3qAn0urj3HhY4d2mNL1uCOl3mHMTG6+vGwpWa7Xq5jn5OC/Ajxj2BOioG1?=
 =?us-ascii?Q?GVYs2yZRqQkcv44FDM24igKqNl88d25uaKCuqV+tfhjV8WmCtWJlIKuWhGh1?=
 =?us-ascii?Q?RLFwsobxfzV9WwK5RiWXWVhYQmUBydTQ9N3NrKYQYOyvAQJ7G2WYLuIF+4H/?=
 =?us-ascii?Q?1GkQRy0/KfJ0d7mzrj840PsZMe5omiAoXg750Cn7tIHWt71XMwH0p2j5E9rK?=
 =?us-ascii?Q?nKSj94x19lsFO9Qoksks4byk+3QTHGCC/OzXOpDAWSiuYqhNsznVYqx2Cz9C?=
 =?us-ascii?Q?Dn1x+GTEsY/rmZlU5ryJhyB/4Fs0DinhdDQ83t8GSjXZFW8BtSKI3lt5d4vO?=
 =?us-ascii?Q?9D6C60Sub/LkPqiLr136XU14Aq4ECh0QzZnJw5EPDGtz3qzQtR4bKjtIAU/O?=
 =?us-ascii?Q?5maA6hR7H+Fg+i33RWZ4g32J3YkY5HGp6a03O5JxqcJNqnukY+wUbueU0Ip1?=
 =?us-ascii?Q?v/wXzqi/gAyDsvsuG1NDRunOAFpu6n7YTX63DNLoesYQfy560aj9JzhnD57D?=
 =?us-ascii?Q?dFks+oCXP/8g6IHePahsCmE42RzsSB1tGIzUY4RPBQ68iO3fIt6dKcftj2Ae?=
 =?us-ascii?Q?DtoXJhCctSxUghqgnNGhCvZPtNKZ+N9mu0ZyXP1pBOi/n4oGSzcDPdet9mmP?=
 =?us-ascii?Q?wd6RVG7LIA+ICQ3lGZcYekyuLaY8L0hJ9SQiyivW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacda000-0acf-48a3-c036-08ddd74f0245
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 14:14:09.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zn870aMPRm5IMvPDMUOKLFmvyUOLr93UQJdowP7nC8lBxB2FZY+Ycuk6Vfo7X2gu+2srEPX3xuOBBtQFFB+tag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5760

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
`GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
redundant flags across subsystems.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 block/blk-cgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5936db7f8475..fe9ebd6a2e14 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -394,7 +394,7 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
 
 	/* allocate */
 	if (!new_blkg) {
-		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT | __GFP_NOWARN);
+		new_blkg = blkg_alloc(blkcg, disk, GFP_NOWAIT);
 		if (unlikely(!new_blkg)) {
 			ret = -ENOMEM;
 			goto err_put_css;
@@ -1467,7 +1467,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 
 	spin_lock_init(&blkcg->lock);
 	refcount_set(&blkcg->online_pin, 1);
-	INIT_RADIX_TREE(&blkcg->blkg_tree, GFP_NOWAIT | __GFP_NOWARN);
+	INIT_RADIX_TREE(&blkcg->blkg_tree, GFP_NOWAIT);
 	INIT_HLIST_HEAD(&blkcg->blkg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&blkcg->cgwb_list);
@@ -1630,7 +1630,7 @@ int blkcg_activate_policy(struct gendisk *disk, const struct blkcg_policy *pol)
 			pd_prealloc = NULL;
 		} else {
 			pd = pol->pd_alloc_fn(disk, blkg->blkcg,
-					      GFP_NOWAIT | __GFP_NOWARN);
+					      GFP_NOWAIT);
 		}
 
 		if (!pd) {
-- 
2.34.1


