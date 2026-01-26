Return-Path: <cgroups+bounces-13451-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCrFOu4ud2kvdAEAu9opvQ
	(envelope-from <cgroups+bounces-13451-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 10:07:58 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991A85CC1
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 233A130098B2
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 09:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480C3275AF5;
	Mon, 26 Jan 2026 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u1ddRi92"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF0E303A12
	for <cgroups@vger.kernel.org>; Mon, 26 Jan 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418434; cv=none; b=s3bDP2ro57FSMW5YOgNa75Nft2JclJaMTxsNiVCHz2PD6JCE9eos2SUfbkJcDM+NIsvI0LhH2wGI5T8PIDY/smEwcPh+Omp4Usl3FkO74u5PV5aqGhxBjPashdbn2wBOUe1WNSABDNIJvfdYceORSlVm5v9JZUX6LWRfcg+vRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418434; c=relaxed/simple;
	bh=s+L/CEQLYB8zlS5YovGGFHaf+77ukYZA+DGQM0Wdzuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3uO0erZ5YYAhbcMmihDmZJDHIFJUKnJBdApL+yyNO+fc++CCTQI/WhhTU26pNftkPNcMBvux0/c9lfyRWtG36v8lHOQkjko73UTX4RaASvwQBoNCi7+TZTqQEETaBQV6DudaxtB3OhRpbFAkIXNopCGvuStKE9eGtjurTCMr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u1ddRi92; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769418429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GO/LF+sPicNNy1cE+LoxDvdgC7eo9UT04E6MeiwBez4=;
	b=u1ddRi924XTVQ+A0lUwrQVJK0OMM4lcoOYsKWqaRhdCNnN7W/M3T4Kx2l81AscnLKseugY
	CCvH9srNWYy8hdcuU5h7hOHKh53Nd5dlaSriTGLqO6gC+xCp3KntleRh702UaHWe021O+d
	LCBfutNU8u2v8R92ALMG9M5/6AqUETY=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
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
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC PATCH bpf-next v4 09/12] selftests/bpf: Add tests for memcg_bpf_ops
Date: Mon, 26 Jan 2026 17:06:28 +0800
Message-ID: <f548f86d60bf9fd80c483d865aa8362efe704bfc.1769417588.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1769417588.git.zhuhui@kylinos.cn>
References: <cover.1769417588.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13451-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8991A85CC1
X-Rspamd-Action: no action

From: Hui Zhu <zhuhui@kylinos.cn>

Add a comprehensive selftest suite for the `memcg_bpf_ops`
functionality. These tests validate that BPF programs can correctly
influence memory cgroup throttling behavior by implementing the new
hooks.

The test suite is added in `prog_tests/memcg_ops.c` and covers
several key scenarios:

1. `test_memcg_ops_over_high`:
   Verifies that a BPF program can trigger throttling on a low-priority
   cgroup by returning a delay from the `get_high_delay_ms` hook when a
   high-priority cgroup is under pressure.

2. `test_memcg_ops_below_low_over_high`:
   Tests the combination of the `below_low` and `get_high_delay_ms`
   hooks, ensuring they work together as expected.

3. `test_memcg_ops_below_min_over_high`:
   Validates the interaction between the `below_min` and
   `get_high_delay_ms` hooks.

The test framework sets up a cgroup hierarchy with high and low
priority groups, attaches BPF programs, runs memory-intensive
workloads, and asserts that the observed throttling (measured by
workload execution time) matches expectations.

