Return-Path: <cgroups+bounces-16225-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBgiByrUEGq9eQYAu9opvQ
	(envelope-from <cgroups+bounces-16225-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:09:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2405BAF87
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36F27301E566
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 22:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39463998B2;
	Fri, 22 May 2026 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+UknO7K"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3839890C
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487603; cv=none; b=nxP0qLnUZH+BMsvH0jusk8PZsg4wOSUp5TqIEqlKNlXlRvj6qGDDqghXXm6Wqdy4jvxouUB8nkAH6TOd68f/4Dt52GYwKLaN/w0TKOOcGw71IYh5OFnEVxCDdx/S4lF0EnqKCu/WFYVMFfJ9Me7fDq8yrXR/2QShyye7E/TScn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487603; c=relaxed/simple;
	bh=4UYwrcyLg6NFLJwsNn/rvSTVnQ4sAFbwhsLF1ErPS6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFADcEwwcbgG4Ag4h8D1TnS17U2T+67iOks60I8yjLXGG+kK37PR0/kPj4+XvAU1OG6nyEYqDVjX+WMAlGULR8NpzXKqTSLqad/uHOi3EQavQSdLxi9KoHf4BktzmaEQFRk6PXyAm4WbiDxULPSgmed2NEq9sc9VcIbNk2JPHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+UknO7K; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-48544493bd1so1101801b6e.0
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779487601; x=1780092401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31yASLdMSEM7nexMHwB6RiM0ndTUZyyCT5Ui47lS5/Q=;
        b=M+UknO7KedpAQJVmVfDNiBhxZosxKwfgE9FYCfCPY0sdnhwghGxjdkUGwL1aoF+8Lj
         6qcW9xfW1aCvu+NFmNZFQ3sWKnWDD82fkGwA6/phTbJDJalVepRaFLUtrxmwVVEa23uq
         ZmpIInVVK7nARoBlw7T7O9ZTaYXsnzQpnFbpu0/Ada+Q3XPph8BhnhN8qG17xmGAIvYx
         OwCgYxC9hHw1l8vMsBFYci1dAI8rmu0PoxpcEeGSCKCkNvwnO/yeVf0VhIHgGZ94oMi1
         tEicObjnLRRIMBN+QvXcIC24vXWill1chCoTL338KnoXL68ApNaO5UMl2vOVF0iM5YCy
         6dow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487601; x=1780092401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=31yASLdMSEM7nexMHwB6RiM0ndTUZyyCT5Ui47lS5/Q=;
        b=bhKqDsYhiE1AvHmYU6Aix/R87zokUB1s14foZ4yeo2nh5lImb1EcdKRnWYUWrWjYXx
         GnH1a9ukVn2KnxY1Br+ACTCWuz3n2Pw+KIf3TGyoYtQaqhN1agV6pm2o/xQI5RLBhAMZ
         4kbFUnp2tcm7+bEWElxolgRzyNibTpA1feHCstpw6R2AYMsRJCxv1LMrI/iFVx3TLOR4
         lhX0aqnbLbsQ0bvQYwMz5yg14aJyWAj37HrJqOAAUCy0iLVsXufJF7WBoFUhCAQs87ah
         hFWltG0yMgiUVYP385M0NanTUm4V2olSJZ4v0zToO/TIeNQ1XTs008g07x1kkht11u3p
         l2YA==
X-Forwarded-Encrypted: i=1; AFNElJ/I3Qd2XUYaL9UsN/zC1Qk1pIXkooiFBqavb27YpA/qpxmeJ87qyfvglMj13BtHFYZndEIMGy9i@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7hdtXv9FI7f4ApjgDFu4bMDpSVUny239qq4VG8VcgW01CE3uA
	7nur7HHRXvP5H1nXMAq1HOutS8qmyMNZkePBPNcRsV2chWt9Df1AczUy
X-Gm-Gg: Acq92OHBWx6jRHBr2KQQ/j7UKvLoVV4PwqFF0ZiLVnMMrtoC12hh7cgynVneHg0B2nI
	mqmuchDo3/yg5Qmi6zZpl0FxktNvIPnNlQh7ovnaL3/Zq2mkrNkLkphf1bcCIs8vtJ2tDjSgnOw
	5oMPoPn+T4kabUBSUJL10hsC7RD6KWpQG2uyRvUeDcUGoWPISSpg0CHOcmU+w1W5T7Ukc3Q7skW
	n4LvLsr1ZP4avZ5xXpSv7ljAFtgROCA8jHtBZceiiJnXtwJ8gNZU/gAxUeSOjMMv26CfZcSvY0S
	zUmr2zRSnY1L+BHI1Zeh/tcNWg0zPAFZ5PJxtOXJxxLBKRgdpkdpi3HFKn7T1rH/HBPy6Xn5N8r
	rYqT8rhRBr4Cnwy13Z2lnOh9qo9u3HEZ43d9wINWnRMqgLOlbr5Bte5BQgQ9JV3Arlsfb+0DrzM
	knrLO7XRUNLI1v7WtkMkpg4mOkeqvxsr5IpVgUHYoDMjNIeXm5eDZNDLwwisJ4Wm1Ue7rXkhdt5
	Co=
X-Received: by 2002:a05:6808:c2fa:b0:485:4441:721a with SMTP id 5614622812f47-4854a1d46f1mr3600895b6e.36.1779487601412;
        Fri, 22 May 2026 15:06:41 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554041ccasm1180385b6e.0.2026.05.22.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:06:40 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 5/7 v2] mm/memcontrol: optimize memsw stock for cgroup v1
