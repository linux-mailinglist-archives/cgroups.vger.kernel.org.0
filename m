Return-Path: <cgroups+bounces-10818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CF4BE17D1
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 07:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57681403D28
	for <lists+cgroups@lfdr.de>; Thu, 16 Oct 2025 05:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD9122129B;
	Thu, 16 Oct 2025 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z2FspIzq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB8222128D
	for <cgroups@vger.kernel.org>; Thu, 16 Oct 2025 05:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760591105; cv=none; b=mhF7LRoRMyPekQ0mAlpdsgtH30tfylUTWoohkHYPkAilI5B6Ua/3pupZ9x5UlEc2glEC8jXMXBpMx+kbL1PXBi0UTYjXPKjxlPJjIeT2Wmp/dL1A2r44gGsIQAIz6KJqN10QEAKnHOewP3+gTRmNEpvxdSnnfZ1Vz+sqeAAyWGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760591105; c=relaxed/simple;
	bh=hXfHwgx63g8mOz/ZQIW+HqCSPSHXfmbbzlHqL88X+i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJlsT2WSBLif0h98W0Eq4+SzfT9ofXEjaDAmA8utwBFvblB0TZlYbAIxPUl7kQpvj6w1VVpEcSI/7ytUlcd2zAAqukjBbqlKZIBJXDTf/WmcPGlSvLABFHc/QfACRiV3zSLQxew6efJnF9uRtJLI3Ni1DrB//iHyS/iwqTclER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z2FspIzq; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f1558b5d-41be-4f56-8428-d5ae63d696ea@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760591087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZ0OhGBCw/TeJ0eEkVC8lEwB+tMQoRHyfhkQ+NORWwo=;
	b=Z2FspIzqtUWauRrDfma+tzAHRHBnmlCfIoUNmBooTf88BAd1opzFWm6xkdDEN+MAKuWKUn
	RCOHF6ctPYUtuQwk1qbiFOFliQxafWzmZuod5Lrscl9XX6uzkErzxea1FmNjQtNtYzix18
	ijoQcslSoA3/Z1rYR67YnHmRcPbOO34=
Date: Wed, 15 Oct 2025 22:04:36 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] memcg: selftests for memcg stat kfuncs
Content-Language: en-GB
To: JP Kobryn <inwardvessel@gmail.com>, shakeel.butt@linux.dev,
 andrii@kernel.org, ast@kernel.org, mkoutny@suse.com, yosryahmed@google.com,
 hannes@cmpxchg.org, tj@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, kernel-team@meta.com
References: <20251015190813.80163-1-inwardvessel@gmail.com>
 <20251015190813.80163-3-inwardvessel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20251015190813.80163-3-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/15/25 12:08 PM, JP Kobryn wrote:
> Add test coverage for the kfuncs that fetch memcg stats. Using some common
> stats, test before and after scenarios ensuring that the given stat
> increases by some arbitrary amount. The stats selected cover the three
> categories represented by the enums: node_stat_item, memcg_stat_item,
> vm_event_item.
>
> Since only a subset of all stats are queried, use a static struct made up
> of fields for each stat. Write to the struct with the fetched values when
> the bpf program is invoked and read the fields in the user mode program for
> verification.
>
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>   .../testing/selftests/bpf/cgroup_iter_memcg.h |  18 ++
>   .../bpf/prog_tests/cgroup_iter_memcg.c        | 295 ++++++++++++++++++
>   .../selftests/bpf/progs/cgroup_iter_memcg.c   |  61 ++++
>   3 files changed, 374 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/cgroup_iter_memcg.h
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
>   create mode 100644 tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
>
> diff --git a/tools/testing/selftests/bpf/cgroup_iter_memcg.h b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
> new file mode 100644
> index 000000000000..5f4c6502d9f1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/cgroup_iter_memcg.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#ifndef __CGROUP_ITER_MEMCG_H
> +#define __CGROUP_ITER_MEMCG_H
> +
> +struct memcg_query {
> +	/* some node_stat_item's */
> +	long nr_anon_mapped;
> +	long nr_shmem;
> +	long nr_file_pages;
> +	long nr_file_mapped;
> +	/* some memcg_stat_item */
> +	long memcg_kmem;
> +	/* some vm_event_item */
> +	long pgfault;
> +};
> +
> +#endif /* __CGROUP_ITER_MEMCG_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> new file mode 100644
> index 000000000000..264dc3c9ec30
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +#include <bpf/libbpf.h>
> +#include <bpf/btf.h>
> +#include <fcntl.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +#include "cgroup_helpers.h"
> +#include "cgroup_iter_memcg.h"
> +#include "cgroup_iter_memcg.skel.h"
> +
> +int read_stats(struct bpf_link *link)

