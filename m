Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940A56FCE11
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 20:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjEISzE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbjEISyu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 14:54:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2183140C6
        for <cgroups@vger.kernel.org>; Tue,  9 May 2023 11:54:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so7860389276.0
        for <cgroups@vger.kernel.org>; Tue, 09 May 2023 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683658480; x=1686250480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NHNoBY3JivORLUbcuDFr4/9tVoWO5VHbaNGCQaI5Uvo=;
        b=1X+XdmG+IkTZjYisXQOtINFnLgKxKKD4yQQ8LZUpgcqBwpnOBVwkfCN/OCN1tT6s08
         01wxZe3i/6hmOdK2AvG76yucisBae+HZSfJT2v6uuqjpFCK+r17X7cYwZbnm25TSELUJ
         tlLmTSt9OTT3NyhwSfsdGskP6z043cZuB5dmUv3B5WzyH5ZFIJnnyVhd9zMCeqelaOaq
         UCPqHoh3EwqVgMfpu7tH4IckqI8F/b13F+YYm8eAkxcYDmQhXF6SKdLx1PFNSTy916Ck
         9cnvr1EktdDZy1qqUuh56DaUScHEZDl7WRKxgOCJqbMy29kunT1BQcRDt+rmvzI0vP1K
         N3Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683658480; x=1686250480;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHNoBY3JivORLUbcuDFr4/9tVoWO5VHbaNGCQaI5Uvo=;
        b=ZCbqMl2ajLRzCDPnfTvkjbcb4xDuMjSVu0Kdry22eW1N9FwzAfbCmucZTMPY6ibhQI
         VIMuLSUS2HKVS+xCNM+oLBIN76V5rb1o7YE3v31u+OnD0ynRB4ZkC2QD6DTPNkP0XGQ5
         RKI7WfsnbldPVRn4+/7PBpLlnMfFdAI1WxuUnJk+LN5k0hWRkUlSnpOsdtzrOhnJVc48
         RTlM62n1B6/2plarfsYSmRzs538bP9pek/Lr+ZzvDP4BI0jZGGylyoPgPMBpNucs9K0v
         NhJ7tKGb1PyksUwpwPO0a9haVWgjrqrLOWh17F68NGuIjQFFyzG70OizwgvDvq/L65zY
         gsmg==
X-Gm-Message-State: AC+VfDzRZ/aJpGAA2CyOgLy9R020Q8fReR0MCjWoIEwJyMSvYaBsqF3/
        iTwVtzOVOQwDcZIfcpa6icMrppDaNB0w
X-Google-Smtp-Source: ACHHUZ6vWI0X2IvACouQ+0IHlezp2Qp+H2rW0BUVF8tMyTzzTJ6S0TOnq6Tqjl1rmJLJ1rAE+VhfRd/K4Yyb
X-Received: from yuanchu.bej.corp.google.com ([2401:fa00:44:10:d495:1070:e926:f84a])
 (user=yuanchu job=sendgmr) by 2002:a25:5282:0:b0:ba6:3564:661a with SMTP id
 g124-20020a255282000000b00ba63564661amr310206ybb.13.1683658480303; Tue, 09
 May 2023 11:54:40 -0700 (PDT)
Date:   Wed, 10 May 2023 02:54:19 +0800
In-Reply-To: <20230509185419.1088297-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20230509185419.1088297-1-yuanchu@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230509185419.1088297-3-yuanchu@google.com>
Subject: [RFC PATCH 2/2] virtio-balloon: Add Working Set reporting
From:   Yuanchu Xie <yuanchu@google.com>
To:     David Hildenbrand <david@redhat.com>,
        "Sudarshan Rajagopalan (QUIC)" <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com
Cc:     SeongJae Park <sj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        talumbau <talumbau@google.com>, Yuanchu Xie <yuanchu@google.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: talumbau <talumbau@google.com>

 - Add WS and notification vqueues
 - Add simple interface to kernel WS functions
 - Driver receives config info and sends reports on notification
 - use mutex to guard virtio_balloon state

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 drivers/virtio/virtio_balloon.c     | 243 +++++++++++++++++++++++++++-
 include/linux/balloon_compaction.h  |   6 +
 include/uapi/linux/virtio_balloon.h |  21 +++
 mm/vmscan.c                         | 102 ++++++++++++
 4 files changed, 371 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 3f78a3a1eb75..edfa2a4960a3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -11,6 +11,7 @@
 #include <linux/swap.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/balloon_compaction.h>
