Return-Path: <cgroups+bounces-16275-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PbuJp4GFWokSQcAu9opvQ
	(envelope-from <cgroups+bounces-16275-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:34:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7315CFF53
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BAFC3051D3A
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 02:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC2830B50C;
	Tue, 26 May 2026 02:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QGVmMhZL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F67305691
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 02:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762536; cv=none; b=UUXikbVpPe1XLfnsHRlIkxHum4/WRcR67m/VRFV4W2EJYpUUn/hv5XpXuu3VO1Csoog+2sevdROjF4Otuxje+lC7FwvQ2zJ+yNLDxKzS1EMxTojMUO4/RhZ8BT2ATE1H9TNfytBts/A/IK+SpDbnG65TwYiYzryk2SpMsBk2s/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762536; c=relaxed/simple;
	bh=e7X2eVAmkhgw2vNzLVS2uUCOI+Rw18Q1ZeOV/KkQp9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qjr3N+gQ/0+mdBdQDaNV1Nkr+HguNTGCZFsE4N96LY55ioZathvGnNODbLIbtzTr+1UsZIAHrhE8CNo4yF4q7LiUEuC9h20ENZ4vvpFzAIrJ7nkwznOmft7M/sQ+ilMKHV69gdxp71zzTkeu54ZfExgH3KDCqVBWdN1fdvmE1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QGVmMhZL; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779762522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/EWtRGAXaZ/GNJCbWxnQ3W+mtK+0x2mWrk3Fzf8518s=;
	b=QGVmMhZLX/mU0YjjxSS9k1WBHWgbRtrrHgcswN3R+JFC3uh+kfo4nXYzC9Z+tX2T/2zfYV
	NXMYHphuYAz4AJSSJ9EN9nJIVtwNxYZinXyhWBd3liHSoOagF0ZAlUFMAXb+hJYQeiTnf/
	z4W7JdW6QCFPgyaQjA8JK0JQYMORrW4=
From: Hui Zhu <hui.zhu@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	KP Singh <kpsingh@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	Hao Luo <haoluo@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: geliang@kernel.org,
	baohua@kernel.org,
	Hui Zhu <zhuhui@kylinos.cn>
Subject: [RFC PATCH bpf-next v7 10/11] selftests/bpf: Add selftest for memcg async reclaim via BPF
Date: Tue, 26 May 2026 10:27:55 +0800
Message-ID: <b3af3d0f9a925f79a6e4e7218e8ce84dfbeb5254.1779760876.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1779760876.git.zhuhui@kylinos.cn>
References: <cover.1779760876.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16275-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,cmpxchg.org,linux-foundation.org,davemloft.net,fomichev.me,meta.com,distanz.ch,cestc.cn,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,huaweicloud.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[59];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.988];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,kylinos.cn:mid,kylinos.cn:email,memory.events:url]
X-Rspamd-Queue-Id: EB7315CFF53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Hui Zhu <zhuhui@kylinos.cn>

Add a BPF selftest that demonstrates and validates asynchronous memory
reclaim for a memory cgroup using BPF struct_ops and the BPF workqueue
mechanism.

The BPF program (progs/memcg_async_reclaim.c) registers struct_ops
callbacks for memcg_charged and memcg_uncharged to track the memory
charge/uncharge events of a target cgroup. When accumulated memory
usage exceeds a configured threshold, the memcg_charged callback
enqueues an asynchronous workqueue item via bpf_wq_start(). The
workqueue callback then invokes bpf_try_to_free_mem_cgroup_pages() to
reclaim pages from the target memcg without blocking the charging
context.

The test (prog_tests/memcg_async_reclaim.c) verifies the effectiveness
of this mechanism by:
  1. Running a memory workload (sequential file write + mmap read)
     without the BPF async reclaim program attached, and asserting that
     the memcg "max" event counter increases, confirming that the cgroup
     memory limit is being hit.
  2. Repeating the same workload with the BPF async reclaim program
     active, and asserting that the "max" event counter does NOT
     increase, confirming that proactive async reclaim successfully
     kept memory usage below the hard limit.

