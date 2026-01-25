Return-Path: <cgroups+bounces-13438-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cH9HFFOhdmmOTAEAu9opvQ
	(envelope-from <cgroups+bounces-13438-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 00:03:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 665618311F
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 00:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FADB305FCA0
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ABE31196A;
	Sun, 25 Jan 2026 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szmnbFCF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073DB30E0F9;
	Sun, 25 Jan 2026 22:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381405; cv=none; b=V3AsQEiDprMfGA5R+/ele561K6WO76229n098C5ajrqDoyFDP4mnnkw+JfKF28mlUMooprUrW5YHnzGdZTATnjQXeu4MnIuNVKwwnzl4Ha5vuKPtCmkz/gMbc9rBm4oOcLM2ymrRNZcGjOWSueaJ7/PHZJeU9fwij05V9haxIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381405; c=relaxed/simple;
	bh=cybpUb9IFSrtSEn6CVNh90w6y5FCshbAQhcAn4rc9bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XwQdKl/jIxMS42kc6VmbIYRMN0xOt9CfmJaeC3CX2fyKi1x8qGjwGFywTmCTV+6qcOpqpQcy1qi6WjNM5xrPhcvH2jxKKhjCv4f3h3SIR49BHntjUUGYf0KJzToKT1tO3tyrxSFgfLvP5/neO/tGNRNsKNANARa0wQyo1adYc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=szmnbFCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6663EC4CEF1;
	Sun, 25 Jan 2026 22:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381404;
	bh=cybpUb9IFSrtSEn6CVNh90w6y5FCshbAQhcAn4rc9bQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=szmnbFCF+vyRguPs+qTjhgn0jgwAxnTgIPrBfdW/GdN/D7mcBxVuZHNNiCj3DokE+
	 8u2aqDutKHZoWAe9XmC3IYWWqKSGUc/71rTf+st24SadAtLG/5tVE/jHMtduy4FUkz
	 SUAJb8ld4SDph1t42LM8gIYOi58uwgPrAnn5YD3a1P8uxg9qB72/8ZQGGOIi74olWd
	 CFCrf6sohYmd90ny+Aju0E7DCjeBioTCp58AJPJYv8B1r5e24LmqFQ57VDbkaj4U1B
	 ROdap0VewRCNie09oE4Flv5Uo1LqjdEi7bFQzZQH0fJGsTjtkrDTq829RCaRtYO8AD
	 d3bzLzh17qang==
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
Date: Sun, 25 Jan 2026 23:45:38 +0100
Message-ID: <20260125224541.50226-32-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260125224541.50226-1-frederic@kernel.org>
References: <20260125224541.50226-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,vger.kernel.org,lists.infradead.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13438-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.966];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 665618311F
X-Rspamd-Action: no action

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


