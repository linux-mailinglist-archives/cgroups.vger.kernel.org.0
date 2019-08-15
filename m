Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714708F538
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 21:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbfHOT60 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 15:58:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37367 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfHOT60 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Aug 2019 15:58:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id s14so2900424qkm.4;
        Thu, 15 Aug 2019 12:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=No9QVbYlU2sgvqpbXkCw9UwcBjO6u+aBDjKZ2hew4hU=;
        b=Gt2lVOaCaz027V8blAT2ErzUdzTPXVxQRyH5tybpqHiiG25cOe/Ls1rrBq0oQhKq4p
         d7wDqqbJ1bM5gobzk77hGHVjDxsDbsTDq+3z5hGLL7VRGAHBX54T8poZTuJbJHT6/wIS
         n+3ZywqbhJ8Uy8k680B4ItSJ85EZjWnkScl1y0M11RkI5WI1vV26GfrlBoAOgyn8ZImy
         MXwv9CZiXjeSbA4ctU2yD4jwsbkz8PujxOymrX0SWDi+4cEk8cYfE//WGxqaDLTNEBGl
         XLQPaEG9+Gi8NYgFRTQ2Qqk+WJv08PpnQoMPdw8hU66i8SPUqA1LZE/L+3O+hb/w8cN8
         s+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=No9QVbYlU2sgvqpbXkCw9UwcBjO6u+aBDjKZ2hew4hU=;
        b=I1jSDxk2anaDI6SVT992tvOccLi9/Xujbra4dn3JJl/QU8HSd40WdKWLzGNJZurzHX
         8daHzUFupc/5wKD8umDjQEY16aDDpiI3Io057ldcMd5nSjIYpcnWGRmGzsdFGL7h0IA9
         5ufirkEXAhfigS3dF3+71onnMexdbNf7ZQna4k27PJ3rpPzbBvIKWGkkiz0JdCUM8eFO
         MvM9MXRJCew8ShkgV++wTPfGDtO3v+nuAiG9R8UnPyO54FZF5sAWmmnvuA0rO1PGA+EZ
         WxfAKwUD3QUSj/5kwVMPHccbQuqibbXBDw7mI+HmQw2/Jv3zunfCLNrESFjy2YMoBtVl
         V3rA==
X-Gm-Message-State: APjAAAXnbX6sx9BzAtw1bwKa0I+zEjxjiyU+wUOrfk4x3HSLM1uKPsiM
        Bn67sw9XYkzDjAeOoFpfsbo=
X-Google-Smtp-Source: APXvYqwYWkovkIDA9ykxqDtjrl7m1KWzJV4ngQIYl24GN2FpAUGCMjzO1WndSIPov9pFcxFYLJIpYA==
X-Received: by 2002:ae9:e216:: with SMTP id c22mr5746003qkc.192.1565899105305;
        Thu, 15 Aug 2019 12:58:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id 23sm1855599qkk.121.2019.08.15.12.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:58:24 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:58:23 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
Subject: [PATCH 3/5] writeback: Separate out wb_get_lookup() from
 wb_get_create()
Message-ID: <20190815195823.GD2263813@devbig004.ftw2.facebook.com>
References: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Separate out wb_get_lookup() which doesn't try to create one if there
isn't already one from wb_get_create().  This will be used by later
patches.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/backing-dev.h |    2 +
 mm/backing-dev.c            |   55 +++++++++++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 18 deletions(-)

--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -230,6 +230,8 @@ static inline int bdi_sched_wait(void *w
 struct bdi_writeback_congested *
 wb_congested_get_create(struct backing_dev_info *bdi, int blkcg_id, gfp_t gfp);
 void wb_congested_put(struct bdi_writeback_congested *congested);
+struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
+				    struct cgroup_subsys_state *memcg_css);
 struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp);
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -618,13 +618,12 @@ out_put:
 }
 
 /**
- * wb_get_create - get wb for a given memcg, create if necessary
+ * wb_get_lookup - get wb for a given memcg
  * @bdi: target bdi
  * @memcg_css: cgroup_subsys_state of the target memcg (must have positive ref)
- * @gfp: allocation mask to use
  *
- * Try to get the wb for @memcg_css on @bdi.  If it doesn't exist, try to
- * create one.  The returned wb has its refcount incremented.
+ * Try to get the wb for @memcg_css on @bdi.  The returned wb has its
+ * refcount incremented.
  *
  * This function uses css_get() on @memcg_css and thus expects its refcnt
  * to be positive on invocation.  IOW, rcu_read_lock() protection on
@@ -641,6 +640,39 @@ out_put:
  * each lookup.  On mismatch, the existing wb is discarded and a new one is
  * created.
  */
+struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
+				    struct cgroup_subsys_state *memcg_css)
+{
+	struct bdi_writeback *wb;
+
+	if (!memcg_css->parent)
+		return &bdi->wb;
+
+	rcu_read_lock();
+	wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
+	if (wb) {
+		struct cgroup_subsys_state *blkcg_css;
+
+		/* see whether the blkcg association has changed */
+		blkcg_css = cgroup_get_e_css(memcg_css->cgroup, &io_cgrp_subsys);
+		if (unlikely(wb->blkcg_css != blkcg_css || !wb_tryget(wb)))
+			wb = NULL;
+		css_put(blkcg_css);
+	}
+	rcu_read_unlock();
+
+	return wb;
+}
+
+/**
+ * wb_get_create - get wb for a given memcg, create if necessary
+ * @bdi: target bdi
+ * @memcg_css: cgroup_subsys_state of the target memcg (must have positive ref)
+ * @gfp: allocation mask to use
+ *
+ * Try to get the wb for @memcg_css on @bdi.  If it doesn't exist, try to
+ * create one.  See wb_get_lookup() for more details.
+ */
 struct bdi_writeback *wb_get_create(struct backing_dev_info *bdi,
 				    struct cgroup_subsys_state *memcg_css,
 				    gfp_t gfp)
@@ -653,20 +685,7 @@ struct bdi_writeback *wb_get_create(stru
 		return &bdi->wb;
 
 	do {
-		rcu_read_lock();
-		wb = radix_tree_lookup(&bdi->cgwb_tree, memcg_css->id);
-		if (wb) {
-			struct cgroup_subsys_state *blkcg_css;
-
-			/* see whether the blkcg association has changed */
-			blkcg_css = cgroup_get_e_css(memcg_css->cgroup,
-						     &io_cgrp_subsys);
-			if (unlikely(wb->blkcg_css != blkcg_css ||
-				     !wb_tryget(wb)))
-				wb = NULL;
-			css_put(blkcg_css);
-		}
-		rcu_read_unlock();
+		wb = wb_get_lookup(bdi, memcg_css);
 	} while (!wb && !cgwb_create(bdi, memcg_css, gfp));
 
 	return wb;
