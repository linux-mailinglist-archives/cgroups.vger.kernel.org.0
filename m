Return-Path: <cgroups+bounces-13346-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKj7EKrLcGkOaAAAu9opvQ
	(envelope-from <cgroups+bounces-13346-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 13:50:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C7257149
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 13:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 543E14C8EAB
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19F481244;
	Wed, 21 Jan 2026 12:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H8Is8c8I"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA548035F
	for <cgroups@vger.kernel.org>; Wed, 21 Jan 2026 12:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999229; cv=none; b=pTfZvaiD7ueSRW5yp8nGpMCj1Q0gES2Rtb1onvmgDXwdDPx/PY1nKZ8wTqJEsUgP+fRAKyKCHzzno2JfkBr0hyOMBz5RqUEit2rDJ7E/JICbVMn1HepqcWJJANdP2LsFn5CrN9B0YvidIZVsei4WGqBh24iZgwAKZPWh3tczr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999229; c=relaxed/simple;
	bh=zew5EPs717atHyJFUgxBnAkH6NyfFZa2MuxiI/3qqLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfgnINSbDmXX/M3SGt4AKPaUUtVo4bqk++M8HKGk2u/3gyfTOR4QiaTuHmM9i6Uxc6IBl+upDYlgfQb8wJjZHZ2lcjzQyWOxdF8bD+H93pLHCnsS2CNfb5Gx8veVcRJg08s2th4QXlqsoLTusFrbw8LpZgeynuFxHsm9ukacrOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H8Is8c8I; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768999223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ub1o/UU9lFxzM8mJWX00aqCeT1WEF1iMiFUlWX3OVEs=;
	b=H8Is8c8IaHPnOwad/rRTj56YFZ8Ms799UmTCQhh71bj3jzuRNfese7/hBIpKIhBgFRgVdG
	TBwbsDV3zHmS/E+2KoQrQ7t9wPO+SfdsIzGqtes5hBe2I/CaZUBNA85ELYcUt4ULAcYZq0
	StruNHCC2ipA6tBTOIqK5AlfM9tYtr4=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] mm/lru_gen: add memory.lru_gen interface for cgroup v2
Date: Wed, 21 Jan 2026 20:39:48 +0800
Message-ID: <20260121123955.84806-3-jiayuan.chen@linux.dev>
In-Reply-To: <20260121123955.84806-1-jiayuan.chen@linux.dev>
References: <20260121123955.84806-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13346-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,cgroups@vger.kernel.org];
	TAGGED_RCPT(0.00)[cgroups];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shopee.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: E1C7257149
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Add a memory.lru_gen interface to cgroup v2 that allows users to
interact with MGLRU directly on a specific cgroup without needing
to know the internal memcg_id.

Read (cat memory.lru_gen):
  Display lru_gen information for this memcg across all NUMA nodes.

Write (echo to memory.lru_gen):
  Execute aging or eviction commands.
  Format: cmd nid seq [swappiness] [opt]
    cmd: '+' for aging, '-' for eviction
    nid: node id
    seq: generation sequence number
    swappiness: optional, or 'max' for anonymous memory only
    opt: force_scan for aging, nr_to_reclaim for eviction

Example:
  # Show lru_gen info
  cat /sys/fs/cgroup/mygroup/memory.lru_gen

  # Run aging on node 0 with seq 100
  echo '+ 0 100' > /sys/fs/cgroup/mygroup/memory.lru_gen

  # Run eviction on node 0 with seq 99, swappiness 50, reclaim 1000 pages
  echo '- 0 99 50 1000' > /sys/fs/cgroup/mygroup/memory.lru_gen

Test result:
cgcreate -g memory:test_group
// create 1GB page cache, loop access 200MB as hot pages.
cgexec -g memory:test_group ./cache_sim &

cat /sys/fs/cgroup/test_group/memory.lru_gen
 node     0 (min_seq=0/0, max_seq=3)
          0      48744          0           4
          1      48744          0           0
          2      48744         24      262144
          3      48744          0           0
 node     1 (min_seq=0/0, max_seq=3)
          0      48744          0           0
          1      48744          0           0
          2      48744          1           0
          3      48744          0           0

