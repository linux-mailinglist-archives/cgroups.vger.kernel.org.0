Return-Path: <cgroups+bounces-11877-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5430C53E8D
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 19:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A49F3A5BFD
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 18:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC7834AB1C;
	Wed, 12 Nov 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FijbiEZd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="q3ctEXq0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350D2D97AF
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 18:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971680; cv=none; b=bphGhyVbb3G84BHhxWSesu5e5upObKRqyho12izX8kbfgCFay2zNzp2sy5jdbpGInVjXOVRd+ZIe0rMTzRThq45rZasqhFUZA9A5iN02KDpZ9mz/1QHgDWFrKNeyGY7ovAxOKghHTnkryhPgRYaW5btF5l/Zqn7fFngGdgFfJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971680; c=relaxed/simple;
	bh=yl+oslX8wXO1RMzv0DqKzC2S5J5LK9Sv9dWD7vhAgAM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P7Wjc0fqvADb1gtYwLxubsisOgTl5I2+x39KzeAWi6l7MZiUMN1HFigSK5wS2B0sjZZHiLLb25s08bJ0lBB3FU9fZM4sFGEQDL5DmQSjcvENUBf/GGX20SCnebjkutOhHLJRZhkqYv4k55ICG45P5B6NrLAjDQlYFjQV5Y7UmoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FijbiEZd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=q3ctEXq0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762971676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dJpJWnR6W2PauvB5c9FgPR6gGTYegkNj3iOoqqoWtg=;
	b=FijbiEZd46vSeDwSvYBUxk3wafkUoH+Cv1oAAsVk1KrbmfCySsHlI3zt3VxmCM+zPS8fUy
	tJtGDmvKTyT8p74VG6fJBnmwQazbLEzuCB4Wdi1C9H0T+f8Q49KjUxKQOmBEaCFghaI0t8
	DsjiiCACuG1Aa8ySQEUy2WyVQs23xg0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-VNJD_LDjOTawAakp7HW_Eg-1; Wed, 12 Nov 2025 13:21:14 -0500
X-MC-Unique: VNJD_LDjOTawAakp7HW_Eg-1
X-Mimecast-MFC-AGG-ID: VNJD_LDjOTawAakp7HW_Eg_1762971674
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b233e206ddso308034485a.3
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762971674; x=1763576474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dJpJWnR6W2PauvB5c9FgPR6gGTYegkNj3iOoqqoWtg=;
        b=q3ctEXq0ffJ4swuBHHeX0XNAnGJowN6jiL8X3fYDo7vZfFxBdJxCiGVFvTrJ1xKOxj
         3BsZ45bqdOSjKLzQ8P+gXTnFq6rluEAwmx7ccwuR9hWtAkgqDg3J54rEbqvn4hf9BIC3
         TWk00a6BXXLekHWc5phULXwY1RAlCLlaF+GxXjy8aXZeNx/CT7GZKs2kpJ0bzmYB87c2
         aNND3ZDytqAkn4nr+OW2ya3iBlGLIw4UGgL3IoyxM01sVvOmOHzEHr90JmlcWPJqXt1z
         KVy1Ejoa52qHF8UA19yKmCalFAOzej6H+7PlG1AVFVq04YekvGUzw4JVjh53rLc+bLAG
         O4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971674; x=1763576474;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dJpJWnR6W2PauvB5c9FgPR6gGTYegkNj3iOoqqoWtg=;
        b=fzyQ0c3W8rA6Ahd+6FLXb5/qSSJg7UycgKHjwOB4CCf5Az7GUKaAZyF50kpaRi1zyb
         ZCQWVSciC7LTSCB3UHo/K+WfKDRbrmXoNY8WqPJfSuxm0ptgOvtcHC4V8XYu4ok8Nikv
         PwfDHxuQB+dv9rHGiWyFzZLnNzj4LUUZYM48tIa9/+xSEU/le8v39yFFeC2Byg9fXybj
         xO4mdaikeoTNPRD3paBtD0I5i7RwqvWXlFoS9iog1QfwIyB71x9idKwi8fCfyPidMhRO
         61o4ezC+84cb53kf8u5uxvBlZXKxsYyHgC/XL5j1HuBzW5A/bG1RZucxH1ENq3LAwjRL
         TIXg==
