Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEB9D3AE
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfHZQHK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 12:07:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44548 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732544AbfHZQHJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 12:07:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so18344419qtg.11;
        Mon, 26 Aug 2019 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3O1Xq487diyfXoEMJTs1w0KreVNXXWibqp67Mw7HjBc=;
        b=SEjLWoYq0fP4psa2uBCCNXgApcuu8+EjDA3JSX8B878dJyhaBo4676Upvh2awIl1by
         hWUw2nMIRbQ1IepCNcoN4rtxFcmV3OkbYrB/HUNC7W42vZhjFKqslqo5N3geJADazT89
         Isqm1ZYiEe8QZuRhdh1ET/XGlhWk9J7KMO1YGG1t1ghRvhMJsLk+xmyE9v1w3D2LDiym
         IXtA59EQycyV6DncujF5KbNoD9r9BWPpOqPvy/gANx21ZEGvUODp6cDqXEZENy+s9LJU
         ja/E0xCD8Mk5t3kLAMXsrtNXnfgzHlhuPrnw8C99C/D4DoCJOjrcRw9QKiy5r/thHfhw
         3SSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3O1Xq487diyfXoEMJTs1w0KreVNXXWibqp67Mw7HjBc=;
        b=gwlnkljsUyqOmMcvQMu+H1/G6EZDbezEaWJXSS9tbTWLZMqAys/n7y4L1mtJKPfeki
         iPer+U1NujA2wusn90DJhkjE5I++J6HqhVtUFPRf3phYvd1gVU+5ZuQzeDxyJDMucdVB
         m2csAbdEsP8XBp6EPRQnEMC0jwuorS8HXdrxhnVPuXfrkzMhf4t8SWI3N9kXsyd2racs
         mwniy5FulMsyPtLPXuk8hof/uNzP3t3//zawzuC/KdU937LfPznASZDXFK7uygy1aJPB
         LI3AhF8pQv2vLS4pbRV99O0eoIrzYIC1jpxvepSWgHJ0occJGJzuSxGOQ21Orppmwnmr
         7QKw==
X-Gm-Message-State: APjAAAUO5TeeU1ofxVp31KR67OPwCCs5IKLMTgAYPSPq1JFwxqiuAjGw
        s6hAMPPstTOZNgAy/i6RauI=
X-Google-Smtp-Source: APXvYqz6TmAInj6KM5R4Rc8P00hmyrxHa998IOH+1NeZV/9zlWFa2x+f6QG1y0uMpFPaYhkDibImdg==
X-Received: by 2002:ac8:4504:: with SMTP id q4mr18060803qtn.286.1566835628343;
        Mon, 26 Aug 2019 09:07:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::d081])
        by smtp.gmail.com with ESMTPSA id r15sm6633892qtp.94.2019.08.26.09.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:07:07 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 2/5] bdi: Add bdi->id
Date:   Mon, 26 Aug 2019 09:06:53 -0700
Message-Id: <20190826160656.870307-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826160656.870307-1-tj@kernel.org>
References: <20190826160656.870307-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There currently is no way to universally identify and lookup a bdi
without holding a reference and pointer to it.  This patch adds an
non-recycling bdi->id and implements bdi_get_by_id() which looks up
bdis by their ids.  This will be used by memcg foreign inode flushing.

I left bdi_list alone for simplicity and because while rb_tree does
support rcu assignment it doesn't seem to guarantee lossless walk when
walk is racing aginst tree rebalance operations.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/backing-dev-defs.h |  2 +
 include/linux/backing-dev.h      |  1 +
 mm/backing-dev.c                 | 65 +++++++++++++++++++++++++++++++-
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 8fb740178d5d..1075f2552cfc 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -185,6 +185,8 @@ struct bdi_writeback {
 };
 
 struct backing_dev_info {
+	u64 id;
+	struct rb_node rb_node; /* keyed by ->id */
 	struct list_head bdi_list;
 	unsigned long ra_pages;	/* max readahead in PAGE_SIZE units */
 	unsigned long io_pages;	/* max allowed IO size */
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 02650b1253a2..84cdcfbc763f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -24,6 +24,7 @@ static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
 	return bdi;
 }
 
