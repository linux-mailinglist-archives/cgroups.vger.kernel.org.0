Return-Path: <cgroups+bounces-13925-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOKOJUpzjmnnCQEAu9opvQ
	(envelope-from <cgroups+bounces-13925-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 01:41:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6CC1321E4
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 01:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DBCF301E6D8
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 00:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCDF20E31C;
	Fri, 13 Feb 2026 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqMmRtrL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9617555
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770943301; cv=none; b=e1jKoTLgqC+qeWuSKVqF03WXN3x3cMCz41MPzgWguBYltz+K7YN4nTt5QGKqiAIvFUZNu58Ihrfsc65q/f1DMsAOZ4T+u/ndHNsG1XIgYPbe/2r3p4XeE64/ZOh60+uGBUiwVS6TnTFKo1K1+ujb9gwi6AM8+Gw19yfD0EMdhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770943301; c=relaxed/simple;
	bh=6D8tgjI9PBm1BFXqhi50JPEsbcI0pqJf1KyyVtXlYsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bx8+OkFeUld3k9tfuDG8Zt+LOWcVUIxfrsCWF5Tkl+xauNm9SPs/LbSXe7ubfZmHNN5DVx25Dwx0Mrozmy8fLBOoSjaK3u3r9EIuDZ2n0/cyz04yFkgx0f/U7x8EE1LCd62J3nqodPvQInsKgq/uaAeushLANnVvXdgsf1yXDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqMmRtrL; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ba9c484e5eso445767eec.1
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770943299; x=1771548099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwqSI1RFCMIyBtnekhVRj3/LtP3LLhrY9w2W+ftU2B8=;
        b=SqMmRtrLf2GRx7c0nMR9aamB/ORqM+JwkEn5N0Gq0gj50anx15gDCgRsACcacevOwP
         A8XcZuQFq9vdldl5KasK3szj4GJM1PWw5jr+UwVnHcIPniP46syn5WaKbKS9nqeD/u8a
         amL5UK1zMnv8/rLiuS6B+VPVlK5rOPvvt8Qy3SDF9YgfMkhbEJnXcO5W4Iy1PsL8zBRL
         ERlXAeGv472zt9Uwepr7y87W9eP5sMzPEjLFvo1Cy3f/OpdFQILX2VxJ7PqfHkWMyAtt
         hsgi31GcqGToy8ZPsbM1LQjpSwQ9w0Fmq2nEhx4kv3vFB5MhvxU8Ll591mFlsmSqzfBU
         VLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770943299; x=1771548099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwqSI1RFCMIyBtnekhVRj3/LtP3LLhrY9w2W+ftU2B8=;
        b=NAE51cJzzlCe5Vb+pbFQF6B5EEWP1VkVqVpzerBAX8O2sSPm3x4VlVq9oONH/SL8lG
         rWPPRyx1umCv4XStdJZk88owKUNnAQuamHCdQwZzgCuCoVMzk/+mjSXX6uO7TTP3xJKZ
         +e4lz1vf2iol7iiI+3mFPSUJn9b9vpgiSgz/I4/U2GRYguxD56ScK6tddVVNym2h1HaW
         wno8eOqr4kkhL2fe+QeBvR4hivlTHhPJiS0cLVT3KwLINSAZc3g0PYMJacnkzjrRyrOz
         sWMV5vJ6zW4oLDVCbh9Xpl4tKwzzYmDuBCtmWFcJZjcvUsqU5OUeYXQJ/qJXOK3tgSsv
         e/1w==
X-Forwarded-Encrypted: i=1; AJvYcCWRE4btbB8KiayXUcZj9Fj9lkR74yas9Bcn3kGMAEnSSxQy3JVlgAKmUSgCkrtUHkmJu7/9RxDk@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvs1K3T1GUTHp34JaoqWBWhvbDwJcqJSg/FbCQHi2Xt638ymSu
	CPSNnwrSKdTt0X634IF9gZMx0YqsKl2DCrXVMluy3naW4QaswH1ym+h7
X-Gm-Gg: AZuq6aKgHCingaZEqgLTXlqMxXwruApet6q1qhDrPBGjj0/oIlNqKDRYndkdxVQ3D1/
	6mUNEQJkh13TtwP/rvf5c6kJehCb6N09AQx9gmcPLWeZGxk+mpoKb+fAVyChAsuaiYYJ60rnaZ1
	WhHvFl/EkPQLQqUbk251kDNkUPYb3A5VWiNch3ySujnvLtEagPBAoXhz9xRvgnLcjNva5DvCTvr
	E35QVmyzT35xP/Z5Sj8zLcNaocIUZlfqMX4U+Almc3EG180WmsLyqwrJGo4BsbYjUuIo6QR55SI
	B69U5pgZs6ZqjdVLSmIKWwZyW2aGG0Kf1mdczODiffknSnT2rKHzKNBecptndeQURSuD9nq6M4H
	9LfLhNxGRceDc6X6jy9F/GybljbFQP768BVdw0P28z3ys6Ey2jmOhC/Udyvja04veP0fncfQ2sV
	isAZoe0C+HGLo5qV5pxUJur1gvI5app0Lq
X-Received: by 2002:a05:7300:ca4:b0:2b7:857:db6a with SMTP id 5a478bee46e88-2babc47cb8amr28835eec.21.1770943298947;
        Thu, 12 Feb 2026 16:41:38 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd0609sm5409175eec.16.2026.02.12.16.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 16:41:38 -0800 (PST)
Message-ID: <f587b319-fc6c-44f5-94b0-350c1aadaa3c@gmail.com>
Date: Thu, 12 Feb 2026 16:41:37 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Skip test_kmem when
 cgroup.memory=nokmem
To: Hui Zhu <hui.zhu@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Hui Zhu <zhuhui@kylinos.cn>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <cover.1770883926.git.zhuhui@kylinos.cn>
 <2f6ee1db173b67a636b2caa85744cb4ce8114e64.1770883926.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <2f6ee1db173b67a636b2caa85744cb4ce8114e64.1770883926.git.zhuhui@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13925-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.dev,cmpxchg.org,kernel.org,linux-foundation.org,iogearbox.net,gmail.com,fomichev.me,google.com,kylinos.cn,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[inwardvessel@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 1F6CC1321E4
X-Rspamd-Action: no action

On 2/12/26 12:23 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When cgroup.memory=nokmem is set in kernel command line, kmem
> accounting is disabled and the test_kmem subtest will fail.
> 
> Add a check to skip this test when the parameter is present.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   .../bpf/prog_tests/cgroup_iter_memcg.c        | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> index 13b299512429..203e6b091a21 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter_memcg.c
> @@ -134,11 +134,39 @@ static void test_shmem(struct bpf_link *link, struct memcg_query *memcg_query)
>   	shm_unlink("/tmp_shmem");
>   }
>   
> +static bool cmdline_has(const char *arg)
> +{
> +	char cmdline[4096];
> +	int fd;
> +	ssize_t len;
> +	bool ret = false;
> +
> +	fd = open("/proc/cmdline", O_RDONLY);
> +	if (fd < 0)
> +		return false;
> +
> +	len = read(fd, cmdline, sizeof(cmdline) - 1);
> +	close(fd);
> +	if (len < 0)
> +		return false;
> +
> +	cmdline[len] = '\0';
> +	if (strstr(cmdline, arg))
> +		ret = true;
> +
> +	return ret;
> +}
> +
>   #define NR_PIPES 64
>   static void test_kmem(struct bpf_link *link, struct memcg_query *memcg_query)
>   {
>   	int fds[NR_PIPES][2], i;
>   
> +	if (cmdline_has("cgroup.memory=nokmem")) {
> +		test__skip();
> +		return;
> +	}

Instead of just skipping what if we proceed and then confirm we get a
zero value after the allocations?

