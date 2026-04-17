Return-Path: <cgroups+bounces-15340-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OR1EVGr4WlVwgAAu9opvQ
	(envelope-from <cgroups+bounces-15340-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 05:38:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB756416A46
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 05:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B38B30511A6
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 03:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A35331A44;
	Fri, 17 Apr 2026 03:38:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F835AC29;
	Fri, 17 Apr 2026 03:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776397126; cv=none; b=Vd9yfF6XyaY5i/lEK5UWabTcXI9yhJgigHQwn57ugmQz1aBrorllzAI6QWvTeq+CjzUwR3kH/fwbvb1f0hTadH2/zz5cxmA5KG4i01JmhFN1h9cRtskMZ9o8nPDV410XINQ3R00ImkjPm2OTyaDVXlaynJk1LoYvylag773DWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776397126; c=relaxed/simple;
	bh=h2Fs++siKjyTsS0bIJDVMJiUlyqQfMdAKlfA+KH5aFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJxR1Tm8xzxeJ7yOdzch0AXEv3L+gQfGKxPTW514HINv5YyQn5xi4aoHXWagQPJCK2NMfbUcswzZfcO5c7LnJaML1umUaQrZNfic3GkKKHLzabfF3+EyeurmTE9/b6Qba4DCvAN9rkeiOwATGF81JwZK2Z7llGyqkX957YTl88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ebc029763a0e11f1aa26b74ffac11d73-20260417
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1ccfb8e6-0053-48c2-8917-b61beb9eb2d7,IP:10,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:-20
X-CID-INFO: VERSION:1.3.12,REQID:1ccfb8e6-0053-48c2-8917-b61beb9eb2d7,IP:10,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-META: VersionHash:e7bac3a,CLOUDID:7dfa1faac29263a7d3cd348da00468de,BulkI
	D:260417113839ABO8TAQR,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:n
	il,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ebc029763a0e11f1aa26b74ffac11d73-20260417
X-User: zhangguopeng@kylinos.cn
Received: from yan.. [(183.242.174.22)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1006010797; Fri, 17 Apr 2026 11:38:38 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	shuah@kernel.org,
	chenridong@huaweicloud.com
Cc: cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH 2/2] selftests/sched_ext: add cpuset DL rollback test
Date: Fri, 17 Apr 2026 11:37:42 +0800
Message-ID: <20260417033742.40793-3-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-15340-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangguopeng@kylinos.cn,cgroups@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB756416A46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The cpuset DL rollback bug only shows up when another controller rejects
a migration after cpuset_can_attach() has already succeeded. Use a
sched_ext scheduler whose cgroup_prep_move() rejects SCHED_DEADLINE
tasks so that the cpu controller fails after cpuset and drives the real
attach rollback path from userspace.

Create overlapping source and destination cpusets under the current
cgroup, using that cgroup's effective CPU and memory masks. Constrain
the destination cpuset to a single CPU so the rollback accounting target
is deterministic, then compare dl_bw->total_bw for that CPU before and
after the failed move. Restore the parent subtree_control state during
cleanup so the test does not leave the cgroup tree changed.

This catches the old behavior where cpuset_cancel_attach() could free DL
bandwidth even though cpuset_can_attach() never allocated it. The test
reads sched/debug because that debugfs output exposes the per-CPU
dl_bw->total_bw accounting that the rollback perturbs.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
---
 tools/testing/selftests/sched_ext/Makefile    |   1 +
 .../sched_ext/cpuset_dl_rollback.bpf.c        |  28 +
 .../selftests/sched_ext/cpuset_dl_rollback.c  | 810 ++++++++++++++++++
 3 files changed, 839 insertions(+)
 create mode 100644 tools/testing/selftests/sched_ext/cpuset_dl_rollback.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/cpuset_dl_rollback.c

diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
index 789037be44c7..2a54d15552bd 100644
--- a/tools/testing/selftests/sched_ext/Makefile
+++ b/tools/testing/selftests/sched_ext/Makefile
@@ -162,6 +162,7 @@ endef
 all_test_bpfprogs := $(foreach prog,$(wildcard *.bpf.c),$(INCLUDE_DIR)/$(patsubst %.c,%.skel.h,$(prog)))
 
 auto-test-targets :=			\
+	cpuset_dl_rollback		\
 	create_dsq			\
 	dequeue				\
 	enq_last_no_enq_fails		\
diff --git a/tools/testing/selftests/sched_ext/cpuset_dl_rollback.bpf.c b/tools/testing/selftests/sched_ext/cpuset_dl_rollback.bpf.c
new file mode 100644
index 000000000000..ca5758a7361f
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cpuset_dl_rollback.bpf.c
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * A sched_ext scheduler used to trigger attach rollback after cpuset has
+ * already accepted the migration.
+ *
+ * Reject moving SCHED_DEADLINE tasks between cgroups from cgroup_prep_move(),
+ * which makes the cpu controller fail after cpuset has already succeeded.
+ */
+
+#include <scx/common.bpf.h>
+
+#define SCHED_DEADLINE 6
+
+char _license[] SEC("license") = "GPL";
+
+s32 BPF_STRUCT_OPS(cpuset_dl_rollback_cgroup_prep_move, struct task_struct *p,
+		   struct cgroup *from, struct cgroup *to)
+{
+	if (p->policy == SCHED_DEADLINE)
+		return -EAGAIN;
+
+	return 0;
+}
+SEC(".struct_ops.link")
+struct sched_ext_ops cpuset_dl_rollback_ops = {
+	.cgroup_prep_move	= (void *)cpuset_dl_rollback_cgroup_prep_move,
+	.name			= "cpuset_dl_rollback",
+};
diff --git a/tools/testing/selftests/sched_ext/cpuset_dl_rollback.c b/tools/testing/selftests/sched_ext/cpuset_dl_rollback.c
new file mode 100644
index 000000000000..44b6cad77d3e
--- /dev/null
+++ b/tools/testing/selftests/sched_ext/cpuset_dl_rollback.c
@@ -0,0 +1,810 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Verify that rollback from cpu_cgroup_can_attach() failure doesn't perturb DL
+ * bandwidth accounting when cpuset_can_attach() didn't allocate DL bandwidth in
+ * the first place.
+ *
+ * The test uses a sched_ext scheduler whose cgroup_prep_move() rejects
+ * SCHED_DEADLINE task migration. That makes the cpu controller fail after the
+ * cpuset controller has already accepted the move, which triggers the cgroup
+ * rollback path without any kernel fault injection.
+ */
+#define _GNU_SOURCE
+
+#include <bpf/bpf.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <limits.h>
+#include <linux/sched/types.h>
+#include <scx/common.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "cpuset_dl_rollback.bpf.skel.h"
+#include "scx_test.h"
+
+#ifndef SYS_sched_setattr
+#if defined(__x86_64__)
+#define SYS_sched_setattr 314
+#elif defined(__i386__)
+#define SYS_sched_setattr 351
+#elif defined(__aarch64__)
+#define SYS_sched_setattr 274
+#else
+#error "Unknown architecture: please define SYS_sched_setattr"
+#endif
+#endif
+
+#ifndef SCHED_DEADLINE
+#define SCHED_DEADLINE 6
+#endif
+
+#define CGROUP2_ROOT "/sys/fs/cgroup"
+#define SCHED_DEBUG "/sys/kernel/debug/sched/debug"
+
+struct cpuset_dl_rollback_ctx {
+	struct cpuset_dl_rollback *skel;
+	struct bpf_link *link;
+	pid_t child;
+	/* The only CPU in dst, and the rollback accounting observation point. */
+	int target_cpu;
+	bool restore_parent_subtree;
+	char parent[PATH_MAX];
+	char root[PATH_MAX];
+	char src[PATH_MAX];
+	char dst[PATH_MAX];
+	char src_rel[PATH_MAX];
+	char parent_subtree[256];
+	char cpu_list[1024];
+	char mem_list[256];
+	char dst_cpu[32];
+};
+
+static void cleanup(void *arg);
+
+static int sched_setattr(pid_t pid, const struct sched_attr *attr,
+			 unsigned int flags)
+{
+	return syscall(SYS_sched_setattr, pid, attr, flags);
+}
+
+static void trim_trailing_ws(char *buf)
+{
+	size_t len = strlen(buf);
+
+	while (len > 0) {
+		char c = buf[len - 1];
+
+		if (c != '\n' && c != ' ' && c != '\t')
+			break;
+		buf[--len] = '\0';
+	}
+}
+
+static int read_text(const char *path, char *buf, size_t size)
+{
+	ssize_t len;
+	int fd;
+
+	fd = open(path, O_RDONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	len = read(fd, buf, size - 1);
+	close(fd);
+	if (len < 0)
+		return -errno;
+
+	buf[len] = '\0';
+	trim_trailing_ws(buf);
+	return 0;
+}
+
+static int write_text(const char *path, const char *buf)
+{
+	size_t len = strlen(buf);
+	ssize_t ret;
+	int fd;
+
+	fd = open(path, O_WRONLY | O_CLOEXEC);
+	if (fd < 0)
+		return -errno;
+
+	ret = write(fd, buf, len);
+	close(fd);
+	if (ret < 0)
+		return -errno;
+	if ((size_t)ret != len)
+		return -EIO;
+
+	return 0;
+}
+
+static int build_path(char *buf, size_t size, const char *dir, const char *file)
+{
+	int ret;
+
+	ret = snprintf(buf, size, "%s/%s", dir, file);
+	if (ret < 0 || (size_t)ret >= size)
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
+static int build_cgroup_dir(const char *rel, char *buf, size_t size)
+{
+	int ret;
+
+	if (!strcmp(rel, "/"))
+		ret = snprintf(buf, size, "%s", CGROUP2_ROOT);
+	else
+		ret = snprintf(buf, size, "%s%s", CGROUP2_ROOT, rel);
+
+	if (ret < 0 || (size_t)ret >= size)
+		return -ENAMETOOLONG;
+
+	return 0;
+}
+
+static int read_cgroup_relpath(const char *path, char *buf, size_t size)
+{
+	char line[PATH_MAX];
+	FILE *fp;
+	int ret;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		return -errno;
+
+	while (fgets(line, sizeof(line), fp)) {
+		char *first, *second, *rel;
+
+		trim_trailing_ws(line);
+
+		first = strchr(line, ':');
+		if (!first) {
+			fclose(fp);
+			return -EINVAL;
+		}
+
+		second = strchr(first + 1, ':');
+		if (!second) {
+			fclose(fp);
+			return -EINVAL;
+		}
+
+		*first = '\0';
+		*second = '\0';
+
+		/* Match the cgroup v2 entry, which is formatted as 0::/path. */
+		if (strcmp(line, "0") || first[1] != '\0')
+			continue;
+
+		rel = second + 1;
+		if (rel[0] != '/') {
+			fclose(fp);
+			return -EINVAL;
+		}
+
+		ret = snprintf(buf, size, "%s", rel);
+		fclose(fp);
+		if (ret < 0 || (size_t)ret >= size)
+			return -ENAMETOOLONG;
+
+		return 0;
+	}
+
+	if (ferror(fp)) {
+		fclose(fp);
+		return -EIO;
+	}
+
+	fclose(fp);
+	return -EOPNOTSUPP;
+}
+
+static bool has_token(const char *list, const char *token)
+{
+	size_t len = strlen(token);
+	const char *pos = list;
+
+	while ((pos = strstr(pos, token))) {
+		bool left_ok = pos == list || pos[-1] == ' ';
+		bool right_ok = pos[len] == '\0' || pos[len] == ' ';
+
+		if (left_ok && right_ok)
+			return true;
+		pos += len;
+	}
+
+	return false;
+}
+
+static int enable_controllers(const char *dir, char *orig, size_t orig_sz,
+			      bool *changed)
+{
+	char ctrl_path[PATH_MAX];
+	char subtree_path[PATH_MAX];
+	char controllers[256];
+	char subtree[256];
+	char enable[64];
+	size_t len = 0;
+	int ret;
+
+	ret = build_path(ctrl_path, sizeof(ctrl_path), dir, "cgroup.controllers");
+	if (ret)
+		return ret;
+	ret = build_path(subtree_path, sizeof(subtree_path), dir,
+			 "cgroup.subtree_control");
+	if (ret)
+		return ret;
+
+	ret = read_text(ctrl_path, controllers, sizeof(controllers));
+	if (ret == -ENOENT)
+		return -EOPNOTSUPP;
+	if (ret)
+		return ret;
+	if (!has_token(controllers, "cpu") || !has_token(controllers, "cpuset"))
+		return -EOPNOTSUPP;
+
+	ret = read_text(subtree_path, subtree, sizeof(subtree));
+	if (ret == -ENOENT)
+		return -EOPNOTSUPP;
+	if (ret)
+		return ret;
+
+	enable[0] = '\0';
+	if (!has_token(subtree, "cpu"))
+		len += snprintf(enable + len, sizeof(enable) - len, "+cpu ");
+	if (!has_token(subtree, "cpuset"))
+		len += snprintf(enable + len, sizeof(enable) - len, "+cpuset ");
+	if (len >= sizeof(enable))
+		return -EOVERFLOW;
+
+	if (!enable[0]) {
+		if (orig && orig_sz) {
+			ret = snprintf(orig, orig_sz, "%s", subtree);
+			if (ret < 0 || (size_t)ret >= orig_sz)
+				return -ENAMETOOLONG;
+		}
+		if (changed)
+			*changed = false;
+		return 0;
+	}
+
+	if (orig && orig_sz) {
+		ret = snprintf(orig, orig_sz, "%s", subtree);
+		if (ret < 0 || (size_t)ret >= orig_sz)
+			return -ENAMETOOLONG;
+	}
+
+	trim_trailing_ws(enable);
+	ret = write_text(subtree_path, enable);
+	if (!ret && changed)
+		*changed = true;
+	return ret;
+}
+
+static int restore_controllers(const char *dir, const char *orig)
+{
+	char subtree_path[PATH_MAX];
+	char subtree[256];
+	char disable[64];
+	size_t len = 0;
+	int ret;
+
+	ret = build_path(subtree_path, sizeof(subtree_path), dir,
+			 "cgroup.subtree_control");
+	if (ret)
+		return ret;
+
+	ret = read_text(subtree_path, subtree, sizeof(subtree));
+	if (ret)
+		return ret;
+
+	/*
+	 * Only undo controllers that this test turned on. If "cpu" or "cpuset"
+	 * was already present in the original subtree_control state, leave it
+	 * alone.
+	 */
+	disable[0] = '\0';
+	if (has_token(subtree, "cpu") && !has_token(orig, "cpu"))
+		len += snprintf(disable + len, sizeof(disable) - len, "-cpu ");
+	if (has_token(subtree, "cpuset") && !has_token(orig, "cpuset"))
+		len += snprintf(disable + len, sizeof(disable) - len,
+				"-cpuset ");
+	if (len >= sizeof(disable))
+		return -EOVERFLOW;
+
+	if (!disable[0])
+		return 0;
+
+	trim_trailing_ws(disable);
+	return write_text(subtree_path, disable);
+}
+
+static int mkdir_one(const char *path)
+{
+	if (mkdir(path, 0755) && errno != EEXIST)
+		return -errno;
+	return 0;
+}
+
+static int write_pid(const char *path, pid_t pid)
+{
+	char buf[32];
+	int ret;
+
+	ret = snprintf(buf, sizeof(buf), "%d", pid);
+	if (ret < 0 || (size_t)ret >= sizeof(buf))
+		return -EOVERFLOW;
+
+	return write_text(path, buf);
+}
+
+/* Parse the first CPU from a cpulist-style string such as "0-3,8". */
+static int first_list_item(const char *list, char *buf, size_t size, int *valp)
+{
+	char *end;
+	long val;
+	int ret;
+
+	errno = 0;
+	val = strtol(list, &end, 10);
+	if (errno || end == list || val < 0)
+		return -EINVAL;
+
+	if (valp)
+		*valp = val;
+
+	ret = snprintf(buf, size, "%ld", val);
+	if (ret < 0 || (size_t)ret >= size)
+		return -EOVERFLOW;
+
+	return 0;
+}
+
+/*
+ * sched/debug reports dl_bw->total_bw inside each CPU section.
+ *
+ * This test constrains dst to a single CPU and stores that CPU number in
+ * ctx->target_cpu. cpuset_cancel_attach() rolls rollback accounting against a
+ * CPU selected from the destination effective mask, so with a single-CPU dst
+ * that exact CPU becomes the rollback site and the matching observation point.
+ *
+ * Reading only the target CPU's dl_bw->total_bw avoids assuming that every CPU
+ * in the system shares one root domain. Unlike sched_ext/total_bw.c, this test
+ * has to identify one specific CPU section, so it also relies on the current
+ * sched/debug "cpu#<n>" section header format.
+ */
+static int read_cpu_total_bw(int target_cpu, long long *bw)
+{
+	char line[256];
+	FILE *fp;
+	bool in_target = false;
+
+	fp = fopen(SCHED_DEBUG, "r");
+	if (!fp)
+		return -errno;
+
+	while (fgets(line, sizeof(line), fp)) {
+		int header_cpu;
+		char *val;
+
+		if (sscanf(line, "cpu#%d", &header_cpu) == 1) {
+			if (in_target)
+				break;
+
+			in_target = header_cpu == target_cpu;
+			continue;
+		}
+		if (!in_target)
+			continue;
+
+		val = strstr(line, "dl_bw->total_bw");
+		if (!val)
+			continue;
+
+		val = strchr(val, ':');
+		if (!val) {
+			fclose(fp);
+			return -EINVAL;
+		}
+
+		*bw = strtoll(val + 1, NULL, 10);
+		fclose(fp);
+		return 0;
+	}
+
+	fclose(fp);
+	return -ENOENT;
+}
+
+static int set_deadline_policy(void)
+{
+	struct sched_attr attr = {
+		.size = sizeof(attr),
+		.sched_policy = SCHED_DEADLINE,
+		.sched_runtime = 10 * 1000 * 1000ULL,
+		.sched_deadline = 30 * 1000 * 1000ULL,
+		.sched_period = 30 * 1000 * 1000ULL,
+	};
+
+	return sched_setattr(0, &attr, 0);
+}
+
+static int spawn_dl_child(struct cpuset_dl_rollback_ctx *ctx)
+{
+	char procs_path[PATH_MAX];
+	int pipefd[2];
+	pid_t pid;
+	int child_ret;
+	int ret;
+
+	ret = build_path(procs_path, sizeof(procs_path), ctx->src, "cgroup.procs");
+	if (ret)
+		return ret;
+
+	if (pipe(pipefd))
+		return -errno;
+
+	pid = fork();
+	if (pid < 0) {
+		ret = -errno;
+		close(pipefd[0]);
+		close(pipefd[1]);
+		return ret;
+	}
+
+	if (!pid) {
+		int err = 0;
+
+		close(pipefd[0]);
+
+		err = write_pid(procs_path, getpid());
+		if (!err && set_deadline_policy())
+			err = -errno;
+
+		if (write(pipefd[1], &err, sizeof(err)) != sizeof(err))
+			_exit(1);
+
+		if (err)
+			_exit(1);
+
+		for (;;)
+			pause();
+	}
+
+	close(pipefd[1]);
+	ret = read(pipefd[0], &child_ret, sizeof(child_ret));
+	close(pipefd[0]);
+	if (ret != sizeof(child_ret)) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		return -EIO;
+	}
+
+	if (child_ret) {
+		kill(pid, SIGKILL);
+		waitpid(pid, NULL, 0);
+		return child_ret;
+	}
+
+	ctx->child = pid;
+	return 0;
+}
+
+static int create_cgroups(struct cpuset_dl_rollback_ctx *ctx)
+{
+	char parent_rel[PATH_MAX];
+	char path[PATH_MAX];
+	char tmpl[PATH_MAX];
+	int ret;
+
+	ret = read_cgroup_relpath("/proc/self/cgroup", parent_rel,
+				  sizeof(parent_rel));
+	if (ret)
+		return ret;
+
+	ret = build_cgroup_dir(parent_rel, ctx->parent, sizeof(ctx->parent));
+	if (ret)
+		return ret;
+
+	ret = enable_controllers(ctx->parent, ctx->parent_subtree,
+				 sizeof(ctx->parent_subtree),
+				 &ctx->restore_parent_subtree);
+	if (ret)
+		return ret;
+
+	ret = build_path(path, sizeof(path), ctx->parent, "cpuset.cpus.effective");
+	if (ret)
+		return ret;
+	ret = read_text(path, ctx->cpu_list, sizeof(ctx->cpu_list));
+	if (ret == -ENOENT)
+		return -EOPNOTSUPP;
+	if (ret)
+		return ret;
+
+	ret = build_path(path, sizeof(path), ctx->parent, "cpuset.mems.effective");
+	if (ret)
+		return ret;
+	ret = read_text(path, ctx->mem_list, sizeof(ctx->mem_list));
+	if (ret == -ENOENT)
+		return -EOPNOTSUPP;
+	if (ret)
+		return ret;
+	if (!ctx->cpu_list[0] || !ctx->mem_list[0])
+		return -ENOSPC;
+
+	/*
+	 * Keep dst on a single CPU so the rollback accounting target is
+	 * deterministic. That same CPU is later sampled from sched/debug.
+	 */
+	ret = first_list_item(ctx->cpu_list, ctx->dst_cpu, sizeof(ctx->dst_cpu),
+			      &ctx->target_cpu);
+	if (ret)
+		return ret;
+
+	ret = snprintf(tmpl, sizeof(tmpl), "%s/scx-cpuset-dl-rollback-XXXXXX",
+		       ctx->parent);
+	if (ret < 0 || (size_t)ret >= sizeof(tmpl))
+		return -ENAMETOOLONG;
+
+	if (!mkdtemp(tmpl))
+		return -errno;
+
+	ret = snprintf(ctx->root, sizeof(ctx->root), "%s", tmpl);
+	if (ret < 0 || (size_t)ret >= sizeof(ctx->root))
+		return -EOVERFLOW;
+
+	ret = snprintf(ctx->src, sizeof(ctx->src), "%s/src", ctx->root);
+	if (ret < 0 || (size_t)ret >= sizeof(ctx->src))
+		return -EOVERFLOW;
+	ret = snprintf(ctx->dst, sizeof(ctx->dst), "%s/ovl", ctx->root);
+	if (ret < 0 || (size_t)ret >= sizeof(ctx->dst))
+		return -EOVERFLOW;
+	ret = snprintf(ctx->src_rel, sizeof(ctx->src_rel), "%s/src",
+		       ctx->root + strlen(CGROUP2_ROOT));
+	if (ret < 0 || (size_t)ret >= sizeof(ctx->src_rel))
+		return -EOVERFLOW;
+
+	ret = build_path(path, sizeof(path), ctx->root, "cpuset.cpus");
+	if (ret)
+		return ret;
+	ret = write_text(path, ctx->cpu_list);
+	if (ret)
+		return ret;
+
+	ret = build_path(path, sizeof(path), ctx->root, "cpuset.mems");
+	if (ret)
+		return ret;
+	ret = write_text(path, ctx->mem_list);
+	if (ret)
+		return ret;
+
+	ret = enable_controllers(ctx->root, NULL, 0, NULL);
+	if (ret)
+		return ret;
+
+	ret = mkdir_one(ctx->src);
+	if (ret)
+		return ret;
+	ret = mkdir_one(ctx->dst);
+	if (ret)
+		return ret;
+
+	ret = build_path(path, sizeof(path), ctx->src, "cpuset.cpus");
+	if (ret)
+		return ret;
+	ret = write_text(path, ctx->cpu_list);
+	if (ret)
+		return ret;
+
+	ret = build_path(path, sizeof(path), ctx->src, "cpuset.mems");
+	if (ret)
+		return ret;
+	ret = write_text(path, ctx->mem_list);
+	if (ret)
+		return ret;
+
+	ret = build_path(path, sizeof(path), ctx->dst, "cpuset.cpus");
+	if (ret)
+		return ret;
+	ret = write_text(path, ctx->dst_cpu);
+	if (ret)
+		return ret;
+
+	ret = build_path(path, sizeof(path), ctx->dst, "cpuset.mems");
+	if (ret)
+		return ret;
+	return write_text(path, ctx->mem_list);
+}
+
+static bool child_in_src(const struct cpuset_dl_rollback_ctx *ctx)
+{
+	char path[PATH_MAX];
+	char cgroup[PATH_MAX];
+	int ret;
+
+	ret = snprintf(path, sizeof(path), "/proc/%d/cgroup", ctx->child);
+	if (ret < 0 || (size_t)ret >= sizeof(path))
+		return false;
+
+	if (read_cgroup_relpath(path, cgroup, sizeof(cgroup)))
+		return false;
+
+	return strcmp(cgroup, ctx->src_rel) == 0;
+}
+
+static enum scx_test_status setup(void **out_ctx)
+{
+	struct cpuset_dl_rollback_ctx *ctx;
+	int ret;
+
+	if (geteuid()) {
+		fprintf(stderr, "Skipping test: root privileges required\n");
+		return SCX_TEST_SKIP;
+	}
+
+	if (access(SCHED_DEBUG, R_OK)) {
+		fprintf(stderr, "Skipping test: %s not accessible\n", SCHED_DEBUG);
+		return SCX_TEST_SKIP;
+	}
+
+	ctx = calloc(1, sizeof(*ctx));
+	if (!ctx)
+		return SCX_TEST_FAIL;
+
+	ret = create_cgroups(ctx);
+	switch (ret) {
+	case -EOPNOTSUPP:
+		fprintf(stderr,
+			"Skipping test: cgroup v2 cpu/cpuset controllers unavailable in current cgroup tree\n");
+		cleanup(ctx);
+		return SCX_TEST_SKIP;
+	case -EPERM:
+	case -EACCES:
+	case -EROFS:
+		fprintf(stderr,
+			"Skipping test: current cgroup tree does not allow cpu/cpuset writes\n");
+		cleanup(ctx);
+		return SCX_TEST_SKIP;
+	case -EBUSY:
+		fprintf(stderr,
+			"Skipping test: current cgroup tree does not allow enabling cpu/cpuset controllers here\n");
+		cleanup(ctx);
+		return SCX_TEST_SKIP;
+	case -ENOSPC:
+		fprintf(stderr,
+			"Skipping test: current cgroup does not expose enough effective cpuset resources\n");
+		cleanup(ctx);
+		return SCX_TEST_SKIP;
+	}
+	if (ret) {
+		SCX_ERR("Failed to create cgroups (%d)", ret);
+		cleanup(ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	ctx->skel = cpuset_dl_rollback__open();
+	if (!ctx->skel) {
+		SCX_ERR("Failed to open skel");
+		cleanup(ctx);
+		return SCX_TEST_FAIL;
+	}
+	SCX_ENUM_INIT(ctx->skel);
+	if (cpuset_dl_rollback__load(ctx->skel)) {
+		SCX_ERR("Failed to load skel");
+		cleanup(ctx);
+		return SCX_TEST_FAIL;
+	}
+
+	*out_ctx = ctx;
+	return SCX_TEST_PASS;
+}
+
+static enum scx_test_status run(void *arg)
+{
+	struct cpuset_dl_rollback_ctx *ctx = arg;
+	char procs_path[PATH_MAX];
+	long long before_bw, after_bw;
+	int ret;
+
+	ret = read_cpu_total_bw(ctx->target_cpu, &before_bw);
+	SCX_FAIL_IF(ret, "Failed to read baseline total_bw (%d)", ret);
+
+	ctx->link = bpf_map__attach_struct_ops(ctx->skel->maps.cpuset_dl_rollback_ops);
+	SCX_FAIL_IF(!ctx->link, "Failed to attach scheduler");
+
+	ret = spawn_dl_child(ctx);
+	switch (ret) {
+	case -EACCES:
+	case -EPERM:
+		fprintf(stderr,
+			"Skipping test: unable to place child in the source cgroup or enable SCHED_DEADLINE due to permissions (%d)\n",
+			ret);
+		return SCX_TEST_SKIP;
+	case -EBUSY:
+		fprintf(stderr,
+			"Skipping test: SCHED_DEADLINE admission control rejected the child (%d)\n",
+			ret);
+		return SCX_TEST_SKIP;
+	case -EINVAL:
+		fprintf(stderr,
+			"Skipping test: unable to enable SCHED_DEADLINE for the child in this environment (%d)\n",
+			ret);
+		return SCX_TEST_SKIP;
+	}
+	SCX_FAIL_IF(ret, "Failed to start SCHED_DEADLINE child (%d)", ret);
+
+	ret = read_cpu_total_bw(ctx->target_cpu, &before_bw);
+	SCX_FAIL_IF(ret, "Failed to read pre-move total_bw (%d)", ret);
+
+	ret = build_path(procs_path, sizeof(procs_path), ctx->dst, "cgroup.procs");
+	SCX_FAIL_IF(ret, "Failed to build cgroup.procs path (%d)", ret);
+
+	ret = write_pid(procs_path, ctx->child);
+	SCX_FAIL_IF(ret != -EAGAIN,
+		    "Expected cgroup move failure with -EAGAIN, got %d", ret);
+	SCX_FAIL_IF(!child_in_src(ctx), "Child left source cgroup after rollback");
+
+	ret = read_cpu_total_bw(ctx->target_cpu, &after_bw);
+	SCX_FAIL_IF(ret, "Failed to read post-move total_bw (%d)", ret);
+	SCX_FAIL_IF(after_bw != before_bw,
+		    "Expected total_bw for CPU%d to remain unchanged (%lld != %lld)",
+		    ctx->target_cpu, after_bw, before_bw);
+
+	return SCX_TEST_PASS;
+}
+
+static void cleanup(void *arg)
+{
+	struct cpuset_dl_rollback_ctx *ctx = arg;
+	int ret;
+
+	if (!ctx)
+		return;
+
+	if (ctx->child > 0) {
+		kill(ctx->child, SIGKILL);
+		waitpid(ctx->child, NULL, 0);
+	}
+
+	if (ctx->link)
+		bpf_link__destroy(ctx->link);
+	if (ctx->skel)
+		cpuset_dl_rollback__destroy(ctx->skel);
+
+	if (ctx->dst[0])
+		rmdir(ctx->dst);
+	if (ctx->src[0])
+		rmdir(ctx->src);
+	if (ctx->root[0])
+		rmdir(ctx->root);
+
+	if (ctx->restore_parent_subtree) {
+		ret = restore_controllers(ctx->parent, ctx->parent_subtree);
+		if (ret)
+			fprintf(stderr,
+				"%s: failed to restore %s/cgroup.subtree_control (%d)\n",
+				__func__, ctx->parent, ret);
+	}
+
+	free(ctx);
+}
+
+struct scx_test cpuset_dl_rollback = {
+	.name = "cpuset_dl_rollback",
+	.description = "Verify attach rollback after cpuset preserves DL bandwidth accounting",
+	.setup = setup,
+	.run = run,
+	.cleanup = cleanup,
+};
+REGISTER_SCX_TEST(&cpuset_dl_rollback)
-- 
2.43.0


