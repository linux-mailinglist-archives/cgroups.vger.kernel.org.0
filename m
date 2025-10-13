Return-Path: <cgroups+bounces-10698-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54607BD633E
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0047D3457C3
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61873126BE;
	Mon, 13 Oct 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhePkCQL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A130CD93;
	Mon, 13 Oct 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387757; cv=none; b=ZMP06tBXraUzoGL+apIMb2kq5n7XInUc3wo1DIv+RpvlhtxCSvvI15b/aow1UICMMNlQbjwPaJpL8Dfg3s8CAaMB0DunC2w3MWfF3Yyt+Ej6WYWLNwxVMMlwnDuUtsKM+swQO0mO1zhQi2s8qrZoIzLaho18zk5Xp6AF9ygU8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387757; c=relaxed/simple;
	bh=VRca4O5xWSvVtV07vu7T/vayv/vKzk4YtiAHpk59aYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJFaAdXawr1QAAM7OGQH5M3x1pXjcejJnJcYD9ZzvGLhHx+WYzbNfxB3pR7SiwOIjvYblLOvDWU3L7CYAFgcZ+gMHu/B8Pmikvid9SoLr9WdvJt1o+TtvzfECbgHz/Dt2xCAss2VYwGVwW2PcwT6ZzpW5iWveNsYFGQ95IWTzZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhePkCQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E744EC4CEFE;
	Mon, 13 Oct 2025 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387757;
	bh=VRca4O5xWSvVtV07vu7T/vayv/vKzk4YtiAHpk59aYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhePkCQL/66n70lV9xZxYwRRP+VnIkS+CH6ARH9WtcldkTiOp5Ob386EHKyl3AMBa
	 9RYk+wDM4ovm/56mZ6bzkEEh9UnuW+WYeuSJUUus+TACOJTuYhJNsvGA+p75if0nIr
	 eF/1rT4tHcaKgPPXNTve99sj8RqEvhRdV8+5zdkPR+FLUveu003ODzhiA2YZdSiMzN
	 L6N60HePBPGl52ouzhwYD9vF78x7wP2Yvg3D7LD2eoI4MiHO+TabowgoVKZ1e5gdiV
	 DR0pYSljDpr9QuAxXqKVRzlLFoIoLIv9vydg718x4I1aBRpQXVEM3pIv7QhMJ6fOYq
	 +KzLX6+lrv2Iw==
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
Subject: [PATCH 31/33] kthread: Document kthread_affine_preferred()
Date: Mon, 13 Oct 2025 22:31:44 +0200
Message-ID: <20251013203146.10162-32-frederic@kernel.org>
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

The documentation of this new API has been overlooked during its
introduction. Fill the gap.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f3397cf7542a..b989aeaa441a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -857,6 +857,18 @@ int kthreadd(void *unused)
 	return 0;
 }
 
+/**
+ * kthread_affine_preferred - Define a kthread's preferred affinity
+ * @p: thread created by kthread_create().
+ * @cpumask: preferred mask of CPUs (might not be online, must be possible) for @k
+ *           to run on.
+ *
+ * Similar to kthread_bind_mask() except that the affinity is not a requirement
+ * but rather a preference that can be constrained by CPU isolation or CPU hotplug.
+ * Must be called before the first wakeup of the kthread.
+ *
+ * Returns 0 if the affinity has been applied.
+ */
 int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
 {
 	struct kthread *kthread = to_kthread(p);
-- 
2.51.0


