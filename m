Return-Path: <cgroups+bounces-231-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AD07E50B4
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 07:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1077B20F20
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C76BA52;
	Wed,  8 Nov 2023 06:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VpymtuJE"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E48D267;
	Wed,  8 Nov 2023 06:59:26 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2123.outbound.protection.outlook.com [40.107.255.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A72D1719;
	Tue,  7 Nov 2023 22:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jj3EYZdlPGcZlM93m2vGlfXD2WRSoSpdKDpHd69Cq/1fVq6TzQC6lGKZDpW95LF1JMHjBA66f3LwANv1jaoCWUcB8EZadJ39sxY2SmcWkQIxy/AyRn0W26wQibhuJRQ1CCVBpo4Odpcp7B6Ae5G9koEgQsoCAFLm+W1DIHJMayvi7c9+rdlJphGmrdhow8qKBJhnDzDHwwgA59150Jiomb1RoB4CEEiiekW/KVskk2DFrtHWtYKivG2gDDf9+ztFXlyT9XSVoxJ17ldguL8HnehVMi1pIBj8JcehamVQV+c0gyG7SIWbEUCPlXQk75HbXUayBc1mC9YdVzB2/Lfiyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUB6Be0jevwGt8NeqUa3bfJfaaD7+VKX6fpXnVPCeZM=;
 b=ZjbPsMDOwLgMI+m2iTFDfGoQBdd8hZ+tymVjIPkdGzYe9VQkqmh+UFhdRXHFk2/ZH0bMb4+Hckx+nUfdYv7zzQLN36R4KPFXizN/CgP3vVnIEsgthnRgxsWSSu/voTCliMJLlzXPLu361whrRxJd6joAmoEo2VeY76BTpM3/xxol6YgPy231hjVtQd0Uf3vB48k+v9NZMbSo4p2m3YKiKsFKY+GydArmG5f9AUGJKlacT6C9VCl5FRHYhVkHQjXUXAU1/kLoAtjA/r7reT50Kn4yL3B1V7B4ge5cywp1T8QoqXZnB4AcnByrNYYYlvfAMQoaWn5y0MiZZun4kgIUvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUB6Be0jevwGt8NeqUa3bfJfaaD7+VKX6fpXnVPCeZM=;
 b=VpymtuJEQ1SAbFMJnNq0jXihnjCNI2NXNoKUnxHf7gfsSfVQV5OVu2E8YXjQreSAW0n3Ws/Sx4v1whmsja2WqsCzj1zQ74xOfL/fGAAbCEWq2neTdw/LGsd2HQ3w5cG3bVwwka+ZHRGTXjBAAVU7RzId3NnU0mVpj8ACS3OeSaD2kMllJNL6zyivojo745Iec8X/CXjYF1iDEVH2XDGDK6rvIzl/OakhU0KZlRtNKPZp5sT55N4x0m/2ZK6UQhVf+9V30TfWsVq4ZmifZb2waJ4j2RKYIryoROWJkI7jV/CJggGXWwURScPgVcKlG5QEh6UT1bRIW8naN7Xi3I+jYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB3983.apcprd06.prod.outlook.com (2603:1096:400:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Wed, 8 Nov
 2023 06:59:23 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 06:59:23 +0000
From: Huan Yang <link@vivo.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Huang Ying <ying.huang@intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Peter Xu <peterx@redhat.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Liu Shixin <liushixin2@huawei.com>,
	Yue Zhao <findns94@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Huan Yang <link@vivo.com>
Subject: [PATCH 2/4] mm: multi-gen LRU: MGLRU unbalance reclaim
Date: Wed,  8 Nov 2023 14:58:13 +0800
Message-Id: <20231108065818.19932-3-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108065818.19932-1-link@vivo.com>
References: <20231108065818.19932-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0187.apcprd04.prod.outlook.com
 (2603:1096:4:14::25) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TYZPR06MB3983:EE_
X-MS-Office365-Filtering-Correlation-Id: f506a763-a0a4-427f-8a44-08dbe0283d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OIB58F67zvsEa5kDgR22kw9XiiibeYLh4UaPmd2yly1Pu41aePNxhJc1Xqv/wi+JO9bn2JEuSrFWM0xMePkjCYYvpNJMRd4oEkwuaIFXv55QFeaY6lNwgKsGc7n+b+db9O8J13dsJIJ7fgmYZUXG8Bop3cwVLQsgg7bWiITDC7FfswDSdN0IzBVjl3zgP8GJiMUU/CuvkuVboovoiNQ0DuYpNhC1RtfppAke2Wu/tmeg9NdC0WqX5riAubAM97g8rBpXlRx7maGIH+Qg5wVnOsmR5MimkBLXeAhdiXJEvdlyWVp0os1F67kQcdmBkn343gG3TLDZbarocgVmf/sm3/IXyVCdTWcBZxEjafQUdG+v0VEfkhphVawboRYEutVznFX7l609hhoYrP06AeAMI/4bNJ/Il8Uf99lDA7oiYFYoTRp/XOFLrg3hD+Ijz3cB4/+0ITwRcWRwWwNslNyoSa5e3smhUThIkYDzKZGjJ4q1jtFBON/BvzBS5zZoTuPlNXX77/+vyONfSlguhZkwQf/P3m5yplB9R04BKjS5/c2P3nE1rmk6qAkhSBTP1mbE8P37j8kIwgAdlpqGrpfa8N7jTJJS0zTxQfuTkjtzZhjXc8cvrWjHUNI0mqjjHVph8bKzgKbWmTYtobDgwimbAw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(6512007)(5660300002)(6506007)(478600001)(52116002)(6666004)(83380400001)(8936002)(8676002)(4326008)(7416002)(316002)(2906002)(26005)(110136005)(66556008)(66476007)(66946007)(86362001)(41300700001)(38100700002)(2616005)(107886003)(1076003)(38350700005)(921008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Jz3+P9rWw2w0tLsgYmtAU7PuNVnP5eSZVzYTkeHX/SYdqBOMTqVQESCRn6N?=
 =?us-ascii?Q?q50XFlqKJa/JSAO+UMB1ycAJG0eGhWwixd2U0cc3O6iUQLZYL8GYxrE386fQ?=
 =?us-ascii?Q?gAKvbtwvlMndvDHYESAQd7TLSGT5enJTO6TmCKYG9ZtZnEmzIyC7LMNOagfO?=
 =?us-ascii?Q?JMhwD4xD2LNjGTLkqGbCdZv6et3bv1WQTINZTgHN4097oatPzjt9KyDzQIr2?=
 =?us-ascii?Q?H8/eMaJwi6RM+E6CiqWH1Csmdiw0I5YHTyNodsEl+rYspjcKxB55nIICTzSP?=
 =?us-ascii?Q?6MPdgIB71n9d2DNl0nQK5NGJdVH+NlMErRIRGP4hpR61QM4lFw7xd5YTb2BS?=
 =?us-ascii?Q?GuVEzTN9AZUbyheuRD/spvtduoNk3FZIbaH9jrCEenqKIUbRjsmtjyntcv+k?=
 =?us-ascii?Q?N6bcYNa1veT4boi7bg0NzO4b3/Bz8doaBuEp1Bh5j4Sgodh4CfI7WBf1KzjY?=
 =?us-ascii?Q?Fs5qtCjqLC5eJOfmGWy92LQe4Djy44n9gE8qi8A0aJrtxCyg6uAiA+nd7ksE?=
 =?us-ascii?Q?y7QOVBlOCzOKG9ptWPjLBup/DG0WBSFdgoc4499gd4ixuDrykfjXNwVB5XPG?=
 =?us-ascii?Q?ZfxwCGV0UleY8csewHYGkzv6e6u+OEN0EIC+ZENX9qhcZZhxBXBAobpDi45N?=
 =?us-ascii?Q?GvHPko/FShdsH1Y4hOUWmzEx1g7b/k4Yy7buzn3CwjpIiSFLLLEmzs8/sBAw?=
 =?us-ascii?Q?a9phU6NQb+XOkjznYLogS+gVz86c+RX/xc/QA+r60pCSDdet+YSyWfw4GjQ3?=
 =?us-ascii?Q?ZxQ9cx8ZDZ2+FqeCErv+gnb3AsdkePQl5rsmlu+Ko8O211SVwNCmOzbQNWrs?=
 =?us-ascii?Q?BA8DQqQiEp9GzJ6HVnLh/EObjWphoYEHiDvxHGkgIy9yckbJhCFosjuz9RAV?=
 =?us-ascii?Q?p1PHAUWHuha7UaSwtawHdtAoX9mTkEsqNFX8FIik2/JdEgyIrKC2a0VSZtPW?=
 =?us-ascii?Q?IoWn+SvoyO2W0d0NNFPHxuNzTICe7VFa6q82r2xjeP3eE0HLY2w1hvhyxqzY?=
 =?us-ascii?Q?roI5L62u69rslam5lVBJCGvAwx1vi9ay8NIQ2YnMaZOgN5xeQ86tMbLgTVT7?=
 =?us-ascii?Q?glGX5wTDDQQyZxXJ0ZewwB+0HbwIga0kJbhIveUM7uvXPhRM6+yifzDKlSe4?=
 =?us-ascii?Q?mKmSTi1Gkd/D/PsK8fp/FubzU/MqVXBqrO/4z3MzK/7SSO3KqGxmPCT7diMQ?=
 =?us-ascii?Q?eVoihGPWrrwqGm8TFQdpAubODd++hWRQ4QqpjyqNIHMBQoFMBBiuyNzYCktd?=
 =?us-ascii?Q?HXqnwLIV8xnrUoxOX8MEfHJ9HDeeP4iqjovj2Uo+56G7ny/qB5EZuIEQIy8X?=
 =?us-ascii?Q?XcEy8vT88aazlAxLGMwujoJ8h16SztBnS7R5EoujYwmQv/ZyMoTMLW+OO0iI?=
 =?us-ascii?Q?S3LyOyTp5HBJsoLJ10/jGXlJw3tROR+WXc3OvCuXK4ThlIBoh8MGl2aeHAie?=
 =?us-ascii?Q?sxHk16mCtN8//A9lNJRsKrJjdwB2RHZasWXlHajWTwA4l3yDKDaa4X7utyit?=
 =?us-ascii?Q?Wtmw1OwB2446rO2P0YE2I9dVpU8wX9X3smSJXqBvsYWV8d3CvOmMYlUaTP2o?=
 =?us-ascii?Q?ik859qjOzGFRQIKlczxlZE6XQeVjhALMHW03iPJs?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f506a763-a0a4-427f-8a44-08dbe0283d19
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:59:23.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ug69hlALgR3GwUIA/+KIRoqdUDlRvTU77rJDAEmLouy0zHwxUB3+FWL8l6rYagluc3Lvmn8zvP0mvibh9eUCOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3983

This patch apply unbalance reclaim into MGLRU, if unbalance reclaim,
will not scan other type folios.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/vmscan.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6ed06e73143a..9243a1f0d606 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4481,6 +4481,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	int type;
 	int scanned;
 	int tier = -1;
+	bool unbalance;
 	DEFINE_MIN_SEQ(lruvec);
 
 	/*
@@ -4488,7 +4489,13 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 	 * available from the same generation, interpret swappiness 1 as file
 	 * first and 200 as anon first.
 	 */
-	if (!swappiness)
+	if (unlikely(unbalance_file_reclaim(sc, swappiness))) {
+		unbalance = true;
+		type = LRU_GEN_FILE;
+	} else if (unlikely(unbalance_anon_reclaim(sc, swappiness))) {
+		unbalance = true;
+		type = LRU_GEN_ANON;
+	} else if (!swappiness)
 		type = LRU_GEN_FILE;
 	else if (min_seq[LRU_GEN_ANON] < min_seq[LRU_GEN_FILE])
 		type = LRU_GEN_ANON;
@@ -4504,7 +4511,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
 			tier = get_tier_idx(lruvec, type);
 
 		scanned = scan_folios(lruvec, sc, type, tier, list);
-		if (scanned)
+		if (scanned || unbalance)
 			break;
 
 		type = !type;
-- 
2.34.1


