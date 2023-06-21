Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABEC738E61
	for <lists+cgroups@lfdr.de>; Wed, 21 Jun 2023 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjFUSRU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 21 Jun 2023 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjFUSRR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 21 Jun 2023 14:17:17 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF2E198B
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:17:14 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-25c26394dc3so3778761a91.0
        for <cgroups@vger.kernel.org>; Wed, 21 Jun 2023 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687371434; x=1689963434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQEbqydm3aL8QCWI0JBHm0Z6aDHcaid/YGMOE1SbX2c=;
        b=PrCXSIfLnBmUtPYYUmkwE7KJpSUraf0vLrQ2op9siDUjsF/iFitSuaxbZsZzv7vceT
         agqOlwEx1ZgaHTJXqPJVw5v/Q9J0pJzHeQ7/eV/ZiJG1oHbMZTM/vO4crBHXbQmHdgej
         qGIqz6KtSnRtXDC3w9vqtnBVj/t6kzCgKkL2QmL8VXVOYtKIW5WJReUtIQWtc1D2VP8s
         wtcYva1qOl9J2ywR33pdi4ZWORX2IQiNbGuqANzecOj2iW7VtYdCVsCb5ZgwlzhnCUvm
         HTczbg559emgkr6xxtcTwEXFAU7yb6WiUwofa0nT4QVBR6JTvnQQBFn/kA/RukNC8Ti7
         JPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687371434; x=1689963434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nQEbqydm3aL8QCWI0JBHm0Z6aDHcaid/YGMOE1SbX2c=;
        b=YkGpd9MV3dmf/p6lnX1+/dDgVuuHO4CZJOw9V8R/PzmWtqTQTqKwxuOYvJPxcIMLQX
         dQTOQmzvnXAzJVaD/bkwjL+F1faODoMlblvWrIsEdrklZegk7cWXuCmVWyVFBKvVyMd2
         kD+nyLbGx7yTsPc1S5RqkMZoFY1q2KdKsIVZiuwu3vYWNFw6lOBUD6s162yL4gu2Lt6g
         /FmoZgsj1c+7g3gpCpaPdLqyuF4YMnvwg5u0NXyMcTuXCVgn8SWMTgghIP466sqodm0V
         ZJr5jHT3UdJuK49+Cp0dqsxblfAe/EwvFla0PWIKUAfRfHB+CVY+Vc7UxGBhYyBsuNTa
         DtkA==
X-Gm-Message-State: AC+VfDxe+LjI4qJJ0N4mm8SiixDYLtqiBl+oN5Wveuj5CEtHDUVPJmen
        6hLCxt89A/ns4dd98i9hEiGbb/cuLbQn
X-Google-Smtp-Source: ACHHUZ5avybGxYwQurVxh278QpCpu04jR6j16LlVEJJkFqphFbaFGeyLmKmuSefdUpU7U8JPfA/vVvUPLm8R
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:4024])
 (user=yuanchu job=sendgmr) by 2002:a17:90a:c7cb:b0:25e:8ed6:947a with SMTP id
 gf11-20020a17090ac7cb00b0025e8ed6947amr2668996pjb.2.1687371433953; Wed, 21
 Jun 2023 11:17:13 -0700 (PDT)
Date:   Wed, 21 Jun 2023 18:04:54 +0000
In-Reply-To: <20230621180454.973862-1-yuanchu@google.com>
Mime-Version: 1.0
References: <20230621180454.973862-1-yuanchu@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621180454.973862-7-yuanchu@google.com>
Subject: [RFC PATCH v2 6/6] virtio-balloon: Add Working Set reporting
From:   Yuanchu Xie <yuanchu@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kairui Song <kasong@tencent.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yuanchu Xie <yuanchu@google.com>,
        "T . J . Alumbaugh" <talumbau@google.com>
Cc:     Wei Xu <weixugc@google.com>, SeongJae Park <sj@kernel.org>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        kai.huang@intel.com, hch@lst.de, jon@nutanix.com,
        Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: "T.J. Alumbaugh" <talumbau@google.com>

