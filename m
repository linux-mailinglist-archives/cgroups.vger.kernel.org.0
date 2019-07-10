Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A766764DF9
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2019 23:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGJVVq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jul 2019 17:21:46 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40971 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJVVq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jul 2019 17:21:46 -0400
Received: by mail-pf1-f169.google.com with SMTP id m30so1674118pff.8;
        Wed, 10 Jul 2019 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=siIn1w9IRj9EyAz1dx7Gl8hkgFfIWbx6jNb+pkUBwDM=;
        b=CWXXPYiJmNO2VkL3MT7DkHV+hmD6kdOoGicSmCBWezxnW3FtZWUaM6vZU1jQNA/eS+
         ln6xoL5gaBXAKj+Ud0V0NkTKNiTDmbUXXBzRXsgE1yQmVCRot+YPhZcGoM758uw19VmT
         CnnGu6vGxos82NuqzEfkrNw+TtW7B1jITstDIG5KEQR4BKgB2lIqHSCLaqrsgNMQxsfj
         Zcpjs6nphhqe+2Bt9te7fqFOQ0J1rBiZI3EyD11sChA1bbYVICRaNWJ6c+cVl2mprSR7
         4YfoDL5JUBiN7h9J+arYvdtZjXF4lBEAxb5wNcCPLRGk4SlBvVCGts/PESbNS7CE3hqa
         K6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=siIn1w9IRj9EyAz1dx7Gl8hkgFfIWbx6jNb+pkUBwDM=;
        b=G31mc882SuOiuD0N1mw7JnNKERYDORTa67csrSf2+wZtJS1WbvacojJa08pYUdwVOz
         SQ18iWt9eVpMRKC9l0/IkrgmigzF/3e7xZNs0cooV7r8aWnzoQlMvzS6WINk0XDeuDaJ
         B1DDPp918zLoBc+Ukg4YqEvmsBrk+i+erXyX/lfmz+Axk5WngVovw65qFyam/5yNr3Cy
         VWcnmo/1DCVg2+1qXZ1lYalxQ3UEWTzfjqlyOyifUw4i1kleQ6aAMzx3MsddNSJ4XGK+
         jZ6dWyhufFjPbP4wgjkuOIzJ2XbOUr0W6Jy08/OH5WpIUSOOaFd4O/r+R+Ft6llzH3Al
         gsPw==
X-Gm-Message-State: APjAAAV8u15dOr7ORhUpFdg28PyneAkQtmR/io4PtZVHXMETu2jnT8jf
        hAOH6V7C+B7rY2HSO5JweFg=
X-Google-Smtp-Source: APXvYqxQfsexkWldj+RCgTAbmj+xZvqfEumit5Aa+odfoOiHhmjsD1wG+GkD6dTNi1iGZIz2KvODBQ==
X-Received: by 2002:a63:5550:: with SMTP id f16mr363820pgm.426.1562793705481;
        Wed, 10 Jul 2019 14:21:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id f19sm3851402pfk.180.2019.07.10.14.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 14:21:44 -0700 (PDT)
Date:   Wed, 10 Jul 2019 14:21:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 11/10] block: omit request->pre_start_time_ns if
 !CONFIG_BLK_CGROUP_IOCOST work-conserving porportional controller
Message-ID: <20190710212142.GP657710@devbig004.ftw2.facebook.com>
References: <20190710205128.1316483-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190710205128.1316483-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From e2693136fa64d5c9dde73d2d663bde84f8326877 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 10 Jul 2019 14:18:12 -0700

request->pre_start_time is currently only used by the iocost
controller.  Let's omit the field if disabled and avoid wasting space
in struct request.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Jens Axboe <axboe@kernel.dk>
---
The git branch is updated accordingly.

Thanks.

 block/blk-mq.c         | 2 ++
 include/linux/blkdev.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 90b46988cc02..ce96bcd7e260 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -325,7 +325,9 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
 	RB_CLEAR_NODE(&rq->rb_node);
 	rq->rq_disk = NULL;
 	rq->part = NULL;
+#ifdef CONFIG_BLK_CGROUP_IOCOST
 	rq->pre_start_time_ns = pre_start_time_ns;
+#endif
 	if (blk_mq_need_time_stamp(rq))
 		rq->start_time_ns = ktime_get_ns();
 	else
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4247a9bc44b7..2425af6d3f5e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -194,8 +194,10 @@ struct request {
 
 	struct gendisk *rq_disk;
 	struct hd_struct *part;
+#ifdef CONFIG_BLK_CGROUP_IOCOST
 	/* Time that the first bio started allocating this request. */
 	u64 pre_start_time_ns;
+#endif
 	/* Time that this request was allocated for this IO. */
 	u64 start_time_ns;
 	/* Time that I/O was submitted to the device. */
@@ -635,8 +637,13 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
 #define blk_queue_pci_p2pdma(q)	\
 	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
+
+#ifdef CONFIG_BLK_CGROUP_IOCOST
 #define blk_queue_rec_prestart(q)	\
 	test_bit(QUEUE_FLAG_REC_PRESTART, &(q)->queue_flags)
+#else
+#define blk_queue_rec_prestart(q)		false
+#endif
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.17.1

