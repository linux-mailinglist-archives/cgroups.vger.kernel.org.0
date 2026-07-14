Return-Path: <cgroups+bounces-17779-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e7w5H8QqVmoz0gAAu9opvQ
	(envelope-from <cgroups+bounces-17779-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:25:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 019B3754807
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 14:25:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=honor.com header.s=dkim header.b=kzZC2sC5;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17779-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17779-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=honor.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 580E53207793
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D8F3C108F;
	Tue, 14 Jul 2026 12:15:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mta22.hihonor.com (mta22.honor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C69E3BE154;
	Tue, 14 Jul 2026 12:15:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031347; cv=none; b=i0/IV+jgWejmBGtS58lT5wIYgfu21+rCwmsm4KvttRS9hRnraSwRNICrI0KBYNkXpINoceFylpxi+2DWR1d7zFlF+wZ4XWSAsqMB0peGyP6k5W0YjmL8gw3JW1fXgPZWs0MJiviEPxkab4sIRXUrST/Pq/7DOlo79PT9r9SoZZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031347; c=relaxed/simple;
	bh=LONzgChPkSvGUxgkSO88PSwlJValMfRNHzxGIgyGodY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esAWHf7UTXzFLKWl6UFKtDWEtEwsHFFOpKfjmYfERWzr34aZPku3dsX9gKMC9fX0XlpfeLy7PMw8K3iQKXoX8lfQogPIcFiwqavQAHcuQrOKEmJIi0uXfpIFxe/Mgb4Tm64djEkJ9wt+j2Oi9ryNS4RYIuoHSkQWxb1hcnh5GWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=kzZC2sC5; arc=none smtp.client-ip=81.70.192.198
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=PTW4Mp0JJ6AVsiV1oNONd40biUPQE43rVLpkGa6ZhVA=;
	b=kzZC2sC5NeUj3xvj/4OmiYy35YCivn0Y0FA7/mkxY+i64JpI3DVxZXqTIlyqc0B6RVQqXaanh
	Ne3KgVhtuzaClsPDeY29BxbpRQ83UTtXsJrUJv4awWjVWpMBroPlhjX/5U0S2HahHPlK+PoBVQn
	nF+PLe+DjkVykBypjWQ+CWQ=
Received: from TW001.hihonor.com (unknown [10.77.229.151])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4gzytp6Dl2zYl0L8;
	Tue, 14 Jul 2026 20:15:30 +0800 (CST)
Received: from TA012-1.hihonor.com (10.77.199.132) by TW001.hihonor.com
 (10.77.229.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 14 Jul
 2026 20:15:30 +0800
Received: from localhost.localdomain (10.144.5.36) by TA012-1.hihonor.com
 (10.77.199.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Jul
 2026 20:15:20 +0800
From: Zicheng Wang <wangzicheng@honor.com>
To: <akpm@linux-foundation.org>, <yuanchu@google.com>
CC: <tj@kernel.org>, <hannes@cmpxchg.org>, <mkoutny@suse.com>,
	<corbet@lwn.net>, <kasong@tencent.com>, <qi.zheng@linux.dev>,
	<shakeel.butt@linux.dev>, <baohua@kernel.org>, <axelrasmussen@google.com>,
	<weixugc@google.com>, <david@kernel.org>, <ljs@kernel.org>,
	<liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>,
	<surenb@google.com>, <mhocko@suse.com>, <roman.gushchin@linux.dev>,
	<muchun.song@linux.dev>, <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<willy@infradead.org>, <denghaojie@honor.com>, <baoquan.he@linux.dev>,
	<kaleshsingh@google.com>, <tjmercier@google.com>, <tao.wangtao@honor.com>,
	<zhangji1@honor.com>, <wangzhen5@honor.com>, Zicheng Wang
	<wangzicheng@honor.com>
Subject: [RFC v2 2/3] mm: memcontrol: add memory.aging cgroup v2 file
Date: Tue, 14 Jul 2026 20:15:28 +0800
Message-ID: <20260714121529.2237261-3-wangzicheng@honor.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260714121529.2237261-1-wangzicheng@honor.com>
References: <20260714121529.2237261-1-wangzicheng@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TW004-1.hihonor.com (10.77.232.85) To TA012-1.hihonor.com
 (10.77.199.132)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[honor.com,none];
	R_DKIM_ALLOW(-0.20)[honor.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-17779-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[wangzicheng@honor.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:yuanchu@google.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:willy@infradead.org,m:denghaojie@honor.com,m:baoquan.he@linux.dev,m:kaleshsingh@google.com,m:tjmercier@google.com,m:tao.wangtao@honor.com,m:zhangji1@honor.com,m:wangzhen5@honor.com,m:wangzicheng@honor.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangzicheng@honor.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[honor.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,honor.com:from_mime,honor.com:mid,honor.com:email,honor.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 019B3754807

Add a write-only memory.aging that triggers MGLRU aging (max_seq
advancement) without reclaim - the aging counterpart of memory.reclaim.
Userspace ages to rebalance the anon/file distribution across
generations, then reclaims.  This is the control half of the loop;
the observability it needs lands in the next patch.

Useful for workloads such as the Android app lifecycle, where anon
concentrates in the 2nd-youngest generation while file fills the
oldest two and gets over-reclaimed.

  echo 2 > /sys/fs/cgroup/foo/memory.aging
  echo "100M" > /sys/fs/cgroup/foo/memory.reclaim

Gated by CONFIG_LRU_GEN.  Concurrent writers race on the lruvec lock;
a caller that did not advance the window gets -EAGAIN.

Signed-off-by: Zicheng Wang <wangzicheng@honor.com>
---
 Documentation/admin-guide/cgroup-v2.rst       | 35 +++++++++++++++++++
 Documentation/admin-guide/mm/multigen_lru.rst | 13 +++++++
 mm/memcontrol.c                               | 30 ++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6efd0095ed99..f42ac6dddbf6 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1437,6 +1437,41 @@ The following nested keys are defined.
 	The valid range for swappiness is [0-200, max], setting
 	swappiness=max exclusively reclaims anonymous memory.
 
+  memory.aging
+	A write-only file which exists for all cgroups when
+	CONFIG_LRU_GEN is enabled.
+
+	This interface triggers MGLRU aging (generation advancement)
+	without page reclaim. It is useful for proactively rebalancing
+	the distribution of pages across generations before invoking
+	memory.reclaim, particularly for workloads (such as the Android
+	application lifecycle) where anonymous pages concentrate in
+	the youngest generations while file pages fill up the oldest
+	generation and get over-reclaimed.
+
+	The single argument is the number of generations to age, in
+	the range [1, MAX_NR_GENS]. MAX_NR_GENS is currently 4.
+
+	Example::
+
+	  echo 2 > memory.aging
+
+	Each aging pass advances both anonymous and file generations
+	simultaneously, matching MGLRU's max_seq semantics. There is
+	no way to age only one type - this is a property of MGLRU,
+	not of this interface.
+
+	Proactive aging should be followed by memory.reclaim to
+	actually free pages::
+
+	  echo 2 > /sys/fs/cgroup/foo/memory.aging
+	  echo "100M" > /sys/fs/cgroup/foo/memory.reclaim
+
+	Returns -EAGAIN if this call did not advance the generation
+	window (typically because a concurrent caller on the same
+	cgroup got there first). Returns -EINVAL if the argument is
+	missing, zero, or out of range.
+
   memory.peak
 	A read-write single value file which exists on non-root cgroups.
 
diff --git a/Documentation/admin-guide/mm/multigen_lru.rst b/Documentation/admin-guide/mm/multigen_lru.rst
index 9cb54b4ff5d9..fd8b4286014e 100644
--- a/Documentation/admin-guide/mm/multigen_lru.rst
+++ b/Documentation/admin-guide/mm/multigen_lru.rst
@@ -161,3 +161,16 @@ cold pages because of the overestimation, it retries on the next
 server according to the ranking result obtained from the working set
 estimation step. This less forceful approach limits the impacts on the
 existing jobs.
+
+Proactive aging
+---------------
+For workloads where it is useful to rebalance the distribution of
+anonymous and file pages across generations before reclaiming (for
+example, the Android application lifecycle, where an application
+that has just been backgrounded has most of its anonymous pages
+clustered in the youngest generations while file pages dominate
+the oldest), the ``memory.aging`` cgroup v2 file can be used to
+advance the generation counter without eviction. The file returns
+-EAGAIN if no advance happened, so callers can correlate with the
+``aging`` counter to verify how many passes actually took
+effect. See Documentation/admin-guide/cgroup-v2.rst.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e42f97e004b6..c6a969b56878 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4896,6 +4896,29 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+#ifdef CONFIG_LRU_GEN
+static ssize_t memory_aging(struct kernfs_open_file *of, char *buf,
+			    size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long nr_gens;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &nr_gens);
+	if (ret)
+		return ret;
+
+	if (nr_gens == 0 || nr_gens > MAX_NR_GENS)
+		return -EINVAL;
+
+	ret = lru_gen_age_memcg(memcg, nr_gens);
+	if (ret)
+		return ret;
+
+	return nbytes;
+}
+#endif
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -4967,6 +4990,13 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+#ifdef CONFIG_LRU_GEN
+	{
+		.name = "aging",
+		.flags = CFTYPE_NS_DELEGATABLE,
+		.write = memory_aging,
+	},
+#endif
 	{ }	/* terminate */
 };
 
-- 
2.25.1


