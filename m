Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03970663343
	for <lists+cgroups@lfdr.de>; Mon,  9 Jan 2023 22:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237260AbjAIVkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Jan 2023 16:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbjAIVjp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Jan 2023 16:39:45 -0500
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782A91DF2F
        for <cgroups@vger.kernel.org>; Mon,  9 Jan 2023 13:38:32 -0800 (PST)
Received: by mail-oi1-x24a.google.com with SMTP id bh17-20020a056808181100b003633ad83115so3073030oib.3
        for <cgroups@vger.kernel.org>; Mon, 09 Jan 2023 13:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bWOMIyzYML+GnCVLadZ/bfKF2vZbEfEtiwoUNHe8I8g=;
        b=B/4nGCkbSar9JPAjXdE2nMB2agrlgj7EbvSmEmaJ+FSJY/iiSdTcvg5MdvBrbYHsHT
         aJRIFm3Wr5pW8VLrvwXyFhP3E3TT9U5sZcpJvG8FV1JDpbHJwB7rtgFFGgNK9LDaVjog
         Pxt5yN9L6hOC7uq/3GfuD7+lUUQyPP+3VSsa17lsU0G2BkfMYQpcL3C/SsXM7xi372Zn
         fNO5FJJkb2PUBmghvakzxN8uNK9UFoT5CrG30MTZzLQBuir0MX/aQWG2h1G8i+8H8PX5
         4fz1y8odBf62yg98vv3M9x+vuJXu9iZH5joEdWq+vYgTfLpmFQLvIEwSeteAmim8RvJX
         MOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWOMIyzYML+GnCVLadZ/bfKF2vZbEfEtiwoUNHe8I8g=;
        b=F2277dDpbskKSVmspymCsHP57NLXnTJrB5CAVOLfLpcQRd4ZdoR2HHTXMvXDy5vpT5
         Trn0IrWcr8qJRwzI+1/peEuCtMdjLNH1wAHIlf6grjlUvR+YGGWA9R8Ji5YnXlDZWgcq
         /taJlJueeU+4qBbO/ytPmhASTuAAD5rAbdKuaHVWeSxwnYg9W8+FC93jNMGRztNSpoO8
         810PTDfp7fCBDaiNGh9mLrsfit2PMWsQDtgw4YIc0ipJe0kTBSyxc0XsEHpYoaHsRquI
         M0y6QnSwQfxR7KidW5SSpcN3BynnvvsUU+qM0rf6M6ETB6tqvrxxy6WVZRgiYSJbiEyT
         OTQA==
X-Gm-Message-State: AFqh2ko4AnJcf5xg+IXBUgIHxmDW320yYMPfRV04vw4dKBPz/2iLVckN
        gKDF5ZiGLPqQPw0eR54wG/dE+EPWod0NixA=
X-Google-Smtp-Source: AMrXdXt2b4GmnQbBAnictl+P9Qid5OxsP4Aa+Rreix4gjPXQPZYSTzo2urBLSPG5NnFGp9zwycV58Z5FT1JxcHQ=
X-Received: from tj.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:53a])
 (user=tjmercier job=sendgmr) by 2002:a05:6870:6327:b0:15b:d2e:d059 with SMTP
 id s39-20020a056870632700b0015b0d2ed059mr587093oao.179.1673300311796; Mon, 09
 Jan 2023 13:38:31 -0800 (PST)
Date:   Mon,  9 Jan 2023 21:38:06 +0000
In-Reply-To: <20230109213809.418135-1-tjmercier@google.com>
Mime-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230109213809.418135-4-tjmercier@google.com>
Subject: [PATCH 3/4] binder: Add flags to relinquish ownership of fds
From:   "T.J. Mercier" <tjmercier@google.com>
To:     tjmercier@google.com, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>
Cc:     daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        Hridya Valsaraju <hridya@google.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hridya Valsaraju <hridya@google.com>

This patch introduces flags BINDER_FD_FLAG_XFER_CHARGE, and
BINDER_FD_FLAG_XFER_CHARGE that a process sending an individual fd or
fd array to another process over binder IPC can set to relinquish
ownership of the fd(s) being sent for memory accounting purposes. If the
flag is found to be set during the fd or fd array translation and the
fd is for a DMA-BUF, the buffer is uncharged from the sender's cgroup
and charged to the receiving process's cgroup instead.

