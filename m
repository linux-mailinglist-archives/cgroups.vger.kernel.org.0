Return-Path: <cgroups+bounces-10583-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E0ABC16B8
	for <lists+cgroups@lfdr.de>; Tue, 07 Oct 2025 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7875D188FCBA
	for <lists+cgroups@lfdr.de>; Tue,  7 Oct 2025 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2690A2DFA27;
	Tue,  7 Oct 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="w82B+Cj+"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC62135C5;
	Tue,  7 Oct 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759841788; cv=none; b=CkRRNjyN7Fb59X/hixeMG0jN05V7xHIcfgePNbTnEdGzncZvatGRFZeqMtJ7OsN3C2YgkbebNIGjIY9+AVzHlGGKSDm2pSIcTZ673N9eyI+120MYDaSysl3q71yD7TewQwLdWG0qfHo0I3GHM7/zpaKabN70VQWtd44E0JPQf7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759841788; c=relaxed/simple;
	bh=/SbNQRwwX27kyNevW/r5xUiMY1EMom4bcJWXjZ2zCNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjbWUe9NMAyiLMr8wNDSH5xUryjziazyeUwoJA29uiNrbjf4ywgNbW3L7lbysV1wcwSiMo9R+R+y3KYtrZouy13u1+/YkbYXZdxbuH3UeglilRUv2oTxxjHeiXbAoFY8qCYXH5KDqPagXCGPKAv2Mdve123KSBvRXHBGwMxsQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=w82B+Cj+; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1759841475; x=1760446275; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=j2I31yXma2qknyIdaRxK003EeXewJ8txeu7FUP4ZPo8=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding;
   b=w82B+Cj+KQ/InClUX4322yvOUwDSlIX1z8k3pYsxElgjN/8rNV41ANBU1nUwH87DBjyie3LfyrFddLx5sv5OpqfaA6Ju5zVBHs7YUQqkVtiI/5anRUOHKw0gWs4fNdud5sY2P/EsEjfMV8nBdCJ4OOYR83JSAXmRJxmjOalXNCM=
Received: from osgiliath.superhosting.cz ([80.250.18.198])
        by mail.sh.cz (14.1.0 build 17 ) with ASMTP (SSL) id 202510071451134462;
        Tue, 07 Oct 2025 14:51:13 +0200
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
Subject: [PATCH v5] memcg: expose socket memory pressure in a cgroup
Date: Tue,  7 Oct 2025 14:50:56 +0200
Message-ID: <20251007125056.115379-1-daniel.sedlak@cdn77.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A2D034E.68E50CC2.0047,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

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
memory pressure for a given cgroup, it affects all sockets used in that
cgroup, including children cgroups.

This patch exposes a new file for each cgroup in sysfs which is a
read-only single value file showing how many microseconds this cgroup
contributed to throttling the throughput of network sockets. The file is
accessible in the following path.

  /sys/fs/cgroup/**/<cgroup name>/memory.net.throttled_usec

Just to summarize the proposals of different methods of hierarchical
propagation of the memory.net.throttled_usec.

1) None - keeping the reported duration local to that cgroup:

   value = self

   Would not be too out of place, since memory.events.local
   already does not accumulate hierarchically.
   To determine whether sockets in a memcg were throttled,
   we would traverse the /sys/fs/cgroup/ hierarchy from root to
   the cgroup of interest and sum those local durations.

2) Propagating the duration upwards (using rstat or simple iteration
   towards root memcg during write):

   value = self + sum of children

   Most semantically consistent with other exposed stat files.
   Could be added as an entry into memory.stat.
   Since the pressure gets applied from ancestors to children
   (see mem_cgroup_under_socket_pressure()), determining the duration of
   throttling for sockets in some cgroup would be hardest in this variant.

   It would involve iterating from the root to the examined cgroup and
   at each node subtracting the values of its children from that nodes
   value, then the sum of that would correspond to the total duration
   throttled.

3) Propagating the duration downwards (write only locally,
   read traversing hierarchy upwards):

   value = self + sum of ancestors

   Mirrors the logic used in mem_cgroup_under_socket_pressure(),
   increase in the reported value for a memcg would coincide with more
   throttling being done to the sockets of that memcg.

We chose variant 1, that is why it is a separate file instead of another
counter in mem.stat. Variant 2 seems to be most fitting however the
calculated value would be misleading and hard to interpret. Ideally, we
would go with variant 3 as this mirrors the logic of
mem_cgroup_under_socket_pressure(), but the third variant can be also
calculated manually from variant 1, and thus we chose the variant 1
as it is the most versatile one without leaking the internal
implementation that can change in the future.

Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linux/snmp.h#L231-L232 [1]
Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.h#L1300-L1301 [2]
Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
---
Sorry for the delay between the versions.

Changes:
v4 -> v5:
- Rebased
- Extend commit message with design decisions
- Rename cgroup counter
- Link to v4: https://lore.kernel.org/netdev/20250805064429.77876-1-daniel.sedlak@cdn77.com/

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

 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++
 include/linux/memcontrol.h              | 41 +++++++++++++++----------
 mm/memcontrol.c                         | 31 ++++++++++++++++++-
 3 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 51c0bc4c2dc5..fe81a134c156 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1887,6 +1887,16 @@ The following nested keys are defined.
 	Shows pressure stall information for memory. See
 	:ref:`Documentation/accounting/psi.rst <psi>` for details.
 