A new helper read_cgroup_file() is added to cgroup_helpers.c to
support reading memcg interface files (e.g. memory.events) from within
the test infrastructure.

The new test files are also registered in MAINTAINERS under the Memory
Controller section.

Signed-off-by: Barry Song <baohua@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 MAINTAINERS                                   |   2 +
 tools/testing/selftests/bpf/cgroup_helpers.c  |  41 +++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   2 +
 .../bpf/prog_tests/memcg_async_reclaim.c      | 333 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_async_reclaim.c | 203 +++++++++++
 5 files changed, 581 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_async_reclaim.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1be243e544da..b2e64ef8c60c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6567,7 +6567,9 @@ F:	mm/memcontrol-v1.h
 F:	mm/page_counter.c
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
+F:	tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
 F:	tools/testing/selftests/bpf/prog_tests/memcg_ops.c
+F:	tools/testing/selftests/bpf/progs/memcg_async_reclaim.c
 F:	tools/testing/selftests/bpf/progs/memcg_ops.c
 F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 45cd0b479fe3..22420d2f5199 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -167,6 +167,47 @@ int write_cgroup_file(const char *relative_path, const char *file,
 	return __write_cgroup_file(cgroup_path, file, buf);
 }
 
+/**
+ * read_cgroup_file() - Read content from a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to read from
+ * @buf: Buffer to store the read data
+ * @buf_size: Size of the buffer
+ *
+ * Read the entire content of a cgroup file into the provided buffer.
+ * The buffer will be null-terminated on success.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int read_cgroup_file(const char *relative_path, const char *file,
+		     char *buf, size_t buf_size)
+{
+	char cgroup_path[PATH_MAX - 24];
+	char file_path[PATH_MAX + 1];
+	int fd;
+	ssize_t len;
+
+	if (!relative_path || !file || !buf || buf_size == 0)
+		return -EINVAL;
+
+	format_cgroup_path(cgroup_path, relative_path);
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+
+	fd = open(file_path, O_RDONLY);
+	if (fd < 0)
+		return -errno;
+
+	len = read(fd, buf, buf_size - 1);
+	if (len < 0) {
+		close(fd);
+		return -errno;
+	}
+	close(fd);
+
+	buf[len] = '\0';
+	return 0;
+}
+
 /**
  * write_cgroup_file_parent() - Write to a cgroup file in the parent process
  *                              workdir
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 3857304be874..d722e8ff8dee 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -13,6 +13,8 @@
 int enable_controllers(const char *relative_path, const char *controllers);
 int write_cgroup_file(const char *relative_path, const char *file,
 		      const char *buf);
+int read_cgroup_file(const char *relative_path, const char *file,
+		     char *buf, size_t buf_size);
 int write_cgroup_file_parent(const char *relative_path, const char *file,
 			     const char *buf);
 int cgroup_setup_and_join(const char *relative_path);
diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
new file mode 100644
index 000000000000..bf25967c911c
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_async_reclaim.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory controller eBPF async reclaim test
+ */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <linux/limits.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include "cgroup_helpers.h"
+
+struct bpf_args_s {
+	u64 cgroup_id;
+	u64 limit_bytes;
+};
+
+#include "memcg_async_reclaim.skel.h"
+
+#define FILE_SIZE (64 * 1024 * 1024ul)
+#define BUFFER_SIZE (4096)
+#define CG_LIMIT (32 * 1024 * 1024ul)
+#define CG_DIR1 "/memcg_async_reclaim1"
+#define CG_DIR2 "/memcg_async_reclaim2"
+#define RECLAIM_TRIGGER_SIZE (12 * 1024 * 1024ul)
+
+static int
+setup_max_cgroup(const char *cg_path, u64 cg_max, u64 *cgroup_id,
+		 int *cgroup_fd)
+{
+	int ret;
+	char limit_buf[20];
+
+	*cgroup_fd = create_and_get_cgroup(cg_path);
+	if (!ASSERT_GE(*cgroup_fd, 0, "create_and_get_cgroup"))
+		goto cleanup;
+
+	*cgroup_id = get_cgroup_id(cg_path);
+	if (!ASSERT_GT(*cgroup_id, 0, "get_cgroup_id"))
+		goto cleanup;
+
+	snprintf(limit_buf, 20, "%lu", cg_max);
+	ret = write_cgroup_file(cg_path, "memory.max", limit_buf);
+	if (!ASSERT_OK(ret, "write_cgroup_file memory.max"))
+		goto cleanup;
+
+	ret = write_cgroup_file(cg_path, "memory.swap.max", "0");
+	if (!ASSERT_OK(ret, "write_cgroup_file memory.swap.max"))
+		goto cleanup;
+
+	return ret;
+
+cleanup:
+	close(*cgroup_fd);
+	cleanup_cgroup_environment();
+	return -1;
+}
+
+static int
+setup_bpf(u64 cg_id, int cg_fd, u64 limit_bytes,
+	  struct memcg_async_reclaim **skel_ptr, struct bpf_link **link_ptr)
+{
+	struct memcg_async_reclaim *skel;
+	struct bpf_map *map;
+	struct bpf_link *link = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	struct bpf_args_s bpf_args = {
+		.limit_bytes = limit_bytes,
+		.cgroup_id = cg_id,
+	};
+	LIBBPF_OPTS(bpf_test_run_opts, run_opts,
+		.ctx_in = &bpf_args,
+		.ctx_size_in = sizeof(bpf_args)
+	);
+	int prog_init_fd;
+
+	skel = memcg_async_reclaim__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "memcg_async_reclaim__open_and_load"))
+		goto error;
+
+	prog_init_fd = bpf_program__fd(skel->progs.prog_init);
+	if (!ASSERT_GE(prog_init_fd, 0, "bpf_program__fd"))
+		goto destroy_skel;
+	if (!ASSERT_OK((bpf_prog_test_run_opts(prog_init_fd, &run_opts) ||
+			run_opts.retval), "bpf_prog_test_run_opts"))
+		goto destroy_skel;
+
+	map = bpf_object__find_map_by_name(skel->obj, "mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name mcg_ops"))
+		goto destroy_skel;
+	opts.flags = BPF_F_CGROUP_FD;
+	opts.target_fd = cg_fd;
+	link = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops_opts"))
+		goto destroy_skel;
+
+	*link_ptr = link;
+	*skel_ptr = skel;
+	return 0;
+
+destroy_skel:
+	memcg_async_reclaim__destroy(skel);
+error:
+	return -1;
+}
+
+static int write_file(const char *filename)
+{
+	int ret = -1;
+	size_t written = 0;
+	char *buffer;
+	FILE *fp;
+
+	fp = fopen(filename, "wb");
+	if (!fp)
+		goto out;
+
+	buffer = malloc(BUFFER_SIZE);
+	if (!buffer)
+		goto cleanup_fp;
+
+	memset(buffer, 'A', BUFFER_SIZE);
+
+	while (written < FILE_SIZE) {
+		size_t to_write = (FILE_SIZE - written < BUFFER_SIZE) ?
+				   (FILE_SIZE - written) :
+				   BUFFER_SIZE;
+
+		if (fwrite(buffer, 1, to_write, fp) != to_write)
+			goto cleanup;
+		written += to_write;
+	}
+
+	ret = 0;
+cleanup:
+	free(buffer);
+cleanup_fp:
+	fclose(fp);
+out:
+	return ret;
+}
+
+static int read_file(const char *filename, int iterations)
+{
+	int ret = -1;
+	long page_size = sysconf(_SC_PAGESIZE);
+	char *p;
+	char *map;
+	size_t i;
+	int fd;
+	struct stat sb;
+
+	fd = open(filename, O_RDONLY);
+	if (fd == -1)
+		goto out;
+
+	if (fstat(fd, &sb) == -1)
+		goto cleanup_fd;
+
+	if (sb.st_size != FILE_SIZE) {
+		fprintf(stderr, "File size mismatch: expected %lu, got %lu\n",
+			(unsigned long)FILE_SIZE, (unsigned long)sb.st_size);
+		goto cleanup_fd;
+	}
+
+	map = mmap(NULL, FILE_SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (map == MAP_FAILED)
+		goto cleanup_fd;
+
+	for (int iter = 0; iter < iterations; iter++) {
+		for (i = 0; i < FILE_SIZE; i += page_size) {
+			/* access a byte to trigger page fault */
+			p = &map[i];
+			__asm__ __volatile__("" : : "r"(p) : "memory");
+		}
+
+		if (env.verbosity >= VERBOSE_NORMAL)
+			printf("%s %d %d done\n", __func__, getpid(), iter);
+	}
+
+	if (munmap(map, FILE_SIZE) == -1)
+		goto cleanup_fd;
+
+	ret = 0;
+
+cleanup_fd:
+	close(fd);
+out:
+	return ret;
+}
+
+int get_cgroup_memory_event(const char *relative_path, const char *key,
+			    u64 *value)
+{
+	char buf[1024];
+	char *line, *saveptr1;
+	char *c, *saveptr2;
+	char *val_str = NULL;
+	bool found = false;
+	int ret, i;
+
+	if (!key || !value)
+		return -EINVAL;
+
+	ret = read_cgroup_file(relative_path, "memory.events",
+			       buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
+
+	for (line = strtok_r(buf, "\n", &saveptr1); line;
+	     line = strtok_r(NULL, "\n", &saveptr1)) {
+		val_str = NULL;
+		i = 0;
+
+		for (c = strtok_r(line, " ", &saveptr2); c;
+		     c = strtok_r(NULL, " ", &saveptr2)) {
+			if (i == 0) {
+				if (strcmp(c, key) != 0)
+					break;
+			} else if (i == 1) {
+				val_str = c;
+				break;
+			}
+			i++;
+		}
+
+		if (val_str) {
+			char *endptr;
+			u64 v;
+
+			v = strtoull(val_str, &endptr, 10);
+			if (endptr == val_str)
+				return -EINVAL;
+
+			*value = v;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		return -ENOENT;
+
+	return 0;
+}
+
+void test_memcg_async_reclaim(void)
+{
+	u64 cgroup_id, old_max, new_max;
+	int cgroup_fd, ret;
+	struct memcg_async_reclaim *skel;
+	struct bpf_link *link = NULL;
+	char data_file1[] = "/tmp/test_data_1_XXXXXX";
+	char data_file2[] = "/tmp/test_data_2_XXXXXX";
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_environment"))
+		return;
+
+	// test without async_reclaim
+	if (!ASSERT_OK(setup_max_cgroup(CG_DIR1, CG_LIMIT, &cgroup_id,
+					&cgroup_fd), "setup_max_cgroup"))
+		goto cleanup_cgroup;
+	if (!ASSERT_OK(join_cgroup(CG_DIR1), "join_cgroup"))
+		goto close_cgroup_fd;
+	ret = mkstemp(data_file1);
+	if (!ASSERT_GE(ret, 0, "mkstemp"))
+		goto close_cgroup_fd;
+	close(ret);
+
+	if (!ASSERT_OK(get_cgroup_memory_event(CG_DIR1, "max", &old_max),
+					       "get_cgroup_memory_event"))
+		goto cleanup_data_file1;
+	if (!ASSERT_OK(write_file(data_file1), "write_file"))
+		goto cleanup_data_file1;
+	if (!ASSERT_OK(read_file(data_file1, 2), "read_file"))
+		goto cleanup_data_file1;
+	if (!ASSERT_OK(get_cgroup_memory_event(CG_DIR1, "max", &new_max),
+					       "get_cgroup_memory_event"))
+		goto cleanup_data_file1;
+	if (!ASSERT_GT(new_max, old_max, "memcg max event not trigger"))
+		goto cleanup_data_file1;
+
+	// test with async_reclaim
+	close(cgroup_fd);
+	if (!ASSERT_OK(setup_max_cgroup(CG_DIR2, CG_LIMIT, &cgroup_id,
+					&cgroup_fd), "setup_max_cgroup"))
+		goto cleanup_data_file1;
+	if (!ASSERT_OK(join_cgroup(CG_DIR2), "join_cgroup"))
+		goto cleanup_data_file1;
+	ret = mkstemp(data_file2);
+	if (!ASSERT_GE(ret, 0, "mkstemp"))
+		goto cleanup_data_file1;
+	close(ret);
+
+	if (!ASSERT_OK(setup_bpf(cgroup_id, cgroup_fd, RECLAIM_TRIGGER_SIZE,
+				 &skel, &link),
+		       "setup_bpf"))
+		goto cleanup_data_file2;
+	if (!ASSERT_OK(get_cgroup_memory_event(CG_DIR2, "max", &old_max),
+					       "get_cgroup_memory_event"))
+		goto cleanup;
+	if (!ASSERT_OK(write_file(data_file2), "write_file"))
+		goto cleanup;
+	if (!ASSERT_OK(read_file(data_file2, 2), "read_file"))
+		goto cleanup;
+	if (!ASSERT_OK(get_cgroup_memory_event(CG_DIR2, "max", &new_max),
+					       "get_cgroup_memory_event"))
+		goto cleanup;
+	if (!ASSERT_EQ(new_max, old_max, "memcg max event triggered"))
+		goto cleanup;
+
+cleanup:
+	bpf_link__destroy(link);
+	memcg_async_reclaim__detach(skel);
+	memcg_async_reclaim__destroy(skel);
+cleanup_data_file2:
+	unlink(data_file2);
+cleanup_data_file1:
+	unlink(data_file1);
+close_cgroup_fd:
+	close(cgroup_fd);
+cleanup_cgroup:
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c b/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c
new file mode 100644
index 000000000000..4e66766eb4a3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_async_reclaim.c
@@ -0,0 +1,203 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf_atomic.h>
+
+#define BIT(nr)			(1UL << (nr))
+
+#define ___GFP_IO		BIT(___GFP_IO_BIT)
+#define ___GFP_FS		BIT(___GFP_FS_BIT)
+#define ___GFP_DIRECT_RECLAIM	BIT(___GFP_DIRECT_RECLAIM_BIT)
+#define ___GFP_KSWAPD_RECLAIM	BIT(___GFP_KSWAPD_RECLAIM_BIT)
+
+#define __GFP_IO	((gfp_t)___GFP_IO)
+#define __GFP_FS	((gfp_t)___GFP_FS)
+#define __GFP_DIRECT_RECLAIM	((gfp_t)___GFP_DIRECT_RECLAIM) /* Caller can reclaim */
+#define __GFP_KSWAPD_RECLAIM	((gfp_t)___GFP_KSWAPD_RECLAIM) /* kswapd can wake */
+#define __GFP_RECLAIM ((gfp_t)(___GFP_DIRECT_RECLAIM|___GFP_KSWAPD_RECLAIM))
+
+#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
+
+#define ONE_MB_PAGE_COUNT 256
+
+struct bpf_args_s {
+	u64 cgroup_id;
+	u64 limit_bytes;
+} bpf_args;
+
+struct wq_elem {
+	struct bpf_wq work;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, struct wq_elem);
+} wq_map SEC(".maps");
+
+static s64 allocated;
+static s64 old_allocated;
+static u64 async_free_run;
+static u64 initialize_status = 1;
+
+struct cgroup_memcg {
+	struct cgroup *cgrp;
+	struct mem_cgroup *memcg;
+};
+
+static int get_cgroup_memcg_from_id(u64 cgroup_id, struct cgroup_memcg *cm)
+{
+	cm->cgrp = bpf_cgroup_from_id(cgroup_id);
+	if (!cm->cgrp)
+		return -1;
+
+	cm->memcg = bpf_get_mem_cgroup(&cm->cgrp->self);
+	if (!cm->memcg) {
+		bpf_cgroup_release(cm->cgrp);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void put_cgroup_memcg(struct cgroup_memcg *cm)
+{
+	bpf_put_mem_cgroup(cm->memcg);
+	bpf_cgroup_release(cm->cgrp);
+}
+
+static int async_free(void *map, int *key, void *value)
+{
+	struct cgroup_memcg cm;
+	bool started_wq = false;
+
+	if (get_cgroup_memcg_from_id(bpf_args.cgroup_id, &cm) != 0)
+		return 0;
+
+	if (bpf_try_to_free_mem_cgroup_pages(cm.memcg, 32, GFP_KERNEL,
+					     0, -1) > 0) {
+		if (bpf_mem_cgroup_usage(cm.memcg) >=
+		    bpf_args.limit_bytes - (ONE_MB_PAGE_COUNT * __PAGE_SIZE)) {
+			__u32 key2 = 0;
+			struct wq_elem *elem;
+
+			elem = bpf_map_lookup_elem(&wq_map, &key2);
+			if (elem) {
+				bpf_wq_start(&elem->work, 0);
+				started_wq = true;
+			}
+		}
+	}
+	if (!started_wq)
+		__atomic_exchange_n(&async_free_run, 0, __ATOMIC_RELEASE);
+
+	put_cgroup_memcg(&cm);
+	return 0;
+}
+
+SEC("syscall")
+int prog_init(struct bpf_args_s *ctx)
+{
+	struct wq_elem *elem;
+	__u32 key = 0;
+	int ret;
+	u64 expected = 1;
+
+	if (!__atomic_compare_exchange_n(&initialize_status,
+					 &expected, 2,
+					 false,
+					 __ATOMIC_ACQ_REL,
+					 __ATOMIC_RELAXED))
+		return -1;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		return -1;
+	ret = bpf_wq_init(&elem->work, &wq_map, 0);
+	if (ret)
+		goto out;
+	ret = bpf_wq_set_callback(&elem->work, async_free, 0);
+	if (ret)
+		goto out;
+
+	allocated = 0;
+	async_free_run = 0;
+	bpf_args.cgroup_id = ctx->cgroup_id;
+	bpf_args.limit_bytes = ctx->limit_bytes;
+
+out:
+	return ret;
+}
+
+static u64 get_usage(void)
+{
+	u64 ret = 0;
+	struct cgroup_memcg cm;
+
+	if (get_cgroup_memcg_from_id(bpf_args.cgroup_id, &cm) != 0)
+		return 0;
+
+	ret = bpf_mem_cgroup_usage(cm.memcg);
+
+	put_cgroup_memcg(&cm);
+
+	return ret;
+}
+
+s64 abs_diff(s64 a, s64 b)
+{
+	return a > b ? a - b : b - a;
+}
+
+SEC("struct_ops/memcg_charged")
+unsigned int BPF_PROG(memcg_charged_impl, struct mem_cgroup *memcg,
+		      unsigned int nr_pages)
+{
+	struct wq_elem *elem;
+	__u32 key = 0;
+	u64 expected = 0;
+	s64 cur_allocated;
+	s64 cur_old_allocated;
+
+	__atomic_add_fetch(&allocated, nr_pages, __ATOMIC_RELAXED);
+	cur_allocated = READ_ONCE(allocated);
+	cur_old_allocated = READ_ONCE(old_allocated);
+	if (abs_diff(cur_allocated, cur_old_allocated) < ONE_MB_PAGE_COUNT)
+		goto out;
+	WRITE_ONCE(old_allocated, cur_allocated);
+
+	if (get_usage() < bpf_args.limit_bytes)
+		goto out;
+
+	if (__atomic_compare_exchange_n(&async_free_run,
+					&expected, 1,
+					false,
+					__ATOMIC_ACQ_REL,
+					__ATOMIC_RELAXED)) {
+		elem = bpf_map_lookup_elem(&wq_map, &key);
+		if (!elem)
+			return 0;
+
+		bpf_wq_start(&elem->work, 0);
+	}
+
+out:
+	return 0;
+}
+
+SEC("struct_ops/memcg_uncharged")
+void BPF_PROG(memcg_uncharged_impl, struct mem_cgroup *memcg,
+	      unsigned int nr_pages)
+{
+	__atomic_sub_fetch(&allocated, nr_pages, __ATOMIC_RELAXED);
+}
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops mcg_ops = {
+	.memcg_charged = (void *)memcg_charged_impl,
+	.memcg_uncharged = (void *)memcg_uncharged_impl,
+};
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


