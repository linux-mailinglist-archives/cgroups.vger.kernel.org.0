Return-Path: <cgroups+bounces-11639-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D37C37FB0
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1086642104B
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D7135BDDD;
	Wed,  5 Nov 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqBh1peA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507534CFA0;
	Wed,  5 Nov 2025 21:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376871; cv=none; b=ZU7uaop61ybNN8+98BJjkdHCl4eUBeah2DGFUHhyMwHF4kqb8pniMPcFiAR7sFVLrwA2CogJHQ1/dvJ67zUVIDQqieL/H/6IRqV5BVFaz8mrZDNFYK2B29H99mJsvt1Mhgo7eHkptsnicdFpPXf1e2eo1KCwmque4/hGRA9j490=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376871; c=relaxed/simple;
	bh=ZcOaIdyFvlxFsz4x9bV8dX/urbiaQ2dIYf+IOrGWyKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqBjbZmJshrwiMfQX17c5j9yxvAZIWUTMbna1xJ+Nxj34zc3m/83NfisG6sud5dW9WAiGAA6yJjtcmskTdggs/Zwv7av4I2fApi3uLdEpVov8TQ2ugUU7A78xdPdnNUCD18Xn0Nxl1ovwF2t+ad84aUaagCsnqnkhItI08sc97Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqBh1peA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAB4C4CEF5;
	Wed,  5 Nov 2025 21:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376871;
	bh=ZcOaIdyFvlxFsz4x9bV8dX/urbiaQ2dIYf+IOrGWyKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uqBh1peA3OwqS5304aC8e215GChgjNQ+xz8WZIQjvhmtUS6f7nqh/RdQVeNQ2M1h0
	 N9H3k5WiLHpEb6YnuD/MWiQNlkqvtuYe7W0HDhMHx5X8eNFG6DBGHNKHlJoU2BaZ3M
	 rY4SVKr9xZY+z9hsVZG9KG/MPb2rofpyd5Vsybfo7AU5hqZEdZTrlKKYfGBaIM7drb
	 2RHucdD91Kljr+Sb2WKdMpyTxwAtuFcHF2KllXdzXz5owrbsFGBYFYh+LObYkRbxKp
	 6VQgFGT1HY05dsL5fIdD8y7aTR9kXshC2UmQ59+mAygTcfny0kDhWu6JYvJ0+oQUt1
	 C3W1zYUxNI9Ng==
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
Subject: [PATCH 29/31] kthread: Comment on the purpose and placement of kthread_affine_node() call
Date: Wed,  5 Nov 2025 22:03:45 +0100
Message-ID: <20251105210348.35256-30-frederic@kernel.org>
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

It may not appear obvious why kthread_affine_node() is not called before
the kthread creation completion instead of after the first wake-up.

The reason is that kthread_affine_node() applies a default affinity
behaviour that only takes place if no affinity preference have already
been passed by the kthread creation call site.

Add a comment to clarify that.

Reported-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index f535d4e66a71..e38ff9b943cf 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -453,6 +453,10 @@ static int kthread(void *_create)
 
 	self->started = 1;
 
+	/*
+	 * Apply default node affinity if no call to kthread_bind[_mask]() nor
+	 * kthread_affine_preferred() was issued before the first wake-up.
+	 */
 	if (!(current->flags & PF_NO_SETAFFINITY) && !self->preferred_affinity)
 		kthread_affine_node();
 
-- 
2.51.0


