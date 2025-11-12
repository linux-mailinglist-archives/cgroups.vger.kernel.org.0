Return-Path: <cgroups+bounces-11845-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F00FC5054A
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 03:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C8B3B2370
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 02:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE92197A7D;
	Wed, 12 Nov 2025 02:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyY836lu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0ZFFCUs"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73DD22301
	for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762914081; cv=none; b=Rb3GqbRaN5E+tK0WysgVf+EOCJ746ep3DO6K+SNzVBmWoW9MT6+5hZWEDX7ylHUYfCngiRYSrASaCEgw+FNwIEwg/qhptArwi2txP8s9jwwqKUSvfU7YZOEl1XQ9vP6nOZ0yIqftit5qrwHIfLWHAju8WVlXD4Df9R2fkDLeKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762914081; c=relaxed/simple;
	bh=YWcG+oJgowB0QXzh7lW0ev+o8dH9TeV1xvVci1EqKF4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jKTvbus/CQTarMHSpeGfGhFfqGR6KRkj62Wk4ZyIEVtB8ZKJtlXZ8hmSoDleUayQEvLNUaVt4/0Fh/SeOMJqptNXTTXIOsyx6eVSsTLI5N2Libm99csD1H4OBxBMZciUWNaY8IcFC9gzhht3rmcFc0wtItHp7GZWcqZjcTeIssQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyY836lu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G0ZFFCUs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762914078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oog1zA4MhgknnCzL4jWJTJK5hM/UQ2vfKQRg1iPWC2A=;
	b=KyY836luTYSMX6y0p7sj/iUb8aeBvTDJNaD0QJwC5oiAUI2O18FhL+mpopULP8UGo0SeAE
	tjbP3aokRe9lsThu/WXVJlU2jF4f5q02ccpnwwvTNDaqP0d3tq0gyvlJDC+DaRocbp5KWj
	AYJo9YIuVTdrF+NHEcLHamOXlULXf/Y=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-Hb-psqyRP0OB4ItSVepeHQ-1; Tue, 11 Nov 2025 21:21:17 -0500
X-MC-Unique: Hb-psqyRP0OB4ItSVepeHQ-1
X-Mimecast-MFC-AGG-ID: Hb-psqyRP0OB4ItSVepeHQ_1762914077
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b24b811fb1so78348485a.1
        for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 18:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762914077; x=1763518877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oog1zA4MhgknnCzL4jWJTJK5hM/UQ2vfKQRg1iPWC2A=;
        b=G0ZFFCUs+0cvPY9NgOaAAjEsK6G5i7G6/YJKapffhnqJ+JWUz5ugYUtxijAHsYcehH
         8wtCInJURGYpoDAxEOCzNobZH46PQqXkIjMV2Oj6PlBvczUNX96QFGgZid16qfOMAiwU
         y2kDZwY/08Qq7ilk71F8CiuPSCr/rpWvkoJjaVuc56I23G3sZzi+EszppBjnYY0WG9Ny
         qCWznO/bmg772ueVk48H0YXpPrrAYs4uUVz206PZFw3x0PGFO/JCuBU9Sl6Loi7D4ktX
         WuHHe2ojjht6kDnfWXPLmwq7LKTabIF9ibu783mMKxsmmZLSdYbVuibFS4GVcMBuesci
         Nc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762914077; x=1763518877;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oog1zA4MhgknnCzL4jWJTJK5hM/UQ2vfKQRg1iPWC2A=;
        b=hC5Mc/Ex9/htUgd1747ZRCxibZxXsWsXk4UMPxeAHkl/GlMQznPM232OCcNcEy+ldO
         /RE2CUH+0Yj3uocFYVf54s1YlmWJZ8scxms8q6dQK9iHl6lWf5bVCRAefnINHha8gq1h
         3QJQLpf3fhUHhKeSsjQ93syUe1rYr0gHw93mvgMit+49ms0fwScreVyD7Dw2CyrXnhPQ
         //boGGskjTDzqDWvS6Bx8Bwx8ax3h5SfgKKL0IaDRQ6y0UUGDmb7XaETYPzxRaOLZTJd
         /tIWQJKCVhwHZrGM6RBjD14ltOGuyDwXVNqJo4HxYzb3MR/LLI2tSK+fiW0B5zLw5MWy
         YuJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3kjAS+ltgoVZMYqwnytVCtJ33niMTKnKhw89lQGrbYGgRNKPbo4K5QBymC+sqtRrD428UfDQA@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuwq++j1M4Kf4TQSPTeeQ31wZEAdlgivTvVl8/NOwGcwb1tZn
	a300vh3m5Ioc+UNJS2mJ9jIFGyhzwt+MubfLfbthAWKJoQDEpKBmb/qFhrjk8KR8Ezr8Ojsd6P+
	E0a0VMCMBZnrZPrQT5hcLUeogU1AfXZ8FHe9HVPKTQQuA5RdOEpgqz6mvYfc=
X-Gm-Gg: ASbGncuGVsGCY0h18TKX5gqzMIb7dL56nUWiV/izDoRSOdbNbog1fgZxdLCwEPd8cOX
	+aK1wM1XvVupQXe9/YQwKI7h31GKsuMcmL0PBENqa5wdxVvJlWixGnoeR9Yb/9oxBQ9VErjHceJ
	jN9hG/rXm259piCbXNiMvbAHU1dz6m4VaUc9goIu5wpkFSnzIW9ogg/WIlXYJM7sKlZz6tC+9Rf
	TtbprcV4wvNaCjMGLZtaMhps2sTZ4Xao+4y5Yivt8XLU7ahm6M6rHQ6EpMiNhfa0nSUGDzpHIuG
	h7Q9zPQrhkoYXzQf2Pg2K7CJgVcPdQ3KvooSzfe+CFohnpDIJo/17oJ9cfn3pOi1f/C4EoKTRaH
	QXl3jbYMtmt+aAtR4/HZVwQG+y7tGPHLeTYh45LJOTwuidQ==
