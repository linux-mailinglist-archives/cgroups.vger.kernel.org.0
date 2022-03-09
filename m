Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502174D367E
	for <lists+cgroups@lfdr.de>; Wed,  9 Mar 2022 18:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbiCIRFe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Mar 2022 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiCIREP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Mar 2022 12:04:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D5819E028
        for <cgroups@vger.kernel.org>; Wed,  9 Mar 2022 08:53:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o133-20020a25738b000000b0062872621d0eso2154473ybc.2
        for <cgroups@vger.kernel.org>; Wed, 09 Mar 2022 08:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=lhHGzZoREQNnf55wN1HaeVUD3hjLL00JJ5cetBP+eaQ=;
        b=gKIbC0k/5p+fyNlConlMN+xPe/ebk8ebvd/uWg6T6vooL8MMIfva9qwy7Lpdbivqq7
         oJoIgx2KDTrB7PC2LXU6JYkOQgHlH1J78wsI/1CybgkEOgCETFPbvTPvvBZjF3KtEYrW
         804ENocSNg1iNY0zuUQhjo4BolEmxZkdv9JShsHPaP3w6yigklJE9Q9l+xaJDLCwR09A
         4DGED7VchRj5zoSQ42M5Way/Ra/0h5dn8HeEz5ZQ9KAEmdn2oNLN4RDfrLj7Imh7317M
         J7FgGxhT0IWthtTIVaNXYJbTS5HECV7f+G560rkLLiA/e5xw92yjAG61zMDzxkzWjfrM
         JpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=lhHGzZoREQNnf55wN1HaeVUD3hjLL00JJ5cetBP+eaQ=;
        b=68ij4LNw8qY9Yv+t2nEOuFCy9tc+HoFp2XwDvf92v9bFqVUGCmlUL1crDB27MGCstv
         mRGuKOQedPmc8ESpggnGoNwuLf53CksG3KFOvr/W1wEkgpAhMtGdwlH22+AxdM6sfyGe
         mXGJLMNFB41YSoiPUNVpOznNqEEiqkEhc5xBHtRzwqZEwGuwa7ulynKOe286EBoAjMDx
         DpC/Tm2peqWejNoL7rxy6zxGJxNmbvGJcYjJPYHNiSTEih7dUWbyn3X6zhkMDEOxdWR4
         LH4i5qCcle6dXwJF9Bfaw8ER/8x9mPwcLOfBxCpc2XoMHzNwq5v+YvnOR7FXKydCLiYZ
         nGEA==
X-Gm-Message-State: AOAM533Jzliu1mUSCCuucw0lR/2jnExvr9d4sYhmaosNYV/u+Jbcym15
        tiTzUum7oNqu1DhbTA3gPXE9wW6J61N1A08=
X-Google-Smtp-Source: ABdhPJwK4yKwsDlaoEUAS3Vm5fm7rENo1CQsEFqudzHVLPT45CzkuU3D+7W8hxwy+2V9Wem//6DQfWjRXmIBTMk=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a05:6902:1541:b0:628:a0ed:ad49 with SMTP
 id r1-20020a056902154100b00628a0edad49mr513167ybu.419.1646844765074; Wed, 09
 Mar 2022 08:52:45 -0800 (PST)
Date:   Wed,  9 Mar 2022 16:52:14 +0000
In-Reply-To: <20220309165222.2843651-1-tjmercier@google.com>
Message-Id: <20220309165222.2843651-5-tjmercier@google.com>
Mime-Version: 1.0
References: <20220309165222.2843651-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [RFC v3 4/8] dmabuf: heaps: export system_heap buffers with GPU
 cgroup charging
From:   "T.J. Mercier" <tjmercier@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com,
        "T.J. Mercier" <tjmercier@google.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

All DMA heaps now register a new GPU cgroup device upon creation, and the
system_heap now exports buffers associated with its GPU cgroup device for
tracking purposes.

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v3 changes
Use more common dual author commit message format per John Stultz.

