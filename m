Return-Path: <cgroups+bounces-10692-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C67BD62EC
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C4F19A009E
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B430C366;
	Mon, 13 Oct 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrf+Kg2/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59E7309DB1;
	Mon, 13 Oct 2025 20:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387711; cv=none; b=q3UVAOPgO31Z3zqXBHhg1SCAd7EA5MPeYh2LjB84Jp295O4LxzHct+7Uq/94ZsU+bjOpbx2Wp1ehK22E4ViWu2wdmLa4KzspfmyjkNOZIVC8pR1YbDRLNliuN4/UGOoBDYkwddoK0KHd3D835tD02Wcpdo8KRyc/KAmqbnc2Kf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387711; c=relaxed/simple;
	bh=Rz519K4RzNFN9C7FTifkrc2s4js15D9og5elk9stWlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPiaYS+sQ6wFvYo079OoUg+qplqHT9Lxp4vCTkey5Ut+XJ23Ao7sr2lb9H6dxJVwgU8yrHbN9D52xjWIi6j4hcAOIhW+sneRlf+1tWJIh2/B2UH1V1pD1XMTV8Pbb61lf3jmIt8ZiNdFPaek+UkZfMJXDhUmXx58YDjpqTNf32s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrf+Kg2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EE4FC4CEE7;
	Mon, 13 Oct 2025 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387711;
	bh=Rz519K4RzNFN9C7FTifkrc2s4js15D9og5elk9stWlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jrf+Kg2/DIvGCNfyCdPFH1ePE8ZtLXxlazjx5t7J+NDYTQdXxH1vJ2Z5Scm1VwP5a
	 SFKQYCjcRmfVTw9Fxi/xNljzr9UonGFOBfXxE7QbiWus82J7VAHAAxWimL73PWy8sp
	 KQUXmznsb7ngzcRXbeFT44rPWlDAU+23nOBfivg8Tdib55Ha8FFtUFqYb4WhKj7Wdb
	 xqn7qGyWBJJwWe38QLQztBFP0hxmcWWMmsct/VYNHEJMPHbsrHisH8W6evGfhEbgWE
	 qrozZxBzKyToJTV/iTb78znyKyHVL52oqRZ4h7NX0lZJzJVoUCRjEH6fXx7vkhe3gn
	 JrvAZ+P+clgQQ==
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
Subject: [PATCH 25/33] sched: Switch the fallback task allowed cpumask to HK_TYPE_DOMAIN
Date: Mon, 13 Oct 2025 22:31:38 +0200
Message-ID: <20251013203146.10162-26-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013203146.10162-1-frederic@kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tasks that have all their allowed CPUs offline don't want their affinity
to fallback on either nohz_full CPUs or on domain isolated CPUs. And
since nohz_full implies domain isolation, checking the latter is enough
to verify both.

Therefore exclude domain isolation from fallback task affinity.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/mmu_context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmu_context.h b/include/linux/mmu_context.h
index ac01dc4eb2ce..ed3dd0f3fe19 100644
--- a/include/linux/mmu_context.h
+++ b/include/linux/mmu_context.h
@@ -24,7 +24,7 @@ static inline void leave_mm(void) { }
 #ifndef task_cpu_possible_mask
 # define task_cpu_possible_mask(p)	cpu_possible_mask
 # define task_cpu_possible(cpu, p)	true
-# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_TICK)
+# define task_cpu_fallback_mask(p)	housekeeping_cpumask(HK_TYPE_DOMAIN)
 #else
 # define task_cpu_possible(cpu, p)	cpumask_test_cpu((cpu), task_cpu_possible_mask(p))
 #endif
-- 
2.51.0


