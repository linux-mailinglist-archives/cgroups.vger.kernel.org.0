Return-Path: <cgroups+bounces-3040-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5FB8D4D07
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 15:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF37C286AC1
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2024 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227B1C0DE6;
	Thu, 30 May 2024 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRgfbnAc"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF81B183079
	for <cgroups@vger.kernel.org>; Thu, 30 May 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076775; cv=none; b=a7tF7UiTEVH4B2vvq2Ax6FlwWzWPRKS+lX0iWl67e4VJP6PNvA2v6qONuJiCrArl1Iu9FvzyOpgsnj4YAvYqQzvLmZCv/lfbdagoOdn+dOIkVJXyNmt1pIicyLZ3TUucvF+9gb51D3ichF1hBbKweSGqeloURS5EHeRBRpqKVeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076775; c=relaxed/simple;
	bh=juDbdX0Y8GqixK8pMaIwY4mK1Kc2Uns7SMNNeKabaC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U5Z/XZNSgLhnh+ZxPVEoQLJUtNxbOoq7MdDBVtt/zAgsANFJsR3x4rhe4hCQQPgH3Z5Mvqfep3Ph36jrghGNjn3MxEnUDGczqL73ta/tD8dGGYW5AGHASrY6gd0IotCFd02GeaFq/Nxm22MgJGA/hx5axFGsqvjwn6TQ4n8eAVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRgfbnAc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717076772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EfyjO2O9S+39QYbsHE3kG4m3i1fzVGSXeu8l7KeSxG4=;
	b=RRgfbnAcH4NzK3dPnoX3eV45/EyaL5maSS20BFaLo+brbeJVRLqLPapw5vs186H3Npb8Su
	Nq+s6RnJc0Bdz319I+o8Ahbne9uYy+gwUzjIMfDj27xw5Lb55CLuiwYHPsbrB+jDVs56Br
	Y7QiBPHigisfa5V3VVXgClLKXRg5aNU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-OC8SETo-PHm4FRv1JHhA0A-1; Thu,
 30 May 2024 09:46:09 -0400
X-MC-Unique: OC8SETo-PHm4FRv1JHhA0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF82A29AA387;
	Thu, 30 May 2024 13:46:08 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9F5CA40C6EB7;
	Thu, 30 May 2024 13:46:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Cc: cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Justin Forbes <jforbes@redhat.com>
Subject: [PATCH] blk-throttle: Fix incorrect display of io.max
Date: Thu, 30 May 2024 09:45:47 -0400
Message-Id: <20240530134547.970075-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Commit bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
attempts to revert the code change introduced by commit cd5ab1b0fcb4
("blk-throttle: add .low interface").  However, it leaves behind the
bps_conf[] and iops_conf[] fields in the throtl_grp structure which
aren't set anywhere in the new blk-throttle.c code but are still being
used by tg_prfill_limit() to display the limits in io.max. Now io.max
always displays the following values if a block queue is used:

	<m>:<n> rbps=0 wbps=0 riops=0 wiops=0

Fix this problem by removing bps_conf[] and iops_conf[] and use bps[]
and iops[] instead to complete the revert.

Fixes: bf20ab538c81 ("blk-throttle: remove CONFIG_BLK_DEV_THROTTLING_LOW")
Reported-by: Justin Forbes <jforbes@redhat.com>
Closes: https://github.com/containers/podman/issues/22701#issuecomment-2120627789
Signed-off-by: Waiman Long <longman@redhat.com>
---
 block/blk-throttle.c | 24 ++++++++++++------------
 block/blk-throttle.h |  8 ++------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index d907040859f9..da619654f418 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1347,32 +1347,32 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	bps_dft = U64_MAX;
 	iops_dft = UINT_MAX;
 
-	if (tg->bps_conf[READ] == bps_dft &&
-	    tg->bps_conf[WRITE] == bps_dft &&
-	    tg->iops_conf[READ] == iops_dft &&
-	    tg->iops_conf[WRITE] == iops_dft)
+	if (tg->bps[READ] == bps_dft &&
+	    tg->bps[WRITE] == bps_dft &&
+	    tg->iops[READ] == iops_dft &&
+	    tg->iops[WRITE] == iops_dft)
 		return 0;
 
 	seq_printf(sf, "%s", dname);
-	if (tg->bps_conf[READ] == U64_MAX)
+	if (tg->bps[READ] == U64_MAX)
 		seq_printf(sf, " rbps=max");
 	else
-		seq_printf(sf, " rbps=%llu", tg->bps_conf[READ]);
+		seq_printf(sf, " rbps=%llu", tg->bps[READ]);
 
-	if (tg->bps_conf[WRITE] == U64_MAX)
+	if (tg->bps[WRITE] == U64_MAX)
 		seq_printf(sf, " wbps=max");
 	else
-		seq_printf(sf, " wbps=%llu", tg->bps_conf[WRITE]);
+		seq_printf(sf, " wbps=%llu", tg->bps[WRITE]);
 
-	if (tg->iops_conf[READ] == UINT_MAX)
+	if (tg->iops[READ] == UINT_MAX)
 		seq_printf(sf, " riops=max");
 	else
-		seq_printf(sf, " riops=%u", tg->iops_conf[READ]);
+		seq_printf(sf, " riops=%u", tg->iops[READ]);
 
-	if (tg->iops_conf[WRITE] == UINT_MAX)
+	if (tg->iops[WRITE] == UINT_MAX)
 		seq_printf(sf, " wiops=max");
 	else
-		seq_printf(sf, " wiops=%u", tg->iops_conf[WRITE]);
+		seq_printf(sf, " wiops=%u", tg->iops[WRITE]);
 
 	seq_printf(sf, "\n");
 	return 0;
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 32503fd83a84..8c365541a275 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -95,15 +95,11 @@ struct throtl_grp {
 	bool has_rules_bps[2];
 	bool has_rules_iops[2];
 
-	/* internally used bytes per second rate limits */
+	/* bytes per second rate limits */
 	uint64_t bps[2];
-	/* user configured bps limits */
-	uint64_t bps_conf[2];
 
-	/* internally used IOPS limits */
+	/* IOPS limits */
 	unsigned int iops[2];
-	/* user configured IOPS limits */
-	unsigned int iops_conf[2];
 
 	/* Number of bytes dispatched in current slice */
 	uint64_t bytes_disp[2];
-- 
2.43.0


