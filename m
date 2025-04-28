Return-Path: <cgroups+bounces-7860-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43DA9E6B7
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 05:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD5F1707F5
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 03:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7612A1FECB4;
	Mon, 28 Apr 2025 03:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c/+BhYCM"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDF31FAC4E
	for <cgroups@vger.kernel.org>; Mon, 28 Apr 2025 03:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811429; cv=none; b=fWfgjhx0d++zIJadK9n3B6Eh1SbCMBN3HcuPaQAfrhNdRYcBrWd031zPobZOas5ja/GPl2iT3yYifRZudkLl3iubLHPl3aJ5wOLpmAAxokSoXRqN1lSKZsiceKGTnPT/1hYcxDYIalPA+1KHycWfLpOLdPyNP4LIhIgOza4NHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811429; c=relaxed/simple;
	bh=yMb5GqcrV1LWSU+1rW5hRyuHFkaaCjPtgv7KT1ltykU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=els1//BR0YZkKMHxqSM4rqt5EITccn3GFKBF/ma9qLLXmoaFQ1kclUhwY961HFqDpnj2xzU+9JBYGSRCg3xId1fQhlPWj76phVHqXPuN15n1WP4kZOzZgaLjoxO9olo/kZxlER8VeqOOnhghYBrYfEYXZo689jcmw56ONVh7SrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c/+BhYCM; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745811423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8WtdDCF/fOjk7l1oSxAg6r0dFrFtCENHh8DzkFeOJww=;
	b=c/+BhYCMrRSBr4yTd5mv7I5T0rvQOkVKbFl9XgTAeowasGX83nsPkgUVRynyVYaolN9nj8
	Wc3beDU42dsEqeUnOao909cO5CNBY1mhRNOzYIyFs52IGCEiGXH2XiE+X/xtR9CO4B/eMp
	PeX97/KKF4tPd4+/I2wRyhQiGvbphn8=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 10/12] mm: introduce bpf_out_of_memory() bpf kfunc
Date: Mon, 28 Apr 2025 03:36:15 +0000
Message-ID: <20250428033617.3797686-11-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
an out of memory events and trigger the corresponding kernel OOM
handling mechanism.

It takes a trusted memcg pointer (or NULL for system-wide OOMs)
as an argument, as well as the page order.

Only one OOM can be declared and handled in the system at once,
so if the function is called in parallel to another OOM handling,
it bails out with -EBUSY.

The function is declared as sleepable. It guarantees that it won't
be called from an atomic context. It's required by the OOM handling
code, which is not guaranteed to work in a non-blocking context.

Handling of a memcg OOM almost always requires taking of the
css_set_lock spinlock. The fact that bpf_out_of_memory() is sleepable
also guarantees that it can't be called with acquired css_set_lock,
so the kernel can't deadlock on it.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/oom_kill.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 2e922e75a9df..246510572e34 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1333,6 +1333,27 @@ __bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
 	return 0;
 }
 
+__bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable, int order)
+{
+	struct oom_control oc = {
+		.memcg = memcg__nullable,
+		.order = order,
+	};
+	int ret = -EINVAL;
+
+	if (oc.order < 0 || oc.order > MAX_PAGE_ORDER)
+		goto out;
+
+	ret = -EBUSY;
+	if (mutex_trylock(&oom_lock)) {
+		ret = out_of_memory(&oc);
+		mutex_unlock(&oom_lock);
+	}
+
+out:
+	return ret;
+}
+
 __bpf_kfunc_end_defs();
 
 __bpf_hook_start();
@@ -1358,6 +1379,7 @@ static const struct btf_kfunc_id_set bpf_oom_hook_set = {
 
 BTF_KFUNCS_START(bpf_oom_kfuncs)
 BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_out_of_memory, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(bpf_oom_kfuncs)
 
 static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
-- 
2.49.0.901.g37484f566f-goog


