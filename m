Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A448F533
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 21:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbfHOT5y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 15:57:54 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43857 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfHOT5x (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Aug 2019 15:57:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id m2so2801865qkd.10;
        Thu, 15 Aug 2019 12:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NK0PK6csvakTjylMz8jDV7zgrirY2g6A6SS9gcMGP38=;
        b=XEiIETwR/iRc/lXiBJkeGJWLPwdP3OTZNZTIZNNbaUyYnuuBUMWk76hAjCesVsGRvR
         DVIXJNeKmQfqKXW702SF1PUeP9sMQBQHvirBaKtwjRZq+JeR2Bqiqj8abtcJSMCd1jzQ
         70f4yD1051JXCEGH8Jf4XgvdEGl7z6LtJqxDO8gRemoNlh+IeCfl8mEaqjzVNU4JR8CL
         rQRPxZoa84hi4tZtGQDIy5KO8uZu8JaNvj9NPih9o3iaXsNOSBCo6teWiZ/GbCdlfiuX
         p4mSuilXdKhg1WbG1k1KNt5O/wZddMSeF2o9jyOlaEWhRejaiNoKnop+vbB73UpmszkK
         DYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NK0PK6csvakTjylMz8jDV7zgrirY2g6A6SS9gcMGP38=;
        b=JSiPhVl6cYU2AppTF3Y2khVQgFb1256EC58comULgg8Pw2ubbLCeu2O8q4raJra8pr
         mJIIdAxaYLmCQshCImx+biolu6tsKPx/7JMBEiEWjD2yyoY+KCYTStjobiUb8ewyI7Lf
         6CeiMbLxINoNNIqn6l6hbuQCRnHWROkfLTD5LEyXvCyufvy9Y48c7/+3nyXhDtrgbFFI
         pkZfJzcGXrCUKeLiA51DeZF99+HepuSRXejBDbNVBsSAchVN7cVnkAcDV06F6XqonD52
         fsvZR6GLJXIRhqBebAMUl4JJnPOyasUeT09irldpufzItqnPWFGgRqPTYTkMjNaUG9Nw
         vWUQ==
X-Gm-Message-State: APjAAAVpDnWertv07XkjopAyu0WuhotGztzmfczwjyJlDykxBd2ub1ew
        r1RPG7CEbtw4BAhk3XZxXUQ=
X-Google-Smtp-Source: APXvYqxgqkXzG03UW+nQ2wzQV8lJWn1lUi6WbNWPWMtyk1a9ytxbt9vAVv4HDVD3hmWenqlqAUYrlw==
X-Received: by 2002:ae9:e411:: with SMTP id q17mr5416347qkc.465.1565899072231;
        Thu, 15 Aug 2019 12:57:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id o21sm1768914qkk.100.2019.08.15.12.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:57:51 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:57:50 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
Subject: [PATCH 2/5] bdi: Add bdi->id
Message-ID: <20190815195750.GC2263813@devbig004.ftw2.facebook.com>
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
 include/linux/backing-dev-defs.h |    2 +
 include/linux/backing-dev.h      |    1 
 mm/backing-dev.c                 |   65 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 66 insertions(+), 2 deletions(-)

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
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -24,6 +24,7 @@ static inline struct backing_dev_info *b
 	return bdi;
 }
 
+struct backing_dev_info *bdi_get_by_id(u64 id);
 void bdi_put(struct backing_dev_info *bdi);
 
 __printf(2, 3)
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/wait.h>
+#include <linux/rbtree.h>
 #include <linux/backing-dev.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
@@ -22,10 +23,12 @@ EXPORT_SYMBOL_GPL(noop_backing_dev_info)
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
@@ -859,9 +862,58 @@ struct backing_dev_info *bdi_alloc_node(
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
@@ -877,7 +929,15 @@ int bdi_register_va(struct backing_dev_i
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
 