@@ -39,12 +40,22 @@
 	(1 << (VIRTIO_BALLOON_HINT_BLOCK_ORDER + PAGE_SHIFT))
 #define VIRTIO_BALLOON_HINT_BLOCK_PAGES (1 << VIRTIO_BALLOON_HINT_BLOCK_ORDER)
 
+/* TODO: replace with a registration interface, similar to shrinker registration. */
+extern int register_wss_receiver(void *receiver, struct pglist_data *pgdat,
+				unsigned long *intervals, unsigned long nr_bins,
+				unsigned long report_threshold,
+				unsigned long refresh_threshold);
+extern void unregister_wss_receiver(void *receiver);
+extern bool working_set_request(struct pglist_data *pgdat);
+
 enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_INFLATE,
 	VIRTIO_BALLOON_VQ_DEFLATE,
 	VIRTIO_BALLOON_VQ_STATS,
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_REPORTING,
+	VIRTIO_BALLOON_VQ_WS,
+	VIRTIO_BALLOON_VQ_NOTIFY,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
@@ -54,7 +65,8 @@ enum virtio_balloon_config_read {
 
 struct virtio_balloon {
 	struct virtio_device *vdev;
-	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
+	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq,
+		*ws_vq, *notification_vq;
 
 	/* Balloon's own wq for cpu-intensive work items */
 	struct workqueue_struct *balloon_wq;
@@ -64,6 +76,8 @@ struct virtio_balloon {
 	/* The balloon servicing is delegated to a freezable workqueue. */
 	struct work_struct update_balloon_stats_work;
 	struct work_struct update_balloon_size_work;
+	struct work_struct update_balloon_ws_work;
+	struct work_struct update_balloon_notification_work;
 
 	/* Prevent updating balloon when it is being canceled. */
 	spinlock_t stop_update_lock;
@@ -110,6 +124,10 @@ struct virtio_balloon {
 	/* Memory statistics */
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
 
+	/* A buffer to hold incoming notification from the host. */
+	unsigned int notification_size;
+	void *notification_buf;
+
 	/* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HINT */
 	struct shrinker shrinker;
 
@@ -119,6 +137,10 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+	/* Working Set reporting */
+	u32 ws_num_bins;
+	struct virtio_balloon_ws *ws;
 };
 
 static const struct virtio_device_id id_table[] = {
@@ -301,6 +323,41 @@ static unsigned int leak_balloon(struct virtio_balloon *vb, size_t num)
 	return num_freed_pages;
 }
 
+/* Must hold the balloon_lock while calling this function. */
+static inline void reset_working_set(struct virtio_balloon *vb)
+{
+	int i;
+
+	for (i = 0; i < vb->ws_num_bins; ++i) {
+		vb->ws[i].tag = cpu_to_virtio16(vb->vdev, 0);
+		vb->ws[i].node_id = cpu_to_virtio16(vb->vdev, -1);
+		vb->ws[i].idle_age_ms = cpu_to_virtio64(vb->vdev, 0);
+		vb->ws[i].memory_size_bytes[0] = cpu_to_virtio64(vb->vdev, -1);
+		vb->ws[i].memory_size_bytes[1] = cpu_to_virtio64(vb->vdev, -1);
+	}
+}
+
+/* Must hold the balloon_lock while calling this function. */
+static inline void update_working_set(struct virtio_balloon *vb, int idx,
+			       u64 idle_age, u64 bytes_anon,
+			       u64 bytes_file)
+{
+	vb->ws[idx].tag = cpu_to_virtio16(vb->vdev, 0);
+	vb->ws[idx].node_id = cpu_to_virtio16(vb->vdev, -1);
+	vb->ws[idx].idle_age_ms = cpu_to_virtio64(vb->vdev, idle_age);
+	vb->ws[idx].memory_size_bytes[0] = cpu_to_virtio64(vb->vdev,
+	     bytes_anon);
+	vb->ws[idx].memory_size_bytes[1] = cpu_to_virtio64(vb->vdev,
+	     bytes_file);
+}
+
+static bool working_set_is_init(struct virtio_balloon *vb)
+{
+	if (vb->ws[0].idle_age_ms > 0)
+		return true;
+	return false;
+}
+
 static inline void update_stat(struct virtio_balloon *vb, int idx,
 			       u16 tag, u64 val)
 {
@@ -386,6 +443,16 @@ static void stats_handle_request(struct virtio_balloon *vb)
 	virtqueue_kick(vq);
 }
 
+static void notification_receive(struct virtqueue *vq)
+{
+	struct virtio_balloon *vb = vq->vdev->priv;
+
+	spin_lock(&vb->stop_update_lock);
+	if (!vb->stop_update)
+		queue_work(system_freezable_wq, &vb->update_balloon_notification_work);
+	spin_unlock(&vb->stop_update_lock);
+}
+
 static inline s64 towards_target(struct virtio_balloon *vb)
 {
 	s64 target;
@@ -465,6 +532,130 @@ static void update_balloon_stats_func(struct work_struct *work)
 	stats_handle_request(vb);
 }
 
+static int virtio_balloon_register_wss_receiver(struct virtio_balloon *vb,
+	__virtio64 *intervals, unsigned long nr_bins, __virtio64 refresh_ms,
+	__virtio64 report_ms)
+{
+	struct pglist_data *pgdat;
+	unsigned long *bin_intervals = NULL;
+	int i, err;
+
+	if (intervals && nr_bins) {
+		/* TODO: keep values as 32-bits throughout. */
+		bin_intervals = kzalloc(sizeof(unsigned long) * (nr_bins-1),
+			GFP_KERNEL);
+		for (i = 0; i < nr_bins - 1; i++)
+			bin_intervals[i] = (unsigned long)intervals[i];
+		pgdat = NODE_DATA(NUMA_NO_NODE);
+		err = register_wss_receiver(vb, pgdat, &(bin_intervals[0]),
+			nr_bins, (unsigned long) refresh_ms,
+			(unsigned long) report_ms);
+		kfree(bin_intervals);
+		return err;
+	}
+	return -EINVAL;
+}
+
+void working_set_notify(void *wss_receiver, struct wss_bin *bins)
+{
+	u64 bytes_nr_file, bytes_nr_anon;
+	struct virtio_balloon *vb = wss_receiver;
+	int idx = 0;
+
+	if (!mutex_trylock(&vb->balloon_lock))
+		return;
+	for (; idx < vb->ws_num_bins; idx++) {
+		bytes_nr_anon = (u64)(bins[idx].nr_pages[0]) * PAGE_SIZE;
+		bytes_nr_file = (u64)(bins[idx].nr_pages[1]) * PAGE_SIZE;
+		update_working_set(vb, idx, jiffies_to_msecs(bins[idx].idle_age),
+			bytes_nr_anon, bytes_nr_file);
+	}
+	mutex_unlock(&vb->balloon_lock);
+	/* Send the working set report to the device. */
+	spin_lock(&vb->stop_update_lock);
+	if (!vb->stop_update)
+		queue_work(system_freezable_wq, &vb->update_balloon_ws_work);
+	spin_unlock(&vb->stop_update_lock);
+}
+
+EXPORT_SYMBOL(working_set_notify);
+
+static void update_balloon_notification_func(struct work_struct *work)
+{
+	struct virtio_balloon *vb;
+	struct scatterlist sg_in;
+	struct pglist_data *pgdat;
+	__virtio64 *bin_intervals;
+	__virtio64 refresh_ms, report_ms;
+	int16_t tag;
+	char *buf;
+	int len;
+
+	vb = container_of(work, struct virtio_balloon,
+			  update_balloon_notification_work);
+
+	/* Read a Working Set notification from the device. */
+	buf = (char *)vb->notification_buf;
+	tag = *((int16_t *)buf);
+	buf += sizeof(int16_t);
+	if (tag == VIRTIO_BALLOON_WS_REQUEST) {
+		pgdat = NODE_DATA(NUMA_NO_NODE);
+		working_set_request(pgdat);
+	} else if (tag == VIRTIO_BALLOON_WS_CONFIG) {
+		mutex_lock(&vb->balloon_lock);
+		reset_working_set(vb);
+		mutex_unlock(&vb->balloon_lock);
+		bin_intervals = (__virtio64 *) buf;
+		buf += sizeof(__virtio64) * (vb->ws_num_bins - 1);
+		refresh_ms = *((__virtio64 *) buf);
+		buf += sizeof(__virtio64);
+		report_ms = *((__virtio64 *) buf);
+		virtio_balloon_register_wss_receiver(vb, bin_intervals, vb->ws_num_bins,
+			refresh_ms, report_ms);
+	} else {
+		dev_warn(&vb->vdev->dev, "Received invalid notification, %u\n", tag);
+		return;
+	}
+
+	/* Detach all the used buffers from the vq */
+	while (virtqueue_get_buf(vb->notification_vq, &len))
+		;
+	/* Add a new notification buffer for device to fill. */
+	sg_init_one(&sg_in, vb->notification_buf, vb->notification_size);
+	virtqueue_add_inbuf(vb->notification_vq, &sg_in, 1, vb, GFP_KERNEL);
+	virtqueue_kick(vb->notification_vq);
+}
+
+static void update_balloon_ws_func(struct work_struct *work)
+{
+	struct virtio_balloon *vb;
+	struct scatterlist sg_out;
+	int err = 0;
+	int unused;
+
+	vb = container_of(work, struct virtio_balloon,
+			  update_balloon_ws_work);
+
+	mutex_lock(&vb->balloon_lock);
+	if (working_set_is_init(vb)) {
+		/* Detach all the used buffers from the vq */
+		while (virtqueue_get_buf(vb->ws_vq, &unused))
+			;
+		sg_init_one(&sg_out, vb->ws, sizeof(struct virtio_balloon_ws) * vb->ws_num_bins);
+		err = virtqueue_add_outbuf(vb->ws_vq, &sg_out, 1, vb, GFP_KERNEL);
+	} else {
+		dev_warn(&vb->vdev->dev, "Working Set not initialized.");
+		err = -EINVAL;
+	}
+	mutex_unlock(&vb->balloon_lock);
+	if (unlikely(err)) {
+		dev_err(&vb->vdev->dev,
+			"Failed to send working set report err = %d\n", err);
+	} else {
+		virtqueue_kick(vb->ws_vq);
+	}
+}
+
 static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
@@ -508,6 +699,10 @@ static int init_vqs(struct virtio_balloon *vb)
 	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+	callbacks[VIRTIO_BALLOON_VQ_WS] = NULL;
+	names[VIRTIO_BALLOON_VQ_WS] = NULL;
+	callbacks[VIRTIO_BALLOON_VQ_NOTIFY] = NULL;
+	names[VIRTIO_BALLOON_VQ_NOTIFY] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
@@ -524,6 +719,13 @@ static int init_vqs(struct virtio_balloon *vb)
 		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		names[VIRTIO_BALLOON_VQ_WS] = "ws";
+		callbacks[VIRTIO_BALLOON_VQ_WS] = NULL;
+		names[VIRTIO_BALLOON_VQ_NOTIFY] = "notify";
+		callbacks[VIRTIO_BALLOON_VQ_NOTIFY] = notification_receive;
+	}
+
 	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
 			      callbacks, names, NULL);
 	if (err)
@@ -534,6 +736,7 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		struct scatterlist sg;
 		unsigned int num_stats;
+
 		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
 
 		/*
@@ -553,6 +756,23 @@ static int init_vqs(struct virtio_balloon *vb)
 		virtqueue_kick(vb->stats_vq);
 	}
 
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		struct scatterlist sg;
+
+		vb->ws_vq = vqs[VIRTIO_BALLOON_VQ_WS];
+		vb->notification_vq = vqs[VIRTIO_BALLOON_VQ_NOTIFY];
+
+		/* Prime the notification virtqueue for the device to fill.*/
+		sg_init_one(&sg, vb->notification_buf, vb->notification_size);
+		err = virtqueue_add_inbuf(vb->notification_vq, &sg, 1, vb, GFP_KERNEL);
+		if (unlikely(err)) {
+			dev_err(&vb->vdev->dev,
+				"Failed to prepare notifications, err = %d\n", err);
+		} else {
+			virtqueue_kick(vb->notification_vq);
+		}
+	}
+
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
 
