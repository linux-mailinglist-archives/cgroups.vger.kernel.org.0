Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 142029D3AA
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 18:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbfHZQHP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 12:07:15 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38977 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732660AbfHZQHO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 12:07:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id l9so18371360qtu.6;
        Mon, 26 Aug 2019 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E6MTfC4z3G0quoIF3DBw3b87rQV2WqMBkOF2p8Csnt4=;
        b=f7PWgdQaNS08y3O69h2TR6wz4T9l5sgzCskuEu75Rl4PPIoqtP1eKAL8MIWvGgBGtD
         b9nHdxjt/X7Yhwz4de8X2WBOiT4ZepZsWVsoCYdmY2fMXZfNCQehm+t0G3Ku1Ww+4huv
         PQ6z8migaaxzUVn9akM/4OyyWFicteYTGNjr2o9iivqYNfvwcZBbtk9hiqePLSyjKXxt
         0RoWxaEApyGfC0uS3sh3e33KjgJQNMv299LqP+PaH6YtTg+QfOuubHX1AmqbNWUaATVV
         gLgNdO4IRMKOeIBRyMaFmxRomthURawpH6qAf1+ZHXC5o5v4K5s/VBLoljkuFuy5JFa0
         OhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=E6MTfC4z3G0quoIF3DBw3b87rQV2WqMBkOF2p8Csnt4=;
        b=Hw3arEJfQ5aQlKBAoP5REXoYtB+NbVM++wFd6h1iqTTgE5qpUDvfleoDoxo27qDOKr
         Nz4UuR+U61aTOAZPE8vpVJfvgobiWMEJzWUwc/SvmVxxvmpNIu6HN6+l5qEJygOsx/0u
         beFT8VWMcsNy6owYwxikAt1baNoT/wYFI9bxn8NTYpdgwUG3Kb0hIA9U1rlXNEqdAKgE
         /mjuG9vetNkLFQTnXiovjj19GHylASB/wKazS3nx7USeI6G2bwlzE9FYltuSCk44xoRB
         uUWK3pnBr58MEiMEfPMjDePZ6fX45b16ddZvoHme5b6VpXorRCyj465SNvUxpL/nobPW
         e0Dg==
X-Gm-Message-State: APjAAAWyHT73xvIKcku3fORdFedmAZI0p3bysYQeFxfFCefbni+X26cv
        Chg+Qrzo1Eik3C97TPN1k60=
X-Google-Smtp-Source: APXvYqyW96+ohk8RXKdmfLCDzQI/qpRQjuN30ZN6OCty725+J7I96Alv2wMPQnmck7YKVxCLnF1bgg==
X-Received: by 2002:ad4:4752:: with SMTP id c18mr16324758qvx.69.1566835632574;
        Mon, 26 Aug 2019 09:07:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::d081])
        by smtp.gmail.com with ESMTPSA id t5sm6637934qkt.93.2019.08.26.09.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:07:11 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] writeback, memcg: Implement cgroup_writeback_by_id()
Date:   Mon, 26 Aug 2019 09:06:55 -0700
Message-Id: <20190826160656.870307-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826160656.870307-1-tj@kernel.org>
References: <20190826160656.870307-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Implement cgroup_writeback_by_id() which initiates cgroup writeback
from bdi and memcg IDs.  This will be used by memcg foreign inode
flushing.

v2: Use wb_get_lookup() instead of wb_get_create() to avoid creating
    spurious wbs.

v3: Interpret 0 @nr as 1.25 * nr_dirty to implement best-effort
    flushing while avoding possible livelocks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c         | 83 +++++++++++++++++++++++++++++++++++++++
 include/linux/writeback.h |  2 +
 2 files changed, 85 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 9442f1fd6460..658dc16c9e6d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -891,6 +891,89 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		wb_put(last_wb);
 }
 
+/**
+ * cgroup_writeback_by_id - initiate cgroup writeback from bdi and memcg IDs
+ * @bdi_id: target bdi id
+ * @memcg_id: target memcg css id
+ * @nr_pages: number of pages to write, 0 for best-effort dirty flushing
+ * @reason: reason why some writeback work initiated
+ * @done: target wb_completion
+ *
+ * Initiate flush of the bdi_writeback identified by @bdi_id and @memcg_id
+ * with the specified parameters.
+ */
+int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr,
+			   enum wb_reason reason, struct wb_completion *done)
+{
+	struct backing_dev_info *bdi;
+	struct cgroup_subsys_state *memcg_css;
+	struct bdi_writeback *wb;
+	struct wb_writeback_work *work;
+	int ret;
+
+	/* lookup bdi and memcg */
+	bdi = bdi_get_by_id(bdi_id);
+	if (!bdi)
+		return -ENOENT;
+
+	rcu_read_lock();
+	memcg_css = css_from_id(memcg_id, &memory_cgrp_subsys);
+	if (memcg_css && !css_tryget(memcg_css))
+		memcg_css = NULL;
+	rcu_read_unlock();
+	if (!memcg_css) {
+		ret = -ENOENT;
+		goto out_bdi_put;
+	}
+
+	/*
+	 * And find the associated wb.  If the wb isn't there already
+	 * there's nothing to flush, don't create one.
+	 */
+	wb = wb_get_lookup(bdi, memcg_css);
+	if (!wb) {
+		ret = -ENOENT;
+		goto out_css_put;
+	}
+
+	/*
+	 * If @nr is zero, the caller is attempting to write out most of
+	 * the currently dirty pages.  Let's take the current dirty page
+	 * count and inflate it by 25% which should be large enough to
+	 * flush out most dirty pages while avoiding getting livelocked by
+	 * concurrent dirtiers.
+	 */
+	if (!nr) {
+		unsigned long filepages, headroom, dirty, writeback;
+
+		mem_cgroup_wb_stats(wb, &filepages, &headroom, &dirty,
+				      &writeback);
+		nr = dirty * 10 / 8;
+	}
+
+	/* issue the writeback work */
+	work = kzalloc(sizeof(*work), GFP_NOWAIT | __GFP_NOWARN);
+	if (work) {
+		work->nr_pages = nr;
+		work->sync_mode = WB_SYNC_NONE;
+		work->range_cyclic = 1;
+		work->reason = reason;
+		work->done = done;
+		work->auto_free = 1;
+		wb_queue_work(wb, work);
+		ret = 0;
+	} else {
+		ret = -ENOMEM;
+	}
+
+	wb_put(wb);
+out_css_put:
+	css_put(memcg_css);
+out_bdi_put:
+	bdi_put(bdi);
+	return ret;
+}
+
 /**
  * cgroup_writeback_umount - flush inode wb switches for umount
  *
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 8945aac31392..a19d845dd7eb 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -217,6 +217,8 @@ void wbc_attach_and_unlock_inode(struct writeback_control *wbc,
 void wbc_detach_inode(struct writeback_control *wbc);
 void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 			      size_t bytes);
+int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
+			   enum wb_reason reason, struct wb_completion *done);
 void cgroup_writeback_umount(void);
 
 /**
-- 
2.17.1

