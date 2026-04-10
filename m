Return-Path: <cgroups+bounces-15214-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oN3hNslm2Wm8pQgAu9opvQ
	(envelope-from <cgroups+bounces-15214-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:08:25 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830D3DCBD0
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 720E3303B146
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF143A963A;
	Fri, 10 Apr 2026 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rQZUHWeo"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9867B3A7F75
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855275; cv=none; b=ngUGg0mf+gcDaNJM2HPZRbtjjMwWjOzJ+Bb82zwlMUldfHedKm/FJY1d4/Ms1Z55LwhVAbbYZDEIGeLm24L5bQFSPyjOry0xxgSnbYGiNpY4atHAv0wf+kbg4WmDEPlgqS7QfsDGVjYJic3Aq+Lf1joL3BXtXVDGY1dLfdwL3yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855275; c=relaxed/simple;
	bh=3w6H/F3uWcnpSwsuRvgJu5YTfmoXTOuwZ4SFgkURGe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkkiSG6OyE7QpjgdmKQjrA96zDWyDC4UXHgPB0ZPip+ukiEB9fS4mtO4wZeSa+ib19Zy/Iu/JfkpCmWkbzkRZ5+gBX4VA/gIn7ryEIfaaLUXfnTI6ZJXM7fK4DKU0zxBXuWtmBIYxGx788uozgVfruPY6dgH3pNDKNZbBFFHaDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rQZUHWeo; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4042fe53946so1145419fac.3
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855271; x=1776460071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPG2mb1u3XIYy2E/F4fu0GfPhkkeNWm+Yupk0vqgtxA=;
        b=rQZUHWeo0zsjE+s50VZLIc5rCefbkEo4bZWsqlkxy0MxSRE/CZPE7noxSQu4fq4uUZ
         BpQYi4l78e+uJ0oUAZ2K3o/6FlltwtsoLhdpWC+DVjO0W1rAJ/olOVsJJ3LO54Mwu7bR
         l6U+Ka8ovXZda8yQ0dEhMBvSzeb7fFZnts8i+kZwhUNgzpEPrYKCEMl4UnW3uynhiOYI
         Tv7HlVQiR44WiitiD7AnbA8cCo42EvVqRMO7XgV/hc+FLQ8wXz0pvd6z3E/1l5iAeb9s
         5KkTYTc8c4r6JXX+urqI0i/UBwoyE6qrj2PRIV8SIIJrgKSFaoTiEGRdupb3K38x7Hqk
         +FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855271; x=1776460071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LPG2mb1u3XIYy2E/F4fu0GfPhkkeNWm+Yupk0vqgtxA=;
        b=RfuUYc8LDGpNkvg/H5wbhTNc5HGCrk0P7WTwqauxTsVuaO/3iyDHoSHGy3aZKjHy90
         +G1dDhVSbGm0UocpHYQFohUYwDGc50ojg1chXdIbWTXvhzmd7rQYShVElWsrxBKEZJkL
         /lTgXPWpBUSRYfW8omsvy7490/h2qPyFudqwoowelKJXc6w0GzJZE/1FGBoI+b4H1Yef
         HnaKkObKy3xIh0cAj5n/MXfAcgTYCYlCzOACSmERNyya++mmgJgkq7ZXOAV0Ns8n5pCQ
         iJMA4R6ixVBrb5d2mPEq4gGWe6Rhxri5QBzHcFwxRUOhut26Zi0cGCq2GcsPkCxPlEYz
         8H1A==
X-Forwarded-Encrypted: i=1; AJvYcCUcEBn1WBFWPMfbdWx9pM786r8ovyoQDOoc0L667g82pkyN4Zc3gInFOnauHm1d12uV7fILnShJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwGM71CzDpVUZltSR7aUIE2s+FFL+0yxxnKTeJn4rhNwcmc1hY8
	2aobpa97W+lslOOpf7IHKe4JWiOYwV4KjuJiGixBmy+GZ7T1LFW3Dmij
X-Gm-Gg: AeBDietoPq4b3E4aSaFcEzbXJ+7HuysrGeRUgm1+48E42iyoozCe8l4DsLi+Jo95nPt
	XRKgGs9VH441dGy1f7pbzGvcfjgOnDYSdW0KaF41r3pT5ipsXAj2LiPe7IgN6mW4MVza/T6/fbM
	ywic7tmYQ+L/437Iw/m7/9dHHJCUwq/nKFWT7GHv8HM7jPVpqWybwcODP5oMNh+itIvRpzsDpC1
	XL8p3I+8sGeQxLk/ouYBc69ysktovUvGSTdey+7d4CkHNx/oRWVqkHPi9ZrP9YgioTtSt7HC+LY
	YISWKpKxx6bHYN2ORixvMwd943w04RjiOVm0Cicq+A7qkKAu7hRZvQUSmZX3dPdbuixxOtoim0l
	rybMazKrha2YFtb5tJSSmwo3lJ2hsGYW0XjeZNsaQuoe9eXLxAbkOpwW+wzohpJeHgkZ/jbbbtv
	Gf8jYA0e5NTNcFUhkoZyGC
X-Received: by 2002:a05:6870:6986:b0:417:2a17:285 with SMTP id 586e51a60fabf-423e10a1761mr2566760fac.30.1775855271475;
        Fri, 10 Apr 2026 14:07:51 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:4::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddcf0376sm3027396fac.18.2026.04.10.14.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:50 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 4/8 RFC] mm/page_counter: introduce stock drain APIs
