Return-Path: <cgroups+bounces-6978-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7CBA5C436
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 15:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FDC1899ADA
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F1925C6FD;
	Tue, 11 Mar 2025 14:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W45wp3tO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE051BB6BA
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704718; cv=none; b=YW/3OroBiockm4XEa3/et1C5AnZWmYd5ufEJpWmBC/GYC8P/9DTdfFSNHhalK7iTayyNNWp6JwAJDn9cHrR+nVf5zd5wIgQO0jyIL9zxhkNhaLv+lVOoKVNvDkgnPvun/JluIXRqAbTdfXLC5ycvKQkkLfaoaro2PIFc0ch76Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704718; c=relaxed/simple;
	bh=6P6c6IwKF2if8Jy7+GXDDsr374M4nCzdOeKbK7tTREo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=j3lfvzTrVfjBeWQkc1wT5IT+hrDkv/FKmChx4dK3UXHjrh4X5fk1w1CPyKnDqPic/MZZKyg1wFdkzElQUDNq/o4BrxJ4yjtJpjvjpsAr5pn7/FCT8HRHgheQIFQilPe0KeHRriiKKOs3a2lARaFCihYi96UcFtBrA7/O6SKKbbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W45wp3tO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741704715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GufUlDMXT/1M/VIjSRRRd41GXoqqZjS4P3HGXBCT2uM=;
	b=W45wp3tOQFiqu3plSPg9+siDhKXBUYfFQLwJCSJxpU3gx9hx8B0oF8kXY8NwpTipsSizjm
	T4f/0URZkOGhjyEDxh8FthKydwbFJnk4c3wgOqlcv/lFSUPR9FsqIZ9Kd6CJrptXpOgzaw
	QEJn6V5MGzHpmTWmEzssol9QbrbT6hI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-TRJ-lOAJOYCYS8xRVwomFA-1; Tue, 11 Mar 2025 10:51:54 -0400
X-MC-Unique: TRJ-lOAJOYCYS8xRVwomFA-1
X-Mimecast-MFC-AGG-ID: TRJ-lOAJOYCYS8xRVwomFA_1741704714
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e91b1ddb51so43874666d6.0
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 07:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704714; x=1742309514;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GufUlDMXT/1M/VIjSRRRd41GXoqqZjS4P3HGXBCT2uM=;
        b=GsnYKK3U7AQt1vPQsLB8jE3tPmVieB3lx6nptTHeND1Rub1s4L5+6PpharhwjCUuRH
         tjCtJoNhLibq2zL86v97RjU0mld0DtEYlzM/lpAmitx5PWI8svRcvUCCBG65Tw/A0pcf
         iJHxzLJ3F4wU2F3JBct1+Q7mvKrnNg5dl7aN0mMrTXChAa+ZZekbQ45CoMHwoqRrz1Z4
         f/s7oeLWaXNOIAlGIg4Sc/uATGP3EbcFjAUhlR+XNKdBUvAXhnbrod9ejcZuVjXLAgJh
         IRd7rVvZUaw3rH1jbILTbnU92HFRT1+fQZkwAj223m8PMx1ofY7uuwHtGsR+51lpiNHk
         dQ4w==
X-Forwarded-Encrypted: i=1; AJvYcCV8ChMU1MEO8b7jQcAIGrxvh7OO9O/F4p4oTpAzMz7Ke0nFMIchlYZiR6hJEgAdmgXxO9lU58rF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZVmazi5XtMlgoZmTEloKlWipIIyHCrrVxL+MAUE65iFsPecq
	0yjzUv/kRvPkgsOodKrZ6OhR1ef+NCgPMJJsAA7rrhSiJAQj/qBv8OfnelWdy1tYfk+ApvKoiDL
	ph2DKojG2797X4EuNq4do2VSR+rWuTJfhVRGZf4PPMJF+0dI/9Y+9dHg=
