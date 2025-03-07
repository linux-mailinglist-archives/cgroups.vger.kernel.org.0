Return-Path: <cgroups+bounces-6895-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2923A56BC4
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2544F179829
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA18821D3C0;
	Fri,  7 Mar 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfOIidRX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394C21CA08
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360775; cv=none; b=lIzIZIbWzUmIrmWp7iZUWUqxLx8DeP6LT91+6hHRTLo8XATPFapRZ269KSk8jiba8J4L3X/gCZGayCmXQUHpsxk4SWWAA1pGuGZ7gLI6oXNlc1VOhf3TX7GDKlsBCt76pWJeEBg0Ilz7otSQKyXyG9vKAlPM/QBmcBaLXtrfgxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360775; c=relaxed/simple;
	bh=gYhaNaVy80cladvz8VcRr5nT9/6t+nPTFWqppoCVnOU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BfZHtc+vZcjm2VBZUbK1GZ3wr28Yeg+Mjgd+JsNcBR4u4KZQp9F2/+EjSrEuC8UX+KMM7000aO3sb+KDmQO87n7gfvdPU8qLlvXkPJxQysspchLK5SD6ybhLrY2TuG3gIQXSjfjol+llrz3E29+MMb1qrRknb/XemKThUrSmbO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfOIidRX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/voaY1C+JOHxKM+JbIxct2yY2wAsdgT0ed4f25T51P4=;
	b=LfOIidRXqnb2POzHfRn9Pvvp8qD/7+qOO2SE7F/NUyUNtBHJ5m0Kt06UaroZP6ZJB+vvCX
	jr3HYBgkB9Dnk/xWEdm0nIXwJ6haTchjD1obA0+5iLnSqVSFGmillb9dvqd8MPA03oCoVH
	O45ZzU2RbYNLgXlW3E76RUB3GHfneyg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-sWF04x2zNsGXiNNsb5s0IQ-1; Fri, 07 Mar 2025 10:19:31 -0500
X-MC-Unique: sWF04x2zNsGXiNNsb5s0IQ-1
X-Mimecast-MFC-AGG-ID: sWF04x2zNsGXiNNsb5s0IQ_1741360771
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e90788e2a7so738216d6.0
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 07:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360770; x=1741965570;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/voaY1C+JOHxKM+JbIxct2yY2wAsdgT0ed4f25T51P4=;
        b=dYfD5dEzWx3knv6Vt+kYLfMmc68ls05zHO7NyAi+faYgD7uJpTDaXcrB825UyA4o3f
         +liXWbSCJunp9wAl09TwqJnq9gWvusNQLJ9e2Znwel//cr4H4wtA9dhL2iIguSK1oJUZ
         QCHGSIQxvCd0e39YTfGgaZecBaC9RQ2FvWZMkJkbF/ppqTtpbKUI96/nXV5E5/WBhchF
         v9vfQ4VT2w4eBEpO21U7qH83954htevFbcKtiXUf5Huv+GcxToghF0WGikQ9frktM9bv
         dsvFqttg6lbxHx307EaPi6fDBVbgKbMWPgBwWHAoZjj2TGGccNe5fJ5r3gOzOIqlW8eG
         NMIg==
X-Forwarded-Encrypted: i=1; AJvYcCX+RgvXd0NEfS7VplraZyrbIF/5iJ6/jLeMZs+h6YuW6WkWZwJtZ6+JbzjMYbRkYYXl/NHJ3ZSx@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfugaz34YpQBYsbWNVQHhYmoqLBRPJoFaOabDMM2SnQO9exBD
	08QN0QIK0LNMZWzC9JhculJpnJdEVC34zwuWI1JRDZsQAXGyxZ839agAK4uhpFFimglhp77qSN3
	dvuTIC4JwXt5hw38KY4Kjy+EIWF4Xllbpsh96FYemZuRHFMADzqLtFZipZKcmdak=
X-Gm-Gg: ASbGncvQ4MXyk7IlKksdzATr0bUh3SJBXLxdsohvbXbfuNyR7o+g+BL359J3/UD6XcI
	OkNYMl2PVM4RBfsv0UzroGI3khPVro7d+ntVBTKnqAG1J8TaecNsxYqg16hOGmAGpFsySHhgwm0
	eqNn4ZzakV1wmi1pUsqAC6zo0YkxcMLu4ii9KTp7+YcrTDbBnXlS37Wc/kZVFfbCpeBGt0k023c
	dV4QPQbUyxfJZ54VcfQIwnkSy2FpgvFt6xduyh0z+eaaueDdcv4u7wRL4GRYhuPVOqeIvR3fZ8r
	A1CeqOhbNUIQBcM7pkKus4rfjDAOC86V0OYAjueiRqm52WtMFpiqXivT0r8=
X-Received: by 2002:ad4:5be2:0:b0:6e8:af23:b6f1 with SMTP id 6a1803df08f44-6e8ff738403mr48320706d6.10.1741360770525;
        Fri, 07 Mar 2025 07:19:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7vgy3SRMmsojlqsMkxhqU/1Y5Pf8CiqlPcyisxnRS9jhc3xrWLOs4SjjO+5bclG8zm4TyGA==
X-Received: by 2002:ad4:5be2:0:b0:6e8:af23:b6f1 with SMTP id 6a1803df08f44-6e8ff738403mr48320296d6.10.1741360770032;
        Fri, 07 Mar 2025 07:19:30 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f715b6acsm20401296d6.74.2025.03.07.07.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:19:29 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4c63551b-4272-45f3-bb6b-626dd7ba10f9@redhat.com>
Date: Fri, 7 Mar 2025 10:19:28 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
To: Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Phil Auld <pauld@redhat.com>,
 luca.abeni@santannapisa.it, tommaso.cucinotta@santannapisa.it,
 Jon Hunter <jonathanh@nvidia.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <20250306141016.268313-3-juri.lelli@redhat.com>
 <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
Content-Language: en-US
In-Reply-To: <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 3/7/25 10:11 AM, Waiman Long wrote:
> On 3/6/25 9:10 AM, Juri Lelli wrote:
>> Create wrappers for sched_domains_mutex so that it can transparently be
>> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
>> do.
>>
>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow 
>> earlier for hotplug")
>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>> ---
>> v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
>>            either in that case
>> ---
>>   include/linux/sched.h   |  2 ++
>>   kernel/cgroup/cpuset.c  |  4 ++--
>>   kernel/sched/core.c     |  4 ++--
>>   kernel/sched/debug.c    |  8 ++++----
>>   kernel/sched/topology.c | 12 ++++++++++--
>>   5 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 9632e3318e0d..d5f8c161d852 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -383,6 +383,8 @@ enum uclamp_id {
>>   extern struct root_domain def_root_domain;
>>   extern struct mutex sched_domains_mutex;
>>   #endif
>> +extern void sched_domains_mutex_lock(void);
>> +extern void sched_domains_mutex_unlock(void);
>
> As discussed in the other thread, move the 
> sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block 
> and define the else part so that it can be used in code block that 
> will also be compiled in the !CONFIG_SMP case.
>
> Other than that, the rest looks good to me.

Actually, you can also remove sched_domains_mutex from the header and 
make it static as it is no longer directly accessed.

Cheers,
Longman


