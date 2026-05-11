Return-Path: <cgroups+bounces-15785-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFZfALo6AmqYpQEAu9opvQ
	(envelope-from <cgroups+bounces-15785-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:23:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9717C515C55
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3849C301B351
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B21D3803CF;
	Mon, 11 May 2026 20:22:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29537DEB7;
	Mon, 11 May 2026 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530976; cv=none; b=uxbQIVoUigM/8c8WQb8PeT2Fv9n3hWLRuzOCC7tO2mxIoH55hupx14MEhMOFg0p0bmxbeRIVwM3gl/vQvcQt9pgpJOkvTcUwG1vlPuldRWHIiw33kyzDmhKohkinRfydwPLHz5+he+3F/SKbbdIpiu9HYEX/HL9szNut1VyNnwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530976; c=relaxed/simple;
	bh=6wqrKndzdUZkZnNt1n8BhDvSH3S6lx5Op6Jwq55DFXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BRtAU+E+LyA+k51PCgRTwLMP30pgKEbGnqBEJQkx1s7wmqirdomz37UGASlYpBaQ7MSCPDGHCqzx0lBU6xMVWVI053Sr6/7rznlntxyFvPlZTrh9rArN8BQgWMX/EA2+gza5YMvQv72pr0wE7N747IVdpS4bTve07LGKN4G3P0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF36C3ED2B;
	Mon, 11 May 2026 20:22:47 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 1/8] mm: memcontrol: propagate NMI slab stats to memcg vmstats
Date: Mon, 11 May 2026 22:20:36 +0200
Message-ID: <20260511202136.330358-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511202136.330358-1-alex@ghiti.fr>
References: <20260511202136.330358-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEKdSC5n47cMxx7+E6xIcuuqMdhUwWhsmhYP0l1q/lL120dThEiR8vb0TiEqhY42A2jPimP5jU/Hm0hGDMno175lLcPytRQJKdldhMsQt6RKWRnwi5uj+7Fz//srcwN3JM6xfrPe93Kmskbbh6XnUYrgM/FTVmCaDrz/0m9ROXr6uVhqG9eyFnOYs1gvA8enM+zyzmByTi7t2LVsTGJjtQGh7t7IHfie/kQmD9bBx9sjOPfZAyTGWUiv6GvKGuseIvPIQs97zGR0NteRVRP95Qqs1VoYF4GH4W6YoIEL9NhmCvSnS5WjCx0nn+v9kQeX4YAgUsLIIKoDX5j6QPthtreg0WrEdOETloX0nHU9QhFkusicJofCoJUaSZJXLcCr3ipFEeJ3E7V1DOQZ31F//5TvDzDBhidPN7NE6DOthjYDol0pyFj4b68FbfFVbwBJvZZDmqots2dvQU1F9tMPbZ0KNLMXGEjnYh5jY9TmHMi8QJcUJPv6R/PHTGe7VuzMDYVUAYEySv3jvZOtiOUX+3BLehOQAdl+y+lDol799VHPQ1GiQTOOyJnUjkI39gp4v6hWPmEvUMxUntR7QxPhqvhnMyoKWukhmEuywJfRLQhc5zfyz4Ni2LLQb9MA8om6nkBITcQCDZuU4F2IlNOslNIR3WBk/YqbbxI7Zos7XD32A
X-Rspamd-Queue-Id: 9717C515C55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15785-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.656];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:email,ghiti.fr:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

flush_nmi_stats() drains per-node NMI slab atomics into the per-node
lruvec_stats, but does not propagate them to the memcg-level vmstats.

This is inconsistent with account_slab_nmi_safe() which updates both,
so fix this by propagating the NMI slab stats to the memcg-level vmstats.

Fixes: 940b01fc8dc1 ("memcg: nmi safe memcg stats for specific archs")
Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c3d98ab41f1f..d81a76654b2c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4341,16 +4341,22 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 			int index = memcg_stats_index(NR_SLAB_RECLAIMABLE_B);
 
 			lstats->state[index] += slab;
+			memcg->vmstats->state[index] += slab;
 			if (plstats)
 				plstats->state_pending[index] += slab;
+			if (parent)
+				parent->vmstats->state_pending[index] += slab;
 		}
 		if (atomic_read(&pn->slab_unreclaimable)) {
 			int slab = atomic_xchg(&pn->slab_unreclaimable, 0);
 			int index = memcg_stats_index(NR_SLAB_UNRECLAIMABLE_B);
 
 			lstats->state[index] += slab;
+			memcg->vmstats->state[index] += slab;
 			if (plstats)
 				plstats->state_pending[index] += slab;
+			if (parent)
+				parent->vmstats->state_pending[index] += slab;
 		}
 	}
 }
-- 
2.54.0


