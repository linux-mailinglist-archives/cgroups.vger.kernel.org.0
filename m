Return-Path: <cgroups+bounces-3488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E39238AD
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02781C222E2
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB08152181;
	Tue,  2 Jul 2024 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qTZi65VU"
X-Original-To: cgroups@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2057.outbound.protection.outlook.com [40.107.117.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138591514F3;
	Tue,  2 Jul 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909975; cv=fail; b=o7TXt5K4h0oN5unmm4INWOaN9ZuYLE3DxiRYzM6ott541bFUW+RCtdM5FvK1Dne6Fm+HQuTjGY21IAJi4jxhXVQa7lw5GkuBdmXEq+l9xmZHqHXKFJGL3179ylCxETWB6C74sABJkUSWnZ8vyGTGGE+wvTJFbMZ3P1LbNfAOC6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909975; c=relaxed/simple;
	bh=7hOPhFx3f/nMSHHYU+/vf5XJQiMJcB3McLZO5wd0SUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVwcrKVTqlKUheUGalSf7GlsjbA2MTgkH5DSBRY/eEEt05yvHZy/t2qzgE/MomNWnLPjY8yfdFL1CdzgzupFjTREiIrQB/TCbrYmKdJecrdJ4qWuWL/6KLfqYFdu6srENff0wqAyMFI8IO5QEZdiEaR2q5vVqH2pvEv9PJwu22E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qTZi65VU; arc=fail smtp.client-ip=40.107.117.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRFhxV3/yKnBSTgIU5u9jy0ZCM28mdMIAlHoeieG/eFg6NLSUQXT3pZzpQAlHY7U2ccj0Z2X7boPS3Jf42v9+vA6e2Uw/ybaLAdI04QwJFRJBNmru4aKZij6wQ2u9EqjI0Jj49DokNl/G0jd6np/g299T/QrMBwDpPSXBHMtYAaw4WRmrK4ATSkvyanvjhFhwEFb14bEaabKdh+mJW1cU8IGmdl3YhV/MDYgC8ML9ZIb0bULSoFmW32RAhvPrWs1l1xBmVRUIKIDgG4iyI1SuHECnal+L1AoIQWn7G7H45acgSF8qOa6TnJHuK+WQGuTwrMtHCXUQuh+vtuV3TgM+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MV7Q2+/9roovDyuynNKu6Tlm1HAL+DluQZMl+IyKQU=;
 b=i0h9VaPXUyBTcOb9X4EXP6HaKFAtkPo2UXDaVSZEZBdd8nuTwAsntkM8zXVXL2t+4KJ227PUHFKfBnBaGPcihgJZZ28LzmHS2Qoyrw+mN07MOUL+NTn/mfQ7oQhfyfP2sZdqEKc7NUd6traLZmvaF3fvC2ngZlWoiiCOnk4vFg26fL1yx3vXKkyxeMQ+liECpID0iXARg77u/vZesCkJKjNc/h9NH25zp+2Bzajdy3faK/J2PpqrmxRRZ2OX7BCrEny8ejl6JNbgbzKIdZzNXbHtoF2OWjz5AeOSzEzZ8NyMvq84xfJxffm+K2JGQCXd5kwJKQ7wtIiYELYJV/7TOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MV7Q2+/9roovDyuynNKu6Tlm1HAL+DluQZMl+IyKQU=;
 b=qTZi65VUKb02QN2AQ5YlH4npS6tSgw//8x+xsr3mqdz6FHeEqqgSyqKMhDT6BeAvSnvQFAqM6lgOy7ZY9NX8G7LwgOnoyxl2IhDIKFbonz2pkX0dFC3s56cSnlRsBxpTcNpkNDAttqyGrnkNt0lzJkdt/aSUQVeGWBepvH4SZ//Dla+jqJ9TeNxLJb70Yfxt4sGTqKTt0ED1mat+e3ylzwO1XDiakBCpRPXEd8AonMBV3u7ETUqkqzyY3n0lG1cFRfssAngV82QF/3cRbHwjJfxaG6cDpn2UXw2O+wsc4CDFy1RhG6xkp2+gVklN+OSk1CoQI3/ZBfqmehZGBoYV/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 08:46:10 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%6]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 08:46:10 +0000
From: Huan Yang <link@vivo.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Chris Li <chrisl@kernel.org>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Huan Yang <link@vivo.com>,
	Kairui Song <kasong@tencent.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: opensource.kernel@vivo.com
Subject: [RFC PATCH 2/4] mm: memcg: pmc support change attribute
Date: Tue,  2 Jul 2024 16:44:05 +0800
Message-ID: <20240702084423.1717904-3-link@vivo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702084423.1717904-1-link@vivo.com>
References: <20240702084423.1717904-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0148.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::28) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SEYPR06MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a2b0f9d-f637-4db7-7d21-08dc9a736c00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?49AJizRIli6T8+XohSyCV4OOS/8am/tL8wB9DywapHJf/AkidjaKey7NaYYc?=
 =?us-ascii?Q?czjOUUBTzfcH1oTB7PlJkowYz/9Ff4UAjmdztuz9BUMcfOCrrjF+CaV0YFuM?=
 =?us-ascii?Q?mMjLp0qIsEb3/sCBqpETEfNpJOVqgR0/Grry21JRoEqaFrPG0EDZwnL4UGQM?=
 =?us-ascii?Q?VpaVwXF3np9oBBP8DwXeqLzeGLC+87+CRxXiuZbq1RmKXhZDM0fyz7mcdZHC?=
 =?us-ascii?Q?zGheHC1jsu8+0F0su5Lx+SP4SocdaqyVLm/ePC5B7YS15CAli1ND07eALBea?=
 =?us-ascii?Q?yVWdhsKzvZWbyzdY5hs+fDh1OyXrszlQYbpyRfJFkAYLheQ9SA2SNOVQ1tZs?=
 =?us-ascii?Q?+ISq/4882UBqJdZL0mWRTxdrVE6AnYbrkEasDU4qCCJa2vNdE8Ky9eOAzQhm?=
 =?us-ascii?Q?0KZ5sufcMS/d8Pwc/E3MWdG0nyQNNVoWcbb87B6C1qfSZ4YrKsXq0e8CVlLC?=
 =?us-ascii?Q?SHGin/3oQ1AirPNzc7z4Jq+M/qTh6EzzMo0/+EsBUWjJXHJF7uvKLHqGAbXM?=
 =?us-ascii?Q?wBFlC7VS4BwWHjp2Ya3FHZTFzQzQxizuIiuftj/2T1mZGfEhSzdJpfFQRAlE?=
 =?us-ascii?Q?aGDXk5kcq+IC7btwXdPqP51yILqkGmz/L+yXui35Flp0EEllvg+veXMrQRBg?=
 =?us-ascii?Q?Yf5lBYLdQyUSjXV96pgLq5JMCm1ZWsMZ0JApCByrjEuBOxYgDreUjNzeSdJP?=
 =?us-ascii?Q?nMo4/zUDvnGNzBfp2MRk2dbEG1tFKoXlNXhjD9w73ddtY0QYFiyewp2MnvWO?=
 =?us-ascii?Q?82QeJr3nHK5ww6uOgMYBMdPm64vK8WfTcl8DkQNePT0k5mikiHBwje3SCfB+?=
 =?us-ascii?Q?xvajcDFSC3z4vhGRwPLt3doUoXVvebUG5H2A60Xtvfj2pX9T0CCdG+dH4j/N?=
 =?us-ascii?Q?Akoltub8BAH9R/vpdjhMTqLjpCFTfHR2LeoTHhfsAAYvFfP7+kOozNcTJwQG?=
 =?us-ascii?Q?OzRUKaTUMXz8hNzpUCeuCvG/iT/dErlo+ML+xkKdAPLgtKWqhbdHB6UwA30a?=
 =?us-ascii?Q?Qq73yT7edJKu0SB3SedH2qkKJFoyQ9+1lijS/5d7tym6JKRUiKuyf4yLBWL2?=
 =?us-ascii?Q?SKOVOIOVgYa8jnVM5tmdOi9Lq9eQ6wPMjEjCXHJLtZfooOfzubvedj8Ld6mv?=
 =?us-ascii?Q?8XIet1zDuW5+fNjQ31um0cMbQXNRTl+S0kKmxPfsgwtq+n0fB2vEh5ZEZx68?=
 =?us-ascii?Q?2XBlBoLb/pxpBr3BYb1QZtWaVe0GoqdFQQLh/gRfqXGQrzqZWLM1oZ00RrNB?=
 =?us-ascii?Q?g1GuXKwPIX+4weoCD2qY4pOBo2ZcjH6veJFOKggC1xwH0RtGXFf1IXoSZMGy?=
 =?us-ascii?Q?IZQE/jeUeOUySMQDmHm87k6x6hynoeOycc0qs0i62fcz7uKEbjVCYNXQivj5?=
 =?us-ascii?Q?/Ouxcg0vQCcaGAMvuMdpHZpRveXPxEhy811/C9RTDrApHcqSb11IkzJR95Rf?=
 =?us-ascii?Q?tcJ7iPQeSzU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x6kusNf0ShESwMV1tB9QubYUsfGsHTzqJOKZFnzJmUmaqMNTMklNeVr0WJ8B?=
 =?us-ascii?Q?OB4oyJGmfCgs0c59lPtrYHQqPmjnEgLd/a/EhJiK+8e0NQC9mOEXlmN9lAhi?=
 =?us-ascii?Q?hpYw+NyTMlNjhvbSrqfTEwfSC3mNka4v83ZGumy4qL6kVnXJYhBnWmuSNiik?=
 =?us-ascii?Q?4RKuXODYMQUxZB8W4oMu9rOb4J7mi4Rp8Pqj3krfDBT/tepTCdHEKNV58UM3?=
 =?us-ascii?Q?CNz4dxbI6BqhUjhGimm3ZCRfq/WmzxNQFcMfEutXNo7U6OIkJVfH4mfTFRZb?=
 =?us-ascii?Q?Cbzdu4+/yvu2tYHLHUy8bDsTo8bJ/CqidfwKtGWPN0g4IDHop1sfiaGJJc0N?=
 =?us-ascii?Q?CkkwS/M6+gWJU47D5R+PWdMzAyJgTIqFmqXUkyqaSHGiPOrWKhHFtABDFu6r?=
 =?us-ascii?Q?FuGd7iv/NRDVCBnMcJSAr+396Mle//z0Bgu8hIxj7d5eZhDoXVhmbm9oDN0k?=
 =?us-ascii?Q?A0S+hOQ+J5JGtqoxfd3VEgXT+6kdgkPDEKZLawF9mPw5wbhOd8FlCjHYeYW4?=
 =?us-ascii?Q?wuDcEzRDamGANGW/4stFjaoZb2dk8oi5g7HblcfZNiaFqfRRlh3iKkebuE8Z?=
 =?us-ascii?Q?ptRJY3Uk7pAWdxLRPCITN7owK9kuCAWQLE0sNCTMy4j+kdp7aZ8rXSNmaDSQ?=
 =?us-ascii?Q?WpNZbJ9UACrukz1o7HhHmvwGZDr9xrcRukhjNGaQtkbDHP1NkGGJt379ymGz?=
 =?us-ascii?Q?nesXx8nRKTLR0Th1rjLGww9jpS6sUHvu4NS4pP+TSSIC1TVJcGhsb4HmNdcY?=
 =?us-ascii?Q?pW+DjyoAYXw9oexlbAi4X3zJBrMmZWzAOLqgnE8ncXNK9xxy2w5sxZ7EEqSF?=
 =?us-ascii?Q?XLEDvdcUUlo73fBnCzmhRgF3DZC/17J+EUafdFg1bfk+QJcjHtzJo+n1QSFn?=
 =?us-ascii?Q?YhnL3FbJqxr7YzXpxoteiLRdtlVfV5MmkYkjUFppOleWzB/W8TR16a0lgy00?=
 =?us-ascii?Q?NcNp0dYvM6ME0twpLtd9qcSS+EJxGyKJJSicsnC7q1ByD2Nv5ZMd/iYCjXxJ?=
 =?us-ascii?Q?rkm/Pk4q9Mgk7O9GtJYRTa/U0n5ehADKAjHLxDYgED8mJzd76xq67SC51c6c?=
 =?us-ascii?Q?qXY6fb2T8+ylAIj/khtYPr23Ei2vQeAeuQYC79lv9sVoBHt89RbfXqsicEBZ?=
 =?us-ascii?Q?+Lk9I15N/Z8iqzjrcUXdql/Ai/lBZ79GVC6zbPNry1o8/J7D765vlK3ZbvYG?=
 =?us-ascii?Q?bw1nQIsbqxGGOiTfQ/mi2JW7Y5oJjcyFgS0XFu9vBztjrMHiOsEcg5iiYvVV?=
 =?us-ascii?Q?JHmNALDg2IIl0aDd5/LhXHnI4HbgLSSr50iJRHK6TmVcX0uADEihtdxqYPpm?=
 =?us-ascii?Q?H46sAf9ZmkJakYUQT28Uv7zXB8Uyoy1/nX+qlbkfOTsHgy4tsWIZiGbh1fi9?=
 =?us-ascii?Q?pq1Z4WjkSYjk7/5U8JfFxt6g5Erc6Rz6M1WTomY+v5Xch1v6/kvmyDDIukpt?=
 =?us-ascii?Q?MO6CVwDWghjrYdvHG+I2GI3M5utcQWbPy9kajfO7FmJfWXa6UQgFBLGHyERY?=
 =?us-ascii?Q?dekKgIHWsy2xbs9cmCRAomShpfiwZrGHHexPcumIPi4sZHKIC5CgkiO4RFWt?=
 =?us-ascii?Q?zfQWfJ/1mDrQ59VPjfG3TU25Q0jyWxHE2uBLyEep?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a2b0f9d-f637-4db7-7d21-08dc9a736c00
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:46:10.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KY6lu++Iu/ILojwIxMOEIrWhiVYpDb2UC6OKonul2hy/y4jSDyVr4WZSMr3g10NKUvkiaYmE33qbMpwZAkQJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790

