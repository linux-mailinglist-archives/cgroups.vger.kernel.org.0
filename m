Return-Path: <cgroups+bounces-13764-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAajF+qWhmlWPAQAu9opvQ
	(envelope-from <cgroups+bounces-13764-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 02:35:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022C10488F
	for <lists+cgroups@lfdr.de>; Sat, 07 Feb 2026 02:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32F04301078E
	for <lists+cgroups@lfdr.de>; Sat,  7 Feb 2026 01:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1A4315D37;
	Sat,  7 Feb 2026 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOBVLw19"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A250314D0F;
	Sat,  7 Feb 2026 01:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770428132; cv=none; b=HCgYiAVJUqz/5LDTAV2dabBeY+RD+0/Uvh8XHoZ4Gh9VyokA4hDkWC0SSTjgOcIsCXkwONZ27cz9Jo6+nwKLOEX4pjQXIOYUJ+hNu/7+vVOgGMZeOQuFVsWOcF4DE41YlmGD1sGpkcdSgiUs7wbSA9Vc1wxsXJw61GXYTRhlruc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770428132; c=relaxed/simple;
	bh=UQZjrgT2+C5sGvrewfIsj+BiY95FtrloV3QjcSk1pj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adEOSKRy6lJfBuTFbuVepDnX+NL/4NOVo8RU8DJRechV9n5WajUIWzrbOAk19grQzhdKhpZ5nbF3mD2uiQAgAC7RF86i6lYhWfkSvhY7gvIb48W5Bc19LQVw9v3SDskKUK+rWA0Fi6+0w/oDcg99cSzODKV+I62AaAnmtog8eoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOBVLw19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB27CC116C6;
	Sat,  7 Feb 2026 01:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770428132;
	bh=UQZjrgT2+C5sGvrewfIsj+BiY95FtrloV3QjcSk1pj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hOBVLw19hzyNdvsmQFl6r4uIKKUUC1+sKGnWq80YxOP0V9mrY7/cfavno86LKYHvC
	 o2u/2IvPeLCTwpr1u69Gd2OZgXkYL42bXtGUrDIwhqd3UOwtWE0mB7m5cl52QAK6R8
	 xMCsnFfJ+YDVX/JfqVs0QW+mix1NbuE4CaB1U1CcoAZ1MgJSK+lbqP4bezSjfJ4/26
	 W3lx+jo1IkzWOnMHhIJcmYqTlxA7wUQM41TlV1ykOEz+Xq4xVAlzkC6jiK5HhwK6cE
	 5QnJQSd6q6cEsYsLPl2jtGtCxxqtmDQUmn2NOXUSII1asL/H0uqKNJdVEwSYAC10wO
	 oVXHqRg9SbsZQ==
From: SeongJae Park <sj@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	linux-mm@kvack.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 2/2] selftests/cgroup: add test for zswap incompressible pages
Date: Fri,  6 Feb 2026 17:35:28 -0800
Message-ID: <20260207013529.69681-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206072220.144008-3-jiayuan.chen@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,shopee.com,cmpxchg.org,suse.com,lwn.net,linux.dev,linux-foundation.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13764-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,shopee.com:email]
X-Rspamd-Queue-Id: 0022C10488F
X-Rspamd-Action: no action

On Fri,  6 Feb 2026 15:22:16 +0800 Jiayuan Chen <jiayuan.chen@linux.dev> wrote:

> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Add test_zswap_incompressible() to verify that the zswap_incomp memcg
> stat correctly tracks incompressible pages.
> 
> The test allocates memory filled with random data from /dev/urandom,
> which cannot be effectively compressed by zswap. When this data is
> swapped out to zswap, it should be stored as-is and tracked by the
> zswap_incomp counter.
> 
> The test verifies that:
> 1. Pages are swapped out to zswap (zswpout increases)
> 2. Incompressible pages are tracked (zswap_incomp increases)
> 
> test:
> dd if=/dev/zero of=/swapfile bs=1M count=2048
> chmod 600 /swapfile
> mkswap /swapfile
> swapon /swapfile
> echo Y > /sys/module/zswap/parameters/enabled
> 
> ./test_zswap
>  TAP version 13
>  1..8
>  ok 1 test_zswap_usage
>  ok 2 test_swapin_nozswap
>  ok 3 test_zswapin
>  ok 4 test_zswap_writeback_enabled
>  ok 5 test_zswap_writeback_disabled
>  ok 6 test_no_kmem_bypass
>  ok 7 test_no_invasive_cgroup_shrink
>  ok 8 test_zswap_incompressible
>  Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0

