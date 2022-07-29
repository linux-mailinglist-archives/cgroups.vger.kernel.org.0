Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B867D585650
	for <lists+cgroups@lfdr.de>; Fri, 29 Jul 2022 22:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbiG2U61 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 16:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiG2U61 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 16:58:27 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B6743DA;
        Fri, 29 Jul 2022 13:58:26 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so6388603pjl.0;
        Fri, 29 Jul 2022 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=2bFn2C2R0db7MfQVsFpxg6sgiZcA9IHHo4DyJ9Lcl8Q=;
        b=DCgDnrIKy0GNaooNz98anUK6wfS3yDZMAehImZSy0ukgVFY8SSIlpHle5jufavIl0l
         tMAVfT/gkY0SEo3oeVkByLZKJW/33IYMpliuFqU4xwfkNS41BRc8Of5qMmYlXZRtfqQU
         VhZJ4bwHKCQzvWxFTKYnSouebgonPOa0mtmnrED64+8nB0/zJIrBlcf3oUJfCdBibN1g
         f2zoGmUF/Nfxjqcrc1DWnLmPoMxgdNNLaWPmVYjHk3BV4D0TTuIRCNU8fMPCIs1ovctT
         loP2YPR2qvUXOM4lh3LkScbKouR4PQrnLi36MQafC7J9i4NMOgucs9cFdvY8xKKeCXqE
         5DYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=2bFn2C2R0db7MfQVsFpxg6sgiZcA9IHHo4DyJ9Lcl8Q=;
        b=dGQDYeirDqePUI8JwRG/T8E2QEsoRPpj6grEwIuv9rf/pKDdzDBy83Uh1fTbbNHFeT
         jJBbSJh86tcFzegpEemmNRmSmAuJWElo/PHaYLZzxMH1wSZswngd1B+HJ2u0wF9NSl9k
         9xJFL4QC+aNSpnkyxlT5r60V1wYpDn4i9B4uQR1NCJefLKa5CBealPRWS2Hc6M+1ad45
         +BbUCgPT7yPJzP6Aw/xJzyhWorEwymfwmqWV4V9BkOKX5cZAbH4HTi5lwj9AJ34OAHFC
         yvhPYTdtUrhgT81q0N9G0D7ASUEQdzdMn+cEHL8GUAm+dGBmQqdtFknspUScAsb6U04S
         TSnQ==
X-Gm-Message-State: ACgBeo3yTwNSQHizXqVJ7sJMo191yGG7C8F8CQq4mY/d/9OBfCGOxOC0
        PoDnIowS4V5aDwTSQgMI8pKj1NOzHfc=
X-Google-Smtp-Source: AA6agR6MyXcs49joshfXyaI+rPLXE4RonUXh3UUyqMYUChPsV74ffPKGtDtKiru4LbiyW47REIPoMQ==
X-Received: by 2002:a17:902:dacf:b0:16d:9d47:dfd1 with SMTP id q15-20020a170902dacf00b0016d9d47dfd1mr5767235plx.52.1659128305239;
        Fri, 29 Jul 2022 13:58:25 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df80])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a398400b001ef863193f4sm6206593pjb.33.2022.07.29.13.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 13:58:24 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 29 Jul 2022 10:58:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Namhyung Kim <namhyung@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v2 cgroup/for-5.20] cgroup: Replace cgroup->ancestor_ids[]
 with ->ancestors[]
Message-ID: <YuRJ7uzKY5/fokH5@slm.duckdns.org>
References: <YuQvcCrcgNWbtndU@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuQvcCrcgNWbtndU@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Every cgroup knows all its ancestors through its ->ancestor_ids[]. There's
no advantage to remembering the IDs instead of the pointers directly and
this makes the array useless for finding an actual ancestor cgroup forcing
cgroup_ancestor() to iteratively walk up the hierarchy instead. Let's
replace cgroup->ancestor_ids[] with ->ancestors[] and remove the walking-up
from cgroup_ancestor().

This patch shouldn't cause user-visible behavior differences.

