Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FFB7BD23E
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 04:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjJIC6I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Oct 2023 22:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbjJIC6H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Oct 2023 22:58:07 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2095.outbound.protection.outlook.com [40.107.255.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BA19E;
        Sun,  8 Oct 2023 19:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RysFwmN45WKvZk9Nfmaf9yMfbio7I3dxAEykE9IMw/SnL8jW+lywRLJ4iyi6uux+c3W54n6OFpee87gr+F8lKZqwC2O35x1yx5GkfBBM6rB/3mz0bIDLHVBs87/Ngmxa2G0HQb1xsqmayeqjfmLEz6t4KOWqJ5ZCpXCZ9fIsjUQhNWxXpKXlFCJ1Cli+UBiMCtlD/VnM+HDxLm4hWHk345EQVb6oYz4qJFk7Op+xxbJ5ei7e00Fguh+MHt9/HMyvxnoBaeoU3vbHuuT9bG5GVMX9Xosw8nE+Rc4y0VeOE+eswYumKc98Y9E+9iIfIuhYsyWEJXp/y1DnQ11wSpoaww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufVFOScT1Uc8FLvPObIJWLuC6qLxilikqqz4c9jJ+X4=;
 b=C5sn0byVdaahMpMYMQhqaXwIq7E6r15iSFhrvwXXqs9TGLmp0TXUWBrItTcvtdTGWFSvuAL5Gonh5DDXxoKvPpN3yB2GKhiAjCzPHkeFMkwxRYoeiwejh19Ni7vOz0If0awERchgQG0+jZ8pjowfl2MZjBCbPwduOEWpJNr3wIjT9I+fapEU+8pB2lA7cJJtw45heyNMWBwL7bdJiWRIS0Iu9iKjB/Ddy4dGToYEl7WlxumqhyUvsZRlFRN5jiWB/wejJyG2MVh1/UdZtqN5oTvP5YkHHNzHwJpJEVdwn+1PZa0pleXSycdgiFC9GNqi50aaDbb7QpMWHxIrmOtwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufVFOScT1Uc8FLvPObIJWLuC6qLxilikqqz4c9jJ+X4=;
 b=iciKMtLY6RTsuGh/M+8uo3ReJ3r4bjcqQPi43cCDUaXCtmd4k0IaJFib+bjLlvv9NSMbMjZD1jMhLw6tb1ZUPQ6EKf3iSfQapTo9o7NnsVaqesFBRtkr/2o8h9qeaCY12JJEWTUtWili4L7KyAXJRkHDdXSEwsfnPUjPx4xPfowKdSejKbcFhH/fYKAcwsYWgQ7GU431djSMwYiLLGaFIBIn0PRawoBRpacTf5YOMr+EfigHTx4ubZTfAMcotVCs8poYaBp3qeBI3hy+eghpIpDjREEwiHt0JwfV5Au2gtbNCLI7zC+m/sARMH9ZcRZsRCvp0QO4suWAiHWlA+73GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 02:58:00 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 02:58:00 +0000
From:   Huan Yang <link@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        cgroups@vger.kernel.org (open list:CONTROL GROUP - MEMORY RESOURCE
        CONTROLLER (MEMCG))
Cc:     opensource.kernel@vivo.com, Huan Yang <link@vivo.com>
Subject: [PATCH 1/3] mm: multi-gen LRU: fold lru_gen run cmd
Date:   Mon,  9 Oct 2023 10:57:20 +0800
Message-Id: <20231009025726.5982-2-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009025726.5982-1-link@vivo.com>
References: <20231009025726.5982-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|TY0PR06MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9d9c91-01b6-4445-fade-08dbc8738c48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCQ0q2tTjcd19NL4mscfLurpAIthoRvjQd4tJOs6wtWwQBpdrYrVCr0U3FDzPuCb9mI+rd+ZoYBTMFyaWeAQvBbJ9NKy6Dd6n8k3NIhlVbyroJkTitr8C9w0jpH4XWYiXXPJxJcX83aLRxWpyyI5v3Mm4B+L9ziTSXLKuFONLNiRTfqryZFQ1Kp90d/KvhkRkr9/3p+yPuhM0aIm7iKGsNfQLarYUIxC2nIT/dcNJGsKp745Q2I+TO7TDaa8T71or6U2GTh/kkdBCsXaPaAFbSDNgS86ylk9T0WY8t8ncbAqq04KDBpUooBf67uVeiQDm2ULd9d5dyrjKWlXmZ/InZHsGwYQtfdK0GB02Q9HaliDmBpFP4gWQEy4WsEWF6A8J2Jl2Wt8bkMTC5NQnIlen7Mp9IJsG7WpI9p6Kai5/6GKI0Lh8Ky5uT450JASFPtY83ocqWZFzMhKeysxI/quhdutun+/sN6HdDMLiTMNhmiNF1JPpg+XGp5o6y23VGd92FL0etVPX/2CMfFwj5sDYHLRynuE9GA0PRffW6V5cGpyCIpEIDmHbnhZQRQ3Mcxq4h4pcdHPECL/67ATOAuBkl2j44AL7t3X5p/eCwM/JoXiSdZHJI9igLXm9sN4tWcuSndKu0bMME63ZWdjAD000A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(52116002)(1076003)(2616005)(26005)(478600001)(6506007)(6666004)(6512007)(107886003)(83380400001)(8676002)(7416002)(2906002)(8936002)(4326008)(66556008)(110136005)(66476007)(66946007)(6486002)(5660300002)(41300700001)(316002)(38350700002)(921005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q9eV6o8Ahbn2lbTm65cJerRZw/j2WhLTUPsUuhBi5JfoGvluco+MfoAIVY0Y?=
 =?us-ascii?Q?4Xo+nmDLERqWqipcvaoQzoKjaUjTtnzTEHVku3doF+QiDBD7CjtmXgxEaFMI?=
 =?us-ascii?Q?bNnIJrjUFlMxvj2FRoBpZunfknjKFTitdTIURM7kXepX2+NhmqZlOEEMSedN?=
 =?us-ascii?Q?6w/yGLT3kFW3qxQSaY/qWvQp5SMOSFU7LldNxGZCipYYIt+nQzy+rqHWomNZ?=
 =?us-ascii?Q?SOkBHc4RrTdsjIXtJXFM0lgY18gc/21SG5DCflcj4ESEuqnPGPDqQlKcecdl?=
 =?us-ascii?Q?TbnAsiFx1IkmLe91HWcZmEszPpgAaRAi81CWlu2Vaq4qK90+j1pyPIJ7Wsx/?=
 =?us-ascii?Q?FclxuRcOXUCjhPEH/P+IqcUyfXMols+suq45KXubKFcTjMoDBZ6aJGHbzSTr?=
 =?us-ascii?Q?yHV/RPmpbrZG0p7kcTEsooWmSowGwitpnKgamxiTUikZX7/2JDI36XoNWU+k?=
 =?us-ascii?Q?MmgKatcJ3MTZzVj/UBrzVDkW5JVpf2fy2sNHwM6ic8rk/dS/8njJNLmNV3e7?=
 =?us-ascii?Q?NLLrPPuyn1dt0O+y8viNF06sQQI76J0+ec7U5KSfjXSlZ1nXuM1XVoXDEJCi?=
 =?us-ascii?Q?Q8LpnL1kPOSN45uo3uAz8bWoM/YJYP7Y/6vZ5qMnNzavxU5bIAz5OJKa89OQ?=
 =?us-ascii?Q?JbLfVJqAgcIu0oq92Mt55S4OuyH7YIcnw2MOCctPjSxZ135dWQEXjzVkRyEy?=
 =?us-ascii?Q?4s0GCADN8bf5CqsUDt+alvGK9yD+R4PjX2LmtHIx0hUsRYo78pHaeNpXE3hi?=
 =?us-ascii?Q?j92tFpd8F5kFBN8beFfl8j13Vfgb9TbE8gIzRDnSgYQTogp3/eA3uazQA3uP?=
 =?us-ascii?Q?mn/w0IhQOrOLYKhri2Djd25PWxZ4d94fD99VtdK5j1kw9YrE+EHNQAPYADHt?=
 =?us-ascii?Q?HA/idrvMZASBBoOPTZ0OJN5o9vuCoDp1p1YCN5JQZAd9919fLur/OngY2m2E?=
 =?us-ascii?Q?djnjAiHTt1jQjyoCCjItkNtac+OvYsetDt2LDeuyVgvyNYfewwRbq476txCr?=
 =?us-ascii?Q?btstSGvTOt+Cb+bl0xTqSEjJa6pNa1xSzl9JldfHaiMI1sDIQxnr6MRP/FzP?=
 =?us-ascii?Q?V93ReHd102NC7rM0aAO0e6J0SJQBpSJzYNh5+M/NuGNAvphirMARS9nWqRQB?=
 =?us-ascii?Q?ehx9Q11hz3GlNfEbwhuoVLTfcBZBs8uQyPyMsUexTPkS5L0q74PgpgnOJ8Qp?=
 =?us-ascii?Q?RnYO2QnEnwP3D98+VN963uhrvWs1cWE799xyEU380Bo34dYKvtYIOL4m+LlR?=
 =?us-ascii?Q?rz+89a/1kLUh7bx2jY59MqQdPQyjCqTBChaVRH/amBfwNC/eq7Lgeva5LNDE?=
 =?us-ascii?Q?25j4u9vwdfl1/n8CmUyRvxf4CaBMxUEmh4YgH+WmY8J9bLHHxGb73wHERiEY?=
 =?us-ascii?Q?o8yKop6CKD0CuCidWqXw0qmyIFehK7Zn92PejcGT78fuT/dLjB9XxjaYoeZG?=
 =?us-ascii?Q?gi3Dukpu3zx2rr2h14gPSmcLQLAzF9Xn7WriT7JzbBrTTqpeqFUqIyiDbSwG?=
 =?us-ascii?Q?rSP5rwZGlqWcqp2CpBWP0NJa0TKzkqAaEOHfAEh7uw0LW0CjHIMUJSL/K49g?=
 =?us-ascii?Q?Zu4+Mzc//hmUvmmJAQ0+G9W53F7SHJlPE8ywwt+d?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9d9c91-01b6-4445-fade-08dbc8738c48
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:58:00.5434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8pE71oorl2FBFhVFty4U/SKq2HSsVwTkAfHEHqoUkCBRXPGLmzMzkkaPSWONch6BaVCGKI+/Xu3r3kTAoTrBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: HuanYang <link@vivo.com>

This patch move LRU_GEN define helper into mm_inline which will
used in per memcg lru gen node.

let run aging/eviction into func, per memcg also will run this.

Signed-off-by: HuanYang <link@vivo.com>
---
 include/linux/mm_inline.h |  9 ++++++++
 mm/vmscan.c               | 45 +++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 8148b30a9df1..b953b305c8a2 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -101,6 +101,15 @@ static __always_inline enum lru_list folio_lru_list(struct folio *folio)
 
 #ifdef CONFIG_LRU_GEN
 
+#define DEFINE_MAX_SEQ(lruvec)						\
+	unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq)
+
+#define DEFINE_MIN_SEQ(lruvec)						\
+	unsigned long min_seq[ANON_AND_FILE] = {			\
+		READ_ONCE((lruvec)->lrugen.min_seq[LRU_GEN_ANON]),	\
+		READ_ONCE((lruvec)->lrugen.min_seq[LRU_GEN_FILE]),	\
+	}
+
 #ifdef CONFIG_LRU_GEN_ENABLED
 static inline bool lru_gen_enabled(void)
 {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ea57a43ebd6b..f59977964e81 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3285,15 +3285,6 @@ static bool should_clear_pmd_young(void)
 
 #define LRU_REFS_FLAGS	(BIT(PG_referenced) | BIT(PG_workingset))
 
-#define DEFINE_MAX_SEQ(lruvec)						\
-	unsigned long max_seq = READ_ONCE((lruvec)->lrugen.max_seq)
-
-#define DEFINE_MIN_SEQ(lruvec)						\
-	unsigned long min_seq[ANON_AND_FILE] = {			\
-		READ_ONCE((lruvec)->lrugen.min_seq[LRU_GEN_ANON]),	\
-		READ_ONCE((lruvec)->lrugen.min_seq[LRU_GEN_FILE]),	\
-	}
-
 #define for_each_gen_type_zone(gen, type, zone)				\
 	for ((gen) = 0; (gen) < MAX_NR_GENS; (gen)++)			\
 		for ((type) = 0; (type) < ANON_AND_FILE; (type)++)	\
@@ -6058,6 +6049,29 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
 	return -EINTR;
 }
 
+static int __process_one_cmd(char cmd, struct lruvec *lruvec, unsigned long seq,
+			     struct scan_control *sc, int swappiness,
+			     unsigned long opt)
+{
+	int err;
+
+	if (swappiness < 0)
+		swappiness = get_swappiness(lruvec, sc);
+	else if (swappiness > 200)
+		return -EINVAL;
+
+	switch (cmd) {
+	case '+':
+		err = run_aging(lruvec, seq, sc, swappiness, opt);
+		break;
+	case '-':
+		err = run_eviction(lruvec, seq, sc, swappiness, opt);
+		break;
+	}
+
+	return err;
+}
+
 static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 		   struct scan_control *sc, int swappiness, unsigned long opt)
 {
@@ -6086,19 +6100,8 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 
 	lruvec = get_lruvec(memcg, nid);
 
-	if (swappiness < 0)
-		swappiness = get_swappiness(lruvec, sc);
-	else if (swappiness > 200)
-		goto done;
+	err = __process_one_cmd(cmd, lruvec, seq, sc, swappiness, opt);
 
-	switch (cmd) {
-	case '+':
-		err = run_aging(lruvec, seq, sc, swappiness, opt);
-		break;
-	case '-':
-		err = run_eviction(lruvec, seq, sc, swappiness, opt);
-		break;
-	}
 done:
 	mem_cgroup_put(memcg);
 
-- 
2.34.1

