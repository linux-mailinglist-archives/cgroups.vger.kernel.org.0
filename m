Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E545A1E0E
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 03:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244169AbiHZBSp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 21:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbiHZBSm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 21:18:42 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4F5C9E96;
        Thu, 25 Aug 2022 18:18:41 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MDMMb1t1gzlWPM;
        Fri, 26 Aug 2022 09:15:23 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:18:39 +0800
Received: from ubuntu1804.huawei.com (10.67.174.175) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 09:18:39 +0800
From:   Lu Jialin <lujialin4@huawei.com>
To:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
CC:     Lu Jialin <lujialin4@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: [RFC 2/2] memcg: Adapt cgroup.top into per-memcg
Date:   Fri, 26 Aug 2022 09:15:03 +0800
Message-ID: <20220826011503.103894-3-lujialin4@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826011503.103894-1-lujialin4@huawei.com>
References: <20220826011503.103894-1-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.175]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup.top is able to show resource usage information for each cgroups.
Currently only memory usage is monitored ,including usage,anon,file,
kmem(Bytes), stats for other resource types would be added as well.

Show case:
/ # mount -t cgroup2 none /sys/fs/cgroup
/ # cd /sys/fs/cgroup/
/sys/fs/cgroup # echo "+memory" > cgroup.subtree_control
/sys/fs/cgroup # mkdir test1
/sys/fs/cgroup # mkdir test2
/sys/fs/cgroup # mkdir test3
/sys/fs/cgroup # echo $$ > test2/cgroup.procs
/sys/fs/cgroup # cd /test
/test # ./memcg_malloc 512000 &
/test # ./memcg_malloc 512000 &
/test # ./memcg_malloc 512000 &
/test # cd /sys/fs/cgroup
/sys/fs/cgroup # echo $$ > test1/cgroup.procs
/sys/fs/cgroup # cd /test
/test # ./memcg_malloc 512000 &
/test # cd /sys/fs/cgroup
/sys/fs/cgroup # echo $$ > test3/cgroup.procs
/sys/fs/cgroup # cat cgroup.top
memory top:
name            usage           anon            file            kernel
test2           1974272         1671168         0               270336
test1           700416          569344          0               94208
test3           196608          86016           0               86016

Signed-off-by: Lu Jialin <lujialin4@huawei.com>
Co-developed-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/memcontrol.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b69979c9ced5..e4d4afefe5a6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5480,6 +5480,92 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	}
 }
 
+static int cmp_usage(const void *a, const void *b)
+{
+	struct mem_cgroup *memcg_a = *(struct mem_cgroup **)a;
+	struct mem_cgroup *memcg_b = *(struct mem_cgroup **)b;
+
+	return page_counter_read(&memcg_b->memory) -
+	       page_counter_read(&memcg_a->memory);
+}
+
+static int child_memcg_css_count(struct cgroup_subsys_state *css)
+{
+	struct cgroup_subsys_state *child;
+	int count = 0;
+
+	css_for_each_child(child, css)
+		count++;
+
+	return count;
+}
+
+struct memory_top_info {
+	const char *name;
+	unsigned long idx;
+};
+
+static const struct memory_top_info memory_info[] = {
+	{"anon",			NR_ANON_MAPPED},
+	{"file",			NR_FILE_PAGES},
+	{"kernel",			MEMCG_KMEM},
+};
+
+static void mem_cgroup_css_top(struct cgroup_subsys_state *css,
+			       struct seq_file *seq)
+{
+	struct mem_cgroup **array;
+	struct cgroup_subsys_state *child;
+	int memcg_number = child_memcg_css_count(css);
+	int i, j;
+	int count = 0;
+
+	mem_cgroup_flush_stats();
+
+	array = kvmalloc_array(memcg_number, sizeof(struct mem_cgroup *),
+			       GFP_KERNEL);
+	if (!array)
+		return;
+
+	css_for_each_child(child, css) {
+		struct mem_cgroup *memcg = mem_cgroup_from_css(child);
+
+		if (count == memcg_number)
+			break;
+		array[count++] = memcg;
+	}
+
+	sort(array, memcg_number, sizeof(struct mem_cgroup *), cmp_usage, NULL);
+
+	seq_printf(seq, "%s top:\n", css->ss->name);
+
+	seq_puts(seq, "name\t\tusage\t\t");
+	for (j = 0; j < ARRAY_SIZE(memory_info); j++)
+		seq_printf(seq, "%s\t\t", memory_info[j].name);
+	seq_puts(seq, "\n");
+
+	for (i = 0; i < memcg_number; i++) {
+		struct mem_cgroup *memcg = array[i];
+		unsigned long usage = page_counter_read(&memcg->memory);
+		struct cgroup *cgroup = memcg->css.cgroup;
+		const char *name = cgroup->kn->name;
+
+		seq_printf(seq, "%s\t\t%lu\t\t", name, usage * PAGE_SIZE);
+		for (j = 0; j < ARRAY_SIZE(memory_info); j++) {
+			u64 size;
+
+			size = memcg_page_state_output(memcg,
+						       memory_info[j].idx);
+			seq_printf(seq, "%llu\t\t", size);
+		}
+		seq_puts(seq, "\n");
+	}
+
+	kvfree(array);
+
+}
+
+
 #ifdef CONFIG_MMU
 /* Handlers for move charge at task migration. */
 static int mem_cgroup_do_precharge(unsigned long count)
@@ -6600,6 +6686,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
+	.css_top = mem_cgroup_css_top,
 	.can_attach = mem_cgroup_can_attach,
 	.cancel_attach = mem_cgroup_cancel_attach,
 	.post_attach = mem_cgroup_move_task,
-- 
2.17.1