Date: Fri, 10 Apr 2026 14:06:58 -0700
Message-ID: <20260410210742.550489-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
References: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15214-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: 5830D3DCBD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Introduce page_counter_drain_stock() and page_counter_drain_cpu()
to replace memcg stock draining functions.

page_counter_drain_stock() runs from drain_all_stock, which is called
when the system is under memory pressure or a cgroup is dying. Because
it is a rare operation, it uses work_on_cpu() to synchronously drain
each online CPU's stock and synchronizes with concurrent charge/uncharge
via local_lock.

page_counter_drain_cpu() handles the CPU hotplug dead path, where the
stock can be accessed directly without locking since the CPU is dead.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 include/linux/page_counter.h |  2 ++
 mm/page_counter.c            | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index c7e3ab3356d20..c6772531074b5 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -111,6 +111,8 @@ static inline void page_counter_reset_watermark(struct page_counter *counter)
 int page_counter_enable_stock(struct page_counter *counter, unsigned int batch);
 void page_counter_disable_stock(struct page_counter *counter);
 void page_counter_free_stock(struct page_counter *counter);
+void page_counter_drain_stock(struct page_counter *counter);
+void page_counter_drain_cpu(struct page_counter *counter, unsigned int cpu);
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 void page_counter_calculate_protection(struct page_counter *root,
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 7be214034bfad..28c2e6442f7d3 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -12,6 +12,8 @@
 #include <linux/string.h>
 #include <linux/sched.h>
 #include <linux/bug.h>
+#include <linux/cpu.h>
+#include <linux/workqueue.h>
 #include <asm/page.h>
 
 static bool track_protection(struct page_counter *c)
@@ -402,6 +404,55 @@ void page_counter_free_stock(struct page_counter *counter)
 	counter->stock = NULL;
 }
 
+static long page_counter_drain_stock_cpu(void *arg)
+{
+	struct page_counter *counter = arg;
+	struct page_counter_stock *stock;
+	unsigned long nr_pages;
+
+	local_lock(&counter->stock->lock);
+	stock = this_cpu_ptr(counter->stock);
+	nr_pages = stock->nr_pages;
+	stock->nr_pages = 0;
+	local_unlock(&counter->stock->lock);
+
+	if (nr_pages)
+		page_counter_cancel_hierarchy(counter, nr_pages);
+
+	return 0;
+}
+/*
+ * Drain per-cpu stock across all online CPUs. Caller (drain_all_stock) is
+ * already protected by a mutex, all future callers must serialize as well.
+ */
+void page_counter_drain_stock(struct page_counter *counter)
+{
+	int cpu;
+
+	if (!counter->stock)
+		return;
+
+	cpus_read_lock();
+	for_each_online_cpu(cpu)
+		work_on_cpu(cpu, page_counter_drain_stock_cpu, counter);
+	cpus_read_unlock();
+}
+
+void page_counter_drain_cpu(struct page_counter *counter, unsigned int cpu)
+{
+	struct page_counter_stock *stock;
+	unsigned long nr_pages;
+
+	if (!counter->stock)
+		return;
+
+	stock = per_cpu_ptr(counter->stock, cpu);
+	nr_pages = stock->nr_pages;
+	if (nr_pages) {
+		stock->nr_pages = 0;
+		page_counter_cancel_hierarchy(counter, nr_pages);
+	}
+}
 
 #if IS_ENABLED(CONFIG_MEMCG) || IS_ENABLED(CONFIG_CGROUP_DMEM)
 /*
-- 
2.52.0


