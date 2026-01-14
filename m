Return-Path: <cgroups+bounces-13226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B89D2195D
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 23:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE6FD30021FF
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 22:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441BA35CBB2;
	Wed, 14 Jan 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZV7F+9/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="edv2SkkS"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981923A9016
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430006; cv=none; b=ul5wxBPYez4ShKt/wBEcNb9wbbFH7JlUn8x2NmJqLfhuCpyivwXHsNASfqHWkcvglL26zP6kzLXkgHI8W1ho1FM264JovCjDKaBBtbEzXqFYJ2LWvn00CbVOACvwhAPuC31vWCc4uLnM4SnCQPx8SqYHwQN9PbxWS9HjHzw42r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430006; c=relaxed/simple;
	bh=MqRy376XtfMamcKnhdgxmeFprufyaEvjRoSNVz+Nu4I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VgoAHX0MtqLetjFN+BrDFutIZCyLkvCef6sToV9i7Qkeuo+3kMijm52PhbINn4XOwddWGPret3O1D3dJg+GqYA5MF0Th/wYvknatJAODTTBKHTrP1/Jy2VfI3faVHXvWqc0EFa5QVd+Ky7wLOFXMNFi3WU1FCz7bzlFQz6EjfSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IZV7F+9/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=edv2SkkS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768430000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bw+UUbbgHuxkE1SVwjm6zfIO4qzzzhxSHIjHJSRD/NE=;
	b=IZV7F+9/6H0UgDa4BdnVaC+7HuBp573RtJH8EFgAkGBZJDC9Hie7nyVqCoyeY2Ev1TiLWE
	byw+Am415CMeonrawYQlEbp5bLRxgZ3pnl5BTvW5iW4F6AroUxmPE2yoJBvCwWnP6tnK/b
	iO2CRBlVj0uVaJREMXTswRVNbGQxW4E=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-ZD7fYQ2EOUOk7UFgbuT8Cw-1; Wed, 14 Jan 2026 17:33:18 -0500
X-MC-Unique: ZD7fYQ2EOUOk7UFgbuT8Cw-1
X-Mimecast-MFC-AGG-ID: ZD7fYQ2EOUOk7UFgbuT8Cw_1768429998
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5ef6db225e3so275453137.3
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 14:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768429998; x=1769034798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bw+UUbbgHuxkE1SVwjm6zfIO4qzzzhxSHIjHJSRD/NE=;
        b=edv2SkkSuyjfSaWUa/c045BnezXnXz+SceehPrUxM2BaD0nqyo8l18wKnmuiPT9wbe
         NEjzYjzZf3Y24KGMwYHwOAh8oNZp+V9mqUDttZ53wr5+gN3k/KpMOia54YzUnXsGG1gQ
         wHyjrwE+mumIFVUJDmdwG5H5OFERlJvZaCBbowNZeHNNQ1JgaU/QcwMyPlDakEaVfoRX
         p7lFsuIFBLcZaUNbR3c8KVSI2816HbjDvRHFk3gEfkqtXUThRRN7ukGXOVIp882PJpNG
         uQ3Pa0c6mBjJQNubPF6OL/OWErwO7vIlmji3MweJ6M1QocjeUJUZThrb5fq5OExT30n2
         ktFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768429998; x=1769034798;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bw+UUbbgHuxkE1SVwjm6zfIO4qzzzhxSHIjHJSRD/NE=;
        b=qgOyrWRStU0VWb3dYYkRU71c8w9mjTISRt/e7bjo0ZY8nYRvyjXk2pVMnn3Fe8PHte
         nKjiQbH9ZX3Ustr4xQvXV0DV40DJeTmm+Aqg+8KiHtrirnGfu1poDvmZ4pztQreCWaUb
         YK6uA5Ytx9B9EPP6j2rUVf+fcLyfovIcZ0EwGvUNuGRjvIaUiB4SedKGh8V6PjGcpJuH
         Q+JMvH4KA/aZnHTCfvH2AVIAfS6yHBmJszGRwE18Ki2yPjFIqSIQYw0CkEdJNIv4PSQZ
         rOOC/sExQRiGp36hC6y3R0K3EtqKaq6DfT+AZWbYvMlUW5u7EbFFNuEDhY+0CwHJaYGZ
         2nQw==
