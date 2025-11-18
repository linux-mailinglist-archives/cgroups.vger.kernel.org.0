Return-Path: <cgroups+bounces-12064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D9BC6A0AE
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 15:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90887346A09
	for <lists+cgroups@lfdr.de>; Tue, 18 Nov 2025 14:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F4532340D;
	Tue, 18 Nov 2025 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jWIZQOqv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JVQWZH26"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2187B24A066
	for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476440; cv=none; b=EtMdN97Pqe2Skt1O46PEumGmZrvUwqcEGtJVdUhSax+ekTOnH8aa1VqOcUE14K0+0GMgt+RuQgJra9dqOCyeNxsxHM0ANFTGGR3+/YBQ58ceOqeQPIg568Z1tfyUWFwKmUFHqPt3XLPcIli6qSTUK0vrrNJNZTauJ5CV96XmIBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476440; c=relaxed/simple;
	bh=+6/xDSclZh/Vt2rIUIELMJl8megBMi2ETzaqvV1fFoA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DOJYhulhBdgaNO+YeMe5DiRf/u0RqP9QsUmIwD64ehilUmEmrqJG2cVYYoQdNPo8m0Jv3QhSnAP/FFEHbBHnQrHBUT5huWsuuffEBJGda1HExwnaZqiE3vEpcV+68md47zWtg6o9Y33OWi+LOThuXqkSegsW4MQDvUyTHMnC95U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jWIZQOqv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JVQWZH26; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763476438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFagp57D9f8DbBWeri59VX6dKVJnpIU1qigZXoJ3IUw=;
	b=jWIZQOqvPlx+4J83k/Y3gHFr4yKT7yq+hyRW5eHkeqlmTAWkfJt42/cTUxs+cV2qJX7sK7
	Gltb9eaS8HfYPf+BXSmZ/s7UYVEZgqKJey/9zKDay7LqYOgI72RYDTFr9AaawvEPWy1YyX
	Yqyhwv5N52hY/9onqv07IWltc+zcY58=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-0kLXpE8mPWO-h8Mgx4eZsg-1; Tue, 18 Nov 2025 09:33:56 -0500
X-MC-Unique: 0kLXpE8mPWO-h8Mgx4eZsg-1
X-Mimecast-MFC-AGG-ID: 0kLXpE8mPWO-h8Mgx4eZsg_1763476436
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8823f4666abso127308656d6.0
        for <cgroups@vger.kernel.org>; Tue, 18 Nov 2025 06:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763476436; x=1764081236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KFagp57D9f8DbBWeri59VX6dKVJnpIU1qigZXoJ3IUw=;
        b=JVQWZH26NDATlEPzpn7ZyAklQWTXrrM9odERZb3MMMFEjAw6n1ymh47RBbFxvKWiE+
         qlWlLzOeWeMHwhpzZcJ0CmRD/bf938c/j627qBbU2NsaPuvQjwR6m+zqqU1oArFLA1W3
         h7cK0okR2dybdmN2+mj3KaB3z+UAh33q8V7tRPb8x4NwjJltnQh2Bqcp1ygF8fcwvyoc
         qBPXfDlqUgOq12yRs/WatN+0WoHVlf1581fBGKMFxFuvyT3GhcHT3dNofwInowCI4C7E
         ZtnTYngcodJbwinY/zrCn6n4K1/QS1uUGN15gqkwyviJxQkMUiWJp1JMFyaAbLscZrI2
         szdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763476436; x=1764081236;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFagp57D9f8DbBWeri59VX6dKVJnpIU1qigZXoJ3IUw=;
        b=K0r8LrSiFphNHTJ8OeEsuOOh/jJxlimKWYASFgPoqz66xxTizn0b2iYDFTCEE4idJH
         XzPjUO2aJ2LnJVhBzN7IMSo2D/9Iew/+MdZecbdNESt979RMZXc5t8npJbVW158F5ZEe
         qqQyKCIKd4zuZ7oBUvn8tbSSFdn1n4c/bkOXK6GNnVydh/rF3lxHDmhVDlRGAbnW3Nog
         9gpOrF5MOY+GQFJKFWKsG6RISQQRS7W9YMlokVEmX+wsXeHrdqomUO0UuI9VRAncKiJM
         B9EMXuAuV4TV9rQ1z+bCTRf194St2ZZsjjzBzBa9nynsYy7tE0OdMjdO274ILPfe+rln
         JcRA==
X-Gm-Message-State: AOJu0YwoicWyxp7W65nftQKH3akgC2hTgM4+jSqdSZ1flI/D4F8Abzsm
	uK9rLdZnuN9mcUlgbfjmID7Non1VXzd5cng7A27o0jm7tMT4FINrUNl9S2RLm4v61L8zSgIl039
	rM4AwQt7phqxYDJXX6iJiFl+AE49+1xsiwN3gOkKns2XIWmZnNucBjWM+Fnw=
