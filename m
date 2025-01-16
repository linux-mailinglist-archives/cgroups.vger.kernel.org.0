Return-Path: <cgroups+bounces-6194-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B6A13C13
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 15:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D52A3188B7AE
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F63822A7F6;
	Thu, 16 Jan 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="YWuBm8/d"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2045.outbound.protection.outlook.com [40.107.255.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFDD142900;
	Thu, 16 Jan 2025 14:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037462; cv=fail; b=KVWCiwJ69Fh0OPqu9x2ViL+kfM/RCjISjHGcFWzLJuLfWTZQeSOD0hpfAqqVNag+/2bjulMExcOf5H+pO/JVekhV5QzW/TMYsDtwiTxbNGv3OIXo3Wg+TCWCeFA90/wVkgQJXCBoyYzNt8FJ086o5EmgHyCwMHXKlbM0eI+8RN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037462; c=relaxed/simple;
	bh=i+d3XVi7iVBK7tYWSdWoZ/sikaAB8ZGRpiy4D/RZ2mI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NYmKMi8lRmiSjdX8eE5tZjUYnJMdpdnkugGsTyONrdGcOMT1aRdrGLcPmKDKAu4tCjY6G2x3wh/MKYU6CX5V9tyjXDl2FfHxUqFbcngEIJ0UN6W0ok2umRh3TS0qM6o6cw6vqFhEsb8b+IVRdXTiipczZzFP3w6ChcKh/6i+0Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=YWuBm8/d; arc=fail smtp.client-ip=40.107.255.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMf9RImoB+xOrT9nBuIl6pILzDMeT+a74iRSDU2MqJrT24Lb7jZeDZFjLrCXBYyUjxkY66KIANbtK6vNdR7olzmQmEeK1LLQmiSSYMbciWcX3B2+x5tlWorY8l7piGESTgGu67ZYPTBAAS1vOu3sC2K8UMTZyMvivT1ugT4lzhPD0hkh7RvPMq7LfGAmmXdnsUvKHr2qcn/dLMxizgXMfZOkDipXVKqkqYszdOCab8avyYimL/mcwpHMRYSSoKQ9Ok/LtCl1dNP56lytgg4K8ZKbyxO4STzXAfgRn9k59nslmVZpP3cgGtUH73Kuei9Blgv+m71HGxriOuMOBXGpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crrv/tOdc2eByuj1Fn39dy0uupovD94Fz5rUmvlwxDk=;
 b=y+JMLIjWefP8twaiJxbP/Qge2q45zwm7MVLG62ul8IO7Tvcr75F1bw5k18fVxTU9Brm/nP9dbltAVT/U9ZIyYEd5Vja5TiouJYhzLtp9569kPNCWN8y4+mIeuxHuWWc3bcLXzvanumyEmCxW+CJMWqsYt1Uy4zMR3yR1tSIQ1Wxeeo7PMFJGqPigcU+YqsKRglWmtuGpWcB6qH5sNCWzpD9hA3AT7vR9a+zMbMUwi2dcUUX+9MG5ir6XR7JCZhAuUQj24d0AxHhPtgZ6DIB+rhHbzzGve1qZkOx0wcP+5+t8K2c0kq9QE/ybKjJjzcL8rCarsOg13MfY4pNi2NW94Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crrv/tOdc2eByuj1Fn39dy0uupovD94Fz5rUmvlwxDk=;
 b=YWuBm8/d9c3/9gqDwGqeHAMvMqi7jMsmxS2BVnujy0ydDVlCNQOz/GqFzjXsSgZvpgLvhUA6aHxi91FT8g7+qtvoyNw+ztTM5h83vm8VSMKwB46A5j7AsuTfU3Q4Vd5gS/9ECxVA6vEWmcIL1Pg7FzB5Uwc4L1oWFjzwCYRSPT90mQtaCaxSZiEUtuciabgx8vQ5ukIeGvmMHF/zxvLnP1jLmPFzIJ1lUmfvQS6GLZngsBUj+Y2AoYUP8FXL7VnC4VUG9xBwV0MqkFmQ27J3LCkweZyHmakGagFgr9fiQFZR41Y7O54TAq7XOiNF5p/mSOIb3VJCo/c+17gHR3qE+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SI6PR06MB7101.apcprd06.prod.outlook.com (2603:1096:4:248::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.6; Thu, 16 Jan
 2025 14:24:16 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%6]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 14:24:16 +0000
From: Zhiguo Jiang <justinjiang@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Zhiguo Jiang <justinjiang@vivo.com>
Subject: [PATCH] mm: memcg supports freeing the specified zone's memory
Date: Thu, 16 Jan 2025 22:22:42 +0800
Message-ID: <20250116142242.615-1-justinjiang@vivo.com>
X-Mailer: git-send-email 2.41.0.windows.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SI6PR06MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 5032659f-4372-418b-6b64-08dd3639751d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1N+CB9aB4c6EyyYjhF7E8nz0W1RcWmTmolIWCdwOl7OWoE8Hq/3jVWFi8sqn?=
 =?us-ascii?Q?Nb31YMLXwDCKgbEHFW43Y++L2y6Qn5yBqBXYuVjmXX2/Kezgr7/VVJG2BrQ6?=
 =?us-ascii?Q?Y5sb9/0z5q6rgQGYkEnTVgQ8tpbjrhMMZ+c/WCT4Jenk1N6+teqt8uj0W6//?=
 =?us-ascii?Q?0tZaVYLGqi3wTRQlBScEeyUCS7ffVWADT08qv20RV/pDyQLgwsZIuSIYYiMO?=
 =?us-ascii?Q?ckZFvyqSd8afDxVpLnCy7Zuq1isPNSZmp1E10wb1NQDW4v85OvD2AY2f0nPN?=
 =?us-ascii?Q?80wTEJJSSZgWeptoQlIoMSRbdBSP3wxQUvTth/t2pWIdyWP++q88SHnrI4ek?=
 =?us-ascii?Q?N353YdFM/FQjzIRnnBi66EraUY+W+TuTCku3khhsXHyNkr4G89yJoykG+IjW?=
 =?us-ascii?Q?8OMjnPT5hi0LfufwkvQJfDcuURD9cl2S0OKmE/FCX6q1MEMPvuas7CHhS380?=
 =?us-ascii?Q?9si1vr2ZGD+sTuDTuKMAFVW//E491STmxgN8BSiOjRXkJsG1YBw/oRl/yDx5?=
 =?us-ascii?Q?LvS9SwpLp9g5mVLfsUhMqICeosCRk8zcIpZ8tvJkeoXER95zsJQRw+WEkA4H?=
 =?us-ascii?Q?BDVQ9Pr556vNIDLAB0yg9VBVoeyOKg7XdD5U9F8kvyM0txPwNU4GSpTQGj0X?=
 =?us-ascii?Q?hDAZdRs5i2KOI3i2SjY5fc9EdHhHx+crv4U7PLJ075WPijpxBEZrCEBEowv5?=
 =?us-ascii?Q?WeZNhqJ+n7MkQ36AP5wig41BlzVMLXRsoo36q5JJlYJK+/ZSo6mLvSjA9kM4?=
 =?us-ascii?Q?uW9ulWmIyl8OfLodlAwY6x6cNxEVqNh5ffXFuaSI0SXetITbq23C4nosLhrA?=
 =?us-ascii?Q?lPh80+/apqbJuFdGVJVmN0PUz5qUp2PfEq71Yc0CBZxq3sz+gdPJS+rwT80/?=
 =?us-ascii?Q?Za4qm9q9M7uZS4HUKnYj71V2jlGxDRC9G1ZTR1xzGpr8hdXTgh2vGXi76nCl?=
 =?us-ascii?Q?DPn9lRLg8Nb41X5ynKx/z80kH1S8iz/jwMqiLCfXd6v2WMPHAmKWRlsA8JFz?=
 =?us-ascii?Q?bj3bMaCWpyWYOltihRJajafvgH0ICq0lxi4HdBUiFKWUA0R5srf7K0DiogVm?=
 =?us-ascii?Q?sn8TkyK1ZksbpwB+4E0LtVaZATLay32ZX2ZFnEQCN/+ZSY2xwgJZatIThsdS?=
 =?us-ascii?Q?8bL+5RSbvCoWJm7HKmlZJodBNRuQezoD0dUlNedNWDfq04uu0203tD3HEDpL?=
 =?us-ascii?Q?d4o9TnggHP8gG7tejKZ14B6CsLVmMkwZHv71nZDca8Jdl0L3wwFpGNHEQVyn?=
 =?us-ascii?Q?mPH3gRMY8XWSJM6sSP/Z8KZKmLq0deNwW9G2cRCor6hG1/ocRHH0Gok6mDXz?=
 =?us-ascii?Q?oPYIJsIyd81RBqWtxwy1u+lRKvElxe0eyct5Ubn4+wfBi4ypD/0sY8ObFYu7?=
 =?us-ascii?Q?NFNDcRfm09fYm7778uxGkaCpIDlr6EPxj1vrOhFC8a1lDM3iHrke5HE34qYL?=
 =?us-ascii?Q?DVezZB4R94BxjC5r5hC2SvnUA+tuhw6L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FDZUYp4kchBVwLCpV+uZm56c6qwbMJWIc2PHXuCNNNC3DQpytHiwDwJsqG/O?=
 =?us-ascii?Q?K81d0YWoIP8FZyKBxWNB0JJhKnbwYjxbxXj9K70LNgvvwebQyjxAqRdcnb6N?=
 =?us-ascii?Q?+WB91e1/DZfdNU0zFsNYWoVaqNPbYKyjHV7n1t9AzM9cyErwAi3Rue8oYgd3?=
 =?us-ascii?Q?GedAytce9L83VeYoZM4McIT2J6QHEJQX66AyJfHJw1V2q2z25M6UagIDlfc3?=
 =?us-ascii?Q?1QT1JlZEbeuvo09c54kOctqKYIDBYb8yr3olwlc5ez/iu3r+T04fDhiBQXan?=
 =?us-ascii?Q?zA4KAxHibouKhFdcqGII7ny+WZpkyBnfaTyyVg7PxsuVv4fKoM9xNK9an39a?=
 =?us-ascii?Q?l5BwW6Poxe36IGqTzT0JJqRviSEocPE1Wlsk/49biYojwJm+wbiZq5rr8dr1?=
 =?us-ascii?Q?H16Sc/TbOlqP5kzxvjJK59O1FZfFujFVLPhkvgfS04gDwlTT6iRDwXwjNH93?=
 =?us-ascii?Q?I6z/fMiRk2h7yxhJwC+IQHhqIPY/nXVfIILLeuIf2Uzuvsz6iGKTrXR0r3Fi?=
 =?us-ascii?Q?0k5pqP8nIjDNva1cnWMKAjlf2DtMq/h7feT/jgQLRp5wNFdi+ZC/YEOX4h2C?=
 =?us-ascii?Q?oYxJOut+klZM6nxwUduzWAqhsX0XUn5p1voCqV1iNWBI0Rpz3Hd1NkDd6H23?=
 =?us-ascii?Q?C7xhqPdHoAy1gAIl2mOUbcEv3SRSlcQkEWTx6XQc0eXy66redPYZwkwzYLF4?=
 =?us-ascii?Q?xsUrTi7IDAowTEnP8TZQ7cbVhgSy2ZDIol673gNCUJS1gojMTvqvb2OK03x0?=
 =?us-ascii?Q?0BoqwPgkBAVazL6RYBF11XZWsX4h/0Bn1TYT7yhlvor44712JKVJHySM7TMb?=
 =?us-ascii?Q?WoSSrvxYBkIW67iR/CCwOz2XjcZqNJR/k/Rx7+KhMf3tJQ4LcONWDN3ShhhS?=
 =?us-ascii?Q?FYo5YOZBawifhK8v9iCdzrBtsJ9Yl+8+ZFx9ntwlh8NbyfoC+mqRKu7iRK4v?=
 =?us-ascii?Q?/QwDtIt0aE7TWuzfFE623ZRZURaKwwYzXdva6bgt3hcB+XRw6tOEkMKbgLNn?=
 =?us-ascii?Q?NmoImlbUpwZLYe8OzDVLq/TJ0dGXulgaGFwoEI072tBsNpqg5ZxkgyyPoqVR?=
 =?us-ascii?Q?DrcONAXEVIjZ9uSY4+QyOfMz+ARk2m1dFzFiMmyQ7IQ29sbaR3mhfuWjkty+?=
 =?us-ascii?Q?vmOLD2Madtp/Xso6BkQ/sOZJHv0T0Y/9hm7r+cN3dic3TrzI4MyM5EOnwnyK?=
 =?us-ascii?Q?8s3KNmY3OMHH3W6TrstixZDC3R1DCQrVlw3jz88pQWZ/jy9vTcniHP8mHJk+?=
 =?us-ascii?Q?e32MiH2QwlHF/xuQQZwLED2MdbfPUA/lpfT6Pcq9/d0/ynxHIBswasd6cZbE?=
 =?us-ascii?Q?LugmKLipMPFwMVbXCtisHAiyQWVmzTk40dTKl2YJuG283LZmlqCBKlzM/E6w?=
 =?us-ascii?Q?Z+NOBDhM+OmJGuJFR+2uW52JLFqmbBlgwCW+fiQNJUzmnEDTzoDCA/3RcP4L?=
 =?us-ascii?Q?huc66VN9NZsFvRIog/QAefxMEEiSGz5WozOZZnS7E2gYyxWq1VMLufw3OyTL?=
 =?us-ascii?Q?aVxEvDERNnDe7cb4P+0WLYdvo3rSOV4eRpPoUjO29X03+kvSnyhjGKQNLvhZ?=
 =?us-ascii?Q?3KbICBcn2F1nI0lqYLbVTpCiNmL63gdtCDI2G57N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5032659f-4372-418b-6b64-08dd3639751d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 14:24:16.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGQZoVSshmWSQXb5xDeIWucR5xQl7K+t8lB8yjkvmR1mPBQocwxdBR+VuCMPmmfvmV5IJkt5u3I6eAPjpHAKvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7101

Currently, the try_to_free_mem_cgroup_pages interface releases the
memory occupied by the memcg, which defaults to all zones in the system.
However, for multi zone systems, such as when there are both movable zone
and normal zone, it is not possible to release memory that is only in
the normal zone.

This patch is used to implement the try_to_free_mem_cgroup_pages interface
to support for releasing the specified zone's memory occupied by the
memcg in a multi zone systems, in order to optimize the memory usage of
multiple zones.

Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
---
 mm/memcontrol-v1.c |  4 ++--
 mm/memcontrol.c    | 11 ++++++-----
 mm/vmscan.c        |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 2be6b9112808..9dc398e9d5f9
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1377,7 +1377,7 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 			continue;
 		}
 
