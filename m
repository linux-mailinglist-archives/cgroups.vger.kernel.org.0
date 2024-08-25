Return-Path: <cgroups+bounces-4441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8618895E48D
	for <lists+cgroups@lfdr.de>; Sun, 25 Aug 2024 19:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6D9E1C20912
	for <lists+cgroups@lfdr.de>; Sun, 25 Aug 2024 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43033156225;
	Sun, 25 Aug 2024 17:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T+UcEHdZ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675F5372
	for <cgroups@vger.kernel.org>; Sun, 25 Aug 2024 17:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724606769; cv=none; b=Snw4P1Y2DH+eH/AgNFKg3m2//u021M913gimMBQd9r36RkALOHa1XEnWz9uZMy7E1iMiQUmi6EP5Gxc/e6RfPVAeTXSvjj1NZC79qpd5FOh0UbzZ5tXWi6DInTqIhCqli+RVZ46xla0T9M+g3BZ6clh/f6UQSenBdQWwYdu/L1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724606769; c=relaxed/simple;
	bh=qexQVZlga6yQl6Rkf/uUCJRkFg59IUXsck2oFm/nPZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYB5nGKq2rGylaT6Y2bVdqnq6PNCt8ZELQLkmSAv3acCkTWQQ40PwKk4m3S3iV2gDSlA27zd8fwj0rQJrGA9jn40yAiqF+T8tjvlIbX6ifyrOWbuUDdCwdVB5QIY2F0LILN7ZBGdfPver0hoxW7oii/LZBzkL+5xgJ+4a2ZCet8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T+UcEHdZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724606766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EiCBagGzLZyRyGUFxhlgt0yU50B01FDyehsuvW/QXCA=;
	b=T+UcEHdZCKxjLt7pwo5aI3kUNbD3MA+rZaW94keNjLEcvIyf/aFLs5ota1bffwXITRpc0d
	nra1PsVbtigydPY69caRLVn1P6BY119LexAtg06gmYw7Rg6zYgg6DiWqpjKnK61PUV5sKo
	CkHA6qATy79o4Qrj6cGAlrn/Xa0yNyY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-O4aK9X43P1S7fI_lI8-gKA-1; Sun,
 25 Aug 2024 13:26:02 -0400
X-MC-Unique: O4aK9X43P1S7fI_lI8-gKA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F58A1955D4A;
	Sun, 25 Aug 2024 17:26:00 +0000 (UTC)
Received: from [10.2.16.7] (unknown [10.2.16.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 56BB219560A3;
	Sun, 25 Aug 2024 17:25:57 +0000 (UTC)
Message-ID: <de64f686-fccb-4d33-99d8-b8b44dc534fa@redhat.com>
Date: Sun, 25 Aug 2024 13:25:57 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 -next 10/11] cgroup/cpuset: guard cpuset-v1 code under
 CONFIG_CPUSETS_V1
To: Chen Ridong <chenridong@huawei.com>, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240823100110.472120-1-chenridong@huawei.com>
 <20240823100110.472120-11-chenridong@huawei.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240823100110.472120-11-chenridong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 8/23/24 06:01, Chen Ridong wrote:
> This patch introduces CONFIG_CPUSETS_V1 and guard cpuset-v1 code under
> CONFIG_CPUSETS_V1. The default value of CONFIG_CPUSETS_V1 is N, so that
> user who adopted v2 don't have 'pay' for cpuset v1.
> Besides, to make code succinct, rename '__cpuset_memory_pressure_bump()'
> to 'cpuset_memory_pressure_bump()', and expose it to the world, which
> takes place of the old mocro 'cpuset_memory_pressure_bump'.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   include/linux/cpuset.h          |  8 +-------
>   init/Kconfig                    | 13 +++++++++++++
>   kernel/cgroup/Makefile          |  3 ++-
>   kernel/cgroup/cpuset-internal.h | 15 +++++++++++++++
>   kernel/cgroup/cpuset-v1.c       | 10 ++++++----
>   kernel/cgroup/cpuset.c          |  2 ++
>   6 files changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 2a6981eeebf8..f91f1f61f482 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -99,13 +99,7 @@ static inline bool cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask)
>   extern int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
>   					  const struct task_struct *tsk2);
>   
> -#define cpuset_memory_pressure_bump() 				\
> -	do {							\
> -		if (cpuset_memory_pressure_enabled)		\
> -			__cpuset_memory_pressure_bump();	\
> -	} while (0)
> -extern int cpuset_memory_pressure_enabled;
> -extern void __cpuset_memory_pressure_bump(void);
> +extern void cpuset_memory_pressure_bump(void);
>   
>   extern void cpuset_task_status_allowed(struct seq_file *m,
>   					struct task_struct *task);

As you are introducing a new CONFIG_CPUSET_V1 kconfig option, you can 
use it to eliminate a useless function call if cgroup v1 isn't enabled. 
Not just this function, all the v1 specific functions should have a 
!CONFIG_CPUSET_V1 version that can be optimized out.

Cheers,
Longman


