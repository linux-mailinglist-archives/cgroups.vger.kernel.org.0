Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7706F3CCDD4
	for <lists+cgroups@lfdr.de>; Mon, 19 Jul 2021 08:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234314AbhGSGXt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jul 2021 02:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhGSGXt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jul 2021 02:23:49 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B3C061762
        for <cgroups@vger.kernel.org>; Sun, 18 Jul 2021 23:20:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id jx7-20020a17090b46c7b02901757deaf2c8so11475797pjb.0
        for <cgroups@vger.kernel.org>; Sun, 18 Jul 2021 23:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ot1ZCdklbuVxPu8+gOG1PND0ADydDvMWRMEYLY++gTw=;
        b=g9yqFYLsJv4KRuG5lwdnluG3L+zDxg5Fr1ogd0pnzjJLXubjNQ39UyUuqpo+/ZFZJI
         4DoNHE17tvg/UKDQ3i3H6dLvSiuL44ALiZZarYPmltyegnAK6G+guZRJr5w5aYZ6wDoX
         vz6VnQO/BG4oBAueyVSVJxQHkropfGeioeOJA272IBXQHzAP6q4HTp1EaJ+grAknc/rz
         C7Ej47TtFDOVHRENQV9rMb24rHeqmncna2AfGfuqG90yhSUuEy5F0rki3xY5ochuptGl
         vBb+OUOXLILb+jDZ2TErztbgY156OLii1u656DVdsB9yfU9fZ7FONsetNBEb0ewlzNuK
         eC8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ot1ZCdklbuVxPu8+gOG1PND0ADydDvMWRMEYLY++gTw=;
        b=iwad0bzrYHoQpgVDmR8CS6xT1+kjSd0fsWF5U5aeNg2xYtT0xtg8tLFInm9gKK4vow
         SNez09WivWRH0Dn0EnJ40sRE/C86YM5O/AiwnhOdEQXFSuYsCrUmOG0uF8d9BUjZ7ees
         xULq9Gj7FtYP3GISIEANglXFf9hG24YfQF6XdrbWyOFkbVs+rb9RylOdqhfbzSFA+7Ja
         B4YpqSg7K+c7B868IncLa641+SptIovSJeJJzTJf4W0wyTdLWaqiD1qAyijXkvFtTMdf
         xzdkO+ehirT/P4FkPeWEqjE+J2w3FMT3Ef+HHRhDP5q2Kz+q7FVvIqO75Q9XKFj/HJ6P
         K5/g==
X-Gm-Message-State: AOAM533sGN2cfxhIWwh6d2EypzHTdzXtWhn8XXclqgyJ0AWpSwYcTwTu
        o2N1Mkqj9N+uUcxP1q55dWo=
X-Google-Smtp-Source: ABdhPJyIduGu8Txn8gKVpxipYzDfcQKlRR+t3UJ1jLj5vpKjtrgUk4K7/ubzRK1yTm8uvvjb55bYfw==
X-Received: by 2002:a17:90b:14a:: with SMTP id em10mr23201993pjb.125.1626675648719;
        Sun, 18 Jul 2021 23:20:48 -0700 (PDT)
Received: from honest-machine-1.localdomain.localdomain (80.251.213.191.16clouds.com. [80.251.213.191])
        by smtp.gmail.com with ESMTPSA id z8sm18766156pfc.155.2021.07.18.23.20.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Jul 2021 23:20:48 -0700 (PDT)
From:   Yutian Yang <nglaive@gmail.com>
To:     shakeelb@google.com, axboe@kernel.dk
Cc:     mhocko@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org, shenwenbo@zju.edu.cn,
        Yutian Yang <nglaive@gmail.com>
