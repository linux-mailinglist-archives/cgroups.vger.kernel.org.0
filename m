Return-Path: <cgroups+bounces-5334-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F79B63DF
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 14:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B15C1F221B5
	for <lists+cgroups@lfdr.de>; Wed, 30 Oct 2024 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FBA1EB9E3;
	Wed, 30 Oct 2024 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ijCNjJMl"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA791EABD8
	for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 13:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730294189; cv=none; b=ElBna5kzJQoVRu2iQ6PnVY2H9F6QML3EamgNNmiXUZ0wIQ+hNZVVDsWgK3SQRtFPK/r8wUmucMf8MHQMj2cOvgwOusQP8T5EsxE2/+3CY+p+V5Xs55GCYmAycSAeKw1eTqycn3INsScV8+XzbO1ttOSW9t0gAvd8jXIyqowamUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730294189; c=relaxed/simple;
	bh=5iYnWc8olwUCtLtsdseFg837IfVYaFUXNV+VUmKVhy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOm4T6sepwFl/EhIZMpLVKqRpSyFcCSd1P6vmZadZu7gjBCSVmrzjUxkESs6VgKfoXglZvOwWykcx1TnERclIW5xwr78POk4kqY/h6+CXm94zSk3a4rQ3idYQnt+UVEGxrtbO74wWDvUmyZUOQPvefsppoa2aiHOiATSUvKwX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ijCNjJMl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730294186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IyKhuqsSDcqnKMuJnkkv0Uvk/jZHuO+vYC1KChJ/OYI=;
	b=ijCNjJMl2EWtgzeMBwi8Bhv0vp7ZkgOIAj/fvt+F8E7V2gGr+MKj789iymMdDayV4rdGjl
	gQb+CYDa3axh58DO7XgGSWTw9oBwPY4XAAZQVqgPjGr0giaR2ZgeXmVzrJYxZud5zY+Csc
	aHeAXpi+vzb7TSv57cPKstGgF9NG6l0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-Yr9xTnKrOiCVMx4PTAISbQ-1; Wed, 30 Oct 2024 09:16:24 -0400
X-MC-Unique: Yr9xTnKrOiCVMx4PTAISbQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539ea3d778dso4802623e87.1
        for <cgroups@vger.kernel.org>; Wed, 30 Oct 2024 06:16:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730294183; x=1730898983;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IyKhuqsSDcqnKMuJnkkv0Uvk/jZHuO+vYC1KChJ/OYI=;
        b=TF044dviG6efq/IEDOrU+WxW4sFwKKpMxhKgUYT4ETD2N14SBn23Q0lYSCw0hsTArn
         1Eq9do55Rr+UQeU3ohjsCzntTDs9sGUCqHtrEnF5AVoSgzqH5YNmd7XuN6K+m0hEdZi5
         oJrSy2b76JwQLy/50i+mAUadPsVtM3mspyOdVvboCORO3pm1dpe0oIh73EaxQ2QLUc57
         FqGsSvVIwjVsSPduSweEk4eGPLyX8UDmxOgTKWqsmS9DYuRne2zusxSBaCiYiEsAujzp
         /4QGajPQRByzS6BAAAdzAyoJtakkWRF7aOyJmwx7TbaBlyz3aJzAQ3jOxpVPSR/mCAKk
         ZQrg==
X-Forwarded-Encrypted: i=1; AJvYcCXFKVmXVpdLQ8jjCnwq+rzjGomXF0D3O4PqAryBrgL7iguZZFH45gjlJeqGh20vZ4kHC9YTwB+O@vger.kernel.org
X-Gm-Message-State: AOJu0YzYHGkuVcVnLNZ5sMwWak3WHkdag7NMnMRlGTWs9VuPACPsAR5Q
	0YeEcAtLmjjT/7qTs3zJOX+tmXOd40W30WJY5MFSxebKPInS84VXt9sUBM+g1o24v4ZvzwfFxwr
	90vR1KKmyWs/9aeydAKbRHr6+7iAjfZtrkFn7+lLQf0paq5zeHQlMBTQ=
X-Received: by 2002:a05:6512:31c6:b0:53a:1a:cb58 with SMTP id 2adb3069b0e04-53b3491deefmr6953798e87.44.1730294183192;
        Wed, 30 Oct 2024 06:16:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcdP1N69ftqLPwJbJcjInux4Al6kGkQDoJdvfVoc1iMHtnrcitG4ogcnXP0W3oo1BhBudYew==
X-Received: by 2002:a05:6512:31c6:b0:53a:1a:cb58 with SMTP id 2adb3069b0e04-53b3491deefmr6953750e87.44.1730294182735;
        Wed, 30 Oct 2024 06:16:22 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:7c00:d067:e327:4f99:7546? (p200300cbc7337c00d067e3274f997546.dip0.t-ipconnect.de. [2003:cb:c733:7c00:d067:e327:4f99:7546])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9cab13sm21417775e9.48.2024.10.30.06.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 06:16:22 -0700 (PDT)
Message-ID: <52e1b8e1-86dd-4abd-81e6-98828284a710@redhat.com>
Date: Wed, 30 Oct 2024 14:16:20 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] Cgroup-based THP control
To: Matthew Wilcox <willy@infradead.org>, gutierrez.asier@huawei-partners.com
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, baohua@kernel.org,
 peterx@redhat.com, hannes@cmpxchg.org, hocko@kernel.org,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stepanov.anatoly@huawei.com, alexander.kozhevnikov@huawei-partners.com,
 guohanjun@huawei.com, weiyongjun1@huawei.com, wangkefeng.wang@huawei.com,
 judy.chenhui@huawei.com, yusongping@huawei.com, artem.kuzin@huawei.com,
 kang.sun@huawei.com
References: <20241030083311.965933-1-gutierrez.asier@huawei-partners.com>
 <ZyIxRExcJvKKv4JW@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZyIxRExcJvKKv4JW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.24 14:14, Matthew Wilcox wrote:
> On Wed, Oct 30, 2024 at 04:33:08PM +0800, gutierrez.asier@huawei-partners.com wrote:
>> From: Asier Gutierrez <gutierrez.asier@huawei-partners.com>
>>
>> Currently THP modes are set globally. It can be an overkill if only some
>> specific app/set of apps need to get benefits from THP usage. Moreover, various
>> apps might need different THP settings. Here we propose a cgroup-based THP
>> control mechanism.
> 
> Or maybe we should stop making the sysadmin's life so damned hard and
> figure out how to do without all of these settings?

In particular if there is no proper problem description / use case.

-- 
Cheers,

David / dhildenb


