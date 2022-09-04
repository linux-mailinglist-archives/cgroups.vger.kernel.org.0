Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944735AC690
	for <lists+cgroups@lfdr.de>; Sun,  4 Sep 2022 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiIDVJ5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Sep 2022 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDVJ5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Sep 2022 17:09:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F1F1D0F4
        for <cgroups@vger.kernel.org>; Sun,  4 Sep 2022 14:09:55 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so6906676pji.1
        for <cgroups@vger.kernel.org>; Sun, 04 Sep 2022 14:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date;
        bh=RrHh9O6PhzAN31NW2y2ora7UtS8+X9Q/3gVI7YIt4sI=;
        b=Es/XHRaQSNag8OoZiPCnqwQgmvL8hUgaGZoHJIoW5bYrllYQf7FBUBrF+wy9JBPDMY
         Z9aCYBRqT/GJ1Prc/KY65W+T+F0dkO7pTVmzJE+wVwfpzr7Gl7MJeEWffwL/bX4PLDWS
         G+oaZ6izK24lKQEcLKDZwqhiiarpnc9gomBCVJPFia3q7q8Hb/sU9MEmM72Qa6kriNqH
         IhHC96/q/5HQDZIVTPY4D1NgQjDNUlRSxoseQOUAIDUQ7rldP34ws/nQMLvfojE0tMXr
         OeOaoliBcxA3VFafiJGY77Bwx+4IBgHMCLkY0I8wX9Yy1vARGzXlcYT00uL6atMMKZIt
         jUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=RrHh9O6PhzAN31NW2y2ora7UtS8+X9Q/3gVI7YIt4sI=;
        b=owH/iVAuSa13elKjSuoqEHdCb3jTWlSj8Jgo862Vvpmcan0ZW16tJzAkA4EZ0qb0tJ
         9ZIDIoc5IuKjdqsKHMNAWTWcpKOb/zE6cnL7ApJzhy/y9TYJdhdSCNFsR7a1RqUZTDFP
         WGY+ADidcpGnyQ6CX1BHFizhnHqMwQXAucmiOUYlAicqvswM39uBIP4znZigCf0szLt/
         oH7MpsNec6+OWvWn8yXsU98jQ2ga22xy6gyvX+pXogyqYM8HfpxnmyZuIjJtDoDUnrHo
         K4nMx6Z/f5MIQhUbPeX4AP6+Or1nZrdrEcW57SPepAv4pRXiYRuBlXSWHHDyQolBy1mX
         LbYg==
X-Gm-Message-State: ACgBeo2jq/sTgqaOEH1Qf24p5H1ULR6mC1oGquWHf+YvOTw4JzHOl9dp
        b5ptBI5LsZSWysc7CXHYofo=
X-Google-Smtp-Source: AA6agR5qjWf+msv4w56JbU29ikbnbXgd8nrz8NU7D41WLOZz02sFdvxUYM85uhCYzrRBdTUqF4v2xw==
X-Received: by 2002:a17:902:8bc7:b0:172:c32f:7d30 with SMTP id r7-20020a1709028bc700b00172c32f7d30mr44344293plo.48.1662325794991;
        Sun, 04 Sep 2022 14:09:54 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:291b])
        by smtp.gmail.com with ESMTPSA id bf12-20020a170902b90c00b001749dff717dsm5772119plb.227.2022.09.04.14.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:09:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 4 Sep 2022 11:09:53 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2 cgroup/for-6.1] cgroup: Improve cftype add/rm error
 handling
Message-ID: <YxUUISLVLEIRBwEY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Let's track whether a cftype is currently added or not using a new flag
__CFTYPE_ADDED so that duplicate operations can be failed safely and
consistently allow using empty cftypes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

If no one objects, imma apply these two cgroup file handling cleanup patches
to cgroup/for-6.1 in a few days.

Thanks.

 include/linux/cgroup-defs.h |    1 +
 kernel/cgroup/cgroup.c      |   27 ++++++++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -131,6 +131,7 @@ enum {
 	/* internal flags, do not use outside cgroup core proper */
 	__CFTYPE_ONLY_ON_DFL	= (1 << 16),	/* only on default hierarchy */
 	__CFTYPE_NOT_ON_DFL	= (1 << 17),	/* not on default hierarchy */
+	__CFTYPE_ADDED		= (1 << 18),
 };
 
 /*
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4166,19 +4166,26 @@ static void cgroup_exit_cftypes(struct c
 		cft->ss = NULL;
 
 		/* revert flags set by cgroup core while adding @cfts */
-		cft->flags &= ~(__CFTYPE_ONLY_ON_DFL | __CFTYPE_NOT_ON_DFL);
+		cft->flags &= ~(__CFTYPE_ONLY_ON_DFL | __CFTYPE_NOT_ON_DFL |
+				__CFTYPE_ADDED);
 	}
 }
 
 static int cgroup_init_cftypes(struct cgroup_subsys *ss, struct cftype *cfts)
 {
 	struct cftype *cft;
+	int ret = 0;
 
 	for (cft = cfts; cft->name[0] != '\0'; cft++) {
 		struct kernfs_ops *kf_ops;
 
 		WARN_ON(cft->ss || cft->kf_ops);
 
+		if (cft->flags & __CFTYPE_ADDED) {
+			ret = -EBUSY;
+			break;
+		}
+
 		if ((cft->flags & CFTYPE_PRESSURE) && !cgroup_psi_enabled())
 			continue;
 
@@ -4194,26 +4201,26 @@ static int cgroup_init_cftypes(struct cg
 		if (cft->max_write_len && cft->max_write_len != PAGE_SIZE) {
 			kf_ops = kmemdup(kf_ops, sizeof(*kf_ops), GFP_KERNEL);
 			if (!kf_ops) {
-				cgroup_exit_cftypes(cfts);
-				return -ENOMEM;
+				ret = -ENOMEM;
+				break;
 			}
 			kf_ops->atomic_write_len = cft->max_write_len;
 		}
 
 		cft->kf_ops = kf_ops;
 		cft->ss = ss;
+		cft->flags |= __CFTYPE_ADDED;
 	}
 
-	return 0;
+	if (ret)
+		cgroup_exit_cftypes(cfts);
+	return ret;
 }
 
 static int cgroup_rm_cftypes_locked(struct cftype *cfts)
 {
 	lockdep_assert_held(&cgroup_mutex);
 
-	if (!cfts || !cfts[0].ss)
-		return -ENOENT;
-
 	list_del(&cfts->node);
 	cgroup_apply_cftypes(cfts, false);
 	cgroup_exit_cftypes(cfts);
@@ -4235,6 +4242,12 @@ int cgroup_rm_cftypes(struct cftype *cft
 {
 	int ret;
 
+	if (!cfts || cfts[0].name[0] == '\0')
+		return 0;
+
+	if (!(cfts[0].flags & __CFTYPE_ADDED))
+		return -ENOENT;
+
 	mutex_lock(&cgroup_mutex);
 	ret = cgroup_rm_cftypes_locked(cfts);
 	mutex_unlock(&cgroup_mutex);
