Return-Path: <cgroups+bounces-8390-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A00FAC8116
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 18:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693C94E5494
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D45224AEB;
	Thu, 29 May 2025 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRtBEJ+L"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E63F1362
	for <cgroups@vger.kernel.org>; Thu, 29 May 2025 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748536994; cv=none; b=iAqhAgJGvcWEUzV9d979YdpFdkI7mY5q/ts97ct8jLM+sWRxCnHPK06m2isHsRIKbdf5ALhRoWRK3dLAiTiVqJA6+S9dW8boTDTdFHe/AlTaCSNhDTx2COvDGnBwaVwvCEWVuA6GbT8Sf47DrHOAZ2nf7Pkjr7CH7xhTqkJonVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748536994; c=relaxed/simple;
	bh=LuUMj5/LIq7PDmQvsXZoUIDdckolOrSC4rNrgeUnfFE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DJQQlpgTyTMaiOjvtCyTmRxdfWz2Pt168oRSSlhnJHnBGe7RThbl0IX+3HSflLWUGPlex+yTdGKFMwYQN6MaZuwWClKXITalAyo0+NWxjSo60d6vUBn5W2w/VjBaG9kDlLq2TGCtJR/cTV02qbaHKNLZgx4ms/oV8kE7E2Pe89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRtBEJ+L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748536991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EX6noTLNlrgY7P2RzLTcHPZSsgo8DbSEpRqQzbvYaZI=;
	b=KRtBEJ+L4rYlhKVKLycA3SkiH/8t/87+D6ExN1zNfXoDZUGt6O3DwR4QmkyoEfOBUdMBDA
	+LEPcNEVcwyrLvSCJmsz9CUM4H9wZecNHRxx28PU7/rA/tqdBWAvJB6B+oYxjfB5fhi82m
	6920bMy61J00qK6m4ghdmqEvdYx8r9M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-YYoRH3f9PdedGjarTnXwKw-1; Thu, 29 May 2025 12:43:08 -0400
X-MC-Unique: YYoRH3f9PdedGjarTnXwKw-1
X-Mimecast-MFC-AGG-ID: YYoRH3f9PdedGjarTnXwKw_1748536988
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f8d3f48f35so23026576d6.0
        for <cgroups@vger.kernel.org>; Thu, 29 May 2025 09:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748536988; x=1749141788;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EX6noTLNlrgY7P2RzLTcHPZSsgo8DbSEpRqQzbvYaZI=;
        b=EZ/p08dyj0mAiq54vkEkj93WJ/lGdCRBwJ74YdTXLUb8+FwPdW1HYBMHQyVMmWJ+OL
         Pj7KZqqwkaLaWfx/Ytf3calufRDct/GI0TIsMbe+2je13WRddpX5oOQ9zj80IE4SPgGd
         uO16AKWOkP8/KvH441gbSeI2xosWQriF/U8a/rxjNkVE5X9PcVVj6Sd8VORM2/8MVNoJ
         6Zl7HW+vVRgiv2r48hSJvKAk0vQi2oBibJBhvdKqvM6tcVXuqckaCS2QOoVEYaRC/lMq
         PVWvOmzeCw5U9VTuOnqPmwybfeDN9BxIb5obUg+jCvCnz0S6J2xXDegYk9qWM2j06E+a
         h8Jw==
X-Gm-Message-State: AOJu0Yz/hYzs06/Ac1LE1ryZaY+SM2S8g5UEyO6PrCmpMJnYCW7cSq47
	Zzzwocj59sObDwJ/6fpth6l26M1HmZ4PoUKy7Itbyk/OhvsWsGQUB3T3vhSQPWGo2jg6jvXxadJ
	OFRDcguzhrX8jSzWi9ySH+gvO16pcVzKgXSc8uvoci1bozGdYQH9wyq3NePY=
X-Gm-Gg: ASbGnct8lONbNMsyiqWxrXFAq7CjPsbfJKa+KFNhiqnE0jl7N07Cuo0SYUD+G8EsTkt
	1XJ4sjB+VmzXtQKW6zJpgH56RTblHDjmiIOEnI7TyyEo4XC0UWHfCRScSrYQR99AUoR4N89+etI
	yTbR0VGG3o4pKdYiD0B1WIVyZ+sNVtAfckBAX6WK95ZnOwDFMh2aUhXsbz13ZbONwbvxopwxuQH
	9FkzD73ug4Is/rf5R6xW/L0UiMaKyXOUkCaXIvurDOSt4yQBKGPxhWqbrfoXPC5xkwfMIxW9qH4
	eYp7jhoLXOc0
X-Received: by 2002:a05:6214:d02:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6faced737edmr4316826d6.32.1748536987971;
        Thu, 29 May 2025 09:43:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfTvumnBK04LF+TV69EWfFnqtEx+fAm1eIoL25uxtXnusMZGDvMgMo3oCC9WS7u7hvRJfuLQ==
X-Received: by 2002:a05:6214:d02:b0:6e8:fbb7:675b with SMTP id 6a1803df08f44-6faced737edmr4316406d6.32.1748536987576;
        Thu, 29 May 2025 09:43:07 -0700 (PDT)
Received: from [172.20.4.10] ([50.234.147.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d5b139sm11241386d6.53.2025.05.29.09.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 09:43:07 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6a0113b9-6ca4-4b42-8cff-785da5fcf9ba@redhat.com>
Date: Thu, 29 May 2025 12:43:04 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
To: JP Kobryn <inwardvessel@gmail.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, klarasmodin@gmail.com, shakeel.butt@linux.dev,
 yosryahmed@google.com, mkoutny@suse.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, kernel-team@meta.com
References: <20250528235130.200966-1-inwardvessel@gmail.com>
 <35bd4722-cd02-4999-9049-41ba1a54cade@redhat.com>
 <563a7062-0530-4202-abd5-95380fb621ca@gmail.com>
Content-Language: en-US
In-Reply-To: <563a7062-0530-4202-abd5-95380fb621ca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/29/25 11:14 AM, JP Kobryn wrote:
> On 5/28/25 10:23 PM, Waiman Long wrote:
>> On 5/28/25 7:51 PM, JP Kobryn wrote:
>>> Previously it was found that on uniprocessor machines the size of
>>> raw_spinlock_t could be zero so a pre-processor conditional was used to
>>> avoid the allocation of ss->rstat_ss_cpu_lock. The conditional did 
>>> not take
>>> into account cases where lock debugging features were enabled. Cover 
>>> these
>>> cases along with the original non-smp case by explicitly using the 
>>> size of
>>> size of the lock type as criteria for allocation/access where 
>>> applicable.
>>>
>>> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
>>> Fixes: 748922dcfabd "cgroup: use subsystem-specific rstat locks to 
>>> avoid contention"
>>
>> Should the commit to be fixed 731bdd97466a ("cgroup: avoid per-cpu 
>> allocation of size zero rstat cpu locks")?
>
> I chose 748922dcfabd because that is where the underlying issue
> originated from, and 731bdd97466a was only a partial fix.
>
OK

For the patch,

Reviewed-by: Waiman Long <longman@redhat.com>

>>
>> Other than that, the patch looks good to me.
>
> Thanks for taking a look.
>