v2: Update cgroup_ancestor() to use ->ancestors[].

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/cgroup-defs.h                 |   10 +++++-----
 include/linux/cgroup.h                      |    8 +++-----
 kernel/cgroup/cgroup.c                      |    7 +++----
 net/netfilter/nft_socket.c                  |    9 +++++----
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c |    2 +-
 5 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 63bf43c7ca3b..51fa744c2e9d 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -379,7 +379,7 @@ struct cgroup {
 	/*
 	 * The depth this cgroup is at.  The root is at depth zero and each
 	 * step down the hierarchy increments the level.  This along with
-	 * ancestor_ids[] can determine whether a given cgroup is a
+	 * ancestors[] can determine whether a given cgroup is a
 	 * descendant of another without traversing the hierarchy.
 	 */
 	int level;
@@ -499,8 +499,8 @@ struct cgroup {
 	/* Used to store internal freezer state */
 	struct cgroup_freezer_state freezer;
 
-	/* ids of the ancestors at each level including self */
-	u64 ancestor_ids[];
+	/* All ancestors including self */
+	struct cgroup *ancestors[];
 };
 
 /*
@@ -520,8 +520,8 @@ struct cgroup_root {
 	/* The root cgroup.  Root is destroyed on its release. */
 	struct cgroup cgrp;
 
-	/* for cgrp->ancestor_ids[0] */
-	u64 cgrp_ancestor_id_storage;
+	/* for cgrp->ancestors[0] */
+	u64 cgrp_ancestor_storage;
 
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ed53bfe7c46c..4d143729b246 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -574,7 +574,7 @@ static inline bool cgroup_is_descendant(struct cgroup *cgrp,
 {
 	if (cgrp->root != ancestor->root || cgrp->level < ancestor->level)
 		return false;
-	return cgrp->ancestor_ids[ancestor->level] == cgroup_id(ancestor);
+	return cgrp->ancestors[ancestor->level] == ancestor;
 }
 
 /**
@@ -591,11 +591,9 @@ static inline bool cgroup_is_descendant(struct cgroup *cgrp,
 static inline struct cgroup *cgroup_ancestor(struct cgroup *cgrp,
 					     int ancestor_level)
 {
-	if (cgrp->level < ancestor_level)
+	if (ancestor_level < 0 || ancestor_level > cgrp->level)
 		return NULL;
-	while (cgrp && cgrp->level > ancestor_level)
-		cgrp = cgroup_parent(cgrp);
-	return cgrp;
+	return cgrp->ancestors[ancestor_level];
 }
 
 /**
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 85fa4c8587a8..ce587fe43dab 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2047,7 +2047,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask)
 	}
 	root_cgrp->kn = kernfs_root_to_node(root->kf_root);
 	WARN_ON_ONCE(cgroup_ino(root_cgrp) != 1);
-	root_cgrp->ancestor_ids[0] = cgroup_id(root_cgrp);
+	root_cgrp->ancestors[0] = root_cgrp;
 
 	ret = css_populate_dir(&root_cgrp->self);
 	if (ret)
@@ -5391,8 +5391,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 	int ret;
 
 	/* allocate the cgroup and its ID, 0 is reserved for the root */
-	cgrp = kzalloc(struct_size(cgrp, ancestor_ids, (level + 1)),
-		       GFP_KERNEL);
+	cgrp = kzalloc(struct_size(cgrp, ancestors, (level + 1)), GFP_KERNEL);
 	if (!cgrp)
 		return ERR_PTR(-ENOMEM);
 
@@ -5444,7 +5443,7 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 
 	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
-		cgrp->ancestor_ids[tcgrp->level] = cgroup_id(tcgrp);
+		cgrp->ancestors[tcgrp->level] = tcgrp;
 
 		if (tcgrp != cgrp) {
 			tcgrp->nr_descendants++;
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 05ae5a338b6f..d982a7c22a77 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -40,16 +40,17 @@ static noinline bool
 nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo *pkt, u32 level)
 {
 	struct cgroup *cgrp;
+	u64 cgid;
 
 	if (!sk_fullsock(sk))
 		return false;
 
-	cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
-	if (level > cgrp->level)
+	cgrp = cgroup_ancestor(sock_cgroup_ptr(&sk->sk_cgrp_data), level);
+	if (!cgrp)
 		return false;
 
-	memcpy(dest, &cgrp->ancestor_ids[level], sizeof(u64));
-
+	cgid = cgroup_id(cgrp);
+	memcpy(dest, &cgid, sizeof(u64));
 	return true;
 }
 #endif
diff --git a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
index 292c430768b5..bd6a420acc8f 100644
--- a/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
+++ b/tools/perf/util/bpf_skel/bperf_cgroup.bpf.c
@@ -68,7 +68,7 @@ static inline int get_cgroup_v1_idx(__u32 *cgrps, int size)
 			break;
 
 		// convert cgroup-id to a map index
-		cgrp_id = BPF_CORE_READ(cgrp, ancestor_ids[i]);
+		cgrp_id = BPF_CORE_READ(cgrp, ancestors[i], kn, id);
 		elem = bpf_map_lookup_elem(&cgrp_idx, &cgrp_id);
 		if (!elem)
 			continue;
