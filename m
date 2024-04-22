Return-Path: <cgroups+bounces-2652-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65728AD417
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 20:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C47281D07
	for <lists+cgroups@lfdr.de>; Mon, 22 Apr 2024 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93A315443D;
	Mon, 22 Apr 2024 18:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMbmngvd"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28565153BC6
	for <cgroups@vger.kernel.org>; Mon, 22 Apr 2024 18:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811131; cv=none; b=tY5zhYDTnFN6cR08RkfeqMvR5rQTRvfbTWdscJnN7nmUsVzZrdOe1x3DdQnw6z9cXxdRiI7JqImzu8J6LR0HLTxpGecV7/Uyhzd1dNC+ld8i148Uyka5nDnarLDSLiu2dmPIzUOprAEIYUDkz//wl7OQAtLmglCYdIHTUrq7iJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811131; c=relaxed/simple;
	bh=twuLgGtiggTWXRs+LZFj1YP8jXpFbLjDXPzT7EG9VOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDW0qiyL5eg5eJz4qXEOmm7YbEePja4F6bBzz/k9dg1ATIpPiLdwg1MCB3+aC2oouqU6DucjrRyvNFlGu3QSPd/e/P3AW840CjP0XOGISVt5A81ioLHy06iFxddOZWH6a0UQafRWecqiNJrWDnIqBPwxV1avp+l3wuPjQi/sy7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMbmngvd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713811129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOsdhDWuSUFMXxTqd4Lt3sQHh6IbAPnGtwXA6iPfEJ8=;
	b=JMbmngvdFAZg+cHpgvDyinMtBlXOXfp+G2Gibh/YaOJ8j5z0rmUjtjovb0Npf3s6dh4lHA
	Vk6MlKvy6/GompwqEZRawh1Tx4l2sQL0YNvmf6Epj0I4LqvFZwEGgyWPPszp6B+C2sUNRM
	LqtNQJ9bVcAu6s/bM77rzUKkaCA1lf4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-ptsEVJUbNAKkKg-J4OfEiQ-1; Mon, 22 Apr 2024 14:38:45 -0400
X-MC-Unique: ptsEVJUbNAKkKg-J4OfEiQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 390A980591B;
	Mon, 22 Apr 2024 18:38:45 +0000 (UTC)
Received: from [10.22.32.240] (unknown [10.22.32.240])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E1232200AE7F;
	Mon, 22 Apr 2024 18:38:44 +0000 (UTC)
Message-ID: <f2fc2eb8-44e0-4805-86c0-f9062380b3e8@redhat.com>
Date: Mon, 22 Apr 2024 14:38:44 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Avoid clearing CS_SCHED_LOAD_BALANCE
 twice
To: Xiu Jianfeng <xiujianfeng@huawei.com>, lizefan.x@bytedance.com,
 tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240420094713.1028579-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240420094713.1028579-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 4/20/24 05:47, Xiu Jianfeng wrote:
> In cpuset_css_online(), CS_SCHED_LOAD_BALANCE has been cleared in the
> is_in_v2_mode() case under the same condition, don't do it twice.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e70008a1d86a..159525cdaeb9 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4059,13 +4059,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   			clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>   	}
>   
> -	/*
> -	 * For v2, clear CS_SCHED_LOAD_BALANCE if parent is isolated
> -	 */
> -	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
> -	    !is_sched_load_balance(parent))
> -		clear_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
> -
>   	spin_unlock_irq(&callback_lock);
>   
>   	if (!test_bit(CGRP_CPUSET_CLONE_CHILDREN, &css->cgroup->flags))

Thanks for catching this duplication.

Could you remove the check inside is_in_v2_mode() instead? 
is_in_v2_mode() can be true for cgroup v1 if the"cpuset_v2_mode" mount 
option is specified. That balance flag change isn't appropriate for this 
particular case.

Thanks,
Longman