X-Gm-Gg: ASbGncuSQflyTkur/KtECGruL61wphhdj0i20V2QWRawOOQVwOS9ZHvpMctgarq2dcC
	HFiauBxOlGc9SfIof4iqkNALyauzoHt0moecY+xfVUKO0KWq6qbrF2jTW9nhZJoUds6nnJbXlcF
	oNrU5BjdHp4BRFR5hutHhfYm3piXvDDbMFWEFoM2hzHcKMofdwsAn5prnZah8GZrivFzyfR8YEV
	HUyUBp3UquFfj608IBrssR0AFIWMm59yNkm/d2gMh8dTd01ShmXMJAIi+hdNuGQcZ4VH8lA158n
	erU/sqLHhyZPubmO9ALw4QMn02tMTa9kP3+NNu1V7GsJRT2XT+PhjvRzWQB6Yo72IifNZXkTB2Q
	71tWF0GhUkSI0mrQIuXa6nPIOsnCaRjuYJHmtJ48JFOYQ1Q==
X-Received: by 2002:ac8:5981:0:b0:4ee:13a1:93bb with SMTP id d75a77b69052e-4ee13a19c99mr139774411cf.25.1763476436198;
        Tue, 18 Nov 2025 06:33:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu+WPeDK2KDgt/AgL9GSl5s+DWTeOdUoi90amK/dDfuB4J0Tcmhhdoa7DI/26KDpc10w7qIg==
X-Received: by 2002:ac8:5981:0:b0:4ee:13a1:93bb with SMTP id d75a77b69052e-4ee13a19c99mr139773961cf.25.1763476435744;
        Tue, 18 Nov 2025 06:33:55 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862c9854sm114279556d6.4.2025.11.18.06.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 06:33:55 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <45bdbbd5-9c82-4f5f-864b-9f01e356d8ef@redhat.com>
Date: Tue, 18 Nov 2025 09:33:53 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 1/2] cgroup/cpuset: Introduce
 cpuset_cpus_allowed_locked()
To: Pingfan Liu <piliu@redhat.com>, Waiman Long <llong@redhat.com>
Cc: cgroups@vger.kernel.org, Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 mkoutny@suse.com, linux-kernel@vger.kernel.org
References: <20251117092732.16419-1-piliu@redhat.com>
 <20251117092732.16419-2-piliu@redhat.com>
 <97ec2e86-cb4f-4467-8930-d390519f12a6@redhat.com>
 <CAF+s44SAPA+PgKBGHd_5853JOHyFxLasKXYegJSWyrkKsDYg1w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAF+s44SAPA+PgKBGHd_5853JOHyFxLasKXYegJSWyrkKsDYg1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/18/25 1:30 AM, Pingfan Liu wrote:
> On Tue, Nov 18, 2025 at 4:37 AM Waiman Long <llong@redhat.com> wrote:
>> On 11/17/25 4:27 AM, Pingfan Liu wrote:
>>> cpuset_cpus_allowed() uses a reader lock that is sleepable under RT,
>>> which means it cannot be called inside raw_spin_lock_t context.
>>>
>>> Introduce a new cpuset_cpus_allowed_locked() helper that performs the
>>> same function as cpuset_cpus_allowed() except that the caller must have
>>> acquired the cpuset_mutex so that no further locking will be needed.
>>>
>>> Suggested-by: Waiman Long <longman@redhat.com>
>>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
>>> Cc: Waiman Long <longman@redhat.com>
>>> Cc: Tejun Heo <tj@kernel.org>
>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>>> Cc: "Michal Koutný" <mkoutny@suse.com>
>>> Cc: linux-kernel@vger.kernel.org
>>> To: cgroups@vger.kernel.org
>>> ---
>>>    include/linux/cpuset.h |  1 +
>>>    kernel/cgroup/cpuset.c | 51 +++++++++++++++++++++++++++++-------------
>>>    2 files changed, 37 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
>>> index 2ddb256187b51..e057a3123791e 100644
>>> --- a/include/linux/cpuset.h
>>> +++ b/include/linux/cpuset.h
>>> @@ -75,6 +75,7 @@ extern void dec_dl_tasks_cs(struct task_struct *task);
>>>    extern void cpuset_lock(void);
>>>    extern void cpuset_unlock(void);
>>>    extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
>>> +extern void cpuset_cpus_allowed_locked(struct task_struct *p, struct cpumask *mask);
>>>    extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
>>>    extern bool cpuset_cpu_is_isolated(int cpu);
>>>    extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
>> Ah, the following code should be added to to !CONFIG_CPUSETS section
>> after cpuset_cpus_allowed().
>>
>> #define cpuset_cpus_allowed_locked(p, m)  cpuset_cpus_allowed(p, m)
>>
>> Or you can add another inline function that just calls
>> cpuset_cpus_allowed().
>>
> It may be better to make cpuset_cpus_allowed() call
> cpuset_cpus_allowed_locked(), following the call chain used under
> CONFIG_CPUSETS case.

That is fine too.

Cheers,
Longman

>
> Thanks,
>
> Pingfan
>


