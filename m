Return-Path: <cgroups+bounces-5543-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 578AB9C7AEF
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 19:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177872816F2
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 18:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13579204005;
	Wed, 13 Nov 2024 18:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR/Ih2EJ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C51FE0F8
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521966; cv=none; b=JgNHyrWdf9j3HMt+xBIbQyMyv4tIfG5/tFmFBjNPwhULlYjvN2QFMkCsVuu0rmcteXr6GkNIC6HxH7NxjPZstUbhBkg7wzf+hGyDQ4R+SC1fV5FUTqfkXhWX2SeCoGKHGS5EXgFwHNMGmajvNO1vusIybLkl7s98FLRTc5IcIt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521966; c=relaxed/simple;
	bh=2sbg3MO0sxlZtCSjsbxleK8gzFWtwrFArn8wCj5HUNQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sNGzfLds47xHarrmemMjimExh98GSa90wGnqPTdKTST3EcwQ6FbsEjlI8Uj/gRAIu/OwYbwh2CPuSOkdA7NQLGqbPiQ1aR2ELvXHPXP2/N09otaXjymbn0BFi0G8nSRov4r4ecfqRH2n/MTontrXpiWuMfcY4v6GYrnc4ZwfPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR/Ih2EJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731521963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1kjlPsKv9zsmgwnAdMucdyKyd6S8wtPHHvn3MwXuMoY=;
	b=DR/Ih2EJ0k3T9OSjaCUxjwEz8u5JKruscdkY/7xwg+IZL4ST25+f5m6OEyt4wXx7GIfav7
	f1+o0Mx3qQaPF5QIY7Lf/RNrqTN0wEbm4ZN21D82AJ+DqXc53O9Y/gWU6euzN+1nAVBHL6
	s0CBq+YO/m6w0raEa+mQGNlzqQp/WTE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-133YQXUgOai0M3wBbqo2rA-1; Wed, 13 Nov 2024 13:19:22 -0500
X-MC-Unique: 133YQXUgOai0M3wBbqo2rA-1
X-Mimecast-MFC-AGG-ID: 133YQXUgOai0M3wBbqo2rA
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83abd63a132so92478439f.1
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 10:19:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731521961; x=1732126761;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kjlPsKv9zsmgwnAdMucdyKyd6S8wtPHHvn3MwXuMoY=;
        b=MUIMRiMvQNNtxHe72Yjgwa0DtPYqNNzcukyznziQE2uPDfZyQAH++JrsayP7zctmXt
         2pykZ+u1LXgE7KE5skO/N4s+pf6LvYQq8ZVoOkApU+egNmD3yEDz33YiXJlMeJwFy1cu
         cFl0uDQWF7dPBEz2ImG0CN1EYuiLxCltOP4glvQb0vJMzxlViYXOoQPKh0oFRD1MBnHW
         +LjZZEMQJR4vjJg2Q8jTYEyBr0SLNRnN04NACuAQZTtV69irY3LIDMSatkYuAlfrFtA+
         4l2qxfmj47I+AQegfKuQfRgQzf6Xh/ScjzYad71JpZ/HWLmlbiVVcKYCBMJOhCdQQ5dN
         03XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMRsOIlSgWae0tCfOuv95eZqJlamWLiQwf1g0qP+5AZyImEyoIAJyRxDqIn1FqUNPWPxVphARb@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJlLLFAhddIAoRwZdXILvTvHF4iOqMs7uhoZDFckxdsh5jIoZ
	sxezqa5N9xSwrrbNLX4HMC5Dp8vPVV/cEZWQPMN0s5wo6e3TDTZKqTQTSFjB+N6f1s59jY5EhOy
	tbAv5eJggdUxeSj/HAzijvAva91frNfgMO3d4nTafT6RF7YPdUmdChk8=
X-Received: by 2002:a6b:ec09:0:b0:835:394a:d784 with SMTP id ca18e2360f4ac-83e5cdcc91emr45799439f.7.1731521960790;
        Wed, 13 Nov 2024 10:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyBTasBQy0DVuFUuBqcxNlJeoCJeY2w5cJqA08N6gptgmxyOs5meWYl2eXpbEuPSeiOSByyA==
