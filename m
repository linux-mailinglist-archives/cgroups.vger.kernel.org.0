Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C9D678605
	for <lists+cgroups@lfdr.de>; Mon, 23 Jan 2023 20:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjAWTSP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 Jan 2023 14:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjAWTSF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 Jan 2023 14:18:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9883AD510
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 11:18:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k15-20020a5b0a0f000000b007eba3f8e3baso13944157ybq.4
        for <cgroups@vger.kernel.org>; Mon, 23 Jan 2023 11:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9WOZzSEfhu/PT9TWBWMQDCCNsrofWV34oFDU/0sj1mQ=;
        b=CLJ2JxK/Tm4oa2T67r1/7AoCewa4cPoaCpXx/gVHbZ1m+FYlbdBISpcie92wke9qiT
         ywnZGTRRWgUyvtV2GeIN6CSF1A1BpACoPsOvCJSqkdka36IG7lwA9jHJB0/1Y37BiDn6
         UZyz4QR44eh7OHGKOjLnRuXG7qELlMRlfRNYaxnDlTMYAnQZZAKF7GLGFraikV5q7pPa
         PqEGE55YfXGgQoOaL42PCJmSLM5OLIrr2pXTamoSK+ZBJQZ3xablgI1e6ZxykShX+C1V
         OGCeujU9/+VSQurUIb0N4LKyFw0PX0Xvt3l2bOlWDy6qNiZqzVXsJcA5m/zeCrF4rUUR
         ohNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9WOZzSEfhu/PT9TWBWMQDCCNsrofWV34oFDU/0sj1mQ=;
        b=JhLiXZD4yJdO6KPSd87MaVYW1iMo7YrQSczGIJVgwMgoImoLYHP1Ysf76KXv0CvGIL
         G7nl2VwoNWg6gnqB3mzUlbysE88PJh8gqHbF9kDIakCGaIRsrRoFYDJLrHXEC6q+k7Rt
         rPvdEtojwwiANnYkep47o3gkdxuBSg3gHuLuWg2uyMdtLDqDAysru/6RzAFU49GaWZGi
         fl/HCfkiALpG+MfBslJn0Iwn9z2CQatt++ax3QLpG+enFEfSClmIQZyH7KVtZxR7pfCP
         ieIZQx1WZlrULRrtCoa0JXroriuSEZ/XcWaNLyTRtPrhIJr1Tk/YTo+dlq5DXCnE8WYo
         gLig==
X-Gm-Message-State: AFqh2kpMDqu5PX/jSqegKaO14qjyGHyPZTSkfOLhCwFefwLPcm5gJ6tv
        Bt4EHT2h4RVk/OBmbmDW5PFm+4sde8UWHes=
X-Google-Smtp-Source: AMrXdXt5UsJV8XnGROzCqwUjMEtxGJTY0AAa2SUnm4rAwiP8wDQKiwcGvs1ceYITQIG6UCVtpU2h3/VNxLbuwi8=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a25:dc92:0:b0:7b0:3379:9c00 with SMTP id
 y140-20020a25dc92000000b007b033799c00mr3149691ybe.359.1674501483256; Mon, 23
 Jan 2023 11:18:03 -0800 (PST)
Date:   Mon, 23 Jan 2023 19:17:24 +0000
In-Reply-To: <20230123191728.2928839-1-tjmercier@google.com>
Mime-Version: 1.0
References: <20230123191728.2928839-1-tjmercier@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230123191728.2928839-3-tjmercier@google.com>
Subject: [PATCH v2 2/4] dmabuf: Add cgroup charge transfer function
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc:     hannes@cmpxchg.org, daniel.vetter@ffwll.ch, android-mm@google.com,
        jstultz@google.com, jeffv@google.com, cmllamas@google.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        cgroups@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The dma_buf_transfer_charge function provides a way for processes to
transfer charge of a buffer to a different cgroup. This is essential
for the cases where a central allocator process does allocations for
various subsystems, hands over the fd to the client who requested the
memory, and drops all references to the allocated memory.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 drivers/dma-buf/dma-buf.c  | 56 ++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h    |  1 +
 include/linux/memcontrol.h |  5 ++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index a6a8cb5cb32d..ac3d02a7ecf8 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -11,6 +11,7 @@
  * refining of this idea.
  */
 
+#include <linux/atomic.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/dma-buf.h>
@@ -1626,6 +1627,61 @@ void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap_unlocked, DMA_BUF);
 
+/**
+ * dma_buf_transfer_charge - Change the cgroup to which the provided dma_buf is charged.
+ * @dmabuf_file:	[in]	file for buffer whose charge will be migrated to a different cgroup
+ * @target:		[in]	the task_struct of the destination process for the cgroup charge
+ *
+ * Only tasks that belong to the same cgroup the buffer is currently charged to
+ * may call this function, otherwise it will return -EPERM.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int dma_buf_transfer_charge(struct file *dmabuf_file, struct task_struct *target)
+{
+	struct mem_cgroup *current_cg, *target_cg;
+	struct dma_buf *dmabuf;
+	unsigned int nr_pages;
+	int ret = 0;
+
+	if (!IS_ENABLED(CONFIG_MEMCG))
+		return 0;
+
+	if (WARN_ON(!dmabuf_file) || WARN_ON(!target))
+		return -EINVAL;
+
+	if (!is_dma_buf_file(dmabuf_file))
+		return -EBADF;
+	dmabuf = dmabuf_file->private_data;
+
+	nr_pages = PAGE_ALIGN(dmabuf->size) / PAGE_SIZE;
+	current_cg = mem_cgroup_from_task(current);
+	target_cg = get_mem_cgroup_from_mm(target->mm);
+
+	if (current_cg == target_cg)
+		goto skip_transfer;
+
+	if (!mem_cgroup_charge_dmabuf(target_cg, nr_pages, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto skip_transfer;
+	}
+
+	if (cmpxchg(&dmabuf->memcg, current_cg, target_cg) != current_cg) {
+		/* Only the current owner can transfer the charge */
+		ret = -EPERM;
+		mem_cgroup_uncharge_dmabuf(target_cg, nr_pages);
+		goto skip_transfer;
+	}
+
+	mem_cgroup_uncharge_dmabuf(current_cg, nr_pages);
+	mem_cgroup_put(current_cg); /* unref from buffer - buffer keeps new ref to target_cg */
+	return 0;
+
+skip_transfer:
+	mem_cgroup_put(target_cg);
+	return ret;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 1f0ffb8e4bf5..f25eb8e60fb2 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -634,4 +634,5 @@ int dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map);
 void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map);
 int dma_buf_vmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
 void dma_buf_vunmap_unlocked(struct dma_buf *dmabuf, struct iosys_map *map);
+int dma_buf_transfer_charge(struct file *dmabuf_file, struct task_struct *target);
 #endif /* __DMA_BUF_H__ */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c10b8565fdbf..009298a446fe 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1335,6 +1335,11 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
 	return NULL;
 }
 
+static inline struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
+{
+	return NULL;
+}
+
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
 }
-- 
2.39.0.246.g2a6d74b583-goog

