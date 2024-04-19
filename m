Return-Path: <cgroups+bounces-2615-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0D8AAE39
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 14:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268412827FE
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 12:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87385273;
	Fri, 19 Apr 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="eidpqVcu"
X-Original-To: cgroups@vger.kernel.org
Received: from mailhk01.kuaishou.com (mailhk01.kuaishou.com [129.226.226.143])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0689839F1;
	Fri, 19 Apr 2024 12:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.226.226.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713528838; cv=none; b=O4rkD9S15iNl2e+wCYxGeoY4GBJmMZkRYohLjQk5MDZWHFlDIrHI0VxkJyGdbPSeP2VSj37dBHdDEZruRXea4I8LyxHiftR/f8Px/rcq6P7XF8EvzC+nKfSqLaWAq3llSg2TNpcXISyRcClpnYteduiOtFpAcBTJFf9RrhS68aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713528838; c=relaxed/simple;
	bh=kQXlIm+hk7ZcDtTEmOfJwkpRlUhwn8EeE4YRTcIyaZg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dUd0oexIxvJbJvFFzvJIf21gTEpyd2F+9Y+QdNMJprwMwY4aHxYMjTZdiADJ+jsRUINX/bSGJSVNoTn+q39YvjY4SGgKh4EKEShKO5tjoCUgS/hEQMDZYnjIxAZr0w+AtwwL9aZ1ggg31wk6hxyovM/TT8bWYx891UOPenXDgMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=eidpqVcu; arc=none smtp.client-ip=129.226.226.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Received: from bjm7-spam02.kuaishou.com (smtpcn03.kuaishou.com [103.107.217.217])
	by mailhk01.kuaishou.com (Postfix) with ESMTP id B3F2461579;
	Fri, 19 Apr 2024 20:08:06 +0800 (CST)
Received: from bjm7-pm-mail01.kuaishou.com (unknown [172.28.1.1])
	by bjm7-spam02.kuaishou.com (Postfix) with ESMTPS id 42EBF19226D0D;
	Fri, 19 Apr 2024 20:07:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1713528471; h=from:subject:to:date:message-id;
	bh=0ojQK3AKejzo96bSCef2HP/0kdeYSr7fp5rz2r2c22s=;
	b=eidpqVcu7qp9qlJL/Ie4vWLUzzqvlJXH5h0f2IXPG5NEstSyRYUfwR71cOcNlTebaG5fobPr0uQ
	U2GO9iDZe+2HXf2R3CsI2b55oRPbyFxZEhwMVBab8B836foaZ+FwTQ2Din/O+aIUCxQKWdjbWuINE
	13KaaF0k1iPXIqGmO/Y=
Received: from rack-retrieve19671.idchb1az3.hb1.kwaidc.com (172.28.1.32) by
 bjm7-pm-mail01.kuaishou.com (172.28.1.1) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Fri, 19 Apr 2024 20:07:50 +0800
From: zhoutaiyu <zhoutaiyu@kuaishou.com>
To: <tj@kernel.org>
CC: <josef@toxicpanda.com>, <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] blk-throttle: fix repeat limit on bio with BIO_BPS_THROTTLED
Date: Fri, 19 Apr 2024 20:07:47 +0800
Message-ID: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjm7-pm-mail09.kuaishou.com (172.28.1.91) To
 bjm7-pm-mail01.kuaishou.com (172.28.1.1)

Give a concrete example, a bio is throtted because of reaching bps
limit. It is then dispatched to request layer after a delay. In the
request layer, it is split and the split bio flagged with
BIO_BPS_THROTTLED will re-enter blkthrottle.
The bio with BIO_BPS_THROTTLED should not be throttled for its bytes
again. However, when the bps_limit and iops_limit are both set and
sq->queue is not empty, the bio will be throttled again even the tg is
still within iops limit.

Test scrips:
cgpath=/sys/fs/cgroup/blkio/test0
mkdir -p $cgpath
echo "8:0 10485760" > $cgpath/blkio.throttle.write_bps_device
echo "8:16 100000" > $cgpath/blkio.throttle.write_iops_device
for ((i=0;i<50;i++));do
  fio -rw=write -direct=1 -bs=4M -iodepth=8 -size=200M -numjobs=1 \
-time_based=1 -runtime=30  -name=testt_$i -filename=testf_$i > /dev/null &
  echo $! > $cgpath/tasks
done

The output of iostat:
Device:  ...  wMB/s  ...
sdb      ...  3.75  ...
sdb      ...  2.50  ...
sdb      ...  3.75  ...
sdb      ...  2.50  ...
sdb      ...  3.75  ...

In order to fix this problem, early throttled the bio only when
sq->queue is no empty and the bio is not flagged with BIO_BPS_THROTTLED.

Signed-off-by: zhoutaiyu <zhoutaiyu@kuaishou.com>
---
 block/blk-throttle.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f4850a6..499c006 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -913,7 +913,8 @@ static bool tg_may_dispatch(struct throtl_grp *tg, struct bio *bio,
 	 * queued.
 	 */
 	BUG_ON(tg->service_queue.nr_queued[rw] &&
-	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]));
+	       bio != throtl_peek_queued(&tg->service_queue.queued[rw]) &&
+	       !bio_flagged(bio, BIO_BPS_THROTTLED));
 
 	/* If tg->bps = -1, then BW is unlimited */
 	if ((bps_limit == U64_MAX && iops_limit == UINT_MAX) ||
@@ -2201,7 +2202,7 @@ bool __blk_throtl_bio(struct bio *bio)
 		throtl_downgrade_check(tg);
 		throtl_upgrade_check(tg);
 		/* throtl is FIFO - if bios are already queued, should queue */
-		if (sq->nr_queued[rw])
+		if (sq->nr_queued[rw] && !bio_flagged(bio, BIO_BPS_THROTTLED))
 			break;
 
 		/* if above limits, break to queue */
-- 
1.8.3.1