X-Received: by 2002:a05:620a:284b:b0:89f:3fa9:d2ea with SMTP id af79cd13be357-8b28898e198mr700389185a.15.1762914076702;
        Tue, 11 Nov 2025 18:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPW+KSEaCRt0t8ci2KGRMI1HcV7Zd4Kh8enTmgeyrHrBzYBM0y3gS0k7fRKyFqts+K3XsvYw==
X-Received: by 2002:a05:620a:284b:b0:89f:3fa9:d2ea with SMTP id af79cd13be357-8b28898e198mr700386985a.15.1762914076304;
        Tue, 11 Nov 2025 18:21:16 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e6c95sm100332085a.29.2025.11.11.18.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 18:21:15 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <3019dd82-5388-427f-8618-30b5d8b06fd8@redhat.com>
Date: Tue, 11 Nov 2025 21:21:14 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: Treat tasks in attaching process as
 populated
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132632.950430-1-chenridong@huaweicloud.com>
 <dpo6yfx7tb6b3vgayxnqgxwighrl7ds6teaatii5us2a6dqmnw@ioipae3evzo4>
 <fed9367d-19bd-4df0-b59d-8cb5a624ef34@redhat.com>
 <sebxxc2px767l447xr7cmkvlsewvdiazp7ksee3u2hlqaka522@egghgtj4oowf>
 <a4e61aa0-5c1f-490e-9cae-5e478ba809ee@redhat.com>
 <86361412-7de0-46bc-9188-a32b634e43a3@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <86361412-7de0-46bc-9188-a32b634e43a3@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/25 8:58 PM, Chen Ridong wrote:
>
> On 2025/11/12 4:35, Waiman Long wrote:
>> On 11/11/25 2:25 PM, Michal Koutný wrote:
>>> On Tue, Nov 11, 2025 at 10:16:33AM -0500, Waiman Long <llong@redhat.com> wrote:
>>>> For internal helper like this one, we may not really need that as
>>>> almost all the code in cpuset.c are within either a cpuset_mutex or
>>>> callback_lock critical sections. So I am fine with or without it.
>>> OK, cpuset_mutex and callback_lock are close but cgroup_is_populated()
>>> that caught my eye would also need cgroup_mutex otherwise "the result
>>> can only be used as a hint" (quote from cgroup.h).
>>>
>>> Or is it safe to assume that cpuset_mutex inside cpuset_attach() is
>>> sufficient to always (incl. exits) ensure stability of
>>> cgroup_is_populated() result?
>>>
>>> Anyway, I'd find some clarifications in the commit message or the
>>> surrounding code about this helpful. (Judgment call, whether with a
>>> lockdep macro. My opinion is -- why not.)
>> For attach_in_progress, it is protected by the cpuset_mutex. So it may make sense to add a
>> lockdep_assert_held() for that.
>>
> Will add.
>
>> You are right that there are problems WRT the stability of cgroup_is_populated() value.
>>
>> I think "cgrp->nr_populated_csets + cs->attach_in_progress" should be almost stable for the cgroup
>> itself with cpuset_mutex, but there can be a small timing window after cpuset_attach(), but before
>> the stat is updated where the sum is 0, but there are actually tasks in the cgroup.
>>
> Do you mean there’s a small window after ss->attach (i.e., cpuset_attach) where
> cgrp->nr_populated_csets + cs->attach_in_progress could be 0?
>
> If I understand correctly:
>
> ss->can_attach: cs->attach_in_progress++, sum > 0
> css_set_move_task->css_set_update_populated: cgrp->nr_populated_csets++, sum > 0
> ss->attach->cpuset_attach: cs->attach_in_progress--, sum > 0
>
> What exactly is the small window you’re referring to where the sum equals 0?
Yes, the nr_populated_csets is incremented before calling 
cpuset_attach(). I think I had mixed up the ordering. Thanks for the 
clarification.
>
>> For "cgrp->nr_populated_domain_children + cgrp->nr_populated_threaded_children", it also has the
>> problem that the sum can be 0 but there are attach_in_progress set in one or more of the child
>> cgroups. So even with this patch, we can't guarantee 100% that there can be no task in the partition
>> even if it has empty effective_cpus. It is only a problem for nested local partitions though as
>> remote partitions are not allowed to exhaust all the CPUs from root cgroup.
>>
>> We should probably document that limitation to warn users if they try to create nested local
>> partitions where the parent partition root of the child partitions has empty effective_cpus.
>>
> Hmm, but it was what the commit e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty
> cpuset.cpus.effective") allowed, and it makes sense.

This commit will allow user to not waste a CPU if users want to set up a 
nested local partitions where there is no task in some intermediate 
levels. One way to address this gap is to iterate down the cpuset 
hierarchy to check if any of its attach_in_progress count is set. So it 
is a solvable problem.

There is also a flip side where cgroup_is_populated() returns a non-zero 
value, but the tasks are actively being moved away. This false positive 
is less a problem even though it can cause a failure in distributing out 
all the CPUs to child partitions. The users can retry and it should work 
the second time.

Cheers,
Longman



