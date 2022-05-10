Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1135227F1
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 01:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbiEJX5V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 19:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238746AbiEJX5K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 19:57:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F793209B7F
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 16:57:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f902276272so2631797b3.21
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 16:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=v8gt6xjWudwEV2qln2N7SwuUJc9JxxsnlnvbLCYxUc0=;
        b=loPY8BnZXxZrmNCWwTUfS3qnOnH67SZdt82uLV668C+yIIJpUM1rapWhZgScGIl9UE
         JFdoQvmgq7+PYtQoNo7Xt49JaVYYmqeh2y94j0P91OEseICBN/VZcZdJ3lAn7XpCBFZ3
         ZAVIHeyQUE+wezChaUS94nW2/UcpI4NzobrLV1STkXosAruMEI00Fa/sE0BRXri67Gz2
         q05IqbfZP5GchqKe/UA5reCqq9DB1Z8ctk9/fnRwNjkinW13EkBWelw/KRjhayVVXg4q
         Q+RrUAtEcwIKZeShieINdDTV4tIt2WaYR50DZuhNAsEvXdGj1OBBCwLDh1FP0SxBPBN8
         7Qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=v8gt6xjWudwEV2qln2N7SwuUJc9JxxsnlnvbLCYxUc0=;
        b=bUZNrQ8wXCRf/rPMyUDDePnAstzD229f5hjNrKsjbAcv0FlEDzGx9GURtSpf42svCl
         gayoIS8QZ1Q3vQ3xZoD446VqQUl1PsQqWdBRnwtBm5GSoqpjGOu5hCXOY+SUqR1/2AiH
         5xnXtbqXaR1Qy5sftuQuEEaoEf7SR2uP4M73qI0ZBwzEp9erZ/3CChCw/4VI2lroVlHV
         Gh5W1WtueX/oNudekSqwiJp3vL6DrmEZJ7U571MKn+uC06G0PpiWmVPBo+JTfZvJa6eY
         Ab1/PFPXZbXMC4aLxT4nEklpB4qGfOueWRZK7eSJBztNwy4gsuWdkCjNh457mrGzLdIL
         2GNw==
X-Gm-Message-State: AOAM532/W2ZwOrmvrYupfkAdiXOcgA8SoqowO8JbHJbDc5xCXVrKhC9j
        YT7NQCWUUtmLx9NNUhXldXMIhH+E3Xsjkjo=
X-Google-Smtp-Source: ABdhPJxuMd23Slzk/nX5zXAwKMfpsaSnwA9y71fBu5xFnMi06zJ5/oaDRiKKaGgRjX9ctDMnyPrityYdWY9YepQ=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a5b:8cb:0:b0:645:d65f:dcdd with SMTP id
 w11-20020a5b08cb000000b00645d65fdcddmr19840185ybq.233.1652227027524; Tue, 10
 May 2022 16:57:07 -0700 (PDT)
Date:   Tue, 10 May 2022 23:56:48 +0000
In-Reply-To: <20220510235653.933868-1-tjmercier@google.com>
Message-Id: <20220510235653.933868-5-tjmercier@google.com>
Mime-Version: 1.0
References: <20220510235653.933868-1-tjmercier@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v7 4/6] dmabuf: Add gpu cgroup charge transfer function
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
 drivers/dma-buf/dma-buf.c  | 57 ++++++++++++++++++++++++++++++++++++++
 include/linux/cgroup_gpu.h | 24 ++++++++++++++++
 include/linux/dma-buf.h    |  6 ++++
 kernel/cgroup/gpu.c        | 51 ++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+)

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
index cb228a16aa1f..7eb68f1507fb 100644
--- a/include/linux/cgroup_gpu.h
+++ b/include/linux/cgroup_gpu.h
@@ -75,6 +75,22 @@ int gpucg_charge(struct gpucg *gpucg, struct gpucg_bucke=
t *bucket, u64 size);
  */
 void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_bucket *bucket, u64 =
size);
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
+			  u64 size);
+
 /**
  * gpucg_register_bucket - Registers a bucket for memory accounting using =
the GPU cgroup controller.
  *
@@ -117,6 +133,14 @@ static inline void gpucg_uncharge(struct gpucg *gpucg,
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
 static inline struct gpucg_bucket *gpucg_register_bucket(const char *name)=
 {}
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
index ad16ea15d427..038ea873a9d3 100644
--- a/kernel/cgroup/gpu.c
+++ b/kernel/cgroup/gpu.c
@@ -274,6 +274,57 @@ void gpucg_uncharge(struct gpucg *gpucg, struct gpucg_=
bucket *bucket, u64 size)
 	css_put(&gpucg->css);
 }
=20
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
 struct gpucg_bucket *gpucg_register_bucket(const char *name)
 {
 	struct gpucg_bucket *bucket, *b;
--=20
2.36.0.512.ge40c2bad7a-goog