X-Received: by 2002:a6b:ec09:0:b0:835:394a:d784 with SMTP id ca18e2360f4ac-83e5cdcc91emr45794139f.7.1731521960066;
        Wed, 13 Nov 2024 10:19:20 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d6305sm3045047173.101.2024.11.13.10.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 10:19:19 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <91010eff-cbac-4772-8b95-1ce9bb56d9e0@redhat.com>
Date: Wed, 13 Nov 2024 13:19:17 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
To: Juri Lelli <juri.lelli@redhat.com>, Waiman Long <llong@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Qais Yousef <qyousef@layalina.io>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Aashish Sharma <shraash@google.com>,
 Shin Kawamura <kawasin@google.com>,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241113125724.450249-1-juri.lelli@redhat.com>
 <20241113125724.450249-3-juri.lelli@redhat.com>
 <8e55c640-c931-4b9c-a501-c5b0a654a420@redhat.com>
 <ZzTWkZJktDMlwQEW@jlelli-thinkpadt14gen4.remote.csb>
 <b7c75f06-1ab5-48c4-b2fb-521508f20f9b@redhat.com>
 <c30adf62-3012-46fe-ae52-2f6de1e20718@redhat.com>
 <ZzTrwJoTetlt2Anj@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <ZzTrwJoTetlt2Anj@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/13/24 1:11 PM, Juri Lelli wrote:
> On 13/11/24 11:50, Waiman Long wrote:
>> On 11/13/24 11:42 AM, Waiman Long wrote:
>>> On 11/13/24 11:40 AM, Juri Lelli wrote:
>>>> On 13/11/24 11:06, Waiman Long wrote:
>>>>
>>>> ...
>>>>
>>>>> This part can still cause a failure in one of test cases in my cpuset
>>>>> partition test script. In this particular case, the CPU to be
>>>>> offlined is an
>>>>> isolated CPU with scheduling disabled. As a result, total_bw is
>>>>> 0 and the
>>>>> __dl_overflow() test failed. Is there a way to skip the
>>>>> __dl_overflow() test
>>>>> for isolated CPUs? Can we use a null total_bw as a proxy for that?
>>>> Can you please share the repro script? Would like to check locally what
>>>> is going on.
>>> Just run tools/testing/selftests/cgroup/test_cpuset_prs.sh.
>> The failing test is
>>
>>          # Remote partition offline tests
>>          " C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0
>> A1:0-1,A2:1,A3:3 A1:P0,A3:P2 2-3"
>>
>> You can remove all the previous lines in the TEST_MATRIX to get to failed
>> test case immediately eliminating unnecessary noise in your testing.
> So, IIUC this test is doing the following
>
> # echo +cpuset >cgroup/cgroup.subtree_control
> # mkdir cgroup/A1
> # echo 0-3 >cgroup/A1/cpuset.cpus
> # echo +cpuset >cgroup/A1/cgroup.subtree_control
> # mkdir cgroup/A1/A2
> # echo 1-3 >cgroup/A1/A2/cpuset.cpus
> # echo +cpuset >cgroup/A1/A2/cgroup.subtree_control
> # mkdir cgroup/A1/A2/A3
> # echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus
> # echo 2-3 >cgroup/A1/cpuset.cpus.exclusive
> # echo 2-3 >cgroup/A1/A2/cpuset.cpus.exclusive
> # echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus.exclusive
> # echo isolated >cgroup/A1/A2/A3/cpuset.cpus.partition
>
> With the last command, we get to one root domain with span: 0-1,4-7 (in
> my setup with 8 CPUs) and no root domain for 2,3, since they are
> isolated.
>
> The test then tries to hotplug CPU 2, but fails to do so and so the
> reported error.
>
> total_bw for CPU 2 and CPU 3 is indeed 0, and I guess we could special
> case this as you suggest (nothing to really worry about if we don't have
> DEADLINE tasks affined to these CPUs). But I would have expected the
> fair server contribution to still show up in total_bw, so this is
> something a need to check.

Thanks for looking into this. So the test script does create a lot of 
different corner cases to test the correctness of the cpuset partition 
code. Hopefully that will help you to improve the DL code to better 
handle these corner cases.

Cheers,
Longman


