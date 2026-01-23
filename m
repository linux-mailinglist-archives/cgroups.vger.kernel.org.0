Return-Path: <cgroups+bounces-13406-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JJBIzD7c2mf0gAAu9opvQ
	(envelope-from <cgroups+bounces-13406-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 23:50:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2A67B411
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 23:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75663300B448
	for <lists+cgroups@lfdr.de>; Fri, 23 Jan 2026 22:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8418283C89;
	Fri, 23 Jan 2026 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzltNJ4/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382411DF75D
	for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769208621; cv=none; b=MPwW/VaIVI6ILvkxW5Y8+5twM0GxUTEOBDa1fwdprriFRPb74GEhUVGhQaxrcBYv8QBNRwgYUXyEkKnYLn1Mj0fsEfc63WVigRCycgAGVOQ6FByTZpipHo9hmJr0XLuPcsstKq7NQucskb55QfKAygUSpJMIVJo9S36gMZjellg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769208621; c=relaxed/simple;
	bh=z8IlIXh47dOFdPn/7YG8QvPpbpmFtqMaCCfJQd7NMlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/KTy+LMFtscCRJ2E7C08j+J8bl8HRqbUhPMEaMwP0uBapMtfqGTLmYTaVcMRA4055+ZA2+n1b+aSp57sE18NdB1icRaOOppMKoxrMbj1m2+1taxRta1T+VCb1NdLodc5+gly8Ms+qsz0bhPBkv/vhtqPmxz2vT2EsQXYv6c1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzltNJ4/; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b70abe3417so6434377eec.0
        for <cgroups@vger.kernel.org>; Fri, 23 Jan 2026 14:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769208619; x=1769813419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6q7jSvteo768fX3RDKijF3HLXLbv8PUQY59d7KtxMqQ=;
        b=kzltNJ4/SKClkn3pHsEaknhf1XSWK/sXwuyNGmGSW728jpvWKrR6OWJOWdMI7WE4w7
         XkgVIFYmZId6oot1QXCJlABENg7UVFogWSUZJwR4BoXbd39DIL3qJwBWZFGP9vSw2nX9
         WOcQKsfpmYls6tpoFW2Qom5Xz4EnQN7pdgDb5eGiorYIV3jzBmnS7w0cC7fByvRKbf0j
         yw7a2X6MtAPoaVX361nZlGOZNe/gMsYN4GR18M4yD6BTSR8koP/uBKCqA7E6LILwc6Zl
         orHfi/rnFAgewUhgZ5i/KknHXZn78jw7aW1yy3v1FcDq3hc9ooAQB7HTLqDiJ65+CJDA
         pc+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769208619; x=1769813419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6q7jSvteo768fX3RDKijF3HLXLbv8PUQY59d7KtxMqQ=;
        b=GjXnMmGOgfJlTd/0BQ8U3DlA2pIqTRB7dmCh5jYKuuqDFSl2YxXvWsu2JBFmZZYejb
         Db3r7Toqo6SGRHC6RhLLPta1JWZbJlmsptWdAjj+onp2nBl+bRJ4mXqOMmQ33vbck9EI
         45sC42mm0QiLbce6kLQrkFC/s99oX4ZYRa3gyKA44qX8T2ctfkXZCBvEy/53tQoiOvuk
         Dxd9kfufANRAkiDnczdutRdwIo3xyw48DOVv8alOpD+uwQLPhYoozh/Fp0kWVXjoK3R9
         qfnBVjfARMyGfneIvl4frMPhjhsB7BiXv1DlepgkfvGJfMaBSc95MXWIRDgRP/EVgzx6
         v7nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoVIGrlx29d1Sv76ataYRAtvTDBq9ODDXCydTAGF8ZlVPrJ48pW8TPqPuEr4W+koH9i3HQgnGc@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhKplGGjxighvTAoFTSL2mclgvln1fvf7bj5FHRh+MohvTef1
	Yr/zj/SHiXg4WLvcMAvbAsqc8HJlL5Ep7x/iMh8q9bY390PqwiKU3AKe
X-Gm-Gg: AZuq6aJ+LfMChG66o4eO9BJ7f1Ugz44+G6W4EpyRA2I8IRcTg8bcnpvqpzESMEEE0G6
	QhihUev1v2y3MlkFuFrY95DsYfa0yjtNL/F7PUn3E3vPAuh1ccBF2AU+7lrRGYLj8ivJmL4/beC
	JLIlbi56GAhKAUd5ay+DZB8Ybav3+o8+CxA4EAqoAwG0xez5UMecGPzYYfTouMvgomLC2GF/224
	ktjnYXX9TVL2W8t77cgEaWPk2mNlCs7IZHLDNKvJkxm0xvVOAAbojMkPhJf6pr8LaCvBYJt2dZB
	eJQ4f6arBymQQeTOwUvIS9W0Bk1GP0twIdbvi5EJolv/q9ir/avZmZvoy7Uarm2HeidHMHuz8Rj
	+0Oa2OznfPZsQQn/7dA1VonGImpSoJ1sH2n2lyJAkareeIt5gb/nsLl6ta5PRbZHJ/jYu7wufwO
	exguXUicDivEGfGkVkzAX7
X-Received: by 2002:a05:7300:230a:b0:2af:674e:bc73 with SMTP id 5a478bee46e88-2b74274cff4mr1359399eec.7.1769201226027;
        Fri, 23 Jan 2026 12:47:06 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73a691b1esm4476320eec.3.2026.01.23.12.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:47:05 -0800 (PST)
Message-ID: <b90069a3-86b4-4fba-9ff3-fe5f6c4e425d@gmail.com>
Date: Fri, 23 Jan 2026 12:47:02 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next v3 09/12] selftests/bpf: Add tests for
 memcg_bpf_ops
