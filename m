Return-Path: <cgroups+bounces-2607-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A14018AA73A
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 05:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 412CD1F21B3A
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 03:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425D79CC;
	Fri, 19 Apr 2024 03:33:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E82F29;
	Fri, 19 Apr 2024 03:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497610; cv=none; b=EBY83si4louj9E/prGnLKAC92n+mdwM0pjcvwzQooasqWahKvkMjeElBYomtzLSCtypUkRcwnSyskJhVuZcejansHZFyiS6fHFYvv1XaVacPBEMw/8bpiPAqTLCiyp4/1S8N8Gjbsz8G4hycXODQJi+iRlIZjc6hkVVS35mThS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497610; c=relaxed/simple;
	bh=iXKYoXizLisUbRsk7HQWdagUkZG7Q/WnEvhvzK6djxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GF+0kLTFSf9VoNPsdGRPy+SgKyUjzkOKVP8JvHJbnkZJVtSagnZU1BDP91eFPAbOGEIxS0xNevmkvBinHDqEKD84U4qV0Y1RY//JcD4z/pYDkaKbX/i2/U5Px00Zfisw8C5TukRuRHhOVasrWD9eMzJqM+v8Lm7oaiUZqDL3jbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VLKvt3mF6z1HBhj;
	Fri, 19 Apr 2024 11:32:26 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E19C1A016C;
	Fri, 19 Apr 2024 11:33:22 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 19 Apr 2024 11:33:21 +0800
Message-ID: <9d01ab99-bbfd-536b-a375-9c44f988aa9a@huawei.com>
Date: Fri, 19 Apr 2024 11:33:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] cgroup: make cgroups info more readable
Content-Language: en-US
To: Huan Yang <link@vivo.com>, Tejun Heo <tj@kernel.org>, Zefan Li
	<lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <opensource.kernel@vivo.com>
References: <20240409021826.1171921-1-link@vivo.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20240409021826.1171921-1-link@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Hi,

I found a discussion about this change in the email thread bellow, and
hope it helps you.

https://lore.kernel.org/all/YwMwlMv%2FtK3sRXbB@slm.duckdns.org/#t

On 2024/4/9 10:18, Huan Yang wrote:
> The current cgroups output format is based on tabs, which
> may cause misalignment of output information.
> 
> Using placeholder formatting can make the output information
> more readable.
> 
> Signed-off-by: Huan Yang <link@vivo.com>
> ---
>  kernel/cgroup/cgroup-v1.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 520a11cb12f4..c082a78f4c22 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -669,15 +669,16 @@ int proc_cgroupstats_show(struct seq_file *m, void *v)
>  	struct cgroup_subsys *ss;
>  	int i;
>  
> -	seq_puts(m, "#subsys_name\thierarchy\tnum_cgroups\tenabled\n");
> +	seq_printf(m, "%16s %16s %16s %16s\n", "#subsys_name", "hierarchy",
> +		   "num_cgroups", "enabled");
>  	/*
>  	 * Grab the subsystems state racily. No need to add avenue to
>  	 * cgroup_mutex contention.
>  	 */
>  
>  	for_each_subsys(ss, i)
> -		seq_printf(m, "%s\t%d\t%d\t%d\n",
> -			   ss->legacy_name, ss->root->hierarchy_id,
> +		seq_printf(m, "%16s %16d %16d %16d\n", ss->legacy_name,
> +			   ss->root->hierarchy_id,
>  			   atomic_read(&ss->root->nr_cgrps),
>  			   cgroup_ssid_enabled(i));
>  