Date: Fri, 22 May 2026 15:06:23 -0700
Message-ID: <20260522220627.1150804-6-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
References: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16225-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EC2405BAF87
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Previously, each memcg had its own stock, which was shared by all page
counters within it. Specifically in try_charge_memcg, the stock limit
check would occur before the memsw and memory page_counters were
charged hierarchically. Now that the memcg stock was folded into the
page_counter level, and we have replaced try_charge_memcg's stock check
against the memory page_counter's stock, this leaves no fast path available
for cgroup v1's memsw check.

Introduce a new stock for the memsw page_counter, charged independently
from the memory page_counter. This provides better caching on cgroup v1:

The best case scenario is when both the memsw and memory page_counters
can use their cached stock charge; this is the old behavior.

The halfway scenario is when either the memsw or memory page_counter
is within the stock size, but the other isn't. This requires one
hierarchical charge.

The worst case scenario is when both memsw and memory page_counters
are over their limit, and must walk two page_counter hierarchies. This
is the same as the old behavior.

By introducing an independent stock for memsw, we can avoid the worst
case scenario more often and can fail or succeed separately from the
memory page counter.

One user-visible change is that reported memsw usage may transiently
be lower than memory usage. This happens because each counter
independently batches the stock charges, so the visible values can
differ by up to the stock batch size (MEMCG_CHARGE_BATCH) pages.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb1ea17e03730..06ec4d26cb519 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2058,8 +2058,11 @@ static long drain_stock_on_cpu(void *arg)
 	struct mem_cgroup *root_memcg = arg;
 	struct mem_cgroup *memcg;
 
-	for_each_mem_cgroup_tree(memcg, root_memcg)
+	for_each_mem_cgroup_tree(memcg, root_memcg) {
 		page_counter_drain_stock_local(&memcg->memory);
+		if (do_memsw_account())
+			page_counter_drain_stock_local(&memcg->memsw);
+	}
 
 	return 0;
 }
@@ -2106,8 +2109,11 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	/* no need for the local lock */
 	drain_obj_stock(&per_cpu(obj_stock, cpu));
 
-	for_each_mem_cgroup(memcg)
+	for_each_mem_cgroup(memcg) {
 		page_counter_drain_stock_cpu(&memcg->memory, cpu);
+		if (do_memsw_account())
+			page_counter_drain_stock_cpu(&memcg->memsw, cpu);
+	}
 
 	return 0;
 }
@@ -3947,6 +3953,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 
 	/* failure is nonfatal, charges fall back to direct hierarchy */
 	page_counter_enable_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+	if (do_memsw_account())
+		page_counter_enable_stock(&memcg->memsw, MEMCG_CHARGE_BATCH);
 
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
@@ -3987,6 +3995,8 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	drain_all_stock(memcg);
 	page_counter_disable_stock(&memcg->memory);
+	if (do_memsw_account())
+		page_counter_disable_stock(&memcg->memsw);
 
 	mem_cgroup_private_id_put(memcg, 1);
 }
-- 
2.53.0-Meta


