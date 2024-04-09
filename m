Return-Path: <cgroups+bounces-2377-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61C089D04F
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 04:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFAA1C22445
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 02:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079DB4F1FA;
	Tue,  9 Apr 2024 02:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="WUrPzTga"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29024F1E2;
	Tue,  9 Apr 2024 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629126; cv=fail; b=Zb3xx2fNiPxb3NDDL0Q8VCZq1LssLpIXojA+Lg61jzX+uRdXVqm7qupeS+RfrVB1RJspP4zASnE79Dw254NG5kIWz5681DRQ04rl8yMUrlYrSwAv08MYvfmB4v6Drdl6Tnk6/jNazzswRJ3y6pIDJHDwrRZWCEWqKcj2SkzisSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629126; c=relaxed/simple;
	bh=/akjc4y9ytdphyKCvW29tZbGc9YRjakTrr5W1rScfWU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jftv1yg5kDUhOF/4majLvnlQK2Flev/pV4+nwk8eQ4+naPviQXVSY/D9GZ1PUW8TEa8ZGNZ2mU8oOLxfA3M3OHzMmIcc+jpIAOTWtq37A1WAu9qffBWjAAafTJzVGDyMOMpO1kv8qisHWhxoTA/DAkmFuKc3gLqSnJ+eb3o8WEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=WUrPzTga; arc=fail smtp.client-ip=40.107.215.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/1HpYijZv/mtcQPbeIJl7g18zQmPQp84rldJL6sl2KB9Q73+1QooTw9gbNbrMn2JlJ78o+IsMzGbjFHJp9K8ntW64xwIgXb+6pUiTQbxYMBS7LBcHI1xcUNEFIX00Bw1ywjZLMbLPBtiIR9h4UA+bhtqqryHu+2bjNsqw9sEOAoDe+bybiLCLiT/+Jd62TWyUXs8Xij12caXxsz3sdG8a483AIF6B+UbazCkPhATMJvcQGTEtT9ZsKYcNuxDl6aL/p5nbKUyRAVDhKRiFcgUn1x4OA+Cr/1XrOKiQUqUNTit3f3sJodNHSWaHs6cxXNqMAsPV99DXNTtFJ6/UtdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnmwn/8wQlF3HJ5yklbH3JetP5U6ZyryDt3eiJXh4BU=;
 b=UGAM4OcW8l2WpkFHNHa4bimXX3Ipe/5wFsyKSFKZlRFWjEW6hneqb+YB+VntOc4F9Ovgyr8DBPC6ogJm2T7ygtu6EL1b94Uyp1lgUptU8BSPZT+5byRKtpPqB8b5E83U6oDDplVoyzdTyxXmCRRVwwSKZ9JdsUNh+spK2ZZIv6PFLWoALDTW9mDXKjAgpC9iI/Z5d9nfdEBRs84BWG2H5ZVw4PeZU/RnxdC98xqjBWAGte0C1lvCy2/6qjfHOVgFr20Ypi+ezKdxlTm95O89/eqef+CpF+g4Nj6DvG1+8PEW6lNxdj8bqStQcuf10uD2bD1d09WfT5rzl9m+Aj0b5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnmwn/8wQlF3HJ5yklbH3JetP5U6ZyryDt3eiJXh4BU=;
 b=WUrPzTgaL8OdAc+nrrXqsTs/HZaSAyHZLqxRyBoI6CfJMR43OX86ir18Vu5stkKZwRi8V8pvSqgIt/plt8wzW1gD0gbNvwoxyB5LrKKFmHImvV+AgdrCZUSwU+5us1hiu+C32WG22S3qN3l1uXzIEbvEH2Pp2WHAt3+XR3oxliGQqxnSYdQFzK71T/96yi9UU9/iW0dWYtmzw+KeIZU3NKO5rqoMNS1qH+pFh5ZzQChHxphwZe3quCog8/6GZkmEUIcvNmHoa0leEv9QDAzL4VYwKwI/AMr7TlcbR7HQ7+zmz27OrbNbfKeiXSlzzLMiC2cfPnNjHz5QnFua1H8K5g==
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by JH0PR06MB6677.apcprd06.prod.outlook.com (2603:1096:990:31::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 02:18:41 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::ad3:f48a:aa04:e11a]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::ad3:f48a:aa04:e11a%7]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 02:18:41 +0000
From: Huan Yang <link@vivo.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH] cgroup: make cgroups info more readable
Date: Tue,  9 Apr 2024 10:18:26 +0800
Message-Id: <20240409021826.1171921-1-link@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|JH0PR06MB6677:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zwxnDYPURwEeJeBFRXKasRvJT3ynweFe50alBkjLWj+PTKdcHP9uqQ/UAoXOlebOl10haBig3MWaFBGDjehLFRiHjP9REnXofuIXVeHzX4Mpzcn4yekhLLdNzscVwszc9BMy2vI/f4VrVYJhz2O30ZRBGW/QMnAMUGQyU5+DLrzZbQ15AMBScTlosjqZnt1VNxAER+jAoF2Zyh/ssT2O9OEv4+t6CGc6xmcTAtd2sLL4F0/fBJjMPIChZEiaEEb6apSQB8sEqP7+FOHsdNM69QlWcA6WnKijCgtlGfFgVkikj3y6DfNMe8Owh+M5zspb2ryHnkziPdYFpuvTDqiSmOCZSrOAUTGMzXPnVVr7wof84MepKX4EQVIRL4FeWbDBSoE+I0ADlt41UxRokM6I4IECL+fZyJU/MQet40KTuLguV268ZuazN3rHuPunp4EbZoJidiRuU0hrLSzioyM64yJ4XMCdm26Gd50LBR8RP/1lcnBPjuCIX/HtlqYmO7MM4Dm97RtbHZC5/NabNoWaJjoupQXXMiX9albV1uXMSyqVHennq+A/3ggAA+hy5i5F7/diU+zLXJ1ltMTbFsJr55yNGVnxZm3B4o9wi4qFCB609z8fYuDCuZcwD/69QKTC8++lTRe059BOwgLC1mxCRIN1hng3uiq0b/tgVUU4r6Ik8+57I+C7IDJRNIosfgv4DIi6wgAro180Gd7hCFmu9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fjtw0NL2jyv/BEyj+iqDC1gDxxxP8f80CpE0unTGgnf2IxeCtEy4obxvJWHG?=
 =?us-ascii?Q?wpzJ8cS5W6d6l8Smknow8uX2V5lGu6liQ6qAv/4dE/WTuo9m4BqnxDJRBiPB?=
 =?us-ascii?Q?El+OJuV5wmNWi2GlJ3lFHNSejYTwnf7L1deXRONCdmPglMeEzRFzmU7WxBGI?=
 =?us-ascii?Q?TY6YWPFHp9tJcvXhMHC0eKNzQd5B0ND7uPAoStFwx0gOqa/rOdBLWdjhwR12?=
 =?us-ascii?Q?8oJGYHgy1xNmgoknrpDba/YYOuZK0ttmMNd4sERnpI5B/kLGFzurcn0X7zQn?=
 =?us-ascii?Q?Ox+QrvuMHc0m7KLKQkcDWy53EoicgCQOuZtKy9cVIgwCmds9cdT8mmPBtXCF?=
 =?us-ascii?Q?ZlYV2qvNr+iPDyH/Qd7zrfagLzrcjZ7Vp7cyVTRbjDi4oK41sHoEf+R/4VsJ?=
 =?us-ascii?Q?FMtwExrr/hMR+X069OQFftUKNip5oQqM+9B/W12xlzd4mpsr+/a2dzBU+NX/?=
 =?us-ascii?Q?XFe+sDmF2exVSZtCEN0hB3TEJpa6xgg7Kutue9DdiDlOGNecCBaIjHcPNJfU?=
 =?us-ascii?Q?Vr9g8riFxIzHsaSNEI8mAoYfWas9LqJt7LbTgNgr68Lua7Szml+dYHSVrGSX?=
 =?us-ascii?Q?+VjZ8+tHfru5k1gPDtnYYhQ+gZ0PtNDLa8m/TToJ7o2IhTxMrn43WDDay6ue?=
 =?us-ascii?Q?OHedZ97YSICVwM1uMToTKdzDChruIFIUfCTgB89PaXPwUYKXGlXdoZBLLgTM?=
 =?us-ascii?Q?kLTP5Kt47NjuzDNUAPH9pS2RPig69xB5UV2J8uisGBEIF5MDsNbCtKZ4uam4?=
 =?us-ascii?Q?neByHJwdL8prKBTPzboU+f66aBC3rEMrHluOjAiJ36eljoOwcSHcCsC3e+Ew?=
 =?us-ascii?Q?VrsTTjxElyOSMsRoC8fE2fTZgSNagrKPIMr/J+3GcY+BGRCEbd5WBdUjJiis?=
 =?us-ascii?Q?Nu81K1mSjTnQiUTFWD5ZjPYwkwFHE1VXHL1iXtvcPzCps5e43mrm82zNKHBj?=
 =?us-ascii?Q?sFyyjhieA9KgSHv6y0s2K1GdjCyUvimFir/qPOVg+f18S9oti4Vu+R5uBY7V?=
 =?us-ascii?Q?zO5QD9wkshKbj71KvSkMzEICIjjC/E/O70LwyWo5dGb4Xg/R0Zs5jZUJwdSH?=
 =?us-ascii?Q?1rY6eJnWbfNP0iK/BZGbj2ZxHw8hDcFr6guj2Tcmcp845Gvtam32j2Ovc7qo?=
 =?us-ascii?Q?sQ811EdGP/wsto6p4gBxuLsiYZcvoO1qCy4SlB8MjKqoqOshB8nZIfmAKePJ?=
 =?us-ascii?Q?g8siySv+0Z8PuzLO/hGczoKMtQP+u4ueDEm1TwfWYRGhR4klqik2lWQO1art?=
 =?us-ascii?Q?/z+7RmPLvR7yesdPlLKdHSxbfwrYP0vlKySQmX1E1JpnvAoc6AxBVThsPLRT?=
 =?us-ascii?Q?bRN6ujKBfEhM4k0sydUp6RbuqnerMYo/KEEzQtOvJAatYnGrdFQL225HGBm0?=
 =?us-ascii?Q?d3BNvA2qAxL76WWOBQpxhcVUpS4f8DixlAayB4x2GH/OlGdQ6a8jckDj/lUl?=
 =?us-ascii?Q?lNpE6PXyL120HMYn1MB9bH54KrnOTfBESJKsxDzRw3jAul7re0NEj6MArH32?=
 =?us-ascii?Q?d0cANMyyMjDCymT8iKyf/ATdoiYi+jXfxqiB/Vs8poSMCIC5Hhhp1b1eX4tE?=
 =?us-ascii?Q?MNGGrqsBDvHyd/8HlUUPJiJwqiPeInhay7HJG9O4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e7db00-7045-4dba-ace3-08dc583b5f9b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 02:18:41.2040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r5pnZQo01KFrX8d25E2/XLNQxN0luL+C6G3wlxkWQmqQxtDnXRG0gKR/ttbo41EKw4lSdMxEP84xze6qlgllCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6677

The current cgroups output format is based on tabs, which
may cause misalignment of output information.

Using placeholder formatting can make the output information
more readable.

Signed-off-by: Huan Yang <link@vivo.com>
---
 kernel/cgroup/cgroup-v1.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 520a11cb12f4..c082a78f4c22 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -669,15 +669,16 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
 	struct cgroup_subsys *ss;
 	int i;
 
-	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
+	seq_printf(m, "%16s %16s %16s %16s\n", "#subsys_name", "hierarchy",
+		   "num_cgroups", "enabled");
 	/*
 	 * Grab the subsystems state racily. No need to add avenue to
 	 * cgroup_mutex contention.
 	 */
 
 	for_each_subsys(ss, i)
-		seq_printf(m, "%s\t%d\t%d\t%d\n",
-			   ss->legacy_name, ss->root->hierarchy_id,
+		seq_printf(m, "%16s %16d %16d %16d\n", ss->legacy_name,
+			   ss->root->hierarchy_id,
 			   atomic_read(&ss->root->nr_cgrps),
 			   cgroup_ssid_enabled(i));
 
-- 
2.34.1


