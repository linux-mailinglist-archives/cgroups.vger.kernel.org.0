Return-Path: <cgroups+bounces-9023-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC9EB1D955
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B03720A58
	for <lists+cgroups@lfdr.de>; Thu,  7 Aug 2025 13:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D982561AA;
	Thu,  7 Aug 2025 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XqvSoo6X"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296B12144D7
	for <cgroups@vger.kernel.org>; Thu,  7 Aug 2025 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574462; cv=none; b=YW6s0rlS5usw1dFVRUZozl73tQo96mFpDiMNZvWdqvOFJsykVGABouXQjXWUv1w6Ntucv8xUXkigNCGOsYsRrQUANZfPBkpOxAUJ166avRraQ4Qoz3kL2SQp4J/P0au5V6COOkz5fO9UnR1SlMT4pPpQfwDOX1Pxc4oA8jr0r1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574462; c=relaxed/simple;
	bh=Lt1VrcFl4j1dHrRBmGpd0wx8gcYqsA1Q2MC823007J4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I2/pYZEt1vMGDokIC4CNNXRQZ5xDpCxI0QItlJirvM8SbaTWOfI4aBelAX2BxB9qEVecTdy9j1BCSnXWHMdhNWINJq8IIqmRPI5TBRt+8YEdyQmEjiTb7g+ekQuFtnYxV7t6GPYIyuBfgr728wHyYLV3JxdfVbr/s1Au7KYDb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XqvSoo6X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754574460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I7tmna+C/APWbW5l/h+M3jZHOM4DQuJitrvRR57OaOY=;
	b=XqvSoo6XdRpKzos8EZUeK9hTNKTUU3orQVC2EKuhqF9eWD34WaUgHB6IZ9k6e98OOa8adj
	vW5YkIoWeiomuN2tQdf+e156lM04YcVudVtmnOS5Pqt5vPL+zSFR9/1l0apNPVp0n/wIkZ
	YFgMzC8VUQXjqBV7hge4YumE0iDpwSg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-H8TE1TmaMUmFyGwBuK9W6g-1; Thu, 07 Aug 2025 09:47:39 -0400
X-MC-Unique: H8TE1TmaMUmFyGwBuK9W6g-1
X-Mimecast-MFC-AGG-ID: H8TE1TmaMUmFyGwBuK9W6g_1754574458
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7196c919719so14734197b3.1
        for <cgroups@vger.kernel.org>; Thu, 07 Aug 2025 06:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754574458; x=1755179258;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7tmna+C/APWbW5l/h+M3jZHOM4DQuJitrvRR57OaOY=;
        b=ktdaqfWGC9fLMOoTctz1jgsbuttjwD7ps6Z8YW1neSHIA1ZFazTSRn0hkHsy6SO2/g
         s1TGfFoAWwobGc3eYLPxGC2sj+UszuY0NUcAFpwZ1Xgs/IfH9MqgQC5L+Rn/Qkd/BrK7
         hETRAdvnOQAcCEUgmdYvP+dRMEPJELczERiGojkc4VuGfRdYQuJHJQHDKP0qK+zbeNYz
         YMtZ0KkeVRqbBQIn28CRU6WFiwiolBxgUDmNIJxwyVdEpc+iT/r5XzQ9gzhSZK+je3Pk
         3atCjSwmzcV4LVeyDq0yjg6xE2jbUMUazdLibaEADT6Uqo7ZZ/cSTmf2QxF/JQSDb9iO
         WHTw==
X-Forwarded-Encrypted: i=1; AJvYcCXWK04nqjGhjWGp/wftg2qb5eVebTbrQzGmyufvY4YYTEsV2liWzuJpjtxhZi2uNvR8pKALxR31@vger.kernel.org
X-Gm-Message-State: AOJu0YzBzKHaDGrWAzBp/palFdhZzrwStS/1/Q4cBOe9IEsZQwtHhzqO
	yIYUacNuB2PvpvT4UTRO55X/vhaxC0LzDVnLVHNLr0Vl6+Xebt/j6npAkxeqcz4EqPzZe9SmHa1
	5S+hFpxppM1He5b4uOl9ShKQAjuoMloRkwDyr9w6Ci3Y66My2/Uu0I5Lg99Y=
