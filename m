Return-Path: <cgroups+bounces-8979-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EECEEB1AEE8
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 08:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDF66212B9
	for <lists+cgroups@lfdr.de>; Tue,  5 Aug 2025 06:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D422AE45;
	Tue,  5 Aug 2025 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="997wEMd/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27FB2264D6;
	Tue,  5 Aug 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376913; cv=none; b=aEBBPh7BiRuY5slNFDlsejgIgS5cX9K0uMeAImWzAc0qv3JZjWorGV18nD+BSjl4s+myxp1Ouekisaq7ael9meoqfdoYArGb1Tc9bvAHCQKQFGe+1JgT2uFMfNkoIXsUSuBMk03L8WWZ2kc9EQTn48SNTL22Vc2gf+mG0tJ13LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376913; c=relaxed/simple;
	bh=RoLwdHkTGP6TctrXRXCOW8WNMcp4uO3FTclyA+grKDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTPRaN+jlxJ2i8rqrdZGnAof2jwqKqFKMX53rateNZDmKJZ2soMHvc3/XpfH6dtLOhN97p0xSui9H+yB7QcNLcxv5wp4xtYCid1pZDeogXnVOzGsDMO9zmE4SifxdPk/MDA9l6pr+tVH2Z0C/K82zdzJCNX5wiLJfh1jJsUDvoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=997wEMd/; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1754376595; x=1754981395; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=3YyntHiLqkFTMznGicglNGAVD8aH+6NcVnSLXy6N7JQ=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding;
   b=997wEMd/zggrxvDleB60R5dGg49bH6E07bd46h3avriRN8sGEODGLeFYm6CJg1FHDefRSh8Q9m6xlMrhEr51PAdJwwOsHL2Q9HZxnTZSsSMCmdac5+cBOztGkJel8UGvYgEdu8Rk6DLwrZC4Ip68URqAZXoSNOzm6Ei6IINTEM4=
Received: from osgiliath.superhosting.cz ([95.168.203.222])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202508050849538632;
        Tue, 05 Aug 2025 08:49:53 +0200
From: Daniel Sedlak <daniel.sedlak@cdn77.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>,
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Date: Tue,  5 Aug 2025 08:44:29 +0200
Message-ID: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A002111.6891A98E.0072,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

This patch is a result of our long-standing debug sessions, where it all
started as "networking is slow", and TCP network throughput suddenly
dropped from tens of Gbps to few Mbps, and we could not see anything in
the kernel log or netstat counters.

Currently, we have two memory pressure counters for TCP sockets [1],
which we manipulate only when the memory pressure is signalled through
the proto struct [2]. However, the memory pressure can also be signaled
through the cgroup memory subsystem, which we do not reflect in the
netstat counters. In the end, when the cgroup memory subsystem signals
that it is under pressure, we silently reduce the advertised TCP window
with tcp_adjust_rcv_ssthresh() to 4*advmss, which causes a significant
throughput reduction.

Keep in mind that when the cgroup memory subsystem signals the socket
memory pressure, it affects all sockets used in that cgroup.

This patch exposes a new file for each cgroup in sysfs which signals
the cgroup socket memory pressure. The file is accessible in
the following path.

  /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure

The output value is a cumulative sum of microseconds spent
under pressure for that particular cgroup.

Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linux/snmp.h#L231-L232 [1]
Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.h#L1300-L1301 [2]
Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
---
Changes:
v3 -> v4:
- Add documentation
- Expose pressure as cummulative counter in microseconds
- Link to v3: https://lore.kernel.org/netdev/20250722071146.48616-1-daniel.sedlak@cdn77.com/

v2 -> v3:
- Expose the socket memory pressure on the cgroups instead of netstat
- Split patch
- Link to v2: https://lore.kernel.org/netdev/20250714143613.42184-1-daniel.sedlak@cdn77.com/

v1 -> v2:
- Add tracepoint
- Link to v1: https://lore.kernel.org/netdev/20250707105205.222558-1-daniel.sedlak@cdn77.com/

 Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
 include/linux/memcontrol.h              |  2 ++
 mm/memcontrol.c                         | 15 +++++++++++++++
 mm/vmpressure.c                         |  9 ++++++++-
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0cc35a14afbe..c810b449fb3d 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1884,6 +1884,13 @@ The following nested keys are defined.
 	Shows pressure stall information for memory. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
+  memory.net.socket_pressure
+	A read-only single value file showing how many microseconds
+	all sockets within that cgroup spent under pressure.
+
+	Note that when the sockets are under pressure, the networking
+	throughput can be significantly degraded.
+
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87b6688f124a..6a1cb9a99b88 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -252,6 +252,8 @@ struct mem_cgroup {
 	 * where socket memory is accounted/charged separately.
 	 */
 	unsigned long		socket_pressure;
+	/* exported statistic for memory.net.socket_pressure */
+	unsigned long		socket_pressure_duration;
 
 	int kmemcg_id;
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 902da8a9c643..8e299d94c073 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3758,6 +3758,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	INIT_LIST_HEAD(&memcg->swap_peaks);
 	spin_lock_init(&memcg->peaks_lock);
 	memcg->socket_pressure = jiffies;
+	memcg->socket_pressure_duration = 0;
 	memcg1_memcg_init(memcg);
 	memcg->kmemcg_id = -1;
 	INIT_LIST_HEAD(&memcg->objcg_list);
@@ -4647,6 +4648,15 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+static int memory_socket_pressure_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%lu\n", READ_ONCE(memcg->socket_pressure_duration));
+
+	return 0;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -4718,6 +4728,11 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+	{
+		.name = "net.socket_pressure",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_socket_pressure_show,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index bd5183dfd879..1e767cd8aa08 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -308,6 +308,8 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		level = vmpressure_calc_level(scanned, reclaimed);
 
 		if (level > VMPRESSURE_LOW) {
+			unsigned long socket_pressure;
+			unsigned long jiffies_diff;
 			/*
 			 * Let the socket buffer allocator know that
 			 * we are having trouble reclaiming LRU pages.
@@ -316,7 +318,12 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 			 * asserted for a second in which subsequent
 			 * pressure events can occur.
 			 */
-			WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
+			socket_pressure = jiffies + HZ;
+
+			jiffies_diff = min(socket_pressure - READ_ONCE(memcg->socket_pressure), HZ);
+			memcg->socket_pressure_duration += jiffies_to_usecs(jiffies_diff);
+
+			WRITE_ONCE(memcg->socket_pressure, socket_pressure);
 		}
 	}
 }

base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
-- 
2.39.5


