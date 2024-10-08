Return-Path: <cgroups+bounces-5069-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08B9950ED
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 16:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450581F21D61
	for <lists+cgroups@lfdr.de>; Tue,  8 Oct 2024 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210A11DF750;
	Tue,  8 Oct 2024 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IdjlPsU3"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F14E1D9A43
	for <cgroups@vger.kernel.org>; Tue,  8 Oct 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396152; cv=none; b=KnL1VZxnWE9h5SzM2ZxNzhmV7sn5rvFgP0rjctn92yuwmVYuG5E+odWmS+4Tp/QOrVAb6zEcickVY5P2ar8+pMTiSvfUPAxiBBZ9DbDMu7IuNO/Z1Njj0YnJ6yDtSK33eP/DgC0R849NtxBWTarpoj8K99iDPBMXKN7CortVMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396152; c=relaxed/simple;
	bh=tVu52BxrX0Q/TS1mAQWUKknA1md5JbYvFeD2hop2BQY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UWrKhVCKj7AIcronl6urJHdyVYtY1WID1hh1y/UM3TAT0HVh4L5jJJ31VA4CIZNSPReCCY7I9a62ILUKL8GRvBh9PomxDZS4dsD2luw999UY/1KPnOB6V2g/hdHraiy/6hVSrusCUwPWW48i2DlNGFdyaLQevHHbhgPFLo4on2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IdjlPsU3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728396150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVX/8OhpJstYMaQl1bgqrbw3GW6MUoKifRJkQWPgKpY=;
	b=IdjlPsU3dKVlfaUVCPcy7/p7WJFrFlcnoSSmj/fZmeaRQbjPukjeVzYDbYKIk15OdL80y7
	fu9bolGcaKm9ch5zwYxOEDu1wBoB1VdE97328pX6V9uos1y8hw9bbwMC3EN4H0aZee95vN
	4QNl5LhktOXSwi0l1TlV+rzId0EEZAE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-l4hRZem2NmWXGuA-3Y5KLg-1; Tue, 08 Oct 2024 10:02:27 -0400
X-MC-Unique: l4hRZem2NmWXGuA-3Y5KLg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7a803adfe52so888289285a.1
        for <cgroups@vger.kernel.org>; Tue, 08 Oct 2024 07:02:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396147; x=1729000947;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QVX/8OhpJstYMaQl1bgqrbw3GW6MUoKifRJkQWPgKpY=;
        b=GMMjnu4mi6xV9lI5cjfTOTfuI6cZIsoERz86UR+CibTauudU2Hyw0AN2PZlT/0ZdCC
         3TiOkVtF7/p0Pwa3byD4Tmaz4eX10wkfLYXkj6JIA8jnRb1trZW9lQaXolsAKS0RRURd
         3FxPYAqni50zBsa+mm0Ju7sH968TVqizuDtjKEBCumm5ollM8eiwm4XphDQ8W3FVcrmv
         NeqESVHRf+D+F0BB5sW7UP4cmaqGuflbNjgGQGF1L7yNBGfOmsV8WEnUrDmH8OFdDMB6
         0kJ8t2/5t6sK7g4WYmWKkZdIeZO/Oc4+4JBfW6ZO8URExI2X0SWg7P1pawOV94mx3QST
         V2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUpQakZm/UWiQagxYBUBsqLZ9sbdakYrIi7w1zlg/x16kmTYsUF6DH+blewDvoIjl9Y8NJmzlh/@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIXhTkqmWmcFFR18ZtPzUoGRaTuWFMhjowPJRgKQbbovOgiXY
	+LevxKaf25AwmivT0PWeVhra4Fgb1BVS91wF+1XmFTmve60QBDe/D6lpuJVuYlJDEp4iZHnQzQZ
	wbNfBWtt3DEe0dRn+r/YYS3S+deTeOgZ8gDq6gPetgNuVFSbwH3htGA8=
X-Received: by 2002:a05:622a:5c8:b0:458:253b:4151 with SMTP id d75a77b69052e-45d9badafcbmr199469801cf.42.1728396146511;
        Tue, 08 Oct 2024 07:02:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEtistseQGcjlje3ffXmMjiGuX784aJwl7Av3+brMKWNfrqZdPUuw+U1bsc7Tic1TbGmHPjg==
X-Received: by 2002:a05:622a:5c8:b0:458:253b:4151 with SMTP id d75a77b69052e-45d9badafcbmr199469401cf.42.1728396146117;
        Tue, 08 Oct 2024 07:02:26 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45f08714e3fsm720221cf.62.2024.10.08.07.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 07:02:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ef7f2495-06fc-4409-8233-062d2e884271@redhat.com>
Date: Tue, 8 Oct 2024 10:02:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] cgroup/cpuset: Optimize domain counting using
 updated uf_union()
To: Kuan-Wei Chiu <visitorckw@gmail.com>, xavier_qy@163.com,
 lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, akpm@linux-foundation.org
Cc: jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <20241007152833.2282199-6-visitorckw@gmail.com>
Content-Language: en-US
In-Reply-To: <20241007152833.2282199-6-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/24 11:28 AM, Kuan-Wei Chiu wrote:
> Improve the efficiency of calculating the total number of scheduling
> domains by using the updated uf_union function, which now returns a
> boolean to indicate if a merge occurred. Previously, an additional loop
> was needed to count root nodes for distinct groups. With this change,
> each successful merge reduces the domain count (ndoms) directly,
> eliminating the need for the final loop and enhancing performance.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Note: Tested with test_cpuset_prs.sh
>
> Side note: I know this optimization provides limited efficiency
> improvements in this case, but since the union-find code is in the
> library and other users may need group counting in the future, and
> the required code change is minimal, I think it's still worthwhile.
>
>   kernel/cgroup/cpuset.c | 10 +++-------
>   1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a4dd285cdf39..5e9301550d43 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -817,6 +817,8 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   	if (root_load_balance && (csn == 1))
>   		goto single_root_domain;
>   
> +	ndoms = csn;
> +
>   	for (i = 0; i < csn; i++)
>   		uf_node_init(&csa[i]->node);
>   
> @@ -829,17 +831,11 @@ static int generate_sched_domains(cpumask_var_t **domains,
>   				 * partition root cpusets.
>   				 */
>   				WARN_ON_ONCE(cgrpv2);
> -				uf_union(&csa[i]->node, &csa[j]->node);
> +				ndoms -= uf_union(&csa[i]->node, &csa[j]->node);

You are taking the implicit assumption that a boolean true is casted to 
int 1. That is the usual practice, but it is not part of the C standard 
itself though it is for C++.  I will be more comfortable with the "if 
(cond) ndoms++" form. It will also be more clear.

Cheers,
Longman