-		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_HIGHUSER_MOVABLE,
 				memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP, NULL)) {
 			ret = -EBUSY;
 			break;
@@ -1409,7 +1409,7 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
 		if (signal_pending(current))
 			return -EINTR;
 
-		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
+		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_HIGHUSER_MOVABLE,
 						  MEMCG_RECLAIM_MAY_SWAP, NULL))
 			nr_retries--;
 	}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46f8b372d212..e0b92edb2f3e
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1945,7 +1945,7 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 
 		psi_memstall_enter(&pflags);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
-							gfp_mask,
+							gfp_mask | __GFP_MOVABLE | __GFP_HIGHMEM,
 							MEMCG_RECLAIM_MAY_SWAP,
 							NULL);
 		psi_memstall_leave(&pflags);
@@ -2253,7 +2253,8 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	psi_memstall_enter(&pflags);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
-						    gfp_mask, reclaim_options, NULL);
+						    gfp_mask | __GFP_MOVABLE | __GFP_HIGHMEM,
+						    reclaim_options, NULL);
 	psi_memstall_leave(&pflags);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
@@ -4109,7 +4110,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		}
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL);
+					GFP_HIGHUSER_MOVABLE, MEMCG_RECLAIM_MAY_SWAP, NULL);
 
 		if (!reclaimed && !nr_retries--)
 			break;
@@ -4158,7 +4159,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 		if (nr_reclaims) {
 			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
-					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP, NULL))
+					GFP_HIGHUSER_MOVABLE, MEMCG_RECLAIM_MAY_SWAP, NULL))
 				nr_reclaims--;
 			continue;
 		}
@@ -4351,7 +4352,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			lru_add_drain_all();
 
 		reclaimed = try_to_free_mem_cgroup_pages(memcg,
-					batch_size, GFP_KERNEL,
+					batch_size, GFP_HIGHUSER_MOVABLE,
 					reclaim_options,
 					swappiness == -1 ? NULL : &swappiness);
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5b626b4f38af..9d198bc4e543
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6610,8 +6610,8 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
 		.proactive_swappiness = swappiness,
 		.gfp_mask = (current_gfp_context(gfp_mask) & GFP_RECLAIM_MASK) |
-				(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK),
-		.reclaim_idx = MAX_NR_ZONES - 1,
+				(gfp_mask & (__GFP_MOVABLE | __GFP_HIGHMEM)),
+		.reclaim_idx = gfp_zone(gfp_mask),
 		.target_mem_cgroup = memcg,
 		.priority = DEF_PRIORITY,
 		.may_writepage = !laptop_mode,
-- 
2.39.0