@@ -878,6 +1098,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
 	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
+	INIT_WORK(&vb->update_balloon_ws_work, update_balloon_ws_func);
+	INIT_WORK(&vb->update_balloon_notification_work, update_balloon_notification_func);
 	spin_lock_init(&vb->stop_update_lock);
 	mutex_init(&vb->balloon_lock);
 	init_waitqueue_head(&vb->acked);
@@ -885,6 +1107,20 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	balloon_devinfo_init(&vb->vb_dev_info);
 
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		virtio_cread_le(vdev, struct virtio_balloon_config, ws_num_bins,
+				&vb->ws_num_bins);
+		/* Allocate space for a Working Set report. */
+		vb->ws = kcalloc(vb->ws_num_bins,
+				 sizeof(struct virtio_balloon_ws), GFP_KERNEL);
+		/* Allocate space for host notifications. */
+		vb->notification_size =
+			sizeof(uint16_t) +
+			sizeof(uint64_t) * (vb->ws_num_bins + 1);
+		vb->notification_buf = kzalloc(vb->notification_size, GFP_KERNEL);
+		reset_working_set(vb);
+	}
+
 	err = init_vqs(vb);
 	if (err)
 		goto out_free_vb;
@@ -1034,11 +1270,15 @@ static void virtballoon_remove(struct virtio_device *vdev)
 		unregister_oom_notifier(&vb->oom_nb);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING))