It is up to the sending process to ensure that it closes the fds
regardless of whether the transfer failed or succeeded.

Most graphics shared memory allocations in Android are done by the
graphics allocator HAL process. On requests from clients, the HAL
process allocates memory and sends the fds to the clients over binder
IPC. The graphics allocator HAL will not retain any references to the
buffers. When the HAL sets *_FLAG_XFER_CHARGE for fd arrays holding
DMA-BUF fds, or individual fd objects, binder will transfer the charge
for the buffer from the allocator process cgroup to the client process
cgroup.

The pad [1] and pad_flags [2] fields of binder_fd_object and
binder_fda_array_object come from alignment with flat_binder_object and
have never been exposed for use from userspace. This new flags use
follows the pattern set by binder_buffer_object.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/android/binder.h?id=feba3900cabb8e7c87368faa28e7a6936809ba22
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/uapi/linux/android/binder.h?id=5cdcf4c6a638591ec0e98c57404a19e7f9997567

Signed-off-by: Hridya Valsaraju <hridya@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  3 ++-
 drivers/android/binder.c                | 31 +++++++++++++++++++++----
 drivers/dma-buf/dma-buf.c               |  4 +---
 include/linux/dma-buf.h                 |  1 +
 include/uapi/linux/android/binder.h     | 23 ++++++++++++++----
 5 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 538ae22bc514..d225295932c0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1457,7 +1457,8 @@ PAGE_SIZE multiple when read back.
 
 	  dmabuf (npn)
 		Amount of memory used for exported DMA buffers allocated by the cgroup.
-		Stays with the allocating cgroup regardless of how the buffer is shared.
+		Stays with the allocating cgroup regardless of how the buffer is shared
+		unless explicitly transferred.
 
 	  workingset_refault_anon
 		Number of refaults of previously evicted anonymous pages.
diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 880224ec6abb..9830848c8d25 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -42,6 +42,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/dma-buf.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
@@ -2237,7 +2238,7 @@ static int binder_translate_handle(struct flat_binder_object *fp,
 	return ret;
 }
 
-static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
+static int binder_translate_fd(u32 fd, binder_size_t fd_offset, __u32 flags,
 			       struct binder_transaction *t,
 			       struct binder_thread *thread,
 			       struct binder_transaction *in_reply_to)
@@ -2275,6 +2276,26 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 		goto err_security;
 	}
 
+	if (IS_ENABLED(CONFIG_MEMCG) && (flags & BINDER_FD_FLAG_XFER_CHARGE)) {
+		struct dma_buf *dmabuf;
+
+		if (unlikely(!is_dma_buf_file(file))) {
+			binder_user_error(
+				"%d:%d got transaction with XFER_CHARGE for non-dmabuf fd, %d\n",
+				proc->pid, thread->pid, fd);
+			ret = -EINVAL;
+			goto err_dmabuf;
+		}
+
+		dmabuf = file->private_data;
+		ret = dma_buf_transfer_charge(dmabuf, target_proc->tsk);
+		if (ret) {
+			pr_warn("%d:%d Unable to transfer DMA-BUF fd charge to %d\n",
+				proc->pid, thread->pid, target_proc->pid);
+			goto err_xfer;
+		}
+	}
+
 	/*
 	 * Add fixup record for this transaction. The allocation
 	 * of the fd in the target needs to be done from a
@@ -2294,6 +2315,8 @@ static int binder_translate_fd(u32 fd, binder_size_t fd_offset,
 	return ret;
 
 err_alloc:
+err_xfer:
+err_dmabuf:
 err_security:
 	fput(file);
 err_fget:
@@ -2604,7 +2627,7 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 
 		ret = copy_from_user(&fd, sender_ufda_base + sender_uoffset, sizeof(fd));
 		if (!ret)
-			ret = binder_translate_fd(fd, offset, t, thread,
+			ret = binder_translate_fd(fd, offset, fda->flags, t, thread,
 						  in_reply_to);
 		if (ret)
 			return ret > 0 ? -EINVAL : ret;
@@ -3383,8 +3406,8 @@ static void binder_transaction(struct binder_proc *proc,
 			struct binder_fd_object *fp = to_binder_fd_object(hdr);
 			binder_size_t fd_offset = object_offset +
 				(uintptr_t)&fp->fd - (uintptr_t)fp;
-			int ret = binder_translate_fd(fp->fd, fd_offset, t,
-						      thread, in_reply_to);
+			int ret = binder_translate_fd(fp->fd, fd_offset, fp->flags,
+						      t, thread, in_reply_to);
 
 			fp->pad_binder = 0;
 			if (ret < 0 ||
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index fd6c5002032b..a65b42433099 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -34,8 +34,6 @@
 
 #include "dma-buf-sysfs-stats.h"
 
-static inline int is_dma_buf_file(struct file *);
-
 struct dma_buf_list {
 	struct list_head head;
 	struct mutex lock;
@@ -527,7 +525,7 @@ static const struct file_operations dma_buf_fops = {
 /*
  * is_dma_buf_file - Check if struct file* is associated with dma_buf
  */