Nice test.  This is also testing the functionality of zswap's incompressible
page handling.

> 
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>

Reviewed-by: SeongJae Park <sj@kernel.org>

> ---
>  tools/testing/selftests/cgroup/test_zswap.c | 96 +++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
> index 64ebc3f3f203..8cb8a131357d 100644
> --- a/tools/testing/selftests/cgroup/test_zswap.c
> +++ b/tools/testing/selftests/cgroup/test_zswap.c
> @@ -5,6 +5,7 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <signal.h>
> +#include <fcntl.h>
>  #include <sys/sysinfo.h>
>  #include <string.h>
>  #include <sys/wait.h>
> @@ -574,6 +575,100 @@ static int test_no_kmem_bypass(const char *root)
>  	return ret;
>  }
>  
> +static int allocate_random_and_wait(const char *cgroup, void *arg)
> +{
> +	size_t size = (size_t)arg;
> +	char *mem;
> +	int fd;
> +	ssize_t n;
> +
> +	mem = malloc(size);
> +	if (!mem)
> +		return -1;
> +
> +	/* Fill with random data from /dev/urandom - incompressible */
> +	fd = open("/dev/urandom", O_RDONLY);
> +	if (fd < 0) {
> +		free(mem);
> +		return -1;
> +	}
> +
> +	for (size_t i = 0; i < size; ) {
> +		n = read(fd, mem + i, size - i);
> +		if (n <= 0)
> +			break;
> +		i += n;
> +	}
> +	close(fd);
> +
> +	/* Touch all pages to ensure they're faulted in */
> +	for (size_t i = 0; i < size; i += 4096)

Nit.  I show test_zswapin() is using PAGE_SIZE.  Maybe the above code can also
use it?

> +		mem[i] = mem[i];
> +
> +	/* Keep memory alive for parent to reclaim and check stats */
> +	pause();
> +	free(mem);
> +	return 0;
> +}
> +
> +static long get_zswap_incomp(const char *cgroup)
> +{
> +	return cg_read_key_long(cgroup, "memory.stat", "zswap_incomp ");
> +}
> +
> +/*
> + * Test that incompressible pages (random data) are tracked by zswap_incomp.
> + *
> + * Since incompressible pages stored in zswap are charged at full PAGE_SIZE
> + * (no memory savings), we cannot rely on memory.max pressure to push them
> + * into zswap. Instead, we allocate random data within memory.max, then use
> + * memory.reclaim to proactively push pages into zswap while checking the stat
> + * before the child exits (zswap_incomp is a gauge that decreases on free).
> + */
> +static int test_zswap_incompressible(const char *root)
> +{
> +	int ret = KSFT_FAIL;
> +	char *test_group;
> +	long zswap_incomp;
> +	pid_t child_pid;
> +	int child_status;
> +
> +	test_group = cg_name(root, "zswap_incompressible_test");
> +	if (!test_group)
> +		goto out;
> +	if (cg_create(test_group))
> +		goto out;
> +	if (cg_write(test_group, "memory.max", "32M"))
> +		goto out;
> +
> +	child_pid = cg_run_nowait(test_group, allocate_random_and_wait,
> +				  (void *)MB(4));
> +	if (child_pid < 0)
> +		goto out;
> +
> +	/* Wait for child to finish allocating */
> +	usleep(500000);

We might be better to revisit here in future to avoid racy test results.  But
this seems good enough for now.

> +
> +	/* Proactively reclaim to push random pages into zswap */
> +	cg_write_numeric(test_group, "memory.reclaim", MB(4));
> +
> +	zswap_incomp = get_zswap_incomp(test_group);
> +	if (zswap_incomp <= 0) {
> +		ksft_print_msg("zswap_incomp not increased: %ld\n", zswap_incomp);
> +		goto out_kill;
> +	}
> +
> +	ret = KSFT_PASS;
> +
> +out_kill:
> +	kill(child_pid, SIGTERM);
> +	waitpid(child_pid, &child_status, 0);
> +out:
> +	cg_destroy(test_group);
> +	free(test_group);
> +	return ret;
> +}
> +
>  #define T(x) { x, #x }
>  struct zswap_test {
>  	int (*fn)(const char *root);
> @@ -586,6 +681,7 @@ struct zswap_test {
>  	T(test_zswap_writeback_disabled),
>  	T(test_no_kmem_bypass),
>  	T(test_no_invasive_cgroup_shrink),
> +	T(test_zswap_incompressible),
>  };
>  #undef T
>  
> -- 
> 2.43.0


Thanks,
SJ

[...]

