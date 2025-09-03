Return-Path: <cgroups+bounces-9661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41332B42540
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9F5201C06
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED724501B;
	Wed,  3 Sep 2025 15:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jBApt3Vl"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8223A564;
	Wed,  3 Sep 2025 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913022; cv=none; b=d7hyWOQPfUb7kFim+G+Do9/H6ROtl3QgrqRo8SLsEkUL2syeZYs701jjU/UNeSyvIJzLZanLgPM4eGmDSqb1jwvfTx1vKLTTnuRMBtj8NSHa26nFnfoGE6iG9LBpT2yxobGmoFsTMkcB8FgHfaksU9A1/34mJS/MnoshwIHieBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913022; c=relaxed/simple;
	bh=60LvLdGEGWcSukyopR1p5m59Ey3i2+yiSsK0hOemL7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+tQ05S3JrF0RUDl68QQCMSZTVQcyHzfIAknA4bMwrxO7liG6xqwHuMoSTGxKm6Khey+JSMDS5huMvC/YWQXbvcMNahPGVDSkZ2qR/MWizFu3lqgfUNguBigpV/XtpPj/SlX988xNfoXvE9HmWzvES6GrGvjBqCugLhVvqQxAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jBApt3Vl; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Re+EJd2Qy1/tCb6GaNPYXJHYHeoiQPrQ4AhNwc1boKQ=; b=jBApt3VlpBuqyn0JbfmKDjcM29
	d9l4lJdX5wyX1GhWXNwBcCrxr5Q0Hf30DKSvqHOCcsbT4IEAxIR6mRzbt3TDkxhkXTmKeEzIBIEjK
	U2pkIne+cB5eT7+oM1naBJh8Kbfi9xbT7bImDCj1jUrzB4ccOYklh0BsH38nPhD4/JFWPP5ivC9Qn
	gLBmFDosiqP/7uOnoPvkdTmpsD9yL9l7OhUgf3jz4D35RhIyunnuQs3BJ7jKZBfz66FUk2fH3N0Wn
	KqW+lSptXhCw6v6vWu13CwSBwmFJvFtxaq6axF/X9zlSuYLLnlidq7ZmYZj8O5+3Reh3RFh2p/mVq
	KGGTu5KA==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKh-006GYm-Gu; Wed, 03 Sep 2025 17:23:35 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
	kernel-dev@igalia.com,
	intel-xe@lists.freedesktop.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Matthew Brost <matthew.brost@intel.com>,
	Philipp Stanner <phasta@kernel.org>
Subject: [RFC 06/21] drm/sched: Free all finished jobs at once
Date: Wed,  3 Sep 2025 16:23:12 +0100
Message-ID: <20250903152327.66002-7-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
References: <20250903152327.66002-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

To implement fair scheduling we will need as accurate as possible view
into per entity GPU time utilisation. Because sched fence execution time
are only adjusted for accuracy in the free worker we need to process
completed jobs as soon as possible so the metric is most up to date when
view from the submission side of things.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 97bec2f86502..9411676e772a 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -906,7 +906,6 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
  * drm_sched_get_finished_job - fetch the next finished job to be destroyed
  *
  * @sched: scheduler instance
- * @have_more: are there more finished jobs on the list
  *
  * Informs the caller through @have_more whether there are more finished jobs
  * besides the returned one.
@@ -915,7 +914,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
  * ready for it to be destroyed.
  */
 static struct drm_sched_job *
-drm_sched_get_finished_job(struct drm_gpu_scheduler *sched, bool *have_more)
+drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
 {
 	struct drm_sched_job *job, *next;
 
@@ -930,7 +929,6 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched, bool *have_more)
 		/* cancel this job's TO timer */
 		cancel_delayed_work(&sched->work_tdr);
 
-		*have_more = false;
 		next = list_first_entry_or_null(&sched->pending_list,
 						typeof(*next), list);
 		if (next) {
@@ -940,8 +938,6 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched, bool *have_more)
 				next->s_fence->scheduled.timestamp =
 					dma_fence_timestamp(&job->s_fence->finished);
 
-			*have_more = dma_fence_is_signaled(&next->s_fence->finished);
-
 			/* start TO timer for next job */
 			drm_sched_start_timeout(sched);
 		}
@@ -1000,14 +996,9 @@ static void drm_sched_free_job_work(struct work_struct *w)
 	struct drm_gpu_scheduler *sched =
 		container_of(w, struct drm_gpu_scheduler, work_free_job);
 	struct drm_sched_job *job;
-	bool have_more;
 
-	job = drm_sched_get_finished_job(sched, &have_more);
-	if (job) {
+	while ((job = drm_sched_get_finished_job(sched)))
 		sched->ops->free_job(job);
-		if (have_more)
-			drm_sched_run_free_queue(sched);
-	}
 
 	drm_sched_run_job_queue(sched);
 }
-- 
2.48.0


