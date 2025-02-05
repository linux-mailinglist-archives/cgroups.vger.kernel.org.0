Return-Path: <cgroups+bounces-6428-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0DA28218
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 03:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263FF1882DF3
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2025 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6640E21420A;
	Wed,  5 Feb 2025 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NERR+Cu0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2E2135CE
	for <cgroups@vger.kernel.org>; Wed,  5 Feb 2025 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738723342; cv=none; b=QRP5N5OWUdPcjO28kwaqgJK3pF0fkUM1XOVvJhVx1Rqkkh3Yi5jLoABvpVOpAqfXzJfWYcDFgh+646+nLxm1jtsbwO1k97vCAUeTBtr8zRsE+YrfwaeUSfHb9dVBD2Bh58vhfxO5IRNehOWaTrCvL7pizUgqCm+StBdOJLaWpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738723342; c=relaxed/simple;
	bh=7YCuggeYk7vbWeyi6etgcTp8qXU+Swwh5GPai7VljGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fePag4iMdW1amVrd6776rOwYnJ1zWdja9nBIAXuArtlQc99a9L3fr+IcpYYUddjNzdoM5mvzFnQh6A7Dy3xmw7DEi5AsnibI+AATMiNi5M/D8YybLV7EiV6QX+3AtC4UP4YZSgaurB1SEb91bbVHyjDOT61oU8xW/Hf+N3l0si0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NERR+Cu0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9dcc3f944so97401a91.2
        for <cgroups@vger.kernel.org>; Tue, 04 Feb 2025 18:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1738723340; x=1739328140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9P6bfbaO1ayzZ+Zop/bs7QRHHtDwQNcmTGhPOOug4o=;
        b=NERR+Cu0kEu1grx7lP7mu99mUcIUxGzTrECG56jyT75fqGZbLsrNKt8dFLLeWc/bA9
         4FfFaRbWTwGKk/pDn7Roy/95ZDBjhHpN9FJkHwUbb3vT3eOcuxDM7WB2U6TAdO9g5hi0
         NPfCuWgHRDd8eZoYl2hoTzqW6CREFp8/IJ8rLAUZZME1QMj1v9/0pBRmwS5GkzD36zw5
         sakP/u/DchsuoJoNZoAqnup5a3u1QymP8nSOj7eRv3fIFFcPXYGVwChx/JIWNCfXGcwG
         rsgshtfIMf0rKzWtwMwVnZHmle5IVXe7vi5o+2DJfLUnGVZ1iNg67gSJaC5r5JNVeqbu
         5NSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738723340; x=1739328140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9P6bfbaO1ayzZ+Zop/bs7QRHHtDwQNcmTGhPOOug4o=;
        b=a2YWSc0uVBFkgt7kkMjt/IbbMAx6zy59OHxjGkgR25xA21x14DGz6y1QUciK9I4GSB
         dFENeGidJ5O2DEs60WMDXJ/1syD54W7jo5I0LeB88Q6uo+xX28u8Nj9H0FGY5uxzLzO9
         cy5xVXjgsS/T99+yuOfGRFa7ifYuCjYw7SIpFxSz58iN0sLaXy1KFCbdrRJddx7JACeA
         pCv9EQ2oUxDmwg4hgaI8u4QxuNd8BnvXXUT9IA60dCGuX9wlPGHInjDQINodRWFpp/Ji
         pPJFoq49apS6NrFOBjoNp+La0jcFvN6D0SFtV4uVbp7CVyO87o8ru+/bVWHiGpdl8+Vp
         uEBg==
X-Forwarded-Encrypted: i=1; AJvYcCWXF1YaOC8H+Z6pmE50vwvrzzTAC0xpUMQnPBLsH8BpzPlldQ0YANqoGHRy/cUMfhS/3GwWN42C@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhLzLDdoTh3O5aQWVarkrs7ejL1FgGBTVm9x6c6n4GIt7ayNT
	Q2ToqyMpGhnAxEvXFF92UFL+PbojZ2BCZ6f39nOCEe/W752lfrwEMXiVGSnJMwc=
X-Gm-Gg: ASbGncuRalbtETb9ogMqIgdTzLqCodyXAncCFnD8RVEsjrJqANEm1YufyXx1mBpq2ck
	dUdlhRyHD7s/onPpIQMtaHzc2OB+yeZgwrqpXsIFGNDTOMudNEXAVMQcwBA3C84kR21cEI/ykgp
	eXANoFT2RqeFgXmxrvcH8pcidl7Bwy1U6BONu/MVYUbdLAefuaGWFyxvc3on60MMGwy4ggYRu3M
	Mhzdo0So1YIUz2A2WeTdJuJ95k5Xj5Lkyo0IW4JP6I4ckWwcc7uzXIeFgHJx6QUdhT9IVCUmJcq
	bzoX044o9cB7ykzS71+JCOMyXBTwTiS89+qv
X-Google-Smtp-Source: AGHT+IGxSXQuqSMk3bcYIZIkz63AGFvTGZucd9e/zkZKrSE5SKZNOcFEvlo7YbkBJWZQn51OYfPUZg==
X-Received: by 2002:a17:90b:1e41:b0:2ee:713d:f536 with SMTP id 98e67ed59e1d1-2f9e0868686mr606696a91.7.1738723339652;
        Tue, 04 Feb 2025 18:42:19 -0800 (PST)
Received: from [10.4.234.23] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f9e1dab45csm305094a91.40.2025.02.04.18.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 18:42:19 -0800 (PST)
Message-ID: <db1391a1-2f25-4976-866f-d48ea6b16e11@bytedance.com>
Date: Wed, 5 Feb 2025 10:42:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re: [PATCH v2 0/3] Fix and cleanup and extend cpu.stat
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Yury Norov
 <yury.norov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Bitao Hu <yaoma@linux.alibaba.com>, Chen Ridong <chenridong@huawei.com>,
 "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250125052521.19487-1-wuyun.abel@bytedance.com>
 <bb16ae49-f591-4ab3-8d27-f649619b266b@bytedance.com>
 <Z6J8wbuXgiz_ly-q@slm.duckdns.org>
From: Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Z6J8wbuXgiz_ly-q@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/25 4:46 AM, Tejun Heo Wrote:
> On Mon, Feb 03, 2025 at 04:11:27PM +0800, Abel Wu wrote:
>> Ping :)
>>
>> On 1/25/25 1:25 PM, Abel Wu Wrote:
>>> Patch 1: fixes an issue that forceidle time can be inconsistant with
>>> other cputimes.
>>>
>>> Patch 2: cleans up the #ifdef mess in cpu.stat.
> 
> I wasn't sure whether the new code was materially better than the existing.
> Can we try without this patch?

Sure, will drop this one.


