Return-Path: <cgroups+bounces-2681-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAA78AF7B0
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 21:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF92E28504D
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8251422BB;
	Tue, 23 Apr 2024 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/LgQ5Wi"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9E41411E0;
	Tue, 23 Apr 2024 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902362; cv=none; b=oZ4icMBSMX+cVd5AHSOiswohswRTKjb09sDFhThtq0JP+wWEIO59W8Q681okVGMWXFGc09rANOXZ+FtP71vklmTOHzQJE5jc7TPL8fwb8Sa8q02PRxuLYJuaZZvUGhU3f2TG6Z4ON9iqcZunKh7YR7Ir6hT0DpHNs/ZhZ7ZasY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902362; c=relaxed/simple;
	bh=BbkoqiMSK9Ssbi1rjQKK2cN+8N1bYmMNPyz/b73g4Fs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nV2GQtyGxjbzObAyyVdSZbvc2Bq0r3d2FJ0uArO3pLAk2MhZqqTwxKAY9Igr1B9IaIo338MAaSmI4zUOD0qi0YqqhCAZWpBJc3VelltKSH0l/Fx4DwZLHSFuHeSzDZKrkIvmrP6NbqJ66Yij527RT8zED2AL7G+TChFDkv3P6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/LgQ5Wi; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso226308e87.1;
        Tue, 23 Apr 2024 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713902359; x=1714507159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbZV0td3QiFIVyIuhLK1YCZ0t4y/knCvQBxyS/kA6xE=;
        b=m/LgQ5WinM3HM0KY5T0SYxRwdiCTCI+AWY945naUOsdOEwNelmIoHxMzkXFVvqt2LL
         HZJeCWnVTL9C9NZ78RV2z4lXfNv45UA3PokkvwhDLcMBmlHSuIc+7nJZxteNqEr6psk/
         Vv80GC15uDqF7maAfW9AbL7ziXkY9w3LgJAie3nIw9OFD8wzzKyJbcNCIHUOEKTMlsOX
         dpBI+ut+lp8CkvCvuEw74x+5T+K9QiPwCzj98UZ7aoG3t4+AqvB7wNDKbIOQhoyhh9Ho
         jRAZ6/I5XNr/qIdfbD1OS0aXC7t3QrpylUKUtOeE0XVHjYPYWRhYkdIcUB4+KqkzdlBQ
         jAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713902359; x=1714507159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbZV0td3QiFIVyIuhLK1YCZ0t4y/knCvQBxyS/kA6xE=;
        b=s9kMDgAXh2EQu31+2fL5cjYDI2EEsqOFz5QOZkTZ/4T2noPrCvqOn5un2Lckk1iIsc
         uPYY3fF9J61VOZmsDvylAWLCyzMnY2AaBoxdXRLCN+c7ole77bXzC5DbwIcypkFUOow/
         PGkUvASOUc27+AWyVs8cS9LcV8oOZtDb4DvKvSHG0cMXvU1q6cQXLwObuy9TtBgnFRA3
         kRFz12OdqUeryyFCvHy+SH3eYPQPuSDzc6dyy1y2pJjiDHb2v9RDreyL9VSuLfI9MRxn
         ZELiPk+gRpXgZHFc+MmuvgoKiOuFllBrHtrfXqoRJffMwa9NgJSE761JqsK8vPpch6iW
         1ROA==
X-Forwarded-Encrypted: i=1; AJvYcCVV+dCcK1A/r/gmHlb8Dz7bYmEKPiSjthQGj3xf+tTg5BYwmlnVhwqZ55TB7mxQiyGhBk/sgDU45vDemZOgIkQU4zv42wy8g+EAJHKF
X-Gm-Message-State: AOJu0YxgETOzmmZkijQxFURaQWj1oXtFtM62snGkOq/bObpMg6z6QfSQ
	O+Jd8HDhCydIt10rmSYZ6TLpR3fFtMTffhqlkDPDB4zosMMVqpJm
X-Google-Smtp-Source: AGHT+IE5700aDd3WYfKRuJ3DOeiP5TWMahl8JXcxO0nR6RXknNJW+zAWi5dnzphHI1E21XuXkoF9Mw==
X-Received: by 2002:ac2:5f83:0:b0:51a:cc71:b91d with SMTP id r3-20020ac25f83000000b0051acc71b91dmr1095486lfe.19.1713902359028;
        Tue, 23 Apr 2024 12:59:19 -0700 (PDT)
Received: from ?IPV6:2001:678:a5c:1202:2659:d6e4:5d55:b864? (soda.int.kasm.eu. [2001:678:a5c:1202:2659:d6e4:5d55:b864])
        by smtp.gmail.com with ESMTPSA id bp26-20020a056512159a00b0051b25491ef5sm804621lfb.127.2024.04.23.12.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 12:59:18 -0700 (PDT)
Message-ID: <ba0a2b84-2d98-4339-9b02-d7e95d9c6caf@gmail.com>
Date: Tue, 23 Apr 2024 21:59:17 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: Statically initialize more members
 of top_cpuset
To: Waiman Long <longman@redhat.com>, Xiu Jianfeng <xiujianfeng@huawei.com>,
 lizefan.x@bytedance.com, tj@kernel.org, hannes@cmpxchg.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240420094616.1028540-1-xiujianfeng@huawei.com>
 <f2edf788-6ff3-43b1-9445-ac237e7910ac@gmail.com>
 <a583d400-ed59-46b8-a26d-b726055b5cad@redhat.com>
Content-Language: en-US, sv-SE
From: Klara Modin <klarasmodin@gmail.com>
In-Reply-To: <a583d400-ed59-46b8-a26d-b726055b5cad@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-04-23 21:50, Waiman Long wrote:
> 
> On 4/23/24 15:21, Klara Modin wrote:
>> Hi,
>>
>> On 2024-04-20 11:46, Xiu Jianfeng wrote:
>>> Initializing top_cpuset.relax_domain_level and setting
>>> CS_SCHED_LOAD_BALANCE to top_cpuset.flags in cpuset_init() could be
>>> completed at the time of top_cpuset definition by compiler.
>>>
>>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>> ---
>>>   kernel/cgroup/cpuset.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index d8d3439eda4e..e70008a1d86a 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -369,8 +369,9 @@ static inline void notify_partition_change(struct 
>>> cpuset *cs, int old_prs)
>>>     static struct cpuset top_cpuset = {
>>>       .flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
>>> -          (1 << CS_MEM_EXCLUSIVE)),
>>> +          (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
>>
>> You dropped a '<' for the bitwise shift, this causes bad cpu 
>> utilization for me.
> 
> Oh, now load_balancing is disable by default in the root cgroup. That is 
> bad. Will post a patch to fix it.
> 
> Thanks,
> Longman
> 
I attached one in my previous message, though I'm still very new at this 
and may have missed something.

Regards,
Klara Modin