X-Gm-Gg: ASbGncsi9+gmcg0TuLhz7eKPa1B4Zhc9/BetnmikEwDHCppOMDcbZ5TwCR6i0Hi5HfS
	G6EnhQNK/8qBHnuybFhKW2YhPbFvrJ2sqtopdYCwPHeFMzfwGPyOAlWQHbEWTJSNt5OJWDB3/vO
	jDDmh9W6VxBiXtU3jIstr7SkxQj6H+SE5gu7r0CY/F2ZijgLpbmrdXTVqSLiZJv3H5mZGV0zpqh
	0/k7Kky43NGkYvoydA8NsR0mBNq/3MR4ZbLwc7XwuFt7IrNmCYVgr/52XsVz1O6lxl0+ILSogZg
	Xj5voXFH2J4q7NujnMdC1ctsddJCLcGzjAjSGzNqDosG6ZCXJnt95d3lEicWbdu6FUGXxkMDJ7R
	kXKQHxJNf6Q==
X-Received: by 2002:a05:690c:6001:b0:71a:2a7e:9cb with SMTP id 00721157ae682-71bcc86dffemr83137127b3.21.1754574458124;
        Thu, 07 Aug 2025 06:47:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEd/JntNjoL+g8+cqvaBLEooL3Wyjt2vW1P7aDxm7/dfts5x4uvWMWOlD9ChxBAudpsyM9hYw==
X-Received: by 2002:a05:690c:6001:b0:71a:2a7e:9cb with SMTP id 00721157ae682-71bcc86dffemr83136657b3.21.1754574457595;
        Thu, 07 Aug 2025 06:47:37 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm45823827b3.77.2025.08.07.06.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 06:47:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5536314d-84de-488c-be56-9c66a5d1a8f5@redhat.com>
Date: Thu, 7 Aug 2025 09:47:36 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cgroup/cpuset: Use static_branch_enable_cpuslocked()
 on cpusets_insane_config_key
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20250806172430.1155133-1-longman@redhat.com>
 <20250806172430.1155133-2-longman@redhat.com>
 <aJSm2sG1G_mk_1P-@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <aJSm2sG1G_mk_1P-@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/7/25 9:15 AM, Juri Lelli wrote:
> Hi,
>
> On 06/08/25 13:24, Waiman Long wrote:
>> The following lockdep splat was observed.
>>
>> [  812.359086] ============================================
>> [  812.359089] WARNING: possible recursive locking detected
>> [  812.359097] --------------------------------------------
>> [  812.359100] runtest.sh/30042 is trying to acquire lock:
>> [  812.359105] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xe/0x20
>> [  812.359131]
>> [  812.359131] but task is already holding lock:
>> [  812.359134] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_write_resmask+0x98/0xa70
>>       :
>> [  812.359267] Call Trace:
>> [  812.359272]  <TASK>
>> [  812.359367]  cpus_read_lock+0x3c/0xe0
>> [  812.359382]  static_key_enable+0xe/0x20
>> [  812.359389]  check_insane_mems_config.part.0+0x11/0x30
>> [  812.359398]  cpuset_write_resmask+0x9f2/0xa70
>> [  812.359411]  cgroup_file_write+0x1c7/0x660
>> [  812.359467]  kernfs_fop_write_iter+0x358/0x530
>> [  812.359479]  vfs_write+0xabe/0x1250
>> [  812.359529]  ksys_write+0xf9/0x1d0
>> [  812.359558]  do_syscall_64+0x5f/0xe0
>>
>> Since commit d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem
>> and hotplug lock order"), the ordering of cpu hotplug lock
>> and cpuset_mutex had been reversed. That patch correctly
>> used the cpuslocked version of the static branch API to enable
>> cpusets_pre_enable_key and cpusets_enabled_key, but it didn't do the
>> same for cpusets_insane_config_key.
>>
>> The cpusets_insane_config_key can be enabled in the
>> check_insane_mems_config() which is called from update_nodemask()
>> or cpuset_hotplug_update_tasks() with both cpu hotplug lock and
>> cpuset_mutex held. Deadlock can happen with a pending hotplug event that
>> tries to acquire the cpu hotplug write lock which will block further
>> cpus_read_lock() attempt from check_insane_mems_config(). Fix that by
>> switching to use static_branch_enable_cpuslocked().
>>
>> Fixes: d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and hotplug lock order")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
> Looks good to me. Thanks for spotting and fixing this.
>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

It is really a corner case that is not easy to trigger. I would have 
missed that myself.

Thanks,
Longman

>
> Best,
> Juri
>


