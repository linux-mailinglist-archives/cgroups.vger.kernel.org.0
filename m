Return-Path: <cgroups+bounces-15837-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CeCIXDvAmryygEAu9opvQ
	(envelope-from <cgroups+bounces-15837-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:14:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 288C751D6A5
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EEF03031399
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28733B7B6B;
	Tue, 12 May 2026 09:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uh6J852O"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2678D47F2DF
	for <cgroups@vger.kernel.org>; Tue, 12 May 2026 09:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577141; cv=none; b=q4ZPkB3OJH4nUb+hcyaSKirHe19Fh7/3jYtM8mDWK3tkS0dfy0BhnyUITclxxxcS/fhuyMOk0PE9Y20nVGY95i/ku8qlSGKloGThjLnX+NZqpz3cnfOTwTFncRNdOjqtd4bfpfBue/IphyZ8+0c+nIzOz7vDIroEXuioqOT6iSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577141; c=relaxed/simple;
	bh=nQsELqjYAoKKjD7Sw4FUo7hzScTngPqspIk+Zg1Nxjc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1EOQHRM7cnfreg3PFcsxFPR28vHHRJ5CuzIQKcS5XJzNcMkvuHHaNGA7hstw65f4SjZ4OwP/bn2QAxBK806ySPzOesvULBjslYJDNKtpN19rVoLi0IQqnqUlFwO8rwJM2thjsRwnS+aeH2g6o/g64+TMwZgnJwR3jDjR8R5FHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uh6J852O; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778577138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ovmOM1aSxsE3VS8oIg1YD9tiz5GV0epdWhQXrnHzQFI=;
	b=Uh6J852OTy1DK5CSUu/IkCbqAf/px0VkHjwid5shV5qPxgGAT/Jky9k6RukcaCfhhJtW14
	SBMkFvtnLCpcTSeyQ6VS9vP4WH3Qw/QC05DeONTMjJZa4D1XvtS8mDSsKIky5pQF3yz/+5
	6mdUeJm7YJ8Ewp1UwP2MEMNhrjfWyFM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-Jt8XvvfuOayLzg007SoGCg-1; Tue,
 12 May 2026 05:12:14 -0400
X-MC-Unique: Jt8XvvfuOayLzg007SoGCg-1
X-Mimecast-MFC-AGG-ID: Jt8XvvfuOayLzg007SoGCg_1778577131
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5556E1800372;
	Tue, 12 May 2026 09:12:10 +0000 (UTC)
Received: from [192.168.1.153] (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E117E30001BB;
	Tue, 12 May 2026 09:12:01 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 12 May 2026 11:10:47 +0200
Subject: [PATCH RFC 5/5] selftests/dmabuf-heaps: Add dma-buf memcg
 accounting tests
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-v2_20230123_tjmercier_google_com-v1-5-6326701c3691@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778577077; l=17411;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=nQsELqjYAoKKjD7Sw4FUo7hzScTngPqspIk+Zg1Nxjc=;
 b=ZBPlHllGFd8Vfmd5XUfWcglgvVhK90KjiOlyAUA5Kozs0rtNYCkc/dKXhAlQDCjPD/IuZDjCE
 ZFQOU1rQWCUD2ty30KfpLPxOwHDEtg+R7jgXyBVOls5N0JGfmMVW3MA
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 288C751D6A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15837-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmtest.sh:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add tests for the new charge_pid_fd field in struct
dma_heap_allocation_data.

When the charge_pid_fd feature is absent (unpatched kernel),
the probe in pidfd_alloc_supported() detects this and the
tests are skipped gracefully.

Add vmtest.sh similar to other subsystem suites, to orchestrate
building the selftests (optionally with a freshly compiled kernel)
inside a virtme-ng VM, so the tests can be run without modifying
the host system. Add a config fragment with required Kconfig symbols.

Also add test_memcg_dmabuf() to the existing test_memcontrol suite
to verify end-to-end cross-cgroup accounting: a parent process opens
a pidfd for a child in a separate cgroup, allocates a dma-buf via
DMA_HEAP_IOCTL_ALLOC with that pidfd, and asserts that memory.stat
dmabuf in the child's cgroup reflects the allocation. If the dmabuf
key is missing (unpatched kernel) or /dev/dma_heap/system is absent,
the test is skipped.

Assisted-by: Claude:claude-sonnet-4-6 Cursor
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 tools/testing/selftests/cgroup/Makefile            |   2 +-
 tools/testing/selftests/cgroup/test_memcontrol.c   | 143 +++++++++++++-
 tools/testing/selftests/dmabuf-heaps/config        |   1 +
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 126 ++++++++++++-
 tools/testing/selftests/dmabuf-heaps/vmtest.sh     | 205 +++++++++++++++++++++
 5 files changed, 473 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/selftests/cgroup/Makefile
index e01584c2189ac..9edfc9f1de5c4 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -Wall -pthread
+CFLAGS += -Wall -pthread $(KHDR_INCLUDES)
 
 all: ${HELPER_PROGS}
 
diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
index b43da9bc20c49..b6a228407530f 100644
--- a/tools/testing/selftests/cgroup/test_memcontrol.c
+++ b/tools/testing/selftests/cgroup/test_memcontrol.c
@@ -19,9 +19,17 @@
 #include <errno.h>
 #include <sys/mman.h>
 
+#include <linux/dma-heap.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+
+#include "../pidfd/pidfd.h"
 #include "kselftest.h"
 #include "cgroup_util.h"
 
+#define DMA_HEAP_SYSTEM		"/dev/dma_heap/system"
+#define ONE_MEG			(1024 * 1024)
+
 #define MEMCG_SOCKSTAT_WAIT_RETRIES        30
 
 static bool has_localevents;
@@ -1762,6 +1770,125 @@ static int test_memcg_inotify_delete_dir(const char *root)
 	return ret;
 }
 
+static int memcg_dmabuf_child(const char *cgroup, void *arg)
+{
+	pause();
+	return 0;
+}
+
+/*
+ * This test allocates a dma-buf via DMA_HEAP_IOCTL_ALLOC with a pidfd
+ * pointing to a child process in a separate cgroup, then checks that
+ * memory.stat[dmabuf] in the child's cgroup rises by the allocation size
+ * and returns to zero after the buffer fd is closed.
+ */
+static int test_memcg_dmabuf(const char *root)
+{
+	char *parent = NULL, *child_cg = NULL;
+	int ret = KSFT_FAIL;
+	int heap_fd = -1, dmabuf_fd = -1, pidfd = -1;
+	pid_t child_pid;
+	int child_status;
+	long dmabuf_stat;
+	struct dma_heap_allocation_data alloc = {
+		.len      = ONE_MEG,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+	};
+
+	if (access(DMA_HEAP_SYSTEM, R_OK | W_OK)) {
+		ret = KSFT_SKIP;
+		goto cleanup;
+	}
+
+	parent = cg_name(root, "dmabuf_memcg_test");
+	if (!parent)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup_parent;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup_parent;
+
+	child_cg = cg_name(parent, "child");
+	if (!child_cg)
+		goto cleanup_parent;
+
+	if (cg_create(child_cg))
+		goto cleanup_parent;
+
+	child_pid = cg_run_nowait(child_cg, memcg_dmabuf_child, NULL);
+	if (child_pid < 0)
+		goto cleanup_child;
+
+	if (cg_wait_for_proc_count(child_cg, 1))
+		goto cleanup_kill;
+
+	pidfd = sys_pidfd_open(child_pid, 0);
+	if (pidfd < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup_kill;
+	}
+
+	heap_fd = open(DMA_HEAP_SYSTEM, O_RDWR);
+	if (heap_fd < 0) {
+		ret = KSFT_SKIP;
+		goto cleanup_pidfd;
+	}
+
+	alloc.charge_pid_fd = (__u32)pidfd;
+	if (ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc) < 0)
+		goto cleanup_heap;
+	dmabuf_fd = (int)alloc.fd;
+
+	dmabuf_stat = cg_read_key_long(child_cg, "memory.stat", "dmabuf ");
+	if (dmabuf_stat == -1) {
+		ret = KSFT_SKIP;
+		goto cleanup_dmabuf;
+	}
+	if (dmabuf_stat != ONE_MEG)
+		dmabuf_stat = cg_read_key_long_poll(child_cg, "memory.stat",
+						    "dmabuf ", ONE_MEG,
+						    15, 200000);
+	if (dmabuf_stat != ONE_MEG) {
+		fprintf(stderr, "Expected dmabuf stat %d, got %ld\n",
+			ONE_MEG, dmabuf_stat);
+		goto cleanup_dmabuf;
+	}
+
+	close(dmabuf_fd);
+	dmabuf_fd = -1;
+
+	dmabuf_stat = cg_read_key_long_poll(child_cg, "memory.stat",
+					    "dmabuf ", 0, 15, 200000);
+	if (dmabuf_stat != 0) {
+		fprintf(stderr, "Expected dmabuf stat 0 after close, got %ld\n",
+			dmabuf_stat);
+		goto cleanup_heap;
+	}
+
+	ret = KSFT_PASS;
+
+cleanup_dmabuf:
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+cleanup_heap:
+	close(heap_fd);
+cleanup_pidfd:
+	close(pidfd);
+cleanup_kill:
+	kill(child_pid, SIGTERM);
+	waitpid(child_pid, &child_status, 0);
+cleanup_child:
+	cg_destroy(child_cg);
+	free(child_cg);
+cleanup_parent:
+	cg_destroy(parent);
+	free(parent);
+cleanup:
+	return ret;
+}
+
 #define T(x) { x, #x }
 struct memcg_test {
 	int (*fn)(const char *root);
@@ -1783,16 +1910,26 @@ struct memcg_test {
 	T(test_memcg_oom_group_score_events),
 	T(test_memcg_inotify_delete_file),
 	T(test_memcg_inotify_delete_dir),
+	T(test_memcg_dmabuf),
 };
 #undef T
 
 int main(int argc, char **argv)
 {
 	char root[PATH_MAX];
-	int i, proc_status;
+	int i, proc_status, plan;
+	const char *filter = NULL;
+
+	if (argc > 1)
+		filter = argv[1];
+
+	plan = 0;
+	for (i = 0; i < ARRAY_SIZE(tests); i++)
+		if (!filter || !strcmp(tests[i].name, filter))
+			plan++;
 
 	ksft_print_header();
-	ksft_set_plan(ARRAY_SIZE(tests));
+	ksft_set_plan(plan);
 	if (cg_find_unified_root(root, sizeof(root), NULL))
 		ksft_exit_skip("cgroup v2 isn't mounted\n");
 
@@ -1818,6 +1955,8 @@ int main(int argc, char **argv)
 	has_localevents = proc_status;
 
 	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (filter && strcmp(tests[i].name, filter))
+			continue;
 		switch (tests[i].fn(root)) {
 		case KSFT_PASS:
 			ksft_test_result_pass("%s\n", tests[i].name);
diff --git a/tools/testing/selftests/dmabuf-heaps/config b/tools/testing/selftests/dmabuf-heaps/config
index be091f1cdfa04..94c8f33b71a28 100644
--- a/tools/testing/selftests/dmabuf-heaps/config
+++ b/tools/testing/selftests/dmabuf-heaps/config
@@ -1,3 +1,4 @@
+CONFIG_MEMCG=y
 CONFIG_DMABUF_HEAPS=y
 CONFIG_DMABUF_HEAPS_SYSTEM=y
 CONFIG_DRM_VGEM=y
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index fc9694fc4e89e..904332b17698a 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -3,6 +3,7 @@
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdint.h>
@@ -10,11 +11,14 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
+#include <sys/syscall.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 
 #include <linux/dma-buf.h>
 #include <linux/dma-heap.h>
 #include <drm/drm.h>
+#include "../pidfd/pidfd.h"
 #include "kselftest.h"
 
 #define DEVPATH "/dev/dma_heap"
@@ -320,6 +324,8 @@ static int dmabuf_heap_alloc_newer(int fd, size_t len, unsigned int flags,
 		__u32 fd;
 		__u32 fd_flags;
 		__u64 heap_flags;
+		__u32 charge_pid_fd;
+		__u32 __padding;
 		__u64 garbage1;
 		__u64 garbage2;
 		__u64 garbage3;
@@ -328,6 +334,8 @@ static int dmabuf_heap_alloc_newer(int fd, size_t len, unsigned int flags,
 		.fd = 0,
 		.fd_flags = O_RDWR | O_CLOEXEC,
 		.heap_flags = flags,
+		.charge_pid_fd = 0,
+		.__padding = 0,
 		.garbage1 = 0xffffffff,
 		.garbage2 = 0x88888888,
 		.garbage3 = 0x11111111,
@@ -390,6 +398,120 @@ static void test_alloc_errors(char *heap_name)
 	close(heap_fd);
 }
 
+static int dmabuf_heap_alloc_pidfd(int fd, size_t len, unsigned int heap_flags,
+				   unsigned int charge_pid_fd, int *dmabuf_fd)
+{
+	struct dma_heap_allocation_data data = {
+		.len = len,
+		.fd = 0,
+		.fd_flags = O_RDWR | O_CLOEXEC,
+		.heap_flags = heap_flags,
+		.charge_pid_fd = charge_pid_fd,
+	};
+	int ret;
+
+	if (!dmabuf_fd)
+		return -EINVAL;
+
+	ret = ioctl(fd, DMA_HEAP_IOCTL_ALLOC, &data);
+	if (ret < 0)
+		return ret;
+	*dmabuf_fd = (int)data.fd;
+	return ret;
+}
+
+/*
+ * Probe whether the kernel honours charge_pid_fd in DMA_HEAP_IOCTL_ALLOC.
+ */
+static bool pidfd_alloc_supported(int heap_fd)
+{
+	int devnull_fd, dmabuf_fd = -1, ret;
+
+	devnull_fd = open("/dev/null", O_RDONLY);
+	if (devnull_fd < 0)
+		return false;
+
+	ret = dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, devnull_fd, &dmabuf_fd);
+	if (dmabuf_fd >= 0) {
+		close(dmabuf_fd);
+		dmabuf_fd = -1;
+	}
+	close(devnull_fd);
+	return ret < 0;
+}
+
+/*
+ * Test: allocate charging the calling process's own cgroup via a self pidfd.
+ */
+static void test_alloc_pidfd_self(char *heap_name)
+{
+	int heap_fd = -1, pidfd = -1, dmabuf_fd = -1, ret;
+
+	heap_fd = dmabuf_heap_open(heap_name);
+
+	if (!pidfd_alloc_supported(heap_fd)) {
+		ksft_test_result_skip("charge_pid_fd not supported by this kernel\n");
+		goto out;
+	}
+
+	pidfd = sys_pidfd_open(getpid(), 0);
+	if (pidfd < 0) {
+		ksft_test_result_skip("pidfd_open not available\n");
+		goto out;
+	}
+
+	ret = dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, pidfd, &dmabuf_fd);
+	ksft_test_result(!ret, "Allocation with self pidfd %d\n", ret);
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	close(pidfd);
+out:
+	close(heap_fd);
+}
+
+/*
+ * Test: allocate charging a child process's cgroup via a child pidfd.
+ */
+static void test_alloc_pidfd_child(char *heap_name)
+{
+	int heap_fd = -1, pidfd = -1, dmabuf_fd = -1;
+	pid_t child_pid;
+	int status, ret;
+
+	heap_fd = dmabuf_heap_open(heap_name);
+
+	if (!pidfd_alloc_supported(heap_fd)) {
+		ksft_test_result_skip("charge_pid_fd not supported by this kernel\n");
+		goto out;
+	}
+
+	child_pid = fork();
+	if (child_pid == 0) {
+		pause();
+		_exit(0);
+	}
+	if (child_pid < 0)
+		ksft_exit_fail_msg("fork failed: %s\n", strerror(errno));
+
+	pidfd = sys_pidfd_open(child_pid, 0);
+	if (pidfd < 0) {
+		kill(child_pid, SIGTERM);
+		waitpid(child_pid, &status, 0);
+		ksft_test_result_skip("pidfd_open for child failed\n");
+		goto out;
+	}
+
+	ret = dmabuf_heap_alloc_pidfd(heap_fd, ONE_MEG, 0, pidfd, &dmabuf_fd);
+	ksft_test_result(!ret, "Allocation with child pidfd %d\n", ret);
+	if (dmabuf_fd >= 0)
+		close(dmabuf_fd);
+	close(pidfd);
+	kill(child_pid, SIGTERM);
+	waitpid(child_pid, &status, 0);
+out:
+	close(heap_fd);
+}
+
 static int numer_of_heaps(void)
 {
 	DIR *d = opendir(DEVPATH);
@@ -420,7 +542,7 @@ int main(void)
 		return KSFT_SKIP;
 	}
 
-	ksft_set_plan(11 * numer_of_heaps());
+	ksft_set_plan(13 * numer_of_heaps());
 
 	while ((dir = readdir(d))) {
 		if (!strncmp(dir->d_name, ".", 2))
@@ -435,6 +557,8 @@ int main(void)
 		test_alloc_zeroed(dir->d_name, ONE_MEG);
 		test_alloc_compat(dir->d_name);
 		test_alloc_errors(dir->d_name);
+		test_alloc_pidfd_self(dir->d_name);
+		test_alloc_pidfd_child(dir->d_name);
 	}
 	closedir(d);
 
diff --git a/tools/testing/selftests/dmabuf-heaps/vmtest.sh b/tools/testing/selftests/dmabuf-heaps/vmtest.sh
new file mode 100755
index 0000000000000..6f1a878384127
--- /dev/null
+++ b/tools/testing/selftests/dmabuf-heaps/vmtest.sh
@@ -0,0 +1,205 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2026 Red Hat
+#
+# Dependencies:
+#		* virtme-ng
+#		* qemu	(used by virtme-ng)
+
+readonly SCRIPT_DIR="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
+readonly KERNEL_CHECKOUT=$(realpath "${SCRIPT_DIR}"/../../../../)
+readonly CGROUP_DIR="${KERNEL_CHECKOUT}/tools/testing/selftests/cgroup"
+
+source "${SCRIPT_DIR}"/../kselftest/ktap_helpers.sh
+
+readonly DMABUF_HEAP_TEST="${SCRIPT_DIR}"/dmabuf-heap
+readonly MEMCONTROL_TEST="${CGROUP_DIR}"/test_memcontrol
+readonly TMP_DIR=$(mktemp -d /tmp/dmabuf-vmtest.XXXXXXXX)
+
+VERBOSE=false
+BUILD=false
+BUILD_HOST=""
+BUILD_HOST_PODMAN_CONTAINER_NAME=""
+
+usage() {
+	echo
+	echo "$0 [OPTIONS]"
+	echo
+	echo "Options"
+	echo "  -b: build the kernel from the current source tree and use it for the VM"
+	echo "  -H: hostname for remote build host (used with -b)"
+	echo "  -p: podman container name for remote build host (used with -b)"
+	echo "      Example: -H beefyserver -p vng"
+
+	echo "  -v: enable verbose vng/qemu output"
+	echo
+
+	exit 1
+}
+
+die() {
+	echo "$*" >&2
+	exit "${KSFT_FAIL}"
+}
+
+cleanup() {
+	rm -rf "${TMP_DIR}"
+}
+
+check_deps() {
+	for dep in vng make; do
+		if [[ ! -x $(command -v "${dep}") ]]; then
+			echo -e "skip:    dependency ${dep} not found!\n"
+			exit "${KSFT_SKIP}"
+		fi
+	done
+
+	if [[ ! -x "${DMABUF_HEAP_TEST}" ]]; then
+		printf "skip:    %s not found!" "${DMABUF_HEAP_TEST}"
+		printf " Please build the kselftest dmabuf-heaps target (or use -b).\n"
+		exit "${KSFT_SKIP}"
+	fi
+
+	if [[ ! -x "${MEMCONTROL_TEST}" ]]; then
+		printf "skip:    %s not found!" "${MEMCONTROL_TEST}"
+		printf " Please build the kselftest cgroup target (or use -b).\n"
+		exit "${KSFT_SKIP}"
+	fi
+}
+
+check_vng() {
+	local tested_versions=("1.36" "1.37")
+	local version
+	local ok=0
+
+	version="$(vng --version)"
+	for tv in "${tested_versions[@]}"; do
+		if [[ "${version}" == *"${tv}"* ]]; then
+			ok=1
+			break
+		fi
+	done
+
+	if [[ "${ok}" -eq 0 ]]; then
+		printf "warning: vng version '%s' has not been tested and may " "${version}" >&2
+		printf "not function properly.\n\tThe following versions have been tested: " >&2
+		echo "${tested_versions[@]}" >&2
+	fi
+}
+
+build_selftests() {
+	make -C "${KERNEL_CHECKOUT}" headers_install \
+		INSTALL_HDR_PATH="${TMP_DIR}/usr" -j"$(nproc)"
+
+	local khdr="-isystem ${TMP_DIR}/usr/include"
+
+	if ! make -C "${SCRIPT_DIR}" KHDR_INCLUDES="${khdr}" -j"$(nproc)"; then
+		die "failed to build dmabuf-heaps selftests"
+	fi
+
+	if ! make -C "${CGROUP_DIR}" KHDR_INCLUDES="${khdr}" \
+		"${MEMCONTROL_TEST}" -j"$(nproc)"; then
+		die "failed to build cgroup/test_memcontrol selftest"
+	fi
+}
+
+handle_build() {
+	if ! ${BUILD}; then
+		return
+	fi
+
+	if [[ ! -d "${KERNEL_CHECKOUT}" ]]; then
+		echo "-b requires vmtest.sh called from the kernel source tree" >&2
+		exit 1
+	fi
+
+	pushd "${KERNEL_CHECKOUT}" &>/dev/null
+
+	if ! vng --kconfig --config "${SCRIPT_DIR}/config"; then
+		die "failed to generate .config for kernel source tree (${KERNEL_CHECKOUT})"
+	fi
+
+	local vng_args=("-v" "--config" "${SCRIPT_DIR}/config" "--build")
+
+	if [[ -n "${BUILD_HOST}" ]]; then
+		vng_args+=("--build-host" "${BUILD_HOST}")
+	fi
+
+	if [[ -n "${BUILD_HOST_PODMAN_CONTAINER_NAME}" ]]; then
+		vng_args+=("--build-host-exec-prefix" \
+			   "podman exec -ti ${BUILD_HOST_PODMAN_CONTAINER_NAME}")
+	fi
+
+	if ! vng "${vng_args[@]}"; then
+		die "failed to build kernel from source tree (${KERNEL_CHECKOUT})"
+	fi
+
+	build_selftests
+
+	popd &>/dev/null
+}
+
+make_runner() {
+	# virtme-ng shares the host filesystem, so TMP_DIR is accessible
+	# inside the VM at the same absolute path.
+	cat > "${TMP_DIR}/run_tests.sh" <<-EOF
+	#!/bin/sh
+	set -u
+	PASS=0; FAIL=0; SKIP=0; N=0
+
+	run() {
+		name="\$1"; shift
+		N=\$((N+1))
+		"\$@"; rc=\$?
+		if   [ \$rc -eq 0 ]; then echo "ok \$N \$name";        PASS=\$((PASS+1))
+		elif [ \$rc -eq 4 ]; then echo "ok \$N \$name # SKIP"; SKIP=\$((SKIP+1))
+		else                      echo "not ok \$N \$name";    FAIL=\$((FAIL+1))
+		fi
+	}
+
+	run "dmabuf-heap charge_pid_fd ioctl"	${DMABUF_HEAP_TEST}
+	run "memcontrol dma-buf memcg"  ${MEMCONTROL_TEST} test_memcg_dmabuf
+	echo "# PASS=\$PASS SKIP=\$SKIP FAIL=\$FAIL"
+	[ \$FAIL -eq 0 ]
+	EOF
+	chmod +x "${TMP_DIR}/run_tests.sh"
+}
+
+run_vm() {
+	local verbose_opt=""
+	local kernel_opt=""
+
+	${VERBOSE} && verbose_opt="--verbose"
+
+	# If we are running from within the kernel source tree, use the kernel
+	# source tree as the kernel to boot, otherwise use the running kernel.
+	if [[ "$(realpath "$(pwd)")" == "${KERNEL_CHECKOUT}"* ]]; then
+		kernel_opt="${KERNEL_CHECKOUT}"
+	fi
+
+	vng --run ${kernel_opt} ${verbose_opt} --user root --memory 512M \
+		--exec "${TMP_DIR}/run_tests.sh"
+}
+
+while getopts :hvbH:p: o
+do
+	case $o in
+	v) VERBOSE=true;;
+	b) BUILD=true;;
+	H) BUILD_HOST=$OPTARG;;
+	p) BUILD_HOST_PODMAN_CONTAINER_NAME=$OPTARG;;
+	h|*) usage;;
+	esac
+done
+shift $((OPTIND-1))
+
+trap cleanup EXIT
+
+check_vng
+handle_build
+check_deps
+make_runner
+
+echo "Booting VM and running tests..."
+run_vm

-- 
2.53.0


