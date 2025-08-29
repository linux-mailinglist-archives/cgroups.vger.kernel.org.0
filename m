Return-Path: <cgroups+bounces-9490-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CA9B3C377
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 21:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69E981CC3256
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 19:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278C23BCF3;
	Fri, 29 Aug 2025 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S/F/0Ykv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB023D289
	for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497392; cv=none; b=AeKJfYH65A51d6Ll1qF4HvejUN4ezFN6J36NlLcK7zvj5lvv6Glac1Ay0GuOE/WJZOVar49VgoXKw0AFfWfrSHm3ZoYf4/w9BWXJYERM1bVT/C7jyox6OMnyoDomAli40HH+ICc3CEQWdutJnG9SCMPfQgeJDxa81A+iPdfbxYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497392; c=relaxed/simple;
	bh=dfist05fBW0TaZ4Z7JckJFBZ+mUcaLGzirY0CwdQkNA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KNpTzoP9OGmMAcEo38wmZNHHPNnNkhuPFKB/g0fkjwE3D61hN2wY+lpPx9FOBuesicPE74zSG5lKkVAURIK1qJ9OqMgWKKdtyVTYHTBkjKDaR/d1mmtAWql/UF8QE3Gwwk0xGlZPaKrHovYi5EuUaBngmTJBVyiKgLuVuvUJSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S/F/0Ykv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756497388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NWrOzdp8UX+L55QSRJ8fYGBKAQ7vGRfHefsUd0SiDXs=;
	b=S/F/0Ykvu+jaY40xotKHWtse21RicKuNPV4lvYT6yXsCzaALt7QK+3MCqelijape7GAiXF
	t5eK8NNhwjYy/nhxq5SSAni8Ol+k4UUS+7FmvOg0Vfe65O85Da69PlGiu4muTcByKDynEX
	hwPOz/fvd/4ebY57SqbEi2fDyd7qu8s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-1lY1rYKvOru4jjkQ1RCnvw-1; Fri, 29 Aug 2025 15:56:26 -0400
X-MC-Unique: 1lY1rYKvOru4jjkQ1RCnvw-1
X-Mimecast-MFC-AGG-ID: 1lY1rYKvOru4jjkQ1RCnvw_1756497385
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70dd6d2560aso55406686d6.0
        for <cgroups@vger.kernel.org>; Fri, 29 Aug 2025 12:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756497385; x=1757102185;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWrOzdp8UX+L55QSRJ8fYGBKAQ7vGRfHefsUd0SiDXs=;
        b=W8KPiFk6H0HsFIA6Q+MidQySXCf7NJrigqJaTRH6EJEj8Z/kDeLfngIVUxelH9UWfU
         W0GQVTnPXr+RUT8pwndMzubFd9u2MZ9RWaWhdtWSnUtUFCc+GUK5vkkOjhB6/RXquq2q
         lrm+viO3C3zsetU59alqXiczwZTZGfdtpk2L0A96gSQKKPFKd5WTnAwpnEpCaZYlIr7Q
         lu3dwAs3QVoQotelHkSCViqz7Kj4PUB5DuiKBoePiZSDSkoENdouCq4dCgij7NvoBmj/
         XOFSdYTHMUz+Des2SKa8CF9O2T9izUlPqXoIpTsTJaRUYKF6kcI9suyKCYsSMUyalW9s
         Xaug==
X-Gm-Message-State: AOJu0Yz3kaH/6qkJh0HnvD0kzAuPAx7KcewtpIa3wNc/GfhPUGsjYsUu
	DAKmj6TsAKFJJGAGU3HC/VpFuJ/OhdExrQA+WQxXi/ZGVD+9eUsl5ces8rQeqnoq75B8sV8gr/v
	INVlHRI4N2a6pTmjE52Qwfu2fpXJ/62NBvvYElIFxfIzBD8i26vX9z7nYiPw=
X-Gm-Gg: ASbGnctSyF2VL60oY9o3XIhdCywFshbTtlnml6u/CPNO+Aw1uD+KrcIHELwvLp6HRvC
	2IWNkzKk6lAwlxXax80SUSO1EEHmHDKCj/yNtdOQ9eg2pIuJ4mcbZgtWREMUn1Am0VAEsSHRVGg
	5Uo8fKAAnf5GO6GupE15dkbxuDUuO/br/JO9pfEL0yppFp/t//oq06dpES5MA+LOLYvRamwncE0
	/zI+WPfPEZCBMaShXQ8oujxrRYkrg5jZSnCRzKxYmZT2/gJYZol8Xix7qgYM5CYVjzoyHSi5Mzn
	2Dx+rqsqhx5Oetqkml5H/0c8b9NWm3sKAXGax/gKgwkBKiPmTRRCtkHpep/D5Glj8uWNYzqqg1M
	e1NGkBeFCnA==
X-Received: by 2002:a05:6214:808d:b0:70d:a635:2cc with SMTP id 6a1803df08f44-70da635069dmr293243986d6.63.1756497385425;
        Fri, 29 Aug 2025 12:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHSAju9DW3ila94dwjgBIjx9yFjXZrZMlxb9LCSw17FFSqf1l3Y4mWEh0CGl7n96P+uqNgQ==
X-Received: by 2002:a05:6214:808d:b0:70d:a635:2cc with SMTP id 6a1803df08f44-70da635069dmr293243726d6.63.1756497384907;
        Fri, 29 Aug 2025 12:56:24 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70e57e0ec80sm22375726d6.26.2025.08.29.12.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:56:24 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <98eb72df-2897-413e-8c01-7d688ad58810@redhat.com>
Date: Fri, 29 Aug 2025 15:56:23 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 07/11] cpuset: refactor out
 invalidate_cs_partition
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-8-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-8-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor the invalidate_cs_partition function to handle cpuset partition
> invalidation when modifying cpuset.cpus. This refactoring also makes the
> function reusable for handling cpuset.cpus.exclusive updates in subsequent
> patches.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 49 +++++++++++++++++++++++++++++++-----------
>   1 file changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5cfc53fe717c..71190f142700 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2376,6 +2376,40 @@ static int parse_cpulist(const char *buf, struct cpumask *out_mask)
>   	return 0;
>   }
>   
> +/**
> + * invalidate_cs_partition - Validate and mark the validity of a cpuset partition configuration

The function name has "invalidate", but the description uses validate. 
It is confusing.

My suggestion

   validate_partition - Check the validity of a cpuset partition 
configuration

   Return 0 if valid, a non-zero prs_errcode otherwise

Cheers,
Longman


