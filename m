Return-Path: <cgroups+bounces-10825-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED139BE47C0
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 18:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6AA93B9BB7
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB1032D0EC;
	Thu, 16 Oct 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFC5HUWh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBD32D0E9
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 16:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760631047; cv=none; b=VgB6oxLb7wtV6z191S1T96QRtIDm8XZej9F0BMNtXH49EMiMix/YT8I6sz+Ata6iQmZHuZfheMzMBD4j81HYys90fGZzIdN8scXLQYGYA45fcscC7JkwASrANsPWTfqUKEoNDmLZ93WENuJcn6sXDBgJs/jc7cPx7kqVS0QlasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760631047; c=relaxed/simple;
	bh=5U6Z8a0MaSKZ0+RBLu/OxM3V0/Ilgn3EedvuYUvKxMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ro1hL5P/dmg4Sp7EBHxjz5r+zjJh1XLnowunpkFAxS3ye2K6LSGY3rFGwF41AVfCLcNSGmqC/mMGyUI/81K73nvAgFeQFvSjN3bUCUIXai70IPrfjX98xQI9Z81ndGl01yhJXM19UfB391UJAoSea2+xq7cEW/zwRBLqE3CAXdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFC5HUWh; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760631043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1oFfzAiEmNB1imkgRrAcZMXMnzNaSFSgFD/9vrR+Foo=;
	b=ZFC5HUWh/rc/E62Q0sjva/XeBcVkzGBoZhUK50u8KVLRFDNaSSzs/aXVRWsFJweLDEHt+H
	MR9j8EMEWQ5PV9f5kmSCmPRIiuBfiWBOw3j8mMpeBc7XP90/+3Yx6ed1MFV1ZJXIIiaUp4
	LdOJ+G1AZjiv1e/WFmVJ554PHPgJT2w=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Matyas Hurtik <matyas.hurtik@cdn77.com>,
	Daniel Sedlak <daniel.sedlak@cdn77.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Wei Wang <weibunny@meta.com>,
	netdev@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2] memcg: net: track network throttling due to memcg memory pressure
Date: Thu, 16 Oct 2025 09:10:35 -0700
Message-ID: <20251016161035.86161-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The kernel can throttle network sockets if the memory cgroup associated
with the corresponding socket is under memory pressure. The throttling
actions include clamping the transmit window, failing to expand receive
or send buffers, aggressively prune out-of-order receive queue, FIN
deferred to a retransmitted packet and more. Let's add memcg metric to
indicate track such throttling actions.

At the moment memcg memory pressure is defined through vmpressure and in
future it may be defined using PSI or we may add more flexible way for
the users to define memory pressure, maybe through ebpf. However the
potential throttling actions will remain the same, so this newly
introduced metric will continue to track throttling actions irrespective
of how memcg memory pressure is defined.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
---
Changes since v1:
- renamed socks_throttled & MEMCG_SOCKS_THROTTLED as suggested by Roman
http://lore.kernel.org/20251016013116.3093530-1-shakeel.butt@linux.dev

 Documentation/admin-guide/cgroup-v2.rst | 4 ++++
 include/linux/memcontrol.h              | 1 +
 include/net/sock.h                      | 6 +++++-
 kernel/cgroup/cgroup.c                  | 1 +
 mm/memcontrol.c                         | 3 +++
 5 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0e6c67ac585a..3345961c30ac 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1515,6 +1515,10 @@ The following nested keys are defined.
           oom_group_kill
                 The number of times a group OOM has occurred.
 
+          sock_throttled
+                The number of times network sockets associated with
+                this cgroup are throttled.
+
   memory.events.local
 	Similar to memory.events but the fields in the file are local
 	to the cgroup i.e. not hierarchical. The file modified event
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7ed15f858dc4..e0240560cea4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -52,6 +52,7 @@ enum memcg_memory_event {
 	MEMCG_SWAP_HIGH,
 	MEMCG_SWAP_MAX,
 	MEMCG_SWAP_FAIL,
+	MEMCG_SOCK_THROTTLED,
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
diff --git a/include/net/sock.h b/include/net/sock.h
index 60bcb13f045c..ff7d49af1619 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2635,8 +2635,12 @@ static inline bool mem_cgroup_sk_under_memory_pressure(const struct sock *sk)
 #endif /* CONFIG_MEMCG_V1 */
 
 	do {
-		if (time_before64(get_jiffies_64(), mem_cgroup_get_socket_pressure(memcg)))
+		if (time_before64(get_jiffies_64(),
+				  mem_cgroup_get_socket_pressure(memcg))) {
+			memcg_memory_event(mem_cgroup_from_sk(sk),
+					   MEMCG_SOCK_THROTTLED);
 			return true;
+		}
 	} while ((memcg = parent_mem_cgroup(memcg)));
 
 	return false;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index fdee387f0d6b..8df671c59987 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4704,6 +4704,7 @@ void cgroup_file_notify(struct cgroup_file *cfile)
 	}
 	spin_unlock_irqrestore(&cgroup_file_kn_lock, flags);
 }
+EXPORT_SYMBOL_GPL(cgroup_file_notify);
 
 /**
  * cgroup_file_show - show or hide a hidden cgroup file
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3ae5cbcaed75..976412c8196e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -81,6 +81,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
 struct mem_cgroup *root_mem_cgroup __read_mostly;
+EXPORT_SYMBOL(root_mem_cgroup);
 
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
@@ -4463,6 +4464,8 @@ static void __memory_events_show(struct seq_file *m, atomic_long_t *events)
 		   atomic_long_read(&events[MEMCG_OOM_KILL]));
 	seq_printf(m, "oom_group_kill %lu\n",
 		   atomic_long_read(&events[MEMCG_OOM_GROUP_KILL]));
+	seq_printf(m, "sock_throttled %lu\n",
+		   atomic_long_read(&events[MEMCG_SOCK_THROTTLED]));
 }
 
 static int memory_events_show(struct seq_file *m, void *v)
-- 
2.47.3


