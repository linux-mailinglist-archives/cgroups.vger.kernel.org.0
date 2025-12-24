Return-Path: <cgroups+bounces-12684-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6769CDC92C
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 15:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 331193063F94
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 14:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4EA359F83;
	Wed, 24 Dec 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZKhlN4Z"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176030F531;
	Wed, 24 Dec 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584197; cv=none; b=X2Vl2H9JrX2eoeLV4uRJC1Rt7kNhmlUAGyd0dh8qqVlTeKEXMrk8pHWCy9dxg3ES/qEcXT4Zm5XPPDiB6baPMpbQ6r+l+KIOAWK7PK2ppT0xHZY98Of+BoT/TZqI+nJRo4+hNX3oo+xDOhZSyF99jb5q61gSwcO0JgNk6wTc/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584197; c=relaxed/simple;
	bh=cybpUb9IFSrtSEn6CVNh90w6y5FCshbAQhcAn4rc9bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uO5ej4qI+7BsxOpGeVyZNXQhfT+bzOql3eZOzC/N3HiKoVsCQE+wamQX+Mc6/NEzkE13jaTWvip2AjbVq0MNpekSdMRwjSw1zniQ0/abVzsBlb7WK4u7nD6zzhF7CU6lSf9OOEs1rEKyirTz/oZok9y5EfIs8Qu39ywphOLKSmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZKhlN4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238F7C16AAE;
	Wed, 24 Dec 2025 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766584197;
	bh=cybpUb9IFSrtSEn6CVNh90w6y5FCshbAQhcAn4rc9bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZKhlN4ZCrk2oVrczUIaU8Cfl9yGLfr/qc/pWWi8kyHLCEe0fx9NhWolAd7YcDLlt
	 BZRBuTClb6m61goQkCT6GKAVXOcIK63R0AZ/gCzX6LqJEXpS8KFXfgk5IYrlxh5Hrd
	 ih5Gs4eYK/CvhYUxN+KFzLqM89y2IYLd2t4I4+0R37RwTn/dmLvj1KFWsfa07xxmX8
	 A+yQmeCIeX75hR/L2CiRAKErUAks3/er1m7nVBvG4qby8kN8ul2qpLIbj4jd8fdsyG
	 mi90adLBUBFLzBlEta2jTpaheAt1kTVPB8RktHKdy2lV5WyQxLjFX1ENx8jWVdMRVx
	 T4RQU5hez+7HA==
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
Subject: [PATCH 31/33] kthread: Comment on the purpose and placement of kthread_affine_node() call
Date: Wed, 24 Dec 2025 14:45:18 +0100
Message-ID: <20251224134520.33231-32-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251224134520.33231-1-frederic@kernel.org>
References: <20251224134520.33231-1-frederic@kernel.org>
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
index 03008154249c..51f419139dea 100644
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
2.51.1


