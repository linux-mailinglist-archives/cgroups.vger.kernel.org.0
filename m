Return-Path: <cgroups+bounces-2651-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C968AD410
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 20:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A3551F21B58
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2869154C01;
	Mon, 22 Apr 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwhdyWs4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182FE153837
	for <cgroups@vger.kernel.org>; Mon, 22 Apr 2024 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713810892; cv=none; b=CWFv2Ixh+/KqI5GBVE+WZQilwAaaJrsymuq0g9I8/sScyWo8rtWhAcKUNfFROAjdMyMb9hRh63zx1I9FamFU9/ThsPN31A8CqVxIprK18OwwjrlaolDigR6g1KRsutNz6sz9IUsGG/yl6Iq3+3x4IBSGR5quRyPqv+AOLnVJgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713810892; c=relaxed/simple;
	bh=qHyu+uP/D6tYcq7d7yU8GqFnJIfU/FEYzQVpzIwder4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5LiSWjyj4lPiDocqEPejk3cLH+59Oz06ErEj3NAuqay+O7e3vexltlrrYu0O/LT/1uBIDO0+3SdEiDFgWfMX4lZp3suqlx58RPIXj7+NdnFAhw6bYKG54aLiCSETPQPowb3JQ2Z4UZkiGaiMbOpoo7rzQWp5iVejzk8LB5pfQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwhdyWs4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713810890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEAqeumfUHtzhzMhX5s4xQkZKWe9CxlywrZ+mXyPh60=;
	b=GwhdyWs4C0M9tGoc28jxavqyCHQFcnLHcX9t2zmFPastRSgcdfskMIaQ17q77aWpOQVHEW
	+vyW2yWjbLUeZxxJONiliHZvmBk1y7HKQUctQphib2hQmu702wf0qItGIEPGAv2eU3lzyy
	mHdrjkAzqNi1Y9jS5xRxOLNMNyM1RX8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-wYztvbUzMgmSbrcjVJQfOg-1; Mon,
 22 Apr 2024 14:34:46 -0400
X-MC-Unique: wYztvbUzMgmSbrcjVJQfOg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB62C3C3D0C5;
	Mon, 22 Apr 2024 18:34:45 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47032581DF;
	Mon, 22 Apr 2024 18:34:44 +0000 (UTC)
Message-ID: <b1a1997d-0af5-4d75-a56c-bf77b2cd0cd6@redhat.com>
Date: Mon, 22 Apr 2024 14:34:44 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Statically initialize more members
 of top_cpuset
To: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240420094616.1028540-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240420094616.1028540-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


On 4/20/24 05:46, Xiu Jianfeng wrote:
> Initializing top_cpuset.relax_domain_level and setting
> CS_SCHED_LOAD_BALANCE to top_cpuset.flags in cpuset_init() could be
> completed at the time of top_cpuset definition by compiler.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d8d3439eda4e..e70008a1d86a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -369,8 +369,9 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>   
>   static struct cpuset top_cpuset = {
>   	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
> -		  (1 << CS_MEM_EXCLUSIVE)),
> +		  (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
>   	.partition_root_state = PRS_ROOT,
> +	.relax_domain_level = -1,
>   	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
>   };
>   
> @@ -4309,8 +4310,6 @@ int __init cpuset_init(void)
>   	nodes_setall(top_cpuset.effective_mems);
>   
>   	fmeter_init(&top_cpuset.fmeter);
> -	set_bit(CS_SCHED_LOAD_BALANCE, &top_cpuset.flags);
> -	top_cpuset.relax_domain_level = -1;
>   	INIT_LIST_HEAD(&remote_children);
>   
>   	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
Reviewed-by: Waiman Long <longman@redhat.com>


