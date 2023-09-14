Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6936C7A01F4
	for <lists+cgroups@lfdr.de>; Thu, 14 Sep 2023 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjINKs4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Sep 2023 06:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjINKsx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Sep 2023 06:48:53 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2134.outbound.protection.outlook.com [40.107.215.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BA11BFE;
        Thu, 14 Sep 2023 03:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HI/xeXDzAaKhqc+B4XlSUIoGcfWe3ghjM+oax4YqIHjnBGUe01DXmtxMpC2b8cfYrphR4mhw++09e7cnFRdT11Ar63t6hBhL+JUSAITPUi/lh+/lgoTGuhSLz/EnaZBjAhAAIag+exutCX8wobtDDC3evz9WxHXyIZZND0pS84HEZh58eGBWsJIMcEP9KZvOilBPspnH+7pZQCdXIcTm+xBLz0pU2Nyjo288viJ42vME+E3VfKlDsaP7age/ZgR+VG1uMcFavSvOUK3tU33X1DxXCh4DRjsfyBv6KzMpOszElxnco3wel2wk3ggU3K6zwxJYPZ2F5utPcF/crWn77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33kzHFfosaT3/g9ZykY5vCyTfSUp4+rL/3ljfHikklM=;
 b=StJDNHlZ2KpiKMXUJCUk5CI5xAagt//Tq8VoA4cuvlmWslMqwB8nO3AH7kHMc8SrIX1K1fSgq3heojsRinkaTGN4SzPCnZHVlGcft83+UjcdChIasTZW4iM2iDpXWBPeGJksSNOeL9cabTCQC3D0IFWRP+Oc/9trPx5+BKvaBaP0PVj6umUBMYhKd07b9+8MsUu/V+k0P3bhPlG0wf38npZ+/b+n+64va2MtAK8PYgqoGNx7Ou1elHCIMnKRaLFQa2G3KrB7cP+qyUcXtcuFd5njeaEZa3w55wo4L91tAeJegj4+TEW0vAzbkQYPfAhmdpnSywRA2xMjKXIOIV+K4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33kzHFfosaT3/g9ZykY5vCyTfSUp4+rL/3ljfHikklM=;
 b=fykUqdvv0ARCGvduwSmSyeZieb4iagXe1y8y8SWrC93GOlWmcTPIVdT3h1JGsGVWawaUcL2YDcvPxY5ABwmlT0eDLsQaNUdlQ4EyDsFs77ZsT1Xv91xapLeirUrUKRfwJPRAU+zcSbDel+AsX7O3JEGWmnhnMAXOmKxqbfdCcgC9xtSQQb42gKnaWxhepmI0fufkOtJB1q03k+3BvYATibcoLLmlO+dKF3CAh5gjSSp1vlXy64uh7g8rJQI65nkZk/Dih3DYUQbtF11QbfedSeJgKmU7nLkEqNINplhMxi0GuA9bJE3T+MC/bkqtOeS+XL1s1QgRYJLzcJBDLG/76w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by SI2PR06MB4267.apcprd06.prod.outlook.com (2603:1096:4:15e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 10:48:45 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::64c1:bd7f:ced7:7d02%4]) with mapi id 15.20.6792.020; Thu, 14 Sep 2023
 10:48:45 +0000
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
Subject: [PATCH 2/3] mm: memcg: add per memcg "lru_gen" node
Date:   Thu, 14 Sep 2023 18:47:44 +0800
Message-Id: <20230914104754.55-3-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94820ea5-d049-4b99-c1db-08dbb5102b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1MahWZvQTmME7axQj3ySs4GyBhPqw8gHl25Usdf24O9fwFfVHnzjdmySALkJmWJkUmoilmx8jZS6WdQSSlwoSUoW8Vv6kJ7UL/HI6DgZTk5W5LX7mI2vr71B5gPMa5TKRhyF8Ou36VnEN7XxXqob3g+GZLYF4Dg0eunDCqVcfhmpzOLsgpfenIqvEVgsNhZCGA8plgah0egSxCA8MlcyrLIi8uAB9ZJ6jgDo/U0W7zsS+TldzxXq5zoPUDiQQVLuNb53pgW+ogtqdJVgAyajBjTZD4ohyxWLYR6aLL2sBZhyZMu6MzYtpHfzKW0GQ2FCy2Hl0h848fz27giVRuSkUtDPILK1jW6fgp8zb17hABv/wHBu+BLj4Ep0QkaCA2jqgGFrZYdbNz2YV8ZpM/46EmHsjkXYFvWIUpRxYNdnc68sKQArVq8zkWsFm1bjzl8rRtrEJiaphs0BzCVCSenIS96ccuQVyP2grN6Dp58pVNL6gjJzGhtt7DOGOWM5bdpSPKpiGG874SWQ2SxW0nQ7VPFbag6+8/hIaHiwAhnAunfG1eG2RdMJhwW59HroXpyRwU9HTlCrIz71D4Cp/80z1PFu/P0W39emr6+WqpvJoqEw/kQOfx56kdcgla8ef6aSTT1TocQq2A/g7TLNpYQmQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199024)(1800799009)(186009)(6506007)(6486002)(52116002)(38100700002)(36756003)(86362001)(921005)(38350700002)(1076003)(2616005)(26005)(83380400001)(107886003)(6512007)(478600001)(2906002)(110136005)(4326008)(316002)(8676002)(8936002)(41300700001)(5660300002)(7416002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aYF/4aKs2sZ31o+Z2L0iJdi9WeDRgvrbqBNQXIVbZuNrgPq6+lk8Q4SyOrH6?=
 =?us-ascii?Q?59Wv/RUNqsbIf2vqpfH3QuZX8AQnPi20nNYeVk2RQkc+O7K0eQvmVPPp3LXq?=
 =?us-ascii?Q?rzh87PDpo3oUxrp2OqksVsUIWYgX/KGafin6e0QmgO94KbSJU9i//5dQ1a/3?=
 =?us-ascii?Q?aj8qzi3uw2efy1IelkcAbpON+rSwn5SaOMxDVUYjzbJ0CQbY1H2oXBvUYzsU?=
 =?us-ascii?Q?mKXasUJpUP8ERXbtXfB9tdxqj3Sn1D23kXKWgEHsH0cb+U5xoAekuEE+GVpK?=
 =?us-ascii?Q?nd0jRDhwBN182JfLN0khTAzuAUNuucDxv6MzA+AR5i5RmnNXcQ5kXI5JDFkt?=
 =?us-ascii?Q?3LYCz2TP5s1vTFHRPbtIX6YWRd/Z95+DpoOrmj+Lds1l5ajN1rUXARqHbmR3?=
 =?us-ascii?Q?B1AmtG663PnDnTtoLuAeNsXLxv8Sd6VafOcwAXDxwI4h0NnQSAolxkZAU0Hl?=
 =?us-ascii?Q?FpmIpOV0ObqmHqbX9jGv826qjbCfeDjQtAEKghkLAE4zeqLpeBG2qTyL+Ijl?=
 =?us-ascii?Q?W9kt0AOcup8m4aAjZ5LoKGVl9efVG+upCxPmmLNxX0xSxef1RrCfRnrzGoUH?=
 =?us-ascii?Q?mgsLmbqyuyfzlNa5IdPVFHfLgqgoR2i9p8ekg/zaeIq75LK2KlqSll2YbpmL?=
 =?us-ascii?Q?3PC7Dr5Ec99QPOqX1W/QwPjwfN5tgMLIsni4Jme4s5p1yN8Vl9Tv1qSh+8Q/?=
 =?us-ascii?Q?hKqUGnMD83GkBxZrgT4gT+mP0n2I6d+2cFp8M6YaVEwcZokvPOWlHE1RHBqU?=
 =?us-ascii?Q?LdJ6qh0sGkyfbhxFKthIn7i9lqjIdSQoauLNsjtvhuSDiaBbELi7MP+mZy6J?=
 =?us-ascii?Q?GjBaS9X+uElZ72UKHFk4I1UZ4waWaZSLAqbt24YouCYOP3y1Es6429ahdPY1?=
 =?us-ascii?Q?QaJfnL5iphubyMOMrABIfb0flzMkaxlDvltGX7/7N1NQV+WRAWzXg+5rkjh2?=
 =?us-ascii?Q?lxKasiHPwfcSkHVi4jlAj9YlKeqx7kJdmtieTpC8kEam39+H6gAx/yI3Jhs1?=
 =?us-ascii?Q?wAseHny5xIaV0SoJ1AtWi5VL6clGJ9YIHQukdYpNhJAuMl/KXOcHgdLQy8mc?=
 =?us-ascii?Q?Sn94aML8ml2E9utrJIfuao7pqk2D21LHyRVa2rA7QV9Mj136VluFSAo44LA2?=
 =?us-ascii?Q?dxIyIZvDh+OoYAn1Z440n0CkxB/r2UHPi3Xz1L+2E/bk0qA4YE8jPW5dqIeZ?=
 =?us-ascii?Q?afmWdWSzwJrD5aRfy4nQMSVvC8BfPAPgi3TxzqxgUbToqn2o+VCWBJ82nU6/?=
 =?us-ascii?Q?iDm/g8FHtNIE/yKDF7blNWLaSCRdoISRwVRkgBPi2gSH4v+aTNOVlvP2cuAC?=
 =?us-ascii?Q?q9E5uJYzPkZwXXG0TIy3KLSkw8EvC8UhGkSGsJsFxSwn8E384l5DlZ/6r5xN?=
 =?us-ascii?Q?8bBjxPudGZlk0NJY+kGTC77YNIBzRtAnECC0yHo3fXAQCkZo8ON4hFCyQu0I?=
 =?us-ascii?Q?RCtvYYOuNVbS6lKVi3SZLIQ0J2ZzXrVWDyf9GDXMmjAlm3YDdpS0PKbuRDe/?=
 =?us-ascii?Q?irlWdiSmK48C7/X7NB3HXwFWJviaTWLV8l0YqLcxIMBxWbZ4hzDu0ejoOP+f?=
 =?us-ascii?Q?xiG53xuVivoj/hNm3NeqAp6aAmDskk5y91e+wCt3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94820ea5-d049-4b99-c1db-08dbb5102b62
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 10:48:45.6948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm59AwrKOXz5Rp0owZ2a2u3WuAc4uBbvBwCI3jK7Ib+QzYwbsxsSymt/CeK5Stf5veAqpzSwcopRzx5r4obzGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4267
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch add "lru_gen" node in mem cgroup both in v1 and v2.

mem_cgroup_lru_gen_show just like global node, show lru_gen info,
but always show the full info due to per memcg no need to simple output.

Just like global node, per memcg "lru_gen" node can input cmd, but we
no need to type memcgid anymore to select one memcg.

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/mmzone.h |   4 +-
 mm/memcontrol.c        | 163 +++++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c            |  37 ++++++++++
 3 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 4106fbc5b4b3..3d399ef177a4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -553,7 +553,9 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg);
 void lru_gen_offline_memcg(struct mem_cgroup *memcg);
 void lru_gen_release_memcg(struct mem_cgroup *memcg);
 void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid);
