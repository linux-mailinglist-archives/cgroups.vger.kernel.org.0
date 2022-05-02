Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0892517AC7
	for <lists+cgroups@lfdr.de>; Tue,  3 May 2022 01:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiEBX0p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 May 2022 19:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233557AbiEBXYD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 May 2022 19:24:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2561C137
        for <cgroups@vger.kernel.org>; Mon,  2 May 2022 16:20:31 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o64-20020a257343000000b006483069a28aso14418561ybc.3
        for <cgroups@vger.kernel.org>; Mon, 02 May 2022 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Wn9v1CSaaj/fcp4H4m6fdK0VVkJ4e50woEWu1Yxarys=;
        b=BCF74xud8cBNQW7tG9f2fW58o9oxEmFAzNkfL/9t0pr5jk1EL1JZMfv+x2SRbD+V9v
         TtheFTeIOscrljY3nyBYFiNtB8sQwLUveg8wd0piZUxDeOPE8kLqWnDubzqVl5Dw3fGf
         sm6+xZ4tLQeK3pwCPyw8lY+8ILvKs5L5o6xKjREPmKIeXvpQ83iVuTAytQ9+g0kzYkB6
         fsjZPX9jcCBdOgVr0XBSfxB5o47yI9rTuwrq6ddJSxuFPO5E1Ud+3/+Sb6oQr5vcWC7b
         +rTD9sxTV5QAizNpm1gcVkvak645ZDrYOlst6c9bBZ2YksFdYwdjbxhN5LToMfhQhpzJ
         xAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Wn9v1CSaaj/fcp4H4m6fdK0VVkJ4e50woEWu1Yxarys=;
        b=GeHzA73nkyuY09JS9+kuhz+TOIGGUbsZZXcuz43Ijcm6VOYtaas5X0PrL8SHh2nA+4
         PdehXADTGWu8gfaiK0zleyyCm71gdSCVYqVta3gNWuOh4LWolLhuKmXEpcrl1RtVNb4d
         4xTgC5hx2/lAfYRdy1Q5b3sk7fLo94s3uKvlVy42urfM7y4Zze75JFYYN6uCdmj7WPTz
         tcO9Ur2yTPWQB3VZCdj3xI7bRJ1fLrSw/HkyLUMinEcaam2x3eb6/yWohSHatlzOLNSx
         x4w0b3ep9Jyi8mBYveVDgETFsV6x9LispxDiQVyKB2FzoUL4sK39ZFU6D2WH9e0e5tBC
         0ivw==
X-Gm-Message-State: AOAM533ShWYZRYu0i25/5alKR9Jy76s3OLKoD8bMEuibqWwTrFv+vIxA
        lRHpMsN/ZEN5qctCXHO6X54rrAU4iFX6msw=
X-Google-Smtp-Source: ABdhPJxwRLjyLd3L5iYMsPvAGGu1aucdAWmyFZwOo/Sh7vl3w7W1o/rVjWtEBGjxnk6u9D9qOr9ZltUl4wapZpQ=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a0d:d9c1:0:b0:2f4:e463:5dcd with SMTP id
 b184-20020a0dd9c1000000b002f4e4635dcdmr12806740ywe.108.1651533620836; Mon, 02
 May 2022 16:20:20 -0700 (PDT)
Date:   Mon,  2 May 2022 23:19:38 +0000
In-Reply-To: <20220502231944.3891435-1-tjmercier@google.com>
Message-Id: <20220502231944.3891435-5-tjmercier@google.com>
Mime-Version: 1.0
References: <20220502231944.3891435-1-tjmercier@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v6 4/6] dmabuf: Add gpu cgroup charge transfer function
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     daniel@ffwll.ch, hridya@google.com, jstultz@google.com,
        tkjos@android.com, cmllamas@google.com, surenb@google.com,
        kaleshsingh@google.com, Kenny.Ho@amd.com, mkoutny@suse.com,
        skhan@linuxfoundation.org, kernel-team@android.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The dma_buf_transfer_charge function provides a way for processes to
transfer charge of a buffer to a different process. This is essential
for the cases where a central allocator process does allocations for
various subsystems, hands over the fd to the client who requested the
memory and drops all references to the allocated memory.

Originally-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>