The BPF program (`progs/memcg_ops.c`) uses a tracepoint on
`memcg:count_memcg_events` (specifically PGFAULT) to detect memory
pressure and trigger the appropriate hooks in response. This test
suite provides essential validation for the new memory control
mechanisms.

Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 MAINTAINERS                                   |   2 +
 .../selftests/bpf/prog_tests/memcg_ops.c      | 541 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/memcg_ops.c | 129 +++++
 3 files changed, 672 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 491d567f7dc8..7e07bb330eae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6471,6 +6471,8 @@ F:	mm/memcontrol-v1.h
 F:	mm/page_counter.c
 F:	mm/swap_cgroup.c
 F:	samples/cgroup/*
+F:	tools/testing/selftests/bpf/prog_tests/memcg_ops.c
+F:	tools/testing/selftests/bpf/progs/memcg_ops.c
 F:	tools/testing/selftests/cgroup/memcg_protection.m
 F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
 F:	tools/testing/selftests/cgroup/test_kmem.c
diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
new file mode 100644
index 000000000000..a019ba2387bc
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
@@ -0,0 +1,541 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Memory controller eBPF struct ops test
+ */
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include "cgroup_helpers.h"
+
+struct local_config {
+	u64 threshold;
+	u64 high_cgroup_id;
+	bool use_below_low;
+	bool use_below_min;
+	unsigned int over_high_ms;
+} local_config;
+
+#include "memcg_ops.skel.h"
+
+#define TRIGGER_THRESHOLD 1
+#define OVER_HIGH_MS 2000
+#define FILE_SIZE (64 * 1024 * 1024ul)
+#define BUFFER_SIZE (4096)
+#define CG_LIMIT (120 * 1024 * 1024ul)
+
+#define CG_DIR "/memcg_ops_test"
+#define CG_HIGH_DIR CG_DIR "/high"
+#define CG_LOW_DIR CG_DIR "/low"
+
+static int
+setup_cgroup(int *high_cgroup_id, int *low_cgroup_fd, int *high_cgroup_fd)
+{
+	int ret;
+	char limit_buf[20];
+
+	ret = setup_cgroup_environment();
+	if (!ASSERT_OK(ret, "setup_cgroup_environment"))
+		goto cleanup;
+
+	ret = create_and_get_cgroup(CG_DIR);
+	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup "CG_DIR))
+		goto cleanup;
+	close(ret);
+	ret = enable_controllers(CG_DIR, "memory");
+	if (!ASSERT_OK(ret, "enable_controllers"))
+		goto cleanup;
+	snprintf(limit_buf, 20, "%ld", CG_LIMIT);
+	ret = write_cgroup_file(CG_DIR, "memory.max", limit_buf);
+	if (!ASSERT_OK(ret, "write_cgroup_file memory.max"))
+		goto cleanup;
+	ret = write_cgroup_file(CG_DIR, "memory.swap.max", "0");
+	if (!ASSERT_OK(ret, "write_cgroup_file memory.swap.max"))
+		goto cleanup;
+
+	ret = create_and_get_cgroup(CG_HIGH_DIR);
+	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup "CG_HIGH_DIR))
+		goto cleanup;
+	if (high_cgroup_fd)
+		*high_cgroup_fd = ret;
+	else
+		close(ret);
+	ret = (int)get_cgroup_id(CG_HIGH_DIR);
+	if (!ASSERT_GE(ret, 0, "get_cgroup_id"))
+		goto cleanup;
+	*high_cgroup_id = ret;
+
+	ret = create_and_get_cgroup(CG_LOW_DIR);
+	if (!ASSERT_GE(ret, 0, "create_and_get_cgroup "CG_LOW_DIR))
+		goto cleanup;
+	if (low_cgroup_fd)
+		*low_cgroup_fd = ret;
+	else
+		close(ret);
+
+	return 0;
+
+cleanup:
+	cleanup_cgroup_environment();
+	return -1;
+}
+
+int write_file(const char *filename)
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
+int read_file(const char *filename, int iterations)
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
+		fprintf(stderr, "File size mismatch: expected %ld, got %ld\n",
+			FILE_SIZE, sb.st_size);
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
+static void
+real_test_memcg_ops_child_work(const char *cgroup_path,
+			       char *data_filename,
+			       char *time_filename,
+			       int read_times)
+{
+	struct timeval start, end;
+	double elapsed;
+	FILE *fp;
+
+	if (!ASSERT_OK(join_parent_cgroup(cgroup_path), "join_parent_cgroup"))
+		return;
+
+	if (env.verbosity >= VERBOSE_NORMAL)
+		printf("%s %d begin\n", __func__, getpid());
+
+	gettimeofday(&start, NULL);
+
+	if (!ASSERT_OK(write_file(data_filename), "write_file"))
+		return;
+
+	if (env.verbosity >= VERBOSE_NORMAL)
+		printf("%s %d write_file done\n", __func__, getpid());
+
+	if (!ASSERT_OK(read_file(data_filename, read_times), "read_file"))
+		return;
+
+	gettimeofday(&end, NULL);
+
+	elapsed = (end.tv_sec - start.tv_sec) +
+		  (end.tv_usec - start.tv_usec) / 1000000.0;
+
+	if (env.verbosity >= VERBOSE_NORMAL)
+		printf("%s %d end %.6f\n", __func__, getpid(), elapsed);
+
+	fp = fopen(time_filename, "w");
+	if (!ASSERT_OK_PTR(fp, "fopen"))
+		return;
+	fprintf(fp, "%.6f", elapsed);
+	fclose(fp);
+}
+
+static int get_time(char *time_filename, double *time)
+{
+	int ret = -1;
+	FILE *fp;
+	char buf[64];
+
+	fp = fopen(time_filename, "r");
+	if (!ASSERT_OK_PTR(fp, "fopen"))
+		goto out;
+
+	if (!ASSERT_OK_PTR(fgets(buf, sizeof(buf), fp), "fgets"))
+		goto cleanup;
+
+	if (sscanf(buf, "%lf", time) < 0) {
+		PRINT_FAIL("sscanf %s", buf);
+		goto cleanup;
+	}
+
+	ret = 0;
+cleanup:
+	fclose(fp);
+out:
+	return ret;
+}
+
+static void real_test_memcg_ops(int read_times)
+{
+	int ret;
+	char data_file1[] = "/tmp/test_data_XXXXXX";
+	char data_file2[] = "/tmp/test_data_XXXXXX";
+	char time_file1[] = "/tmp/test_time_XXXXXX";
+	char time_file2[] = "/tmp/test_time_XXXXXX";
+	pid_t pid1, pid2;
+	double time1, time2;
+
+	ret = mkstemp(data_file1);
+	if (!ASSERT_GT(ret, 0, "mkstemp"))
+		return;
+	close(ret);
+	ret = mkstemp(data_file2);
+	if (!ASSERT_GT(ret, 0, "mkstemp"))
+		goto cleanup_data_file1;
+	close(ret);
+	ret = mkstemp(time_file1);
+	if (!ASSERT_GT(ret, 0, "mkstemp"))
+		goto cleanup_data_file2;
+	close(ret);
+	ret = mkstemp(time_file2);
+	if (!ASSERT_GT(ret, 0, "mkstemp"))
+		goto cleanup_time_file1;
+	close(ret);
+
+	pid1 = fork();
+	if (!ASSERT_GE(pid1, 0, "fork"))
+		goto cleanup;
+	if (pid1 == 0) {
+		real_test_memcg_ops_child_work(CG_LOW_DIR,
+					       data_file1,
+					       time_file1,
+					       read_times);
+		exit(0);
+	}
+
+	pid2 = fork();
+	if (!ASSERT_GE(pid2, 0, "fork"))
+		goto cleanup;
+	if (pid2 == 0) {
+		real_test_memcg_ops_child_work(CG_HIGH_DIR,
+					       data_file2,
+					       time_file2,
+					       read_times);
+		exit(0);
+	}
+
+	ret = waitpid(pid1, NULL, 0);
+	if (!ASSERT_GT(ret, 0, "waitpid"))
+		goto cleanup;
+
+	ret = waitpid(pid2, NULL, 0);
+	if (!ASSERT_GT(ret, 0, "waitpid"))
+		goto cleanup;
+
+	if (get_time(time_file1, &time1))
+		goto cleanup;
+
+	if (get_time(time_file2, &time2))
+		goto cleanup;
+
+	if (time1 < time2 || time1 - time2 <= 1)
+		PRINT_FAIL("low fast compare time1=%f, time2=%f",
+			   time1, time2);
+
+cleanup:
+	unlink(time_file2);
+cleanup_time_file1:
+	unlink(time_file1);
+cleanup_data_file2:
+	unlink(data_file2);
+cleanup_data_file1:
+	unlink(data_file1);
+}
+
+void test_memcg_ops_over_high(void)
+{
+	int err, map_fd;
+	struct memcg_ops *skel = NULL;
+	struct bpf_map *map;
+	size_t bss_sz;
+	struct memcg_ops__bss *bss_data;
+	__u32 key = 0;
+	struct bpf_program *prog = NULL;
+	struct bpf_link *link = NULL, *link2 = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	int high_cgroup_id, low_cgroup_fd = -1;
+
+	err = setup_cgroup(&high_cgroup_id, &low_cgroup_fd, NULL);
+	if (!ASSERT_OK(err, "setup_cgroup"))
+		goto out;
+
+	skel = memcg_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "memcg_ops__open_and_load"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, ".bss");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name .bss"))
+		goto out;
+
+	map_fd = bpf_map__fd(map);
+	bss_sz = bpf_map__value_size(map);
+	bss_data = malloc(bpf_map__value_size(map));
+	if (!ASSERT_OK_PTR(bss_data, "malloc(bpf_map__value_size(map))"))
+		goto out;
+	memset(bss_data, 0, sizeof(struct local_config));
+	bss_data->local_config.high_cgroup_id = high_cgroup_id;
+	bss_data->local_config.threshold = TRIGGER_THRESHOLD;
+	bss_data->local_config.use_below_low = false;
+	bss_data->local_config.use_below_min = false;
+	bss_data->local_config.over_high_ms = OVER_HIGH_MS;
+	err = bpf_map_update_elem(map_fd, &key, bss_data, BPF_EXIST);
+	free(bss_data);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(skel->obj,
+						"handle_count_memcg_events");
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto out;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, "low_mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name low_mcg_ops"))
+		goto out;
+
+	opts.relative_fd = low_cgroup_fd;
+	link2 = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	real_test_memcg_ops(5);
+
+out:
+	bpf_link__destroy(link);
+	bpf_link__destroy(link2);
+	memcg_ops__detach(skel);
+	memcg_ops__destroy(skel);
+	close(low_cgroup_fd);
+	cleanup_cgroup_environment();
+}
+
+void test_memcg_ops_below_low_over_high(void)
+{
+	int err, map_fd;
+	struct memcg_ops *skel = NULL;
+	struct bpf_map *map;
+	size_t bss_sz;
+	struct memcg_ops__bss *bss_data;
+	__u32 key = 0;
+	struct bpf_program *prog = NULL;
+	struct bpf_link *link = NULL, *link_high = NULL, *link_low = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	int high_cgroup_id, high_cgroup_fd = -1, low_cgroup_fd = -1;
+
+	err = setup_cgroup(&high_cgroup_id, &low_cgroup_fd, &high_cgroup_fd);
+	if (!ASSERT_OK(err, "setup_cgroup"))
+		goto out;
+
+	skel = memcg_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "memcg_ops__open_and_load"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, ".bss");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name .bss"))
+		goto out;
+
+	map_fd = bpf_map__fd(map);
+	bss_sz = bpf_map__value_size(map);
+	bss_data = malloc(bpf_map__value_size(map));
+	if (!ASSERT_OK_PTR(bss_data, "malloc(bpf_map__value_size(map))"))
+		goto out;
+	memset(bss_data, 0, sizeof(struct local_config));
+	bss_data->local_config.high_cgroup_id = high_cgroup_id;
+	bss_data->local_config.threshold = TRIGGER_THRESHOLD;
+	bss_data->local_config.use_below_low = true;
+	bss_data->local_config.use_below_min = false;
+	bss_data->local_config.over_high_ms = OVER_HIGH_MS;
+	err = bpf_map_update_elem(map_fd, &key, bss_data, BPF_EXIST);
+	free(bss_data);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(skel->obj,
+						"handle_count_memcg_events");
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto out;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, "high_mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name mcg_ops"))
+		goto out;
+	opts.relative_fd = high_cgroup_fd;
+	link_high = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link_high, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, "low_mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name mcg_ops"))
+		goto out;
+	opts.relative_fd = low_cgroup_fd;
+	link_low = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link_low, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	real_test_memcg_ops(50);
+
+out:
+	bpf_link__destroy(link);
+	bpf_link__destroy(link_high);
+	bpf_link__destroy(link_low);
+	memcg_ops__detach(skel);
+	memcg_ops__destroy(skel);
+	close(high_cgroup_fd);
+	close(low_cgroup_fd);
+	cleanup_cgroup_environment();
+}
+
+void test_memcg_ops_below_min_over_high(void)
+{
+	int err, map_fd;
+	struct memcg_ops *skel = NULL;
+	struct bpf_map *map;
+	size_t bss_sz;
+	struct memcg_ops__bss *bss_data;
+	__u32 key = 0;
+	struct bpf_program *prog = NULL;
+	struct bpf_link *link = NULL, *link_high = NULL, *link_low = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	int high_cgroup_id, high_cgroup_fd = -1, low_cgroup_fd = -1;
+
+	err = setup_cgroup(&high_cgroup_id, &low_cgroup_fd, &high_cgroup_fd);
+	if (!ASSERT_OK(err, "setup_cgroup"))
+		goto out;
+
+	skel = memcg_ops__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "memcg_ops__open_and_load"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, ".bss");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name .bss"))
+		goto out;
+
+	map_fd = bpf_map__fd(map);
+	bss_sz = bpf_map__value_size(map);
+	bss_data = malloc(bpf_map__value_size(map));
+	if (!ASSERT_OK_PTR(bss_data, "malloc(bpf_map__value_size(map))"))
+		goto out;
+	memset(bss_data, 0, sizeof(struct local_config));
+	bss_data->local_config.high_cgroup_id = high_cgroup_id;
+	bss_data->local_config.threshold = TRIGGER_THRESHOLD;
+	bss_data->local_config.use_below_low = false;
+	bss_data->local_config.use_below_min = true;
+	bss_data->local_config.over_high_ms = OVER_HIGH_MS;
+	err = bpf_map_update_elem(map_fd, &key, bss_data, BPF_EXIST);
+	free(bss_data);
+	if (!ASSERT_OK(err, "bpf_map_update_elem"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(skel->obj,
+						"handle_count_memcg_events");
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto out;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, "high_mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name mcg_ops"))
+		goto out;
+	opts.relative_fd = high_cgroup_fd;
+	link_high = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link_high, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, "low_mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name mcg_ops"))
+		goto out;
+	opts.relative_fd = low_cgroup_fd;
+	link_low = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link_low, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	real_test_memcg_ops(50);
+
+out:
+	bpf_link__destroy(link);
+	bpf_link__destroy(link_high);
+	bpf_link__destroy(link_low);
+	memcg_ops__detach(skel);
+	memcg_ops__destroy(skel);
+	close(high_cgroup_fd);
+	close(low_cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_ops.c b/tools/testing/selftests/bpf/progs/memcg_ops.c
new file mode 100644
index 000000000000..44087a206a61
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_ops.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define ONE_SECOND_NS	1000000000
+
+struct local_config {
+	u64 threshold;
+	u64 high_cgroup_id;
+	bool use_below_low;
+	bool use_below_min;
+	unsigned int over_high_ms;
+} local_config;
+
+struct AggregationData {
+	u64 sum;
+	u64 window_start_ts;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct AggregationData);
+} aggregation_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, u64);
+} trigger_ts_map SEC(".maps");
+
+SEC("tp/memcg/count_memcg_events")
+int
+handle_count_memcg_events(struct trace_event_raw_memcg_rstat_events *ctx)
+{
+	u32 key = 0;
+	struct AggregationData *data;
+	u64 current_ts;
+
+	if (ctx->id != local_config.high_cgroup_id ||
+	    (ctx->item != PGFAULT))
+		goto out;
+
+	data = bpf_map_lookup_elem(&aggregation_map, &key);
+	if (!data)
+		goto out;
+
+	current_ts = bpf_ktime_get_ns();
+
+	if (current_ts - data->window_start_ts < ONE_SECOND_NS) {
+		data->sum += ctx->val;
+	} else {
+		data->window_start_ts = current_ts;
+		data->sum = ctx->val;
+	}
+
+	if (data->sum > local_config.threshold) {
+		bpf_map_update_elem(&trigger_ts_map, &key, &current_ts,
+				    BPF_ANY);
+		data->sum = 0;
+		data->window_start_ts = current_ts;
+	}
+
+out:
+	return 0;
+}
+
+static bool need_threshold(void)
+{
+	u32 key = 0;
+	u64 *trigger_ts;
+	bool ret = false;
+
+	trigger_ts = bpf_map_lookup_elem(&trigger_ts_map, &key);
+	if (!trigger_ts || *trigger_ts == 0)
+		goto out;
+
+	u64 current_ts = bpf_ktime_get_ns();
+
+	if (current_ts - *trigger_ts < ONE_SECOND_NS)
+		ret = true;
+
+out:
+	return ret;
+}
+
+SEC("struct_ops/below_low")
+unsigned int below_low_impl(struct mem_cgroup *memcg)
+{
+	if (!local_config.use_below_low)
+		return false;
+
+	return need_threshold();
+}
+
+SEC("struct_ops/below_min")
+unsigned int below_min_impl(struct mem_cgroup *memcg)
+{
+	if (!local_config.use_below_min)
+		return false;
+
+	return need_threshold();
+}
+
+SEC("struct_ops/get_high_delay_ms")
+unsigned int get_high_delay_ms_impl(struct mem_cgroup *memcg)
+{
+	if (local_config.over_high_ms && need_threshold())
+		return local_config.over_high_ms;
+
+	return 0;
+}
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops high_mcg_ops = {
+	.below_low = (void *)below_low_impl,
+	.below_min = (void *)below_min_impl,
+};
+
+SEC(".struct_ops.link")
+struct memcg_bpf_ops low_mcg_ops = {
+	.get_high_delay_ms = (void *)get_high_delay_ms_impl,
+};
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


