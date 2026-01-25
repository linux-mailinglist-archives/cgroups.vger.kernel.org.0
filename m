Return-Path: <cgroups+bounces-13414-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAweO3WddmmOTAEAu9opvQ
	(envelope-from <cgroups+bounces-13414-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:47:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C7482C48
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C32F30117BE
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A330F541;
	Sun, 25 Jan 2026 22:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyHyvsIu"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7D430DEA9;
	Sun, 25 Jan 2026 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381209; cv=none; b=ohYb1L8uQ5znDYpb3a4FgmQgB1kFvcQy/6yhLiKMP+mgp8wHEtFHG7AnHITDWOT+T5hQY+sLdQeNznS7KrbDC9G5A3pvkVOQ6lErTqS6NXelW+G0TEn/Lx8hYfV/oRq9DgmnYUgb3zVEl3KSglnXJFjmfROYrmrnlP4DJpjHzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381209; c=relaxed/simple;
	bh=N56RJwx7Vb0djbwM5UfAAN+LOP0Kn2KqSnmCrDj/jJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f9mbm/0yWyGPGPnDuIm4/AV8FliGFzhkhSHFJg8IlslmQ5hBuKlUZubxZUUlRar1pFJT+nl0REKJeB6vqj/oDd48hrabOJWONBmxdLDrDbv8PlPqlH8CNU07CeFP3+F9SEXoDMhsA2ztS+gy14jxDgEX8XI4RgOA3CKUsWG2SM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyHyvsIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B7AC4CEF1;
	Sun, 25 Jan 2026 22:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381208;
	bh=N56RJwx7Vb0djbwM5UfAAN+LOP0Kn2KqSnmCrDj/jJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyHyvsIu3okQ7Dlrf1ZCbraTIEmvPj3HTE7McqBEPQFbSMXqbR7JC1o8FMfOZ5Nus
	 Q0VStLXxJa8HFC8tU9CxjBr+GJAO0LSOS68Rky95s/N/EpY3B5xpjhtYJYUnX4DqlF
	 ugG/ANCw3sRSMZvTBSK2hobdEYUt4T9D/rHhR+ohNj687AyBkaVf1S/Ds/MAyJa6ue
	 ntDh/UYinNi61GJeloa/JJXblaHR6n9fE0MGE8ZRm26svM4ZXhwoEZYsHjx6klL++o
	 gid4fhZqJNRtQyW/mAw1DvMlbvBzIy1VeVFBCDXa+U33RbENMF2WCVNMGDNzansp9s
	 u9p6/bEs4ZVWg==
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
Subject: [PATCH 07/33] driver core: cpu: Convert /sys/devices/system/cpu/isolated to use HK_TYPE_DOMAIN_BOOT
Date: Sun, 25 Jan 2026 23:45:14 +0100
Message-ID: <20260125224541.50226-8-frederic@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-13414-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.974];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84C7482C48
X-Rspamd-Action: no action

Make sure /sys/devices/system/cpu/isolated only prints what was passed
through the isolcpus= parameter before HK_TYPE_DOMAIN will also
integrate cpuset isolated partitions.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 drivers/base/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c6c57b6f61c6..3e3fa031e605 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -291,7 +291,7 @@ static ssize_t print_cpus_isolated(struct device *dev,
 		return -ENOMEM;
 
 	cpumask_andnot(isolated, cpu_possible_mask,
-		       housekeeping_cpumask(HK_TYPE_DOMAIN));
+		       housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
 	len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));
 
 	free_cpumask_var(isolated);
-- 
2.51.1


