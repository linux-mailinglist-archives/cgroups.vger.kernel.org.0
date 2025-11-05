Return-Path: <cgroups+bounces-11629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB46C37E76
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819543BD767
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D82357A36;
	Wed,  5 Nov 2025 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPMVl7Uv"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EA734D4F8;
	Wed,  5 Nov 2025 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376792; cv=none; b=DmA0EyEJuHphG/2oulKzXM1UNOlLhq44OAhsZjV33wqLoMp1pqSwdxBXd2KStYX9qtp+9PHtvCHVINdB/DoYYZIvTvt1BBaWgmwEL8U+52UXQhqj31X7OJoAxo+Bpq+SnPlCAZcXLiOldPrWcgGqxbcZNr1X+IMuVz0PzDtCB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376792; c=relaxed/simple;
	bh=/4qlBV0o6wHpMCHv+PGJIH0/5p5VMnEM2VldkFFk/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYH7QkPp/aFUYYXOLSFYiJ1U3/fHIsU9eNaPN3PuqUJLZD+Er5YywLcDX5xuEcErve/wwqPSii8HHv27fVXYrXUeB8qQ6b8a7cgVG+UXlTPXXn3DlIYFCT32lag96oRDZQpXApdi4cDG2lT/n4kJH46qe/VoykPko9qtl9dBBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPMVl7Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F01FC4CEF5;
	Wed,  5 Nov 2025 21:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376792;
	bh=/4qlBV0o6wHpMCHv+PGJIH0/5p5VMnEM2VldkFFk/hA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WPMVl7UvVPMRPQhKg2eY/RDKFC1vZcXdD08AGo6Qq/JtNgo8kPbs91s/W0brc+V5w
	 YScVpXtDvf96TJiGbbd3qjQihx33QG/l0iLxhIfzXvXPIv/C6GBZcpUsAOA5/LUs1n
	 oaHLFsM5/jX9GEIO4TEpslLn6l3LkI9tBTlpdE50e1TEqi8N11MwGL1neMCwf138kP
	 PlCf+SEUHcmKj9utkNTtcf5yDLRO3jFxTVgZtfFtvRXo7um6DMx6SJcAdriB6p90Nq
	 yLFLyG0eKaF2fF2W+V+aALv1nrBq3tM7L8gCnFVt09OqEynVIJmKSvNgTQpXOuXEU1
	 1rE/ac7aW9QzQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 19/31] sched/isolation: Remove HK_TYPE_TICK test from cpu_is_isolated()
Date: Wed,  5 Nov 2025 22:03:35 +0100
Message-ID: <20251105210348.35256-20-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210348.35256-1-frederic@kernel.org>
References: <20251105210348.35256-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It doesn't make sense to use nohz_full without also isolating the
related CPUs from the domain topology, either through the use of
isolcpus= or cpuset isolated partitions.

And now HK_TYPE_DOMAIN includes all kinds of domain isolated CPUs.

This means that HK_TYPE_KERNEL_NOISE (of which HK_TYPE_TICK is only an
alias) should always be a subset of HK_TYPE_DOMAIN.

Therefore if a CPU is not HK_TYPE_DOMAIN, it shouldn't be
HK_TYPE_KERNEL_NOISE either. Testing the former is then enough.

Simplify cpu_is_isolated() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index a127629adb32..a24acefacf9f 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -82,8 +82,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 
 static inline bool cpu_is_isolated(int cpu)
 {
-	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
-	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
+	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN);
 }
 
 #endif /* _LINUX_SCHED_ISOLATION_H */
-- 
2.51.0


