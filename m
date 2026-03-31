Return-Path: <cgroups+bounces-15125-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sASEHLqMy2kuIwYAu9opvQ
	(envelope-from <cgroups+bounces-15125-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 10:58:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D52E366924
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 10:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 687CC30C1C16
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F03EB810;
	Tue, 31 Mar 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o/DYA0xn"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7C73EBF3F
	for <cgroups@vger.kernel.org>; Tue, 31 Mar 2026 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947062; cv=none; b=akqksXj1tNTA3D0XIAxx1+INSHjcX4fIdnSFN/l2A76dFlMeoAD1ILa9MBpq6v7aQSKSf4a9+bqVNJWhIhCLnquxU32Kp7mPAbwgeYZ4xrljruM7S+YPC+2BggE7VfdmsX3sgnzEEnyl53oCuY7WjiZI+ovuDL6pMY3pOW2U8uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947062; c=relaxed/simple;
	bh=O9alaEbUrmSP1l1r2uxblXiWWZrVr4jLSCPHzLx3cKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eb1iZgMhJrzwbGklR7opS6j9w1oh/MYyuRuavNnUs21Sa84Lhn2/EBke1+AtlFG1ZH0TjrEPoeH2vVaEA7kQSU3KTnI5H+OzZnsr40JagzR6iFTKhdMR3LMLFIAJbOjg9RmVnNLA1leR9Pf5AQowTByLz9bjfLFsuQ3+xcgLQHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o/DYA0xn; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774947058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rBfxzG2jzPOmQSrb7bP9sSmrE4XYtLM5eOde2/d1gZs=;
	b=o/DYA0xnP38Fsx4B9HGfnhYFc1q1RxfHxJeeGfXFRuSYcy1/1U0tRPRcMLL0V5uxscXD+i
	W8SHqOrVSKbPuQfF2aC93lHHyZbMmZ26srW+98DPFV/CGs098UUw/SoQ8rt8vkwws4KCPq
	3WAYYJeIRZQVzVlnr0MTLsIaMtG7vAo=
From: Jackie Liu <liu.yun@linux.dev>
To: tj@kernel.org,
	hch@lst.de,
	axboe@kernel.dk
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] blk-cgroup: fix disk reference leak in blkcg_maybe_throttle_current()
Date: Tue, 31 Mar 2026 16:50:54 +0800
Message-ID: <20260331085054.46857-1-liu.yun@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15125-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liu.yun@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D52E366924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jackie Liu <liuyun01@kylinos.cn>

Add the missing put_disk() on the error path in
blkcg_maybe_throttle_current(). When blkcg lookup, blkg lookup, or
blkg_tryget() fails, the function jumps to the out label which only
calls rcu_read_unlock() but does not release the disk reference acquired
by blkcg_schedule_throttle() via get_device(). Since current->throttle_disk
is already set to NULL before the lookup, blkcg_exit() cannot release
this reference either, causing the disk to never be freed.

Restore the reference release that was present as blk_put_queue() in the
original code but was inadvertently dropped during the conversion from
request_queue to gendisk.

Fixes: f05837ed73d0 ("blk-cgroup: store a gendisk to throttle in struct task_struct")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b70096497d38..c377241ee13c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2022,6 +2022,7 @@ void blkcg_maybe_throttle_current(void)
 	return;
 out:
 	rcu_read_unlock();
+	put_disk(disk);
 }
 
 /**
-- 
2.51.1


