Return-Path: <cgroups+bounces-17830-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bx1LDUNIV2pPIgEAu9opvQ
	(envelope-from <cgroups+bounces-17830-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:43:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D868275BFFA
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 10:43:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=gp+8PHzg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17830-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17830-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFAC0306ED8A
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 08:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EA13CF1F1;
	Wed, 15 Jul 2026 08:43:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FAD3CF1FC;
	Wed, 15 Jul 2026 08:43:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104998; cv=none; b=nzLEbn/5IMA6tRMcirawxn8h+TTqsCOZdEyqsFYl3ZdWx7zoDDR1GeyWeT70kqlXlSTyezw0IaW+hsabJ4IOqOclFS9eB7yB2gKuMoGxtYRlapquoedVDvVptyVAu2yMlY9ZyaKHB3nlP4+Jve8yVH4MPL1/vmlBQ31qRJOUxkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104998; c=relaxed/simple;
	bh=5q0Y5I8yIawo2ynnBMhalYpb2NrtyICRNplR5jao6JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJ6jRfX3rpsfHDPmtQ5kqxtbE94EeG3/XBIyPMmBx+A3riVAdUvO7SuPb8aPo5K6giBhZYG3YN3XGUzZvmhJHBwreNOIJpqE3tLhlcmdDzBPi0NUcj6ZBrNWmdQjBknjSDCh+15gRXKYrbULJUVCHOO1ja0D4qI2izshrM7HQFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gp+8PHzg; arc=none smtp.client-ip=115.124.30.132
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1784104978; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IAnvCrJF1q7w7fmz3FaNGMcNd/i1AfT8lqKrGtMAUZ8=;
	b=gp+8PHzgqHbvgE9eTyTtdC+3k0o+VdtUuzl470Vcp75RQNNhPnjLd5yf8RMdWKSy/8S9RvTjqfWcX78mRHO1BpDB6m8SiLNUGkFljIWu8hKHaMXmNp2XAWH9nUEbYiKRJ4YoYeeLWKno3LeavteehrVHdXHzr4wpbtd/T9z1wo4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=lulie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X78Xw0Q_1784104977;
Received: from localhost(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0X78Xw0Q_1784104977 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Jul 2026 16:42:57 +0800
From: Philo Lu <lulie@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: tj@kernel.org,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eadavis@qq.com,
	surenb@google.com,
	akpm@linux-foundation.org,
	dust.li@linux.alibaba.com
Subject: [PATCH 6.6.y 1/2] cgroup/psi: Set of->priv to NULL upon file release
Date: Wed, 15 Jul 2026 16:42:55 +0800
Message-Id: <20260715084256.43412-2-lulie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260715084256.43412-1-lulie@linux.alibaba.com>
References: <20260715084256.43412-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,vger.kernel.org,qq.com,google.com,linux-foundation.org,linux.alibaba.com];
	FORGED_SENDER(0.00)[lulie@linux.alibaba.com,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:eadavis@qq.com,m:surenb@google.com,m:akpm@linux-foundation.org,m:dust.li@linux.alibaba.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17830-lists,cgroups=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lulie@linux.alibaba.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,alibaba.com:email,huawei.com:email,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D868275BFFA

From: Chen Ridong <chenridong@huawei.com>

commit 94a4acfec14615e971eb2c9e1fa6c992c85ff6c6 upstream.

Setting of->priv to NULL when the file is released enables earlier bug
detection. This allows potential bugs to manifest as NULL pointer
dereferences rather than use-after-free errors[1], which are generally more
difficult to diagnose.

[1] https://lore.kernel.org/cgroups/38ef3ff9-b380-44f0-9315-8b3714b0948d@huaweicloud.com/T/#m8a3b3f88f0ff3da5925d342e90043394f8b2091b
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Philo Lu <lulie@linux.alibaba.com>
---
 kernel/cgroup/cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e787dc0eacd7d..4a7d334be50a5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4061,6 +4061,7 @@ static void cgroup_file_release(struct kernfs_open_file *of)
 		cft->release(of);
 	put_cgroup_ns(ctx->ns);
 	kfree(ctx);
+	of->priv = NULL;
 }
 
 static ssize_t cgroup_file_write(struct kernfs_open_file *of, char *buf,
-- 
2.47.3


