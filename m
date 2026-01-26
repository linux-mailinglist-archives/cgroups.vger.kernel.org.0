Return-Path: <cgroups+bounces-13441-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PT6OR/Gdml7WAEAu9opvQ
	(envelope-from <cgroups+bounces-13441-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 02:40:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D178357A
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 02:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ED583008206
	for <lists+cgroups@lfdr.de>; Mon, 26 Jan 2026 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8B41DE3AD;
	Mon, 26 Jan 2026 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JtIvEjky"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C1B1850A4
	for <cgroups@vger.kernel.org>; Mon, 26 Jan 2026 01:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769391631; cv=none; b=i3ipkP4ExgUVUi8x1te6bbM57wIqX5BCEGztmGdN53vEbOzkkB8D9FxZLU0N4BOyS0ysCaFZ88oVOcenAnxLf8Ax+G8J6MFVTswJ7wkJpq8DbR7d030SdnPM5hXsceiD/+Ce0CFwCmkctWIVZe79XXMw98zyoomC6PxkkBFcPsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769391631; c=relaxed/simple;
	bh=st4oG32XzB15pUzcYQ7SBJEdkYV85I4fNj6S9F09L7I=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=CAeTfXhQbn5p+aFrzkQ+VK82kjGS1LB/qlH5V3xUAIPxS6dVpdCiFRkntGWNYuoaeuApCTC3oDhCkMNeJyykGjXzhy/MZdOECzx7cd4oWhgDJWO3Enc35rOlE+UwI3Z8CYqh5Q+U9XgJeZsE9AUZt4R2zQTRBV5IhE4SRuY3g+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JtIvEjky; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769391617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qOS/I3qY1vByTUV0rzQTBMazz/yNAmJFWVeZH3R10+Y=;
	b=JtIvEjkyz6fJcB1qcAm9UeGr45TrQiuC4U97SwoSQWERAEd26ARBHVe7+Pw+4xl7KifCNB
	9NYXe7CylOwE4gcUYajwfyysJZAzkYijiu3765UOhj/R84ibbkDA0AHNiazLN02H6fY7JY
	Q2NWiGJKpBl1suunAWTwKhLgjyy1ZxU=
Date: Mon, 26 Jan 2026 01:40:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: hui.zhu@linux.dev
Message-ID: <8ee851c5676facd43c45cdd5d434d92d85628e43@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH bpf-next v3 09/12] selftests/bpf: Add tests for
 memcg_bpf_ops
To: "JP Kobryn" <inwardvessel@gmail.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Johannes Weiner" <hannes@cmpxchg.org>,
 "Michal Hocko" <mhocko@kernel.org>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Muchun Song" <muchun.song@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, "Kees Cook" <kees@kernel.org>, "Tejun
 Heo" <tj@kernel.org>, "Jeff Xu" <jeffxu@chromium.org>, mkoutny@suse.com,
 "Jan Hendrik Farr" <kernel@jfarr.cc>, "Christian Brauner"
 <brauner@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Brian
 Gerst" <brgerst@gmail.com>, "Masahiro Yamada" <masahiroy@kernel.org>,
 davem@davemloft.net, "Jakub Kicinski" <kuba@kernel.org>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, "Willem de Bruijn" <willemb@google.com>,
 "Jason Xing" <kerneljasonxing@gmail.com>, "Paul Chaignon"
 <paul.chaignon@gmail.com>, "Anton Protopopov" <a.s.protopopov@gmail.com>,
 "Amery Hung" <ameryhung@gmail.com>, "Chen Ridong"
 <chenridong@huaweicloud.com>, "Lance Yang" <lance.yang@linux.dev>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: "Hui Zhu" <zhuhui@kylinos.cn>, "Geliang Tang" <geliang@kernel.org>
