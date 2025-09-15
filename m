Return-Path: <cgroups+bounces-10119-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF511B584E4
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 20:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 192957AFCB5
	for <lists+cgroups@lfdr.de>; Mon, 15 Sep 2025 18:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15572D0622;
	Mon, 15 Sep 2025 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ikz5sfxv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0227AC2F
	for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 18:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961891; cv=none; b=B6cC1vEB14bCHuh+6hNyub22CG1adsgr2SJSXcgKqHEaBxY8TWSGTEpFfxnTIpmv12tUm6aWQKwhHF4HYZ89NjknOp4cGfUh7FWN3UCU0Q2V4QAv+1AeTTeSJIvAR1xopgfnOrLiAAYhaO2ZtX/Dq7h1GG7LUx3bmnJZeiFogdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961891; c=relaxed/simple;
	bh=siF+cUJ0MXDi9fG9kS1S5oPOWHY/N4+AU9C3uXhgSS8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FuNEVyLEGLQXjJc+/4Dr9No0CSi+EsKdd+uOO7x3m9Cku/M7zNq7Mo4Th/iOhX7xXhIQLeS6TUhDLfE5z8UP67V8wuQJXpkCBieCPETVeM6qGDuQTl7ldydzBFQPsdt7NQzRm/04jwUwUKx0L6s0yGdCPtq/Q1uAwNUOxfMUXVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ikz5sfxv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757961889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYas1KhB09Rxb7ocj6C9fOFj/tEHQDmFrrWYj7yINyE=;
	b=Ikz5sfxvHHD7Tw+nWTP8BD6eL/gbiamPtGj/ReStx6v3ffKjnqi23j0Y1Aj0anxqZjrOY2
	mLq9L6u7f7UQNtIuWkiJIQ9nGdIktr7biTni10lcj7IDE8kkJSfoZn3NQntgfBWspmehmT
	pQl1aju9nX08rD3uc2TtqdyVEu+Uy+k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-WFHqFxXhN-yzeZT1LaEdDg-1; Mon, 15 Sep 2025 14:44:47 -0400
X-MC-Unique: WFHqFxXhN-yzeZT1LaEdDg-1
X-Mimecast-MFC-AGG-ID: WFHqFxXhN-yzeZT1LaEdDg_1757961887
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-777fb17fd83so39963326d6.2
        for <cgroups@vger.kernel.org>; Mon, 15 Sep 2025 11:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757961886; x=1758566686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYas1KhB09Rxb7ocj6C9fOFj/tEHQDmFrrWYj7yINyE=;
        b=jGOLvSvhASQ0boCrPTsrCfqEOwf/Y3sxSWcseRIeZZAbBXT7ABrFEHQ2+2S1grhH4m
         GyoYEo6cr/QUYZrCfGDSdy9qEx7fwAXouiIJoEaZqtM9ZQRYOWeuwxiqdAQQ0aITeBe4
         Lg/d/LryL6lWzAkfZHWDWerRoheOpQrvY6y0jg+klO+wMC/V/UYrSEhNKwTBC9kUw6p+
         uUCj7Q5bwM3AmLBVxfJUglnuWmEB638Io/yNLHKbKCFddlGt/58hU+0+Cqt2tFOXt8uc
         t6GkxLig0OwE3iWPnO2Fudae+HmZBS9lMc0raYNdio83sJc6j4+W5kKuXHuQiIfVMd5k
         0KGw==
X-Gm-Message-State: AOJu0YwmPbwco/MygWaReEprJk1x8aUHLHt3hH4q/TwUTxkzIV1jNB9o
	n0MlVDTJO2hO7APuN24GaKaVwmuqGylGAT/Txy4a1oWGVjcCy3Rpwz9iMNkLnnqi3sJKf7IyOlq
	B076oIqMpSHT4liBebMU6Fzh7tmQMf4SjLS+uHH4h6AQ3sSkKkxdMzQrpETqySGtOuMY=
X-Gm-Gg: ASbGnctcdzEMhgxfupABLn3iIv08GpxVJIjGrOTffst8cSL7jgNAzEk6qjjPRt5//O7
	ewgqMc279XTUOXUAem1tKtCeGUrzBtP5VfDecTV01EJKRKmDPwBUroJUjUTjz9p6Tw3DODC7hxE
	c3vzyAH7nuHD5tjlB9Y6NLF3xkjmNW1W+i7PhOZ9EL6r6f71NJsj//DQ+/wHKxENOKAJW4pH39C
	tUXecwp4s0OX4da+xz8c+orsTFHItOT4Sa0Gkwfw64gMuvKFx9v/KkwDK+ky+qke4GEbTvMxTcJ
	XwjH2dTDRjodjL5U+i+hDlN2yL3ueIR2Qv7G6r29q8YJg+vmvUzRwOHm3g/ZcKFUwj1VP/Loqu/
	zzWvUpqg9DQ==
X-Received: by 2002:a05:6214:1d24:b0:766:3902:b9ca with SMTP id 6a1803df08f44-767bc5e5138mr192434186d6.25.1757961885857;
        Mon, 15 Sep 2025 11:44:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt6VhgCUr0JQtHHuL07FrOdDlBOUWjL2CkXjgKYoyEtglTMKJ54UdEUm2p0M7XKMORlJ6TXw==
X-Received: by 2002:a05:6214:1d24:b0:766:3902:b9ca with SMTP id 6a1803df08f44-767bc5e5138mr192433796d6.25.1757961885459;
        Mon, 15 Sep 2025 11:44:45 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-778d99113d1sm40448006d6.68.2025.09.15.11.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 11:44:44 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <94219ba5-d0f7-4c2c-8d82-daffb1d7d151@redhat.com>
Date: Mon, 15 Sep 2025 14:44:43 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 03/11] cpuset: change return type of
 is_partition_[in]valid to bool
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The functions is_partition_valid() and is_partition_invalid() logically
> return boolean values, but were previously declared with return type
> 'int'. This patch changes their return type to 'bool' to better reflect
> their semantic meaning and improve type safety.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d21c448a35e1..a31b05f58e0e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -159,12 +159,12 @@ void dec_dl_tasks_cs(struct task_struct *p)
>   	cs->nr_deadline_tasks--;
>   }
>   
> -static inline int is_partition_valid(const struct cpuset *cs)
> +static inline bool is_partition_valid(const struct cpuset *cs)
>   {
>   	return cs->partition_root_state > 0;
>   }
>   
> -static inline int is_partition_invalid(const struct cpuset *cs)
> +static inline bool is_partition_invalid(const struct cpuset *cs)
>   {
>   	return cs->partition_root_state < 0;
>   }
Reviewed-by: Waiman Long <longman@redhat.com>


