Return-Path: <cgroups+bounces-17480-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZROYAqeSSGqhrgAAu9opvQ
	(envelope-from <cgroups+bounces-17480-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 06:57:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B2608706A8B
	for <lists+cgroups@lfdr.de>; Sat, 04 Jul 2026 06:57:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XdIb7x3m;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17480-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17480-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D44C3022908
	for <lists+cgroups@lfdr.de>; Sat,  4 Jul 2026 04:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B15638D01B;
	Sat,  4 Jul 2026 04:56:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A9738910E
	for <cgroups@vger.kernel.org>; Sat,  4 Jul 2026 04:56:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783141005; cv=none; b=CWkbugzcccuWadtmMEIlIrl2RUyC9jMJL7lwOuAwoQjxzamB5wsbFKQOTle9h9U135NDDS6Y/JuU0eAewXLnypAwem+Vqv0lLCOOV+OssVyAXmYGu1cgsuIojf9mcUfX+LfnqNEQs6W8c7hHjg9XOwV7q1MZZt4f6q1McJFmoCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783141005; c=relaxed/simple;
	bh=OpXGK44SZhSqwSPo9ylcyFDVeBN4/aWtFdFBPphpl8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1qdBEug0+EISdj7fHKWD/qknW6/yiQ/flm2CowX7/WNStgltctP6EMbt7JBwSZ/eeyu1JXF+bFuo5Yauqy+OlgFw3i54NxVcXfiVL6dbuEaYKIdAJGMVzaVpAOc7azQYbYi9G22tKF+6Pyr25BRGGB4uUWAB4B0fkm3zQJ4uQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdIb7x3m; arc=none smtp.client-ip=209.85.215.193
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso836305a12.2
        for <cgroups@vger.kernel.org>; Fri, 03 Jul 2026 21:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783141001; x=1783745801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj04xp6owV2DkV/l2RSlBC1aE0MzBBmHrmxdSFA0FCc=;
        b=XdIb7x3mTiEDtezFs0GfRS/8O0U9lQTqQ3pjzLyXIQOZDuQ2wNBPvZs8ORAPLMqpY/
         yxDbnG0EKUoX/+WmkNSsnh0Z6cF0t+1QMlsD19wGaOZoHKYhls+eaaG1S1aBhhCuWsmh
         R9eekYKIkGrt0HvNWNvTO8SenouilN3liMbUVee6SVgHr/7oC8LoRGdYmoEooHGP2qSY
         wkRff5UmxDzJGjEXJshJ/xjZOjhwjv3muu9nHG+x4vbyEAsJ5KfGVwA6NckYdP+B+TZC
         pChsPoePw9r2ncJjajaOBoa3J9k/YjzODiRzCgFYkmlahsEvG0IfV8oQyWIOKPTKHoQx
         pfBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783141001; x=1783745801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uj04xp6owV2DkV/l2RSlBC1aE0MzBBmHrmxdSFA0FCc=;
        b=CsOMTxd8AAl2QM6wkqk9XQINIfBwcOKdZHRIO9Iu24AV1337r+iTCK/SCYuN8aCY1I
         lxDDOT1mQ+ksJfw8T6GIptHaLoF4queFIquShDGX0HK/o5N+51zgsHohx+1ynIoGRHSG
         RGpPck98kFzunoibdwpJkCPe1yJyoBoZKc6xjHM0kv/wfny7rG/Oo4rAWlWGKRlezNJZ
         M00l6VAcMzAQm5pefnOGaLYaWGfvtm/0UpzV6hgu//jlUMd8Ge2PoxaZ70af9zNChRJr
         5Ry3sKyRumanlcoI8Gglx31KAur+7j+WsYhPIac4jFZ+h5JHFBEXg51r109QtQd1NUU6
         rKfw==
X-Forwarded-Encrypted: i=1; AHgh+RoMgxW+gr4+AmdIEgZAxdm5MA0zk4yUKWxopmmok6VIxGMDB8WXhheXGCXsejS1Sl5mSHhiq82X@vger.kernel.org
X-Gm-Message-State: AOJu0YyaB/Wtg5JAidkz1nx9bXmhXAVeuEqAT4fh598dZtouhEtMp9tf
	dC5ALbVf38ZEmjHsqVxELwxFM4T5k01m8Ink7psOswM7rZVOzswsiqMx
X-Gm-Gg: AfdE7ckGBiLFJ5pcKI1Jj3bF6biJn2QYsOYMGWTszQMK14+IPgrLZndt2BnJ1N0wCMY
	qnRmNYB6hZpBzKqEUgzKZwqmz9eyq3UJG9/KEwVhymcpbmGCWYxSSxr8Xe+3lfmWM389smjLSoy
	Ss34ErLxb4kbRzQ2YlHQ8n+XWesDO2mEVgWx0dCyzTfG7Uji00c3lvK/+Slc25+bfI9rYeRKSNN
	fVG1fTgDNhYX//Hbn3pa6r+62YHVBRrvf1o+E+Fh4Vl7AZGQkSYGQNHofkFnZW9L8fW21S+6bi0
	axVcInzaWYHsLU5vTFgKjH45uwxgOrDuEZUuUmpCuCg8W062nxzkXK5fVwp5xi2MAarq3n0AtQf
	RWYLtr8K4miC16ATqAUbhTAnN6vvPgdNleBXrcEyFHbksVVPIiUwmcKEHsNJJ5T1Ct0s4
X-Received: by 2002:a17:90b:1f8a:b0:380:9504:9780 with SMTP id 98e67ed59e1d1-3829fbd736cmr2162917a91.29.1783141000944;
        Fri, 03 Jul 2026 21:56:40 -0700 (PDT)
Received: from localhost ([2a03:2880:9ff:6a::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f1cbfc285sm17862797eec.5.2026.07.03.21.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 21:56:40 -0700 (PDT)
From: Ziyang Men <ziyang.meme@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	kernel-team@meta.com,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyang Men <ziyang.meme@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH 1/3] selftests/bpf: add memcg_stat_reader BPF-vs-memory.stat benchmark
Date: Fri,  3 Jul 2026 21:56:15 -0700
Message-ID: <20260704045617.487664-2-ziyang.meme@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260704045617.487664-1-ziyang.meme@gmail.com>
References: <20260704045617.487664-1-ziyang.meme@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17480-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[ziyangmeme@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:roman.gushchin@linux.dev,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ziyang.meme@gmail.com,m:shakeel.butt@linux.dev,m:ziyangmeme@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,etsalapatis.com,meta.com,kvack.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziyangmeme@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2608706A8B

Add a test_progs selftest that reads memory-cgroup statistics for a whole
synthetic cgroup subtree two ways and compares their cost:

  (A) the traditional path: open/read/parse memory.stat, memory.current
      and memory.max for every cgroup from userspace;
  (B) the BPF path: a single SEC("iter.s/cgroup") program walked over the
      subtree in BPF_CGROUP_ITER_DESCENDANTS_PRE order that calls the
      memcg kfuncs (bpf_get_mem_cgroup, bpf_mem_cgroup_flush_stats,
      bpf_mem_cgroup_page_state, bpf_mem_cgroup_vm_events,
      bpf_put_mem_cgroup) per cgroup and stashes the results in a hash map
      keyed by cgroup id, drained once afterwards.

The traditional path reads the control files through a new read_cgroup_file()
helper added to cgroup_helpers (the read counterpart of write_cgroup_file),
instead of open-coding the cgroupfs path layout in the test.

The test builds a parameterized tree (fanout x depth) and charges
anonymous memory into the leaves from a helper child so the per-cgroup and
hierarchical stats are non-zero, then:

  - asserts the BPF snapshot agrees with memory.stat for the anon counter
    (rstat-flushed and deterministic) within a small tolerance, and that
    the iterator visited every cgroup in the subtree;
  - reports memory.current drift as informational only: it is a live
    page_counter that both sides read identically, so a difference between
    the one-shot BPF walk and the longer file-reading loop is time skew,
    not a correctness issue;
  - reports the average wall-clock cost of each path reading the full
    ~memory.stat field set.

Subtests small/medium/large vary the tree size; large_sparse charges only
a fraction of the leaves to exercise rstat's "flush is O(updated subtree)"
behaviour. The pass/fail result depends only on the correctness checks; the
timing table is an informational diagnostic captured like any other test
output, i.e. printed only under -v (or when the test fails), never on a
normal PASS.

The BPF field fold guards each counter with bpf_core_enum_value_exists()
so an enumerator missing from the running kernel's BTF is skipped rather than
poisoning the whole program load, keeping the test loadable across kernel
configs and versions. When the memcg kfuncs are unavailable (CONFIG_MEMCG=n)
the test skips cleanly instead of failing to load; the base selftest config
now selects CONFIG_MEMCG=y as well.

The file path cost is dominated by per-cgroup VFS open/read and string
parsing, while the BPF path avoids per-cgroup syscalls and string parsing, so
it is ~32-37x faster for a whole-tree scan. The file path cost tracks the
number of cgroups traversed rather than the amount of memory charged: large
and large_sparse read the same 1111 files in about the same time. The BPF path
is cheaper still when fewer leaves are charged (large_sparse), because the
rstat flush is O(updated subtree).

Sample output (v7.1 VM); times are us, average per full-tree pass reading the
full memory.stat field set; ro = bpf read()-only (no map drain):

  ==== memcg_stat_reader: small ====
  tree: nodes=21 leaves=16 charged_leaves=16 fanout=4 depth=2 charge=256KB/leaf iters=200
  file_avg=2777.9  bpf_avg=84.7  bpf_ro=30.4  speedup(file/bpf)=32.82x

  ==== memcg_stat_reader: medium ====
  tree: nodes=111 leaves=100 charged_leaves=100 fanout=10 depth=2 charge=256KB/leaf iters=50
  file_avg=14633.3  bpf_avg=428.5  bpf_ro=144.5  speedup(file/bpf)=34.15x

  ==== memcg_stat_reader: large ====
  tree: nodes=1111 leaves=1000 charged_leaves=1000 fanout=10 depth=3 charge=256KB/leaf iters=10
  file_avg=156774.0  bpf_avg=4245.0  bpf_ro=1416.1  speedup(file/bpf)=36.93x

  ==== memcg_stat_reader: large_sparse ====
  tree: nodes=1111 leaves=1000 charged_leaves=125 fanout=10 depth=3 charge=256KB/leaf iters=10
  file_avg=158895.6  bpf_avg=4307.8  bpf_ro=1452.4  speedup(file/bpf)=36.89x

This builds on the memcg BPF kfuncs and complements the existing
cgroup_iter_memcg selftest.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Ziyang Men <ziyang.meme@gmail.com>
---
 tools/testing/selftests/bpf/cgroup_helpers.c  |  46 ++
 tools/testing/selftests/bpf/cgroup_helpers.h  |   2 +
 tools/testing/selftests/bpf/config            |   1 +
 .../testing/selftests/bpf/memcg_stat_reader.h |  35 +
 .../bpf/prog_tests/memcg_stat_reader.c        | 617 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_stat_reader.c   | 181 +++++
 6 files changed, 882 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/memcg_stat_reader.h
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_stat_reader.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_stat_reader.c

diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
index 45cd0b479fe3..fe8ec07c6100 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.c
+++ b/tools/testing/selftests/bpf/cgroup_helpers.c
@@ -188,6 +188,52 @@ int write_cgroup_file_parent(const char *relative_path, const char *file,
 	return __write_cgroup_file(cgroup_path, file, buf);
 }
 
+static int __read_cgroup_file(const char *cgroup_path, const char *file,
+			      char *buf, size_t buf_size)
+{
+	char file_path[PATH_MAX + 1];
+	ssize_t len;
+	int fd;
+
+	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
+	fd = open(file_path, O_RDONLY);
+	if (fd < 0) {
+		log_err("Opening %s", file_path);
+		return 1;
+	}
+
+	len = read(fd, buf, buf_size - 1);
+	close(fd);
+	if (len < 0) {
+		log_err("Reading %s", file_path);
+		return 1;
+	}
+	buf[len] = '\0';
+	return 0;
+}
+
+/**
+ * read_cgroup_file() - Read from a cgroup file
+ * @relative_path: The cgroup path, relative to the workdir
+ * @file: The name of the file in cgroupfs to read from
+ * @buf: Buffer to read into; NUL-terminated on success
+ * @buf_size: Size of @buf; at most @buf_size - 1 bytes are read
+ *
+ * Read from a file in the given cgroup's directory. As with reading any
+ * cgroupfs control/stat file, @buf should be large enough to hold the whole
+ * value in a single read().
+ *
+ * If successful, 0 is returned.
+ */
+int read_cgroup_file(const char *relative_path, const char *file,
+		     char *buf, size_t buf_size)
+{
+	char cgroup_path[PATH_MAX - 24];
+
+	format_cgroup_path(cgroup_path, relative_path);
+	return __read_cgroup_file(cgroup_path, file, buf, buf_size);
+}
+
 /**
  * setup_cgroup_environment() - Setup the cgroup environment
  *
diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing/selftests/bpf/cgroup_helpers.h
index 3857304be874..1ed76dd3a1da 100644
--- a/tools/testing/selftests/bpf/cgroup_helpers.h
+++ b/tools/testing/selftests/bpf/cgroup_helpers.h
@@ -15,6 +15,8 @@ int write_cgroup_file(const char *relative_path, const char *file,
 		      const char *buf);
 int write_cgroup_file_parent(const char *relative_path, const char *file,
 			     const char *buf);
+int read_cgroup_file(const char *relative_path, const char *file,
+		     char *buf, size_t buf_size);
 int cgroup_setup_and_join(const char *relative_path);
 int get_root_cgroup(void);
 int create_and_get_cgroup(const char *relative_path);
diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index adb25146e88c..4e75b4ea8649 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -55,6 +55,7 @@ CONFIG_LIRC=y
 CONFIG_LIVEPATCH=y
 CONFIG_LWTUNNEL=y
 CONFIG_LWTUNNEL_BPF=y
+CONFIG_MEMCG=y
 CONFIG_MODULE_SIG=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/tools/testing/selftests/bpf/memcg_stat_reader.h b/tools/testing/selftests/bpf/memcg_stat_reader.h
new file mode 100644
index 000000000000..72afebe95ccb
--- /dev/null
+++ b/tools/testing/selftests/bpf/memcg_stat_reader.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#ifndef __MEMCG_STAT_READER_H
+#define __MEMCG_STAT_READER_H
+
+/*
+ * One per-cgroup snapshot, produced by the BPF cgroup iterator and read back
+ * from a BPF hash map keyed by cgroup id.  The "matched" subset is always
+ * populated so it can be compared field-by-field against what userspace parses
+ * out of memory.stat / memory.current / memory.max.  The "full" fold is only
+ * populated when collect_full is set and exists to (a) force the extra kfunc
+ * reads to happen (so the full-vs-matched timing is honest) and (b) give a
+ * coarse, informational signal of how many fields the full path touched.
+ */
+struct memcg_stat_snapshot {
+	__u64 cgroup_id;
+
+	/* Matched subset. Page-state values are in bytes (already unit-scaled
+	 * by the kernel), so they compare directly against memory.stat.
+	 */
+	__u64 anon;		/* NR_ANON_MAPPED, bytes */
+	__u64 file;		/* NR_FILE_PAGES, bytes */
+	__u64 shmem;		/* NR_SHMEM, bytes */
+	__u64 file_mapped;	/* NR_FILE_MAPPED, bytes */
+	__u64 pgfault;		/* PGFAULT, count */
+	__u64 usage_pages;	/* page_counter memory.usage, in PAGES */
+	__u64 max_pages;	/* page_counter memory.max, in PAGES */
+
+	/* Full-mode fold: sum and count of every field the full path read. */
+	__u64 full_sum;
+	__u32 full_fields;
+	__u32 pad;
+};
+
+#endif /* __MEMCG_STAT_READER_H */
diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_stat_reader.c b/tools/testing/selftests/bpf/prog_tests/memcg_stat_reader.c
new file mode 100644
index 000000000000..b1e631b1520a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/memcg_stat_reader.c
@@ -0,0 +1,617 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+
+/*
+ * memcg_stat_reader
+ * =================
+ * Read memory-cgroup statistics for a whole synthetic cgroup subtree TWO ways
+ * and compare them:
+ *
+ *   (A) traditional: open+read+parse memory.stat / memory.current / memory.max
+ *       for every cgroup, in userspace;
+ *   (B) BPF: a single SEC("iter.s/cgroup") program walked over the subtree in
+ *       DESCENDANTS_PRE order, calling the memcg kfuncs per cgroup and stashing
+ *       the results in a hash map keyed by cgroup id, drained once afterwards.
+ *
+ * The test (a) asserts the BPF path agrees with the file path for a checked
+ * field subset (correctness) and (b) reports the wall-clock cost of each path
+ * reading the full ~memory.stat field set, across cgroup trees of increasing
+ * size and load.
+ *
+ * The pass/fail result depends only on the correctness checks; the timing table
+ * is an informational diagnostic captured like any other test output, i.e. shown
+ * only under -v (or when the test fails), never on a normal PASS.
+ */
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include "cgroup_helpers.h"
+#include "memcg_stat_reader.h"
+#include "memcg_stat_reader.skel.h"
+
+#define SUBTREE_ROOT	"/mcg_stat"
+
+#define WARMUP_ITERS	3
+
+struct cg_node {
+	char rel[128];
+	__u64 id;
+	bool is_leaf;
+};
+
+/* Field subset the BPF prog reads matched against memory.stat by hand. */
+struct file_snap {
+	__u64 anon, file, shmem, file_mapped, pgfault;
+	__u64 current;		/* memory.current, bytes */
+	__u64 max;		/* memory.max, bytes (valid unless max_is_max) */
+	__u64 full_sum;
+	__u32 full_fields;
+	bool max_is_max;
+};
+
+struct timing {
+	double avg_us;		/* average per full-tree pass */
+	double ro_avg_us;	/* BPF read()-only average (no map drain); 0 for file */
+	int nodes_seen;		/* entries produced (BPF) */
+	__u32 fields;		/* fields/cgroup touched (informational) */
+};
+
+static volatile __u64 sink;	/* keep the optimizer from eliding reads */
+static long page_size;
+
+static long long now_ns(void)
+{
+	struct timespec t;
+
+	clock_gettime(CLOCK_MONOTONIC, &t);
+	return (long long)t.tv_sec * 1000000000LL + t.tv_nsec;
+}
+
+/* ---- tree construction ------------------------------------------------- */
+
+static struct cg_node *nodes;
+static int n_nodes;
+static int n_leaves;
+
+static int add_node(const char *rel, bool is_leaf, int *keep_fd)
+{
+	int fd;
+
+	fd = create_and_get_cgroup(rel);
+	if (fd < 0)
+		return -1;
+	if (keep_fd)
+		*keep_fd = fd;
+	else
+		close(fd);
+
+	strncpy(nodes[n_nodes].rel, rel, sizeof(nodes[n_nodes].rel) - 1);
+	nodes[n_nodes].rel[sizeof(nodes[n_nodes].rel) - 1] = '\0';
+	nodes[n_nodes].id = get_cgroup_id(rel);
+	nodes[n_nodes].is_leaf = is_leaf;
+	if (is_leaf)
+		n_leaves++;
+	n_nodes++;
+	return 0;
+}
+
+/* Recursively create children of @rel. @rel must already exist and be recorded. */
+static int build_children(const char *rel, int fanout, int depth)
+{
+	/* size 128 should be enough for file path with max depth 3 is the test*/
+	char child[128];
+	int i;
+
+	if (depth == 0)
+		return 0;
+
+	/* Enable memory on this interior node so its children get memory. */
+	if (enable_controllers(rel, "memory"))
+		return -1;
+
+	for (i = 0; i < fanout; i++) {
+		snprintf(child, sizeof(child), "%s/c%d", rel, i);
+		if (add_node(child, depth == 1, NULL))
+			return -1;
+		if (build_children(child, fanout, depth - 1))
+			return -1;
+	}
+	return 0;
+}
+
+static size_t tree_capacity(int fanout, int depth)
+{
+	size_t total = 1, level = 1;
+	int d;
+
+	for (d = 0; d < depth; d++) {
+		level *= fanout;
+		total += level;
+	}
+	return total;
+}
+
+static int build_tree(int fanout, int depth, int *root_fd)
+{
+	n_nodes = 0;
+	n_leaves = 0;
+	nodes = calloc(tree_capacity(fanout, depth), sizeof(*nodes));
+	if (!nodes)
+		return -1;
+
+	/* special handle for the leaf (0 depth) */
+	if (add_node(SUBTREE_ROOT, depth == 0, root_fd))
+		return -1;
+	return build_children(SUBTREE_ROOT, fanout, depth);
+}
+
+/* ---- charging ---------------------------------------------------------- */
+
+/*
+ * A forked child walks the leaves, joining each and faulting in a private anon
+ * region so the charge lands on that leaf, then keeps every region mapped and
+ * blocks.  Interior nodes accumulate the charge hierarchically.  The child is
+ * left stopped (blocked on the control pipe) so the stats are static while the
+ * parent measures.
+ */
+static pid_t charger_pid = -1;
+static int charger_ctrl[2] = { -1, -1 };
+
+static int start_charger(size_t charge_bytes, int charge_fraction)
+{
+	int ready[2];
+	pid_t pid;
+	int i, mod;
+	char c;
+
+	if (!ASSERT_OK(pipe(ready), "pipe ready"))
+		return -1;
+	if (!ASSERT_OK(pipe(charger_ctrl), "pipe ctrl")) {
+		close(ready[0]);
+		close(ready[1]);
+		return -1;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		ASSERT_GE(pid, 0, "fork charger");
+		close(ready[0]);
+		close(ready[1]);
+		close(charger_ctrl[0]);
+		close(charger_ctrl[1]);
+		charger_ctrl[0] = charger_ctrl[1] = -1;
+		return -1;
+	}
+
+	if (pid == 0) {
+		/* child (assert only in the parent so it isn't printed twice) */
+		int leaf_idx = 0;
+
+		close(ready[0]);
+		close(charger_ctrl[1]);
+
+		mod = charge_fraction > 0 ? charge_fraction : 1;
+		for (i = 0; i < n_nodes; i++) {
+			void *p;
+
+			if (!nodes[i].is_leaf)
+				continue;
+			if ((leaf_idx++ % mod) != 0)
+				continue;
+			/*
+			 * cgroup_helpers builds paths from getpid(); in this
+			 * forked child that differs from the parent that built
+			 * the tree, so use the _parent (getppid()) variant to
+			 * resolve the leaf under the parent's work dir.
+			 */
+			if (join_parent_cgroup(nodes[i].rel))
+				_exit(1);
+			p = mmap(NULL, charge_bytes, PROT_READ | PROT_WRITE,
+				 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+			if (p == MAP_FAILED)
+				_exit(2);
+			memset(p, 1, charge_bytes);
+			/* keep p mapped so the charge persists */
+		}
+		/* signal ready, then block until the parent closes the pipe */
+		if (write(ready[1], "x", 1) != 1)
+			_exit(3);
+		while (read(charger_ctrl[0], &c, 1) > 0)
+			;
+		_exit(0);
+	}
+
+	/* parent */
+	charger_pid = pid;
+	close(ready[1]);
+	close(charger_ctrl[0]);
+	charger_ctrl[0] = -1;
+
+	/* wait until the child has charged every leaf */
+	if (!ASSERT_EQ(read(ready[0], &c, 1), 1, "charger ready")) {
+		close(ready[0]);
+		return -1;
+	}
+	close(ready[0]);
+	return 0;
+}
+
+static void stop_charger(void)
+{
+	int status;
+
+	if (charger_ctrl[1] >= 0) {
+		close(charger_ctrl[1]);	/* unblock the child -> it exits */
+		charger_ctrl[1] = -1;
+	}
+	if (charger_pid > 0) {
+		if (waitpid(charger_pid, &status, 0) == charger_pid &&
+		    (!WIFEXITED(status) || WEXITSTATUS(status) != 0))
+			fprintf(stderr,
+				"charger child exited abnormally (status=0x%x)\n",
+				status);
+		charger_pid = -1;
+	}
+}
+
+/* ---- file (traditional) reader ----------------------------------------- */
+
+static void parse_stat(char *buf, struct file_snap *o)
+{
+	char *save, *line;
+
+	for (line = strtok_r(buf, "\n", &save); line;
+	     line = strtok_r(NULL, "\n", &save)) {
+		unsigned long long val;
+		char name[64];
+
+		if (sscanf(line, "%63s %llu", name, &val) != 2)
+			continue;
+		o->full_sum += val;
+		o->full_fields++;
+		if (!strcmp(name, "anon"))
+			o->anon = val;
+		else if (!strcmp(name, "file"))
+			o->file = val;
+		else if (!strcmp(name, "shmem"))
+			o->shmem = val;
+		else if (!strcmp(name, "file_mapped"))
+			o->file_mapped = val;
+		else if (!strcmp(name, "pgfault"))
+			o->pgfault = val;
+	}
+}
+
+static int file_read_node(const char *rel, struct file_snap *o)
+{
+	char buf[8192];
+
+	memset(o, 0, sizeof(*o));
+
+	if (read_cgroup_file(rel, "memory.stat", buf, sizeof(buf)))
+		return -1;
+	parse_stat(buf, o);
+
+	if (!read_cgroup_file(rel, "memory.current", buf, sizeof(buf)))
+		o->current = strtoull(buf, NULL, 10);
+	if (!read_cgroup_file(rel, "memory.max", buf, sizeof(buf))) {
+		if (!strncmp(buf, "max", 3))
+			o->max_is_max = true;
+		else
+			o->max = strtoull(buf, NULL, 10);
+	}
+	return 0;
+}
+
+static void time_file(int iters, struct timing *res)
+{
+	long long total = 0;
+	struct file_snap s;
+	int it, i;
+
+	for (it = 0; it < WARMUP_ITERS; it++)
+		for (i = 0; i < n_nodes; i++)
+			file_read_node(nodes[i].rel, &s);
+
+	for (it = 0; it < iters; it++) {
+		long long t0 = now_ns();
+
+		for (i = 0; i < n_nodes; i++) {
+			file_read_node(nodes[i].rel, &s);
+			sink += s.anon + s.full_sum;
+		}
+		total += now_ns() - t0;
+	}
+	res->avg_us = (double)total / iters / 1000.0;
+	res->fields = s.full_fields;
+}
+
+/* ---- BPF reader -------------------------------------------------------- */
+
+static int bpf_walk_once(struct bpf_link *link)
+{
+	char buf[4096];
+	ssize_t r;
+	int fd;
+
+	fd = bpf_iter_create(bpf_link__fd(link));
+	if (fd < 0)
+		return -1;
+	while ((r = read(fd, buf, sizeof(buf))) > 0)
+		;
+	close(fd);
+	return r == 0 ? 0 : -1;
+}
+
+static int drain_map(int mfd, struct memcg_stat_snapshot *out, int max)
+{
+	__u64 key = 0, next;
+	int n = 0, err;
+
+	err = bpf_map_get_next_key(mfd, NULL, &next);
+	while (err == 0) {
+		if (n < max && !bpf_map_lookup_elem(mfd, &next, &out[n])) {
+			sink += out[n].anon + out[n].full_sum;
+			n++;
+		}
+		key = next;
+		err = bpf_map_get_next_key(mfd, &key, &next);
+	}
+	return n;
+}
+
+static void time_bpf(struct bpf_link *link, struct memcg_stat_reader *skel,
+		     int iters, struct timing *res)
+{
+	struct memcg_stat_snapshot *tmp;
+	long long total = 0, ro_total = 0;
+	int mfd = bpf_map__fd(skel->maps.results);
+	int it, got = 0;
+
+	tmp = calloc(n_nodes + 8, sizeof(*tmp));
+	if (!ASSERT_OK_PTR(tmp, "calloc tmp"))
+		return;
+
+	skel->bss->collect_full = 1;
+
+	for (it = 0; it < WARMUP_ITERS; it++) {
+		bpf_walk_once(link);
+		drain_map(mfd, tmp, n_nodes + 8);
+	}
+
+	for (it = 0; it < iters; it++) {
+		long long t0, t1, t2;
+
+		t0 = now_ns();
+		bpf_walk_once(link);
+		t1 = now_ns();
+		got = drain_map(mfd, tmp, n_nodes + 8);
+		t2 = now_ns();
+
+		total += t2 - t0;
+		ro_total += t1 - t0;
+	}
+
+	res->avg_us = (double)total / iters / 1000.0;
+	res->ro_avg_us = (double)ro_total / iters / 1000.0;
+	res->nodes_seen = got;
+	res->fields = tmp[0].full_fields;
+	free(tmp);
+}
+
+/* ---- correctness ------------------------------------------------------- */
+
+static void check_correctness(struct bpf_link *link,
+			      struct memcg_stat_reader *skel)
+{
+	int mfd = bpf_map__fd(skel->maps.results);
+	__u64 total_anon = 0, worst_cur_drift = 0;
+	__u64 anon_tol = 4 * page_size;
+	int i, anon_mism = 0, missing = 0;
+
+	skel->bss->collect_full = 0;
+	if (!ASSERT_OK(bpf_walk_once(link), "bpf walk"))
+		return;
+
+	for (i = 0; i < n_nodes; i++) {
+		struct memcg_stat_snapshot b;
+		__u64 cur, drift;
+		struct file_snap f;
+
+		if (bpf_map_lookup_elem(mfd, &nodes[i].id, &b)) {
+			missing++;
+			continue;
+		}
+		if (file_read_node(nodes[i].rel, &f)) {
+			missing++;
+			continue;
+		}
+		total_anon += b.anon;
+
+		/*
+		 * anon (NR_ANON_MAPPED) is rstat-flushed and, with the charger
+		 * stopped, deterministic: BPF and memory.stat must agree.  The
+		 * tolerance is far tighter than a units error (bytes vs pages
+		 * differ by PAGE_SIZE), so a wrong-unit/wrong-field bug trips it.
+		 */
+		if ((b.anon > f.anon ? b.anon - f.anon : f.anon - b.anon) > anon_tol) {
+			anon_mism++;
+			if (anon_mism <= 5)
+				fprintf(stderr,
+					"anon mismatch %s: bpf=%llu file=%llu\n",
+					nodes[i].rel, b.anon, f.anon);
+		}
+
+		/*
+		 * memory.current is the LIVE page_counter.  Both sides read the
+		 * same counter, but the BPF values are captured in one fast walk
+		 * while the files are read across the whole (much longer) loop,
+		 * so any difference is time skew on a moving counter, not a BPF
+		 * bug -- track it as informational only.
+		 */
+		cur = b.usage_pages * page_size;
+		drift = cur > f.current ? cur - f.current : f.current - cur;
+		if (drift > worst_cur_drift)
+			worst_cur_drift = drift;
+	}
+
+	ASSERT_EQ(missing, 0, "all cgroups present in map");
+	ASSERT_EQ(anon_mism, 0, "bpf vs file anon (rstat-flushed)");
+	ASSERT_GT(total_anon, 0, "tree charged some anon");
+	printf("max memory.current drift bpf-vs-file: %llu bytes (live counter, read across the walk window)\n",
+	       worst_cur_drift);
+}
+
+/* ---- one case ---------------------------------------------------------- */
+
+struct testcase {
+	const char *name;
+	int fanout;
+	int depth;
+	size_t charge_bytes;
+	int charge_fraction;	/* charge every Nth leaf; 1 = all */
+	int iters;
+};
+
+static void run_case(const struct testcase *tc)
+{
+	struct timing f = {}, b = {};
+	struct memcg_stat_reader *skel = NULL;
+	struct bpf_link *link = NULL;
+	int root_fd = -1;
+	int charged;
+
+	if (!ASSERT_OK(build_tree(tc->fanout, tc->depth, &root_fd), "build tree"))
+		goto out;
+
+	if (start_charger(tc->charge_bytes, tc->charge_fraction))
+		goto out;
+
+	skel = memcg_stat_reader__open();
+	if (!ASSERT_OK_PTR(skel, "skel open"))
+		goto out;
+	if (!ASSERT_OK(bpf_map__set_max_entries(skel->maps.results, n_nodes + 8),
+		       "set max_entries"))
+		goto out;
+	if (!ASSERT_OK(memcg_stat_reader__load(skel), "skel load"))
+		goto out;
+
+	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
+	union bpf_iter_link_info linfo = {};
+
+	linfo.cgroup.cgroup_fd = root_fd;
+	linfo.cgroup.order = BPF_CGROUP_ITER_DESCENDANTS_PRE;
+	opts.link_info = &linfo;
+	opts.link_info_len = sizeof(linfo);
+
+	link = bpf_program__attach_iter(skel->progs.cgroup_memcg_stat_reader,
+					&opts);
+	if (!ASSERT_OK_PTR(link, "attach iter"))
+		goto out;
+
+	check_correctness(link, skel);
+
+	time_file(tc->iters, &f);
+	time_bpf(link, skel, tc->iters, &b);
+
+	charged = tc->charge_fraction > 0 ?
+		  (n_leaves + tc->charge_fraction - 1) / tc->charge_fraction :
+		  n_leaves;
+
+	/*
+	 * Informational timing diagnostic: captured like any test output, so it
+	 * is shown under -v or on failure but not on a normal PASS.  The pass/fail
+	 * verdict is decided solely by the correctness checks, never by these
+	 * numbers.
+	 */
+	printf("\n==== memcg_stat_reader: %s ====\n", tc->name);
+	printf("tree: nodes=%d leaves=%d charged_leaves=%d fanout=%d depth=%d charge=%zuKB/leaf iters=%d\n",
+	       n_nodes, n_leaves, charged, tc->fanout, tc->depth,
+	       tc->charge_bytes >> 10, tc->iters);
+	printf("all times in us (average per full-tree pass, full memory.stat field set); ro = bpf read()-only (no map drain)\n");
+	printf("file_avg=%.1f  bpf_avg=%.1f  bpf_ro=%.1f  speedup(file/bpf)=%.2fx\n",
+	       f.avg_us, b.avg_us, b.ro_avg_us,
+	       b.avg_us > 0 ? f.avg_us / b.avg_us : 0.0);
+	printf("per-cgroup: file avg=%.0f ns  bpf avg=%.0f ns\n",
+	       f.avg_us * 1000.0 / n_nodes, b.avg_us * 1000.0 / n_nodes);
+	printf("fields/cgroup: bpf=%u | file stat lines=%u\n", b.fields, f.fields);
+	printf("bpf entries produced: %d (expected %d)\n", b.nodes_seen, n_nodes);
+
+	ASSERT_EQ(b.nodes_seen, n_nodes, "bpf visited whole subtree");
+
+out:
+	bpf_link__destroy(link);
+	memcg_stat_reader__destroy(skel);
+	if (root_fd >= 0)
+		close(root_fd);
+	stop_charger();		/* reap charger so leaves become empty */
+
+	/*
+	 * Remove the subtree in reverse creation order.  Nodes are recorded in
+	 * DFS pre-order (a parent precedes all its descendants), so iterating
+	 * backwards removes every child before its parent.
+	 */
+	if (nodes) {
+		int i;
+
+		for (i = n_nodes - 1; i >= 0; i--)
+			remove_cgroup(nodes[i].rel);
+		free(nodes);
+		nodes = NULL;
+	}
+}
+
+static const struct testcase cases[] = {
+	{ "small",       4, 2, 256 << 10, 1,  200 },
+	{ "medium",     10, 2, 256 << 10, 1,   50 },
+	{ "large",      10, 3, 256 << 10, 1,   10 },
+	{ "large_sparse", 10, 3, 256 << 10, 8, 10 },
+};
+
+/*
+ * The memcg kfuncs the BPF program relies on (bpf_get_mem_cgroup et al.) are
+ * built only with CONFIG_MEMCG (mm/bpf_memcontrol.c).  On a kernel without it
+ * they are absent from vmlinux BTF and the program fails to load, so probe for
+ * one of them and skip cleanly rather than reporting a spurious failure.
+ */
+static bool memcg_kfuncs_available(void)
+{
+	struct btf *btf;
+	bool ok;
+
+	btf = btf__load_vmlinux_btf();
+	if (!btf)
+		return false;
+	ok = btf__find_by_name_kind(btf, "bpf_get_mem_cgroup", BTF_KIND_FUNC) > 0;
+	btf__free(btf);
+	return ok;
+}
+
+void test_memcg_stat_reader(void)
+{
+	int i;
+
+	if (!memcg_kfuncs_available()) {
+		test__skip();
+		return;
+	}
+
+	page_size = sysconf(_SC_PAGESIZE);
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup cgroup env"))
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		if (!test__start_subtest(cases[i].name))
+			continue;
+		run_case(&cases[i]);
+	}
+
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/memcg_stat_reader.c b/tools/testing/selftests/bpf/progs/memcg_stat_reader.c
new file mode 100644
index 000000000000..a2c1b1b48364
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/memcg_stat_reader.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "memcg_stat_reader.h"
+
+char _license[] SEC("license") = "GPL";
+
+/*
+ * Flipped by userspace between timed runs (a plain .bss global, writable at
+ * runtime through the skeleton mmap):
+ *   0 - collect only the matched subset (a handful of kfunc calls)
+ *   1 - additionally fold in the full memory.stat field set (many kfunc calls)
+ */
+int collect_full;
+
+/*
+ * Per-cgroup results, keyed by cgroup id.  The BPF-side id (cgrp->kn->id)
+ * equals the userspace get_cgroup_id() value, so the test can correlate map
+ * entries back to the cgroups it created.  max_entries is resized by userspace
+ * (bpf_map__set_max_entries) to the size of the subtree before load.
+ */
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, __u64);
+	__type(value, struct memcg_stat_snapshot);
+} results SEC(".maps");
+
+/*
+ * Accumulate one page-state / vm-event read.  Each enumerator is guarded by
+ * bpf_core_enum_value_exists(): the full field set below spans counters that are
+ * config- or version-gated (e.g. NR_SECONDARY_PAGETABLE, PGDEMOTE_KHUGEPAGED,
+ * MEMCG_PERCPU_B), so on a kernel whose BTF lacks one, the bpf_core_enum_value()
+ * relocation would otherwise poison the instruction and fail the *entire*
+ * program load.  With the _exists guard the missing enumerator relocates to a
+ * compile-time-false branch that the verifier drops as dead code, so the fold is
+ * simply skipped and the rest of the program (including the matched/correctness
+ * path) still loads.
+ */
+#define FOLD_PS(ENUM, NAME) do {						\
+	if (bpf_core_enum_value_exists(enum ENUM, NAME)) {			\
+		__u64 __v = bpf_mem_cgroup_page_state(memcg,			\
+				bpf_core_enum_value(enum ENUM, NAME));		\
+		if (__v != (__u64)-1) {						\
+			sum += __v;						\
+			nr++;							\
+		}								\
+	}									\
+} while (0)
+
+#define FOLD_EV(NAME) do {							\
+	if (bpf_core_enum_value_exists(enum vm_event_item, NAME)) {		\
+		__u64 __v = bpf_mem_cgroup_vm_events(memcg,			\
+				bpf_core_enum_value(enum vm_event_item, NAME));	\
+		if (__v != (__u64)-1) {						\
+			sum += __v;						\
+			nr++;						\
+		}							\
+	}								\
+} while (0)
+
+/*
+ * Read a broad memory.stat field set so the timed "full" run pays the realistic
+ * per-field kfunc cost.  Enumerators absent from the running kernel's BTF are
+ * skipped (see the _exists guard in FOLD_PS/FOLD_EV), so this stays loadable
+ * across kernel configs/versions.  __always_inline so the acquired memcg
+ * reference stays in the main frame (no cross-subprog reference tracking); the
+ * runtime collect_full branch keeps it off the matched path.
+ */
+static __always_inline void collect_full_stats(struct mem_cgroup *memcg,
+					       struct memcg_stat_snapshot *snap)
+{
+	__u64 sum = 0;
+	__u32 nr = 0;
+
+	/* node_stat_item: size + event counters that memory.stat prints */
+	FOLD_PS(node_stat_item, NR_ANON_MAPPED);
+	FOLD_PS(node_stat_item, NR_FILE_PAGES);
+	FOLD_PS(node_stat_item, NR_FILE_MAPPED);
+	FOLD_PS(node_stat_item, NR_FILE_DIRTY);
+	FOLD_PS(node_stat_item, NR_WRITEBACK);
+	FOLD_PS(node_stat_item, NR_SHMEM);
+	FOLD_PS(node_stat_item, NR_INACTIVE_ANON);
+	FOLD_PS(node_stat_item, NR_ACTIVE_ANON);
+	FOLD_PS(node_stat_item, NR_INACTIVE_FILE);
+	FOLD_PS(node_stat_item, NR_ACTIVE_FILE);
+	FOLD_PS(node_stat_item, NR_UNEVICTABLE);
+	FOLD_PS(node_stat_item, NR_SLAB_RECLAIMABLE_B);
+	FOLD_PS(node_stat_item, NR_SLAB_UNRECLAIMABLE_B);
+	FOLD_PS(node_stat_item, NR_KERNEL_STACK_KB);
+	FOLD_PS(node_stat_item, NR_PAGETABLE);
+	FOLD_PS(node_stat_item, NR_SECONDARY_PAGETABLE);
+	FOLD_PS(node_stat_item, NR_VMALLOC);
+	FOLD_PS(node_stat_item, WORKINGSET_REFAULT_ANON);
+	FOLD_PS(node_stat_item, WORKINGSET_REFAULT_FILE);
+	FOLD_PS(node_stat_item, WORKINGSET_ACTIVATE_ANON);
+	FOLD_PS(node_stat_item, WORKINGSET_ACTIVATE_FILE);
+	FOLD_PS(node_stat_item, WORKINGSET_RESTORE_ANON);
+	FOLD_PS(node_stat_item, WORKINGSET_RESTORE_FILE);
+	FOLD_PS(node_stat_item, WORKINGSET_NODERECLAIM);
+	FOLD_PS(node_stat_item, PGDEMOTE_KSWAPD);
+	FOLD_PS(node_stat_item, PGDEMOTE_DIRECT);
+	FOLD_PS(node_stat_item, PGDEMOTE_KHUGEPAGED);
+	FOLD_PS(node_stat_item, PGSTEAL_KSWAPD);
+	FOLD_PS(node_stat_item, PGSTEAL_DIRECT);
+	FOLD_PS(node_stat_item, PGSTEAL_KHUGEPAGED);
+	FOLD_PS(node_stat_item, PGSCAN_KSWAPD);
+	FOLD_PS(node_stat_item, PGSCAN_DIRECT);
+	FOLD_PS(node_stat_item, PGSCAN_KHUGEPAGED);
+	FOLD_PS(node_stat_item, PGREFILL);
+
+	/* memcg_stat_item: numbered past NR_VM_NODE_STAT_ITEMS */
+	FOLD_PS(memcg_stat_item, MEMCG_KMEM);
+	FOLD_PS(memcg_stat_item, MEMCG_SOCK);
+	FOLD_PS(memcg_stat_item, MEMCG_PERCPU_B);
+
+	/* vm_event_item: the raw-count tail of memory.stat */
+	FOLD_EV(PGFAULT);
+	FOLD_EV(PGMAJFAULT);
+	FOLD_EV(PGACTIVATE);
+	FOLD_EV(PGDEACTIVATE);
+	FOLD_EV(PGLAZYFREE);
+	FOLD_EV(PGLAZYFREED);
+
+	snap->full_sum = sum;
+	snap->full_fields = nr;
+}
+
+SEC("iter.s/cgroup")
+int cgroup_memcg_stat_reader(struct bpf_iter__cgroup *ctx)
+{
+	struct cgroup *cgrp = ctx->cgroup;
+	struct memcg_stat_snapshot snap = {};
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *memcg;
+	__u64 cg_id;
+
+	/*
+	 * DESCENDANTS_PRE ends with a terminal element where cgroup == NULL.
+	 * Return 0 (not 1) so the walk runs to completion.
+	 */
+	if (!cgrp)
+		return 0;
+
+	css = &cgrp->self;
+	memcg = bpf_get_mem_cgroup(css);
+	if (!memcg)
+		return 0;
+
+	/* Bring this memcg's rstat up to date before reading it. */
+	bpf_mem_cgroup_flush_stats(memcg);
+
+	cg_id = BPF_CORE_READ(cgrp, kn, id);
+	snap.cgroup_id = cg_id;
+
+	/* Matched subset: always collected so correctness holds in both modes. */
+	snap.anon = bpf_mem_cgroup_page_state(memcg,
+			bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED));
+	snap.file = bpf_mem_cgroup_page_state(memcg,
+			bpf_core_enum_value(enum node_stat_item, NR_FILE_PAGES));
+	snap.shmem = bpf_mem_cgroup_page_state(memcg,
+			bpf_core_enum_value(enum node_stat_item, NR_SHMEM));
+	snap.file_mapped = bpf_mem_cgroup_page_state(memcg,
+			bpf_core_enum_value(enum node_stat_item, NR_FILE_MAPPED));
+	snap.pgfault = bpf_mem_cgroup_vm_events(memcg,
+			bpf_core_enum_value(enum vm_event_item, PGFAULT));
+
+	/* page_counter fields need no kfunc; read them off the trusted ptr. */
+	snap.usage_pages = BPF_CORE_READ(memcg, memory.usage.counter);
+	snap.max_pages = BPF_CORE_READ(memcg, memory.max);
+
+	if (collect_full)
+		collect_full_stats(memcg, &snap);
+
+	bpf_map_update_elem(&results, &cg_id, &snap, BPF_ANY);
+
+	bpf_put_mem_cgroup(memcg);
+	return 0;
+}
-- 
2.53.0-Meta