Add working set and notification vqueues, along with a
simple interface to kernel WS functions. The driver receives
config info and sends reports on notification. A mutex is
used to guard virtio_balloon state.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 drivers/virtio/virtio_balloon.c     | 288 ++++++++++++++++++++++++++++
 include/linux/balloon_compaction.h  |   3 +
 include/linux/wsr.h                 |  29 ++-
 include/uapi/linux/virtio_balloon.h |  33 ++++
 mm/vmscan.c                         | 106 ++++++++++
 5 files changed, 457 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 3f78a3a1eb753..0cb6a46eb7e8a 100644
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
@@ -45,6 +46,8 @@ enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_STATS,
 	VIRTIO_BALLOON_VQ_FREE_PAGE,
 	VIRTIO_BALLOON_VQ_REPORTING,
+	VIRTIO_BALLOON_VQ_WORKING_SET,
+	VIRTIO_BALLOON_VQ_NOTIFY,
 	VIRTIO_BALLOON_VQ_MAX
 };
 
@@ -55,6 +58,9 @@ enum virtio_balloon_config_read {
 struct virtio_balloon {
 	struct virtio_device *vdev;
 	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
+#ifdef CONFIG_WSR
+	struct virtqueue *working_set_vq, *notification_vq;
+#endif
 
 	/* Balloon's own wq for cpu-intensive work items */
 	struct workqueue_struct *balloon_wq;
@@ -64,6 +70,10 @@ struct virtio_balloon {
 	/* The balloon servicing is delegated to a freezable workqueue. */
 	struct work_struct update_balloon_stats_work;
 	struct work_struct update_balloon_size_work;
+#ifdef CONFIG_WSR
+	struct work_struct update_balloon_working_set_work;
+	struct work_struct update_balloon_notification_work;
+#endif
 
 	/* Prevent updating balloon when it is being canceled. */
 	spinlock_t stop_update_lock;
@@ -119,6 +129,16 @@ struct virtio_balloon {
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
+
+#ifdef CONFIG_WSR
+	/* Working Set reporting */
+	u8 working_set_num_bins;
+	struct virtio_balloon_working_set *working_set;
+
+	/* A buffer to hold incoming notification from the host. */
+	unsigned int notification_size;
+	void *notification_buf;
+#endif
 };
 
 static const struct virtio_device_id id_table[] = {
@@ -465,6 +485,211 @@ static void update_balloon_stats_func(struct work_struct *work)
 	stats_handle_request(vb);
 }
 
+#ifdef CONFIG_WSR
+/* Must hold the balloon_lock while calling this function. */
+static inline void reset_working_set(struct virtio_balloon *vb)
+{
+	int i;
+
+	for (i = 0; i < vb->working_set_num_bins; ++i) {
+		vb->working_set[i].tag = cpu_to_virtio16(vb->vdev, -1);
+		vb->working_set[i].node_id = cpu_to_virtio16(vb->vdev, -1);
+		vb->working_set[i].idle_age_ms = cpu_to_virtio64(vb->vdev, 0);
+		vb->working_set[i].memory_size_bytes[0] = cpu_to_virtio64(vb->vdev, -1);
+		vb->working_set[i].memory_size_bytes[1] = cpu_to_virtio64(vb->vdev, -1);
+	}
+}
+
+/* Must hold the balloon_lock while calling this function. */
+static inline void update_working_set(struct virtio_balloon *vb, int idx,
+			       u64 idle_age, u64 bytes_anon,
+			       u64 bytes_file, int node_id)
+{
+	vb->working_set[idx].tag = cpu_to_virtio16(vb->vdev, VIRTIO_BALLOON_WS_RECLAIMABLE);
+	vb->working_set[idx].node_id = cpu_to_virtio16(vb->vdev, node_id);
+	vb->working_set[idx].idle_age_ms = cpu_to_virtio64(vb->vdev, idle_age);
+	vb->working_set[idx].memory_size_bytes[0] = cpu_to_virtio64(vb->vdev,
+	     bytes_anon);
+	vb->working_set[idx].memory_size_bytes[1] = cpu_to_virtio64(vb->vdev,
+	     bytes_file);
+}
+
+static bool working_set_is_init(struct virtio_balloon *vb)
+{
+	if (vb->working_set[0].idle_age_ms > 0)
+		return true;
+	return false;
+}
+
+static void virtio_balloon_working_set_request(void)
+{
+	struct pglist_data *pgdat;
+	int nid = NUMA_NO_NODE;
+
+	if (IS_ENABLED(CONFIG_NUMA)) {
+		for_each_online_node(nid) {
+			if (node_possible(nid)) {
+				pgdat = NODE_DATA(nid);
+				working_set_request(pgdat);
+			}
+		}
+	} else {
+		pgdat = NODE_DATA(nid);
+		working_set_request(pgdat);
+	}
+}
+
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
+static int virtio_balloon_register_working_set_receiver(struct virtio_balloon *vb,
+	__virtio64 *intervals, unsigned long nr_bins, __virtio64 refresh_ms,
+	__virtio64 report_ms)
+{
+	struct pglist_data *pgdat;
+	unsigned long *bin_intervals = NULL;
+	int i, err;
+	int nid = NUMA_NO_NODE;
+
+	if (intervals && nr_bins) {
+		/* TODO: keep values as 32-bits throughout. */
+		bin_intervals = kzalloc(sizeof(unsigned long) * (nr_bins-1),
+			GFP_KERNEL);
+		for (i = 0; i < nr_bins - 1; i++)
+			bin_intervals[i] = (unsigned long)intervals[i];
+
+		if (IS_ENABLED(CONFIG_NUMA)) {
+			for_each_online_node(nid) {
+				if (node_possible(nid)) {
+					pgdat = NODE_DATA(nid);
+					err = register_working_set_receiver(vb,
+						pgdat, &(bin_intervals[0]),
+						nr_bins, (unsigned long) refresh_ms,
+						(unsigned long) report_ms);
+				}
+			}
+		} else {
+			pgdat = NODE_DATA(nid);
+			err = register_working_set_receiver(vb, pgdat,
+				&(bin_intervals[0]), nr_bins,
+				(unsigned long) refresh_ms,
+				(unsigned long) report_ms);
+		}
+		kfree(bin_intervals);
+		return err;
+	}
+	return -EINVAL;
+}
+
+void working_set_notify(void *ws_receiver, struct ws_bin *bins, int node_id)
+{
+	u64 bytes_nr_file, bytes_nr_anon;
+	struct virtio_balloon *vb = ws_receiver;
+	int idx = 0;
+
+	if (!mutex_trylock(&vb->balloon_lock))
+		return;
+	for (; idx < vb->working_set_num_bins; idx++) {
+		bytes_nr_anon = (u64)(bins[idx].nr_pages[0]) * PAGE_SIZE;
+		bytes_nr_file = (u64)(bins[idx].nr_pages[1]) * PAGE_SIZE;
+		update_working_set(vb, idx, jiffies_to_msecs(bins[idx].idle_age),
+			bytes_nr_anon, bytes_nr_file, node_id);
+	}
+	mutex_unlock(&vb->balloon_lock);
+	/* Send the working set report to the device. */
+	spin_lock(&vb->stop_update_lock);
+	if (!vb->stop_update)
+		queue_work(system_freezable_wq, &vb->update_balloon_working_set_work);
+	spin_unlock(&vb->stop_update_lock);
+}
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
+		virtio_balloon_working_set_request();
+	} else if (tag == VIRTIO_BALLOON_WS_CONFIG) {
+		mutex_lock(&vb->balloon_lock);
+		reset_working_set(vb);
+		mutex_unlock(&vb->balloon_lock);
+		bin_intervals = (__virtio64 *) buf;
+		buf += sizeof(__virtio64) * (vb->working_set_num_bins - 1);
+		refresh_ms = *((__virtio64 *) buf);
+		buf += sizeof(__virtio64);
+		report_ms = *((__virtio64 *) buf);
+		virtio_balloon_register_working_set_receiver(vb, bin_intervals,
+			vb->working_set_num_bins, refresh_ms, report_ms);
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
+			  update_balloon_working_set_work);
+
+	mutex_lock(&vb->balloon_lock);
+	if (working_set_is_init(vb)) {
+		/* Detach all the used buffers from the vq */
+		while (virtqueue_get_buf(vb->working_set_vq, &unused))
+			;
+		sg_init_one(&sg_out, vb->working_set,
+			(sizeof(struct virtio_balloon_working_set) *
+			vb->working_set_num_bins));
+		err = virtqueue_add_outbuf(vb->working_set_vq, &sg_out, 1, vb, GFP_KERNEL);
+	} else {
+		dev_warn(&vb->vdev->dev, "Working Set not initialized.");
+		err = -EINVAL;
+	}
+	mutex_unlock(&vb->balloon_lock);
+	if (unlikely(err)) {
+		dev_err(&vb->vdev->dev,
+			"Failed to send working set report err = %d\n", err);
+	} else {
+		virtqueue_kick(vb->working_set_vq);
+	}
+}
+#endif /* CONFIG_WSR */
+
 static void update_balloon_size_func(struct work_struct *work)
 {
 	struct virtio_balloon *vb;
@@ -508,6 +733,10 @@ static int init_vqs(struct virtio_balloon *vb)
 	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
+	callbacks[VIRTIO_BALLOON_VQ_WORKING_SET] = NULL;
+	names[VIRTIO_BALLOON_VQ_WORKING_SET] = NULL;
+	callbacks[VIRTIO_BALLOON_VQ_NOTIFY] = NULL;
+	names[VIRTIO_BALLOON_VQ_NOTIFY] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
@@ -524,6 +753,15 @@ static int init_vqs(struct virtio_balloon *vb)
 		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;
 	}
 
+#ifdef CONFIG_WSR
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		names[VIRTIO_BALLOON_VQ_WORKING_SET] = "ws";
+		callbacks[VIRTIO_BALLOON_VQ_WORKING_SET] = NULL;
+		names[VIRTIO_BALLOON_VQ_NOTIFY] = "notify";
+		callbacks[VIRTIO_BALLOON_VQ_NOTIFY] = notification_receive;
+	}
+#endif
+
 	err = virtio_find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX, vqs,
 			      callbacks, names, NULL);
 	if (err)
