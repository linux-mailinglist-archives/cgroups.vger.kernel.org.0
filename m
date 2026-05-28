Return-Path: <cgroups+bounces-16385-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHZ2FUwNGGrMbAgAu9opvQ
	(envelope-from <cgroups+bounces-16385-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 11:39:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3BE5EFBF7
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 11:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3759A304DA30
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C624D3AE191;
	Thu, 28 May 2026 09:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rua/h5+p"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA063AE1A5
	for <cgroups@vger.kernel.org>; Thu, 28 May 2026 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961092; cv=none; b=OiNa5pWg7th44JByR2UMND0QpKurAv8r6lZmrZlVL/IUo1p8MPyQ6FnGfLwvNA9J0YA2Um9QDlRNiLePkKYfRCDt8PPw95U94onLMTimr9fgFZ/NrwrqobXaPFbUZXajBjiGPkQ71ycH10Sq07G+NeM42AhxWFS4TLHsVid5J4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961092; c=relaxed/simple;
	bh=5fdPGmsaekgSXFdnDNIqxNfeLfEf8EE6+pf01BBiDdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHerBWXw+RXnPH/mFNmH1QKQ3OZPriR34ItpzIgPOX6vQsteuTMIciNjsWJ4R2eOnQzQ7hBKaOKO822m9I8x0Ccfhw1+FvzL7IK8kN1zsVYVIdjSvCepRz5Mh9IFgfMBOM22pj8i9lKnwgUZ/bjq5vLYdDVDpMbbJ/8Ia1PnNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rua/h5+p; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779961077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=168BIu5dc0NAbe1hBH5woqQWWLGcJ7sVc64Of2NFMLA=;
	b=Rua/h5+pt/9jMZ7YFK9O/0Xvi+MqXZxpiRYslAQjiUFWz+UXNeuZGX6isMAwaSqSBENVuT
	YFlqRtxCB5wDvNNgTgrlbw9OkDilpT4VdeyLoVi3Ztu49Wt6Czwzw5gnwFRWt1QXVFM46R
	u/cY2vT0AWG9k2wZlRg+kCP8VpSSrPo=
From: Guopeng Zhang <guopeng.zhang@linux.dev>
To: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH] cgroup/cpuset: Free sched domains on rebuild guard failure
Date: Thu, 28 May 2026 17:37:42 +0800
Message-ID: <20260528093742.1792456-1-guopeng.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16385-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guopeng.zhang@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8D3BE5EFBF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Guopeng Zhang <zhangguopeng@kylinos.cn>

generate_sched_domains() returns sched-domain masks and optional
attributes that are normally handed to partition_sched_domains(), which
takes ownership of them.

rebuild_sched_domains_locked() has a WARN guard after
generate_sched_domains() and before partition_sched_domains() to avoid
passing offline CPUs into the scheduler domain rebuild path. If that
guard fires, the function currently returns directly without freeing
the generated doms and attr.

Free the generated sched-domain masks and attributes before returning
from the guard failure path.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 kernel/cgroup/cpuset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 51327333980a..c5fdebc205d8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1004,8 +1004,11 @@ void rebuild_sched_domains_locked(void)
 	* prevent the panic.
 	*/
 	for (i = 0; doms && i < ndoms; i++) {
-		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
+		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask))) {
+			free_sched_domains(doms, ndoms);
+			kfree(attr);
 			return;
+		}
 	}
 
 	/* Have scheduler rebuild the domains */
-- 
2.43.0


