Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E42929862A
	for <lists+cgroups@lfdr.de>; Wed, 21 Aug 2019 23:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfHUVCP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Aug 2019 17:02:15 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34976 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbfHUVCO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Aug 2019 17:02:14 -0400
Received: by mail-qk1-f193.google.com with SMTP id r21so3180206qke.2;
        Wed, 21 Aug 2019 14:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KqdERxhIBAIfp0cd0hd74/Q6JgUT8pUqLNfVR97hQrw=;
        b=cvs9Vr1YLEympRLozhgSozrKl/OUAv7d2nZM7TBMrHINk/WCc10TYb0b7zVsDTOHhU
         Ta5B4QJ347mfUkR+Wup4leIKwduHVyS+oPVMrEk2P80BjxZRHKGUtSEQ6gZ9xJhc74f7
         FXfp3eqwTYi689KtqkWIiD0avLvg+V4jePnSbNV5KsDQnukJYxKgL4OHMa+8ehX5TEHN
         Sf7gBaXzkDUK+ATl6xXFt3mobpa8Y7S3RQchx1wt7116E02QSagSd/IuyCGvHU2Q+r8j
         6rvey1+5cnTsOx0CG88ElNI/RUUWRUhXv5KiUGa23CgKxHmLU/gjbEvt2/2Rp8aPHMBT
         N9lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KqdERxhIBAIfp0cd0hd74/Q6JgUT8pUqLNfVR97hQrw=;
        b=HiNLVJVgcUehhxt7HVn2urI0gMs8OTkFNqfZXY2ImC5P5jdI9JaDUaSSSNzKBTRfFf
         8VYRV0E5cT7SckIsnRbTs+yO7En4drVC7bEWVjng4j7eT8iWJe3yjMhMW3+/G10l77cN
         ToEW5I1dUPjUvItv4OV9tfBxpYCaSwEhEzK3lfaEFfVC3hz/tb3R3x8Kkfz6o3yLalT9
         5e05O05pbCjA4F6rlbaTy3UiZ75LvZ0TRxQvwV/VQqmCdsRsmb0mYHRL2NylNBD8Qfyk
         UUFv4GQYcp1ty4d2L07Rj2/qCqXe4Ltdurlr0buF8nhFsx6g2A9tOWPMylHocriKMc7d
         d9Dg==
X-Gm-Message-State: APjAAAUU4UMmuPHt21dtTeUiL4ZKNyGX7j2WVSgmEtmEwNJuPNQqGhdX
        yR0fXvERhTBlt3CFRppdU3G3d8RG
X-Google-Smtp-Source: APXvYqwiYZD1Q0jEB7i1nrSipTQUHE/zf0lNymV6cHbSadUYR57/Bem3O2OHYhxa9abFPy0fNICRPg==
X-Received: by 2002:ae9:e84b:: with SMTP id a72mr33982679qkg.355.1566421332435;
        Wed, 21 Aug 2019 14:02:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:1f05])
        by smtp.gmail.com with ESMTPSA id l18sm10223076qtp.64.2019.08.21.14.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Aug 2019 14:02:11 -0700 (PDT)
Date:   Wed, 21 Aug 2019 14:02:10 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
Subject: [PATCH v3 4/5] writeback, memcg: Implement cgroup_writeback_by_id()
Message-ID: <20190821210210.GM2263813@devbig004.ftw2.facebook.com>
References: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
 <20190815195902.GE2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815195902.GE2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
---
 fs/fs-writeback.c         |   83 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/writeback.h |    2 +
 2 files changed, 85 insertions(+)

--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -892,6 +892,89 @@ restart:
 }
 
 /**
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
+/**
  * cgroup_writeback_umount - flush inode wb switches for umount
  *
  * This function is called when a super_block is about to be destroyed and
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -217,6 +217,8 @@ void wbc_attach_and_unlock_inode(struct
 void wbc_detach_inode(struct writeback_control *wbc);
 void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 			      size_t bytes);
+int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
+			   enum wb_reason reason, struct wb_completion *done);
 void cgroup_writeback_umount(void);
 
 /**