@@ -534,6 +772,7 @@ static int init_vqs(struct virtio_balloon *vb)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		struct scatterlist sg;
 		unsigned int num_stats;
+
 		vb->stats_vq = vqs[VIRTIO_BALLOON_VQ_STATS];
 
 		/*
@@ -553,6 +792,25 @@ static int init_vqs(struct virtio_balloon *vb)
 		virtqueue_kick(vb->stats_vq);
 	}
 
+#ifdef CONFIG_WSR
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		struct scatterlist sg;
+
+		vb->working_set_vq = vqs[VIRTIO_BALLOON_VQ_WORKING_SET];
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
+#endif
+
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
 
@@ -878,6 +1136,10 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
 	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
+#ifdef CONFIG_WSR
+	INIT_WORK(&vb->update_balloon_working_set_work, update_balloon_ws_func);
+	INIT_WORK(&vb->update_balloon_notification_work, update_balloon_notification_func);
+#endif
 	spin_lock_init(&vb->stop_update_lock);
 	mutex_init(&vb->balloon_lock);
 	init_waitqueue_head(&vb->acked);
@@ -885,6 +1147,23 @@ static int virtballoon_probe(struct virtio_device *vdev)
 
 	balloon_devinfo_init(&vb->vb_dev_info);
 
+#ifdef CONFIG_WSR
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_WS_REPORTING)) {
+		virtio_cread_le(vdev, struct virtio_balloon_config, working_set_num_bins,
+				&vb->working_set_num_bins);
+		dev_err(&vb->vdev->dev, "in probe , num bins: %d ", vb->working_set_num_bins);
+		/* Allocate space for a Working Set report. */
+		vb->working_set = kcalloc(vb->working_set_num_bins,
+				 sizeof(struct virtio_balloon_working_set), GFP_KERNEL);
+		/* Allocate space for host notifications. */
+		vb->notification_size =
+			sizeof(uint16_t) +
+			sizeof(uint64_t) * (vb->working_set_num_bins + 1);
+		vb->notification_buf = kzalloc(vb->notification_size, GFP_KERNEL);
+		reset_working_set(vb);
+	}
+#endif
+
 	err = init_vqs(vb);
 	if (err)
 		goto out_free_vb;
