Return-Path: <cgroups+bounces-2687-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544AF8AFD8B
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 03:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B261F239E3
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 01:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21E4405;
	Wed, 24 Apr 2024 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KW4k7kxC"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E44C4C81
	for <cgroups@vger.kernel.org>; Wed, 24 Apr 2024 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920584; cv=none; b=cR+UpD7VPZ9oT+4sW8Wm5Qr+YqygHxoawNA+DTqaeZ5b48Dg6HnOkDrP5+UxivLCFJzRD39OPxxA06KoLFjoi+j2/bl32ahBSGSVacvZa7ho1vhkPaW1XQMkFNbIh3VIdanNIF38+yrniCzwHlTdVYMB74albROYyBk1ByNB5YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920584; c=relaxed/simple;
	bh=tNKWNbI0np7zXIODuEqzXD8xRS0Z9uSzOdo7JjMPDP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSct6tvovciHiqhikaMckhW4QR53Axhv518S1p8U1Wp/2ME/hgIJYE1Ma3zI+lMpmetAJfuen/fJDBFuUkAMIPO3e9eR12zcJQvGZLwQCX/UhN5MC/Ahhwu3SM6w6ytT947ZP6bit1JIqbO42GSQOL26EpLGOldRJIg53lAJj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KW4k7kxC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713920578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aox3o8ECNJWZ0A+Nhw6alI9wWjGPPciBpMH2m54sKuQ=;
	b=KW4k7kxC4g67QqWRwO+UpZe15Y4VE0RfACXoDTgYyl2V+L48DsNt33er7e6ALdardEZwKK
	1frQbVxLFZOrRIGhx2lKkUq8JWXGeV8TiL4jfbmsK7X1jmVfPajnhX6yMGDB++u30xP7Qn
	xRUcQnoggPZxZZc9paY4us5ikm9e4co=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-92Usn8jZNByrAGrImVyw1A-1; Tue, 23 Apr 2024 21:02:53 -0400
X-MC-Unique: 92Usn8jZNByrAGrImVyw1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94B7A8032FA;
	Wed, 24 Apr 2024 01:02:52 +0000 (UTC)
Received: from [10.22.33.184] (unknown [10.22.33.184])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4A2DD49102;
	Wed, 24 Apr 2024 01:02:52 +0000 (UTC)
Message-ID: <5c5089de-311c-4563-b534-2340e328a5ee@redhat.com>
Date: Tue, 23 Apr 2024 21:02:52 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-cgroup] cgroup/cpuset: Fix incorrect top_cpuset flags
To: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Xiu Jianfeng <xiujianfeng@huawei.com>
References: <20240424010020.181305-1-longman@redhat.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240424010020.181305-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1


On 4/23/24 21:00, Waiman Long wrote:
> Commit 8996f93fc388 ("cgroup/cpuset: Statically initialize more
> members of top_cpuset") uses an incorrect "<" relational operator for
> the CS_SCHED_LOAD_BALANCE bit when initializing the top_cpuset. This
> results in load_balancing turned off by default in the top cpuset which
> is bad for performance.
>
> Fix this by using the BIT() helper macro to set the desired top_cpuset
> flags and avoid similar mistake from being made in the future.
>
> Fixes: 8996f93fc388 ("cgroup/cpuset: Statically initialize more members of top_cpuset")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/cgroup/cpuset.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e70008a1d86a..b0a97efa5f20 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -368,8 +368,8 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
>   }
>   
>   static struct cpuset top_cpuset = {
> -	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
> -		  (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
> +	.flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
> +		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>   	.partition_root_state = PRS_ROOT,
>   	.relax_domain_level = -1,
>   	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
Add cc to xiujianfeng <xiujianfeng@huawei.com>