static int read_stats(...)

> +{
> +	int fd, ret = 0;
> +	ssize_t bytes;
> +
> +	fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_OK_FD(fd, "bpf_iter_create"))
> +		return 1;
> +
> +	/*
> +	 * Invoke iter program by reading from its fd. We're not expecting any
> +	 * data to be written by the bpf program so the result should be zero.
> +	 * Results will be read directly through the custom data section
> +	 * accessible through skel->data_query.memcg_query.
> +	 */
> +	bytes = read(fd, NULL, 0);
> +	if (!ASSERT_EQ(bytes, 0, "read fd"))
> +		ret = 1;
> +
> +	close(fd);
> +	return ret;
> +}
> +
> +static void test_anon(struct bpf_link *link,
> +		struct memcg_query *memcg_query)

Alignment between arguments? Actually two arguments can be in the same line.

> +{
> +	void *map;
> +	size_t len;
> +	long val;
> +
> +	len = sysconf(_SC_PAGESIZE) * 1024;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		return;
> +
> +	val = memcg_query->nr_anon_mapped;
> +	if (!ASSERT_GE(val, 0, "initial anon mapped val"))
> +		return;
> +
> +	/*
> +	 * Increase memcg anon usage by mapping and writing
> +	 * to a new anon region.
> +	 */
> +	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

All arguments can be in the same line.

> +	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap anon"))
> +		return;
> +
> +	memset(map, 1, len);
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		goto cleanup;
> +
> +	ASSERT_GT(memcg_query->nr_anon_mapped, val, "final anon mapped val");
> +
> +cleanup:
> +	munmap(map, len);
> +}
> +
> +static void test_file(struct bpf_link *link,
> +		struct memcg_query *memcg_query)

Arguments can be in the same line. Some other examples below.

> +{
> +	void *map;
> +	size_t len;
> +	long val_pages, val_mapped;
> +	FILE *f;
> +	int fd;
> +
> +	len = sysconf(_SC_PAGESIZE) * 1024;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		return;
> +
> +	val_pages = memcg_query->nr_file_pages;
> +	if (!ASSERT_GE(val_pages, 0, "initial file val"))
> +		return;
> +	val_mapped = memcg_query->nr_file_mapped;
> +	if (!ASSERT_GE(val_mapped, 0, "initial file mapped val"))
> +		return;
> +
> +	/*
> +	 * Increase memcg file usage by creating and writing
> +	 * to a temoprary mapped file.
> +	 */
> +	f = tmpfile();
> +	if (!ASSERT_OK_PTR(f, "tmpfile"))
> +		return;
> +	fd = fileno(f);
> +	if (!ASSERT_OK_FD(fd, "open fd"))
> +		return;
> +	if (!ASSERT_OK(ftruncate(fd, len), "ftruncate"))
> +		goto cleanup_fd;
> +
> +	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +			MAP_SHARED, fd, 0);

ditto.

> +	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap file"))
> +		goto cleanup_fd;
> +
> +	memset(map, 1, len);
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		goto cleanup_map;
> +
> +	ASSERT_GT(memcg_query->nr_file_pages, val_pages, "final file value");
> +	ASSERT_GT(memcg_query->nr_file_mapped, val_mapped,
> +			"final file mapped value");

ditto.

> +
> +cleanup_map:
> +	munmap(map, len);
> +cleanup_fd:
> +	close(fd);
> +}
> +
> +static void test_shmem(struct bpf_link *link,
> +		struct memcg_query *memcg_query)

ditto.

> +{
> +	size_t len;
> +	int fd;
> +	void *map;
> +	long val;
> +
> +	len = sysconf(_SC_PAGESIZE) * 1024;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		return;
> +
> +	val = memcg_query->nr_shmem;
> +	if (!ASSERT_GE(val, 0, "init shmem val"))
> +		return;
> +
> +	/*
> +	 * Increase memcg shmem usage by creating and writing
> +	 * to a shmem object.
> +	 */
> +	fd = shm_open("/tmp_shmem", O_CREAT | O_RDWR, 0644);
> +	if (!ASSERT_OK_FD(fd, "shm_open"))
> +		return;
> +
> +	if (!ASSERT_OK(ftruncate(fd, len), "ftruncate"))
> +		goto cleanup_fd;
> +
> +	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +			MAP_SHARED, fd, 0);