+  memory.net.throttled_usec
+	A read-only single value file showing how many microseconds this cgroup
+	contributed to throttling the throughput of network sockets.
+
+	Socket throttling is applied to a cgroup and to all its children,
+	as a consequence of high reclaim pressure.
+
+	Observing throttling of sockets in a particular cgroup can be done
+	by checking this file for that cgroup and also for all its ancestors.
+
 
 Usage Guidelines
 ~~~~~~~~~~~~~~~~
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fb27e3d2fdac..647fba7dcc8a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -247,14 +247,19 @@ struct mem_cgroup {
 	atomic_t		kmem_stat;
 #endif
 	/*
-	 * Hint of reclaim pressure for socket memroy management. Note
+	 * Hint of reclaim pressure for socket memory management. Note
 	 * that this indicator should NOT be used in legacy cgroup mode
 	 * where socket memory is accounted/charged separately.
 	 */
 	u64			socket_pressure;
-#if BITS_PER_LONG < 64
+	/* memory.net.throttled_usec */
+	u64			socket_pressure_duration;
+#if BITS_PER_LONG >= 64
+	spinlock_t		socket_pressure_spinlock;
+#else
 	seqlock_t		socket_pressure_seqlock;
 #endif
+
 	int kmemcg_id;
 	/*
 	 * memcg->objcg is wiped out as a part of the objcg repaprenting
@@ -1607,19 +1612,33 @@ bool mem_cgroup_sk_charge(const struct sock *sk, unsigned int nr_pages,
 			  gfp_t gfp_mask);
 void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages);
 
-#if BITS_PER_LONG < 64
 static inline void mem_cgroup_set_socket_pressure(struct mem_cgroup *memcg)
 {
-	u64 val = get_jiffies_64() + HZ;
 	unsigned long flags;
 
+#if BITS_PER_LONG >= 64
+	spin_lock_irqsave(&memcg->socket_pressure_spinlock, flags);
+#else
 	write_seqlock_irqsave(&memcg->socket_pressure_seqlock, flags);
-	memcg->socket_pressure = val;
+#endif
+	u64 old_socket_pressure = memcg->socket_pressure;
+	u64 new_socket_pressure = get_jiffies_64() + HZ;
+
+	memcg->socket_pressure = new_socket_pressure;
+	memcg->socket_pressure_duration +=  jiffies_to_usecs(
+		min(new_socket_pressure - old_socket_pressure, HZ));
+#if BITS_PER_LONG >= 64
+	spin_unlock_irqrestore(&memcg->socket_pressure_spinlock, flags);
+#else
 	write_sequnlock_irqrestore(&memcg->socket_pressure_seqlock, flags);
+#endif
 }
 
 static inline u64 mem_cgroup_get_socket_pressure(struct mem_cgroup *memcg)
 {
+#if BITS_PER_LONG >= 64
+	return READ_ONCE(memcg->socket_pressure);
+#else
 	unsigned int seq;
 	u64 val;
 
@@ -1629,18 +1648,8 @@ static inline u64 mem_cgroup_get_socket_pressure(struct mem_cgroup *memcg)
 	} while (read_seqretry(&memcg->socket_pressure_seqlock, seq));
 
 	return val;
-}
-#else
-static inline void mem_cgroup_set_socket_pressure(struct mem_cgroup *memcg)
-{
-	WRITE_ONCE(memcg->socket_pressure, jiffies + HZ);
-}
-
-static inline u64 mem_cgroup_get_socket_pressure(struct mem_cgroup *memcg)
-{
-	return READ_ONCE(memcg->socket_pressure);
-}
 #endif
+}
 
 int alloc_shrinker_info(struct mem_cgroup *memcg);
 void free_shrinker_info(struct mem_cgroup *memcg);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index df3e9205c9e6..d29147223822 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3755,7 +3755,10 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	INIT_LIST_HEAD(&memcg->swap_peaks);
 	spin_lock_init(&memcg->peaks_lock);
 	memcg->socket_pressure = get_jiffies_64();
-#if BITS_PER_LONG < 64
+	memcg->socket_pressure_duration = 0;
+#if BITS_PER_LONG >= 64
+	spin_lock_init(&memcg->socket_pressure_spinlock);
+#else
 	seqlock_init(&memcg->socket_pressure_seqlock);
 #endif
 	memcg1_memcg_init(memcg);
@@ -4579,6 +4582,27 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+static int memory_net_throttled_usec_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	u64 throttled_usec;
+
+#if BITS_PER_LONG >= 64
+	throttled_usec = READ_ONCE(memcg->socket_pressure_duration);
+#else
+	unsigned int seq;
+
+	do {
+		seq = read_seqbegin(&memcg->socket_pressure_seqlock);
+		throttled_usec = memcg->socket_pressure_duration;
+	} while (read_seqretry(&memcg->socket_pressure_seqlock, seq));
+#endif
+
+	seq_printf(m, "%llu\n", throttled_usec);
+
+	return 0;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -4650,6 +4674,11 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NS_DELEGATABLE,
 		.write = memory_reclaim,
 	},
+	{
+		.name = "net.throttled_usec",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_net_throttled_usec_show,
+	},
 	{ }	/* terminate */
 };
 

base-commit: 312e6f7676e63bbb9b81e5c68e580a9f776cc6f0
-- 
2.39.5