@@ -1034,11 +1313,19 @@ static void virtballoon_remove(struct virtio_device *vdev)
 		unregister_oom_notifier(&vb->oom_nb);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
+#ifdef CONFIG_WSR
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_WS_REPORTING))
+		unregister_working_set_receiver(vb);
+#endif
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update = true;
 	spin_unlock_irq(&vb->stop_update_lock);
 	cancel_work_sync(&vb->update_balloon_size_work);
 	cancel_work_sync(&vb->update_balloon_stats_work);
+#ifdef CONFIG_WSR
+	cancel_work_sync(&vb->update_balloon_working_set_work);
+	cancel_work_sync(&vb->update_balloon_notification_work);
+#endif
 
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		cancel_work_sync(&vb->report_free_page_work);
@@ -1104,6 +1391,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_WS_REPORTING,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 5ca2d56996201..7bbf5281d84d3 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -43,6 +43,7 @@
 #include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/list.h>
+#include <linux/mmzone.h>
 
 /*
  * Balloon device information descriptor.
@@ -67,6 +68,8 @@ extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
 				      struct list_head *pages);
 extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
 				     struct list_head *pages, size_t n_req_pages);
+extern void working_set_notify(void *ws_receiver, struct ws_bin *bins,
+			       int node_id);
 
 static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 {
diff --git a/include/linux/wsr.h b/include/linux/wsr.h
index 68246734679cd..671ca5426254d 100644
--- a/include/linux/wsr.h
+++ b/include/linux/wsr.h
@@ -53,6 +53,16 @@ void wsr_refresh(struct wsr *wsr, struct mem_cgroup *root,
 		 struct pglist_data *pgdat);
 void report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk *walk);
 void report_ws(struct pglist_data *pgdat, struct scan_control *sc);
+/*
+ * Function to send the working set report to a receiver (e.g. the balloon driver)
+ * TODO: Replace with a proper registration interface, similar to shrinkers.
+ */
+int register_working_set_receiver(void *receiver, struct pglist_data *pgdat,
+				unsigned long *intervals, unsigned long nr_bins,
+				unsigned long report_threshold,
+				unsigned long refresh_threshold);
+void unregister_working_set_receiver(void *receiver);
+bool working_set_request(struct pglist_data *pgdat);
 #else
 struct ws_bin;
 struct wsr;
