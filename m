Return-Path: <cgroups+bounces-12433-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9577CC8D23
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 17:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0198C3085CA1
	for <lists+cgroups@lfdr.de>; Wed, 17 Dec 2025 16:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179BE3557F4;
	Wed, 17 Dec 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g0nSmNmP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D693557F7
	for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988888; cv=none; b=NOwusIbmtKdY4AkldZT5JEy2YbRUTt/vOCSUBtzmM6/W1FSL4aMzB1uUYE8EiNftUaIE2KZhfL2bHPu17DHDRucQ1JLeiK9OVsYIXjJ4sYmF3y4FZgk/Bo5ugNiGHCTREmLf8U7w2xjkk8SkgSf+hZuLb3twi1gFBvWRF/f1VhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988888; c=relaxed/simple;
	bh=jqBZIn02NWMcecKP606Y1uEX4V9j1/cIbAV2uLmFwFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTaw8Vlb1uzKyEIu0AVjxXN0cLM0akCPreh4qSTnNwRnm7u7cH525MxoSTIzfCPqwULn/NUlMRbpudYFNQ055j/Od8+CXpYYR5/OTwhGavECnlynfw+4HdVmFeidcG0IWCFOxedCUS1kRSQU+YxjDl4Lj5mGv7+vHU0Z2qiNOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g0nSmNmP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so2075817f8f.3
        for <cgroups@vger.kernel.org>; Wed, 17 Dec 2025 08:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765988884; x=1766593684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5p3p8kAejxs1YQJhv0WnbRr/UVt3w2bGs3E+oMVl6E=;
        b=g0nSmNmPe0I1hSFsbHvi4tSbETWwrYGb7BvgFGNOZA6f9X+Eq/sAZkF7l8espN3o9L
         TjHpmufh5VcGptfW1SM5uHG5sa60ZQdS3yiJOmn4Xygh5wvlq6s0oyQZRcVr8tPEXHWe
         klSU8aGYAEe9BWAP180QufjkwUmjvyZJd65JZ4yx0EoJvlMWHhwEFHhMSESVX70hR8SR
         j71mbpBqvQNiMcvMaEvtvlixYYrYdnq3gY/o8gyjVBErEAyl8zemnGymBzo/v7SDMy42
         KY75AkOJgM5pzvBARcfyRRswG6D0wwyrgNMTun2Yp4qdS8mgCHwchnJjdsAyx1fN5ALe
         eElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988884; x=1766593684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D5p3p8kAejxs1YQJhv0WnbRr/UVt3w2bGs3E+oMVl6E=;
        b=BhQqfmTBs7HXAtJrFGG5ZaH/crYLx0mtYDpSE30ElWGMJJ27NGDJExDcfTWhxFhjCa
         cXsQK02xfPqMO4QzAp+uOEWSww4myiGI32Z1d7knprpXxkiahQ5Wfz5XnM+0TnhFBkKN
         pC3wocFzhgDujpDwnM60Y9M4OTrBdJzDjd28NBB/s+QXQTxCP0kZwkKQUBPNpZyLj9mM
         39H79D4hNkF1Ain/qwJ0Q6zrxC1pZBcMb2ZoobDb7oZ5D+RvmUK1RJbSsnGWQZUud3pW
         ePY3yuJ6drGT5VmwHhmyDrZz0MJl7MDe2AqNILhlM4uLEtA0bgaGTwiUuLeVqfXY7/N9
         n/tw==
X-Forwarded-Encrypted: i=1; AJvYcCX+K16XOsrnWTiWNalAGnz98wKH9TXn2jgPt8lRq96v+LjSoYEbjK+TA9oAWrnDonTdLxD41sdT@vger.kernel.org
X-Gm-Message-State: AOJu0YyWENh2b0B0cOnklny3ixRE1pq4kiLpcdO00GfZ8feJq4UJSMHj
	9is4ysfmeELrgo11JRehl0DeONhtqIKvFZd4rj7RZxB6/+CtsbVXEZxKmEglY47KhAM=
