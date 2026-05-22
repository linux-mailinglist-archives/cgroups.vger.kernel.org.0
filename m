Return-Path: <cgroups+bounces-16226-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD2JJJ/VEGrYeQYAu9opvQ
	(envelope-from <cgroups+bounces-16226-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:15:59 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81A5BB0E3
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 03A603056F1A
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 22:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45EA399368;
	Fri, 22 May 2026 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2znhhr8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D139185C
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 22:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487606; cv=none; b=GBm6xWQfOE9gsbFY5GQEquOyJDgIfhsMrLOgNKaYJ2QgFcqcIr+55bvhRn1GaMnonWZx2qY9OpfWAxuv5gllWvIBfoVVJbWp4VhBZH1+kkifLtUkhIT+GrW1QMYAyZ45gz1igK6DnqwNWaIG0A8VdCHuBJezF9VcFkqrVe6lPhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487606; c=relaxed/simple;
	bh=H/XQBqBRChs9osHNUhzeryf/uvzIMoUecr7yd1hITkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWapiOU6+vkdALT2i/YQIea+hG/MWgcjjVkfi2lv3TnuTnxjVE0riKcH2lV68eufcgMFLGgfmHFea59GKwCvFvyluQLcVUk4XMYpW4flxhNMzP318dMSXuoz2g4RsUMT6HphjNOeX6Ku2sJLCSkYrnfg1i/sZsqSgGNYHglqeCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2znhhr8; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-479dd56d016so6213459b6e.3
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 15:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779487604; x=1780092404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nur42U2oSMrw1R78cJIX2iGXEeitKT4aAu4TEsPr2eM=;
        b=l2znhhr825O0VATWasx5uUKyMCtESUVcpZ5bYjG6ZelhNiwwmdgF/UYBEg71MXq8oH
         +LVz0D1IJcBpNhTANGwywm3zH+T7VIEpYOQ5QHuzVWRhu9G6OYrAXQ1qwAQIAiAjeFbk
         G3cxeLeZ6kQgOmZnAqXuSk6z/M3sWnyvGGvFFoyLh17UG9YKo/bVcwkrIdmHL1lk+DkQ
         gsx/ZysoWf5LSNbY5iAkasxAv4zFjxTgQnp6uX9yCjSjMiTZC1tdyyYC5Cr92PwbDTdi
         K+koGmg694X6QJELHGLYnstdHJfpP9Ub7oSffoHvoodUbXPxLxIBpWnLEyy0FWSmPWsJ
         Yp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487604; x=1780092404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nur42U2oSMrw1R78cJIX2iGXEeitKT4aAu4TEsPr2eM=;
        b=gfCoBSojnvMVwMK3uy+8AW+EsGtUceAphEqvCbsp+mGjk43DTjuqFsStd2DG/Lxfo3
         8F9WAzxkiJ+8idmjfLAuF2+o0sya5yMReszLuGfW9REcDamdkAVbCIuJne0YIMbf50F7
         A65E9cEska87gcUr3L5aKFpSaFZi0DsV24S3zGxjBhuiuR+k2vwPBvc0RqxN+1Qxs22w
         5L0tDXAOyo+05Qd0cmovVhmYBvjEckovhZTBvYS5xJ7Z1OUW7yc9jTMjH2ZbdzJKcFWY
         t61scWKdm0+rID6pjISTLTcwwMY3oTuQyqeIb4u4OD3gsP+eOm3zVxQ+kERS6YLj1nAJ
         5IWg==
X-Forwarded-Encrypted: i=1; AFNElJ+0YnHKGMNeEs/ekwo8f4DMxRlQNTwqEWfawI9zVDD7ECHpkOzz+U/BqjyXAjP4/XQ6XjjsYiwQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbRR8MeKurCKu866zGXgncLPmlvKRmj7PLwjeqPCLedYtYFL5
	P61t4nx2k5p6xBixbv7IKgexobd0e2sq6/zYoUglcpFdoygZLqdIHzoWg/7ieg==
X-Gm-Gg: Acq92OEI0tN4LSrDBYFvITIHO6Ld5ODtXtAS6DFA5F+Qf6k1Sy03ijudejjGTbuEIYl
	eAYFa29EhMdYhwW/MeZ/Tz6VlqAef2p7FzIneWXLUu1ddsDxYl0Fruc4FekEZIlgwkENcUvuB+V
	jD24+XNaXmPWS3K2EnE6nfpkG89nQiCaN58zUaj47e5Wa5fEQ7UvlrQp5TJ8pSjy2cMInVBwunf
	1a+PD+62iNYUgaFEEQgN6wWvJds7621jJUQEqWtbaIotxpu2pU0ugIlfv1krCQjnivdRCMvl+eW
	K0OGQo2cTmJzpNU5njwXZgk5AovQymxczBwRo3sI8ZH9uFWBRZziBzoxq1NxxWTmQ0x+ah+IVnp
	4cpq126dy7tMUVdYhWOUlUqei6Xdc4rRuLyzLufvBC71UJCg2Oe2gOOI1LHenn3C5O1zq7c75cl
	PM1pDjW0ooMg1o1u7uNT3PgCxiDXWrWZr9a6Vdd8Dr739nIhazWrWGzw==
X-Received: by 2002:a05:6808:e494:b0:485:5f33:91ab with SMTP id 5614622812f47-4855f3393c9mr972537b6e.43.1779487604358;
        Fri, 22 May 2026 15:06:44 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554755d06sm1157002b6e.16.2026.05.22.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:06:43 -0700 (PDT)
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
Subject: [PATCH 6/7 v2] mm/memcontrol: optimize stock usage for cgroup v2
Date: Fri, 22 May 2026 15:06:24 -0700
Message-ID: <20260522220627.1150804-7-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16226-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9E81A5BB0E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In cgroup v2, it is unlikely for memcg charges to happen directly on
non-leaf cgroups. There are a few exceptions, such as processes that
have yet to be migrated to children, and tasks that are reparented on
memcg destruction, that charge to the parent.

Because it is rare for parent cgroups to receive direct charges, stock
that remains in them are wasted memory.

Drain parent stocks when the first child is created to return those
pages for other memcgs to use.

This optimization is not for cgroup v1, where tasks can be attached to
any cgroup in the hierarchy, meaning stock can be consumed & refilled
for non-leaf cgroups as well.

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 06ec4d26cb519..fc1e1b10b6ab6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3968,6 +3968,21 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	 */
 	xa_store(&mem_cgroup_private_ids, memcg->id.id, memcg, GFP_KERNEL);
 
+	/*
+	 * It is unlikely for non-leaf memcgs to get direct charges on v2.
+	 * Drain the parent's stock if we are the first child.
+	 */
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
+		struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+		int cpu;
+
+		if (parent && !mem_cgroup_is_root(parent) &&
+			      !css_has_online_children(&parent->css)) {
+			for_each_online_cpu(cpu)
+				work_on_cpu(cpu, drain_stock_on_cpu, parent);
+		}
+	}
+
 	return 0;
 offline_kmem:
 	memcg_offline_kmem(memcg);
-- 
2.53.0-Meta