@@ -84,6 +94,21 @@ static inline void report_reaccess(struct lruvec *lruvec, struct lru_gen_mm_walk
 static inline void report_ws(struct pglist_data *pgdat, struct scan_control *sc)
 {
 }
-#endif	/* CONFIG_WSR */
+static inline int
+register_working_set_receiver(void *receiver, struct pglist_data *pgdat,
+			      unsigned long *intervals, unsigned long nr_bins,
+			      unsigned long report_threshold,
+			      unsigned long refresh_threshold)
+{
+	return -EINVAL;
+}
+static inline void unregister_working_set_receiver(void *receiver)
+{
+}
+static inline bool working_set_request(struct pglist_data *pgdat)
+{
+	return false;
+}
+#endif /* CONFIG_WSR */
 
-#endif	/* _LINUX_WSR_H */
+#endif /* _LINUX_WSR_H */
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ddaa45e723c4c..a682d917daca1 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_WS_REPORTING 6 /* Working Set Size reporting */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -59,6 +60,9 @@ struct virtio_balloon_config {
 	};
 	/* Stores PAGE_POISON if page poisoning is in use */
 	__le32 poison_val;
+	/* Number of bins for Working Set report if in use. */
+	__u8 working_set_num_bins;
+	__u8 padding[3];
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
@@ -116,4 +120,33 @@ struct virtio_balloon_stat {
 	__virtio64 val;
 } __attribute__((packed));
 
+/* Enumerate all possible message types from the device. */
+enum virtio_balloon_working_set_op {
+	VIRTIO_BALLOON_WS_REQUEST = 1,
+	VIRTIO_BALLOON_WS_CONFIG = 2,
+};
+
+/* The metadata values for Working Set Reports. */
+enum virtio_balloon_working_set_tags {
+	/* Memory is reclaimable by guest */
+	VIRTIO_BALLOON_WS_RECLAIMABLE = 0,
+	/* Memory can only be discarded by guest */
+	VIRTIO_BALLOON_WS_DISCARDABLE = 1,
+};
+
+/*
+ * Working Set Report structure.
+ */
+struct virtio_balloon_working_set {
+	/* A tag for additional metadata. */
+	__le16 tag;
+	/* the NUMA node for this report. */
+	__le16 node_id;
+	uint8_t reserved[4];
+	/* The idle age (in ms) of this bin of memory */
+	__virtio64 idle_age_ms;
+	/* A bin each for anonymous and file-backed memory. */
+	__le64 memory_size_bytes[2];
+};
+
 #endif /* _LINUX_VIRTIO_BALLOON_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index bc8c026ceef0d..c89728f8f61ba 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5911,6 +5911,57 @@ late_initcall(init_lru_gen);
  ******************************************************************************/
 
 #ifdef CONFIG_WSR
+static void *wsr_receiver;
+
+/*
+ * Register/unregister a receiver of working set notifications
+ * TODO: Replace with a proper registration interface, similar to shrinkers.
+ */
+int register_working_set_receiver(void *receiver, struct pglist_data *pgdat,
+				  unsigned long *intervals,
+				  unsigned long nr_bins,
+				  unsigned long refresh_threshold,
+				  unsigned long report_threshold)
+{
+	struct wsr *wsr;
+	struct ws_bin *bins;
+	int i;
+
+	wsr_receiver = receiver;
+
+	if (!pgdat)
+		return 0;
+
+	if (!intervals || !nr_bins)
+		return 0;
+
+	bins = kzalloc(sizeof(wsr->bins), GFP_KERNEL);
+	if (!bins)
+		return -ENOMEM;
+
+	for (i = 0; i < nr_bins - 1; i++) {
+		bins[i].idle_age = msecs_to_jiffies(*intervals);
+		intervals++;
+	}
+	bins[i].idle_age = -1;
+
+	wsr = lruvec_wsr(mem_cgroup_lruvec(NULL, pgdat));
+
+	mutex_lock(&wsr->bins_lock);
+	memcpy(wsr->bins, bins, sizeof(wsr->bins));
+	WRITE_ONCE(wsr->refresh_threshold, msecs_to_jiffies(refresh_threshold));
+	WRITE_ONCE(wsr->report_threshold, msecs_to_jiffies(report_threshold));
+	mutex_unlock(&wsr->bins_lock);
+	return 0;
+}
+EXPORT_SYMBOL(register_working_set_receiver);
+
+void unregister_working_set_receiver(void *receiver)
+{
+	wsr_receiver = NULL;
+}
+EXPORT_SYMBOL(unregister_working_set_receiver);
+
 void wsr_refresh(struct wsr *wsr, struct mem_cgroup *root,
 		 struct pglist_data *pgdat)
 {
@@ -5967,6 +6018,16 @@ void report_ws(struct pglist_data *pgdat, struct scan_control *sc)
 	refresh_wsr(wsr, memcg, pgdat, sc, 0);
 	WRITE_ONCE(wsr->timestamp, jiffies);
 
+	/* Balloon driver subscribes to global memory reclaim.
+	 * This requires CONFIG_VIRTIO_BALLOON=y, not m, because
+	 * it's calling a function defined in virtio_balloon.c.
+	 * This is a hack to have balloon notifications work in a
+	 * proof of concept, and aproper notification registration
+	 * interface is on the TODO list.
+	 */
+	if (!cgroup_reclaim(sc) && wsr_receiver)
+		working_set_notify(wsr_receiver, wsr->bins, pgdat->node_id);
+
 	mutex_unlock(&wsr->bins_lock);
 
 	if (wsr->notifier)
@@ -5974,6 +6035,51 @@ void report_ws(struct pglist_data *pgdat, struct scan_control *sc)
 	if (memcg && cmpxchg(&memcg->wsr_event, 0, 1) == 0)
 		wake_up_interruptible(&memcg->wsr_wait_queue);
 }
+
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
+	struct wsr *wsr;
+
+	if (!wsr_receiver)
+		return false;
+
+	wsr = lruvec_wsr(mem_cgroup_lruvec(NULL, pgdat));
+
+	if (!mutex_trylock(&wsr->bins_lock))
+		return false;
+
+	if (wsr->bins->idle_age != -1) {
+		unsigned long timestamp = READ_ONCE(wsr->timestamp);
+		unsigned long threshold = READ_ONCE(wsr->refresh_threshold);
+
+		if (time_is_before_jiffies(timestamp + threshold)) {
+			// We might need to refresh the report.
+			set_task_reclaim_state(current, &sc.reclaim_state);
+			flags = memalloc_noreclaim_save();
+			refresh_wsr(wsr, NULL, pgdat, &sc, threshold);
+			memalloc_noreclaim_restore(flags);
+			set_task_reclaim_state(current, NULL);
+		}
+	}
+
+	if (wsr_receiver)
+		working_set_notify(wsr_receiver, wsr->bins, pgdat->node_id);
+
+	mutex_unlock(&wsr->bins_lock);
+	return true;
+
+}
+EXPORT_SYMBOL(working_set_request);
+
 #endif /* CONFIG_WSR */
 
 #else /* !CONFIG_LRU_GEN */
-- 
2.41.0.162.gfafddb0af9-goog

