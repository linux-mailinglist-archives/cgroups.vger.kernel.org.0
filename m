Return-Path: <cgroups+bounces-9660-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 195F3B4253F
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 464ED681D53
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C690B242D83;
	Wed,  3 Sep 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pl6bhxor"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C18238C0D;
	Wed,  3 Sep 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913022; cv=none; b=tAsqLsV3bEto6nXwAKWYzXWyL3nRigBTMydC9iNYn/PGzAo47Z5rALXW9kwJTHAQDHXbAkhj2DkTNkEILYEM3DX3WbRhXjs6adMohl94uWkrzBFeU7BuX+d4rglfWvP9uewSFJUZkVTqomR8bzElQlUQ2iieGHHWRJnip7DQgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913022; c=relaxed/simple;
	bh=Yaa7GNtC1+SM4z7e0jVuuQzPCLSSYuwL6PlueYgTHbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GF1vHGYtXjvgKkCO+BAncHLyMaLW7ul+Z+rpbOfAN+W7i5PKkkQ55U07QKCaJWvaV8NCsp3rGJ2Qr7jWXKY9Hf1BMw1cIXBbR+Ej9zrKHkvL8PmGH8GYg+/YAMRxfRsrkKGcQPu+ujnVERVwHxdz3NIMdJ6vwPUeqFzyVKGFfDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pl6bhxor; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/Xk/URIaSjNqs+E7Ui6VDY/cPKbItzp2zXKB3OCGsS8=; b=pl6bhxorboFt8wq3sueSto3/0v
	ro6GgmOH7pZ1xwhTeXWrmBLt0PQgtZV/LGoIZRmYkoF/rni3E6H56Bf2T8JFTjRZQQpcs+ql0awHG
	zyECFvpBiYb83ns7Hxj8WzOIBNChCmxGI9mI5fa4htZBf3pm07lu9tSl3zqaJ63qTXNU96+C+211X
	Jh7D37heY+rwRznHj34vHpd7UyhN9n1O2lOQnPfd0QKueFybQRBjx8VcakEmiFN+bAypd7Gap4ybb
	0OMMbfK1KoOjGuIde82VyI0AYOHsS7TiAHQIeH6agfvapkOJlAXK8mGIayClHlhbywiwfPa1SzK8g
	TZb0vB2A==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKg-006GYc-2K; Wed, 03 Sep 2025 17:23:34 +0200
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
Subject: [RFC 04/21] drm/sched: Consolidate entity run queue management
Date: Wed,  3 Sep 2025 16:23:10 +0100
Message-ID: <20250903152327.66002-5-tvrtko.ursulin@igalia.com>
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

Move the code dealing with entities entering and exiting run queues to
helpers to logically separate it from jobs entering and exiting entities.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_entity.c   | 64 ++-------------
 drivers/gpu/drm/scheduler/sched_internal.h |  8 +-
 drivers/gpu/drm/scheduler/sched_main.c     | 95 +++++++++++++++++++---
 3 files changed, 91 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_entity.c b/drivers/gpu/drm/scheduler/sched_entity.c
index 4852006f2308..7a0a52ba87bf 100644
--- a/drivers/gpu/drm/scheduler/sched_entity.c
+++ b/drivers/gpu/drm/scheduler/sched_entity.c
@@ -456,24 +456,9 @@ drm_sched_job_dependency(struct drm_sched_job *job,
 	return NULL;
 }
 
-static ktime_t
-drm_sched_rq_get_rr_ts(struct drm_sched_rq *rq, struct drm_sched_entity *entity)
-{
-	ktime_t ts;
-
-	lockdep_assert_held(&entity->lock);
-	lockdep_assert_held(&rq->lock);
-
-	ts = ktime_add_ns(rq->rr_ts, 1);
-	entity->rr_ts = ts;
-	rq->rr_ts = ts;
-
-	return ts;
-}
-
 struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 {
-	struct drm_sched_job *sched_job, *next_job;
+	struct drm_sched_job *sched_job;
 
 	sched_job = drm_sched_entity_queue_peek(entity);
 	if (!sched_job)
@@ -502,26 +487,7 @@ struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity)
 
 	spsc_queue_pop(&entity->job_queue);
 
