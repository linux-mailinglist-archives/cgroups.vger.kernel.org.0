Return-Path: <cgroups+bounces-6889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067A0A56B7D
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C493AA9D2
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 15:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB34221727;
	Fri,  7 Mar 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPde4PqH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B853C21CC64
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 15:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360326; cv=none; b=cRSprj4gkzJrohV3Ik25rXHS4it41lgwJqihZ0XLko9HGl/JcJOj0/t82fdLRbRzIpJOHFOYkyIzZUqboMXtGgT76rH8Kui0SPKb3DsuJ1FB9P8B4cVt8bloxX6RTifAgiCiBW+jzKJsPr1Aa96hIJhx15n9rMkMjC0ajvd2s1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360326; c=relaxed/simple;
	bh=C9tM5TuLfhlgQvLUFBgkKrvHur7nfMZAswXEQogvyso=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=AqR891nI2xcW8SwUZmkpdUB/w4gAmgU81xDoX7ZY3qan4sfDV5Ru6rl2f2Lh2qv4ZVwHbgkmrx3QLYvnnR8KFmQrAYKZTbGacQ4oSIJ4II9bw0M/FXwUMlqQcc0kVLXmnnrr6YrCCGMlPSjtwJTUU8PpU08nNxs07oFmg3iQYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WPde4PqH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741360323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3S/y/ILHmIHApB88hRzIwz+jtFgRApUnIcM4kDcX/4=;
	b=WPde4PqHBrtR9lXlm2USInj3vKxiNa3U1cXPko4MZO1rnU/TEZHQ4JqUCBqWvshsQECrGF
	+tnTcIw0JUkmRdMLHMdgqV6fOy89WUgZMzn5kGyxNawr2LMyJSPckqONcdq8Sen9X3l9vD
	DU7qf2dFOZsYO3feQcpj4rrfFTBa/4w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-x4zec5eoOgCYToZI1peZWQ-1; Fri, 07 Mar 2025 10:12:00 -0500
X-MC-Unique: x4zec5eoOgCYToZI1peZWQ-1
X-Mimecast-MFC-AGG-ID: x4zec5eoOgCYToZI1peZWQ_1741360320
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c0c1025adbso519822585a.1
        for <cgroups@vger.kernel.org>; Fri, 07 Mar 2025 07:12:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360320; x=1741965120;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3S/y/ILHmIHApB88hRzIwz+jtFgRApUnIcM4kDcX/4=;
        b=qe32LOH5cj9A41Um0PUcORCaoKLS+lDaw7bl6pGT2Q11NmcTk7FceKgTV1Y9haLeKA
         Emrx4CFQrR9qpQ1jbVO0+KYPkZUcb9XWTq77MzeVs/sgQ82/IYJpAsv6028KJUREhJf+
         Uac+9JUjnkSo64RhRHSE+u0uyL9qsfMqVbot1Q2Dapg1lKSJ3ceGO1noroY3F2AVq4NC
         Z3dbw195zGeEd4uLnQwiYiNwI6kaes01khKj2mYdYL4a5GjfJ3BkHtsMW8gWJtgktxFH
         o+E2TBoSE7kijc1vcM6wvk0Q7fEFTiXgphEHceruGvVi+VMUSiXEBnHRs0n2E+9JjODT
         Wx0w==
X-Forwarded-Encrypted: i=1; AJvYcCW4VzEpst9QT13zSL0GknAHfavQqXXIqt321J2cpbDpZzAG+ghhIWQ6IFF+qnGeeyo7f8q7IzVm@vger.kernel.org
X-Gm-Message-State: AOJu0YwOpViKq1MWRlvdUDJ+iQIVdqb0lWSNBm7+ABJ4cnkUdDiZVStR
	LJeNS+LmPA+T8tcpf7KYcPIdEqcZtwcn132Mm0TIyJNE977QUmSEMIJmnbGjsS24fiUWu0nFzSy
	0cv/OLD7KAm1XIMLh6b45Ijc5C6Bmqgy/gMByW66l4/pFGgicP0oOocs=
X-Gm-Gg: ASbGnctvkNrkgmJ2hw3NKhZ0y+TQGKL2X9wBoKZORcS46E74TfyUZhVh+J/m3wqL3hd
	dlka9n14FCO1A1AoZjbAAlJm8DEu2+vNNvg4NozU5MbY/FQWmcIEW8EN0X/Mg4Hr1qLfcMIRPai
	yNHv+C1R8nbGC/eh+IfBoQjdkivZiq6J7bIGOEsvaIfuVME5S2AgoQuERlmjH6nAuKsK09HAfcV
	4UGsyHlze1UinF6hzYL0QIaaxBblyCoEetVzGa6180mo5kUDz/v9MSgekgnLPwG8BTbu+hYE+mJ
	CJqYBqS9YagSSgf/1mCmMr29HzE/eFn3n4QMK9CPeE4SAp6d0mV8MPE59Wk=
X-Received: by 2002:a05:620a:261f:b0:7c3:e457:853c with SMTP id af79cd13be357-7c4e61ed4a1mr577217685a.50.1741360320193;
        Fri, 07 Mar 2025 07:12:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKuw12OwEB6WB4+HUUfMD0cI7kHe8YYf7PqXIevfwUmXERTDQ2AcnR+rdUrcLqQxyKvb/9YA==
X-Received: by 2002:a05:620a:261f:b0:7c3:e457:853c with SMTP id af79cd13be357-7c4e61ed4a1mr577213785a.50.1741360319918;
        Fri, 07 Mar 2025 07:11:59 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a1a1sm254283185a.6.2025.03.07.07.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 07:11:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <eafef3d6-c5ce-435e-850c-60f780500b2e@redhat.com>
Date: Fri, 7 Mar 2025 10:11:57 -0500
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
Content-Language: en-US
In-Reply-To: <20250306141016.268313-3-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/25 9:10 AM, Juri Lelli wrote:
> Create wrappers for sched_domains_mutex so that it can transparently be
> used on both CONFIG_SMP and !CONFIG_SMP, as some function will need to
> do.
>
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
> v1 -> v2: Remove wrappers for the !SMP case as all users are not defined
>            either in that case
> ---
>   include/linux/sched.h   |  2 ++
>   kernel/cgroup/cpuset.c  |  4 ++--
>   kernel/sched/core.c     |  4 ++--
>   kernel/sched/debug.c    |  8 ++++----
>   kernel/sched/topology.c | 12 ++++++++++--
>   5 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 9632e3318e0d..d5f8c161d852 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -383,6 +383,8 @@ enum uclamp_id {
>   extern struct root_domain def_root_domain;
>   extern struct mutex sched_domains_mutex;
>   #endif
> +extern void sched_domains_mutex_lock(void);
> +extern void sched_domains_mutex_unlock(void);

As discussed in the other thread, move the 
sched_domains_mutex_{lock/unlock}{} inside the "#if CONFIG_SMP" block 
and define the else part so that it can be used in code block that will 
also be compiled in the !CONFIG_SMP case.

Other than that, the rest looks good to me.

Cheers,
Longman


