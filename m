Return-Path: <cgroups+bounces-15834-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDHZOBLwAmrpywEAu9opvQ
	(envelope-from <cgroups+bounces-15834-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:17:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950451D7A0
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B41630B8C62
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01C33A3E99;
	Tue, 12 May 2026 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M39vrfiq"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86603A6F0D
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 09:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577119; cv=none; b=TSEXm+NUn8by39WWySPsfxtCGCUGbFnBK8NJbJKK/UN2Cxp1EGpwdhojFYlUfoOaYANVhq3DdZRq7wVlB9Pn4P0YtsvibiSWHC0Eny8Bn02728O4Mbs2uKDDg2QbjRaj77Ido6NyTBTsS+Z1RuH6Ma2K/tlQxNSekPyxInaZNV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577119; c=relaxed/simple;
	bh=vgP3BSi+pKTi5BKG4jjd/BvwaZwWNIPAQ8TXdaMjUhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llXiUhWDZblmWjLPdRSk/km9xmT0xGrtihHicJ93M3KHrB1iMc2qBp6Al48bXIRkrqJ2stJ+cA7CCKWWhMdE9Eh/9BqKeY9nvP6teXfn/LbziFPcxLmR1xC2iNEwOZ6JRJxfHumU0Kjah2GtzP2VlSjZKFZt7bsEswr+vqzoO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M39vrfiq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778577116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CQEJ5v5FyoWaxXZTn+HL4PsS7r3tZw5G+G6Pr5P0n4=;
	b=M39vrfiqoStAZzNMThyGn+L480dVyby4CvR3D58PK6/oe+swnfYEgf+2r+9kB2pFduFHLb
	Ycgz20JNNEA0qxadhnQkunWBR3YP68L+lWmiduPBm8TXL9QH2lSChNzfRJmpMus44nDNBY
	c6BLn/4HZLiRZg4pve5pjqQ9oy+5rqk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-6iXquA2jN8y67ceKdZ1_IQ-1; Tue,
 12 May 2026 05:11:50 -0400
X-MC-Unique: 6iXquA2jN8y67ceKdZ1_IQ-1
X-Mimecast-MFC-AGG-ID: 6iXquA2jN8y67ceKdZ1_IQ_1778577105
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F51A19560B7;
	Tue, 12 May 2026 09:11:44 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E84F3002D31;
	Tue, 12 May 2026 09:11:36 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 12 May 2026 11:10:44 +0200
Subject: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
In-Reply-To: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778577077; l=8921;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=vgP3BSi+pKTi5BKG4jjd/BvwaZwWNIPAQ8TXdaMjUhY=;
 b=w+q19gabxB2RmmKPSce904HwYHkXAkOdQr54pAolLRTefvnlQgtTzUlnBbAobkzoJWVftPUMI
 pqfdVtzfigGA2ux1lpW97EKJyuRbl177/g8GqiYdf+6Rc5CXliS5DfQ
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 6950451D7A0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15834-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,linaro.org,amd.com,linux.dev,linux-foundation.org,collabora.com,arm.com,google.com,paul-moore.com,namei.org,hallyn.com,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aesteve@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On embedded platforms a central process often allocates dma-buf
memory on behalf of client applications. Without a way to
attribute the charge to the requesting client's cgroup, the
cost lands on the allocator, making per-cgroup memory limits
ineffective for the actual consumers.

Add charge_pid_fd to struct dma_heap_allocation_data. When set to
a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
the mem_accounting module parameter enabled, the buffer is charged
to the allocator's own cgroup.

Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
page allocations. Keeping __GFP_ACCOUNT would charge the same pages
twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
all accounting through a single MEMCG_DMABUF path.

Usage examples:

  1. Central allocator charging to a client at allocation time.
     The allocator knows the client's PID (e.g., from binder's
     sender_pid) and uses pidfd to attribute the charge:

       pid_t client_pid = txn->sender_pid;
       int pidfd = pidfd_open(client_pid, 0);

       struct dma_heap_allocation_data alloc = {
           .len             = buffer_size,
           .fd_flags        = O_RDWR | O_CLOEXEC,
           .charge_pid_fd   = pidfd,
       };
       ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
       close(pidfd);
       /* alloc.fd is now charged to client's cgroup */

  2. Default allocation (no pidfd, mem_accounting=1).
     When charge_pid_fd is not set and the mem_accounting module
     parameter is enabled, the buffer is charged to the allocator's
     own cgroup:

       struct dma_heap_allocation_data alloc = {
           .len      = buffer_size,
           .fd_flags = O_RDWR | O_CLOEXEC,
       };
       ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
       /* charged to current process's cgroup */

Current limitations:

 - Single-owner model: a dma-buf carries one memcg charge regardless of
   how many processes share it. Means only the first owner (and exporter)
   of the shared buffer bears the charge.
 - Only memcg accounting supported. While this makes sense for system
   heap buffers, other heaps (e.g., CMA heaps) will require selectively
   charging also for the dmem controller.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  5 ++--
 drivers/dma-buf/dma-buf.c               | 16 ++++---------
 drivers/dma-buf/dma-heap.c              | 42 ++++++++++++++++++++++++++++++---
 drivers/dma-buf/heaps/system_heap.c     |  2 --
 include/uapi/linux/dma-heap.h           |  6 +++++
 5 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8bdbc2e866430..824d269531eb1 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1636,8 +1636,9 @@ The following nested keys are defined.
 		structures.
 
 	  dmabuf (npn)
