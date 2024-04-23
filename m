Return-Path: <cgroups+bounces-2665-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ADC8ADC09
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 04:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDD61F229E4
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9C017C6C;
	Tue, 23 Apr 2024 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X39HqP45"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D413FF4
	for <cgroups@vger.kernel.org>; Tue, 23 Apr 2024 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713840816; cv=none; b=Wbqp8k4Kx0d0LJlaLfjdwmQyAcW2EWzK8zAarOGABtKj1WhRn2RByFbhIxVwOAyW69y9PUXF6QN21xWkeB4L6vOg6+3dCS9ETE8byxXMH1AsigU3LLQqCi7wQHLPYu3jb4LD6te5P922ZCH9qDu9hD1YK4yVRPIW4Past3+66co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713840816; c=relaxed/simple;
	bh=hUy2NwK4SfQ20dn+seKulwjQP7VZkvebQQGsFBI5Nhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xq5pXmVWWTQLKXpDfdAeI4V1ZnhBW6WtBg1OYv+P6BikP0PO5y6XVVPmXSY21KEG1LXzqc9HY2FCLRs2I2vnjfTDB6We8Q0kQJUAuClWvst6RtThEA/Y4mo8+iNf12Y6PxvSPlUqpDp9uZpJchE2aDkc6vmItZBUjJlT5Klq5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X39HqP45; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713840813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vHHK5+Fqa6ZKdYDjyl4I1FINs9qOnFj81l/KGssjU38=;
	b=X39HqP456A+WwwBey6bZcP0dmhtO1gcOiaJl1ayGIj5QpiA2M/2emLjkwyjqvKMaQamshG
	mZNqf280xfVKYJz+3NUXY/yXXTH/7x2j10OvDL/9kGjE+JNqY4P1JLFIohGQVk5ylH+dGI
	mZ+6PVraDAlIbIQ1HApcr52RiCj5EMw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-GyatvBUCNXakD_kWV3bhqg-1; Mon,
 22 Apr 2024 22:53:31 -0400
X-MC-Unique: GyatvBUCNXakD_kWV3bhqg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DDE3382C469;
	Tue, 23 Apr 2024 02:53:31 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DA80E2166B32;
	Tue, 23 Apr 2024 02:53:30 +0000 (UTC)
Message-ID: <fd806ed3-372b-4911-838d-975f3aeef1d7@redhat.com>
Date: Mon, 22 Apr 2024 22:53:30 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 -next] cgroup/cpuset: Avoid clearing
 CS_SCHED_LOAD_BALANCE twice
To: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240423024439.1064922-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240423024439.1064922-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On 4/22/24 22:44, Xiu Jianfeng wrote:
> In cpuset_css_online(), CS_SCHED_LOAD_BALANCE will be cleared twice,
> the former one in the is_in_v2_mode() case could be removed because
> is_in_v2_mode() can be true for cgroup v1 if the "cpuset_v2_mode"
> mount option is specified, that balance flag change isn't appropriate
> for this particular case.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>
> ---
> v2: remove the one in is_in_v2_mode() case.
> ---
>   kernel/cgroup/cpuset.c | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d8d3439eda4e..bb9bf25889c9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4051,11 +4051,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   		cs->effective_mems = parent->effective_mems;
>   		cs->use_parent_ecpus = true;
>   		parent->child_ecpus_count++;
> -		/*
> -		 * Clear CS_SCHED_LOAD_BALANCE if parent is isolated
> -		 */
> -		if (!is_sched_load_balance(parent))
> -			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	}
>   
>   	/*

Thank for the v2.

Reviewed-by: Waiman Long <longman@redhat.com>


