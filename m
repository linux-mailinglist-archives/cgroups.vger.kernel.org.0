Return-Path: <cgroups+bounces-10622-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC41BCA00B
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 18:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B38753439C3
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DC23C4F1;
	Thu,  9 Oct 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQ6Y2Nc3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCCA230BEC;
	Thu,  9 Oct 2025 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025612; cv=none; b=Y9agvMkqhtpnCUC2Fb7hRjVfdOjnijWz7MBiMrWGaH25wI0qmNVv0WFHoigJ79vVRsB0fPIQq7RVoxmZ0+mO7oxltcGY3bEglmrovdq5Gy/4zqnJabLPp4Q3yQieMEZPm6ajlGMh2+vr3zEjSMU4zgxIVRTIbVs/SwJBtonr1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025612; c=relaxed/simple;
	bh=NMWhqpztKsNMnHx4nh4GQe9VPNSbedFScB58mPNOEKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KIB5kHNZKVuiblWOjdGFS5SuNJIJqmfEer2ceQmYVjelwK32Yq2oNnDh7qnb/MicTg7Gez2boMZvNkt9qSqiTtxx60u9stRFjlGggCheqhqBs+/C8/59PHBq60/OcSs3iT3+azvI/r8YvMkGy+HANznsMcmB5nvVkE4DBYKcAgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQ6Y2Nc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9691BC4CEF7;
	Thu,  9 Oct 2025 16:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760025612;
	bh=NMWhqpztKsNMnHx4nh4GQe9VPNSbedFScB58mPNOEKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQ6Y2Nc3E5Ker5SrKnQcpTm/0pxfnVziosQKN71skA0fbcTOMC/UX8wN6aVSHbpRb
	 tFAqYQcwV9Qh4Jb6hJzHfIgN5eJaV6A2xOWzPUq1T1JffduBWxjc6VwL78T6QESs8M
	 RqagDqo7IksaEvodbezhi/hwnSyyaIKBvm+76GbFvMlLzE2rR+0HXxjNTCS/0wHCcS
	 LJChqPJsTjr5qys7U872ZpVVauSddl6bhPwYyDlFX224Zuwk93oLdvazJj3qhxSC/L
	 EqgRSBAmMa0Als1VWWsCKRPOQkE2FozJzPhwBlOvoV9Z7wVu/avzWJ0wEdhG3TcxB5
	 2SB3Ig4BxsKtQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dan Schatzberg <dschatzberg@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	daniel@iogearbox.net,
	andrii@kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.6] bpf: Do not limit bpf_cgroup_from_id to current's namespace
Date: Thu,  9 Oct 2025 11:55:40 -0400
Message-ID: <20251009155752.773732-74-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009155752.773732-1-sashal@kernel.org>
References: <20251009155752.773732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit 2c895133950646f45e5cf3900b168c952c8dbee8 ]

The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
cgroup corresponding to a given cgroup ID. This helper can be called in
a lot of contexts where the current thread can be random. A recent
example was its use in sched_ext's ops.tick(), to obtain the root cgroup
pointer. Since the current task can be whatever random user space task
preempted by the timer tick, this makes the behavior of the helper
unreliable.

Refactor out __cgroup_get_from_id as the non-namespace aware version of
cgroup_get_from_id, and change bpf_cgroup_from_id to make use of it.

There is no compatibility breakage here, since changing the namespace
against which the lookup is being done to the root cgroup namespace only
permits a wider set of lookups to succeed now. The cgroup IDs across
namespaces are globally unique, and thus don't need to be retranslated.

Reported-by: Dan Schatzberg <dschatzberg@meta.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20250915032618.1551762-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES - This patch fixes a real functional bug in `bpf_cgroup_from_id()`
that breaks sched_ext and other BPF users when the helper runs from
contexts where `current` lives in an unrelated cgroup namespace.

**Bug Details**
- Today `bpf_cgroup_from_id()` simply calls `cgroup_get_from_id()`
  (`kernel/bpf/helpers.c:2539`), and that helper rejects IDs not visible
  from `current`’s namespace via the `cgroup_is_descendant()` check
  (`kernel/cgroup/cgroup.c:6407`). When the kfunc is invoked from timer
  and irq contexts (e.g. sched_ext `ops.tick()`), `current` is just
  whatever user task was interrupted, so the lookup spuriously returns
  `NULL` and the BPF scheduler treats valid cgroups as gone.
