Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B114B2A01
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 17:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348638AbiBKQT1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 11:19:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351462AbiBKQTP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 11:19:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C88D90
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 08:19:12 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b12-20020a056902030c00b0061d720e274aso19663805ybs.20
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 08:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=09UL10d0I9UYF+bVDoR9sZ50jMDUcLUx49HZh4jVL78=;
        b=JE1EYWsWmJMVKKKziQTWEWuNUsyaPxqCZ/opyUrIE1QJ2zMzT8OF9HdxhY+GhtuCaK
         HyDDiusYJME2veTyqvuwR1555jPMqz95nnShokOB0VNQWEe93IdgXongToVPd90O3dAV
         IimzoYc1rIm15su0G+eGvhoRyruDLS+nZbjAQSDDWgXzx6DUp60nKevkdTlnOcGS/yxC
         7VDKvQJbgIkNVOdKUHyv+vhK1BCP41v5/xbIT27E+bix812dIwb5ma26aGylR3U5/hbr
         /YZu4e+ldXsQQ0aLJTqhpqIkZ/qs9fg8ieI0b6EipnVFoSEM/clguN4lkL+c5q3or2+f
         JMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=09UL10d0I9UYF+bVDoR9sZ50jMDUcLUx49HZh4jVL78=;
        b=1z2k89kevpIT/quo9YTuYDq97+HdKmULpk3f5yedbDy7s+/6gnAENwjwwbjtRwyQrY
         d/FKsySs3tFHUY1m7xHlZX7sle3QSF/lkDnBNeMiC0PjgaOzvA80gVVc0EWKBs+M3Slh
         /I1y0PK2SXXDx2tVVDkyAJ0e43zqhYjKF4Q8wOnumHNvkMRP5VIUhczWZKY11Bv98M8u
         Xh20fo40XVpMHcSnVFxWNmF2XdMQIg9DIfNX1e60uSpg9Zv+6+LKnNShUKSgiuYfTm8p
         LENwXlCYA/Ofq7DXOiWXrLnEAzqhGLKjiPpvq7GaoRr5YxFlNH01jAd07XS2IoX3Pp/O
         WDAw==
X-Gm-Message-State: AOAM533si96zsoQ+n49HVG0Q18W58HWCawXxKh+3+/IbOzCvtPUiJYD3
        LFMWaw0jwFAVTDhf7G8oAuByDm7w0GbRCso=
X-Google-Smtp-Source: ABdhPJyt28xsiqi+oRkwIgJ74WzjQyOoBVx2xkYnBQvOje0p3ZB58ZSdJeKE27JlSq7ErJdcjRoIy8BigQrNax8=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a81:d007:: with SMTP id
 v7mr2415829ywi.88.1644596352146; Fri, 11 Feb 2022 08:19:12 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:18:29 +0000
In-Reply-To: <20220211161831.3493782-1-tjmercier@google.com>
Message-Id: <20220211161831.3493782-7-tjmercier@google.com>
Mime-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [RFC v2 6/6] android: binder: Add a buffer flag to relinquish
 ownership of fds
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch introduces a buffer flag BINDER_BUFFER_FLAG_SENDER_NO_NEED
that a process sending an fd array to another process over binder IPC
can set to relinquish ownership of the fds being sent for memory
accounting purposes. If the flag is found to be set during the fd array
translation and the fd is for a DMA-BUF, the buffer is uncharged from
the sender's cgroup and charged to the receiving process's cgroup
instead.

It is up to the sending process to ensure that it closes the fds
regardless of whether the transfer failed or succeeded.

Most graphics shared memory allocations in Android are done by the
graphics allocator HAL process. On requests from clients, the HAL process
allocates memory and sends the fds to the clients over binder IPC.
The graphics allocator HAL will not retain any references to the
buffers. When the HAL sets the BINDER_BUFFER_FLAG_SENDER_NO_NEED for fd
arrays holding DMA-BUF fds, the gpu cgroup controller will be able to
correctly charge the buffers to the client processes instead of the
graphics allocator HAL.

From: Hridya Valsaraju <hridya@google.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
Co-developed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
changes in v2
- Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.

 drivers/android/binder.c            | 26 ++++++++++++++++++++++++++
 include/uapi/linux/android/binder.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..f50d88ded188 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -42,6 +42,7 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
+#include <linux/dma-buf.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/freezer.h>
@@ -2482,8 +2483,10 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 {
 	binder_size_t fdi, fd_buf_size;
 	binder_size_t fda_offset;
+	bool transfer_gpu_charge =3D false;
 	const void __user *sender_ufda_base;
 	struct binder_proc *proc =3D thread->proc;
+	struct binder_proc *target_proc =3D t->to_proc;
 	int ret;
=20
 	fd_buf_size =3D sizeof(u32) * fda->num_fds;
@@ -2521,8 +2524,15 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 	if (ret)
 		return ret;
=20
+	if (IS_ENABLED(CONFIG_CGROUP_GPU) &&
+		parent->flags & BINDER_BUFFER_FLAG_SENDER_NO_NEED)
+		transfer_gpu_charge =3D true;
+
 	for (fdi =3D 0; fdi < fda->num_fds; fdi++) {
 		u32 fd;
+		struct dma_buf *dmabuf;
+		struct gpucg *gpucg;
+
 		binder_size_t offset =3D fda_offset + fdi * sizeof(fd);
 		binder_size_t sender_uoffset =3D fdi * sizeof(fd);
=20
@@ -2532,6 +2542,22 @@ static int binder_translate_fd_array(struct list_hea=
d *pf_head,
 						  in_reply_to);
 		if (ret)
 			return ret > 0 ? -EINVAL : ret;
+
+		if (!transfer_gpu_charge)
+			continue;
+
+		dmabuf =3D dma_buf_get(fd);
+		if (IS_ERR(dmabuf))
+			continue;
+
+		gpucg =3D gpucg_get(target_proc->tsk);
+		ret =3D dma_buf_charge_transfer(dmabuf, gpucg);
+		if (ret) {
+			pr_warn("%d:%d Unable to transfer DMA-BUF fd charge to %d",
+				proc->pid, thread->pid, target_proc->pid);
+			gpucg_put(gpucg);
+		}
+		dma_buf_put(dmabuf);
 	}
 	return 0;
 }
diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/andro=
id/binder.h
index 3246f2c74696..169fd5069a1a 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -137,6 +137,7 @@ struct binder_buffer_object {
=20
 enum {
 	BINDER_BUFFER_FLAG_HAS_PARENT =3D 0x01,
+	BINDER_BUFFER_FLAG_SENDER_NO_NEED =3D 0x02,
 };
=20
 /* struct binder_fd_array_object - object describing an array of fds in a =
buffer
--=20
2.35.1.265.g69c8d7142f-goog

