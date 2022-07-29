Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C9585571
	for <lists+cgroups@lfdr.de>; Fri, 29 Jul 2022 21:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbiG2TH5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 29 Jul 2022 15:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238666AbiG2THo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 29 Jul 2022 15:07:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFC18AB3F;
        Fri, 29 Jul 2022 12:06:28 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so5401462pfb.7;
        Fri, 29 Jul 2022 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc;
        bh=uLQq543zzaP6K6uM2P4doohHRVa2+DxlHja/0GeLtJM=;
        b=a1pa96GKeVk8nUGVWzvitE5LFMPojG7MJ/BBtGXKp2C+WlFDMudd7HhhUKYxId7XYd
         DIkHccq5lh2HOp4ViiS9OvRAtw6BlcOdnwP1RKU4pEm8h4O5nsv7Yysc4xwSyOgn60Il
         RcUHSz0FvQCn31sY6Bs4GDilUdSZAEr66+mpOx582AjFdxbGge1r3L08/bt8O7143QFQ
         fsZzKvI5v4l8qFZ3EYEjUabhzkKI48c094BRBv1RJUXzhPP07Ir5N2QjmG9Zmvq8myoE
         8Pz12bJeNHX+WWJBdiPrJvhRbLiM4dNYxbJcl8/CBQdwaQmIaqWPUSCjZ5gHakTfLQ8Q
         eiZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc;
        bh=uLQq543zzaP6K6uM2P4doohHRVa2+DxlHja/0GeLtJM=;
        b=QvLZoHM5/1DJZUVGAaKQPszm2B/gfFm8eDlFQS61foF2UxTsm8mVPf5xQgRwvP2rN0
         d28sMW1TW5q8+Dvi2moZi9anDthZ/munHY3D8tsbYOq29o/SWy3auQAT+Kkq5rSby1Q+
         778Hb6n+pOkmyWvlSDByi/4RP80c2gLHlg2TfATWnVn9IMeskuB3nYqMDe9h9EZjXtRU
         1na1xuAAlK85nkCt6/k48ZKaqGDchjMLRhTqcFOYDW1TYpUzNF4TRtbhz07UckwMZA21
         Fn0s/XJqM2te+2Q1bGvhDN3xYb8yHSFIKh8BHRgab8WzMQWfACRJccC7PNeCDl3VxL+g
         o1LQ==
X-Gm-Message-State: AJIora/XtMJYW1wWH1iBUTS/PcO8rK+euixGRynOS7mgkIQh24YFEdoQ
        S8AFOLkKXsPQvw2IoajkP53gKX0dJ9I=
X-Google-Smtp-Source: AGRyM1vJPZifYAAesQi6iHBXj0elaShPjxKqT1uaup506flc6MzaCg5XhFxjvxAy6yzSldQWXs6z4Q==
X-Received: by 2002:a05:6a00:2495:b0:52b:7a9:9c72 with SMTP id c21-20020a056a00249500b0052b07a99c72mr5110530pfv.46.1659121586652;
        Fri, 29 Jul 2022 12:06:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df80])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0016d88f68dbfsm4050738plg.63.2022.07.29.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:05:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 29 Jul 2022 09:05:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Namhyung Kim <namhyung@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH cgroup/for-5.20] cgroup: Replace cgroup->ancestor_ids[] with
 ->ancestors[]
Message-ID: <YuQvcCrcgNWbtndU@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Every cgroup knows all its ancestors through its ->ancestor_ids[]. While all
the existing users only need the IDs, there's no advantage to remembering
the IDs instead of the pointers directly. Let's replace
cgroup->ancestor_ids[] with ->ancestors[] so that it's easy to access non-ID
ancestor fields.

This patch shouldn't cause any behavior differences.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Namhyung, I think the change in bperf_cgroup is correct but couldn't figure
out how to test it (normal perf build wouldn't compile it). Can you please
see whether it's correct?

Thanks.

 include/linux/cgroup-defs.h                 |   10 +++++-----
 include/linux/cgroup.h                      |    2 +-
 kernel/cgroup/cgroup.c                      |    7 +++----
 net/netfilter/nft_socket.c                  |    5 +++--
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c |    2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

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
index ed53bfe7c46c..5334b6134399 100644
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
index 05ae5a338b6f..d64784d4bd02 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -40,6 +40,7 @@ static noinline bool
 nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo *pkt, u32 level)
 {
 	struct cgroup *cgrp;
+	u64 cgid;
 
 	if (!sk_fullsock(sk))
 		return false;
@@ -48,8 +49,8 @@ nft_sock_get_eval_cgroupv2(u32 *dest, struct sock *sk, const struct nft_pktinfo
 	if (level > cgrp->level)
 		return false;
 
-	memcpy(dest, &cgrp->ancestor_ids[level], sizeof(u64));
-
+	cgid = cgroup_id(cgrp->ancestors[level]);
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