v2 changes
Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.
---
 drivers/dma-buf/dma-heap.c          | 27 +++++++++++++++++++++++++++
 drivers/dma-buf/heaps/system_heap.c |  3 +++
 include/linux/dma-heap.h            | 11 +++++++++++
 3 files changed, 41 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index 8f5848aa144f..885072427775 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/cdev.h>
+#include <linux/cgroup_gpu.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
@@ -31,6 +32,7 @@
  * @heap_devt		heap device node
  * @list		list head connecting to list of heaps
  * @heap_cdev		heap char device
+ * @gpucg_dev		gpu cgroup device for memory accounting
  *
  * Represents a heap of memory from which buffers can be made.
  */
@@ -41,6 +43,9 @@ struct dma_heap {
 	dev_t heap_devt;
 	struct list_head list;
 	struct cdev heap_cdev;
+#ifdef CONFIG_CGROUP_GPU
+	struct gpucg_device gpucg_dev;
+#endif
 };
=20
 static LIST_HEAD(heap_list);
@@ -216,6 +221,26 @@ const char *dma_heap_get_name(struct dma_heap *heap)
 	return heap->name;
 }
=20
+#ifdef CONFIG_CGROUP_GPU
+/**
+ * dma_heap_get_gpucg_dev() - get struct gpucg_device for the heap.
+ * @heap: DMA-Heap to get the gpucg_device struct for.
+ *
+ * Returns:
+ * The gpucg_device struct for the heap. NULL if the GPU cgroup controller=
 is
+ * not enabled.
+ */
+struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
+{
+	return &heap->gpucg_dev;
+}
+#else /* CONFIG_CGROUP_GPU */
+struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap)
+{
+	return NULL;
+}
+#endif /* CONFIG_CGROUP_GPU */
+
 struct dma_heap *dma_heap_add(const struct dma_heap_export_info *exp_info)
 {
 	struct dma_heap *heap, *h, *err_ret;
@@ -288,6 +313,8 @@ struct dma_heap *dma_heap_add(const struct dma_heap_exp=
ort_info *exp_info)
 	list_add(&heap->list, &heap_list);
 	mutex_unlock(&heap_list_lock);
=20
+	gpucg_register_device(dma_heap_get_gpucg_dev(heap), exp_info->name);
+
 	return heap;
=20
 err2:
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/sy=
stem_heap.c
index ab7fd896d2c4..752a05c3cfe2 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -395,6 +395,9 @@ static struct dma_buf *system_heap_allocate(struct dma_=
heap *heap,
 	exp_info.ops =3D &system_heap_buf_ops;
 	exp_info.size =3D buffer->len;
 	exp_info.flags =3D fd_flags;
+#ifdef CONFIG_CGROUP_GPU
+	exp_info.gpucg_dev =3D dma_heap_get_gpucg_dev(heap);
+#endif
 	exp_info.priv =3D buffer;
 	dmabuf =3D dma_buf_export(&exp_info);
 	if (IS_ERR(dmabuf)) {
diff --git a/include/linux/dma-heap.h b/include/linux/dma-heap.h
index 0c05561cad6e..e447a61d054e 100644
--- a/include/linux/dma-heap.h
+++ b/include/linux/dma-heap.h
@@ -10,6 +10,7 @@
 #define _DMA_HEAPS_H
=20
 #include <linux/cdev.h>
+#include <linux/cgroup_gpu.h>
 #include <linux/types.h>
=20
 struct dma_heap;
@@ -59,6 +60,16 @@ void *dma_heap_get_drvdata(struct dma_heap *heap);
  */
 const char *dma_heap_get_name(struct dma_heap *heap);
=20
+/**
+ * dma_heap_get_gpucg_dev() - get a pointer to the struct gpucg_device for=
 the
+ * heap.
+ * @heap: DMA-Heap to retrieve gpucg_device for.
+ *
+ * Returns:
+ * The gpucg_device struct for the heap.
+ */
+struct gpucg_device *dma_heap_get_gpucg_dev(struct dma_heap *heap);
+
 /**
  * dma_heap_add - adds a heap to dmabuf heaps
  * @exp_info:		information needed to register this heap
--=20
2.35.1.616.g0bdcbb4464-goog

