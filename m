Return-Path: <cgroups+bounces-5541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47739C7949
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 17:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99679282A1C
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 16:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C8200B84;
	Wed, 13 Nov 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vly5IlJu"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FF1E1A28
	for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516613; cv=none; b=kX1VJNoUkHKg6WFoFv1cWkXza9ENx6in7NKN86SctVSZaUEeuJp4bwTmyzTlYdFgU7YJlBdhST6C5U1f3Gxcy82ZcAX6Yb/xB4oEiNBuCCnkBD9qYgcXqHg3DZizJwN/0SqBj3sibNMC3SB7rM6cqZhGwfBiEwqgZgWzpl0/GR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516613; c=relaxed/simple;
	bh=EW2dt4u4f+4Lo5MovdMlHFcVBcY8DGZB3JoAN1l2EQo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hf/b3BP59dzCp6z3l7zuEpYiajif5ApuhQN7XJ4JLegwGt3cApfzaOK4QG0IwhKEGS7F+ETummwVUWeWCIPZ0zhmFbBMp0DRUrvRuerzMkOQn1Her1CdyXrcKHQ3ejW9E8abdRaODbM/c5mlRojc3kUlrUjGwSiZh2vsczU9XY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vly5IlJu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731516610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05s4oWNKFdaj5fgh/SGPavDFEuEiB9rS0OJ8HR13gHY=;
	b=Vly5IlJux2FAWocr+/uk8WhNuOkN9YeC8F9cyFB7x4wDpIVpXgzPkBXt+g+9BNTqAjSTtr
	Zdr3IeKAmn5i3vMC58o8gb7wqOeD6RRgsjx+aXxYa5Vo1amhy8k3In7NGyMF0Zsks+HzHH
	P9fAOJmsxzyFBdkO02jZMoxIE7zCqqo=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-jN-YWWA3NbOaTvpwtbbR3g-1; Wed, 13 Nov 2024 11:50:09 -0500
X-MC-Unique: jN-YWWA3NbOaTvpwtbbR3g-1
X-Mimecast-MFC-AGG-ID: jN-YWWA3NbOaTvpwtbbR3g
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aa6bcd7b3so855816939f.2
        for <cgroups@vger.kernel.org>; Wed, 13 Nov 2024 08:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731516608; x=1732121408;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05s4oWNKFdaj5fgh/SGPavDFEuEiB9rS0OJ8HR13gHY=;
        b=UYI+f6Httv0m0Q0tePeFRuwb0OSxAWhK9CBemLk58w0l+gi+FMhNf8wrqQXBZgHOw7
         uswtNaKNq5idkvmuvDbyw7N1nRsgViacyiMatqRbRdqy81Ra+Ej/h+08JGpa5Tsw9oIv
         UsOJ3PFKcZ06scAiGw6YIn27N0nOuzGnbNa3Mt41XOYAEKrN7cG04s+No6tjVq6x/T9L
         yjuYki2gJq1z8Mnap7oOo8GUYXZsp48l0YBhkBlLLc1+dcI+hFSp3zGnPmgHFP/AVHuv
         NbrZuYzizfmxTxbIpxdF+IfCXptU8ASz4epD5EVO3ACjRpewTbpi8xRxc/JbF6aDAVih
         f71Q==
X-Forwarded-Encrypted: i=1; AJvYcCU172jtGTe49F7tHRE9GsLAW93jN7l1+yweSp/x0Lihdfw5xo/jnZGMpRHhNwZVxsSI444FEFDZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwTl0I+tLLEUNPg691h2B8vwXYN3shf7IHgijKKbMMfGHKaB9Sb
	CqodjVnfqNGPSEcnIqQ0sTVxEkcd7/HE+rttdYygXusESyT8e9xPDAEfxoEGO4Rt/9hfqmlnHqd
	yp0tpydRpfkE/4qG43HHldqwvtqY19LQLsia8+ds/ZAe/clYUxg42C4Y=
X-Received: by 2002:a05:6602:3407:b0:82a:9cab:9be1 with SMTP id ca18e2360f4ac-83e033538f3mr2423350739f.12.1731516608413;
        Wed, 13 Nov 2024 08:50:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7l+QLffK/cVeiuqm6Xzcx7aCFWBqZmbfWM+eCeA2GW4bG7/8ljaIQOJOy01BtTb/K9amXGA==
X-Received: by 2002:a05:6602:3407:b0:82a:9cab:9be1 with SMTP id ca18e2360f4ac-83e033538f3mr2423344939f.12.1731516607705;
        Wed, 13 Nov 2024 08:50:07 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de7874396bsm2950837173.46.2024.11.13.08.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 08:50:07 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c30adf62-3012-46fe-ae52-2f6de1e20718@redhat.com>
Date: Wed, 13 Nov 2024 11:50:05 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched/deadline: Correctly account for allocated
 bandwidth during hotplug
To: Waiman Long <llong@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
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
Content-Language: en-US
In-Reply-To: <b7c75f06-1ab5-48c4-b2fb-521508f20f9b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/13/24 11:42 AM, Waiman Long wrote:
>
> On 11/13/24 11:40 AM, Juri Lelli wrote:
>> On 13/11/24 11:06, Waiman Long wrote:
>>
>> ...
>>
>>> This part can still cause a failure in one of test cases in my cpuset
>>> partition test script. In this particular case, the CPU to be 
>>> offlined is an
>>> isolated CPU with scheduling disabled. As a result, total_bw is 0 
>>> and the
>>> __dl_overflow() test failed. Is there a way to skip the 
>>> __dl_overflow() test
>>> for isolated CPUs? Can we use a null total_bw as a proxy for that?
>> Can you please share the repro script? Would like to check locally what
>> is going on.
>
> Just run tools/testing/selftests/cgroup/test_cpuset_prs.sh.

The failing test is

         # Remote partition offline tests
         " C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 
A1:0-1,A2:1,A3:3 A1:P0,A3:P2 2-3"

You can remove all the previous lines in the TEST_MATRIX to get to 
failed test case immediately eliminating unnecessary noise in your testing.

Cheers,
Longman


