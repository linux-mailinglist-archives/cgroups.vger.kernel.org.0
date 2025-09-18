Return-Path: <cgroups+bounces-10268-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB2AB86634
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 20:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373D4485929
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 18:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2342D193F;
	Thu, 18 Sep 2025 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uqwk0vNX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A22D1308
	for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 18:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219042; cv=none; b=S1O5jMQq21BNIJdC5SPCNn79GWdRAagvIVejJLhDjloe+T1fqzie8XjdATuCxTVddEa32E9D9QFV70HZlY0mSYyt0hpEULkB/41PQoMhPpyspJXQBLVSRSKlpTLH4M4yix/uGSf8Kb5ZsJeEexwxfw6u2/5RAYY5PvPRLzh5kpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219042; c=relaxed/simple;
	bh=G11DW+dxDZsRwBrASQuWanHM5C6C3pq8YdaEHXpqd2k=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IbjNIzUVW9JVATAjljVye2803Rcp2LJrWvZ1rN2JEq7iWeCjppV9w7J/ijeJKhlIBFrIDAjZ/ZT0inKtBEwCS1I1E9EBhza+cMo4A3MtMhNgXKGabslyk4KjUnpw5g0TgZq/2tXCLnO3fHVpblefM5jWW1c4E7qey3jEJfXftcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uqwk0vNX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758219040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vr089DtKU6BHFhoOnacLG5H/uMQfTGq5wqyv/jSw24M=;
	b=Uqwk0vNXhn3qY6e9biV3s+bI26XaP0G8/PnrLIAGVOSL0/iRl8Poi4m59k3IUdibjHPGMN
	Uq5D5JheRyyYukcEM/ebqXgu9Y4/VDSetz+rsonrSsqqsj9jIuHkk7/Z54EHzJt7it4T6W
	018RpnxmelZYT/DMsZp097WjdU6a9qA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-4Svh8AEUOZ255yZBpw_G-Q-1; Thu, 18 Sep 2025 14:10:38 -0400
X-MC-Unique: 4Svh8AEUOZ255yZBpw_G-Q-1
X-Mimecast-MFC-AGG-ID: 4Svh8AEUOZ255yZBpw_G-Q_1758219038
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-79390b83c48so21720546d6.1
        for <cgroups@vger.kernel.org>; Thu, 18 Sep 2025 11:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758219038; x=1758823838;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vr089DtKU6BHFhoOnacLG5H/uMQfTGq5wqyv/jSw24M=;
        b=m99DHEzhpyaNACQbboBqvOQ9rhZVLnxhLPn8E3eC8vsv0Lhbr7o3eubeEJmMhmmo5p
         VeBFchxwh9ia8TwxaNziC5H7qLqSL5N/RRg2gDZEJMd90zBrQgF3GMuboZiFbdlj7Us+
         TmQbNaBzhoVMYOVL0d3d4uolzDVJe/3G7ICEcTFjJkfZc0pkIhBd45Tq+uu5m3Q1rl1T
         D1st7L0EUXYLUutKT4Z5jKgexvvtk6a91KT55JkDzEexhNl59HTNAR2B019YmnAg5B31
         OExqwHZsJUYyYGf13LRgV5/FEBWXLEYXa3Hr9LXIRmMDclEfmOyxdObaqk7ShTS6wsnA
         xNrw==
X-Gm-Message-State: AOJu0YwXrXt3HmDBtpZvYU58jbonIV1YXoJkD4Pa11YT4J0ZvUMtBHoB
	q6+ZD0NJMAJp1hRg9IsAYDnHtv/Q8tirQPYS3AAWgPHrIMg8oCCNYCj2oveKPITjtsGzCURCqlo
	otHCKxzk2kM7utoLHjvi1FzJbjjvu+/fXU4s2vBpEjIsH35h0lw8I1UlIHGU=
X-Gm-Gg: ASbGnctwlIfJhMh/zfDAWRuuE9NH+WQsc8u4RFykkc+RTOl+5UsXjRmABo+nzrHRw9V
	HNoKUREASZbpoE9R71QIXTOUEMVWRnN8UnZHLzF8HtG9uUxGiyfK50bFpf0w/waThL3phpa5vlz
	5RdlkzVsCrRVHbiWHeEakNNA8blrPjpYYGVTMlDXn372JK+0cANn7rn5b7wlKenk0Pk6sKimX8p
	VBUbup0vrPKgdmWQf83V4hNTEEsQ1yLobEdYik8INkRoJ2QH8JODblBK1vV/zVCof/eSrr7EFYo
	rIDuXzCqq3Cu2d5d4TzJ7D/bg+FADZ/GrokcuB97q1EpXN1grpj4fbEAEiP0mvsmYrMddHtwVlZ
	q6nBn7kmf6g==
X-Received: by 2002:a05:6214:1945:b0:77d:6920:f855 with SMTP id 6a1803df08f44-7991d54f01fmr3749926d6.57.1758219038095;
        Thu, 18 Sep 2025 11:10:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEkKmLDocDew++syyxMKDilcYw/Xs5yWPD3DVBHZ2sTHpZvWqF9ALgzSZJhNk93MzijvYLAQ==
X-Received: by 2002:a05:6214:1945:b0:77d:6920:f855 with SMTP id 6a1803df08f44-7991d54f01fmr3749546d6.57.1758219037715;
        Thu, 18 Sep 2025 11:10:37 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79337bc5835sm17034806d6.0.2025.09.18.11.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 11:10:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ea6c57fa-4e44-45ad-9219-09bc60acea26@redhat.com>
Date: Thu, 18 Sep 2025 14:10:36 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH cgroup/for-next 2/2] cpuset: Use new excpus for nocpu
 error check when enabling root partition
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250918122532.2981503-1-chenridong@huaweicloud.com>
 <20250918122532.2981503-3-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250918122532.2981503-3-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/18/25 8:25 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> A previous patch fixed a bug where new_prs should be assigned before
> checking housekeeping conflicts. This patch addresses another potential
> issue: the nocpu error check currently uses the xcpus which is not updated.
> Although no issue has been observed so far, the check should be performed
> using the new effective exclusive cpus.
>
> The comment has been removed because the function returns an error if
> nocpu checking fails, which is unrelated to the parent.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 2b7e2f17577e..44d65890326a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1818,11 +1818,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>   		if (prstate_housekeeping_conflict(new_prs, xcpus))
>   			return PERR_HKEEPING;
>   
> -		/*
> -		 * A parent can be left with no CPU as long as there is no
> -		 * task directly associated with the parent partition.
> -		 */
> -		if (nocpu)
> +		if (tasks_nocpu_error(parent, cs, xcpus))
>   			return PERR_NOCPUS;
>   
>   		/*
Reviewed-by:  Waiman Long <longman@redhat.com>


