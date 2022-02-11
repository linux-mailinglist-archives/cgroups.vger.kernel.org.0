Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD994B2A10
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 17:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351425AbiBKQTQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 11:19:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351424AbiBKQTO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 11:19:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51F92F5
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 08:19:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 2-20020a251302000000b006118f867dadso19737115ybt.12
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=yvZODKlks7uSqzZPx/QuM2FpvgBeZ2Sk/1s0RF7z1Xc=;
        b=ec1Yy1HYUYsk8sjBv+NO8SvcoXRcbLd5uiv9OPxDsNNur23ie7DmHnG9pRO3ilNRJc
         1WvllX32ogWUY0ES0dpiEE0PkkZAqEtGHDkIOKsW2C7o8MPYg3yfWoNyM+WdEiwbD35T
         Wm/nnsqgsS4c257blD2h2q3WLvab8g25Dj83ORJVcsTjGYJyVICqcM/zkGknDnaHwtni
         S4ZDOVi8GlgnNuE1vqJ9LyP4yV9NB3a+ujEPEu7FgVA5ADIEY9Yho6UbQZlXhZiHM4fN
         WFpGmfjmGs9WnZVI4xN8jGbbfCl8+QIJaWkRzPaFr5hx6+gvkC/2/iIAsFPFyG5TXVMH
         vNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=yvZODKlks7uSqzZPx/QuM2FpvgBeZ2Sk/1s0RF7z1Xc=;
        b=mwpwBViElZ2UHFH3rjLPf0yS3cDwT39sczQ0phGEmViZAYh2odJZsBfjFiw7TQpLf+
         cqnEGTdPS0SWNcuCwua2OdHVCFCCBwT69Pdwe5jzgrfuxv+/UHM0fqoE1BmkZ1Wdl7Z5
         FtyGDfwioo3kqITXPdEAwQRhwE9hNsTRX6veZ7FjJDxfUm6vjA5yyRa8zFodZh1zg1bc
         LfxD6Jnne6iEBvmhp4abYZV1DsB7BzpNScu71TmBL1ixlQRQSqMX9qICfaExDYLEzYyk
         FfgULfaln/QXGqet4qiL0YumsbZTMhLyA7TsmPRZNC8tnl1vZniTF5TojO/fj3f+byos
         rJ2g==
X-Gm-Message-State: AOAM531vR2atncZoitJusC9IxdwdpyzwBggYyYAWunzBu2rZYRUkm4dL
        5NIRUN+kIcsCkiya54BLeOT3UdlLex0H7/8=
X-Google-Smtp-Source: ABdhPJyzRZpguSr08v/JtkpnGzL6Z+Soi+F7TZB5Jn0SLwqv4tx2BBp/V2mC7+AUgYjetHM8LbPfONmE/Uc6VpY=
X-Received: from tj2.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:187])
 (user=tjmercier job=sendgmr) by 2002:a81:2d03:: with SMTP id
 t3mr2496118ywt.215.1644596347024; Fri, 11 Feb 2022 08:19:07 -0800 (PST)
Date:   Fri, 11 Feb 2022 16:18:28 +0000
In-Reply-To: <20220211161831.3493782-1-tjmercier@google.com>
Message-Id: <20220211161831.3493782-6-tjmercier@google.com>
Mime-Version: 1.0
References: <20220211161831.3493782-1-tjmercier@google.com>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [RFC v2 5/6] dmabuf: Add gpu cgroup charge transfer function
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

The dma_buf_charge_transfer function provides a way for processes to
transfer charge of a buffer to a different process. This is essential
for the cases where a central allocator process does allocations for
various subsystems, hands over the fd to the client who requested the
memory and drops all references to the allocated memory.

From: Hridya Valsaraju <hridya@google.com>
Signed-off-by: Hridya Valsaraju <hridya@google.com>
Co-developed-by: T.J. Mercier <tjmercier@google.com>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
changes in v2
- Move dma-buf cgroup charge transfer from a dma_buf_op defined by every
heap to a single dma-buf function for all heaps per Daniel Vetter and
Christian K=C3=B6nig.

 drivers/dma-buf/dma-buf.c | 48 +++++++++++++++++++++++++++++++++++++++
 include/linux/dma-buf.h   |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 83d0d1b91547..55e1b982f840 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -1374,6 +1374,54 @@ void dma_buf_vunmap(struct dma_buf *dmabuf, struct d=
ma_buf_map *map)
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_vunmap, DMA_BUF);
=20
+/**
+ * dma_buf_charge_transfer - Change the GPU cgroup to which the provided d=
ma_buf
+ * is charged.
+ * @dmabuf:	[in]	buffer whose charge will be migrated to a different GPU
+ *			cgroup
+ * @gpucg:	[in]	the destination GPU cgroup for dmabuf's charge
+ *
+ * Only tasks that belong to the same cgroup the buffer is currently charg=
ed to
+ * may call this function, otherwise it will return -EPERM.
+ *
+ * Returns 0 on success, or a negative errno code otherwise.
+ */
+int dma_buf_charge_transfer(struct dma_buf *dmabuf, struct gpucg *gpucg)
+{
+#ifdef CONFIG_CGROUP_GPU
+	struct gpucg *current_gpucg;
+	int ret =3D 0;
+
+	/*
+	 * Verify that the cgroup of the process requesting the transfer is the
+	 * same as the one the buffer is currently charged to.
+	 */
+	current_gpucg =3D gpucg_get(current);
+	mutex_lock(&dmabuf->lock);
+	if (current_gpucg !=3D dmabuf->gpucg) {
+		ret =3D -EPERM;
+		goto err;
+	}
+
+	ret =3D gpucg_try_charge(gpucg, dmabuf->gpucg_dev, dmabuf->size);
+	if (ret)
+		goto err;
+
+	dmabuf->gpucg =3D gpucg;
+
+	/* uncharge the buffer from the cgroup it's currently charged to. */
+	gpucg_uncharge(current_gpucg, dmabuf->gpucg_dev, dmabuf->size);
+
+err:
+	mutex_unlock(&dmabuf->lock);
+	gpucg_put(current_gpucg);
+	return ret;
+#else
+	return 0;
+#endif /* CONFIG_CGROUP_GPU */
+}
+EXPORT_SYMBOL_NS_GPL(dma_buf_charge_transfer, DMA_BUF);
+
 #ifdef CONFIG_DEBUG_FS
 static int dma_buf_debug_show(struct seq_file *s, void *unused)
 {
diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
index 742f29c3daaf..85c940c08867 100644
--- a/include/linux/dma-buf.h
+++ b/include/linux/dma-buf.h
@@ -646,4 +646,6 @@ int dma_buf_mmap(struct dma_buf *, struct vm_area_struc=
t *,
 		 unsigned long);
 int dma_buf_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
 void dma_buf_vunmap(struct dma_buf *dmabuf, struct dma_buf_map *map);
+
+int dma_buf_charge_transfer(struct dma_buf *dmabuf, struct gpucg *gpucg);
 #endif /* __DMA_BUF_H__ */
--=20
2.35.1.265.g69c8d7142f-goog

