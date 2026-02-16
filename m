Return-Path: <cgroups+bounces-13969-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2As8DVFik2n74AEAu9opvQ
	(envelope-from <cgroups+bounces-13969-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 19:30:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2D2146FCF
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 19:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9142A3039C9C
	for <lists+cgroups@lfdr.de>; Mon, 16 Feb 2026 18:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EAB2E3387;
	Mon, 16 Feb 2026 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMLJktL2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B482BEFE7
	for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771266622; cv=none; b=NUhOWZ4Q7/yGEkcCBmBxXRf/CVaJeUVHFUqHGzCj9LzGI7vM3uZBI50DS2XYw8t0t+i/+lUyWRLWy0SgMAtwFecALgRFAD7ChVVbr5m45B55areWg5PghVEPttO10lcybsHNFjutwULDNYyk78JUSf4SFv41FRbQlW5bi7vh1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771266622; c=relaxed/simple;
	bh=MAEs3Jddu85q70yGwvGJmRXFIyW3shtR1hg+pghMVm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MIe9DIDfgDdbYsmp/YZFFSEUAyo70qLUEXDz1GyjQ7HISeO8pHfVJp88P98ctjgkxrVJX9NH7ojN3Pa21dublzfLY9KUuw9/eSBy6mjjJT7Dly8dtlbnIl7BYFvQDe1SdWWGmkCsI0fZqTLs0kvuv8bG7eD3N5GPwgJGlyq7pbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMLJktL2; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1271257ae53so3501843c88.1
        for <cgroups@vger.kernel.org>; Mon, 16 Feb 2026 10:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771266619; x=1771871419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EkJWUx4iz20mHMlM7dqbfruMTcGOgRj83PoFq0CJCIQ=;
        b=dMLJktL2qRHJHkLBftVGBt/ill/K2ExeWTvtZA/hZ1YMOwn9BPr0tXAhoCOoJDX+2E
         6FaWkjwiege15sgemLCZKR4DkHPqeGqOjbxeGjC+tOtZMWY1hJx38Zw6i9Ak1+C6c4hL
         DKqnQtuSrUE87hEQC6F/P9X2EUZZNeXkayRwR0QgQijMKjwvKF+sjsfEbNm+bZC6CZCV
         Y9KPtK60qsyAOGgmDG+SJobr7u//1MTnYeRTUiVa7/hW8uy95zbT+r9CObAMa1AgGTOt
         HPEkquwTmfsIIM4zz2V7B4GG+chjM7KRV+mYwAiND/qKsQ9lJe03DBT1m62bEtZofAcb
         ChZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771266619; x=1771871419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EkJWUx4iz20mHMlM7dqbfruMTcGOgRj83PoFq0CJCIQ=;
        b=JR6/52YhW03ICKNIDqVJQKAZv7ojZta2Kzmb7ohqJ3DDt3ih2zg+vtaSCjnVvR5Xwi
         hF5EsiYIV6L+qxdmwa8WHjJzrkUMkNgTgIs8qV0O5FGOzI+bQfpzcMHY8ebRl/EPjbIN
         ys+x3Qsd254clyjH7q0jCBtJaHWm5HtWAQaGAH3emgS2dHwUKt9WhhX0pVEaBhiluOiQ
         shg7aefaCJu0CfkzMx4KsoZbqYN17IdFhbQggAUfCimByNntgBWEFbhXEbzDxeMF6ClL
         B8+qmoq75qDpRoz1SsZOWdFsYWAHDmg0rKYZR8FHjtGwq0kSWZ6AAbnljLAtOZFyg0af
         PFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbXXYkPSD/9aegkOZ2Opf4x2myQYi6rC2GiQKWXLsh3bWx4yFsuyilq1vwWtbwi/HChkEEprs/@vger.kernel.org
X-Gm-Message-State: AOJu0YznEyWcmzYU50nQyPiUy0oT4uHbEzck7VacfSr7FP02qLxCvSfu
	U2tvvU4kZOpj5iOipZ9SILAfMQ927RKNq++uFlLE1yWnXjQtqYk4YOSE
X-Gm-Gg: AZuq6aKHd1Y5aFAb7lA7DGZ7aoRygK7ldqTXU1StRyN4xbT62cc+drAzya0V4pv2rSV
	YYHtsAnfIQvUmZ1ZLAcPKbbHs7bX99+nHGOOS95NgJlsTJnchSQgAcfiIH99ZX+OVJcLTd3KDZe
	9BkWyn5xEuxdtlJ4wM8zlVv1Y1ioTZZZbsOYcdl66d4Ok0hI1mQed1yj3DSboib6nit27irCZW/
	cuBDluJ/35UWnpOX5EPOD3AqkVBquKaGcHWGYArfLWAJ4qEx7qN9OHnFqrtrRU0u24oDyocTHkj
	WSX9tvRQzCxcxPbJGp41VCOHPDHpMvSgRy+XeU3b6iDx+9sXCmpcpFYXo/BrsdoL7i7+9dpTxli
	kduB9gmw5pBguOBGsHdnfDZc5z6tvbPb/ZEkGR8SiQScLww3GciF+T2xLNLXkUrB+T54F24i8UO
	9KXW1ml4h/Ppp7d21rpPN49wcfPJDR/ptf
X-Received: by 2002:a05:7022:692:b0:11b:a36d:a7f7 with SMTP id a92af1059eb24-1273add4230mr3788461c88.16.1771266619112;
        Mon, 16 Feb 2026 10:30:19 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc83e6sm11517513c88.15.2026.02.16.10.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Feb 2026 10:30:18 -0800 (PST)
Message-ID: <ac9ccc1c-acb1-4439-8db2-eafe757c4f9e@gmail.com>
Date: Mon, 16 Feb 2026 10:30:17 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Use bpf_core_enum_value for stats in
 cgroup_iter_memcg
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
References: <cover.1770965805.git.zhuhui@kylinos.cn>
 <24ac7bab25d8d2a24a35ab87a5283263eb6a4575.1770965805.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <24ac7bab25d8d2a24a35ab87a5283263eb6a4575.1770965805.git.zhuhui@kylinos.cn>
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
	TAGGED_FROM(0.00)[bounces-13969-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE2D2146FCF
X-Rspamd-Action: no action

On 2/12/26 11:23 PM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Replace hardcoded enum values with bpf_core_enum_value() calls in
> cgroup_iter_memcg test to improve portability across different
> kernel versions.
> 
> The change adds runtime enum value resolution for:
> - node_stat_item: NR_ANON_MAPPED, NR_SHMEM, NR_FILE_PAGES,
>    NR_FILE_MAPPED
> - memcg_stat_item: MEMCG_KMEM
> - vm_event_item: PGFAULT
> 
> This ensures the BPF program can adapt to enum value changes
> between kernel versions, returning early if any enum value is
> unavailable (returns 0).
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   .../selftests/bpf/progs/cgroup_iter_memcg.c   | 41 +++++++++++++++----
>   1 file changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> index 59fb70a3cc50..b020951dd7e6 100644
> --- a/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> +++ b/tools/testing/selftests/bpf/progs/cgroup_iter_memcg.c
> @@ -15,6 +15,8 @@ int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
>   	struct cgroup *cgrp = ctx->cgroup;
>   	struct cgroup_subsys_state *css;
>   	struct mem_cgroup *memcg;
> +	int ret = 1;
> +	int idx;
>   
>   	if (!cgrp)
>   		return 1;
> @@ -26,14 +28,39 @@ int cgroup_memcg_query(struct bpf_iter__cgroup *ctx)
>   
>   	bpf_mem_cgroup_flush_stats(memcg);
>   
> -	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(memcg, NR_ANON_MAPPED);
> -	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(memcg, NR_SHMEM);
> -	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(memcg, NR_FILE_PAGES);
> -	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(memcg, NR_FILE_MAPPED);
> -	memcg_query.memcg_kmem = bpf_mem_cgroup_page_state(memcg, MEMCG_KMEM);
> -	memcg_query.pgfault = bpf_mem_cgroup_vm_events(memcg, PGFAULT);
> +	idx = bpf_core_enum_value(enum node_stat_item, NR_ANON_MAPPED);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.nr_anon_mapped = bpf_mem_cgroup_page_state(memcg, idx);
>   
> +	idx = bpf_core_enum_value(enum node_stat_item, NR_SHMEM);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.nr_shmem = bpf_mem_cgroup_page_state(memcg, idx);
> +
> +	idx = bpf_core_enum_value(enum node_stat_item, NR_FILE_PAGES);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.nr_file_pages = bpf_mem_cgroup_page_state(memcg, idx);
> +
> +	idx = bpf_core_enum_value(enum node_stat_item, NR_FILE_MAPPED);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.nr_file_mapped = bpf_mem_cgroup_page_state(memcg, idx);
> +
> +	idx = bpf_core_enum_value(enum memcg_stat_item, MEMCG_KMEM);
> +	if (idx == 0)
> +		goto out;
> +	memcg_query.memcg_kmem = bpf_mem_cgroup_page_state(memcg, idx);
> +
> +	idx = bpf_core_enum_value(enum vm_event_item, PGFAULT);
> +	if (idx == 0)
> +		goto out;

This is getting messy. Most of these values should be on any system
regardless of boot-params. I was expecting you would make the call
inline.

Let's simplify this whole series. This selftest only needs to exercise
bpf_mem_cgroup_page_state() and bpf_mem_cgroup_vm_events(). I think we
can remove the kmem subtest altogether and still have the coverage we
need. You could then call bpf_core_enum_value() inline as an argument to
the kfuncs above and not need to check if they exist (just let them give
you the host-specific co-re value).