+		unregister_wss_receiver(vb);
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update = true;
 	spin_unlock_irq(&vb->stop_update_lock);
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);
+	cancel_work_sync(&vb->update_balloon_ws_work);
+	cancel_work_sync(&vb->update_balloon_notification_work);
 
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		cancel_work_sync(&vb->report_free_page_work);
@@ -1104,6 +1344,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_WS_REPORTING,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 5ca2d5699620..2cf4fca6e7f1 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -43,6 +43,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/list.h>
+#include <linux/mmzone.h>
 
 /*
  * Balloon device information descriptor.
@@ -67,6 +68,11 @@ extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				      struct list_head *pages);
 extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				     struct list_head *pages, size_t n_req_pages);
+/*
+ * Function to send the working set to a receiver (e.g. the balloon driver)
+ * TODO: Replace with a proper registration interface, similar to shrinkers.
+ */
+extern void working_set_notify(void *wss_receiver, struct wss_bin *bins);
 
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4..06d0683d8d8c 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_WS_REPORTING 6 /* Working Set Size reporting */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -59,6 +60,8 @@ struct virtio_balloon_config {
 	};
 	/* Stores PAGE_POISON if page poisoning is in use */
 	__le32 poison_val;
+	/* Number of bins for Working Set report if in use. */
+	__le32 ws_num_bins;
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
@@ -116,4 +119,22 @@ struct virtio_balloon_stat {
 	__virtio64 val;
 } __attribute__((packed));
 
