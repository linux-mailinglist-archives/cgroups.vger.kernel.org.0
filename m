Return-Path: <cgroups+bounces-6898-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2214A56DE0
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 17:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD79E173BCB
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D132417C3;
	Fri,  7 Mar 2025 16:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YVMAxB6A"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D2A23E227
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365256; cv=none; b=BjjRLBdkp0Jl+OflUr1TRxz+6a5r5TwQXU+UzxsIwm0zq+mlAKEGM2lUogL3bheuNnCHx37DJMXrlIs0eS/pgKwyHq5kPLxd8Zluu06jnCQWaTICN8cXeaAdX7L0X2iPf6naFIADODOeoi52Bs3yPxJnZaFQGfA5+TNdHjqoR5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365256; c=relaxed/simple;
	bh=H8uzd5peODCzukZg6jl5fU/M2HJxgbzQtlgwHrd4fKA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lSXgrmNJyIkMVmJuQHVaKdtMLV1x0hFWMMkgAO+240Cc18Q29HhDA4A1OnJ7tegQL1mUINvF9rg2+wE58w/C2pxFTaK2DaDXM4SbqnXsQTuYSlT1+vpu4dWEYrK/SlLj0d+QIevVJ62C7r4FPeHosRi1PKohyYI7FgnhEOWnuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YVMAxB6A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741365253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I29SMSMVFttr10Ul27KnYZOPsk3TfrDUd1/Dj5UPrMM=;
	b=YVMAxB6A8vA+RMs6QhMhHepuOMpHA43TtnjOuX1A7f/EekCasy8ygS9gOW2AxAYplbAvPe
	R7rZkM0cLS/wu4GUObtJrc9pjeDiriSOs9aSu1nVEVjiHzd6Qv1Dc3XsIujd6dKTY+a1md
	5X/ll0SfPwV7bqJ+974VDFFfYGoQ44s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-SyAX_JJdPnycxfwIDL1wRw-1; Fri, 07 Mar 2025 11:34:12 -0500
X-MC-Unique: SyAX_JJdPnycxfwIDL1wRw-1
X-Mimecast-MFC-AGG-ID: SyAX_JJdPnycxfwIDL1wRw_1741365252
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-474f1ef0b7fso40306511cf.3
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 08:34:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365252; x=1741970052;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I29SMSMVFttr10Ul27KnYZOPsk3TfrDUd1/Dj5UPrMM=;
        b=jEhLVo5+ToFCh2pPPpRIgxLOzLdSP5wODO8zWqtKHyAvH4qBrqREtQEtHRfGmVIPEj
         XBXcGe1z0QM+bqWU+YgHn2aguVPIodImc4O4SCqrD651Ws99ynzHwK2CuSIGX7kt5ni8
         7MFqrcGgdyqHvZ99soNBURF++xm0S977uNn/FMk8k7an2h4hgRUSfGC8XjsjEPZ1MLqF
         xG7jersTEUs1WdzQwIkPCos+CPa52vhASQy3gzD1d+IyiVtKHU+EY2CQaSkc0eNnMcyS
         AQNcPVzkzdXFqdtiYX89xQIvGNHzSJ8n12XKk3ZuRs9hCfvcpz5tq06MMijN7dSrAk9s
         DT8w==
X-Forwarded-Encrypted: i=1; AJvYcCVzI5HTPDbyfoNiR61mNgpAVFxBtnlABQDHb+8AerfdxxqcyhKOHSS0qz3TKirE5pdLsYr3UjgW@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMIVghhBMAWSNswEOTEVSRpXLUSZb2wMD4KHjPEBGSxtJfA2S
	1lvcVPDAfRG4uJKg7ItGuWisWZVxZxv1bdZ535s+/ard+CwdRoRZI+vuZXRH2l879JjY8y+vBdo
	0/O+ox2vpU8FEzwMxcn/Cu3FAeKduxw8f/e67o78Q8RGQslPIAagJ2K8=