+struct backing_dev_info *bdi_get_by_id(u64 id);
 void bdi_put(struct backing_dev_info *bdi);
 
 __printf(2, 3)
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index e8e89158adec..612aa7c5ddbd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/wait.h>
+#include <linux/rbtree.h>
 #include <linux/backing-dev.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
@@ -22,10 +23,12 @@ EXPORT_SYMBOL_GPL(noop_backing_dev_info);
 static struct class *bdi_class;
 
 /*
- * bdi_lock protects updates to bdi_list. bdi_list has RCU reader side
- * locking.
+ * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
+ * reader side locking.
  */
 DEFINE_SPINLOCK(bdi_lock);
+static u64 bdi_id_cursor;
+static struct rb_root bdi_tree = RB_ROOT;
 LIST_HEAD(bdi_list);
 
 /* bdi_wq serves all asynchronous writeback tasks */
@@ -859,9 +862,58 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
 }
 EXPORT_SYMBOL(bdi_alloc_node);
 
+static struct rb_node **bdi_lookup_rb_node(u64 id, struct rb_node **parentp)
+{
+	struct rb_node **p = &bdi_tree.rb_node;
+	struct rb_node *parent = NULL;
+	struct backing_dev_info *bdi;
+
+	lockdep_assert_held(&bdi_lock);
+
+	while (*p) {
+		parent = *p;
+		bdi = rb_entry(parent, struct backing_dev_info, rb_node);
+
+		if (bdi->id > id)
+			p = &(*p)->rb_left;
+		else if (bdi->id < id)
+			p = &(*p)->rb_right;
+		else
+			break;
+	}
+
+	if (parentp)
+		*parentp = parent;
+	return p;
+}
+
+/**
+ * bdi_get_by_id - lookup and get bdi from its id
+ * @id: bdi id to lookup
+ *
+ * Find bdi matching @id and get it.  Returns NULL if the matching bdi
+ * doesn't exist or is already unregistered.
+ */
+struct backing_dev_info *bdi_get_by_id(u64 id)
+{
+	struct backing_dev_info *bdi = NULL;
+	struct rb_node **p;
+
+	spin_lock_bh(&bdi_lock);
+	p = bdi_lookup_rb_node(id, NULL);
+	if (*p) {
+		bdi = rb_entry(*p, struct backing_dev_info, rb_node);
+		bdi_get(bdi);
+	}
+	spin_unlock_bh(&bdi_lock);
+
+	return bdi;
+}
+
 int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 {
 	struct device *dev;
+	struct rb_node *parent, **p;
 
 	if (bdi->dev)	/* The driver needs to use separate queues per device */
 		return 0;
@@ -877,7 +929,15 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
 	set_bit(WB_registered, &bdi->wb.state);
 
 	spin_lock_bh(&bdi_lock);
+
+	bdi->id = ++bdi_id_cursor;
+
+	p = bdi_lookup_rb_node(bdi->id, &parent);
+	rb_link_node(&bdi->rb_node, parent, p);
+	rb_insert_color(&bdi->rb_node, &bdi_tree);
+
 	list_add_tail_rcu(&bdi->bdi_list, &bdi_list);
+
 	spin_unlock_bh(&bdi_lock);
 
 	trace_writeback_bdi_register(bdi);
@@ -918,6 +978,7 @@ EXPORT_SYMBOL(bdi_register_owner);
 static void bdi_remove_from_list(struct backing_dev_info *bdi)
 {
 	spin_lock_bh(&bdi_lock);
+	rb_erase(&bdi->rb_node, &bdi_tree);
 	list_del_rcu(&bdi->bdi_list);
 	spin_unlock_bh(&bdi_lock);
 
-- 
2.17.1