---
v5 changes
Fix commit message which still contained the old name for
dma_buf_transfer_charge per Michal Koutn=C3=BD.

Modify the dma_buf_transfer_charge API to accept a task_struct instead
of a gpucg. This avoids requiring the caller to manage the refcount
of the gpucg upon failure and confusing ownership transfer logic.

v4 changes
Adjust ordering of charge/uncharge during transfer to avoid potentially
hitting cgroup limit per Michal Koutn=C3=BD.

v3 changes
Use more common dual author commit message format per John Stultz.

v2 changes
Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.
---
 drivers/dma-buf/dma-buf.c  | 57 +++++++++++++++++++++++++++++++++++
 include/linux/cgroup_gpu.h | 14 +++++++++
 include/linux/dma-buf.h    |  6 ++++
 kernel/cgroup/gpu.c        | 62 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index bc89c44bd9b9..f3fb844925e2 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1341,6 +1341,63 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct i=
osys_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap, DMA_BUF);
=20
+/**
+ * dma_buf_transfer_charge - Change the GPU cgroup to which the provided d=
ma_buf is charged.
+ * @dmabuf:	[in]	buffer whose charge will be migrated to a different GPU c=
group
+ * @target:	[in]	the task_struct of the destination process for the GPU cg=
roup charge
+ *
+ * Only tasks that belong to the same cgroup the buffer is currently charg=
ed to
+ * may call this function, otherwise it will return -EPERM.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int dma_buf_transfer_charge(struct dma_buf *dmabuf, struct task_struct *ta=
rget)
+{
+	struct gpucg *current_gpucg, *target_gpucg, *to_release;
+	int ret;
+
+	if (!dmabuf->gpucg || !dmabuf->gpucg_bucket) {
+		/* This dmabuf is not tracked under GPU cgroup accounting */
+		return 0;
+	}
+
+	current_gpucg =3D gpucg_get(current);
+	target_gpucg =3D gpucg_get(target);
+	to_release =3D target_gpucg;
+
+	/* If the source and destination cgroups are the same, don't do anything.=
 */
+	if (current_gpucg =3D=3D target_gpucg) {
+		ret =3D 0;
+		goto skip_transfer;
+	}
+
+	/*
+	 * Verify that the cgroup of the process requesting the transfer
+	 * is the same as the one the buffer is currently charged to.
+	 */
+	mutex_lock(&dmabuf->lock);
+	if (current_gpucg !=3D dmabuf->gpucg) {
+		ret =3D -EPERM;
+		goto err;
+	}
+
+	ret =3D gpucg_transfer_charge(
+		dmabuf->gpucg, target_gpucg, dmabuf->gpucg_bucket, dmabuf->size);
+	if (ret)
+		goto err;
+
+	to_release =3D dmabuf->gpucg;
+	dmabuf->gpucg =3D target_gpucg;
+
+err:
+	mutex_unlock(&dmabuf->lock);
+skip_transfer:
+	gpucg_put(current_gpucg);
+	gpucg_put(to_release);
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_transfer_charge, DMA_BUF);
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/cgroup_gpu.h b/include/linux/cgroup_gpu.h
index 4dfe633d6ec7..f5973ef9f926 100644
--- a/include/linux/cgroup_gpu.h
+++ b/include/linux/cgroup_gpu.h
@@ -83,7 +83,13 @@ static inline struct gpucg *gpucg_parent(struct gpucg *c=
g)
 }
=20
 int gpucg_charge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 siz=
e);
+
 void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 =
size);
+
+int gpucg_transfer_charge(struct gpucg *source,
+			  struct gpucg *dest,
+			  struct gpucg_bucket *bucket,
+			  u64 size);
 int gpucg_register_bucket(struct gpucg_bucket *bucket, const char *name);
 #else /* CONFIG_CGROUP_GPU */
=20
@@ -118,6 +124,14 @@ static inline void gpucg_uncharge(struct gpucg *gpucg,
 				  struct gpucg_bucket *bucket,
 				  u64 size) {}
=20
+static inline int gpucg_transfer_charge(struct gpucg *source,
+					struct gpucg *dest,
+					struct gpucg_bucket *bucket,
+					u64 size)
+{
+	return 0;
+}
+
 static inline int gpucg_register_bucket(struct gpucg_bucket *bucket, const=
 char *name) {}
 #endif /* CONFIG_CGROUP_GPU */
 #endif /* _CGROUP_GPU_H */
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 8e7c55c830b3..438ad8577b76 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/err.h>
 #include <linux/scatterlist.h>