To: Hui Zhu <hui.zhu@linux.dev>, Andrew Morton <akpm@linux-foundation.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
 Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, mkoutny@suse.com,
 Jan Hendrik Farr <kernel@jfarr.cc>, Christian Brauner <brauner@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>,
 Masahiro Yamada <masahiroy@kernel.org>, davem@davemloft.net,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Chen Ridong <chenridong@huaweicloud.com>,
 Lance Yang <lance.yang@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>, Geliang Tang <geliang@kernel.org>
References: <cover.1769157382.git.zhuhui@kylinos.cn>
 <c44accaaaebfc32be13234f82b501a3852ba3f0f.1769157382.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <c44accaaaebfc32be13234f82b501a3852ba3f0f.1769157382.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13406-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,linux-foundation.org,cmpxchg.org,kernel.org,iogearbox.net,gmail.com,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[51];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: CB2A67B411
X-Rspamd-Action: no action

Hi Hui,

On 1/23/26 1:00 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Add a comprehensive selftest suite for the `memcg_bpf_ops`
> functionality. These tests validate that BPF programs can correctly
> influence memory cgroup throttling behavior by implementing the new
> hooks.
> 
> The test suite is added in `prog_tests/memcg_ops.c` and covers
> several key scenarios:
> 
> 1. `test_memcg_ops_over_high`:
>     Verifies that a BPF program can trigger throttling on a low-priority
>     cgroup by returning a delay from the `get_high_delay_ms` hook when a
>     high-priority cgroup is under pressure.
> 
> 2. `test_memcg_ops_below_low_over_high`:
>     Tests the combination of the `below_low` and `get_high_delay_ms`
>     hooks, ensuring they work together as expected.
> 
> 3. `test_memcg_ops_below_min_over_high`:
>     Validates the interaction between the `below_min` and
>     `get_high_delay_ms` hooks.
> 
> The test framework sets up a cgroup hierarchy with high and low
> priority groups, attaches BPF programs, runs memory-intensive
> workloads, and asserts that the observed throttling (measured by
> workload execution time) matches expectations.
> 
> The BPF program (`progs/memcg_ops.c`) uses a tracepoint on
> `memcg:count_memcg_events` (specifically PGFAULT) to detect memory
> pressure and trigger the appropriate hooks in response. This test
> suite provides essential validation for the new memory control
> mechanisms.
> 
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
[..]
> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> new file mode 100644
> index 000000000000..9a8d16296f2d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> @@ -0,0 +1,537 @@
[..]
> +
> +static void
> +real_test_memcg_ops_child_work(const char *cgroup_path,
> +			       char *data_filename,
> +			       char *time_filename,
> +			       int read_times)
> +{
> +	struct timeval start, end;
> +	double elapsed;
> +	FILE *fp;
> +
> +	if (!ASSERT_OK(join_parent_cgroup(cgroup_path), "join_parent_cgroup"))
> +		goto out;
> +
> +	if (env.verbosity >= VERBOSE_NORMAL)
> +		printf("%s %d begin\n", __func__, getpid());
> +
> +	gettimeofday(&start, NULL);
> +
> +	if (!ASSERT_OK(write_file(data_filename), "write_file"))
> +		goto out;
> +
> +	if (env.verbosity >= VERBOSE_NORMAL)
> +		printf("%s %d write_file done\n", __func__, getpid());
> +
> +	if (!ASSERT_OK(read_file(data_filename, read_times), "read_file"))
> +		goto out;
> +
> +	gettimeofday(&end, NULL);
> +
> +	elapsed = (end.tv_sec - start.tv_sec) +
> +		  (end.tv_usec - start.tv_usec) / 1000000.0;
> +
> +	if (env.verbosity >= VERBOSE_NORMAL)
> +		printf("%s %d end %.6f\n", __func__, getpid(), elapsed);
> +
> +	fp = fopen(time_filename, "w");
> +	if (!ASSERT_OK_PTR(fp, "fopen"))
> +		goto out;
> +	fprintf(fp, "%.6f", elapsed);
> +	fclose(fp);
> +
> +out:
> +	exit(0);
> +}
> +

