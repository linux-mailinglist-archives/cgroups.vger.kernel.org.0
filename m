Return-Path: <cgroups+bounces-13416-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CHHKLCddmmOTAEAu9opvQ
	(envelope-from <cgroups+bounces-13416-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:48:16 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA45A82C8A
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35F04300E5D6
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3798F30F53E;
	Sun, 25 Jan 2026 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="temhnd07"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE3E30C626;
	Sun, 25 Jan 2026 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381225; cv=none; b=KWv1whrs5N7zGhG8/lDlb1xT7dTkzJnQeb0+amby0WEelhlnhI/DG1w7XoomX1dP040JgRvuflRer8FY3+TDpQm23G7+MvLJu/z6zh9HP/8bNWnqBD5FWtP/6sp5Q5ocO/hDIBpSRzYmrJ2YzQXqYX/NDnPYup6WSvpIZo7lwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381225; c=relaxed/simple;
	bh=CSBqMHaVS4LYUH4nZYK0n1Q3mrGckGoVFLRQaFReEXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWwMIOom0BcOfG0zLH2CgUKxXXOXe5L+VeY4iPuSSTjuiEzXLu4vcx7mB/43X+j75E4hUOz/T4BGwqX2E4X2LQvFAj9/wk0OXM8udVEz1ELqUY0mRB71e3k6XyGRytUdI2uPmMzVpTfkluKdTj5RXQxz3vntmaDAZWr360XG43Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=temhnd07; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2BFEC16AAE;
	Sun, 25 Jan 2026 22:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381224;
	bh=CSBqMHaVS4LYUH4nZYK0n1Q3mrGckGoVFLRQaFReEXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=temhnd07RHCs6lNSYUz4dbj0AdS6VgNvDbHHoQlwXOwUJoMRDGW6YISibUt7MpdLw
	 jnI8yaWSPfggyIWb9RllrE4gvUIzfbvX7Wkkex438uhX1Q6DMwMifEXgCIYovYdPi2
	 Nz4roDXgmETt+bVRRIuD7SU6+baquysP7zPZFV0nRG/4zl4hxV7Rb9tZdivbsT5sd6
	 jRm8usW5uMG/cXmbECMxPFLPyK7QOV71u+IsduLIES03OtEaV2UMKcf37Gn97vcjpL
	 vmQQtoDswbo1ah3b/RS/Or1mUjKopIJ+G4wDoUQgpGQ9VxlcCsO/MsQZlJ6NkPPfEK
	 elrCpb0Jw4Vxw==
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
Subject: [PATCH 09/33] block: Protect against concurrent isolated cpuset change
Date: Sun, 25 Jan 2026 23:45:16 +0100
Message-ID: <20260125224541.50226-10-frederic@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,vger.kernel.org,lists.infradead.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13416-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.972];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: CA45A82C8A
X-Rspamd-Action: no action

The block subsystem prevents running the workqueue to isolated CPUs,
including those defined by cpuset isolated partitions. Since
HK_TYPE_DOMAIN will soon contain both and be subject to runtime
modifications, synchronize against housekeeping using the relevant lock.

For full support of cpuset changes, the block subsystem may need to
propagate changes to isolated cpumask through the workqueue in the
future.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1978eef95dca..0037af1216f3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4257,12 +4257,16 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		/*
 		 * Rule out isolated CPUs from hctx->cpumask to avoid
-		 * running block kworker on isolated CPUs
+		 * running block kworker on isolated CPUs.
+		 * FIXME: cpuset should propagate further changes to isolated CPUs
+		 * here.
 		 */
+		rcu_read_lock();
 		for_each_cpu(cpu, hctx->cpumask) {
 			if (cpu_is_isolated(cpu))
 				cpumask_clear_cpu(cpu, hctx->cpumask);
 		}
+		rcu_read_unlock();
 
 		/*
 		 * Initialize batch roundrobin counts
-- 
2.51.1