+#include <linux/sched.h>
 #include <linux/list.h>
 #include <linux/dma-mapping.h>
 #include <linux/fs.h>
@@ -650,9 +651,14 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct ios=
ys_map *map);
 void dma_buf_exp_info_set_gpucg(struct dma_buf_export_info *exp_info,
 				struct gpucg *gpucg,
 				struct gpucg_bucket *gpucg_bucket);
+
+int dma_buf_transfer_charge(struct dma_buf *dmabuf, struct task_struct *ta=
rget);
 #else/* CONFIG_CGROUP_GPU */
 static inline void dma_buf_exp_info_set_gpucg(struct dma_buf_export_info *=
exp_info,
 					      struct gpucg *gpucg,
 					      struct gpucg_bucket *gpucg_bucket) {}
+
+static inline int dma_buf_transfer_charge(struct dma_buf *dmabuf, struct t=
ask_struct *target)
+{ return 0; }
 #endif /* CONFIG_CGROUP_GPU */
 #endif /* __DMA_BUF_H__ */
diff --git a/kernel/cgroup/gpu.c b/kernel/cgroup/gpu.c
index 34d0a5b85834..7dfbe0fd7e45 100644
--- a/kernel/cgroup/gpu.c
+++ b/kernel/cgroup/gpu.c
@@ -252,6 +252,68 @@ void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_=
bucket *bucket, u64 size)
 	css_put(&gpucg->css);
 }
=20
+/**
+ * gpucg_transfer_charge - Transfer a GPU charge from one cgroup to anothe=
r.
+ *
+ * @source:	[in]	The GPU cgroup the charge will be transferred from.
+ * @dest:	[in]	The GPU cgroup the charge will be transferred to.
+ * @bucket:	[in]	The GPU cgroup bucket corresponding to the charge.
+ * @size:	[in]	The size of the memory in bytes.
+ *                      This size will be rounded up to the nearest page s=
ize.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int gpucg_transfer_charge(struct gpucg *source,
+			  struct gpucg *dest,
+			  struct gpucg_bucket *bucket,
+			  u64 size)
+{
+	struct page_counter *counter;
+	u64 nr_pages;
+	struct gpucg_resource_pool *rp_source, *rp_dest;
+	int ret =3D 0;
+
+	nr_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
+
+	mutex_lock(&gpucg_mutex);
+	rp_source =3D cg_rpool_find_locked(source, bucket);
+	if (unlikely(!rp_source)) {
+		ret =3D -ENOENT;
+		goto exit_early;
+	}
+
+	rp_dest =3D cg_rpool_get_locked(dest, bucket);
+	if (IS_ERR(rp_dest)) {
+		ret =3D PTR_ERR(rp_dest);
+		goto exit_early;
+	}
+
+	/*
+	 * First uncharge from the pool it's currently charged to. This ordering =
avoids double
+	 * charging while the transfer is in progress, which could cause us to hi=
t a limit.
+	 * If the try_charge fails for this transfer, we need to be able to rever=
se this uncharge,
+	 * so we continue to hold the gpucg_mutex here.
+	 */
+	page_counter_uncharge(&rp_source->total, nr_pages);
+	css_put(&source->css);
+
+	/* Now attempt the new charge */
+	if (page_counter_try_charge(&rp_dest->total, nr_pages, &counter)) {
+		css_get(&dest->css);
+	} else {
+		/*
+		 * The new charge failed, so reverse the uncharge from above. This shoul=
d always
+		 * succeed since charges on source are blocked by gpucg_mutex.
+		 */
+		WARN_ON(!page_counter_try_charge(&rp_source->total, nr_pages, &counter))=
;
+		css_get(&source->css);
+		ret =3D -ENOMEM;
+	}
+exit_early:
+	mutex_unlock(&gpucg_mutex);
+	return ret;
+}
+
 /**
  * gpucg_register_bucket - Registers a bucket for memory accounting using =
the
  * GPU cgroup controller.
--=20
2.36.0.464.gb9c8b46e94-goog