X-Gm-Gg: ASbGnctlBM3rUwsLbjPDWYiRP2tD9eqSxNCwmC17bzCEhCSfJYLHesy4kMuQEBTQfAQ
	HyTKny2D3Op0BeqI3fJIB5D5ERtN97QrPft1efPRb+U3cj+9b9S1k3eHS96oSnoqgCsPzsj6XDI
	RmZTg7UZWl5QBsOsnVPI2zMdU1U26CWD2G8CpbTPjivbvrQMKNURuqahM27+u5nKbp2tU2hFok8
	5TgHNOw9k8vQzo/cZCGJY/YHcro9v8frvLIfv5OKOFJC2Bld9hYSw+fNn01IGRn/p43R01GQGNF
	74+RN7RcGc/giVmD7rVfWVDOJdCE8I6WXbEEbhbqczL9+fih7TfTLF1jOqSt3g==
X-Received: by 2002:ad4:5d4e:0:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6ea2dd1e43fmr47780226d6.10.1741704713866;
        Tue, 11 Mar 2025 07:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER+qrQDpo55ZhHiyPPq04O5V2epge8MNIv0W7WA80QT0Yqq/w+t4w/lAFSZRPF845NmZLaNg==
X-Received: by 2002:ad4:5d4e:0:b0:6e8:fa33:2969 with SMTP id 6a1803df08f44-6ea2dd1e43fmr47779826d6.10.1741704713440;
        Tue, 11 Mar 2025 07:51:53 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e90f82a582sm45342366d6.27.2025.03.11.07.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 07:51:52 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7fb20de6-46a6-4e87-932e-dfc915fff3dc@redhat.com>
Date: Tue, 11 Mar 2025 10:51:51 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] sched/deadline: Rebuild root domain accounting
 after every update
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Waiman Long <llong@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
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
References: <20250310091935.22923-1-juri.lelli@redhat.com>
 <Z86yxn12saDHLSy3@jlelli-thinkpadt14gen4.remote.csb>
 <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
 <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
 <fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com>
 <Z9Alq55RpuFqWT--@jlelli-thinkpadt14gen4.remote.csb>
 <be2c47b8-a5e4-4591-ac4d-3cbc92e2ce5d@redhat.com>
 <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
Content-Language: en-US
In-Reply-To: <e6731145-5290-41f8-aafb-1d0f1bcc385a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 9:29 AM, Dietmar Eggemann wrote:
> On 11/03/2025 13:34, Waiman Long wrote:
>> On 3/11/25 7:59 AM, Juri Lelli wrote:
>>> On 10/03/25 20:16, Waiman Long wrote:
>>>> On 3/10/25 3:18 PM, Waiman Long wrote:
>>>>> On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
>>>>>> On 10/03/2025 10:37, Juri Lelli wrote:
>>>>>>> Rebuilding of root domains accounting information (total_bw) is
>>>>>>> currently broken on some cases, e.g. suspend/resume on aarch64.
>>>>>>> Problem
>>>>>> Nit: Couldn't spot any arch dependency here. I guess it was just
>>>>>> tested
>>>>>> on Arm64 platforms so far.
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>>>>>>> index 44093339761c..363ad268a25b 100644
>>>>>>> --- a/kernel/sched/topology.c
>>>>>>> +++ b/kernel/sched/topology.c
>>>>>>> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int
>>>>>>> ndoms_new, cpumask_var_t doms_new[],
>>>>>>>         ndoms_cur = ndoms_new;
>>>>>>>           update_sched_domain_debugfs();
>>>>>>> +    dl_rebuild_rd_accounting();
>>>>>> Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
>>>>>> barf when called via cpuhp's:
>>>>>>
>>>>>> sched_cpu_deactivate()
>>>>>>
>>>>>>      cpuset_cpu_inactive()
>>>>>>
>>>>>>        partition_sched_domains()
>>>>>>
>>>>>>          partition_sched_domains_locked()
>>>>>>
>>>>>>            dl_rebuild_rd_accounting()
>>>>>>
>>>>>> ?
>>> Good catch. Guess I didn't notice while testing with LOCKDEP as I was
>>> never able to hit this call path on my systems.
>>>
>>>>> Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will be
>>>>> called without holding cpuset mutex.
>>>>>
>>>>> Well, I think we will need an additional wrapper in cpuset.c that
>>>>> acquires the cpuset_mutex first before calling
>>>>> partition_sched_domains()
>>>>> and use the new wrapper in these cases.
>>>> Actually, partition_sched_domains() is called with the special
>>>> arguments (1,
>>>> NULL, NULL) to reset the domain to a single one. So perhaps something
>>>> like
>>>> the following will be enough to avoid this problem.
>>> I think this would work, as we will still rebuild the accounting after
>>> last CPU comes back from suspend. The thing I am still not sure about is
>>> what we want to do in case we have DEADLINE tasks around, since with
>>> this I belive we would be ignoring them and let suspend proceed.
>> That is the current behavior. You can certainly create a test case to
>> trigger such condition and see what to do about it. Alternatively, you
>> can document that and come up with a follow-up patch later on.
> But don't we rely on that partition_sched_domains_locked() calls
> dl_rebuild_rd_accounting() even in the reset_domain=1 case?
>
> Testcase: suspend/resume
>
> on Arm64 big.LITTLE cpumask=[LITTLE][big]=[0,3-5][1-2]
> plus cmd line option 'isolcpus=3,4'.
>
> with Waiman's snippet:
> https://lkml.kernel.org/r/fd4d6143-9bd2-4a7c-80dc-1e19e4d1b2d1@redhat.com
>
> ...
> [  234.831675] --- > partition_sched_domains_locked() reset_domain=1
> [  234.835966] psci: CPU4 killed (polled 0 ms)
> [  234.838912] Error taking CPU3 down: -16
> [  234.838952] Non-boot CPUs are not disabled
> [  234.838986] Enabling non-boot CPUs ...
> ...
>
> IIRC, that's the old DL accounting issue.

