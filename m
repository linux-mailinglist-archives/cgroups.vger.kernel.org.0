Return-Path: <cgroups+bounces-4727-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9B696F067
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 11:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA6021F27F2D
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2024 09:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1140D1C8FA5;
	Fri,  6 Sep 2024 09:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="UMsxOR18"
X-Original-To: cgroups@vger.kernel.org
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17731C9EA5
	for <cgroups@vger.kernel.org>; Fri,  6 Sep 2024 09:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616429; cv=none; b=c1sfcdpog/KFI36NRKmq1dJmZRyf3X9RqK11IVC6/8tday3w0TJtW9QJwtz8+w77o8CJB3SIwXQ6oohHQB0fg05nkpyj0/mHCIaxVuP96pSh+8D1KPMmovV9b9P0DTxfhFijBRcQNKprhA4HvOPwJ88yO9fv2PBhE6zTaIhJU28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616429; c=relaxed/simple;
	bh=8XHNoIQfIyQtbDLRSGDPf+aLvqEvZjnzaj5Dek7I8Q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YbLTJFaGlbqDKNZC44jcgxqIL4LZ3g4l9j/c9/rAtbbLU9eNKZF8PdviKMSmoN5oYNUryKs0Pbop9aqds9GbqjvTGrMPyrEXmkf3QavfFd1LN/x+QoF0gH3IFJCEOvqStYwCUhaNvmUgzryYmviMQa61y8GoeNBOogVVX6LrTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=UMsxOR18; arc=none smtp.client-ip=185.136.64.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20240906095339872b07aa7f4789a455
        for <cgroups@vger.kernel.org>;
        Fri, 06 Sep 2024 11:53:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ghovqhbYJ+w5KNxfwKu3pn/axYB+6/3jSM34AUo5pxQ=;
 b=UMsxOR18TiuVRFfTwYuCaGJ0NWLsRHYIYHuNNvZYBdXXQhvGSKIMyzV2bZAEFkeT/K3gEI
 h6Yg+ZBNRWmyiN5zzinjxeJ/EccL9MAFnkL5bZUgw5NY4NLB6CFNsCMBfJK7fbptc71PGEsR
 S8iTryuHtde5i9HgG6MU/xjmWXytJs5jQKHy5DBIVf9AbVWUcYb0fDDAftpgkDA4qnDrPXE9
 uzzB1Sj07lz1gjjo/Ucp0s5ABkOAEZlE+6vLJnYlQQz5COZoHgFKfJzFd/Yf6MpvorPXOasF
 yh6jAk/FD4a63ZiCl08ye2xHG0OI7Pu1yQK9IhpFayeXx+6ToTzdEMRA==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: stable@vger.kernel.org
Cc: io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH][6.1][1/2] io_uring/io-wq: stop setting PF_NO_SETAFFINITY on io-wq workers
Date: Fri,  6 Sep 2024 11:53:20 +0200
Message-Id: <20240906095321.388613-2-felix.moessbauer@siemens.com>
In-Reply-To: <20240906095321.388613-1-felix.moessbauer@siemens.com>
References: <20240906095321.388613-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

From: Jens Axboe <axboe@kernel.dk>

commit 01e68ce08a30db3d842ce7a55f7f6e0474a55f9a upstream.

Every now and then reports come in that are puzzled on why changing
affinity on the io-wq workers fails with EINVAL. This happens because they
set PF_NO_SETAFFINITY as part of their creation, as io-wq organizes
workers into groups based on what CPU they are running on.

However, this is purely an optimization and not a functional requirement.
We can allow setting affinity, and just lazily update our worker to wqe
mappings. If a given io-wq thread times out, it normally exits if there's
no more work to do. The exception is if it's the last worker available.
For the timeout case, check the affinity of the worker against group mask
and exit even if it's the last worker. New workers should be created with
the right mask and in the right location.

Reported-by:Daniel Dao <dqminh@cloudflare.com>
Link: https://lore.kernel.org/io-uring/CA+wXwBQwgxB3_UphSny-yAP5b26meeOu1W4TwYVcD_+5gOhvPw@mail.gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 io_uring/io-wq.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 04503118cdc1..139cd49b2c27 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -628,7 +628,7 @@ static int io_wqe_worker(void *data)
 	struct io_wqe_acct *acct = io_wqe_get_acct(worker);
 	struct io_wqe *wqe = worker->wqe;
 	struct io_wq *wq = wqe->wq;
-	bool last_timeout = false;
+	bool exit_mask = false, last_timeout = false;
 	char buf[TASK_COMM_LEN];
 
 	worker->flags |= (IO_WORKER_F_UP | IO_WORKER_F_RUNNING);
@@ -644,8 +644,11 @@ static int io_wqe_worker(void *data)
 			io_worker_handle_work(worker);
 
 		raw_spin_lock(&wqe->lock);
-		/* timed out, exit unless we're the last worker */
-		if (last_timeout && acct->nr_workers > 1) {
+		/*
+		 * Last sleep timed out. Exit if we're not the last worker,
+		 * or if someone modified our affinity.
+		 */
+		if (last_timeout && (exit_mask || acct->nr_workers > 1)) {
 			acct->nr_workers--;
 			raw_spin_unlock(&wqe->lock);
 			__set_current_state(TASK_RUNNING);
@@ -664,7 +667,11 @@ static int io_wqe_worker(void *data)
 				continue;
 			break;
 		}
-		last_timeout = !ret;
+		if (!ret) {
+			last_timeout = true;
+			exit_mask = !cpumask_test_cpu(raw_smp_processor_id(),
+							wqe->cpu_mask);
+		}
 	}
 
 	if (test_bit(IO_WQ_BIT_EXIT, &wq->state))
@@ -716,7 +723,6 @@ static void io_init_new_worker(struct io_wqe *wqe, struct io_worker *worker,
 	tsk->worker_private = worker;
 	worker->task = tsk;
 	set_cpus_allowed_ptr(tsk, wqe->cpu_mask);
-	tsk->flags |= PF_NO_SETAFFINITY;
 
 	raw_spin_lock(&wqe->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list);
-- 
2.39.2