Subject: [PATCH] memcg: charge io_uring related objects
Date:   Mon, 19 Jul 2021 02:20:25 -0400
Message-Id: <1626675625-9883-1-git-send-email-nglaive@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This patch is a more complete version than the previous one, adding
accounting flags to nearly all syscall-triggerable kernel object 
allocations. The patch does not account for temporary objects, i.e., 
objects that are freed soon after allocation, to avoid meaningless 
performance penalty.

Thanks!

Yutian Yang,
Zhejiang University


Signed-off-by: Yutian Yang <nglaive@gmail.com>
---
 fs/io-wq.c    |  6 +++---
 fs/io_uring.c | 54 +++++++++++++++++++++++++--------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index f72d53848..ab31d01cc 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -1086,11 +1086,11 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	if (WARN_ON_ONCE(!data->free_work || !data->do_work))
 		return ERR_PTR(-EINVAL);
 
-	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
+	wq = kzalloc(sizeof(*wq), GFP_KERNEL_ACCOUNT);
 	if (!wq)
 		return ERR_PTR(-ENOMEM);
 
-	wq->wqes = kcalloc(nr_node_ids, sizeof(struct io_wqe *), GFP_KERNEL);
+	wq->wqes = kcalloc(nr_node_ids, sizeof(struct io_wqe *), GFP_KERNEL_ACCOUNT);
 	if (!wq->wqes)
 		goto err_wq;
 
@@ -1111,7 +1111,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 		if (!node_online(alloc_node))
 			alloc_node = NUMA_NO_NODE;
-		wqe = kzalloc_node(sizeof(struct io_wqe), GFP_KERNEL, alloc_node);
+		wqe = kzalloc_node(sizeof(struct io_wqe), GFP_KERNEL_ACCOUNT, alloc_node);
 		if (!wqe)
 			goto err;
 		wq->wqes[node] = wqe;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index d0b7332ca..f323c99ad 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1177,7 +1177,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	struct io_ring_ctx *ctx;
 	int hash_bits;
 
-	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
 	if (!ctx)
 		return NULL;
 
@@ -1195,13 +1195,13 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 		hash_bits = 1;
 	ctx->cancel_hash_bits = hash_bits;
 	ctx->cancel_hash = kmalloc((1U << hash_bits) * sizeof(struct hlist_head),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 	if (!ctx->cancel_hash)
 		goto err;
 	__hash_init(ctx->cancel_hash, 1U << hash_bits);
 
 	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free,
-			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
+			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL_ACCOUNT))
 		goto err;
 
 	ctx->flags = p->flags;
@@ -1311,7 +1311,7 @@ static bool io_identity_cow(struct io_kiocb *req)
 	if (req->work.flags & IO_WQ_WORK_CREDS)
 		creds = req->work.identity->creds;
 
