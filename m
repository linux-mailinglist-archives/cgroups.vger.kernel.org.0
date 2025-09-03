Return-Path: <cgroups+bounces-9665-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808A6B4254B
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 17:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BD43A79A7
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 15:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB8B258CE8;
	Wed,  3 Sep 2025 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="VywDhwYv"
X-Original-To: cgroups@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7120242D86;
	Wed,  3 Sep 2025 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913025; cv=none; b=anQb7PI31LuVZRmFAIy20pZdlRfdSRJq6G8b5EH6F6uHBog4aW1mh5IYsMjxXfxlvnpdMuziPN3DWJzxzpMnd/t8ujoASsY+wkwSf3xSuBuIXFqQTGKB4aa8TGY27tvXIgefXOtBF6iDOJdNImsEOJ3cEBN8WhTr8gYVmS7lvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913025; c=relaxed/simple;
	bh=/spK7tew3bFhTQ430+THIXDXu/85MFV7m0+9HDffKfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+0lNxNKutKgWutt8Y99seCmI8C2Hisp51Qrw/mlvfcaeaL3cMaK95NruXPKnAZ9P5nOVrqp3/YgjGiQ5J/F+WJkCkKlMA/V2eI3ac3AqUbWP60aJ9oRE1uZLcMEgh8/ZhxIoLQ9ACwFTKyS6svCEuo2TzZ2XFL4j0ofMPbl/c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=VywDhwYv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xxY7Xa4tcL3TGCaORSRMfy4WldOqWubmo3rUqucqPuQ=; b=VywDhwYvzpVJn8uIf8JOOBzkzA
	VjrDVKWYlQO649rQNadbYEpDxH72cyR0kuRHBgpP+J71y/4vNeDUlBMsdoI+sWATRWgDL+DhaIi45
	dO1AvQEDjXzZOMQN+Zi7rsY4uz0eJbGPZaTu7k4kWg1njz0F/IhGn8ZEY4pDt728WKqjZB55/Hd1w
	6QitXu5PEEmVNHWAX6tzt7WvRlvwkmUhV1EFufBDcK0S58xV620B+rn9jk+y/DUnaSYMPSYvhZToc
	ZO/pvTQEIEU7FgyidoElDndNyMtFEfzVEJV5zLiJiOS2/tPUDLxA6A9RFFCgXGk2QESrYftsVue3v
	SzXJOBnw==;
Received: from [84.66.36.92] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utpKk-006GZY-Ef; Wed, 03 Sep 2025 17:23:38 +0200
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
	Philipp Stanner <phasta@kernel.org>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [RFC 10/21] drm/sched: Break submission patterns with some randomness
Date: Wed,  3 Sep 2025 16:23:16 +0100
Message-ID: <20250903152327.66002-11-tvrtko.ursulin@igalia.com>
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

GPUs generally don't implement preemption and DRM scheduler definitely
does not support it at the front end scheduling level. This means
execution quanta can be quite long and is controlled by userspace,
consequence of which is picking the "wrong" entity to run can have a
larger negative effect than it would have with a virtual runtime based CPU
scheduler.

Another important consideration is that rendering clients often have
shallow submission queues, meaning they will be entering and exiting the
scheduler's runnable queue often.

Relevant scenario here is what happens when an entity re-joins the
runnable queue with other entities already present. One cornerstone of the
virtual runtime algorithm is to let it re-join at the head and depend on
the virtual runtime accounting to sort out the order after an execution
quanta or two.

However, as explained above, this may not work fully reliably in the GPU
world. Entity could always get to overtake the existing entities, or not,
depending on the submission order and rbtree equal key insertion
behaviour.

We can break this latching by adding some randomness for this specific
corner case.

If an entity is re-joining the runnable queue, was head of the queue the
last time it got picked, and there is an already queued different entity
of an equal scheduling priority, we can break the tie by randomly choosing
the execution order between the two.

For randomness we implement a simple driver global boolean which selects
whether new entity will be first or not. Because the boolean is global and
shared between all the run queues and entities, its actual effect can be
loosely called random. Under the assumption it will not always be the same
entity which is re-joining the queue under these circumstances.

Another way to look at this is that it is adding a little bit of limited
random round-robin behaviour to the fair scheduling algorithm.

Net effect is a significant improvemnt to the scheduling unit tests which
check the scheduling quality for the interactive client running in
parallel with GPU hogs.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/scheduler/sched_rq.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_rq.c b/drivers/gpu/drm/scheduler/sched_rq.c
index b0cf7d2143c8..c5be8a2c893d 100644
--- a/drivers/gpu/drm/scheduler/sched_rq.c
+++ b/drivers/gpu/drm/scheduler/sched_rq.c
@@ -150,6 +150,16 @@ drm_sched_entity_restore_vruntime(struct drm_sched_entity *entity,
 			 * Higher priority can go first.
 			 */
 			vruntime = -us_to_ktime(rq_prio - prio);
+		} else {
+			static const int shuffle[2] = { -1, 1 };
+			static bool r = 0;
+
+			/*
+			 * For equal priority apply some randomness to break
+			 * latching caused by submission patterns.
+			 */
+			vruntime = shuffle[r];
+			r ^= 1;
 		}
 	}
 
-- 
2.48.0