[..]

> +static void real_test_memcg_ops(int read_times)
> +{
> +	int ret;
> +	char data_file1[] = "/tmp/test_data_XXXXXX";
> +	char data_file2[] = "/tmp/test_data_XXXXXX";
> +	char time_file1[] = "/tmp/test_time_XXXXXX";
> +	char time_file2[] = "/tmp/test_time_XXXXXX";
> +	pid_t pid1, pid2;
> +	double time1, time2;
> +
> +	ret = mkstemp(data_file1);
> +	if (!ASSERT_GT(ret, 0, "mkstemp"))
> +		return;
> +	close(ret);
> +	ret = mkstemp(data_file2);
> +	if (!ASSERT_GT(ret, 0, "mkstemp"))
> +		goto cleanup_data_file1;
> +	close(ret);
> +	ret = mkstemp(time_file1);
> +	if (!ASSERT_GT(ret, 0, "mkstemp"))
> +		goto cleanup_data_file2;
> +	close(ret);
> +	ret = mkstemp(time_file2);
> +	if (!ASSERT_GT(ret, 0, "mkstemp"))
> +		goto cleanup_time_file1;
> +	close(ret);
> +
> +	pid1 = fork();
> +	if (!ASSERT_GE(pid1, 0, "fork"))
> +		goto cleanup;
> +	if (pid1 == 0)
> +		real_test_memcg_ops_child_work(CG_LOW_DIR,
> +					       data_file1,
> +					       time_file1,
> +					       read_times);

Would it be better to call exit() after real_test_memcg_ops_child_work()
instead of within it? This way the fork/exit/wait logic is contained in
the same scope making the lifetimes easier to track. I had to go back
and search for the call to exit() since at a glance this function
appears to proceed to call fork() and waitpid() from within both parent
and child procs (though it really does not).

