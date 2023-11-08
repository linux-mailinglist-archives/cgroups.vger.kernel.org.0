Return-Path: <cgroups+bounces-230-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D97E50AF
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 07:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C78EB20FD5
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 06:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C303D266;
	Wed,  8 Nov 2023 06:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="clmJ5Fma"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26991CA61;
	Wed,  8 Nov 2023 06:59:20 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2125.outbound.protection.outlook.com [40.107.255.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBBFD40;
	Tue,  7 Nov 2023 22:59:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=og/7ipoEpj7QhCnqrKQBMKHou8aurJLOkJO6KmdLxw6jfrcLykOQdGSUd566prgNn+jaeJ+MjZHoagHO3OLgnJjSPaZ1q9OdiXxbbtxLh0S7qvjTx2EHS3X3aTweo4d1oOefXPzurd/ASNbcdQhjZxbkKo3QX88+DaoJMtGIoVsDDBqvy297qB1d4MrLXVwr1HAd4waH+hBdHiN7pw5DDE9NsE0WpfCDxyL7NfTQEiW3GufaP33XWzwm0aDxNrG0Xu9EBMCeDxjlhicXvD6AA8j5pD0Fofr4OuojRYj9F5wnf4tDzzoKxwLGdPAPi03cOXeFoC5BgCsXPsHmY5cDmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IY+4KZ/gKYHUwky0cc5tBRLchnjCs2TVZRgBQ1lHr2g=;
 b=UNTcquFMuWT1UNOXlPSym+DDlhbkUgIJ4+6zaIZvSo+FTEBPa29BJUcwKfz0t2B4qzN1skD/23iC8bZfc3A4sG1SbcylzBI3r8xo9oPNrXOOU23yr1GD4MGiNMKeLeOhiUQ+Y7jMpgP2upG/zjBUxJ4LYBUrTCVqpLpCu4bgwnQ9Cu8DEdinhyMUdmCrnBs0WussfWwJOGn0/B42smt7dX76DyT39Di7Pth7lZWn78phtp0rWwl+XDyilCtNI4mxY6dSYDDiBKGkREEmlLlUrq6VoSlJHAY9XkIGd53Zx2t3IGZs6ZHGrrUYr7Pufblt9yPvPZqQqtj74aL6tuiEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IY+4KZ/gKYHUwky0cc5tBRLchnjCs2TVZRgBQ1lHr2g=;
 b=clmJ5FmaB1ehw+6p9k6Y5/LZ7fFqPom8LAzeyK6h+b9sgyRs3bXqFpALvIEoHUEWiOUGC8lCDEJjzCSPztl3epdzaOVoVct8GZvzoXEA+BvSlEhjbrCu7X4iHNMe2Fjh+fqXkvbNDxJhKI1jzZoYT8L+K2Qi4w22qpJIDZnKj+h0BmfAg5MAnG0PRemm8pgS4SEs91AVHpjTrFyyUQtGcUk7XekLhz50rMw2XXHr1ghx/0HeBD5DtLRbXPFs/S8jKHORK91aohbwA/kVbhamtv6J50x/xOe9byLNu1AzrhAiLe/s8tL+KqXO9uP1G0sOJjT+z5P7/WKIyPMxnI7mtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TYZPR06MB3983.apcprd06.prod.outlook.com (2603:1096:400:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.31; Wed, 8 Nov
 2023 06:59:16 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::d754:7b3:dc4c:6b48%6]) with mapi id 15.20.6954.027; Wed, 8 Nov 2023
 06:59:16 +0000
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
Subject: [PATCH 1/4] mm: vmscan: LRU unbalance cgroup reclaim
Date: Wed,  8 Nov 2023 14:58:12 +0800
Message-Id: <20231108065818.19932-2-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d59434f4-ddf3-471d-2eac-08dbe02838d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OC10UwMzJq9lwG1MKCtZWBAljF2GRqDt06D4WRCPcyNK2NP38ig6PbFIu6Zicy+0fUuvyK+/srDyzxeEsJycynhKBxyMF7vO6ZBGenDkp27Va+t+xQyxR/QkkRXZ+A7+vKJjfy77/0pgmPjTYWasUdoUwWW770danrERLoXzLXBLjievpgxTX7f7gaQJrVrpZmd3mFoghjsjTfECUFx2ftKtXcP9XjngtLjZ9/rWKdONOe7yFWZSzsjjM8cvCL25ylsQWFZz3k++QRjPYNq121+63y67Gu53mf8Yi40GRrbyGFfLNFayAOZRnAMLG0lidtE66gHidjTeU0UMgCUbzLpqtQzCwDgtaX3rhGOi55VlcBb0TxDVD4MxEwBBDACos2sd6vA7PCyWY/vfst9pyOelt9B1hjgUzP13ru5x8HR2zWpWasNTaqMAqcMkanrLHnHD50oQBogI2Rr+y0fuq5UMC0XnGhphY3TvDTwwPCsDfOa0sFRv0jA1OoosdTWGPLFxz9bRMupKFk4dNIUSB/YMcuFTVkmLQmdbbepMIchZd9h690iJ21V+Vovr00nl0u8246AS7n85BUO1ItSJtTwJJ80zNcVbURxh03C0AEY5z4gGbgWgnDfbgKESucCanQ9nb7cBaiRUxLjWv3Xjjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6486002)(6512007)(5660300002)(6506007)(478600001)(52116002)(6666004)(8936002)(8676002)(4326008)(7416002)(316002)(2906002)(26005)(110136005)(66556008)(66476007)(66946007)(86362001)(41300700001)(38100700002)(2616005)(107886003)(1076003)(38350700005)(921008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3TtqxLh1Yc89LV/rI0is1nEgwXsPy5ho3SmJM0eSUXP7+gChf4WCxSDLCdQJ?=
 =?us-ascii?Q?wmVur1d2/sXmbl0n8ip2n8aBL7Omt45nyO7wkLdOCdNYurvuoRUmpGCwJrRp?=
 =?us-ascii?Q?/h+PjzYRQPIQr19wGUQQD08fTszr4yqTIRabD7GY3jpkCTKOpCpr2/Yq0kQC?=
 =?us-ascii?Q?kVcG2bbBrWpLBL6i4hxVp/PFrYevrBABVEd4STO0WdANJkyP7lwzXEeiThYr?=
 =?us-ascii?Q?+NlCZFai648S+WFzNIEarxmEW12XNp7bP/6NpuC/FUUMBeO2An8qcxUCHkaQ?=
 =?us-ascii?Q?fZuAuzpWTAKXIss0o7gwgopUFiVTNWwraNAGfSlp++GuAuQJOX2ybhoph/Ea?=
 =?us-ascii?Q?4Hl9OvXzflFbcvGAhzy2Bo41wWaNXN8pPWXvG+88qAFiwZfygWl6aBn6e4jm?=
 =?us-ascii?Q?1FZ0OpWimXz1Ay6reteZjquf43HC9TptMvqjsPXawNOCAbEXPOj8DgGCFc1w?=
 =?us-ascii?Q?5JtcBn3PGlnKOirPmNkqz1/ADnzq+kwi7LtewbweLx0n+OWK1bgSYWehRa01?=
 =?us-ascii?Q?iXgk95xlZCWApKwpIwno7CHsdPW7UnC6kzIghXM22+OyyAafLuG47ymkzoRL?=
 =?us-ascii?Q?geY/63u5xupX6FZWRBqj5BcgCT4ErFdxSrgkzzTCE4b3z3TqJgalkvhjDdWS?=
 =?us-ascii?Q?d5vSa4Gs1XuZUFWFO8fiL2vmp2j0blU8aVKG1uwKMdYoITfLXNfFrrQaIwEi?=
 =?us-ascii?Q?sjYG8CCmX4xSJif6A0WE6xUMRbHtozvv/vk8rN98vZNlOPLuXEZUYizHC/Eb?=
 =?us-ascii?Q?eLc1/QYCSdx2YdGfna8Ki0V4GndAnB9EMnOxXiUn2Yc0mUk/BAKT6GcJxldl?=
 =?us-ascii?Q?mWjVweG8OQyK7oCYKhVP5vXHj/nS+gV2Jv9MwNeMiZ/RH0v7L4Gwe/cSV1zu?=
 =?us-ascii?Q?NkCamaF2DGOvOYEUjnzI/1IIMrC6uTeHi3VAFKVOlLWViVGi6mPYMzfpK2Tr?=
 =?us-ascii?Q?fjy1y1fzGDVUoDbvT1AS4OqH9Vu2sMh0JIYZcZDDWJtZtqwljjRhj/v095i7?=
 =?us-ascii?Q?NSf1+JfrdN5dvPPkIboPLK00M0OXcrpFZBtgBBI7STCb0gW6Ets0Evp4qTkP?=
 =?us-ascii?Q?0BQHIAUkftyFw3JqirRFnjzGLqriJnWowi4cBZkLmgScQDsbOYPGrELWktLz?=
 =?us-ascii?Q?neapz2CxIWQ1MP9I2qOy7vwDC9bJOdR6eWRJrYcrZ/JEcOD8us8NawNitKmb?=
 =?us-ascii?Q?Bd7V5Gc1ubHQFxzzb9rrp4W9uvoV+H0Gj43D0SIcRA+CDkd1QmDxaiHfghBZ?=
 =?us-ascii?Q?MafHuSYH7ME4LipKWW5EnHFOOl/oZKatbnb/MXDcgCRvxNb+M+DMpLhAAxf7?=
 =?us-ascii?Q?zIpGl2jr1MbZj+2tLBiYY/v81KixcHSYpy4VmvEGytEVQ2zTT+fWVJ1FRmTj?=
 =?us-ascii?Q?W60+r9d/TPqu17bius7eS0Fxb6BOTa1pzEWPVLqAQCHnUsVzrsjTonM3c4fe?=
 =?us-ascii?Q?2xPfPhF7qfZycEfJAPvIiY0VPfRLLE1sFDVgy55O3to+0+y6tm5TwVNlTgaG?=
 =?us-ascii?Q?gTP5D+W6qrG9UhHQqSzqV87j3SENAERexbuWYadgSiBKudOg9vZDphZyxySn?=
 =?us-ascii?Q?f7fAXsUTD4ECigluFipHWQ7ul5ZO+M4irktOqsJC?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d59434f4-ddf3-471d-2eac-08dbe02838d3
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:59:16.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCEiU6qf7qwij7S3RtyHN3QzsWYOHjWYQwDwoZtVVNdvMDAJ0zfPOsZJlbdNkCnUMN1JesXLoV6R73rGgioC4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3983

This patch add unbalance flag into sc, and just allow cgroup reclaim
trigger it.

If flag set, LRU reclaim will only touch target type folios.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/vmscan.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2cc0cb41fb32..6ed06e73143a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -111,6 +111,10 @@ struct scan_control {
 	/* Proactive reclaim invoked by userspace through memory.reclaim */
 	unsigned int proactive:1;
 
+	/* Unbalance reclaim pages. */
+	unsigned int unbalance_anon:1;
+	unsigned int unbalance_file:1;
+
 	/*
 	 * Cgroup memory below memory.low is protected as long as we
 	 * don't threaten to OOM. If any cgroup is reclaimed at
@@ -2338,6 +2342,18 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	}
 }
 
+static __always_inline bool unbalance_anon_reclaim(struct scan_control *sc,
+						   int swappiness)
+{
+	return sc->unbalance_anon && cgroup_reclaim(sc);
+}
+
+static __always_inline bool unbalance_file_reclaim(struct scan_control *sc,
+						   int swappiness)
+{
+	return sc->unbalance_file && cgroup_reclaim(sc);
+}
+
 /*
  * Determine how aggressively the anon and file LRU lists should be
  * scanned.
@@ -2358,6 +2374,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	unsigned long ap, fp;
 	enum lru_list lru;
 
+	if (unlikely(unbalance_file_reclaim(sc, swappiness))) {
+		scan_balance = SCAN_FILE;
+		goto out;
+	}
+
+	if (unlikely(unbalance_anon_reclaim(sc, swappiness))) {
+		scan_balance = SCAN_ANON;
+		goto out;
+	}
+
 	/* If we have no swap space, do not bother scanning anon folios. */
 	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
 		scan_balance = SCAN_FILE;
-- 
2.34.1