pmc have below attribute:
  watermark: only when zone free pages above high+watermark can
cache pages
  limit: max memory it can cached.
This patch let user can change each attribute by `memory.cache`.

To change attribute, can type `keys=attribute=vaule` into memcg's
`memory.cache` if it enabled cache.

For example:
  echo keys=watermark=157286400,limit=209715200 > memory.cache
This changed memcg's only when free pages above high+150MB can
cache pages, and can cache up to a maximum of 200MB .

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/memcontrol.c | 152 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 151 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 404fcb96bf68..9db5bbe63b34 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7253,29 +7253,168 @@ static int mem_cgroup_cache_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+#define STATUS_UNSET_DEFAULT_VALUE -1
+enum {
+	OPT_KEY_NID,
+	OPT_KEY_WATERMARK,
+	OPT_KEY_HOLD_LIMIT,
+	OPT_KEY_ERR,
+	NR_PMC_KEY_OPTS = OPT_KEY_ERR
+};
+
+static const match_table_t fc_tokens = {
+	{ OPT_KEY_NID, "nid=%d" },
+	{ OPT_KEY_WATERMARK, "watermark=%u" },
+	{ OPT_KEY_HOLD_LIMIT, "limit=%u" },
+	{ OPT_KEY_ERR, NULL}
+};
+
+static void
+__apply_status_for_mem_cgroup_cache(struct mem_cgroup_per_node_cache *p,
+				    unsigned int opts[])
+{
+	int i;
+
+	for (i = OPT_KEY_WATERMARK; i < NR_PMC_KEY_OPTS; ++i) {
+		switch (i) {
+		case OPT_KEY_WATERMARK:
+			if (opts[OPT_KEY_WATERMARK] !=
+			    STATUS_UNSET_DEFAULT_VALUE)
+				p->allow_watermark = opts[OPT_KEY_WATERMARK];
+			break;
+		case OPT_KEY_HOLD_LIMIT:
+			if (opts[OPT_KEY_HOLD_LIMIT] !=
+			    STATUS_UNSET_DEFAULT_VALUE)
+				p->hold_limit = opts[OPT_KEY_HOLD_LIMIT];
+			break;
+		default:
+			break;
+		}
+	}
+}
+
+static __always_inline int
+mem_cgroup_apply_cache_status(struct mem_cgroup *memcg,
+				   unsigned int opts[])
+{
+	struct mem_cgroup_per_node_cache *p;
+	unsigned int nid = opts[OPT_KEY_NID];
+
+	if (nid != STATUS_UNSET_DEFAULT_VALUE) {
+		p = memcg->nodeinfo[nid]->cachep;
+		if (unlikely(!p))
+			return -EINVAL;
+		__apply_status_for_mem_cgroup_cache(p, opts);
+		return 0;
+	}
+
+	for_each_node(nid) {
+		p = memcg->nodeinfo[nid]->cachep;
+		if (!p)
+			continue;
+		__apply_status_for_mem_cgroup_cache(p, opts);
+	}
+
+	return 0;
+}
+
+/**
+ * Support nid=x,watermark=bytes,limit=bytes args
+ */
+static int __mem_cgroup_cache_control_key(char *buf,
+					      struct mem_cgroup *memcg)
+{
+	char *p;
+	unsigned int opts[NR_PMC_KEY_OPTS];
+
+	memset(opts, STATUS_UNSET_DEFAULT_VALUE, sizeof(opts));
+
+	if (!READ_ONCE(memcg->cache_enabled))
+		return -EINVAL;
+
+	if (!buf)
+		return -EINVAL;
+
+	while ((p = strsep(&buf, ",")) != NULL) {
+		int token;
+		u32 v;
+		substring_t args[MAX_OPT_ARGS];
+
+		p = strstrip(p);
+
+		if (!*p)
+			continue;
+
+		token = match_token(p, fc_tokens, args);
+		switch (token) {
+		case OPT_KEY_NID:
+			if (match_uint(&args[0], &v) || v >= MAX_NUMNODES)
+				return -EINVAL;
+			opts[OPT_KEY_NID] = v;
+			break;
+		case OPT_KEY_WATERMARK:
+#define MIN_WATERMARK_LIMIT ((10 << 20) >> PAGE_SHIFT)
+			if (match_uint(&args[0], &v))
+				return -EINVAL;
+			v >>= PAGE_SHIFT;
+			if (v < MIN_WATERMARK_LIMIT)
+				return -EINVAL;
+			opts[OPT_KEY_WATERMARK] = v;
+			break;
+		case OPT_KEY_HOLD_LIMIT:
+			if (match_uint(&args[0], &v))
+				return -EINVAL;
+			v >>= PAGE_SHIFT;
+#define MAX_CACHE_LIMIT_NR ((500 << 20) >> PAGE_SHIFT)
+			if (v > MAX_CACHE_LIMIT_NR)
+				return -EINVAL;
+			opts[OPT_KEY_HOLD_LIMIT] = v;
+			break;
+		case OPT_KEY_ERR:
+		default:
+			break;
+		}
+	}
+
+	if (mem_cgroup_apply_cache_status(memcg, opts))
+		return -EINVAL;
+
+	return 0;
+}
+
 enum {
 	OPT_CTRL_ENABLE,
+	OPT_CTRL_KEYS,
 	OPT_CTRL_ERR,
 	OPR_CTRL_NR = OPT_CTRL_ERR,
 };
 
 static const match_table_t ctrl_tokens = {
 					   { OPT_CTRL_ENABLE, "enable=%s" },
+					   { OPT_CTRL_KEYS, "keys=%s" },
 					   { OPT_CTRL_ERR, NULL } };
 
 /**
  * This function  can control target memcg's cache. include enable\keys set.
  * To enable\disable this cache, by `echo enable=[y|n] > memory.cace`
  * in target memcg.
+ * To set keys, by `echo keys=[key=args;..] > memory.cache`, current support keys:
+ *   1. nid=x, if input, will only change target NODE's cache status. Else, all.
+ *   2. watermark=bytes, change cache hold behavior, only zone free pages above
+ *      high watermark+watermark, can hold.
+ *   3. limit=bytes, change max pages can cache. Max can change to 500MB
+ * Enable and keys can both input, split by space, so can set args after enable,
+ * if cache not enable, can't set keys.
  */
 static ssize_t mem_cgroup_cache_control(struct kernfs_open_file *of, char *buf,
 					size_t nbytes, loff_t off)
 {
 	bool enable;
-	bool opt_enable_set = false;
+	bool opt_enable_set = false, opt_key_set = false;
 	int err = 0;
 	char *sub;
 	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	char keybuf[256];
 
 	buf = strstrip(buf);
 	if (!strlen(buf))
@@ -7300,6 +7439,14 @@ static ssize_t mem_cgroup_cache_control(struct kernfs_open_file *of, char *buf,
 				return -EINVAL;
 			opt_enable_set = true;
 			break;
+		case OPT_CTRL_KEYS:
+			if (match_strlcpy(tbuf, &args[0], sizeof(tbuf)) >=
+			    sizeof(tbuf))
+				return -EINVAL;
+
+			memcpy(keybuf, tbuf, sizeof(keybuf));
+			opt_key_set = true;
+			break;
 		case OPT_CTRL_ERR:
 		default:
 			return -EINVAL;
@@ -7315,6 +7462,9 @@ static ssize_t mem_cgroup_cache_control(struct kernfs_open_file *of, char *buf,
 		}
 	}
 
+	if (opt_key_set)
+		err = __mem_cgroup_cache_control_key(keybuf, memcg);
+
 	return err ? err : nbytes;
 }
 
-- 
2.45.2