-
+int mem_cgroup_lru_gen_cmd(char cmd, struct mem_cgroup *memcg, int nid,
+			   unsigned long seq, int swappiness,
+			   unsigned long opt);
 #else /* !CONFIG_MEMCG */
 
 #define MEMCG_NR_GENS	1
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ecc07b47e813..56385142c5b8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5052,6 +5052,155 @@ static int mem_cgroup_slab_show(struct seq_file *m, void *p)
 
 static int memory_stat_show(struct seq_file *m, void *v);
 
+#ifdef CONFIG_LRU_GEN
+static ssize_t mem_cgroup_lru_gen_write(struct kernfs_open_file *of, char *buf,
+					size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int n;
+	int end;
+	char cmd;
+	unsigned int nid;
+	unsigned long seq;
+	unsigned int swappiness = -1;
+	unsigned long opt = -1;
+	int ret;
+
+	buf = strstrip(buf);
+	n = sscanf(buf, "%c %u %lu %n %u %n %lu %n", &cmd, &nid, &seq, &end,
+		   &swappiness, &end, &opt, &end);
+	if (n < 3 || buf[end])
+		return -EINVAL;
+
+	if (nid < 0 || nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY))
+		return -EINVAL;
+
+	ret = mem_cgroup_lru_gen_cmd(cmd, memcg, nid, seq, swappiness, opt);
+	if (ret)
+		return ret;
+
+	return nbytes;
+}
+
+static void __lru_gen_show_info_full(struct seq_file *m, struct lruvec *lruvec,
+				  unsigned long max_seq, unsigned long *min_seq,
+				  unsigned long seq)
+{
+	int i;
+	int type, tier;
+	int hist = lru_hist_from_seq(seq);
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+
+	for (tier = 0; tier < MAX_NR_TIERS; tier++) {
+		seq_printf(m, "            %10d", tier);
+		for (type = 0; type < ANON_AND_FILE; type++) {
+			const char *s = "   ";
+			unsigned long n[3] = {};
+
+			if (seq == max_seq) {
+				s = "RT ";
+				n[0] = READ_ONCE(lrugen->avg_refaulted[type][tier]);
+				n[1] = READ_ONCE(lrugen->avg_total[type][tier]);
+			} else if (seq == min_seq[type] || NR_HIST_GENS > 1) {
+				s = "rep";
+				n[0] = atomic_long_read(&lrugen->refaulted[hist][type][tier]);
+				n[1] = atomic_long_read(&lrugen->evicted[hist][type][tier]);
+				if (tier)
+					n[2] = READ_ONCE(lrugen->protected[hist][type][tier - 1]);
+			}
+
+			for (i = 0; i < 3; i++)
+				seq_printf(m, " %10lu%c", n[i], s[i]);
+		}
+		seq_putc(m, '\n');
+	}
+
+	seq_puts(m, "                      ");
+	for (i = 0; i < NR_MM_STATS; i++) {
+		const char *s = "      ";
+		unsigned long n = 0;
+
+		if (seq == max_seq && NR_HIST_GENS == 1) {
+			s = "LOYNFA";
+			n = READ_ONCE(lruvec->mm_state.stats[hist][i]);
+		} else if (seq != max_seq && NR_HIST_GENS > 1) {
+			s = "loynfa";
+			n = READ_ONCE(lruvec->mm_state.stats[hist][i]);
+		}
+
+		seq_printf(m, " %10lu%c", n, s[i]);
+	}
+	seq_putc(m, '\n');
+}
+
+
+static int __lru_gen_show_info(struct seq_file *m, struct mem_cgroup *memcg, int nid)
+{
+	unsigned long seq;
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	DEFINE_MAX_SEQ(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+	char *path = kvmalloc(PATH_MAX, GFP_KERNEL);
+
+	if (unlikely(!path))
+		return -ENOMEM;
+
+	if (nid == first_memory_node) {
+		cgroup_path(memcg->css.cgroup, path, PATH_MAX);
+		seq_printf(m, "memcg %5u %s\n", mem_cgroup_id(memcg), path);
+	}
+
+	seq_printf(m, " node %5d\n", nid);
+
+	if (max_seq >= MAX_NR_GENS)
+		seq = max_seq - MAX_NR_GENS + 1;
+	else
+		seq = 0;
+
+	for (; seq <= max_seq; seq++) {
+		int type, zone;
+		int gen = lru_gen_from_seq(seq);
+		unsigned long birth = READ_ONCE(lrugen->timestamps[gen]);
+
+		seq_printf(m, " %10lu %10u", seq, jiffies_to_msecs(jiffies - birth));
+
+		for (type = 0; type < ANON_AND_FILE; type++) {
+			unsigned long size = 0;
+			char mark = seq < min_seq[type] ? 'x' : ' ';
+
+			for (zone = 0; zone < MAX_NR_ZONES; zone++)
+				size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+
+			seq_printf(m, " %10lu%c", size, mark);
+		}
+
+		seq_putc(m, '\n');
+
+
+		__lru_gen_show_info_full(m, lruvec, max_seq, min_seq, seq);
+	}
+
+	kvfree(path);
+
+	return 0;
+}
+
+static int mem_cgroup_lru_gen_show(struct seq_file *m, void *v)
+{
+	int nid, ret;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for_each_node_state(nid, N_MEMORY) {
+		ret = __lru_gen_show_info(m, memcg, nid);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+#endif
+
 static struct cftype mem_cgroup_legacy_files[] = {
 	{
 		.name = "usage_in_bytes",
@@ -5172,6 +5321,13 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.write = mem_cgroup_reset,
 		.read_u64 = mem_cgroup_read_u64,
 	},
+#ifdef CONFIG_LRU_GEN
+	{
+		.name = "lru_gen",
+		.write = mem_cgroup_lru_gen_write,
+		.seq_show = mem_cgroup_lru_gen_show,
+	},
+#endif
 	{ },	/* terminate */
 };
 
@@ -6831,6 +6987,13 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+#ifdef CONFIG_LRU_GEN
+	{
+		.name = "lru_gen",
+		.write = mem_cgroup_lru_gen_write,
+		.seq_show = mem_cgroup_lru_gen_show,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f59977964e81..4da200cda0b9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6072,6 +6072,43 @@ static int __process_one_cmd(char cmd, struct lruvec *lruvec, unsigned long seq,
 	return err;
 }
 
+#ifdef CONFIG_MEMCG
+int mem_cgroup_lru_gen_cmd(char cmd, struct mem_cgroup *memcg, int nid,
+			   unsigned long seq, int swappiness, unsigned long opt)
+{
+	int err;
+	struct lruvec *lruvec;
+	unsigned int flags;
+	struct blk_plug plug;
+	struct scan_control sc = {
+		.may_writepage = true,
+		.may_unmap = true,
+		.may_swap = true,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+	};
+
+	set_task_reclaim_state(current, &sc.reclaim_state);
+	flags = memalloc_noreclaim_save();
+	blk_start_plug(&plug);
+	if (!set_mm_walk(NULL, true)) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	lruvec = get_lruvec(memcg, nid);
+	err = __process_one_cmd(cmd, lruvec, seq, &sc, swappiness, opt);
+
+done:
+	clear_mm_walk();
+	blk_finish_plug(&plug);
+	memalloc_noreclaim_restore(flags);
+	set_task_reclaim_state(current, NULL);
+
+	return err;
+}
+#endif
+
 static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 		   struct scan_control *sc, int swappiness, unsigned long opt)
 {
-- 
2.34.1