X-Forwarded-Encrypted: i=1; AJvYcCXb1WgE5gjrEz2iqujv0+BC5XkRRDtel1lAPbtVGjjK6O/OOzrk0BIClfy9SFDb+qUfB/7w7WOH@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWM1xjz+NynnJhLYgS/jRLLIqz8Hcse9NStZ+tiQvrDFBWtXI
	GNGty1nKbD/i49Ad1TnIF84OxDu8YNE0ujGmsmVFuX0/3PXA6TA1wXl6W2ZHIX6QAnD9sYGRpSv
	ubYUEGgdyYwtnGAemVM/4aE2QORk+sZ7sAbHjRzlJimd8wdFiqS9Opda3Ohg=
X-Gm-Gg: AY/fxX5lnYcrUjyVlMNdsBah9nXG9tsPctpU1UmPmWft8RZlW2vmg3O19dbCvzKhHPD
	b8FnxkbH69d7kzZGmqUKIElXXSuU5MRBoSjocaUgQh6xZyBN0X85ouh4MzjY4m9evntuBMjQyK6
	04Xyl6GzjhcCSIoXuLMoAQqaaTliqsZ+4Me8hTZAfstUV4Ve2N92okedAYGp4LF2JhrbjnSTy4P
	jM1dO5yh1TUrTehF8QIeEAmRqW6a+/1I+oShdSrlx3ux4oPfjP4u4fOW8Pd/BvIS0beUfwspjCr
	ob/i71/wdrwiJIs+gxXkKVLW1MKXKMNVEFCEzJELgT1q0dl/6/6fMdeM1jP6Ko6RJkVW1XohrkL
	v2FPvO1D8zBtHmJKnch2XtRkWxXQ58//eZdsR7rKwkJzyqkNv5x45J9Ms
X-Received: by 2002:a05:6102:5801:b0:5ee:a184:35c8 with SMTP id ada2fe7eead31-5f17f638b15mr2072342137.30.1768429998160;
        Wed, 14 Jan 2026 14:33:18 -0800 (PST)
X-Received: by 2002:a05:6102:5801:b0:5ee:a184:35c8 with SMTP id ada2fe7eead31-5f17f638b15mr2072327137.30.1768429997810;
        Wed, 14 Jan 2026 14:33:17 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-944122ae554sm23610471241.2.2026.01.14.14.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 14:33:17 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <51675d7c-5c9d-4596-8e5c-692c90b79e06@redhat.com>
Date: Wed, 14 Jan 2026 17:33:06 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] cgroup: use nodes_and() output where appropriate
To: Yury Norov <ynorov@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alistair Popple <apopple@nvidia.com>,
 Byungchul Park <byungchul@sk.com>, David Hildenbrand <david@kernel.org>,
 Gregory Price <gourry@gourry.net>, Johannes Weiner <hannes@cmpxchg.org>,
 Joshua Hahn <joshua.hahnjy@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Matthew Brost <matthew.brost@intel.com>, Michal Hocko <mhocko@suse.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Ying Huang <ying.huang@linux.alibaba.com>,
 Zi Yan <ziy@nvidia.com>, cgroups@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20260114172217.861204-1-ynorov@nvidia.com>
 <20260114172217.861204-4-ynorov@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260114172217.861204-4-ynorov@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/26 12:22 PM, Yury Norov wrote:
> Now that nodes_and() returns true if the result nodemask is not empty,
> drop useless nodes_intersects() in guarantee_online_mems() and
> nodes_empty() in update_nodemasks_hier(), which both are O(N).
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>   kernel/cgroup/cpuset.c | 7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3e8cc34d8d50..e962efbb300d 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -456,9 +456,8 @@ static void guarantee_active_cpus(struct task_struct *tsk,
>    */
>   static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
>   {
> -	while (!nodes_intersects(cs->effective_mems, node_states[N_MEMORY]))
> +	while (!nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]))
>   		cs = parent_cs(cs);
> -	nodes_and(*pmask, cs->effective_mems, node_states[N_MEMORY]);
>   }
>   
>   /**
> @@ -2862,13 +2861,13 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
>   	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
>   		struct cpuset *parent = parent_cs(cp);
>   
> -		nodes_and(*new_mems, cp->mems_allowed, parent->effective_mems);
> +		bool has_mems = nodes_and(*new_mems, cp->mems_allowed, parent->effective_mems);
>   
>   		/*
>   		 * If it becomes empty, inherit the effective mask of the
>   		 * parent, which is guaranteed to have some MEMs.
>   		 */
> -		if (is_in_v2_mode() && nodes_empty(*new_mems))
> +		if (is_in_v2_mode() && !has_mems)
>   			*new_mems = parent->effective_mems;
>   
>   		/* Skip the whole subtree if the nodemask remains the same. */
Reviewed-by: Waiman Long <longman@redhat.com>


