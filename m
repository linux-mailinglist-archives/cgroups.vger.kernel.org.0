Return-Path: <cgroups+bounces-10410-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA0BB9826B
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 05:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E7C2E592E
	for <lists+cgroups@lfdr.de>; Wed, 24 Sep 2025 03:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4376B22D4C3;
	Wed, 24 Sep 2025 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SBXGZ2/z"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122C221F20
	for <cgroups@vger.kernel.org>; Wed, 24 Sep 2025 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758685344; cv=none; b=o4PdwxFhaoqcsxwANVaKCu2p1yy1NbHOVQkmkhZeM3EGX33KqEGNjjUZorapLp0EDaQEBTrj23HrzPD0h5QMuDnUXAIy4WjV2HyFutsI8WP7RTeTLTK22k6CKg21cPFSOHxihdYHtlz/564CxlgVMAi1ZQ/G6aiWc4gG9RyiNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758685344; c=relaxed/simple;
	bh=JfIAWDuN1kKed0FYgT3jkRN7qq4iKlUIG9GpMZNLTHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvn9lpg0Vr+X25Ulc5q8JD02S9fsK/f0Q9wY3F3wr6HipWXjdBQvXebBaOmEchI9pLUNqUoOJNIkE5NLLaHo1Wm1haiwAFcFsQMmAHZMPsH3+VcMZ5MjlzmPFF9SwP4S/U4kQmk9sOlhjrUtTr5cJHCm9NUMqxswtlFwvxLRhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SBXGZ2/z; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27c369f898fso21677515ad.3
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758685342; x=1759290142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsJTV5DUFz04JQKhysbzOjs1PoDN4ekmuz2g31Q2mg8=;
        b=SBXGZ2/z/hWy7nePgRqH8oxZEzeaEJs9yMavjspCzkBvWRyR9xlObEeOz4k+Cje6Ok
         W3k8l/oWd8mvxJThE6O7vUR9pY1CKONA2L3J7KRiQ0IWZUiTDpwrfiiJBKttHZ0MAJ9f
         RbRuq3zG8/Lwlot5q+qZIueQsWDJRnHzeQ1K7KeJGCE/TgKDV/UDm3n5lM/k/leUaz6t
         GKqewGmKapr7WeqT3C4oA+MINB/DMV5Xuqg5sss7Z/vTyMPxxbPJjPjUPJOR5kvGbIo8
         ZK0fUuqHhYFQ5timiDiS91iJVs6l4SeaMRnxIi43+snVC8dbKGvanPDBxXJZWM1OSdaG
         g0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758685342; x=1759290142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsJTV5DUFz04JQKhysbzOjs1PoDN4ekmuz2g31Q2mg8=;
        b=ZlBfJXE0bTz71qEp6JERI7Uhfs+bU4fkSMWIRYVwV0/J1018MVAvXppErhH2g+oVBU
         ozLqnlavAyxiXK34GIaJkcKNE9/f8UcA89kIETsQIh4J5toOGB1N0PRPPuj04BZ3KIim
         OQLURARj6ZRMF/G7x3pq1u2Cu2msYBiXAHO4/qKNJqyso2bvfNqpvqNBlGsjMs650O1o
         OeppbV/s2QIafCR25+8KZzcO3/JM63oj1qgNReCOzNuMURb7s7hYZPT2jijGWZGPEhmj
         w1dPPqll3joobY0jAtR1q6cKItgUBwwY648HQb8HOaqy1SItXnhf3ZTwVCljLjnrO26d
         lL2g==
X-Gm-Message-State: AOJu0Yy/n8Jg8XQMUHnxGzJdLKkfC7awGd7RuHybYNKFqv2Zg1siAUhO
	CKXNw5kIB6Ob7pLbcEs1HVWtmIIIVhwDpoMyLy3yiEozwJYiNBkWzC2AXWTY5BbWaUqj/MbxOHk
	B7yfc+/NR/w==
X-Gm-Gg: ASbGnctGF9s6ZPRpOV4uBpP6l8mlmt3Fa4x9NVD/yGbnZ7KSSW9GqK89JsMUKzWWp59
	XOTJNwJeMtrEqoc1a1DwDp0HcPl8pqM/u1J/AF6Ez5YFlvE561jOrdZ1HKaaqAVkCJCvV10InnW
	RKKcs+fS6HNDERurAqY7MWBR1gJSK59cG+4jYTnfJ6eguUDPQJ8wLxRdZuSNntYReGRBkAU0f56
	Dagx1UvEimA0ALno0G8lvvPmDxK7+PVfXdbmJ/fm1bBnmuJsbrQUwzBgW+W+aH0fQCf/Z/pbaXA
	GGWijZNFJLQXeFvuiY02n7lFjaUMX5PkLegCsT8dlWmDYdNO0YATsvnpeG0xQz2cZGc21N7W5I3
	2zhNq9dNC6060yjPN3p90JQopKFsJ3+75uQ==
X-Google-Smtp-Source: AGHT+IGrcT5Ka2xMEBu3sbqKbDUXPNl6amxvjYaBM1CXrmwchGIMFPPAdgNK41sSgXmtBkVzwz8xzA==
X-Received: by 2002:a17:903:8c6:b0:269:82a5:fa19 with SMTP id d9443c01a7336-27cc61bed26mr61207375ad.45.1758685341761;
        Tue, 23 Sep 2025 20:42:21 -0700 (PDT)
Received: from localhost ([106.38.226.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2752328629fsm88067475ad.106.2025.09.23.20.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 20:42:21 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	yangyicong@hisilicon.com,
	will@kernel.org,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 2/2] memcg: Don't trigger hung task warnings when memcg is releasing resources.
Date: Wed, 24 Sep 2025 11:41:00 +0800
Message-Id: <20250924034100.3701520-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924034100.3701520-1-sunjunchao@bytedance.com>
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hung task warning in mem_cgroup_css_free() is undesirable and
unnecessary since the behavior of waiting for a long time is
expected.

Use touch_hung_task_detector() to eliminate the possible
hung task warning.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---

 I didn’t add a fixes tag because there is no actual bug in the
 original code, and this patch is more of an improvement-type one.

 mm/memcontrol.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..fc73a56372a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
+#include <linux/nmi.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -3912,8 +3913,15 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		/*
+		 * We don't want the hung task detector to report warnings
+		 * here since there's nothing wrong if the writeback work
+		 * lasts for a long time.
+		 */
+		touch_hung_task_detector(current);
 		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	}
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.39.5