X-Forwarded-Encrypted: i=1; AJvYcCUH+7KHYGmBMixheQwQeaxvNPSNzxkzpI9wDdHTCKQ8lSuAdy7mjOaCCEoYglZThnlg87LoxW0m@vger.kernel.org
X-Gm-Message-State: AOJu0YxME/gY4nJZIYihH6GHIY/YEm+I0hnQFRRwkAM+c2AdpOv6XKKZ
	S2wda4MB8G1uDrLbKjTeVMsAUr8QWkOt6yuxCzm8CDvHJ1gMp1Ee8HMkkZ672jmotr8MrEKXmMm
	Sop/PRIfeZoc/iJQLtnmsBKWHBZ4w09KDLCpmVmkSTvJW72FjUZoG0OmX0PY=
X-Gm-Gg: ASbGncu/9oDwQWH8R05GlOTYRzPEydFPzuxA2Zw8eOsswI0DzuVAyYZt6uyIB7SdcyX
	1FfOl1qlHlzrnG7Ms7mKU7+38VyxffkFPFTRO5+5CbsUgZu1g4yahchQ2JmHT5NykmYX7yQel/T
	4lW6HrNcJLLXnrk5rVubjs5HjRLQgsAJlyzYJXN53MSzryIS57+JhGTgAHxWNfLqOTSwBs6lQNR
	jHbJfhvXV8l3xUTJTlTxGiLM6RsDSKOa79/weZQ13Y50lERMrtFxhcedh6Q64Cb/VUQdVA9Mzki
	URubAfHWOslDZfZ91Zt4U+y1GTOXCBmszDyYPhNYoL4PGN1ngjUMl3A61q9EidydKmJrj3OqCZe
	Cx8IljKFTJsV+ZOQV+AejDZHdMs04HAsOUvaOoJOOrArWQA==
X-Received: by 2002:a05:620a:3189:b0:891:ae32:d696 with SMTP id af79cd13be357-8b29b82bdaamr491393585a.66.1762971674362;
        Wed, 12 Nov 2025 10:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmk9lfZ7Dqn8dctjmk3Q6bmGkgKiuUiM1dIje3DZrti/tFNHBsEkMGCydCnh8k8ZsuTO/tAA==
X-Received: by 2002:a05:620a:3189:b0:891:ae32:d696 with SMTP id af79cd13be357-8b29b82bdaamr491389785a.66.1762971673918;
        Wed, 12 Nov 2025 10:21:13 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85e0a9sm238798185a.20.2025.11.12.10.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:21:13 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>
Date: Wed, 12 Nov 2025 13:21:12 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Chen Ridong <chenridong@huawei.com>,
 Pingfan Liu <piliu@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20251112035759.1162541-1-longman@redhat.com>
 <20251112085124.O5dlZ8Og@linutronix.de>
Content-Language: en-US
In-Reply-To: <20251112085124.O5dlZ8Og@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 3:51 AM, Sebastian Andrzej Siewior wrote:
> On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
>> The callback_lock is a spinlock_t which is acquired either to read
>> a stable set of cpu or node masks or to modify those masks when
>> cpuset_mutex is also acquired. Sometime it may need to go up the
>> cgroup hierarchy while holding the lock to find the right set of masks
>> to use. Assuming that the depth of the cgroup hierarch is finite and
>> typically small, the lock hold time should be limited.
> We can't assume that, can we?
We can theoretically create a cgroup hierarchy with many levels, but no 
sane users will actually do that. If this is a concern to you, I can 
certainly drop this patch.
>> Some externally callable cpuset APIs like cpuset_cpus_allowed() and
> cpuset_cpus_allowed() has three callers in kernel/sched/ and all use
> GFP_KERNEL shortly before invoking the function in question.
The current callers of these APIs are fine. What I am talking is about 
new callers that may want to call them when holding a raw_spinlock_t.
>
>> cpuset_mems_allowed() acquires callback_lock with irq disabled to ensure
> This I did not find. But I would ask to rework it somehow that we don't
> need to use raw_spinlock_t as a hammer that solves it all.

OK.

Cheers,
Longman

>> stable cpuset data. These APIs currently have the restriction that they
>> can't be called when a raw spinlock is being held. This is needed to
>> work correctly in a PREEMPT_RT kernel. This requires additional code
>> changes to work around this limitation. See [1] for a discussion of that.
>>
>> Make these external cpuset APIs more useful by changing callback_lock
>> to a raw_spinlock_t to remove this limitation so that they can be called
>> from within other raw spinlock critical sections if needed.
>>
>> [1] https://lore.kernel.org/lkml/20251110014706.8118-1-piliu@redhat.com/
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Sebastian
>


