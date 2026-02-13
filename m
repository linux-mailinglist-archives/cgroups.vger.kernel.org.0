Return-Path: <cgroups+bounces-13924-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH56JqhyjmnXCQEAu9opvQ
	(envelope-from <cgroups+bounces-13924-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 01:39:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C351321B4
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 01:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D26303018D5D
	for <lists+cgroups@lfdr.de>; Fri, 13 Feb 2026 00:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A781F30AD;
	Fri, 13 Feb 2026 00:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4dbM5iM"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E17EADC
	for <cgroups@vger.kernel.org>; Fri, 13 Feb 2026 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770943138; cv=none; b=GE6M53Amy4ZqQYbp0SL5emTNcxswbTUFzgLOzaEHaTQD9EhdS+n+DHoM9U8PFTvGibPu3sOL+DqMc74JymUV5E6IvJF6aBnFSQXYaDfURtGwdCdin7bci4N49m+1yg2JmoEDv1QpCwsf/rwW4xA9z9zStt2VFfiC4ZvT43RWMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770943138; c=relaxed/simple;
	bh=t/+3wyweMkhjwVY2qvSMuKbG8mkGC5i0DHQ0TzmGcNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FU3FiVaqQQYm8AG/nlbnFq/pTl6sL0UpZjTiImtib+OmtmloryLgzQZ0I6UGooxRxUWq0bbWzyIjey7eSqU/9yRNP1vCac0Q9lUg7fXLj7xWZvJR5Z28VzDQJwKn0an9cs0BVvEWLzYld/Rv8fOgQU1PYNa0cw8iqQ1vTAXIw1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4dbM5iM; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba6aa57d5fso413869eec.1
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770943137; x=1771547937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lp9040amXhpFPWQBTbbqsO5bbDZPitD7bxgNCwcTcG0=;
        b=O4dbM5iMYx+hC473R22ijUI0lZpm6cdrFrNmHh8qiVVi6mMita1w4d2PR6Akbcz9c+
         1OKTt8BL7xNdmSHjXiWu72amsRryuBbbxDX5MMGjI6Ru7ROn6oemG5LT4pcykRlwTBud
         pWAwKCv745EF6QABauIPfqbGXz/5fYqyIqWHRabXORb+0VsiAEwnn/pwYGhI3KDwMIFu
         A9ruoh8X7Cpl9Q8t5G5eXF3PlutUn1oGmOjzadHzAyw2PJ9692Kgi/KlhiSuC8aWuE7X
         9qFSWNCmr9wymbrJDXFWuzk/aTz9F3agQ1KNu0wZIxEJsnDk0I9kJHbACBfrcO7FU+VC
         XZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770943137; x=1771547937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lp9040amXhpFPWQBTbbqsO5bbDZPitD7bxgNCwcTcG0=;
        b=CIqZUpkrK//tlhZyN+5/5Dg5yL+RxDtlNKNFrelAyVSzobSNR3BsON3iGV+Krq64Hn
         GtrPKWGGHThIiGEJ8xwRFytTwoa/HZ8fki1xeUtWWM/Dw59T+0f4r+Gqw6sUq+vuzQpO
         YK5zT0Cv0E+Mx2wpN3KSdCuI3oMR5DayQhAVBPbuKCswXt3iqgZjY7941hLpezRb11Tj
         9HnJ4/bIubjKgQ/yullRiFOgTA/Lz6iHS4MH6x5CXtHkvNTWLgDpt2UUkP52W20v1bL9
         UkZDdhEV82DiZ/soVsns6+zz+M7f/QDryIOrnf1fh4gJwZ/Bsu74gtQrneQ8KSLpnCPq
         LOAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgcAYf6jRyAr3hkoZc353EAlbS5uSuboPcZdtLrv+8ukCMqB6ReRjPuhVN1IgCSRGkE56Y8VOq@vger.kernel.org
X-Gm-Message-State: AOJu0YwH9wY/5zQmovf643Vxc3g0VY2X44wCcnYUuT0q04LNcPpxelGD
	hQypdPpeuRv//wULqbCvFp1YjMfWFj4UWTuJnBcciW4chsYnzhw4m5/K
X-Gm-Gg: AZuq6aKKJdCSXSWkJhOzgOAFxUkBIAv3t5F7QIeaGOVBXWLG9QhH148TtfXA098aD1B
	KK3nHjtFKfgpoltgjs3jBDXAeXcPPKw+wcHMhoObfqHxredj3yDFkWEWVBCyNPJmmUdQGgvOHh+
	ZxdJmjLsDGscMD+vs9mSQNFCW60TyqC9rdUYTURtI9/RZ3hDQNQ1UuhWdAolccPxqz6tGsoTp+F
	rIbWwO59ekFZ6jgTYfpt2Peq9cwx1rOZVW1V9Hd3jF5Yg1V/MmJTI2ZYClNxEshxvJx8/YqrjHB
	dcabxONuA5lLtdiTYT8Wt4ikXlcjtCZQqHqkd2mG57KMGR/y3lOFWgYs8XcqXG50W29csx11EEo
	11eYlCMccwU7B09GEPHRcPyoLybJAwUNmrk5+zzZcUzVHePbWgIasrpNKG2FQOBXqo6QSCld9Ae
	G8t7luPuhW8swFFbaYr+VpbinWFfcgm+mOAeIzrzHLa5I=
X-Received: by 2002:a05:693c:2b06:b0:2ba:75f5:72a2 with SMTP id 5a478bee46e88-2babc3a4e2emr44150eec.2.1770943136554;
        Thu, 12 Feb 2026 16:38:56 -0800 (PST)
Received: from [192.168.4.196] ([73.222.117.172])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd00d2sm5059384eec.20.2026.02.12.16.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 16:38:56 -0800 (PST)
Message-ID: <51bbd728-c712-4601-8a4a-7c602c67fe75@gmail.com>
Date: Thu, 12 Feb 2026 16:38:54 -0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] mm/memcontrol: Return error when accessing
 kmem with nokmem
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
 <733422f72ccbac94126ae67b9e49f4a3d460b76a.1770883926.git.zhuhui@kylinos.cn>
Content-Language: en-US
From: "JP Kobryn (Meta)" <inwardvessel@gmail.com>
In-Reply-To: <733422f72ccbac94126ae67b9e49f4a3d460b76a.1770883926.git.zhuhui@kylinos.cn>
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
	TAGGED_FROM(0.00)[bounces-13924-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 45C351321B4
X-Rspamd-Action: no action

On 2/12/26 12:23 AM, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> When running tests on hosts with cgroup.memory=nokmem enabled for
> performance reasons, test_kmem always gets a value of 0 for kmem
> statistics.
> 
> Since BPF programs cannot easily determine whether kmem is enabled,
> add a check in memcg_stat_item_valid() to return an error when
> attempting to access MEMCG_KMEM statistics while kmem accounting
> is disabled via cgroup_memory_nokmem.
> 
> This prevents BPF programs from silently receiving zero values and
> allows them to properly handle the case where kmem accounting is
> unavailable.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   mm/memcontrol.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 129eed3ff5bb..4d8419623d1c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -667,7 +667,8 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>   
>   bool memcg_stat_item_valid(int idx)
>   {
> -	if ((u32)idx >= MEMCG_NR_STAT)
> +	if ((u32)idx >= MEMCG_NR_STAT ||
> +	    (cgroup_memory_nokmem && (u32)idx == MEMCG_KMEM))
>   		return false;

It's still a valid stat though, right? When it's disabled the value will
just remain zero. I don't think this is necessary.

