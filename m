Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE78A4B29FE
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351416AbiBKQTG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 11:19:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351425AbiBKQTE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 11:19:04 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414302FD
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 08:19:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id n4-20020a17090ade8400b001b8bb511c3bso5963453pjv.7
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 08:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=H9ElGyQs3gn6zkZHkaswT2uUcjDtIMKU0yBKyPd+zRw=;
        b=pqlxHsof189xym//3NOb/X4sUEqabODThOYWzG6aE6YJ7NVdPjULt2IJ1cr9fGd286
         TqN8Vwy43pbjAeV0VM9D9lBgLG4vSp0hd5VeYAKLDd4c+fBW8AVWzET7AUF9gs3d9DnW
         gj6vH7NfEcDQIT5DTgijFUOnIfHCxeO7XgA/CHN9DVWmhsFC84dmykrVDNiTyVAb0Uga
         lAiN/rH84g/hNRQgrPyaLunHyngW5zJcDyWr3zfhJNVeBxDY4SR5wMNbeFGNJd7Ub9kP
         G4ZlAh2HeMqycTHUESlobX2v63RZoLJURMn7i3CeIYfJRL5Jz9s0DxOG0Oh6xijpBQgi
         i4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=H9ElGyQs3gn6zkZHkaswT2uUcjDtIMKU0yBKyPd+zRw=;
        b=nsKpS4xI/8VrJaqPxf2k9yXA063/+Gs+VrELQhUQv6ws6n+tQDlme2JjdrrnGN1sEl
         usbgZ4+3K2ezqS32VA7/QVgd/kcKJxPGI7ff/FMVlAwarwAHNCO46RjFu15vELihcl+z
         h/H4WSiCTScTX5qKIN3chXusq3phLTj9srT0A2+2nU2n5MO/MWLSR70L3OYvmC6UuQk9
         2ZJD10yY7NBe+VUrmdeU5Fpiub4ixeqRDbqmZKuvPbugqXg1dbUBqFIPW8VwFZxpbZpr
         2CZTEfwVf2GoXNDwwtmDQTPHjGjZ3W4DTvCASOQuc4ZIOfKycWmOvLz0htam2eqUU71t
         NEfQ==
X-Gm-Message-State: AOAM533T6lIOh99y/kQlkkwPBk8xwvZy1UCojhjoxPdlkmbRWwIifNo+
        CfdvcaJIeFSbKG9r5BKexlqzY7LyVr8Yj/0=
X-Google-Smtp-Source: ABdhPJw+X052tlo7rO4R6ZJggau2VhHkvqL4TWCXAHP2/z0pcE7Hcx1yJPi6R86BW0yLQibs4VQNry7tP5PL4gI=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:aa7:8883:: with SMTP id
 z3mr2365344pfe.65.1644596342665; Fri, 11 Feb 2022 08:19:02 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:18:27 +0000
In-Reply-To: <20220211161831.3493782-1-tjmercier@google.com>
Message-Id: <20220211161831.3493782-5-tjmercier@google.com>
Mime-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [RFC v2 4/6] dmabuf: heaps: export system_heap buffers with GPU
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
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     kaleshsingh@google.com, Kenny.Ho@amd.com,
        "T.J. Mercier" <tjmercier@google.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, cgroups@vger.kernel.org
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

All DMA heaps now register a new GPU cgroup device upon creation, and the
system_heap now exports buffers associated with its GPU cgroup device for
tracking purposes.

From: Hridya Valsaraju <hridya@google.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
Co-developed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
changes in v2
- Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.

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
2.35.1.265.g69c8d7142f-goog

