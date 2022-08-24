Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38ACC59F1A6
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 05:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbiHXDC3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 23:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiHXDCD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 23:02:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CB97E80B
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 20:01:17 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3328a211611so267975277b3.5
        for <cgroups@vger.kernel.org>; Tue, 23 Aug 2022 20:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=RPQZUHYfHy6reZ8ZUvZcr7XwclRTjwMrYIVgdxCY3BE=;
        b=OJuUNgxbhNtnEJpvLc3yRYV/9zzchz14/C3lYDh6tNlyZdL5efC5K8GXh916tiC9Ec
         eJkUR5GYtzTFulHyV7rhA825rmCg6GgJomlz/0R0VTJSlipjnQVPrzYJNNC5do3p6NZh
         j4tkBVVcWEWbDmit+34sTR8DaJGvaJaU89QeV0bh78WSjpbSigNCEdRQ+8241lruyCuA
         TD2ZHYhBfScXGoAs1awU5npyoNkTgL6NP1+BiDxj6qwrvvnbC6uRkJW9ZP0JNDxcOYLB
         hWEobCko2+T5CfMyaDLdFrhvx5x8rNVoYyW+ORdpAHb6HaKDN7pZ0/wTMO69M/E0vIyW
         c+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=RPQZUHYfHy6reZ8ZUvZcr7XwclRTjwMrYIVgdxCY3BE=;
        b=hhmPx33NmO+rCs0bVDr5cRkJlrigrJc64xvYHwQegh4PfMoSvUM2dgjstYJ4i/tO1u
         tlMF0IVsJGqQT6ZeJ/d2CWSy55Ri5xsHQQHuWxp+70nF22MEkjeeiC7Xkk6IwIQIE8M7
         CdI91Vl/MjMp/XHhRrb9clnBvdqFJc+sHeYe8z8W7Re/yJs5i82RP/qZLGcnjNfD7YvV
         pC+48H71q5OZZvUCVxRuK4UrKjIqYrVnZs52cQ1113sozLZTf1iBlUSBvM5pkjW6HPD4
         mUt8zpHvCjS/AT2/TSCP4BxzJ5QvidQYr6LcSoiBN2PqlX//RFPlsOb9tRK7iqQwujZ3
         tqvg==
X-Gm-Message-State: ACgBeo1H54q6EFeC28WFk6cnmq5CNCSdaAKfZxSQvIqZ8FEKMs6N2av3
        nEAMyob4g+aMOj6Des7S1AM+rsLGcBw=
X-Google-Smtp-Source: AA6agR4lUF1ExlhweKk6tQPhWjE2BSIokfKvASEyLeJRjKIj647ns9Alku2bgGmT8kvJkUhUKeaWq9kkiZs=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2d4:203:87e3:473b:a297:1247])
 (user=haoluo job=sendgmr) by 2002:a25:d784:0:b0:694:1bdd:f08d with SMTP id
 o126-20020a25d784000000b006941bddf08dmr26396272ybg.152.1661310075994; Tue, 23
 Aug 2022 20:01:15 -0700 (PDT)
Date:   Tue, 23 Aug 2022 20:00:31 -0700
In-Reply-To: <20220824030031.1013441-1-haoluo@google.com>
Message-Id: <20220824030031.1013441-6-haoluo@google.com>
Mime-Version: 1.0
References: <20220824030031.1013441-1-haoluo@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH bpf-next v9 5/5] selftests/bpf: add a selftest for cgroup
 hierarchical stats collection
From:   Hao Luo <haoluo@google.com>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        cgroups@vger.kernel.org, netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        KP Singh <kpsingh@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Michal Koutny <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yosry Ahmed <yosryahmed@google.com>

Add a selftest that tests the whole workflow for collecting,
aggregating (flushing), and displaying cgroup hierarchical stats.

TL;DR:
- Userspace program creates a cgroup hierarchy and induces memcg reclaim
  in parts of it.
- Whenever reclaim happens, vmscan_start and vmscan_end update
  per-cgroup percpu readings, and tell rstat which (cgroup, cpu) pairs
  have updates.
- When userspace tries to read the stats, vmscan_dump calls rstat to flush
  the stats, and outputs the stats in text format to userspace (similar
  to cgroupfs stats).
- rstat calls vmscan_flush once for every (cgroup, cpu) pair that has
  updates, vmscan_flush aggregates cpu readings and propagates updates
  to parents.