-	id = kmemdup(req->work.identity, sizeof(*id), GFP_KERNEL);
+	id = kmemdup(req->work.identity, sizeof(*id), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!id)) {
 		req->work.flags |= IO_WQ_WORK_CANCEL;
 		return false;
@@ -3235,7 +3235,7 @@ static void io_req_map_rw(struct io_kiocb *req, const struct iovec *iovec,
 static inline int __io_alloc_async_data(struct io_kiocb *req)
 {
 	WARN_ON_ONCE(!io_op_defs[req->opcode].async_size);
-	req->async_data = kmalloc(io_op_defs[req->opcode].async_size, GFP_KERNEL);
+	req->async_data = kmalloc(io_op_defs[req->opcode].async_size, GFP_KERNEL_ACCOUNT);
 	return req->async_data == NULL;
 }
 
@@ -4018,7 +4018,7 @@ static int io_add_buffers(struct io_provide_buf *pbuf, struct io_buffer **head)
 	int i, bid = pbuf->bid;
 
 	for (i = 0; i < pbuf->nbufs; i++) {
-		buf = kmalloc(sizeof(*buf), GFP_KERNEL);
+		buf = kmalloc(sizeof(*buf), GFP_KERNEL_ACCOUNT);
 		if (!buf)
 			break;
 
@@ -4058,7 +4058,7 @@ static int io_provide_buffers(struct io_kiocb *req, bool force_nonblock,
 
 	if (!list) {
 		ret = idr_alloc(&ctx->io_buffer_idr, head, p->bgid, p->bgid + 1,
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 		if (ret < 0) {
 			__io_remove_buffers(ctx, head, p->bgid, -1U);
 			goto out;
@@ -5872,7 +5872,7 @@ static int io_req_defer(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 			return ret;
 	}
 	io_prep_async_link(req);
-	de = kmalloc(sizeof(*de), GFP_KERNEL);
+	de = kmalloc(sizeof(*de), GFP_KERNEL_ACCOUNT);
 	if (!de)
 		return -ENOMEM;
 
@@ -7165,7 +7165,7 @@ static struct io_sq_data *io_get_sq_data(struct io_uring_params *p)
 	if (p->flags & IORING_SETUP_ATTACH_WQ)
 		return io_attach_sq_data(p);
 
-	sqd = kzalloc(sizeof(*sqd), GFP_KERNEL);
+	sqd = kzalloc(sizeof(*sqd), GFP_KERNEL_ACCOUNT);
 	if (!sqd)
 		return ERR_PTR(-ENOMEM);
 
@@ -7251,11 +7251,11 @@ static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
 	struct sk_buff *skb;
 	int i, nr_files;
 
-	fpl = kzalloc(sizeof(*fpl), GFP_KERNEL);
+	fpl = kzalloc(sizeof(*fpl), GFP_KERNEL_ACCOUNT);
 	if (!fpl)
 		return -ENOMEM;
 
-	skb = alloc_skb(0, GFP_KERNEL);
+	skb = alloc_skb(0, GFP_KERNEL_ACCOUNT);
 	if (!skb) {
 		kfree(fpl);
 		return -ENOMEM;
@@ -7346,7 +7346,7 @@ static int io_sqe_alloc_file_tables(struct fixed_file_data *file_data,
 
 		this_files = min(nr_files, IORING_MAX_FILES_TABLE);
 		table->files = kcalloc(this_files, sizeof(struct file *),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 		if (!table->files)
 			break;
 		nr_files -= this_files;
@@ -7504,12 +7504,12 @@ static struct fixed_file_ref_node *alloc_fixed_file_ref_node(
 {
 	struct fixed_file_ref_node *ref_node;
 
-	ref_node = kzalloc(sizeof(*ref_node), GFP_KERNEL);
+	ref_node = kzalloc(sizeof(*ref_node), GFP_KERNEL_ACCOUNT);
 	if (!ref_node)
 		return NULL;
 
 	if (percpu_ref_init(&ref_node->refs, io_file_data_ref_zero,
-			    0, GFP_KERNEL)) {
+			    0, GFP_KERNEL_ACCOUNT)) {
 		kfree(ref_node);
 		return NULL;
 	}
@@ -7543,7 +7543,7 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	if (nr_args > IORING_MAX_FIXED_FILES)
 		return -EMFILE;
 
-	file_data = kzalloc(sizeof(*ctx->file_data), GFP_KERNEL);
+	file_data = kzalloc(sizeof(*ctx->file_data), GFP_KERNEL_ACCOUNT);
 	if (!file_data)
 		return -ENOMEM;
 	file_data->ctx = ctx;
@@ -7553,12 +7553,12 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 
 	nr_tables = DIV_ROUND_UP(nr_args, IORING_MAX_FILES_TABLE);
 	file_data->table = kcalloc(nr_tables, sizeof(*file_data->table),
-				   GFP_KERNEL);
+				   GFP_KERNEL_ACCOUNT);
 	if (!file_data->table)
 		goto out_free;
 
 	if (percpu_ref_init(&file_data->refs, io_file_ref_kill,
-				PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
+				PERCPU_REF_ALLOW_REINIT, GFP_KERNEL_ACCOUNT))
 		goto out_free;
 
 	if (io_sqe_alloc_file_tables(file_data, nr_tables, nr_args))
@@ -7679,7 +7679,7 @@ static int io_queue_file_removal(struct fixed_file_data *data,
 	struct io_file_put *pfile;
 	struct fixed_file_ref_node *ref_node = data->node;
 
-	pfile = kzalloc(sizeof(*pfile), GFP_KERNEL);
+	pfile = kzalloc(sizeof(*pfile), GFP_KERNEL_ACCOUNT);
 	if (!pfile)
 		return -ENOMEM;
 
@@ -7850,11 +7850,11 @@ static int io_uring_alloc_task_context(struct task_struct *task)
 	struct io_uring_task *tctx;
 	int ret;
 
-	tctx = kmalloc(sizeof(*tctx), GFP_KERNEL);
+	tctx = kmalloc(sizeof(*tctx), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!tctx))
 		return -ENOMEM;
 
-	ret = percpu_counter_init(&tctx->inflight, 0, GFP_KERNEL);
+	ret = percpu_counter_init(&tctx->inflight, 0, GFP_KERNEL_ACCOUNT);
 	if (unlikely(ret)) {
 		kfree(tctx);
 		return ret;
@@ -8038,7 +8038,7 @@ static void io_mem_free(void *ptr)
 
 static void *io_mem_alloc(size_t size)
 {
-	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP |
+	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP |
 				__GFP_NORETRY;
 
 	return (void *) __get_free_pages(gfp_flags, get_order(size));
@@ -8218,7 +8218,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		return -EINVAL;
 
 	ctx->user_bufs = kcalloc(nr_args, sizeof(struct io_mapped_ubuf),
-					GFP_KERNEL);
+					GFP_KERNEL_ACCOUNT);
 	if (!ctx->user_bufs)
 		return -ENOMEM;
 
@@ -8268,7 +8268,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 		}
 
 		imu->bvec = kvmalloc_array(nr_pages, sizeof(struct bio_vec),
-						GFP_KERNEL);
+						GFP_KERNEL_ACCOUNT);
 		ret = -ENOMEM;
 		if (!imu->bvec)
 			goto err;
@@ -8725,7 +8725,7 @@ static int io_uring_add_task_file(struct io_ring_ctx *ctx, struct file *file)
 		if (!old) {
 			get_file(file);
 			ret = xa_err(xa_store(&tctx->xa, (unsigned long)file,
-						file, GFP_KERNEL));
+						file, GFP_KERNEL_ACCOUNT));
 			if (ret) {
 				fput(file);
 				return ret;
@@ -9538,14 +9538,14 @@ static int io_register_personality(struct io_ring_ctx *ctx)
 	struct io_identity *id;
 	int ret;
 
-	id = kmalloc(sizeof(*id), GFP_KERNEL);
+	id = kmalloc(sizeof(*id), GFP_KERNEL_ACCOUNT);
 	if (unlikely(!id))
 		return -ENOMEM;
 
 	io_init_identity(id);
 	id->creds = get_current_cred();
 
-	ret = idr_alloc_cyclic(&ctx->personality_idr, id, 1, USHRT_MAX, GFP_KERNEL);
+	ret = idr_alloc_cyclic(&ctx->personality_idr, id, 1, USHRT_MAX, GFP_KERNEL_ACCOUNT);
 	if (ret < 0) {
 		put_cred(id->creds);
 		kfree(id);
@@ -9874,7 +9874,7 @@ static int __init io_uring_init(void)
 
 	BUILD_BUG_ON(ARRAY_SIZE(io_op_defs) != IORING_OP_LAST);
 	BUILD_BUG_ON(__REQ_F_LAST_BIT >= 8 * sizeof(int));
-	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC);
+	req_cachep = KMEM_CACHE(io_kiocb, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
 	return 0;
 };
 __initcall(io_uring_init);
-- 
2.25.1