ditto.

> +	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap shmem"))
> +		goto cleanup_fd;
> +
> +	memset(map, 1, len);
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		goto cleanup_map;
> +
> +	ASSERT_GT(memcg_query->nr_shmem, val, "final shmem value");
> +
> +cleanup_map:
> +	munmap(map, len);
> +cleanup_fd:
> +	close(fd);
> +	shm_unlink("/tmp_shmem");
> +}
> +
> +static void test_kmem(struct bpf_link *link,
> +		struct memcg_query *memcg_query)

ditto.

> +{
> +	int fds[2];
> +	int err;
> +	ssize_t bytes;
> +	size_t len;
> +	char *buf;
> +	long val;
> +
> +	len = sysconf(_SC_PAGESIZE) * 1024;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		return;
> +
> +	val = memcg_query->memcg_kmem;
> +	if (!ASSERT_GE(val, 0, "initial kmem val"))
> +		return;
> +
> +	err = pipe2(fds, O_NONBLOCK);
> +	if (!ASSERT_OK(err, "pipe"))
> +		return;
> +
> +	buf = malloc(len);

buf could be NULL?

> +	memset(buf, 1, len);
> +	bytes = write(fds[1], buf, len);
> +	if (!ASSERT_GT(bytes, 0, "write"))
> +		goto cleanup;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		goto cleanup;
> +
> +	ASSERT_GT(memcg_query->memcg_kmem, val, "kmem value");
> +
> +cleanup:
> +	free(buf);
> +	close(fds[0]);
> +	close(fds[1]);
> +}
> +
> +static void test_pgfault(struct bpf_link *link,
> +		struct memcg_query *memcg_query)

ditto.

> +{
> +	void *map;
> +	size_t len;
> +	long val;
> +
> +	len = sysconf(_SC_PAGESIZE) * 1024;
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		return;
> +
> +	val = memcg_query->pgfault;
> +	if (!ASSERT_GE(val, 0, "initial pgfault val"))
> +		return;
> +
> +	/* Create region to use for triggering a page fault. */
> +	map = mmap(NULL, len, PROT_READ | PROT_WRITE,
> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> +	if (!ASSERT_NEQ(map, MAP_FAILED, "mmap anon"))
> +		return;
> +
> +	/* Trigger page fault. */
> +	memset(map, 1, len);
> +
> +	if (!ASSERT_OK(read_stats(link), "read stats"))
> +		goto cleanup;
> +
> +	ASSERT_GT(memcg_query->pgfault, val, "final pgfault val");
> +
> +cleanup:
> +	munmap(map, len);
> +}
> +
> +void test_cgroup_iter_memcg(void)
> +{
> +	char *cgroup_rel_path = "/cgroup_iter_memcg_test";
> +	struct cgroup_iter_memcg *skel;
> +	struct bpf_link *link;
> +	int cgroup_fd, err;
> +
> +	cgroup_fd = cgroup_setup_and_join(cgroup_rel_path);
> +	if (!ASSERT_OK_FD(cgroup_fd, "cgroup_setup_and_join"))
> +		return;
> +
> +	skel = cgroup_iter_memcg__open();
> +	if (!ASSERT_OK_PTR(skel, "cgroup_iter_memcg__open"))
> +		goto cleanup_cgroup_fd;
> +
> +	err = cgroup_iter_memcg__load(skel);
> +	if (!ASSERT_OK(err, "cgroup_iter_memcg__load"))
> +		goto cleanup_skel;

The above two can be combined with cgroup_iter_memcg__open_and_load().

> +
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo = {
> +		.cgroup.cgroup_fd = cgroup_fd,
> +		.cgroup.order = BPF_CGROUP_ITER_SELF_ONLY,
> +	};
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	link = bpf_program__attach_iter(skel->progs.cgroup_memcg_query, &opts);
> +	if (!ASSERT_OK_PTR(link, "bpf_program__attach_iter"))
> +		goto cleanup_cgroup_fd;

goto cleanup_skel;

> +
> +	if (test__start_subtest("cgroup_iter_memcg__anon"))
> +		test_anon(link, &skel->data_query->memcg_query);
> +	if (test__start_subtest("cgroup_iter_memcg__shmem"))
> +		test_shmem(link, &skel->data_query->memcg_query);
> +	if (test__start_subtest("cgroup_iter_memcg__file"))
> +		test_file(link, &skel->data_query->memcg_query);
> +	if (test__start_subtest("cgroup_iter_memcg__kmem"))
> +		test_kmem(link, &skel->data_query->memcg_query);
> +	if (test__start_subtest("cgroup_iter_memcg__pgfault"))
> +		test_pgfault(link, &skel->data_query->memcg_query);
> +
> +	bpf_link__destroy(link);
> +cleanup_skel:
> +	cgroup_iter_memcg__destroy(skel);
> +cleanup_cgroup_fd:
> +	close(cgroup_fd);
> +	cleanup_cgroup_environment();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> new file mode 100644
> index 000000000000..0d913d72b68d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
> +#include <vmlinux.h>
> +#include <bpf/bpf_core_read.h>
> +#include "cgroup_iter_memcg.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +extern void memcg_flush_stats(struct cgroup *cgrp) __ksym;
> +extern unsigned long memcg_stat_fetch(struct cgroup *cgrp,
> +		enum memcg_stat_item item) __ksym;
> +extern unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
> +		enum node_stat_item item) __ksym;
> +extern unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
> +		enum vm_event_item item) __ksym;