// age
echo '+ 0 3' > /sys/fs/cgroup/test_group/memory.lru_gen

cat /sys/fs/cgroup/test_group/memory.lru_gen
memcg    35 /test_group
 node     0 (min_seq=1/1, max_seq=4)
          1     216564          0           3
          2     216564         24      262144
          3     216564          0           1
          4      14936          0           0
 node     1 (min_seq=0/0, max_seq=3)
          0     216564          0           0
          1     216564          0           0
          2     216564          1           0
          3     216564          0           0

// age
echo '+ 0 4' > /sys/fs/cgroup/test_group/memory.lru_gen
cat /sys/fs/cgroup/test_group/memory.lru_gen
memcg    35 /test_group
 node     0 (min_seq=2/2, max_seq=5)
          2     266880         23      210947
          3     266880          0           1
          4      65252          1       51200
          5       9320          0           0
 node     1 (min_seq=0/0, max_seq=3)
          0     266880          0           0
          1     266880          0           0
          2     266880          1           0
          3     266880          0           0

// age
echo '+ 0 5' > /sys/fs/cgroup/test_group/memory.lru_gen
 node     0 (min_seq=3/3, max_seq=6)
          3     318384          0      210948
          4     116756          0           0
          5      60824          1       51200
          6       3408         23           0
 node     1 (min_seq=0/0, max_seq=3)
          0     318384          0           0
          1     318384          0           0
          2     318384          1           0
          3     318384          0           0

// reclaim 200000 pages
echo '- 0 3 0 200000' > /sys/fs/cgroup/test_group/memory.lru_gen
cat /sys/fs/cgroup/test_group/memory.lru_gen
 node     0 (min_seq=3/3, max_seq=6)
          3     760308          0       10884
          4     558680          0           0
          5     502748          1       51200
          6     445332         23           0
 node     1 (min_seq=0/0, max_seq=3)
          0     760308          0           0
          1     760308          0           0
          2     760308          1           0
          3     760308          0           0

// reclaim 20000 pages
echo '- 0 3 0 20000' > /sys/fs/cgroup/test_group/memory.lru_gen
cat /sys/fs/cgroup/test_group/memory.lru_gen
 node     0 (min_seq=3/5, max_seq=6)
          3     826864          0           0
          4     625236          0           0
          5     569304          1       51201
          6     511888         23           0
 node     1 (min_seq=0/0, max_seq=3)
          0     826864          0           0
          1     826864          0           0
          2     826864          1           0
          3     826864          0           0

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 include/linux/mmzone.h | 16 +++++++
 mm/memcontrol.c        | 31 ++++++++++++++
 mm/vmscan.c            | 94 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fc5d6c88d2f0..8edb9549b435 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -625,6 +625,11 @@ void lru_gen_offline_memcg(struct mem_cgroup *memcg);
 void lru_gen_release_memcg(struct mem_cgroup *memcg);
 void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid);
 
+/* memcg interface */
+struct seq_file;
+void lru_gen_seq_show_memcg(struct seq_file *m, struct mem_cgroup *memcg);
+int lru_gen_seq_write_memcg(struct mem_cgroup *memcg, char *buf);
+
 #else /* !CONFIG_LRU_GEN */
 
 static inline void lru_gen_init_pgdat(struct pglist_data *pgdat)
@@ -664,6 +669,17 @@ static inline void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
 {
 }
 