X-Gm-Gg: AY/fxX77Jsacj71p9j8CT4MKSFkbXQErrOYExmA215/ILOrOGk8ClILbfmSGCQO03t9
	3HkMN9i2F9Cfhl0iTiojMCj9JlUspKyrqvmks/JrlW7DpZvNx4clCsl2f7bl22axOSp5SXxDPgR
	losJ1XjleTV1RL4m0mxHjQkGGQuSng95CYRyGExSefqHyMEHFzp3BHPwiv+WeUwvn1rkBzoCme7
	BAzvDPOsNh8sMgTfcZXuDBUnsDciQUsLVzoZQzOhxIpRXnrANim/Sw31a0vdBS6gh7sJDGTXATB
	IYfkUSiQSPy2MwFifig89AVjdLFUwMhBkDMVx+jkPoCAOhpiVKY/YnUIptbp03NQNrJa0s00kbs
	i6j4ft/PQZOjy4uila7udIuWGrlolx3TXA3ylhYq0nWizWd0xcisLtEApAWkZYVMFHvMoh07Vyf
	d61ksiAFsSVcc+PWshJvX28edmz/7VHsk=
X-Google-Smtp-Source: AGHT+IGpydpE/x5zxrviDhKfJqjEaKSG+Hi2wTDqQX9lTrcKDco/8aBmmWcByjoue9ZRozmJ4alpSw==
X-Received: by 2002:a05:6000:186d:b0:431:5ca:c1b7 with SMTP id ffacd0b85a97d-43105cac2d6mr7328202f8f.23.1765988883910;
        Wed, 17 Dec 2025 08:28:03 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm5728364f8f.29.2025.12.17.08.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:28:03 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH 2/4] cgroup: Introduce cgroup_level() helper