-static inline int is_dma_buf_file(struct file *file)
+int is_dma_buf_file(struct file *file)
 {
 	return file->f_op == &dma_buf_fops;
 }
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 6aa128d76aa7..092d572ce528 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -595,6 +595,7 @@ dma_buf_attachment_is_dynamic(struct dma_buf_attachment *attach)
 	return !!attach->importer_ops;
 }
 
+int is_dma_buf_file(struct file *file);
 struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
 					  struct device *dev);
 struct dma_buf_attachment *
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index e72e4de8f452..696c2bdb8a7e 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -91,14 +91,14 @@ struct flat_binder_object {
 /**
  * struct binder_fd_object - describes a filedescriptor to be fixed up.
  * @hdr:	common header structure
- * @pad_flags:	padding to remain compatible with old userspace code
+ * @flags:	One or more BINDER_FD_FLAG_* flags
  * @pad_binder:	padding to remain compatible with old userspace code
  * @fd:		file descriptor
  * @cookie:	opaque data, used by user-space
  */
 struct binder_fd_object {
 	struct binder_object_header	hdr;
-	__u32				pad_flags;
+	__u32				flags;
 	union {
 		binder_uintptr_t	pad_binder;
 		__u32			fd;
@@ -107,6 +107,17 @@ struct binder_fd_object {
 	binder_uintptr_t		cookie;
 };
 
+enum {
+	/**
+	 * @BINDER_FD_FLAG_XFER_CHARGE
+	 *
+	 * When set, the sender of a binder_fd_object wishes to relinquish ownership of the fd for
+	 * memory accounting purposes. If the fd is for a DMA-BUF, the buffer is uncharged from the
+	 * sender's cgroup and charged to the receiving process's cgroup instead.
+	 */
+	BINDER_FD_FLAG_XFER_CHARGE = 0x01,
+};
+
 /* struct binder_buffer_object - object describing a userspace buffer
  * @hdr:		common header structure
  * @flags:		one or more BINDER_BUFFER_* flags
@@ -141,7 +152,7 @@ enum {
 
 /* struct binder_fd_array_object - object describing an array of fds in a buffer
  * @hdr:		common header structure
- * @pad:		padding to ensure correct alignment
+ * @flags:		One or more BINDER_FDA_FLAG_* flags
  * @num_fds:		number of file descriptors in the buffer
  * @parent:		index in offset array to buffer holding the fd array
  * @parent_offset:	start offset of fd array in the buffer
@@ -162,12 +173,16 @@ enum {
  */
 struct binder_fd_array_object {
 	struct binder_object_header	hdr;
-	__u32				pad;
+	__u32				flags;
 	binder_size_t			num_fds;
 	binder_size_t			parent;
 	binder_size_t			parent_offset;
 };
 
+enum {
+	BINDER_FDA_FLAG_XFER_CHARGE = BINDER_FD_FLAG_XFER_CHARGE,
+};
+
 /*
  * On 64-bit platforms where user code may run in 32-bits the driver must
  * translate the buffer (and local binder) addresses appropriately.
-- 
2.39.0.314.g84b9a713c41-goog