The above four extern functions are not needed. They should be included
in vmlinux.h if the latest pahole version (1.30) is used.

> +
> +/* The latest values read are stored here. */
> +struct memcg_query memcg_query SEC(".data.query");
> +
> +/*
> + * Helpers for fetching any of the three different types of memcg stats.
> + * BPF core macros are used to ensure an enumerator is present in the given
> + * kernel. Falling back on -1 indicates its absence.
> + */
> +#define node_stat_fetch_if_exists(cgrp, item) \
> +	bpf_core_enum_value_exists(enum node_stat_item, item) ? \
> +		memcg_node_stat_fetch((cgrp), bpf_core_enum_value( \
> +					 enum node_stat_item, item)) : -1
> +
> +#define memcg_stat_fetch_if_exists(cgrp, item) \
> +	bpf_core_enum_value_exists(enum memcg_stat_item, item) ? \
> +		memcg_node_stat_fetch((cgrp), bpf_core_enum_value( \
> +					 enum memcg_stat_item, item)) : -1
> +
> +#define vm_event_fetch_if_exists(cgrp, item) \
> +	bpf_core_enum_value_exists(enum vm_event_item, item) ? \
> +		memcg_vm_event_fetch((cgrp), bpf_core_enum_value( \
> +					 enum vm_event_item, item)) : -1
> +
> +SEC("iter.s/cgroup")
> +int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
> +{
> +	struct cgroup *cgrp = ctx->cgroup;
> +
> +	if (!cgrp)
> +		return 1;
> +
> +	memcg_flush_stats(cgrp);
> +
> +	memcg_query.nr_anon_mapped = node_stat_fetch_if_exists(cgrp,
> +			NR_ANON_MAPPED);
> +	memcg_query.nr_shmem = node_stat_fetch_if_exists(cgrp, NR_SHMEM);
> +	memcg_query.nr_file_pages = node_stat_fetch_if_exists(cgrp,
> +			NR_FILE_PAGES);
> +	memcg_query.nr_file_mapped = node_stat_fetch_if_exists(cgrp,
> +			NR_FILE_MAPPED);
> +	memcg_query.memcg_kmem = memcg_stat_fetch_if_exists(cgrp, MEMCG_KMEM);
> +	memcg_query.pgfault = vm_event_fetch_if_exists(cgrp, PGFAULT);

There is a type mismatch:

+struct memcg_query {
+	/* some node_stat_item's */
+	long nr_anon_mapped;
+	long nr_shmem;
+	long nr_file_pages;
+	long nr_file_mapped;
+	/* some memcg_stat_item */
+	long memcg_kmem;
+	/* some vm_event_item */
+	long pgfault;
+};

memcg_query.nr_anon_mapped is long, but node_stat_fetch_if_exists
(...) return value type is unsigned long. It would be good if two
types are the same.

> +
> +	return 0;
> +}