Date: Wed, 17 Dec 2025 17:27:34 +0100
Message-ID: <20251217162744.352391-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162744.352391-1-mkoutny@suse.com>
References: <20251217162744.352391-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a no functional change to hide physical storage of cgroup's
level and it allows subesequent conversion of the storage.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 block/bfq-iosched.c           |  2 +-
 block/blk-iocost.c            |  4 ++--
 include/linux/cgroup.h        | 18 +++++++++++++++---
 include/trace/events/cgroup.h |  8 ++++----
 kernel/bpf/helpers.c          |  2 +-
 kernel/cgroup/cgroup.c        |  4 ++--
 net/netfilter/nft_socket.c    |  2 +-
 7 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4a8d3d96bfe49..f293bab068274 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -601,7 +601,7 @@ static bool bfqq_request_over_limit(struct bfq_data *bfqd,
 		goto out;
 
 	/* +1 for bfqq entity, root cgroup not included */
-	depth = bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup->level + 1;
+	depth = cgroup_level(bfqg_to_blkg(bfqq_group(bfqq))->blkcg->css.cgroup) + 1;
 	if (depth > alloc_depth) {
 		spin_unlock_irq(&bfqd->lock);
 		if (entities != inline_entities)
diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index a0416927d33dc..b4eebe61dca7f 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2962,7 +2962,7 @@ static void ioc_cpd_free(struct blkcg_policy_data *cpd)
 static struct blkg_policy_data *ioc_pd_alloc(struct gendisk *disk,
 		struct blkcg *blkcg, gfp_t gfp)
 {
-	int levels = blkcg->css.cgroup->level + 1;
+	int levels = cgroup_level(blkcg->css.cgroup) + 1;
 	struct ioc_gq *iocg;
 
 	iocg = kzalloc_node(struct_size(iocg, ancestors, levels), gfp,
@@ -3003,7 +3003,7 @@ static void ioc_pd_init(struct blkg_policy_data *pd)
 	init_waitqueue_head(&iocg->waitq);
 	hrtimer_setup(&iocg->waitq_timer, iocg_waitq_timer_fn, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
 
-	iocg->level = blkg->blkcg->css.cgroup->level;
+	iocg->level = cgroup_level(blkg->blkcg->css.cgroup)
 
 	for (tblkg = blkg; tblkg; tblkg = tblkg->parent) {
 		struct ioc_gq *tiocg = blkg_to_iocg(tblkg);
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index bc892e3b37eea..0290878ebad26 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -525,6 +525,18 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
 	return NULL;
 }
 
+/**
+ * cgroup_level - cgroup depth
+ * @cgrp: cgroup
+ *
+ * The depth this cgroup is at.  The root is at depth zero and each step down
+ * the hierarchy increments the level.
+ */
+static inline int cgroup_level(struct cgroup *cgrp)
+{
+	return cgrp->level;
+}
+
 /**
  * cgroup_is_descendant - test ancestry
  * @cgrp: the cgroup to be tested
@@ -537,9 +549,9 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
 static inline bool cgroup_is_descendant(struct cgroup *cgrp,
 					struct cgroup *ancestor)
 {
-	if (cgrp->root != ancestor->root || cgrp->level < ancestor->level)
+	if (cgrp->root != ancestor->root || cgroup_level(cgrp) < cgroup_level(ancestor))
 		return false;
-	return cgrp->ancestors[ancestor->level] == ancestor;
+	return cgrp->ancestors[cgroup_level(ancestor)] == ancestor;
 }
 
 /**
@@ -556,7 +568,7 @@ static inline bool cgroup_is_descendant(struct cgroup *cgrp,
 static inline struct cgroup *cgroup_ancestor(struct cgroup *cgrp,
 					     int ancestor_level)
 {
-	if (ancestor_level < 0 || ancestor_level > cgrp->level)
+	if (ancestor_level < 0 || ancestor_level > cgroup_level(cgrp))
 		return NULL;
 	return cgrp->ancestors[ancestor_level];
 }
diff --git a/include/trace/events/cgroup.h b/include/trace/events/cgroup.h
index ba9229af9a343..0a1bc91754b5e 100644
--- a/include/trace/events/cgroup.h
+++ b/include/trace/events/cgroup.h
@@ -67,7 +67,7 @@ DECLARE_EVENT_CLASS(cgroup,
 	TP_fast_assign(
 		__entry->root = cgrp->root->hierarchy_id;
 		__entry->id = cgroup_id(cgrp);
-		__entry->level = cgrp->level;
+		__entry->level = cgroup_level(cgrp);
 		__assign_str(path);
 	),
 
@@ -136,7 +136,7 @@ DECLARE_EVENT_CLASS(cgroup_migrate,
 	TP_fast_assign(
 		__entry->dst_root = dst_cgrp->root->hierarchy_id;
 		__entry->dst_id = cgroup_id(dst_cgrp);
-		__entry->dst_level = dst_cgrp->level;
+		__entry->dst_level = cgroup_level(dst_cgrp);
 		__assign_str(dst_path);
 		__entry->pid = task->pid;
 		__assign_str(comm);
@@ -180,7 +180,7 @@ DECLARE_EVENT_CLASS(cgroup_event,
 	TP_fast_assign(
 		__entry->root = cgrp->root->hierarchy_id;
 		__entry->id = cgroup_id(cgrp);
-		__entry->level = cgrp->level;
+		__entry->level = cgroup_level(cgrp);
 		__assign_str(path);
 		__entry->val = val;
 	),
@@ -221,7 +221,7 @@ DECLARE_EVENT_CLASS(cgroup_rstat,
 	TP_fast_assign(
 		__entry->root = cgrp->root->hierarchy_id;
 		__entry->id = cgroup_id(cgrp);
-		__entry->level = cgrp->level;
+		__entry->level = cgroup_level(cgrp);
 		__entry->cpu = cpu;
 		__entry->contended = contended;
 	),
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index db72b96f9c8c8..b825f6e0a1c29 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2577,7 +2577,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_ancestor(struct cgroup *cgrp, int level)
 {
 	struct cgroup *ancestor;
 
-	if (level > cgrp->level || level < 0)
+	if (level > cgroup_level(cgrp) || level < 0)
 		return NULL;
 
 	/* cgrp's refcnt could be 0 here, but ancestors can still be accessed */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 554a02ee298ba..e011f1dd6d87f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5843,7 +5843,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	struct cgroup_root *root = parent->root;
 	struct cgroup *cgrp, *tcgrp;
 	struct kernfs_node *kn;
-	int i, level = parent->level + 1;
+	int i, level = cgroup_level(parent) + 1;
 	int ret;
 
 	/* allocate the cgroup and its ID, 0 is reserved for the root */
@@ -5884,7 +5884,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 		goto out_stat_exit;
 
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp))
-		cgrp->ancestors[tcgrp->level] = tcgrp;
+		cgrp->ancestors[cgroup_level(tcgrp)] = tcgrp;
 
 	/*
 	 * New cgroup inherits effective freeze counter, and
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 36affbb697c2f..a5b0340924efb 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -64,7 +64,7 @@ static noinline int nft_socket_cgroup_subtree_level(void)
 	if (IS_ERR(cgrp))
 		return PTR_ERR(cgrp);
 
-	level = cgrp->level;
+	level = cgroup_level(cgrp);
 
 	cgroup_put(cgrp);
 
-- 
2.52.0


