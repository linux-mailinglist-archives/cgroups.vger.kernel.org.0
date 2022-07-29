Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943D6585731
	for <lists+cgroups@lfdr.de>; Sat, 30 Jul 2022 01:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiG2XKX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbiG2XKV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 19:10:21 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0413F617E;
        Fri, 29 Jul 2022 16:10:20 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id w17-20020a17090a8a1100b001f326c73df6so4940136pjn.3;
        Fri, 29 Jul 2022 16:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=ZT5Hgv9++D0LeXy67xshC1n8RX5xcI1NeVd8cpWBDyc=;
        b=EXWqxzvg90ywPJ5Qh+zZ/nc6YVWIvUi9vSiPcUvUxDKlSEDyqnBs6aWG6r0xsf4LOS
         VTXa92CyP08EGIIKs6Y+PZGaIQVKKh0wboWVrlys8DKtJzSTiS6E+gl7YpgNCGyyRfsd
         /PxJ13gwxLXT2v3WJtRlBLRtiExjDVBaAag7enKKiy5AXmBUnxy21YwuirHnCIpmRSdP
         fH0GHAdxhAFM/dx28WIGtHbj/+qGIorOE0XyzpJZn+xEzP4W/zcl8YMZRCcQhhb62gG0
         A4yy2QPbN37xb8X4IMZq0l9aOiTIBAZF+a7/fRPGcBg+4lQfv5vSieEsn/STJHCWDIgT
         3FOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=ZT5Hgv9++D0LeXy67xshC1n8RX5xcI1NeVd8cpWBDyc=;
        b=75FriK2glY3NRIkU+HmUtArLY9+4wAoDtE0Gghc5G1gYFKG1hQ9syYtNrMPzDOU+kQ
         gVwrBY+jiOoNBDzeDCz+ZictRUc4wAKRW54oFBM+vuwLpFLG/il5C93M2DFgW+YDIxZ6
         bPRRGf4i/rEmH1Umn5ib6xOsmW8H3wkXlH0mesnDZHI11NNIsMYJ0NCeCiBq37hsid2P
         NQCXLN5zzrYXc3A3HTlNzqUGlc80yrM5+ZQMjDqktnFYdHVBsIWxy1sYCY/yjzQ5taJU
         f0rzrvOQMlNkgBpSBMVm/HLTZ0J3zqOVkxqVO51Q0R9cCPMTs+xnrQtDVJEILG9TPmnd
         ZWOw==
X-Gm-Message-State: ACgBeo0XPuQJvQJe8sKW6Owvh7DY32L/tDdhXjTV7DHECA9hE0Tz247b
        IX/0fcKQlV4RzdBW0iWw5dDcjBTrS50=
X-Google-Smtp-Source: AA6agR7JXcV/a/dNps5EsEg14WIfe+v2Df0haUj3nkkFLPaWFx3Xk0I2DUCIIb075vYNB3jlA6vnVw==
X-Received: by 2002:a17:902:b681:b0:16d:31bb:7cd3 with SMTP id c1-20020a170902b68100b0016d31bb7cd3mr6042270pls.154.1659136218961;
        Fri, 29 Jul 2022 16:10:18 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df80])
        by smtp.gmail.com with ESMTPSA id m1-20020a1709026bc100b0016d9e53c138sm4192888plt.17.2022.07.29.16.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 16:10:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 29 Jul 2022 13:10:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Namhyung Kim <namhyung@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v3 cgroup/for-5.20] cgroup: Replace cgroup->ancestor_ids[]
 with ->ancestors[]
Message-ID: <YuRo2PLFH6wLgEkm@slm.duckdns.org>
References: <YuQvcCrcgNWbtndU@slm.duckdns.org>
 <YuRJ7uzKY5/fokH5@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuRJ7uzKY5/fokH5@slm.duckdns.org>
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

While at it, improve comments around cgroup_root->cgrp_ancestor_storage.

This patch shouldn't cause user-visible behavior differences.

v2: Update cgroup_ancestor() to use ->ancestors[].

v3: cgroup_root->cgrp_ancestor_storage's type is updated to match
    cgroup->ancestors[]. Better comments.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 include/linux/cgroup-defs.h                 |   16 ++++++++++------
 include/linux/cgroup.h                      |    8 +++-----
 kernel/cgroup/cgroup.c                      |    7 +++----
 net/netfilter/nft_socket.c                  |    9 +++++----
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c |    2 +-
 5 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 63bf43c7ca3b..52a3c47c89bc 100644
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
@@ -517,11 +517,15 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
-	/* The root cgroup.  Root is destroyed on its release. */
+	/*
+	 * The root cgroup. The containing cgroup_root will be destroyed on its
+	 * release. cgrp->ancestors[0] will be used overflowing into the
+	 * following field. cgrp_ancestor_storage must immediately follow.
+	 */
 	struct cgroup cgrp;
 
-	/* for cgrp->ancestor_ids[0] */
-	u64 cgrp_ancestor_id_storage;
+	/* must follow cgrp for cgrp->ancestors[0], see above */
+	struct cgroup *cgrp_ancestor_storage;
 
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
