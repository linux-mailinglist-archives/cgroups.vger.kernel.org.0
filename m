Return-Path: <cgroups+bounces-8817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D067B0D25E
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 09:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DE107B1D89
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 07:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B7028B3F1;
	Tue, 22 Jul 2025 07:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b="VqGXw/tv"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-internal.sh.cz (mail-internal.sh.cz [95.168.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865EE56A;
	Tue, 22 Jul 2025 07:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.168.196.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753168371; cv=none; b=ugJqP8jn0llzE3Kyu5pmJf728V/3xNovw2Sw/zo5VTqfNq9ZCRDHbtfa7KTliH2ObisuFyduFI+5OkQIgehmljkg6VxPhLtP45ArObF9zuBDzI8E7wec4S81cjaHjAOWss2nKSEd00HNb/GoTrlK1RoGQb5qfGGF27yOHn5jaY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753168371; c=relaxed/simple;
	bh=utRuUgk1dUsACGv3NH/GunBOaa5y/TynhaYYqHE4lYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=StQl7PXy1xcbvQ4izpyBAQlIfh9z6aZ3Gcv5pv/btGtq+xeR8c2/3TSf9S4WFd8kxzNgU6ozI0QyKeDKt6wgSOA0oYwo6pfwnT0+XVxo73Nsz5i9XjUO7oWTCncUtWKhDKji9Z4Cxwxq0rDFnoNfJfPJ9AQ0sllQVxCEwWBmgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com; spf=pass smtp.mailfrom=cdn77.com; dkim=pass (1024-bit key) header.d=cdn77.com header.i=@cdn77.com header.b=VqGXw/tv; arc=none smtp.client-ip=95.168.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cdn77.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cdn77.com
DKIM-Signature: a=rsa-sha256; t=1753168360; x=1753773160; s=dkim2019; d=cdn77.com; c=relaxed/relaxed; v=1; bh=G9jb3st1obP8Gd9xyUJPV6c8IdsyENVMCWvoYCoWByc=; h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding;
   b=VqGXw/tvesgG2gtVuhtJPArWgMROI/mJTgqt4ysZzUMxE4eZ+kpBLHKXDksPjpIGJU681T4/wa9AiBHeyCX8D9opXNgKO/xIdL9B1hKZ0LifSKviL7bloYmI32xmTnXnrhhGi+ngUmgp6+8JQbLPG2kkczyvAUdI0u9CNZ6W6j4=
Received: from osgiliath.superhosting.cz ([80.250.18.198])
        by mail.sh.cz (14.1.0 build 16 ) with ASMTP (SSL) id 202507220912390266;
        Tue, 22 Jul 2025 09:12:39 +0200
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
	cgroups@vger.kernel.org
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>,
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: [PATCH v3] memcg: expose socket memory pressure in a cgroup
Date: Tue, 22 Jul 2025 09:11:46 +0200
Message-ID: <20250722071146.48616-1-daniel.sedlak@cdn77.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A002102.687F39E7.007F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0"; Spam="Unknown"; VOD="Unknown"

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

The output value is an integer matching the internal semantics of the
struct mem_cgroup for socket_pressure. It is a periodic re-arm clock,
representing the end of the said socket memory pressure, and once the
clock is re-armed it is set to jiffies + HZ.

Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/uapi/linux/snmp.h#L231-L232 [1]
Link: https://elixir.bootlin.com/linux/v6.15.4/source/include/net/sock.h#L1300-L1301 [2]
Co-developed-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Signed-off-by: Matyas Hurtik <matyas.hurtik@cdn77.com>
Signed-off-by: Daniel Sedlak <daniel.sedlak@cdn77.com>
---
Changes:
v2 -> v3:
- Expose the socket memory pressure on the cgroups instead of netstat
- Split patch
- Link: https://lore.kernel.org/netdev/20250714143613.42184-1-daniel.sedlak@cdn77.com/

v1 -> v2:
- Add tracepoint
- Link: https://lore.kernel.org/netdev/20250707105205.222558-1-daniel.sedlak@cdn77.com/


 mm/memcontrol.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 902da8a9c643..8e8808fb2d7a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4647,6 +4647,15 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
 	return nbytes;
 }
 
+static int memory_socket_pressure_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	seq_printf(m, "%lu\n", READ_ONCE(memcg->socket_pressure));
+
+	return 0;
+}
+
 static struct cftype memory_files[] = {
 	{
 		.name = "current",
@@ -4718,6 +4727,11 @@ static struct cftype memory_files[] = {
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
 

base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
-- 
2.39.5