- Userspace program makes sure the stats are aggregated and read
  correctly.

Detailed explanation:
- The test loads tracing bpf programs, vmscan_start and vmscan_end, to
  measure the latency of cgroup reclaim. Per-cgroup readings are stored in
  percpu maps for efficiency. When a cgroup reading is updated on a cpu,
  cgroup_rstat_updated(cgroup, cpu) is called to add the cgroup to the
  rstat updated tree on that cpu.

- A cgroup_iter program, vmscan_dump, is loaded and pinned to a file, for
  each cgroup. Reading this file invokes the program, which calls
  cgroup_rstat_flush(cgroup) to ask rstat to propagate the updates for all
  cpus and cgroups that have updates in this cgroup's subtree. Afterwards,
  the stats are exposed to the user. vmscan_dump returns 1 to terminate
  iteration early, so that we only expose stats for one cgroup per read.

- An ftrace program, vmscan_flush, is also loaded and attached to
  bpf_rstat_flush. When rstat flushing is ongoing, vmscan_flush is invoked
  once for each (cgroup, cpu) pair that has updates. cgroups are popped
  from the rstat tree in a bottom-up fashion, so calls will always be
  made for cgroups that have updates before their parents. The program
  aggregates percpu readings to a total per-cgroup reading, and also
  propagates them to the parent cgroup. After rstat flushing is over, all
  cgroups will have correct updated hierarchical readings (including all
  cpus and all their descendants).

- Finally, the test creates a cgroup hierarchy and induces memcg reclaim
  in parts of it, and makes sure that the stats collection, aggregation,
  and reading workflow works as expected.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Hao Luo <haoluo@google.com>
---
 .../prog_tests/cgroup_hierarchical_stats.c    | 357 ++++++++++++++++++
 .../bpf/progs/cgroup_hierarchical_stats.c     | 226 +++++++++++
 2 files changed, 583 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