You are right. cpuhp_tasks_frozen will be set in the suspend/resume 
case. In that case, we do need to add a cpuset helper to acquire the 
cpuset_mutex. A test patch as follows (no testing done yet):

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index c414daa7d503..ef1ffb9c52b0 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -129,6 +129,7 @@ extern void dl_rebuild_rd_accounting(void);
  extern void rebuild_sched_domains(void);

  extern void cpuset_print_current_mems_allowed(void);
+extern void cpuset_reset_sched_domains(void)

  /*
   * read_mems_allowed_begin is required when making decisions involving
@@ -269,6 +270,11 @@ static inline void rebuild_sched_domains(void)
         partition_sched_domains(1, NULL, NULL);
  }

+static inline void cpuset_reset_sched_domains(void)
+{
+       partition_sched_domains(1, NULL, NULL);
+}
+
  static inline void cpuset_print_current_mems_allowed(void)
  {
  }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7995cd58a01b..a51099e5d587 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1076,6 +1076,13 @@ void rebuild_sched_domains(void)
         cpus_read_unlock();
  }

+void cpuset_reset_sched_domains(void)
+{
+       mutex_lock(&cpuset_mutex);
+       partition_sched_domains(1, NULL, NULL);
+       mutex_unlock(&cpuset_mutex);
+}
+
  /**
   * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the 
cpuset.
   * @cs: the cpuset in which each task's cpus_allowed mask needs to be 
changed
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 58593f4d09a1..dbf44ddbb6b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8183,7 +8183,7 @@ static void cpuset_cpu_active(void)
                  * operation in the resume sequence, just build a 
single sched
                  * domain, ignoring cpusets.
                  */
-               partition_sched_domains(1, NULL, NULL);
+               cpuset_reset_sched_domains();
                 if (--num_cpus_frozen)
                         return;
                 /*
@@ -8202,7 +8202,7 @@ static void cpuset_cpu_inactive(unsigned int cpu)
                 cpuset_update_active_cpus();
         } else {
                 num_cpus_frozen++;
-               partition_sched_domains(1, NULL, NULL);
+               cpuset_reset_sched_domains();
         }
  }

Cheers,
Longman

>


