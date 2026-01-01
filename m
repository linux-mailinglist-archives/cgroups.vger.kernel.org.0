Return-Path: <cgroups+bounces-12869-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A459CED825
	for <lists+cgroups@lfdr.de>; Thu, 01 Jan 2026 23:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D55304B3D1
	for <lists+cgroups@lfdr.de>; Thu,  1 Jan 2026 22:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F46B303C8A;
	Thu,  1 Jan 2026 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C2srymam"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E5C303A1A;
	Thu,  1 Jan 2026 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767305818; cv=none; b=KWDJrMlzpkIPQSL+jLK1RhWJMoUUd4BKtNFdtnJ3Mxqp5UhZiYRx8wMHQj9or/rMfPV9PZu0wznpRX58XskjMzsBLS56SPMgsn3j19xFjTP6woOEfUULAzzWjpoLNEQj9i7fWudL9JM+uxCswmB7YaAN70eZ/7gkNE7wqOZVK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767305818; c=relaxed/simple;
	bh=xcMcLXp9lSxfZhVrsREHiMXj3hvNw6ylCQ2N03wRKM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el9GGVB2IitcmGPaR2qg/EkSI6Hwd9ZSSqNw9cRrEpxPil4CIJQo+O8CbStvu75nzsCiEwiiHVgIqEeEsvaM16Nksu6FexIeFFB17TnFxUi+oYwDK6y4EswW4VNwWHKyawf1jPyumBQbBVxtDgKsCtRh8XpLwT980hqxl3072lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C2srymam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71B19C4CEF7;
	Thu,  1 Jan 2026 22:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767305818;
	bh=xcMcLXp9lSxfZhVrsREHiMXj3hvNw6ylCQ2N03wRKM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C2srymamUA0MXxivD0ZeKbuJECZYnpJecM0twnYUVIw4QXxFyrb6VkzOgcYkmHia7
	 +DnWEgfnwas3kVZuLf9KnTKlIMAuWVsPt4pwS9udwPhgI+qL1DxK7Sod9D8m263NIa
	 W7qFbUW/tCcxsOubXiycdmSVDZ9lABvy+cWUVjffImRmPd4OCVaeJltguOh1R2iLNZ
	 JtcehsjD6GO3wNqGufbqTqFGlp6vOWIx4t10NRQc+URkLgOMwMUo+VgTIAgOoZRK6F
	 RExsJ3KheHEyeLBvwtNieJ9/RZAvnTRNxtfaiadl5mYG2GYxsztP4x+qItJkx55huk
	 8+pERh53gsTmQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
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
Subject: [PATCH 20/33] timers/migration: Remove superfluous cpuset isolation test
Date: Thu,  1 Jan 2026 23:13:45 +0100
Message-ID: <20260101221359.22298-21-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260101221359.22298-1-frederic@kernel.org>
References: <20260101221359.22298-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cpuset isolated partitions are now included in HK_TYPE_DOMAIN. Testing
if a CPU is part of an isolated partition alone is now useless.

Remove the superflous test.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/time/timer_migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 3879575a4975..6da9cd562b20 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -466,9 +466,8 @@ static inline bool tmigr_is_isolated(int cpu)
 {
 	if (!static_branch_unlikely(&tmigr_exclude_isolated))
 		return false;
-	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) ||
-		cpuset_cpu_is_isolated(cpu)) &&
-	       housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE);
+	return (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN) &&
+		housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE));
 }
 
 /*
-- 
2.51.1