+struct seq_file;
+static inline void lru_gen_seq_show_memcg(struct seq_file *m,
+					  struct mem_cgroup *memcg)
+{
+}
+
+static inline int lru_gen_seq_write_memcg(struct mem_cgroup *memcg, char *buf)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_LRU_GEN */
 
 struct lruvec {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75fc22a33b28..e2f13a69b891 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4565,6 +4565,30 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+#ifdef CONFIG_LRU_GEN
+static int memory_lru_gen_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	lru_gen_seq_show_memcg(m, memcg);
+	return 0;
+}
+
+static ssize_t memory_lru_gen_write(struct kernfs_open_file *of, char *buf,
+				    size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	int ret;
+
+	buf = strstrip(buf);
+	ret = lru_gen_seq_write_memcg(memcg, buf);
+	if (ret)
+		return ret;
+
+	return nbytes;
+}
+#endif
+
 static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 			      size_t nbytes, loff_t off)
 {
@@ -4649,6 +4673,13 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+#ifdef CONFIG_LRU_GEN
+	{
+		.name = "lru_gen",
+		.seq_show = memory_lru_gen_show,
+		.write = memory_lru_gen_write,
+	},
+#endif
 	{ }	/* terminate */
 };
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8ea5b67daa36..43f38f9f43c5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5668,6 +5668,100 @@ static const struct file_operations lru_gen_ro_fops = {
 	.release = seq_release,
 };
 
+/******************************************************************************
+ *                          memcg interface
+ ******************************************************************************/
+
+void lru_gen_seq_show_memcg(struct seq_file *m, struct mem_cgroup *memcg)
+{
+	int nid;
+	char *path;
+
+	path = kvmalloc(PATH_MAX, GFP_KERNEL);
+#ifdef CONFIG_MEMCG
+	if (memcg && path)
+		cgroup_path(memcg->css.cgroup, path, PATH_MAX);
+#endif
+	seq_printf(m, "memcg %5hu %s\n", mem_cgroup_id(memcg),
+		   (memcg && path) ? path : "");
+	kvfree(path);
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct lruvec *lruvec = get_lruvec(memcg, nid);
+		DEFINE_MAX_SEQ(lruvec);
+		DEFINE_MIN_SEQ(lruvec);
+
+		seq_printf(m, " node %5d (min_seq=%lu/%lu, max_seq=%lu)\n",
+			   nid, min_seq[LRU_GEN_ANON], min_seq[LRU_GEN_FILE], max_seq);
+		lru_gen_print_lruvec(m, lruvec, max_seq, min_seq, false);
+	}
+}
+
+int lru_gen_seq_write_memcg(struct mem_cgroup *memcg, char *buf)
+{
+	char *cur, *next;
+	unsigned int flags;
+	struct blk_plug plug;
+	int err = -EINVAL;
+	struct scan_control sc = {
+		.may_writepage = true,
+		.may_unmap = true,
+		.may_swap = true,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+		.proactive = true,
+		.target_mem_cgroup = memcg,
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
+	next = buf;
+	while ((cur = strsep(&next, ",;\n"))) {
+		int n, end;
+		char cmd, swap_str[5];
+		unsigned int nid, swappiness = -1;
+		unsigned long seq, opt = -1;
+		struct lruvec *lruvec;
+
+		cur = skip_spaces(cur);
+		if (!*cur)
+			continue;
+
+		n = sscanf(cur, "%c %u %lu %n %4s %n %lu %n", &cmd, &nid,
+			   &seq, &end, swap_str, &end, &opt, &end);
+		if (n < 3 || cur[end]) {
+			err = -EINVAL;
+			break;
+		}
+		if (n > 3 && strcmp("max", swap_str) == 0)
+			swappiness = SWAPPINESS_ANON_ONLY;
+		else if (n > 3 && kstrtouint(swap_str, 0, &swappiness))
+			break;
+
+		if (nid >= MAX_NUMNODES || !node_state(nid, N_MEMORY)) {
+			err = -EINVAL;
+			break;
+		}
+
+		lruvec = get_lruvec(memcg, nid);
+		err = __run_cmd(cmd, lruvec, seq, &sc, swappiness, opt);
+		if (err)
+			break;
+	}
+done:
+	clear_mm_walk();
+	blk_finish_plug(&plug);
+	memalloc_noreclaim_restore(flags);
+	set_task_reclaim_state(current, NULL);
+	return err;
+}
+
 /******************************************************************************
  *                          initialization
  ******************************************************************************/
-- 
2.43.0