- Documentation already describes the ID lookup as global
  (`Documentation/bpf/kfuncs.rst:653`), so current behaviour contradicts
  the documented contract and leads to unpredictable failures for BPF
  programs that cache cgroup IDs.

**Fix Mechanics**
- The patch factors the namespace-agnostic portion of the lookup into a
  new `__cgroup_get_from_id()` placed directly above the existing helper
  in `kernel/cgroup/cgroup.c` (~6376 after applying the change). That
  routine mirrors the old code path but returns as soon as the
  refcounted `struct cgroup` is acquired, skipping the namespace filter.
- `bpf_cgroup_from_id()` is switched to call the new helper
  (`kernel/bpf/helpers.c:2539` post-patch), so BPF programs always see
  the globally unique ID mapping they rely on. The public declaration in
  `include/linux/cgroup.h:653` is added so other in-kernel users can opt
  into the unrestricted lookup if they intentionally need it.
- The original `cgroup_get_from_id()` continues to enforce namespace
  visibility for existing callers (block layer, memcg, BPF iterators),
  so their semantics are unchanged.

**Risk Assessment**
- Behaviour only widens the set of IDs that succeed for this BPF kfunc;
  no kernel data structures or locking rules change. The lookup and
  refcount handling remain identical, so regression risk is low.
- The broader visibility is acceptable because accessing kfuncs of this
  class already requires privileged BPF programs; the cgroup maintainers
  (Acked-by: Tejun Heo) agreed the helper should operate on the global
  namespace.
- No new exports or user-visible ABI are introduced—the change is
  confined to in-kernel helpers and a single BPF kfunc.

**Stable Backport Notes**
- The patch is self-contained and applies cleanly as long as commit
  332ea1f697be (“bpf: Add bpf_cgroup_from_id() kfunc”) is present, which
  is true for current stable lines. No follow-up fixes are required.
- Without it, sched_ext BPF schedulers and other consumers that cache
  cgroup IDs will continue to misbehave whenever executed from
  asynchronous contexts, so backporting is warranted.

 include/linux/cgroup.h |  1 +
 kernel/bpf/helpers.c   |  2 +-
 kernel/cgroup/cgroup.c | 24 ++++++++++++++++++++----
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e2..b08c8e62881cd 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -650,6 +650,7 @@ static inline void cgroup_kthread_ready(void)
 }
 
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
+struct cgroup *__cgroup_get_from_id(u64 id);
 struct cgroup *cgroup_get_from_id(u64 id);
 #else /* !CONFIG_CGROUPS */
 
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8af62cb243d9e..0bde01edf5e6e 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2540,7 +2540,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 {
 	struct cgroup *cgrp;
 
-	cgrp = cgroup_get_from_id(cgid);
+	cgrp = __cgroup_get_from_id(cgid);
 	if (IS_ERR(cgrp))
 		return NULL;
 	return cgrp;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 77d02f87f3f12..c62b98f027f99 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6373,15 +6373,15 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 }
 
 /*
- * cgroup_get_from_id : get the cgroup associated with cgroup id
+ * __cgroup_get_from_id : get the cgroup associated with cgroup id
  * @id: cgroup id
  * On success return the cgrp or ERR_PTR on failure
- * Only cgroups within current task's cgroup NS are valid.
+ * There are no cgroup NS restrictions.
  */
-struct cgroup *cgroup_get_from_id(u64 id)
+struct cgroup *__cgroup_get_from_id(u64 id)
 {
 	struct kernfs_node *kn;
-	struct cgroup *cgrp, *root_cgrp;
+	struct cgroup *cgrp;
 
 	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
 	if (!kn)
@@ -6403,6 +6403,22 @@ struct cgroup *cgroup_get_from_id(u64 id)
 
 	if (!cgrp)
 		return ERR_PTR(-ENOENT);
+	return cgrp;
+}
+
+/*
+ * cgroup_get_from_id : get the cgroup associated with cgroup id
+ * @id: cgroup id
+ * On success return the cgrp or ERR_PTR on failure
+ * Only cgroups within current task's cgroup NS are valid.
+ */
+struct cgroup *cgroup_get_from_id(u64 id)
+{
+	struct cgroup *cgrp, *root_cgrp;
+
+	cgrp = __cgroup_get_from_id(id);
+	if (IS_ERR(cgrp))
+		return cgrp;
 
 	root_cgrp = current_cgns_cgroup_dfl();
 	if (!cgroup_is_descendant(cgrp, root_cgrp)) {
-- 
2.51.0


