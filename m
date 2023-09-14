Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2067A01F0
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 12:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjINKss (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjINKsr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 06:48:47 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2092.outbound.protection.outlook.com [40.107.215.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E09D1FD4;
        Thu, 14 Sep 2023 03:48:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NOPanoPlg8bseAhnL7sPBKbUB8KfMX28xEzpYI3ntGzsCuSyZQ37F6pWO8yuEX4vhAHfFoef0Ga8WZTjFG/u9Q3ib7/doQqSKV+DbOP6f05DK/MUa4WaDWLrHw42k5ch3XUCHuRRAm9ntf4kR20NtXX0RETEgk473tRotnN+2pL33VMlrAeZjonxXbdbyiIfavRblWANhPonBUn2+/EvWGBlB1g27CxGS2nZM3/YezTgvnkz9UrKaBs3dPVSwG8DWaWWR2vzRTyxsCFE9wsZEqACMB7ahiGjMuKlSDpExEgyhjTG3Yz0KAblYQM/mE1HCVwVzsWNUQL6FH3PaWfKFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C8N66XH3EPgkxilo68Mh0apGkR0cAE3HBoIonCw0Yc=;
 b=EiHcI+/gdxmDnZWtvX2lKvpN1Z05BJmnOEogrF9cfi/qCF9Gd8rBmdn5p1BF1z8iQo7Pc4qKT/DqotX1MPgRK/w45RLb0H47Z0CRFPlufVH5OiXUlJce5s3qWU8p3+rLDOjKJRCYD6fBhpXI7W6oDRP4xTflCFBl3uGSnBg+0KVmeBDiP1stWa79i0dSHO5PpZ1bTM+eZqOY3JLS+XUjpefkhum3t9aSPGvcwJmXiBRhY7Ue6GV7Qu9d0ONQunAtbUNuef/drBkcHRHynQOrmT7bEVujTih9u0iibkpnxMw2XL54eQzbX0QU7ch+dYFAtdTibXlPqrYqqzWUMFq0xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C8N66XH3EPgkxilo68Mh0apGkR0cAE3HBoIonCw0Yc=;
 b=bzTL9qkPZQ+omu8iK7UQBPZb9vgNx+01XztxjXtNl3nSG2nPhlqV52IiIkLsg8VOrBm1WyJCPHjZRSRfXHgJJuT+g9MTwlY7XuGw+UN7ZHVCcEQ+8SZFNS4fekPYbIj4Pq1T1bvGntYhUpziO5EmFnFDEOAxlOxzkLWlnRewOFyHb2PH7aMY4XrkqJPnDi9o5S16InDTTEb2oFR3a5+p6BYF2IPxSspxmC09RJNBfGI1QrfFeIbyGL5ojCJDbawVWNrFhGOO2EFDOByP0cKHis8m35dn2olXVN5bD8zy3KaGodFiTRo1dy0ZdGV3DJxu4LSKzuXaU4t0y6AZeYhNZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI2PR06MB4267.apcprd06.prod.outlook.com (2603:1096:4:15e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:48:37 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:48:37 +0000
From:   Huan Yang <link@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Suleiman Souhlal <suleiman@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>,
        Yu Zhao <yuzhao@google.com>, Huan Yang <link@vivo.com>,
        Brian Geffon <bgeffon@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "T.J. Alumbaugh" <talumbau@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     kernel@vivo.com
Subject: [PATCH 1/3] mm: multi-gen LRU: fold lru_gen run cmd
Date:   Thu, 14 Sep 2023 18:47:43 +0800
Message-Id: <20230914104754.55-2-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914104754.55-1-link@vivo.com>
References: <20230914104754.55-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::16)
 To PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|SI2PR06MB4267:EE_
X-MS-Office365-Filtering-Correlation-Id: b73aa587-e954-4842-c263-08dbb5102637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybVcbCl7l1skbKUfIituhK3pOU19EcwbqCw/JQqOIya8kXYo+vES8mLyIaClv1J38ZS+hvgmXWFQUXFCXPJvrB008dgXh2zFerZgXX6pkstxOtfBF9tOx+fBPkK/rPw080Qp/QImgKoCJxqv4YFU0Oftc0s/5K9d+vQdhXEWAgWQieCIv73vW3X2a5Oq2YG+xvp333PZsGl7VfZGggNAmbJNAkm8rRG29LxSYaGaxadsUOx6yIxifvDDGkmtQ0RchE/KB/9+13gtB77Wsp8a9NNsDWE2Gsxn01uyu1tAN+6U2ZGHTBqyKUitnzAcRccty7psNU45QbGpY9j+IoDS5aciKEt90df6ushgzsKNMNXLBTBewCUIymTDxgGImeJgxmOEaTtJ2DhzcirKZCmYRrNadpVXASxf+bob+BNYtnZjp6rbqGoJCKaOnVmuDmvcLQ+2VguGMQ2P3ODL4FGCCtoMmAN64sRwXVOqRQQm9VbpbVwU31cE7Dubddtb4s2jhSFVAAudcyBVzgy51PAkxIin/2EwzlZaV0JPlYVc+yq0kN15QukxUY6CDo6o5S9w3nX5zixj2TLFslS3PSVfMvfNYKV9sI+qBI8WEp7EthVJL5NYCXL0xS6O0JB2NoFXThL3JmcJGkpQrVHokGZAww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199024)(1800799009)(186009)(6506007)(6486002)(52116002)(6666004)(38100700002)(36756003)(86362001)(921005)(38350700002)(1076003)(2616005)(26005)(83380400001)(107886003)(6512007)(478600001)(2906002)(110136005)(4326008)(316002)(8676002)(8936002)(41300700001)(5660300002)(7416002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OIf6VHXOFZPEurL+UTwOum+6V5RvQYiPmsJw7Mwdzq0U3nSKPZolS98/YtD3?=
 =?us-ascii?Q?Hk1mbBLQC+OopEpaGUWvd1AIChW/TwlDQ5HUVDLQjhQPmjf41i749lmYrTnQ?=
 =?us-ascii?Q?f63SrvbineYpSTAdmOMIDjMF+AuSz/0BV+XaOek6CG6JdpjkpLJ7AJq8bmzT?=
 =?us-ascii?Q?T79SPlg6TFPP3o09rqNogtQ88vUmOKDX9aaQs7v8DRcQDQVB8xxDIU4Dn63T?=
 =?us-ascii?Q?qWIZualGlAEoBfft3vvuL6qAN01IBZ2KitrG2NwDZ5TRgWk67yxY9N8Ye0xX?=
 =?us-ascii?Q?AdARIDbYpF99inGoKzxRVBSlviZ6PKgwBTF3Met+w/G7rLVgoMLbfFcYXHk3?=
 =?us-ascii?Q?7L17FkX2DlxCCOIav9LwiUVFXwhQ00SR+awkdRBXoJgF1ch9w4XJScHQ6GPk?=
 =?us-ascii?Q?l6BTzSYpbTwH0hndjSCNbnErecJh8ex0j/EezQSNa7W7IIG2XKZM01nc7uPY?=
 =?us-ascii?Q?EaUDr1SpejtvOPziW+Ffngku70+R+GfiNLmTZM2zQSArgWvRXkpOurU6tDbO?=
 =?us-ascii?Q?gxQva5lLBXbR+5oIXpPux/asbyzGJsxO+vp/fEcef+QS60LEa8KNis+g6FEf?=
 =?us-ascii?Q?9/3W2yn49HYk+wX+xXgD5DEr7sNr7C9EZTVfmOjgP3GCp9NZGHm4QsGFAo4b?=
 =?us-ascii?Q?ec5rh5ScuOhxp9gmLAeFO8hPgzulj/FI49xP3Ez0msFxHFLixvYVCqsf74rn?=
 =?us-ascii?Q?fp09SaaQvswIDW9hhvmWvAKp8ohWxVmY4olcBoOT4yp9Pd4+8uhgrMS/jnPt?=
 =?us-ascii?Q?1hTE/WhwPnIpCdiGhI1OHgLOZFhznhEicSon9Lbbzt+iZrWlyEFDi8luHNge?=
 =?us-ascii?Q?E3XuIBxkwnQxQcJGqoFi+LV2yDkwHnHJsidbRQfVYFA3xnnPScW74Tba7L09?=
 =?us-ascii?Q?YptioTVKBy/16rEP4vkZAoI3EokM1UsmsKPUr2RxumNnkmqpSoGRoYbhFS0S?=
 =?us-ascii?Q?ICcf55E1UXYkHOHkvLyezjsVEmhoOMoVTkl8Va/QDLFCG1jT0mZB/1L33WQq?=
 =?us-ascii?Q?WW+/z/1hAk+gWc75sKoSZtumULmIUtyFzMo3Jg9uM8tvBsb7hJTUCWTheR9W?=
 =?us-ascii?Q?ab0HVaskGVjn9rT8SH7wrFA3elSEASrWXD5k8Vw0a+rXMj397HKEa4RjCEA9?=
 =?us-ascii?Q?Wn3WdjaQDvkBmAFed2LLuiMUKFXJ/8zR0CEANT1Ybsw2SPfop6nWavTij5E3?=
 =?us-ascii?Q?ceFeEAlnGHOkkfIDfsrHMqBwukdjL4znmDM4nBCmQLMvV28TVJxPRsd+z7OQ?=
 =?us-ascii?Q?FerbK5fsfd/cY6g9/cO6BjZ2Tepy446sG4s/xFRXXnjCiCpNkfCaOvBjErRv?=
 =?us-ascii?Q?JMFQqNeIp4OYA2CcaqlE7XkV1SpJPQ5DzFZrggkZae/yxM9sgT80u4NjpSnb?=
 =?us-ascii?Q?ud2HzcA8N+W7NrKxZiLYdLlZybBY3Uus9teT+jHTLgJdQM4G1ta8XdpgimFi?=
 =?us-ascii?Q?PPdR5+xcSSijiLmGSQPz04rZ84oGQvYAOAZZEzqLlOQYH2ltAv4b0soIDksB?=
 =?us-ascii?Q?Aonlwz3suYnrAGnakXXQZtxVeEV/F/kiV/e7FX5EeJhqoMotCmUVnfQLx+GA?=
 =?us-ascii?Q?EL+bEaiQeNiC12Z62qN8Av47sO5pqjAqTxXG21oy?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b73aa587-e954-4842-c263-08dbb5102637
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:48:37.0229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X1Vm2JhefifHOrsmTcEGT59gWSATiCdZYqlyR4XBtUW00uW+1IZOQfUe6sklvtzDyNiTBOYSK1jQUrRsYZGVPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4267
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch move LRU_GEN define helper into mm_inline which will
used in per memcg lru gen node.

let run aging/eviction into func, per memcg also will run this.

Signed-off-by: Huan Yang <link@vivo.com>
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

