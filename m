Return-Path: <cgroups+bounces-11614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4633C37D7D
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E9C318C855A
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D3134CFCE;
	Wed,  5 Nov 2025 21:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyGGAVyE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A02BD5A7;
	Wed,  5 Nov 2025 21:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376674; cv=none; b=hV9PZb25Q2Docpv3S23S7B99J8Xdh6Of0N0BPw0u633MFLXXllz68OOUSx5LahX+7p6R2mML1CNgybWeZdLHyGuVycodO9fGIDPyNjXV0KilFJWUFne6G7ZEm78ublVsFxmRSGxdD6iiXebOAXPOT/SNZ6JB+mMQrZXtiWSEkAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376674; c=relaxed/simple;
	bh=ApQa5R07ipGBiVCyA3EgObV++ftyWFoj/ra3rzP5dCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usccpBdhZghUIgDAku7z92DqJZqzJPYnQHuazzV6+DqXIZGBnbtgXPVeaXnaVzeI2022LCH1O3Uz0J/N9tYYqQ9hth8GVtOFfcpWyxpwOMo6Ly4Yz9qg6B/2WZ3u9as8/c6ZkcUkPRua7+oF6bAskAncMlljZKZaanykd8EtyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyGGAVyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FFC7C4AF09;
	Wed,  5 Nov 2025 21:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376673;
	bh=ApQa5R07ipGBiVCyA3EgObV++ftyWFoj/ra3rzP5dCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cyGGAVyEEtnTJleIGvRPvdX/Cc6KEP2KDLlXtGtmXgRrPqu8Hr6k4dV2PS4NZXG/b
	 0TuJ9Xv9ZVXQWSh2Q5s5CnahVU/19PTlWf5bvziWhR6igHAhOvKcyNWxStp0IREsuQ
	 dCvjHLJNUd14dOSieLUuFACfi9H0I3xpfHEEvQVGyxubT+iCI4qTrf+SBosWgX9JwY
	 q8wUhQKNtbk77Gb5lvCUyYfdwPpF6f8ZJlnEwEOgiTX7YW4gUFPYiJIdvr5mvwbwxf
	 m8/DbHKO9hBpJpzZlv5oT+4ck92P+ii+pCIyA06mlA6F7sTvBrnc5dZH921cfMjKM3
	 ISpiuGCwxLlCw==
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
Subject: [PATCH 04/31] mm: vmstat: Prepare to protect against concurrent isolated cpuset change
Date: Wed,  5 Nov 2025 22:03:20 +0100
Message-ID: <20251105210348.35256-5-frederic@kernel.org>
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

The HK_TYPE_DOMAIN housekeeping cpumask will soon be made modifiable at
runtime. In order to synchronize against vmstat workqueue to make sure
that no asynchronous vmstat work is pending or executing on a newly made
isolated CPU, target and queue a vmstat work under the same RCU read
side critical section.

Whenever housekeeping will update the HK_TYPE_DOMAIN cpumask, a vmstat
workqueue flush will also be issued in a further change to make sure
that no work remains pending after a CPU has been made isolated.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 mm/vmstat.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index bb09c032eecf..7afb2981501f 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -2135,11 +2135,13 @@ static void vmstat_shepherd(struct work_struct *w)
 		 * infrastructure ever noticing. Skip regular flushing from vmstat_shepherd
 		 * for all isolated CPUs to avoid interference with the isolated workload.
 		 */
-		if (cpu_is_isolated(cpu))
-			continue;
+		scoped_guard(rcu) {
+			if (cpu_is_isolated(cpu))
+				continue;
 
-		if (!delayed_work_pending(dw) && need_update(cpu))
-			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
+			if (!delayed_work_pending(dw) && need_update(cpu))
+				queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
+		}
 
 		cond_resched();
 	}
-- 
2.51.0