-	/*
-	 * Update the entity's location in the min heap according to
-	 * the timestamp of the next job, if any.
-	 */
-	next_job = drm_sched_entity_queue_peek(entity);
-	if (next_job) {
-		struct drm_sched_rq *rq;
-		ktime_t ts;
-
-		spin_lock(&entity->lock);
-		rq = entity->rq;
-		spin_lock(&rq->lock);
-		if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
-			ts = next_job->submit_ts;
-		else
-			ts = drm_sched_rq_get_rr_ts(rq, entity);
-		drm_sched_rq_update_fifo_locked(entity, rq, ts);
-		spin_unlock(&rq->lock);
-		spin_unlock(&entity->lock);
-	}
+	drm_sched_rq_pop_entity(entity);
 
 	/* Jobs and entities might have different lifecycles. Since we're
 	 * removing the job from the entities queue, set the jobs entity pointer
@@ -611,30 +577,10 @@ void drm_sched_entity_push_job(struct drm_sched_job *sched_job)
 	/* first job wakes up scheduler */
 	if (first) {
 		struct drm_gpu_scheduler *sched;
-		struct drm_sched_rq *rq;
 
-		/* Add the entity to the run queue */
-		spin_lock(&entity->lock);
-		if (entity->stopped) {
-			spin_unlock(&entity->lock);
-
-			DRM_ERROR("Trying to push to a killed entity\n");
-			return;
-		}
-
-		rq = entity->rq;
-		sched = rq->sched;
-
-		spin_lock(&rq->lock);
-		drm_sched_rq_add_entity(rq, entity);
-		if (drm_sched_policy == DRM_SCHED_POLICY_RR)
-			submit_ts = entity->rr_ts;
-		drm_sched_rq_update_fifo_locked(entity, rq, submit_ts);
-
-		spin_unlock(&rq->lock);
-		spin_unlock(&entity->lock);
-
-		drm_sched_wakeup(sched);
+		sched = drm_sched_rq_add_entity(entity, submit_ts);
+		if (sched)
+			drm_sched_wakeup(sched);
 	}
 }
 EXPORT_SYMBOL(drm_sched_entity_push_job);
diff --git a/drivers/gpu/drm/scheduler/sched_internal.h b/drivers/gpu/drm/scheduler/sched_internal.h
index 7ea5a6736f98..8269c5392a82 100644
--- a/drivers/gpu/drm/scheduler/sched_internal.h
+++ b/drivers/gpu/drm/scheduler/sched_internal.h
@@ -12,13 +12,11 @@ extern int drm_sched_policy;
 
 void drm_sched_wakeup(struct drm_gpu_scheduler *sched);
 
-void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
-			     struct drm_sched_entity *entity);
+struct drm_gpu_scheduler *
+drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts);
 void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 				struct drm_sched_entity *entity);
-
-void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity,
-				     struct drm_sched_rq *rq, ktime_t ts);
+void drm_sched_rq_pop_entity(struct drm_sched_entity *entity);
 
 void drm_sched_entity_select_rq(struct drm_sched_entity *entity);
 struct drm_sched_job *drm_sched_entity_pop_job(struct drm_sched_entity *entity);
diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index 1db0a4aa1d46..c53931e63458 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -151,9 +151,9 @@ static void drm_sched_rq_remove_fifo_locked(struct drm_sched_entity *entity,
 	}
 }
 
