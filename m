Return-Path: <cgroups+bounces-11621-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDEBC37E19
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E10E3BA610
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89AF350D79;
	Wed,  5 Nov 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptyyf6KV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C7C34DB78;
	Wed,  5 Nov 2025 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376729; cv=none; b=LiqVZFKXjEYRFTCa08oiExmo/SU63HPdHdzkH7Ja00on7vE+BnHpzhEfruIOGjwTWe2O3HERz96lwGc+NoE76ED+p3cIp1k+6WaszWRgVB+9+fqKVP25qbuGbig/ioDBGaukv4/RViHcw9ku4mmu9L99lHLL1Heer8WL/Fv860g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376729; c=relaxed/simple;
	bh=VdxniS9PgPy7NwhH2qd2yJdMmQz1qplz7zrJIak9Kiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oGv27mnrkOZPQgYN2E0xZah5L3VPTt7nEPEnLtEdhTopjWMR3VHZFltXVhjcG/Q611ES8ZVbyrzNqrsEJLSLVJC4V/pGMaRca/RiAD4dMue40uHiY6GkVPxWdj3GDiueq5bDHHEFaMRGiPoPkVj4YVmUWS3QzbavSDprlLLK5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptyyf6KV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1154C4CEF5;
	Wed,  5 Nov 2025 21:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376729;
	bh=VdxniS9PgPy7NwhH2qd2yJdMmQz1qplz7zrJIak9Kiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ptyyf6KVzJ0lA9mUbJMRTUMDBxFbFqsC7D72x5Es055cz5O6o+7X0VRAI46bJaeX1
	 IR4WE2Lj3E9TiqBgFbWjMrFSWMNGGAy8Bh2T4cDmUyCakgmccGz0OLgjYIo10G4vez
	 X41hI+3qx0OgMbveZU476QadXo3RIrr04BXSlHz9KQ2vGGxtGVUlpa0WFTm+A/bBvp
	 1BJar5S1ziv66ELBOGUJEuzhVHcaxUtgsuDeEcD/R0uDbBnw/KgyFHlPjQx0YWswAG
	 UWIjs3xA+jcx7za2UJJZ6K84bgaKV1VKCrBdWGGmlKDLgPoerOSfU/sxU0t89VhBaD
	 WWhAqun83nwlA==
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
Subject: [PATCH 11/31] cpuset: Provide lockdep check for cpuset lock held
Date: Wed,  5 Nov 2025 22:03:27 +0100
Message-ID: <20251105210348.35256-12-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210348.35256-1-frederic@kernel.org>
References: <20251105210348.35256-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cpuset modifies partitions, including isolated, while holding the cpuset
mutex.

This means that holding the cpuset mutex is safe to synchronize against
housekeeping cpumask changes.

Provide a lockdep check to validate that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuset.h | 2 ++
 kernel/cgroup/cpuset.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2ddb256187b5..051d36fec578 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -18,6 +18,8 @@
 #include <linux/mmu_context.h>
 #include <linux/jump_label.h>
 
+extern bool lockdep_is_cpuset_held(void);
+
 #ifdef CONFIG_CPUSETS
 
 /*
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8595f1eadf23..aa1ac7bcf2ea 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -279,6 +279,13 @@ void cpuset_full_unlock(void)
 	cpus_read_unlock();
 }
 
+#ifdef CONFIG_LOCKDEP
+bool lockdep_is_cpuset_held(void)
+{
+	return lockdep_is_held(&cpuset_mutex);
+}
+#endif
+
 static DEFINE_SPINLOCK(callback_lock);
 
 void cpuset_callback_lock_irq(void)
-- 
2.51.0


