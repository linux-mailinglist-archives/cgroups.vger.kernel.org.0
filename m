Return-Path: <cgroups+bounces-16396-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKV2LDWTGGoMlQgAu9opvQ
	(envelope-from <cgroups+bounces-16396-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:10:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AD5F6E8E
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 21:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C33A0313E96B
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23F033ADA8;
	Thu, 28 May 2026 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aiW7EDvU"
X-Original-To: cgroups@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86F3368A4;
	Thu, 28 May 2026 19:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995027; cv=fail; b=W7+R+hbid7P/pi3p9GMkR1jleQx0oJQSiDPWb36gE8gDrEycy9fUQVSkQJdGlCxZ765Oyt3dh0uVciL0WuETFBFXhj2OVnowj45Gw+cGf4vzugkxHQPPnF88baT/PcRmmHz7hOpkuzxWkLunrf2UDyXWI8dPLvi1BUDXgH7zwKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995027; c=relaxed/simple;
	bh=rfLsE6FHBgcXLfIicffrvywGIMH16qY6VGwFUQyalzc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qbU4eDKWcYcjRBXwoqieXCPgMeeWBCUIEjExx9A9HzHLGFfpaL+fvSa5YCPo1uGv4qsZMm6uLKxhaKQnZtXkBi1MIEJn0hviPDau9oWTapFphw4MnqQx9kp2N8E1K9rqCpTzAjY5Ix/SmSZXABmnEME3717VI+xTfHVlq4e1v0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aiW7EDvU; arc=fail smtp.client-ip=40.107.208.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZnv/sbdi0dymBDBy61gjfRWmzRDTMBxGMSI2NiTu9FOsqRBQX1OBYXQGFgc97ez/y3IZVojb41Z72UhKq5tIGXD4/3YtrR7wPgwdKVkJqDZbW5IH8tPO4oAL/C7Cvs8zEreaBTPbmozvdd0HGHeNWB1WhOzjB74ysOAPbyzl8XJWq19DsHXKJoPfMFaaySIbZcFanlwoyAarm60ZlIK+8AUXn++X4nhbxzXtZOIzWz+9oY0J7kB1Bld/Tigbg/bEd7LmzPhyI3kMtvN97+/7RQqFnz21hmecvmHUm7Ou+b6ZD2EENBSxE1pwJ7ciugII1YprNnjjSvCKzJOwcbR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOS5eSH2FpTBHK47e/QJTZ0HYZ1p0XViboVUySo4mZc=;
 b=pXDmIT64gX9QqTsWkGDPUvOo7UWTIQ7LgelTZcto3e3w8bvUBmpDIn1crQCgOkWfZ2RnhBvn5R+mfGWlXhZWXqBmVN5FS6uOp1rULd/PW1zmlwKpsqw4XrDt6LO7YzzeH7bgclszx/W695C27IWdCWtO1/LDJmFFn+rXpkV1g/XPMDzctSarKIEKOep3lnMp+ajaq8o3gRjXsX2Ovg7LWc+ux5IF97kn5By6+YZEE4rIvBHB8wd9U1Q8EtAfZ6cQ6QyflCKkXt1EYIzi8D+MwqBPbOquX3ghrW9disQFD1dzdqVRLLQ2NourTr7v5/BLJSEIPscBgrutlhJha26snw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOS5eSH2FpTBHK47e/QJTZ0HYZ1p0XViboVUySo4mZc=;
 b=aiW7EDvUVUoEl0VMCgcoKWPfF+WiE6IJFAWRfaQArnRmrIH//OBHDk8gzl42ZBz86XY9IkuEipogwlGjPB5yRfY7r2oAum10Q8vhnUoCjycZzQ3rBL7Cp82Nq0apz4tTKkxtPB7v7d5PKmrzUeW0QlgQ5pRS7hlRE7k8En1CvC8Jh3DdrX2rLIMnNyQpO9cdDo1WGLz/Nyl16s3U2U+yGM+TReID9xo2FJ5cloGezGNOEtu1DWVKlKH6z19fnK3rqc3cKn0li9waF0/DLJBCXUWWSwoTb3evpcusymoWInakHTnz2J2A68QnueDEDliGGV0ujv+p77f4BpB+EuKLFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21)
 by IA1PR12MB6042.namprd12.prod.outlook.com (2603:10b6:208:3d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 19:03:42 +0000
Received: from LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286]) by LV3PR12MB9356.namprd12.prod.outlook.com
 ([fe80::1c36:31b4:c420:6286%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 19:03:41 +0000
From: Yury Norov <ynorov@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <ynorov@nvidia.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Waiman Long <longman@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	cgroups@vger.kernel.org
Subject: [PATCH] mm: don't allow empty relative nodemask in mpol_relative_nodemask()
Date: Thu, 28 May 2026 15:03:37 -0400
Message-ID: <20260528190337.878027-1-ynorov@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To LV3PR12MB9356.namprd12.prod.outlook.com
 (2603:10b6:408:20c::21)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9356:EE_|IA1PR12MB6042:EE_
X-MS-Office365-Filtering-Correlation-Id: 25da8389-a36b-4840-67f5-08debcebd539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024|56012099006|11063799006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	3KgGPN73WIqvP8fq5U//WLoQWu7iC5mC8bRx1+tY020SKYsGrvAJPzonjxqsEzu/WeOTHmz7Ys0oQ42DYOzrqMMRVLWpxsBieH644raWR9H4vgTKcxbZQwYdx83q+CNwar+ZSRQ6vKA7axjnAymmxoxdxZ2MGjFaTBCo+oxqww0xlmWi1wa1HFZAnlJWnuFMgHp8D+Ew27bab7bvVfQpyXPaOhOLPcGxNh+3/k6gON5bgu6QNlG1BpiiiYjYC2MJtPwdkynu1NEy9g4Yg3mFJavN3ahJDDZIOXL9IFQkcIM9ab8TFUhi8KwqZeeVpNXxx8af05FZuoMx4Ypz1Rj9189SNTwN9bsnnS9ekBO5PCBC5T/iEdwt2BqnbJPF1rrEvRi36SVLJPm83fHF4pAeLfnctgSl472vXqR3lQ3rnx+4F/u7+6Spj/qcOlj1CoAbAQP1BiAkRbT5TetoeXoqZyGuw4iz4otzmU5vQvFdIR3k8ZgQVbD6mws3V2VZdEIVrdzDIXymwYbXMbvHBy7wEAF89LgSmL2khi3TANTZ4E8WbUVneNOdPi88WmB9Mj/n+hcnVYsQ2baOECV3WQf4l0LbLBAa5HRyqzB3+syG1tkO4RUWWvYjgfByba6Vy5ghE7UDyQfPC91STnr/belLvCHl+QURw510DSQ6AF/+c0mD1D3CWaOhAETZkrVoVugEamLkkwEN9tgSneoriOn64MS2KzyEVR2Xpjhzjck1KSD5Gn7PonVxW4tQvEFNJ94D
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kHE95x2H5q0npis+kY9R+U8aBytDc+AFJmNu84DaIWQSH3JTc6/OVweoLMfq?=
 =?us-ascii?Q?RL/u9iWPWzchs0gRwtT5V9Wt++ZM+swqeY6qfw3l9zMgsLiSBORrb55ZdUjq?=
 =?us-ascii?Q?1AbTueHG7cpCFuZodUtvKFTs9tmwM+asYwwHkmX5/asxKxyhW/Uocw2AsbPF?=
 =?us-ascii?Q?Eo+8tzmDXQ1zpPG8YETqr7t1Zy+upiMLGw5pU2rh9cmaNe29tQ6UtbFmeTpf?=
 =?us-ascii?Q?l2UVoWhWxpLbWqC6O6Ugi0BUoJgCGTl9oE72Nr9np3V8zkoEdc7Xs2CR2gEX?=
 =?us-ascii?Q?ofgUMF6Ot1slI7/I4AynImxMszQzuoPS9UcuHtpC7rRqcFHEKtkNXQOX3j6M?=
 =?us-ascii?Q?VyDgBV7E1HzzcN7Dw8STId2ty++28wSXkwY0zBjHts0WmTZW7jPR92sWGNNQ?=
 =?us-ascii?Q?x4YOZIcBSB5iqHj3/W9UgTSVOWHXDxyt3eDZCntK0x/GP6J27M7oPHJVb5pW?=
 =?us-ascii?Q?kaYCCAtYE8ZTGPenpxPHIwjbrw0wxornp9DKq4D2UdtR5K4IVtr30h/ydumo?=
 =?us-ascii?Q?F477vp2OR0riEqPmbzhUlqOmeVdSQC9MYA2JBsacDd4sT8z/jQEygMaAhFL8?=
 =?us-ascii?Q?pk9SHAwCfIeXMBSjpV/crd8ipGVj9MWYs0c1hJnYm7/qWMPp4Os0RXNEpXSf?=
 =?us-ascii?Q?Qa85YVORkQI9lMy40elSd1M6Zje+im/HOkZc7CwsSIB3COM3p1qNJllHxtfy?=
 =?us-ascii?Q?11voj2oENKYack57Z3jYTHHHRCsBIlrIuY6Wk+3ZUpII2xrwyfmq71BUATbI?=
 =?us-ascii?Q?AoLj4AORGfzqScgUSdWoxmnH9BdpLVZ64foi3lHwBFUNhWKcajvvA3gaVw3R?=
 =?us-ascii?Q?OdlmmqzSdxdVMWnggc3BYtp2e2CQKK2pg8M6nz5CeqJdDBe9evxd6VYyxilP?=
 =?us-ascii?Q?jv2FxCLqm+PHmO01VjBqVoxwHysliomlfMlhe6wvVQKqvSZn/PRZLd1ImIpZ?=
 =?us-ascii?Q?DMu5ztdYS+mpDXx0aKZvSpE7i/iER8qbGn3BRNHD/Yngr7cUKSwlH19JOKBN?=
 =?us-ascii?Q?8Muf2aNMEVawCX6haLeZW0+9k5G9vonQxuZcry+e2G7aMiHkvIqgoJPh7+UG?=
 =?us-ascii?Q?DnYRU0IS7V0e4jM1Nva13FUc92XB0qe9nzXO+sbVAisU7Thr+Iq8494lhzV4?=
 =?us-ascii?Q?gCXbAsAt3k+DwBYj/icEUf8wVIGOyz++QIJl6V7t7z3NdW719r+FyipTd+8j?=
 =?us-ascii?Q?ZZLB10pcXWu6CT+S7GO2kZNOAQ2uCIWfl79TjrXUsudSQRcRnT26YDihc5HE?=
 =?us-ascii?Q?ZsON7q8+uiaTXJ24dG+9dTv8RDI85cDIrJgjpAFtRuix+aGe63jUPICzaVca?=
 =?us-ascii?Q?n4O5qR1iUkfI3OVAsJG2RuZDyeG85ouJWr8PFWClSIKwIPCgDhLx4B3D3i7V?=
 =?us-ascii?Q?GA4YM/VV5dB2i0OnzS9nhqtw4dww5MgX+WC2Jl7tVcZsC8lCK4Exn4/whRnx?=
 =?us-ascii?Q?jA/oNlW7dsqIqlf5vj4Q7bIEuWHCY7yQw1sQn9G0+zHyPVFOU7uoZEdpOBJx?=
 =?us-ascii?Q?OwUelDOQuLu/h9bUj3LlJ8PXXY3ipxEh+PA2NYfyr4xPdAe/o12VMzTC3zvr?=
 =?us-ascii?Q?PNnv1rf99IJhsSAp1l2zA+4jwaQ0Ihf2fYXHh3e81VDbeiYrTdc72VVg3/B9?=
 =?us-ascii?Q?cXeu4UOoJD8bdiAuTbptAd0tIwPFd8MQWFduUlkvpawahwYIozvRVZ+5dGdu?=
 =?us-ascii?Q?ZVPdQOxBc3jriAtN3rLw6pDO33jnop+7jqH9XwCOmX5vn5md6gwzEjRxY9xH?=
 =?us-ascii?Q?XoB1jNTtAzCb/7bZi0XiAoUXYcCSUnLW4ylNid2ipLJRhXPKaRrD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25da8389-a36b-4840-67f5-08debcebd539
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 19:03:41.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SXnw3N0umrM9RsoPS+sbc/RNaBQuWaVzYtL49phd+gHiVPJr9H5KYE2pKYLdhM2EkqiZy+9osRfeTdosgnNhQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6042
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16396-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linux-foundation.org,kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,kvack.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: F29AD5F6E8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reassigning nodes relative an empty user-provided nodemask is useless,
and triggers divide-by-zero in the function.

Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Link: https://lore.kernel.org/all/CA+0ovCgxbZkXa+OU8w3s84R3KNPNxxRfmsNR-udh+afQBbGNmw@mail.gmail.com/
Signed-off-by: Yury Norov <ynorov@nvidia.com>
---
 mm/mempolicy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4e4421b22b59..cd961fa1eb33 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -370,8 +370,13 @@ static inline int mpol_store_user_nodemask(const struct mempolicy *pol)
 static void mpol_relative_nodemask(nodemask_t *ret, const nodemask_t *orig,
 				   const nodemask_t *rel)
 {
+	unsigned int w = nodes_weight(*rel);
 	nodemask_t tmp;
-	nodes_fold(tmp, *orig, nodes_weight(*rel));
+
+	if (w == 0)
+		return -EINVAL;
+
+	nodes_fold(tmp, *orig, w);
 	nodes_onto(*ret, tmp, *rel);
 }
 
-- 
2.51.0