In-Reply-To: <b90069a3-86b4-4fba-9ff3-fe5f6c4e425d@gmail.com>
References: <cover.1769157382.git.zhuhui@kylinos.cn>
 <c44accaaaebfc32be13234f82b501a3852ba3f0f.1769157382.git.zhuhui@kylinos.cn>
 <b90069a3-86b4-4fba-9ff3-fe5f6c4e425d@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13441-lists,cgroups=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[hui.zhu@linux.dev,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,cmpxchg.org,kernel.org,linux.dev,iogearbox.net,fomichev.me,google.com,infradead.org,chromium.org,suse.com,jfarr.cc,davemloft.net,huaweicloud.com,vger.kernel.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[51];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92D178357A
X-Rspamd-Action: no action

2026=E5=B9=B41=E6=9C=8824=E6=97=A5 04:47, "JP Kobryn" <inwardvessel@gmail=
.com mailto:inwardvessel@gmail.com?to=3D%22JP%20Kobryn%22%20%3Cinwardvess=
el%40gmail.com%3E > =E5=86=99=E5=88=B0:


>=20
>=20Hi Hui,
>=20
>=20On 1/23/26 1:00 AM, Hui Zhu wrote:
>=20
>=20>=20
>=20> From: Hui Zhu <zhuhui@kylinos.cn>
> >  Add a comprehensive selftest suite for the `memcg_bpf_ops`
> >  functionality. These tests validate that BPF programs can correctly
> >  influence memory cgroup throttling behavior by implementing the new
> >  hooks.
> >  The test suite is added in `prog_tests/memcg_ops.c` and covers
> >  several key scenarios:
> >  1. `test_memcg_ops_over_high`:
> >  Verifies that a BPF program can trigger throttling on a low-priority
> >  cgroup by returning a delay from the `get_high_delay_ms` hook when a
> >  high-priority cgroup is under pressure.
> >  2. `test_memcg_ops_below_low_over_high`:
> >  Tests the combination of the `below_low` and `get_high_delay_ms`
> >  hooks, ensuring they work together as expected.
> >  3. `test_memcg_ops_below_min_over_high`:
> >  Validates the interaction between the `below_min` and
> >  `get_high_delay_ms` hooks.
> >  The test framework sets up a cgroup hierarchy with high and low
> >  priority groups, attaches BPF programs, runs memory-intensive
> >  workloads, and asserts that the observed throttling (measured by
> >  workload execution time) matches expectations.
> >  The BPF program (`progs/memcg_ops.c`) uses a tracepoint on
> >  `memcg:count_memcg_events` (specifically PGFAULT) to detect memory
> >  pressure and trigger the appropriate hooks in response. This test
> >  suite provides essential validation for the new memory control
> >  mechanisms.
> >  Signed-off-by: Geliang Tang <geliang@kernel.org>
> >  Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> >  ---
> >=20
>=20[..]
>=20
>=20>=20
>=20> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_ops.c b/t=
ools/testing/selftests/bpf/prog_tests/memcg_ops.c
> >  new file mode 100644
> >  index 000000000000..9a8d16296f2d
> >  --- /dev/null
> >  +++ b/tools/testing/selftests/bpf/prog_tests/memcg_ops.c
> >  @@ -0,0 +1,537 @@
> >=20
>=20[..]
>=20
>=20>=20
>=20> +
> >  +static void
> >  +real_test_memcg_ops_child_work(const char *cgroup_path,
> >  + char *data_filename,
> >  + char *time_filename,
> >  + int read_times)
> >  +{
> >  + struct timeval start, end;
> >  + double elapsed;
> >  + FILE *fp;
> >  +
> >  + if (!ASSERT_OK(join_parent_cgroup(cgroup_path), "join_parent_cgrou=
p"))
> >  + goto out;
> >  +
> >  + if (env.verbosity >=3D VERBOSE_NORMAL)
> >  + printf("%s %d begin\n", __func__, getpid());
> >  +
> >  + gettimeofday(&start, NULL);
> >  +
> >  + if (!ASSERT_OK(write_file(data_filename), "write_file"))
> >  + goto out;
> >  +
> >  + if (env.verbosity >=3D VERBOSE_NORMAL)
> >  + printf("%s %d write_file done\n", __func__, getpid());
> >  +
> >  + if (!ASSERT_OK(read_file(data_filename, read_times), "read_file"))
> >  + goto out;
> >  +
> >  + gettimeofday(&end, NULL);
> >  +
> >  + elapsed =3D (end.tv_sec - start.tv_sec) +
> >  + (end.tv_usec - start.tv_usec) / 1000000.0;
> >  +
> >  + if (env.verbosity >=3D VERBOSE_NORMAL)
> >  + printf("%s %d end %.6f\n", __func__, getpid(), elapsed);
> >  +
> >  + fp =3D fopen(time_filename, "w");
> >  + if (!ASSERT_OK_PTR(fp, "fopen"))
> >  + goto out;
> >  + fprintf(fp, "%.6f", elapsed);
> >  + fclose(fp);
> >  +
> >  +out:
> >  + exit(0);
> >  +}
> >  +
> >=20
>=20[..]
>=20
>=20>=20
>=20> +static void real_test_memcg_ops(int read_times)
> >  +{
> >  + int ret;
> >  + char data_file1[] =3D "/tmp/test_data_XXXXXX";
> >  + char data_file2[] =3D "/tmp/test_data_XXXXXX";
> >  + char time_file1[] =3D "/tmp/test_time_XXXXXX";
> >  + char time_file2[] =3D "/tmp/test_time_XXXXXX";
> >  + pid_t pid1, pid2;
> >  + double time1, time2;
> >  +
> >  + ret =3D mkstemp(data_file1);
> >  + if (!ASSERT_GT(ret, 0, "mkstemp"))
> >  + return;
> >  + close(ret);
> >  + ret =3D mkstemp(data_file2);
> >  + if (!ASSERT_GT(ret, 0, "mkstemp"))
> >  + goto cleanup_data_file1;
> >  + close(ret);
> >  + ret =3D mkstemp(time_file1);
> >  + if (!ASSERT_GT(ret, 0, "mkstemp"))
> >  + goto cleanup_data_file2;
> >  + close(ret);
> >  + ret =3D mkstemp(time_file2);
> >  + if (!ASSERT_GT(ret, 0, "mkstemp"))
> >  + goto cleanup_time_file1;
> >  + close(ret);
> >  +
> >  + pid1 =3D fork();
> >  + if (!ASSERT_GE(pid1, 0, "fork"))
> >  + goto cleanup;
> >  + if (pid1 =3D=3D 0)
> >  + real_test_memcg_ops_child_work(CG_LOW_DIR,
> >  + data_file1,
> >  + time_file1,
> >  + read_times);
> >=20
>=20Would it be better to call exit() after real_test_memcg_ops_child_wor=
k()
> instead of within it? This way the fork/exit/wait logic is contained in
> the same scope making the lifetimes easier to track. I had to go back
> and search for the call to exit() since at a glance this function
> appears to proceed to call fork() and waitpid() from within both parent
> and child procs (though it really does not).
>

I will fix it.

Best,
Hui