-		Amount of memory used for exported DMA buffers allocated by the cgroup.
-		Stays with the allocating cgroup regardless of how the buffer is shared.
+		Amount of memory used for exported DMA buffers allocated by or on
+		behalf of the cgroup. Stays with the allocating cgroup regardless
+		of how the buffer is shared.
 
 	  workingset_refault_anon
 		Number of refaults of previously evicted anonymous pages.
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index ce02377f48908..23fb758b78297 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentry)
 	 */
 	BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
 
-	mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
-	mem_cgroup_put(dmabuf->memcg);
+	if (dmabuf->memcg) {
+		mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
+					  PAGE_ALIGN(dmabuf->size) / PAGE_SIZE);
+		mem_cgroup_put(dmabuf->memcg);
+	}
 
 	dmabuf->ops->release(dmabuf);
 
@@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 		dmabuf->resv = resv;
 	}
 
-	dmabuf->memcg = get_mem_cgroup_from_mm(current->mm);
-	if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->size) / PAGE_SIZE,
-				      GFP_KERNEL)) {
-		ret = -ENOMEM;
-		goto err_memcg;
-	}
-
 	file->private_data = dmabuf;
 	file->f_path.dentry->d_fsdata = dmabuf;
 	dmabuf->file = file;
@@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_buf_export_info *exp_info)
 
 	return dmabuf;
 
-err_memcg:
-	mem_cgroup_put(dmabuf->memcg);
 err_file:
 	fput(file);
 err_module:
diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index ac5f8685a6494..ff6e259afcdc0 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -7,13 +7,17 @@
  */
 
 #include <linux/cdev.h>
+#include <linux/cgroup.h>
 #include <linux/device.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
+#include <linux/memcontrol.h>
+#include <linux/sched/mm.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/nospec.h>
+#include <linux/pidfd.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/xarray.h>
@@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
 		 "Enable cgroup-based memory accounting for dma-buf heap allocations (default=false).");
 
 static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
-				 u32 fd_flags,
-				 u64 heap_flags)
+				 u32 fd_flags, u64 heap_flags,
+				 struct mem_cgroup *charge_to)
 {
 	struct dma_buf *dmabuf;
+	unsigned int nr_pages;
+	struct mem_cgroup *memcg = charge_to;
 	int fd;
 
 	/*
@@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
 	if (IS_ERR(dmabuf))
 		return PTR_ERR(dmabuf);
 
+	nr_pages = len / PAGE_SIZE;
+
+	if (memcg)
+		css_get(&memcg->css);
+	else if (mem_accounting)
+		memcg = get_mem_cgroup_from_mm(current->mm);
+
+	if (memcg) {
+		if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERNEL)) {
+			mem_cgroup_put(memcg);
+			dma_buf_put(dmabuf);
+			return -ENOMEM;
+		}
+		dmabuf->memcg = memcg;
+	}
+
 	fd = dma_buf_fd(dmabuf, fd_flags);
 	if (fd < 0) {
 		dma_buf_put(dmabuf);
@@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
 {
 	struct dma_heap_allocation_data *heap_allocation = data;
 	struct dma_heap *heap = file->private_data;
+	struct mem_cgroup *memcg = NULL;
+	struct task_struct *task;
+	unsigned int pidfd_flags;
 	int fd;
 
 	if (heap_allocation->fd)
@@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file *file, void *data)
 	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
 		return -EINVAL;
 
+	if (heap_allocation->charge_pid_fd) {
+		task = pidfd_get_task(heap_allocation->charge_pid_fd, &pidfd_flags);
+		if (IS_ERR(task))
+			return PTR_ERR(task);
+
+		memcg = get_mem_cgroup_from_mm(task->mm);
+		put_task_struct(task);
+	}
+
 	fd = dma_heap_buffer_alloc(heap, heap_allocation->len,
 				   heap_allocation->fd_flags,
-				   heap_allocation->heap_flags);
+				   heap_allocation->heap_flags,
+				   memcg);
+	mem_cgroup_put(memcg);
 	if (fd < 0)
 		return fd;
 
diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 03c2b87cb1112..95d7688167b93 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsigned long size,
 		if (max_order < orders[i])
 			continue;
 		flags = order_flags[i];
-		if (mem_accounting)
-			flags |= __GFP_ACCOUNT;
 		page = alloc_pages(flags, orders[i]);
 		if (!page)
 			continue;
diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-heap.h
index a4cf716a49fa6..e02b0f8cbc6a1 100644
--- a/include/uapi/linux/dma-heap.h
+++ b/include/uapi/linux/dma-heap.h
@@ -29,6 +29,10 @@
  *			handle to the allocated dma-buf
  * @fd_flags:		file descriptor flags used when allocating
  * @heap_flags:		flags passed to heap
+ * @charge_pid_fd:	optional pidfd of the process whose cgroup should be
+ *			charged for this allocation; 0 means charge the calling
+ *			process's cgroup
+ * @__padding:		reserved, must be zero
  *
  * Provided by userspace as an argument to the ioctl
  */
@@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
 	__u32 fd;
 	__u32 fd_flags;
 	__u64 heap_flags;
+	__u32 charge_pid_fd;
+	__u32 __padding;
 };
 
 #define DMA_HEAP_IOC_MAGIC		'H'

-- 
2.53.0