+enum virtio_balloon_ws_op {
+	VIRTIO_BALLOON_WS_REQUEST = 1,
+	VIRTIO_BALLOON_WS_CONFIG = 2,
+};
+
+struct virtio_balloon_ws {
+#define VIRTIO_BALLOON_WS_RECLAIMABLE 0
+#define VIRTIO_BALLOON_WS_DISCARDABLE 1
+	/* TODO: Provide additional detail on memory, e.g. reclaimable. */
+	__virtio16 tag;
+	/* TODO: Support per-NUMA node reports. */
+	__virtio16 node_id;
+	uint8_t reserved[4];
+	__virtio64 idle_age_ms;
+	/* Track separately for ANON_AND_FILE. */
+	__virtio64 memory_size_bytes[2];
+};
+
 #endif /* _LINUX_VIRTIO_BALLOON_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b3adf924691c..ab343974de91 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -209,6 +209,8 @@ static void set_task_reclaim_state(struct task_struct *task,
 LIST_HEAD(shrinker_list);
 DECLARE_RWSEM(shrinker_rwsem);
 
+static void *wss_receiver;
+
 #ifdef CONFIG_MEMCG
 static int shrinker_nr_max;
 
@@ -621,6 +623,54 @@ static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
 	return size;
 }
 
+/*
+ * Register/unregister a receiver of wss notifications
+ * TODO: Replace with a proper registration interface, similar to shrinkers.
+ */
+int register_wss_receiver(void *receiver, struct pglist_data *pgdat,
+			unsigned long *intervals, unsigned long nr_bins,
+			unsigned long refresh_threshold,
+			unsigned long report_threshold)
+{
+	struct wss *wss;
+	struct wss_bin *bins;
+	int i;
+
+	wss_receiver = receiver;
+
+	if (!pgdat)
+		return 0;
+
+	if (!intervals || !nr_bins)
+		return 0;
+
+	bins = kzalloc(sizeof(wss->bins), GFP_KERNEL);
+	if (!bins)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_bins - 1; i++) {
+		bins[i].idle_age = msecs_to_jiffies(*intervals);
+		intervals++;
+	}
+	bins[i].idle_age = -1;
+
+	wss = lruvec_wss(mem_cgroup_lruvec(NULL, pgdat));
+
+	mutex_lock(&wss->bins_lock);
+	memcpy(wss->bins, bins, sizeof(wss->bins));
+	WRITE_ONCE(wss->refresh_threshold, msecs_to_jiffies(refresh_threshold));
+	WRITE_ONCE(wss->report_threshold, msecs_to_jiffies(report_threshold));
+	mutex_unlock(&wss->bins_lock);
+	return 0;
+}
+EXPORT_SYMBOL(register_wss_receiver);
+
+void unregister_wss_receiver(void *receiver)
+{
+	wss_receiver = NULL;
+}
+EXPORT_SYMBOL(unregister_wss_receiver);
+
 /*
  * Add a shrinker callback to be called from the vm.
  */
