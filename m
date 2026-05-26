Return-Path: <cgroups+bounces-16273-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDmtFVYFFWroSAcAu9opvQ
	(envelope-from <cgroups+bounces-16273-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:28:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC05CFE8E
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A51B301F198
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 02:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A38E3090D4;
	Tue, 26 May 2026 02:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aIqbJCo0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E373E304BDC
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 02:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762360; cv=none; b=HE4Gcn5OtRS/TY9KLCB00JdJHZOe3duLOLXjykcQXWHKt2j7lbb9dlNwr7fNJS5/3zvqfg9avz4EdVV/jdprLEzvmuqorfCGahMkVxfH4Cgrqbnt2syDpsZ0Sbz0l+KfEFNbxGqwh9sIrjan5fcuLl3Y3pNELpyC4WiOss0ukGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762360; c=relaxed/simple;
	bh=NZsybeCaQAY2gJXlMxVE7V8Ip8oqeh1zeTnxdRrNEMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEg36PsHaQmDy5i1WN/Vp/kbLL2WK0aPSEskNSj1lLMPJIbDAmKW3xFO+pz/wDht6L7LDp5jkDEQJBREupQcpk+3xa7qj4nTtmpoPHdL4W16uUG9ZFQweMH5blqlE6cJjCxUeMpz46ZAQzypECSspfsq+N787WfoSBGmac9P42s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aIqbJCo0; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779762355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=33PG31psqtzKKyL9YlsX5pLdBGFtUZt06yU1qeQL7VI=;
	b=aIqbJCo0XQEKgTA2YA4Re8D8hMf0LPQrvtJE5STgVqdePPrMM/0xYlncquHOhe+FAkuR39
	9giU5M3c6dqhw1IC6AqCwezcAbQ63csRN7nitGTrACbCh5vdfNYOqH7yOJaC4odiXOuAbM
	D8A/ow9PzQSU27qPcVKzgHEglhxdnUQ=
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
Subject: [RFC PATCH bpf-next v7 08/11] selftests/bpf: Add tests for memcg_bpf_ops
Date: Tue, 26 May 2026 10:24:56 +0800
Message-ID: <722df14b403dfbb123f1a1df3c72fbbfb998a31f.1779760876.git.zhuhui@kylinos.cn>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16273-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.964];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: E0DC05CFE8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Signed-off-by: Barry Song <baohua@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
---
 MAINTAINERS                                   |   2 +
 .../selftests/bpf/prog_tests/memcg_ops.c      | 561 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/memcg_ops.c | 132 +++++
 3 files changed, 695 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_ops.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dfc621ff629d..1be243e544da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6567,6 +6567,8 @@ F:	mm/memcontrol-v1.h
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
index 000000000000..19fd4fde2266
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
@@ -0,0 +1,561 @@
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
+setup_high_low_cgroups(u64 *high_cgroup_id, int *low_cgroup_fd,
+		       int *high_cgroup_fd)
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
+	snprintf(limit_buf, 20, "%lu", CG_LIMIT);
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
+	*high_cgroup_id = get_cgroup_id(CG_HIGH_DIR);
+	if (!ASSERT_GT(*high_cgroup_id, 0, "get_cgroup_id"))
+		goto cleanup;
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
+static int
+real_test_memcg_ops_child_work(const char *cgroup_path,
+			       char *data_filename,
+			       char *time_filename,
+			       int read_times)
+{
+	struct timeval start, end;
+	double elapsed;
+	FILE *fp;
+	int ret = -1;
+
+	if (!ASSERT_OK(join_parent_cgroup(cgroup_path), "join_parent_cgroup"))
+		goto out;
+
+	if (env.verbosity >= VERBOSE_NORMAL)
+		printf("%s %d begin\n", __func__, getpid());
+
+	gettimeofday(&start, NULL);
+
+	if (!ASSERT_OK(write_file(data_filename), "write_file"))
+		goto out;
+
+	if (env.verbosity >= VERBOSE_NORMAL)
+		printf("%s %d write_file done\n", __func__, getpid());
+
+	if (!ASSERT_OK(read_file(data_filename, read_times), "read_file"))
+		goto out;
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
+		goto out;
+	fprintf(fp, "%.6f", elapsed);
+	fclose(fp);
+
+	ret = 0;
+out:
+	return ret;
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
+	if (sscanf(buf, "%lf", time) != 1) {
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
+	char data_file1[] = "/tmp/test_data_1_XXXXXX";
+	char data_file2[] = "/tmp/test_data_2_XXXXXX";
+	char time_file1[] = "/tmp/test_time_1_XXXXXX";
+	char time_file2[] = "/tmp/test_time_2_XXXXXX";
+	pid_t pid1, pid2;
+	double time1, time2;
+	int status;
+
+	ret = mkstemp(data_file1);
+	if (!ASSERT_GE(ret, 0, "mkstemp"))
+		return;
+	close(ret);
+	ret = mkstemp(data_file2);
+	if (!ASSERT_GE(ret, 0, "mkstemp"))
+		goto cleanup_data_file1;
+	close(ret);
+	ret = mkstemp(time_file1);
+	if (!ASSERT_GE(ret, 0, "mkstemp"))
+		goto cleanup_data_file2;
+	close(ret);
+	ret = mkstemp(time_file2);
+	if (!ASSERT_GE(ret, 0, "mkstemp"))
+		goto cleanup_time_file1;
+	close(ret);
+
+	pid1 = fork();
+	if (!ASSERT_GE(pid1, 0, "fork"))
+		goto cleanup;
+	if (pid1 == 0) {
+		exit(real_test_memcg_ops_child_work(CG_LOW_DIR,
+						    data_file1,
+						    time_file1,
+						    read_times));
+	}
+
+	pid2 = fork();
+	if (!ASSERT_GE(pid2, 0, "fork")) {
+		/* Reap first child to avoid a zombie if second fork fails. */
+		(void)waitpid(pid1, NULL, 0);
+		goto cleanup;
+	}
+	if (pid2 == 0) {
+		exit(real_test_memcg_ops_child_work(CG_HIGH_DIR,
+						    data_file2,
+						    time_file2,
+						    read_times));
+	}
+
+	ret = waitpid(pid1, &status, 0);
+	if (!ASSERT_GT(ret, 0, "child1 waitpid"))
+		goto cleanup;
+	if (!ASSERT_TRUE(WIFEXITED(status), "child1 exited normally"))
+		goto cleanup;
+	if (!ASSERT_EQ(WEXITSTATUS(status), 0, "child1 exit status"))
+		goto cleanup;
+
+	ret = waitpid(pid2, &status, 0);
+	if (!ASSERT_GT(ret, 0, "child2 waitpid"))
+		goto cleanup;
+	if (!ASSERT_TRUE(WIFEXITED(status), "child2 exited normally"))
+		goto cleanup;
+	if (!ASSERT_EQ(WEXITSTATUS(status), 0, "child2 exit status"))
+		goto cleanup;
+
+	if (get_time(time_file1, &time1))
+		goto cleanup;
+
+	if (get_time(time_file2, &time2))
+		goto cleanup;
+
+	if (time1 < time2 || time1 - time2 <= 1)
+		PRINT_FAIL("Low priority cgroup not slower: low=%f vs high=%f",
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
+	struct memcg_ops__bss *bss_data;
+	__u32 key = 0;
+	struct bpf_program *prog = NULL;
+	struct bpf_link *link = NULL, *link2 = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	u64 high_cgroup_id;
+	int low_cgroup_fd = -1;
+
+	err = setup_high_low_cgroups(&high_cgroup_id, &low_cgroup_fd, NULL);
+	if (!ASSERT_OK(err, "setup_high_low_cgroups"))
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
+	bss_data = calloc(1, bpf_map__value_size(map));
+	if (!ASSERT_OK_PTR(bss_data, "calloc(1, bpf_map__value_size(map))"))
+		goto out;
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
+	opts.flags = BPF_F_CGROUP_FD;
+	opts.target_fd = low_cgroup_fd;
+	link2 = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link2, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	real_test_memcg_ops(5);
+
+out:
+	bpf_link__destroy(link);
+	bpf_link__destroy(link2);
+	if (skel) {
+		memcg_ops__detach(skel);
+		memcg_ops__destroy(skel);
+	}
+	close(low_cgroup_fd);
+	cleanup_cgroup_environment();
+}
+
+void test_memcg_ops_below_low_over_high(void)
+{
+	int err, map_fd;
+	struct memcg_ops *skel = NULL;
+	struct bpf_map *map;
+	struct memcg_ops__bss *bss_data;
+	__u32 key = 0;
+	struct bpf_program *prog = NULL;
+	struct bpf_link *link = NULL, *link_high = NULL, *link_low = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	u64 high_cgroup_id;
+	int high_cgroup_fd = -1, low_cgroup_fd = -1;
+
+	err = setup_high_low_cgroups(&high_cgroup_id, &low_cgroup_fd,
+				     &high_cgroup_fd);
+	if (!ASSERT_OK(err, "setup_high_low_cgroups"))
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
+	bss_data = calloc(1, bpf_map__value_size(map));
+	if (!ASSERT_OK_PTR(bss_data, "calloc(1, bpf_map__value_size(map))"))
+		goto out;
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
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name high_mcg_ops"))
+		goto out;
+	opts.flags = BPF_F_CGROUP_FD;
+	opts.target_fd = high_cgroup_fd;
+	link_high = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link_high, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, "low_mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name low_mcg_ops"))
+		goto out;
+	opts.target_fd = low_cgroup_fd;
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
+	if (skel) {
+		memcg_ops__detach(skel);
+		memcg_ops__destroy(skel);
+	}
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
+	struct memcg_ops__bss *bss_data;
+	__u32 key = 0;
+	struct bpf_program *prog = NULL;
+	struct bpf_link *link = NULL, *link_high = NULL, *link_low = NULL;
+	DECLARE_LIBBPF_OPTS(bpf_struct_ops_opts, opts);
+	u64 high_cgroup_id;
+	int high_cgroup_fd = -1, low_cgroup_fd = -1;
+
+	err = setup_high_low_cgroups(&high_cgroup_id, &low_cgroup_fd,
+				     &high_cgroup_fd);
+	if (!ASSERT_OK(err, "setup_high_low_cgroups"))
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
+	bss_data = calloc(1, bpf_map__value_size(map));
+	if (!ASSERT_OK_PTR(bss_data, "calloc(1, bpf_map__value_size(map))"))
+		goto out;
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
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name high_mcg_ops"))
+		goto out;
+	opts.flags = BPF_F_CGROUP_FD;
+	opts.target_fd = high_cgroup_fd;
+	link_high = bpf_map__attach_struct_ops_opts(map, &opts);
+	if (!ASSERT_OK_PTR(link_high, "bpf_map__attach_struct_ops_opts"))
+		goto out;
+
+	map = bpf_object__find_map_by_name(skel->obj, "low_mcg_ops");
+	if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name low_mcg_ops"))
+		goto out;
+	opts.target_fd = low_cgroup_fd;
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
+	if (skel) {
+		memcg_ops__detach(skel);
+		memcg_ops__destroy(skel);
+	}
+	close(high_cgroup_fd);
+	close(low_cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_ops.c b/tools/testing/selftests/bpf/progs/memcg_ops.c
new file mode 100644
index 000000000000..4a1d817c1d9c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_ops.c
@@ -0,0 +1,132 @@
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
+	u64 current_ts;
+
+	trigger_ts = bpf_map_lookup_elem(&trigger_ts_map, &key);
+	if (!trigger_ts || *trigger_ts == 0)
+		goto out;
+
+	current_ts = bpf_ktime_get_ns();
+
+	if (current_ts - *trigger_ts < ONE_SECOND_NS)
+		ret = true;
+
+out:
+	return ret;
+}
+
+SEC("struct_ops/below_low")
+bool below_low_impl(struct mem_cgroup *memcg, unsigned long elow,
+		    unsigned long usage)
+{
+	if (!local_config.use_below_low)
+		return false;
+
+	return need_threshold();
+}
+
+SEC("struct_ops/below_min")
+bool below_min_impl(struct mem_cgroup *memcg, unsigned long emin,
+		    unsigned long usage)
+{
+	if (!local_config.use_below_min)
+		return false;
+
+	return need_threshold();
+}
+
+SEC("struct_ops/memcg_charged")
+unsigned int memcg_charged_impl(struct mem_cgroup *memcg, unsigned int nr_pages)
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
+	.memcg_charged = (void *)memcg_charged_impl,
+};
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.43.0