new file mode 100644
index 000000000000..101a6d70b863
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Functions to manage eBPF programs attached to cgroup subsystems
+ *
+ * Copyright 2022 Google LLC.
+ */
+#include <asm-generic/errno.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/bpf.h>
+
+#include "cgroup_helpers.h"
+#include "cgroup_hierarchical_stats.skel.h"
+
+#define PAGE_SIZE 4096
+#define MB(x) (x << 20)
+
+#define BPFFS_ROOT "/sys/fs/bpf/"
+#define BPFFS_VMSCAN BPFFS_ROOT"vmscan/"
+
+#define CG_ROOT_NAME "root"
+#define CG_ROOT_ID 1
+
+#define CGROUP_PATH(p, n) {.path = p"/"n, .name = n}
+
+static struct {
+	const char *path, *name;
+	unsigned long long id;
+	int fd;
+} cgroups[] = {
+	CGROUP_PATH("/", "test"),
+	CGROUP_PATH("/test", "child1"),
+	CGROUP_PATH("/test", "child2"),
+	CGROUP_PATH("/test/child1", "child1_1"),
+	CGROUP_PATH("/test/child1", "child1_2"),
+	CGROUP_PATH("/test/child2", "child2_1"),
+	CGROUP_PATH("/test/child2", "child2_2"),
+};
+
+#define N_CGROUPS ARRAY_SIZE(cgroups)
+#define N_NON_LEAF_CGROUPS 3
+
+static int root_cgroup_fd;
+static bool mounted_bpffs;
+
+/* reads file at 'path' to 'buf', returns 0 on success. */
+static int read_from_file(const char *path, char *buf, size_t size)
+{
+	int fd, len;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	len = read(fd, buf, size);
+	close(fd);
+	if (len < 0)
+		return len;
+
+	buf[len] = 0;
+	return 0;
+}
+
+/* mounts bpffs and mkdir for reading stats, returns 0 on success. */
+static int setup_bpffs(void)
+{
+	int err;
+
+	/* Mount bpffs */
+	err = mount("bpf", BPFFS_ROOT, "bpf", 0, NULL);
+	mounted_bpffs = !err;
+	if (ASSERT_FALSE(err && errno != EBUSY, "mount"))
+		return err;
+
+	/* Create a directory to contain stat files in bpffs */
+	err = mkdir(BPFFS_VMSCAN, 0755);
+	if (!ASSERT_OK(err, "mkdir"))
+		return err;
+
+	return 0;
+}
+
+static void cleanup_bpffs(void)
+{
+	/* Remove created directory in bpffs */
+	ASSERT_OK(rmdir(BPFFS_VMSCAN), "rmdir "BPFFS_VMSCAN);
+
+	/* Unmount bpffs, if it wasn't already mounted when we started */
+	if (mounted_bpffs)
+		return;
+
+	ASSERT_OK(umount(BPFFS_ROOT), "unmount bpffs");
+}
+
+/* sets up cgroups, returns 0 on success. */
+static int setup_cgroups(void)
+{
+	int i, fd, err;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		return err;
+
+	root_cgroup_fd = get_root_cgroup();
+	if (!ASSERT_GE(root_cgroup_fd, 0, "get_root_cgroup"))
+		return root_cgroup_fd;
+
+	for (i = 0; i < N_CGROUPS; i++) {
+		fd = create_and_get_cgroup(cgroups[i].path);
+		if (!ASSERT_GE(fd, 0, "create_and_get_cgroup"))
+			return fd;
+
+		cgroups[i].fd = fd;
+		cgroups[i].id = get_cgroup_id(cgroups[i].path);
+
+		/*
+		 * Enable memcg controller for the entire hierarchy.
+		 * Note that stats are collected for all cgroups in a hierarchy
+		 * with memcg enabled anyway, but are only exposed for cgroups
+		 * that have memcg enabled.
+		 */
+		if (i < N_NON_LEAF_CGROUPS) {
+			err = enable_controllers(cgroups[i].path, "memory");
+			if (!ASSERT_OK(err, "enable_controllers"))
+				return err;
+		}
+	}
+	return 0;
+}
+
+static void cleanup_cgroups(void)
+{
+	close(root_cgroup_fd);
+	for (int i = 0; i < N_CGROUPS; i++)
+		close(cgroups[i].fd);
+	cleanup_cgroup_environment();
+}
+
+/* Sets up cgroup hiearchary, returns 0 on success. */
+static int setup_hierarchy(void)
+{
+	return setup_bpffs() || setup_cgroups();
+}
+
+static void destroy_hierarchy(void)
+{
+	cleanup_cgroups();
+	cleanup_bpffs();
+}
+
+static int reclaimer(const char *cgroup_path, size_t size)
+{
+	static char size_buf[128];
+	char *buf, *ptr;
+	int err;
+
+	/* Join cgroup in the parent process workdir */
+	if (join_parent_cgroup(cgroup_path))
+		return EACCES;
+
+	/* Allocate memory */
+	buf = malloc(size);
+	if (!buf)
+		return ENOMEM;
+
+	/* Write to memory to make sure it's actually allocated */
+	for (ptr = buf; ptr < buf + size; ptr += PAGE_SIZE)
+		*ptr = 1;
+
+	/* Try to reclaim memory */
+	snprintf(size_buf, 128, "%lu", size);
+	err = write_cgroup_file_parent(cgroup_path, "memory.reclaim", size_buf);
+
+	free(buf);
+	/* memory.reclaim returns EAGAIN if the amount is not fully reclaimed */
+	if (err && errno != EAGAIN)
+		return errno;
+
+	return 0;
+}
+
+static int induce_vmscan(void)
+{
+	int i, status;
+
+	/*
+	 * In every leaf cgroup, run a child process that allocates some memory
+	 * and attempts to reclaim some of it.
+	 */
+	for (i = N_NON_LEAF_CGROUPS; i < N_CGROUPS; i++) {
+		pid_t pid;
+
+		/* Create reclaimer child */
+		pid = fork();
+		if (pid == 0) {
+			status = reclaimer(cgroups[i].path, MB(5));
+			exit(status);
+		}
+
+		/* Cleanup reclaimer child */
+		waitpid(pid, &status, 0);
+		ASSERT_TRUE(WIFEXITED(status), "reclaimer exited");
+		ASSERT_EQ(WEXITSTATUS(status), 0, "reclaim exit code");
+	}
+	return 0;
+}
+
+static unsigned long long
+get_cgroup_vmscan_delay(unsigned long long cgroup_id, const char *file_name)
+{
+	unsigned long long vmscan = 0, id = 0;
+	static char buf[128], path[128];
+
+	/* For every cgroup, read the file generated by cgroup_iter */
+	snprintf(path, 128, "%s%s", BPFFS_VMSCAN, file_name);
+	if (!ASSERT_OK(read_from_file(path, buf, 128), "read cgroup_iter"))
+		return 0;
+
+	/* Check the output file formatting */
+	ASSERT_EQ(sscanf(buf, "cg_id: %llu, total_vmscan_delay: %llu\n",
+			 &id, &vmscan), 2, "output format");
+
+	/* Check that the cgroup_id is displayed correctly */
+	ASSERT_EQ(id, cgroup_id, "cgroup_id");
+	/* Check that the vmscan reading is non-zero */
+	ASSERT_GT(vmscan, 0, "vmscan_reading");
+	return vmscan;
+}
+
+static void check_vmscan_stats(void)
+{
+	unsigned long long vmscan_readings[N_CGROUPS], vmscan_root;
+	int i;
+
+	for (i = 0; i < N_CGROUPS; i++) {
+		vmscan_readings[i] = get_cgroup_vmscan_delay(cgroups[i].id,
+							     cgroups[i].name);
+	}
+
+	/* Read stats for root too */
+	vmscan_root = get_cgroup_vmscan_delay(CG_ROOT_ID, CG_ROOT_NAME);
+
+	/* Check that child1 == child1_1 + child1_2 */
+	ASSERT_EQ(vmscan_readings[1], vmscan_readings[3] + vmscan_readings[4],
+		  "child1_vmscan");
+	/* Check that child2 == child2_1 + child2_2 */
+	ASSERT_EQ(vmscan_readings[2], vmscan_readings[5] + vmscan_readings[6],
+		  "child2_vmscan");
+	/* Check that test == child1 + child2 */
+	ASSERT_EQ(vmscan_readings[0], vmscan_readings[1] + vmscan_readings[2],
+		  "test_vmscan");
+	/* Check that root >= test */
+	ASSERT_GE(vmscan_root, vmscan_readings[1], "root_vmscan");
+}
+
+/* Creates iter link and pins in bpffs, returns 0 on success, -errno on failure.
+ */
+static int setup_cgroup_iter(struct cgroup_hierarchical_stats *obj,
+			     int cgroup_fd, const char *file_name)
+{
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo = {};
+	struct bpf_link *link;
+	static char path[128];
+	int err;
+
+	/*
+	 * Create an iter link, parameterized by cgroup_fd. We only want to
+	 * traverse one cgroup, so set the traversal order to "self".
+	 */
+	linfo.cgroup.cgroup_fd = cgroup_fd;
+	linfo.cgroup.order = BPF_ITER_SELF_ONLY;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+	link = bpf_program__attach_iter(obj->progs.dump_vmscan, &opts);
+	if (!ASSERT_OK_PTR(link, "attach_iter"))
+		return -EFAULT;
+
+	/* Pin the link to a bpffs file */
+	snprintf(path, 128, "%s%s", BPFFS_VMSCAN, file_name);
+	err = bpf_link__pin(link, path);
+	ASSERT_OK(err, "pin cgroup_iter");
+
+	/* Remove the link, leaving only the ref held by the pinned file */
+	bpf_link__destroy(link);
+	return err;
+}
+
+/* Sets up programs for collecting stats, returns 0 on success. */
+static int setup_progs(struct cgroup_hierarchical_stats **skel)
+{
+	int i, err;
+
+	*skel = cgroup_hierarchical_stats__open_and_load();
+	if (!ASSERT_OK_PTR(*skel, "open_and_load"))
+		return 1;
+
+	/* Attach cgroup_iter program that will dump the stats to cgroups */
+	for (i = 0; i < N_CGROUPS; i++) {
+		err = setup_cgroup_iter(*skel, cgroups[i].fd, cgroups[i].name);
+		if (!ASSERT_OK(err, "setup_cgroup_iter"))
+			return err;
+	}
+
+	/* Also dump stats for root */
+	err = setup_cgroup_iter(*skel, root_cgroup_fd, CG_ROOT_NAME);
+	if (!ASSERT_OK(err, "setup_cgroup_iter"))
+		return err;
+
+	bpf_program__set_autoattach((*skel)->progs.dump_vmscan, false);
+	err = cgroup_hierarchical_stats__attach(*skel);
+	if (!ASSERT_OK(err, "attach"))
+		return err;
+
+	return 0;
+}
+
+static void destroy_progs(struct cgroup_hierarchical_stats *skel)
+{
+	static char path[128];
+	int i;
+
+	for (i = 0; i < N_CGROUPS; i++) {
+		/* Delete files in bpffs that cgroup_iters are pinned in */
+		snprintf(path, 128, "%s%s", BPFFS_VMSCAN,
+			 cgroups[i].name);
+		ASSERT_OK(remove(path), "remove cgroup_iter pin");
+	}
+
+	/* Delete root file in bpffs */
+	snprintf(path, 128, "%s%s", BPFFS_VMSCAN, CG_ROOT_NAME);
+	ASSERT_OK(remove(path), "remove cgroup_iter root pin");
+	cgroup_hierarchical_stats__destroy(skel);
+}
+
+void test_cgroup_hierarchical_stats(void)
+{
+	struct cgroup_hierarchical_stats *skel = NULL;
+
+	if (setup_hierarchy())
+		goto hierarchy_cleanup;
+	if (setup_progs(&skel))
+		goto cleanup;
+	if (induce_vmscan())
+		goto cleanup;
+	check_vmscan_stats();
+cleanup:
+	destroy_progs(skel);
+hierarchy_cleanup:
+	destroy_hierarchy();
+}
diff --git a/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
new file mode 100644
index 000000000000..8ab4253a1592
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Functions to manage eBPF programs attached to cgroup subsystems
+ *
+ * Copyright 2022 Google LLC.
+ */
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * Start times are stored per-task, not per-cgroup, as multiple tasks in one
+ * cgroup can perform reclaim concurrently.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__type(key, int);
+	__type(value, __u64);
+} vmscan_start_time SEC(".maps");
+
+struct vmscan_percpu {
+	/* Previous percpu state, to figure out if we have new updates */
+	__u64 prev;
+	/* Current percpu state */
+	__u64 state;
+};
+
+struct vmscan {
+	/* State propagated through children, pending aggregation */
+	__u64 pending;
+	/* Total state, including all cpus and all children */
+	__u64 state;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_HASH);
+	__uint(max_entries, 100);
+	__type(key, __u64);
+	__type(value, struct vmscan_percpu);
+} pcpu_cgroup_vmscan_elapsed SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 100);
+	__type(key, __u64);
+	__type(value, struct vmscan);
+} cgroup_vmscan_elapsed SEC(".maps");
+
+extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __ksym;
+extern void cgroup_rstat_flush(struct cgroup *cgrp) __ksym;
+
+static struct cgroup *task_memcg(struct task_struct *task)
+{
+	int cgrp_id;
+
+#if __has_builtin(__builtin_preserve_enum_value)
+	cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id, memory_cgrp_id);
+#else
+	cgrp_id = memory_cgrp_id;
+#endif
+	return task->cgroups->subsys[cgrp_id]->cgroup;
+}
+
+static uint64_t cgroup_id(struct cgroup *cgrp)
+{
+	return cgrp->kn->id;
+}
+
+static int create_vmscan_percpu_elem(__u64 cg_id, __u64 state)
+{
+	struct vmscan_percpu pcpu_init = {.state = state, .prev = 0};
+
+	return bpf_map_update_elem(&pcpu_cgroup_vmscan_elapsed, &cg_id,
+				   &pcpu_init, BPF_NOEXIST);
+}
+
+static int create_vmscan_elem(__u64 cg_id, __u64 state, __u64 pending)
+{
+	struct vmscan init = {.state = state, .pending = pending};
+
+	return bpf_map_update_elem(&cgroup_vmscan_elapsed, &cg_id,
+				   &init, BPF_NOEXIST);
+}
+
+SEC("tp_btf/mm_vmscan_memcg_reclaim_begin")
+int BPF_PROG(vmscan_start, int order, gfp_t gfp_flags)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	__u64 *start_time_ptr;
+
+	start_time_ptr = bpf_task_storage_get(&vmscan_start_time, task, 0,
+					      BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (start_time_ptr)
+		*start_time_ptr = bpf_ktime_get_ns();
+	return 0;
+}
+
+SEC("tp_btf/mm_vmscan_memcg_reclaim_end")
+int BPF_PROG(vmscan_end, unsigned long nr_reclaimed)
+{
+	struct vmscan_percpu *pcpu_stat;
+	struct task_struct *current = bpf_get_current_task_btf();
+	struct cgroup *cgrp;
+	__u64 *start_time_ptr;
+	__u64 current_elapsed, cg_id;
+	__u64 end_time = bpf_ktime_get_ns();
+
+	/*
+	 * cgrp is the first parent cgroup of current that has memcg enabled in
+	 * its subtree_control, or NULL if memcg is disabled in the entire tree.
+	 * In a cgroup hierarchy like this:
+	 *                               a
+	 *                              / \
+	 *                             b   c
+	 *  If "a" has memcg enabled, while "b" doesn't, then processes in "b"
+	 *  will accumulate their stats directly to "a". This makes sure that no
+	 *  stats are lost from processes in leaf cgroups that don't have memcg
+	 *  enabled, but only exposes stats for cgroups that have memcg enabled.
+	 */
+	cgrp = task_memcg(current);
+	if (!cgrp)
+		return 0;
+
+	cg_id = cgroup_id(cgrp);
+	start_time_ptr = bpf_task_storage_get(&vmscan_start_time, current, 0,
+					      BPF_LOCAL_STORAGE_GET_F_CREATE);
+	if (!start_time_ptr)
+		return 0;
+
+	current_elapsed = end_time - *start_time_ptr;
+	pcpu_stat = bpf_map_lookup_elem(&pcpu_cgroup_vmscan_elapsed,
+					&cg_id);
+	if (pcpu_stat)
+		pcpu_stat->state += current_elapsed;
+	else if (create_vmscan_percpu_elem(cg_id, current_elapsed))
+		return 0;
+
+	cgroup_rstat_updated(cgrp, bpf_get_smp_processor_id());
+	return 0;
+}
+
+SEC("fentry/bpf_rstat_flush")
+int BPF_PROG(vmscan_flush, struct cgroup *cgrp, struct cgroup *parent, int cpu)
+{
+	struct vmscan_percpu *pcpu_stat;
+	struct vmscan *total_stat, *parent_stat;
+	__u64 cg_id = cgroup_id(cgrp);
+	__u64 parent_cg_id = parent ? cgroup_id(parent) : 0;
+	__u64 *pcpu_vmscan;
+	__u64 state;
+	__u64 delta = 0;
+
+	/* Add CPU changes on this level since the last flush */
+	pcpu_stat = bpf_map_lookup_percpu_elem(&pcpu_cgroup_vmscan_elapsed,
+					       &cg_id, cpu);
+	if (pcpu_stat) {
+		state = pcpu_stat->state;
+		delta += state - pcpu_stat->prev;
+		pcpu_stat->prev = state;
+	}
+
+	total_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed, &cg_id);
+	if (!total_stat) {
+		if (create_vmscan_elem(cg_id, delta, 0))
+			return 0;
+
+		goto update_parent;
+	}
+
+	/* Collect pending stats from subtree */
+	if (total_stat->pending) {
+		delta += total_stat->pending;
+		total_stat->pending = 0;
+	}
+
+	/* Propagate changes to this cgroup's total */
+	total_stat->state += delta;
+
+update_parent:
+	/* Skip if there are no changes to propagate, or no parent */
+	if (!delta || !parent_cg_id)
+		return 0;
+
+	/* Propagate changes to cgroup's parent */
+	parent_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed,
+					  &parent_cg_id);
+	if (parent_stat)
+		parent_stat->pending += delta;
+	else
+		create_vmscan_elem(parent_cg_id, 0, delta);
+	return 0;
+}
+
+SEC("iter.s/cgroup")
+int BPF_PROG(dump_vmscan, struct bpf_iter_meta *meta, struct cgroup *cgrp)
+{
+	struct seq_file *seq = meta->seq;
+	struct vmscan *total_stat;
+	__u64 cg_id = cgrp ? cgroup_id(cgrp) : 0;
+
+	/* Do nothing for the terminal call */
+	if (!cg_id)
+		return 1;
+
+	/* Flush the stats to make sure we get the most updated numbers */
+	cgroup_rstat_flush(cgrp);
+
+	total_stat = bpf_map_lookup_elem(&cgroup_vmscan_elapsed, &cg_id);
+	if (!total_stat) {
+		BPF_SEQ_PRINTF(seq, "cg_id: %llu, total_vmscan_delay: 0\n",
+			       cg_id);
+	} else {
+		BPF_SEQ_PRINTF(seq, "cg_id: %llu, total_vmscan_delay: %llu\n",
+			       cg_id, total_stat->state);
+	}
+
+	/*
+	 * We only dump stats for one cgroup here, so return 1 to stop
+	 * iteration after the first cgroup.
+	 */
+	return 1;
+}
-- 
2.37.1.595.g718a3a8f04-goog