@@ -4606,6 +4656,12 @@ void report_wss(struct pglist_data *pgdat, struct scan_control *sc)
 	refresh_wss(wss, memcg, pgdat, sc, 0);
 	WRITE_ONCE(wss->timestamp, jiffies);
 
+	/* balloon driver subscribes to global memory reclaim */
+	if (!cgroup_reclaim(sc) && wss_receiver) {
+		pr_warn("Working Set Notify!");
+		working_set_notify(wss_receiver, wss->bins);
+	}
+
 	mutex_unlock(&wss->bins_lock);
 
 	if (wss->notifier)
@@ -4711,6 +4767,52 @@ void report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk *walk)
 	}
 }
 
+/* TODO: Replace with a proper registration interface, similar to shrinkers. */
+bool working_set_request(struct pglist_data *pgdat)
+{
+	unsigned int flags;
+	struct scan_control sc = {
+		.may_writepage = true,
+		.may_unmap = true,
+		.may_swap = true,
+		.reclaim_idx = MAX_NR_ZONES - 1,
+		.gfp_mask = GFP_KERNEL,
+	};
+	struct wss *wss;
+
+	if (!wss_receiver)
+		return false;
+
+	wss = lruvec_wss(mem_cgroup_lruvec(NULL, pgdat));
+
+	if (!mutex_trylock(&wss->bins_lock))
+		return false;
+
+	if (wss->bins->idle_age != -1) {
+		unsigned long timestamp = READ_ONCE(wss->timestamp);
+		unsigned long threshold = READ_ONCE(wss->refresh_threshold);
+
+		if (time_is_before_jiffies(timestamp + threshold)) {
+			// We might need to refresh the report.
+			set_task_reclaim_state(current, &sc.reclaim_state);
+			flags = memalloc_noreclaim_save();
+			refresh_wss(wss, NULL, pgdat, &sc, threshold);
+			memalloc_noreclaim_restore(flags);
+			set_task_reclaim_state(current, NULL);
+		}
+	}
+
+	if (wss_receiver) {
+		pr_warn("WS notify inside ws request\n");
+		working_set_notify(wss_receiver, wss->bins);
+	}
+
+	mutex_unlock(&wss->bins_lock);
+	return true;
+
+}
+EXPORT_SYMBOL(working_set_request);
+
 static struct pglist_data *kobj_to_pgdat(struct kobject *kobj)
 {
 	int nid = IS_ENABLED(CONFIG_NUMA) ? kobj_to_dev(kobj)->id :
-- 
2.40.1.521.gf1e218fcd8-goog

