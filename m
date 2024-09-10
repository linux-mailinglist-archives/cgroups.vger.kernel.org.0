Return-Path: <cgroups+bounces-4806-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4A09739E9
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 16:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F6928A7D0
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6A7194C89;
	Tue, 10 Sep 2024 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="aLjdWnrr"
X-Original-To: cgroups@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DB192D99
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978816; cv=none; b=TCmjeE/Rc3k2LvFgPKi8jvT4GWDAQZ7JdB9d4KwsfEAGHAvysp0YlmNJAgSbuTMttwZqbQu+zSyetiA98v+SCwHminxeGf0+TKnDjni4HFT61iT+GM9wfFNayQJ1XeLkCPilYk4WNSfTJDCVfOkrD8H0ujzJZFjdG2sRYghO8oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978816; c=relaxed/simple;
	bh=HdjpHHoNjYhBNqAxemQTKbJ7B8cX2tOtQLZrtAyVLgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCp0FKQ2tvNjPKgL0vbEl6Sx5gAvB67vsICOCB4PSBFfqLD+VdjZqrWEQ9fh7ZJpBhJQ7b/KUDuDvfPmj0IXJlHd0GM9gADgFRWJcZ1Hvw95wGw/rPuRDRL5fgtwe7eIH6jnf6968/MKnPMLAxkU8ZGN/HGy4xYOgpFuQp550DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=aLjdWnrr; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 2024091014333141aa9393dd61551b45
        for <cgroups@vger.kernel.org>;
        Tue, 10 Sep 2024 16:33:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=n2V+rpn0MsoDnSoEFfdxd31DQiUD8YinS8WdnXxpaHA=;
 b=aLjdWnrraN9sTjU0K0JxfJEbsKlJHU3RGuyyvDTifxtBVtGcPAgQPicpqN0YzHzHMNJ0iN
 lvbbSUTFekouVMhaU5rxBl/04r1pz6SkK1jN6O3szNKQeuijZR75rb6vcDuOSQjThb3IJRt9
 QdtrpimuBVImvEO2PW7IrNTV5dN8+n3IXfPzo7dCMuV2vGEga0ynWkQ0Wpve2woBBszaaYkd
 jJ4XOv/EQeJ6EmVMSgM8rw+QiE9DGVFOySl1bngfYbJ6tSuWVEVnZ4eeTwpuXKrmqvp2edmJ
 RuVIfHb6siZsDUpz1cVYDsl32kcXIm8IcYPv8FshZtB+OMtsW4OBvLxA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH 2/2] io_uring/io-wq: limit io poller cpuset to ambient one
Date: Tue, 10 Sep 2024 16:33:20 +0200
Message-Id: <20240910143320.123234-3-felix.moessbauer@siemens.com>
In-Reply-To: <20240910143320.123234-1-felix.moessbauer@siemens.com>
References: <20240910143320.123234-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

The io work queue polling threads are userland threads that just never
exit to the userland. By that, they are also assigned to a cgroup (the
group of the creating task).

When creating a new io poller, this poller should inherit the cpu limits
of the cgroup, as it belongs to the cgroup of the creating task.

Fixes: da64d6db3bd3 ("io_uring: One wqe per wq")
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 io_uring/io-wq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index c7055a8895d7..a38f36b68060 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -1168,7 +1168,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 	if (!alloc_cpumask_var(&wq->cpu_mask, GFP_KERNEL))
 		goto err;
-	cpumask_copy(wq->cpu_mask, cpu_possible_mask);
+	cpuset_cpus_allowed(data->task, wq->cpu_mask);
 	wq->acct[IO_WQ_ACCT_BOUND].max_workers = bounded;
 	wq->acct[IO_WQ_ACCT_UNBOUND].max_workers =
 				task_rlimit(current, RLIMIT_NPROC);
-- 
2.39.2