X-Gm-Gg: ASbGncvKm1EE64Dh5fhyu/2D8Jc0xfCXocM9asYIC4m01+hLap3u9gdr03Gh78aPvzn
	8K+APK7XK6U3xDKdd8SMr8LlD/NYd6pPdk+P6RqgSdkI0oLGndPRqE3eZZiFOC/A9YQijv2fAi2
	dBkCLeWUsEbJNcA67w309I7rzaFCkAlAxZfI6Q+SQXImKSQfuv4YhF9xDb1vYj1UWwYkIuekF8L
	7SRP/s08NxoyDFFYuFVjj8JUCNEkILaf9GaMabqKE9xo2cM5v19YdZ99U52DJ+H/nwIOAsFAti2
	OHpaQkhiOBYeNtqLypCSigFoWCCPqyyu1ELXx+6GW3pylNFaVFSehM+iznY=
X-Received: by 2002:ac8:5708:0:b0:472:1814:3fc1 with SMTP id d75a77b69052e-476109b1b81mr46175991cf.31.1741365251788;
        Fri, 07 Mar 2025 08:34:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyiT6kSkHsRD2rq0rc8kZ0edEmUm64eP/RfjPLUfuJmGieySNXWs5OYJHIRlasV7cNaGtGrA==
X-Received: by 2002:ac8:5708:0:b0:472:1814:3fc1 with SMTP id d75a77b69052e-476109b1b81mr46175551cf.31.1741365251451;
        Fri, 07 Mar 2025 08:34:11 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4751d9a89acsm22570861cf.44.2025.03.07.08.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:34:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <67a401e5-6cef-4f4c-a31b-7c2793666e40@redhat.com>
Date: Fri, 7 Mar 2025 11:34:09 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] sched/topology: Wrappers for sched_domains_mutex
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
 <4c63551b-4272-45f3-bb6b-626dd7ba10f9@redhat.com>
 <Z8sX5VtKuBD1BoiB@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <Z8sX5VtKuBD1BoiB@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/7/25 10:59 AM, Juri Lelli wrote:
> On 07/03/25 10:19, Waiman Long wrote:
>> On 3/7/25 10:11 AM, Waiman Long wrote:
>>> On 3/6/25 9:10 AM, Juri Lelli wrote:
>>>> Create wrappers for sched_domains_mutex so that it can transparently be
>>>> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
>>>> do.
>>>>
>>>> Reported-by: Jon Hunter <jonathanh@nvidia.com>
>>>> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow
>>>> earlier for hotplug")
>>>> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
>>>> ---
>>>> v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
>>>>             either in that case
>>>> ---
>>>>    include/linux/sched.h   |  2 ++
>>>>    kernel/cgroup/cpuset.c  |  4 ++--
>>>>    kernel/sched/core.c     |  4 ++--
>>>>    kernel/sched/debug.c    |  8 ++++----
>>>>    kernel/sched/topology.c | 12 ++++++++++--
>>>>    5 files changed, 20 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>>> index 9632e3318e0d..d5f8c161d852 100644
>>>> --- a/include/linux/sched.h
>>>> +++ b/include/linux/sched.h
>>>> @@ -383,6 +383,8 @@ enum uclamp_id {
>>>>    extern struct root_domain def_root_domain;
>>>>    extern struct mutex sched_domains_mutex;
>>>>    #endif
>>>> +extern void sched_domains_mutex_lock(void);
>>>> +extern void sched_domains_mutex_unlock(void);
>>> As discussed in the other thread, move the
>>> sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block
>>> and define the else part so that it can be used in code block that will
>>> also be compiled in the !CONFIG_SMP case.
>>>
>>> Other than that, the rest looks good to me.
>> Actually, you can also remove sched_domains_mutex from the header and make
>> it static as it is no longer directly accessed.
> Apart from a lockdep_assert_held() in cpuset.c, no? Guess I can create a
> wrapper for that, but is it really better?

I forgot about that. Please ignore this comment.

Thanks,
Longman