-void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity,
-				     struct drm_sched_rq *rq,
-				     ktime_t ts)
+static void drm_sched_rq_update_fifo_locked(struct drm_sched_entity *entity,
+					    struct drm_sched_rq *rq,
+					    ktime_t ts)
 {
 	/*
 	 * Both locks need to be grabbed, one to protect from entity->rq change
@@ -191,22 +191,45 @@ static void drm_sched_rq_init(struct drm_gpu_scheduler *sched,
 /**
  * drm_sched_rq_add_entity - add an entity
  *
- * @rq: scheduler run queue
  * @entity: scheduler entity
+ * @ts: submission timestamp
  *
  * Adds a scheduler entity to the run queue.
+ *
+ * Returns a DRM scheduler pre-selected to handle this entity.
  */
-void drm_sched_rq_add_entity(struct drm_sched_rq *rq,
-			     struct drm_sched_entity *entity)
+struct drm_gpu_scheduler *
+drm_sched_rq_add_entity(struct drm_sched_entity *entity, ktime_t ts)
 {
-	lockdep_assert_held(&entity->lock);
-	lockdep_assert_held(&rq->lock);
+	struct drm_gpu_scheduler *sched;
+	struct drm_sched_rq *rq;
 
-	if (!list_empty(&entity->list))
-		return;
+	/* Add the entity to the run queue */
+	spin_lock(&entity->lock);
+	if (entity->stopped) {
+		spin_unlock(&entity->lock);
 
-	atomic_inc(rq->sched->score);
-	list_add_tail(&entity->list, &rq->entities);
+		DRM_ERROR("Trying to push to a killed entity\n");
+		return NULL;
+	}
+
+	rq = entity->rq;
+	spin_lock(&rq->lock);
+	sched = rq->sched;
+
+	if (list_empty(&entity->list)) {
+		atomic_inc(sched->score);
+		list_add_tail(&entity->list, &rq->entities);
+	}
+
+	if (drm_sched_policy == DRM_SCHED_POLICY_RR)
+		ts = entity->rr_ts;
+	drm_sched_rq_update_fifo_locked(entity, rq, ts);
+
+	spin_unlock(&rq->lock);
+	spin_unlock(&entity->lock);
+
+	return sched;
 }
 
 /**
@@ -235,6 +258,54 @@ void drm_sched_rq_remove_entity(struct drm_sched_rq *rq,
 	spin_unlock(&rq->lock);
 }
 
+static ktime_t
+drm_sched_rq_get_rr_ts(struct drm_sched_rq *rq, struct drm_sched_entity *entity)
+{
+	ktime_t ts;
+
+	lockdep_assert_held(&entity->lock);
+	lockdep_assert_held(&rq->lock);
+
+	ts = ktime_add_ns(rq->rr_ts, 1);
+	entity->rr_ts = ts;
+	rq->rr_ts = ts;
+
+	return ts;
+}
+
+/**
+ * drm_sched_rq_pop_entity - pops an entity
+ *
+ * @entity: scheduler entity
+ *
+ * To be called every time after a job is popped from the entity.
+ */
+void drm_sched_rq_pop_entity(struct drm_sched_entity *entity)
+{
+	struct drm_sched_job *next_job;
+	struct drm_sched_rq *rq;
+	ktime_t ts;
+
+	/*
+	 * Update the entity's location in the min heap according to
+	 * the timestamp of the next job, if any.
+	 */
+	next_job = drm_sched_entity_queue_peek(entity);
+	if (!next_job)
+		return;
+
+	spin_lock(&entity->lock);
+	rq = entity->rq;
+	spin_lock(&rq->lock);
+	if (drm_sched_policy == DRM_SCHED_POLICY_FIFO)
+		ts = next_job->submit_ts;
+	else
+		ts = drm_sched_rq_get_rr_ts(rq, entity);
+	drm_sched_rq_update_fifo_locked(entity, rq, ts);
+	spin_unlock(&rq->lock);
+	spin_unlock(&entity->lock);
+}
+
 /**
  * drm_sched_rq_select_entity - Select an entity which provides a job to run
  *
-- 
2.48.0


