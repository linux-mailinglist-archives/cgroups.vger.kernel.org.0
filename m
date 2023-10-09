Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCC7BD244
	for <lists+cgroups@lfdr.de>; Mon,  9 Oct 2023 04:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjJIC6R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Oct 2023 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjJIC6O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Oct 2023 22:58:14 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2124.outbound.protection.outlook.com [40.107.255.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA70E4;
        Sun,  8 Oct 2023 19:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MSMpnKQwYJKTbP2Hb04ixAgCTakPl2b4NuV8mDywI/0YvbVA3z36tBk16aqpn+MNpc/d99YuH1JyfLueDKeJ6poC+EgTuR3JmBDYrCePX/2zK8Nb8UTRcOXqNgeu0snU/sFDtDxB59x25IZdsuEGFjaYm4leDrf6c9HX2kETJtppFWfFteDQOfE2h3TT4JMIGXvmPKruIYeANT1KH98gjmsMXR2R6rZlltOnZ9E1Z7tsZvMONqCuX9+h/xRhvZ6QYaooRzBGKGgy+v7jVDuSLcOdt8tqs1EIMCBJHBV1Tv8FL1PitaFhq/UFF1+OFuMOGu0FtNha/yEzlZVNvalrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig9Ha7nnM7rsdaFJWSYfdcWwPLi1FA9WU93YxlOKSTw=;
 b=bUgxArmCJ4AUs9PynN2BG7mby1X0Msxk88TmQOQantQmn3fi12gf9YuwHW62WcWIz1wWzXqTsOTCnm6A+m5zW4wDNgif5aMk2oOU60eUChk0jMuzwXDwQy+K8qog2C6BNoloMcpjUp5jjmFHEt0wH3Y36DAzUlLujLlYDS1GPOS/06hBQXBHgOD57E4Pjn6jR0m63lwot2a3zFsJq/D2EE6fUX9hKTg050MzkhFjK1p7fDW3FgQP7W5qqef/rjNyC0PcdHP8Xuzyq/l5LjqdzL47fNG8PUMKWgC6rtvfcie++cssvvWA1VjYTWnrSIVxCRjqb5irDM0gaVCYF5rYSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig9Ha7nnM7rsdaFJWSYfdcWwPLi1FA9WU93YxlOKSTw=;
 b=J3aPdzpHe5nJqkZiGkSlFr+loD7dvO4eDDjpbpBPYCUzbuCNbMyElq85rMDN2fhLtcH2+9wdbzkrLffeUQBt60x1fuhUKVzJ3SLbe6OkPQot1jiSvemqASHnrUOOfZIJ+sZY9g/NicyYde+S/5BK2x7ogyaZ0cZmLGUsa1Cys5pfflhNmj05pbsnDi8ym3YcxNIkl1ySUtlrCkJq5E/COdsdlH/yd8oPB+M3rB2ChR/tGAj/YHDgLZYPRAIwax0/a8mcGJfowYcyUrNKm90SAo3ZoyyJAYwsLCneE504xAZpug4nck/LQDb5RYYn7De+ozvcNG8MdHhJoiPyIaY6ew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by TY0PR06MB5428.apcprd06.prod.outlook.com (2603:1096:400:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 02:58:08 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 02:58:08 +0000
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
Subject: [PATCH 2/3] mm: memcg: add per memcg "lru_gen" node
Date:   Mon,  9 Oct 2023 10:57:21 +0800
Message-Id: <20231009025726.5982-3-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 19fa420f-6076-4659-15e1-08dbc873912f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qTqwUBPmzRDTvYyledPNQJgrffoG18cE/rPISI28a7g7frst57q3uFm50EOOD9Fe4Q6c7Z5kqRDvdDWEjfKhytqVwPWpWNZzeiaqINdwB8CXYp652qdgwpLh5Di6/A2mihJx4+fe+RtWV7BU2cho4HHlSgW5WPIOwn4dlOfe0T81lQgyHFoasqBqY29BqjAKD/VegxTsaDlozHxbadF54weu1WGjHd72UwLHjfEbRJ8iMpbDWFs7oVPBAqOE5KaTBC/9OXU/0+zKxJH5Rnvr4moPVaPmv23LH3NK/DVgfRJGeW4/9kJkINbcuCxfAYUpdKZhW25sV44lzjepSn5SjXhDxnpuIAv/59bEJcD7ekl43bZBzGbkLULuB+k3AFwb4c5NYN+5ore529+II5o8rGrB1ohKQ4Phf5/ZuOTR2FWmF/tidZf9VlOaF2yDdBBG/8WRvbRv/6jv5rNQlD8ZIBJmOqSozpKgXesOWL/mNhMP33bW8tMiGlR2+uhebmLWD1AqlyB6Kwi4aeYPdX/r2VEo38ApU4R5NhCHI4hc9m7VuEEDjdEErun/T0Z2XtPjKpC+d9eZqJz9faMT+yqaCeZfsYZOOUReD3k+oT5HIbdz8Pq/mwt/K6utuFoIU+5LFyttNbPFCcDdDH3WmN1cTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(52116002)(1076003)(2616005)(26005)(478600001)(6506007)(6666004)(6512007)(107886003)(83380400001)(8676002)(7416002)(2906002)(8936002)(4326008)(66556008)(110136005)(66476007)(66946007)(6486002)(5660300002)(41300700001)(316002)(38350700002)(921005)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K4e0sOIx0Fy3x6VJaPJFC5t8L5IxkqjPddG2/OXcK/xZxvnfgKcOKwMwdlg7?=
 =?us-ascii?Q?baohOc4OJA1o8GYtHyrMjt1HIGtEkzflOct55tmDS17snV5OonwIUKgZTmY5?=
 =?us-ascii?Q?AupaM5ANUIO4p4h44EDHdjrW5bd3geeDnmJxsNh3aTce77rmwTpsZhk59gKi?=
 =?us-ascii?Q?O4SVeFP8C4uOcP/vLo527M6tMEJTQRAqvtBGzjvM3loD4QLP7ui+gc8tnwCz?=
 =?us-ascii?Q?XR5GK9BXyaWDGOWmZETgRxcibn0WvKKV3HfxG3ieTSY1i99V9GK4i2Njagxu?=
 =?us-ascii?Q?J5+B1rXqD4uuHk1Dz8ry1TlOvPkm+Z28z3bHtbshCIeWBtSsX8rcR7nySeK9?=
 =?us-ascii?Q?2UOlPLKfW8DAajjd0XpLYLlKd/gEatj4FAktmP1SqV9aGY3ERVqgiPP6ODl9?=
 =?us-ascii?Q?x0c53rHPH8fzkiWprxCewW996I0w9yk+9sOX8D3QCKvBN/ZZPK/toPHwaiOO?=
 =?us-ascii?Q?9Az9/tmQq2v/S6aP54LJOBxMOkXtQjeTJeF7YnP08MCYettWG0RYxMdK4G3f?=
 =?us-ascii?Q?IowzpG56lDJBBDxZHJ6qyaRxbvqqUMFJ/ods9Mq/Vp9Qb+9Te3YkEXGmTgvJ?=
 =?us-ascii?Q?orEb9BE6nZ89qN/m4/JoeBn9EbR0me6glwjJ8MO/00gNaHa6nZCmks5PmG3c?=
 =?us-ascii?Q?aXmx2JQFgJdKQEawyVSH2DzHzlnznMUBxF/rHOha/2t3NuNm0iSMTFQ479vO?=
 =?us-ascii?Q?T8Fhop8iyLxLfQFx5HDNFEkxSBUsnk13jxAe/wzwOq50LhPwxpCsDvOLVgBm?=
 =?us-ascii?Q?uR4xc3dAxPoLJxGFYxbv5FyjrN7XNjZk/6tbGDzT9OFg3Chv7g8Z8wy2cTZ/?=
 =?us-ascii?Q?Qk6rTyxCTMJxcAzvvTFYyix2x5/Gx4LgjxMuInhtcy0vjdjhs6FNXZs2Do2Q?=
 =?us-ascii?Q?jYhV/gY6nLZs3UkFnpoI107MLmfX2grMvc9kD8XOSwYEjxoEGZh7RhbLfq6I?=
 =?us-ascii?Q?Ijtd53wQ7WblIIqxBY4kxoqrgIlxQrhk5SSEZqPxst0WnZse+HgCqTwAKpar?=
 =?us-ascii?Q?UbMT/2eMXZICurCLnFqz/lklnZIp8RFSrGzHlV6jgBh0HH1sE69tG/mNF9q5?=
 =?us-ascii?Q?Ikk70//CbJjHfqW5Pwxk2LZSP3eLzE9Fc8OFt5fBzawhRfVgCTVX/DTJu5Uf?=
 =?us-ascii?Q?o3sTkIl27bDIXtYeni6rCusCVGmeZbqeav8viAg6dTwzDqpUHn5NoYdY6dI+?=
 =?us-ascii?Q?wBe0RnolC8K47IyUEt176ryQp7yq7LaENk7TTvtZtrQwQBuQgvzbnw56j/oi?=
 =?us-ascii?Q?Yq0muRIct8bCSVx4vHgkL+VZUn+vWTNMr9gIADOEHDWqP3MeGrp7NB4nvWdx?=
 =?us-ascii?Q?DPdiOeHL6jIEWPicu1LbKKKUvH7l9gj6tOA6KfEQe1QYJq9uhDKBQ1D71mg2?=
 =?us-ascii?Q?IV4TRKoq6LxClzgFaGFM7bRLFaLfmSXsdcRzMtr04U4TCo9x+JS7zwVHXhAQ?=
 =?us-ascii?Q?cLzswkSR01/2QI74NRZGwIpRp4b+VqLhfIONjzoM4DNk5ux2Z9RJVz/vAdFz?=
 =?us-ascii?Q?0Bt0D7pjqnsqndFlQ3DnhHftD11xfz3nCt3l02uXAx12vvnziPwqTZK3Qxml?=
 =?us-ascii?Q?F6VZOFFj0O7NUvdaGrHNtYpwZBcbjc4sFye5Ch3N?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fa420f-6076-4659-15e1-08dbc873912f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 02:58:08.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrwlA/SuXWLjbv6cO5Qr0kT1PN5S4U6uG55/pMODy80tzj5k4o/S5NdrqpY5K+obd/c36LxHugHN6m7xveFyCQ==
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

This patch add "lru_gen" node in mem cgroup both in v1 and v2.

mem_cgroup_lru_gen_show just like global node, show lru_gen info,
but always show the full info due to per memcg no need to simple output.

Just like global node, per memcg "lru_gen" node can input cmd, but we
no need to type memcgid anymore to select one memcg.

Signed-off-by: HuanYang <link@vivo.com>
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

