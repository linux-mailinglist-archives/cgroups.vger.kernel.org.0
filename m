Return-Path: <cgroups+bounces-6950-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3174EA5A3B3
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 20:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FE5172A14
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E3722D7AB;
	Mon, 10 Mar 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EhWfwzBW"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5395F1CCEF0
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634341; cv=none; b=d1h2qIdD7fZZqYM5ure0suAngge91Fl3i0HJU78AbAmXaoazCwAmkDspC+xSQaD9t9aC6lrcWALXy8oJ5ZMFbZNpXmxsjI+akqPEpVVeXVwWn1wWKQPdIJ+nCXFeWDPcYf8vwCE226qdEcLYCfJ+9ZNdlvjq3yNKs8FvRBqMIUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634341; c=relaxed/simple;
	bh=N3f+MEWxB77zkydBCDkoQHG5PkErqEqsIhPm+kg/w9s=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=li6qjDWsUPL9hIP3HwF4AfephzxwbJaD6WAp13EUmvYIINRQ9UiJaZX640AuKK5UmadjoEoHNqBEYPvDJS12t3MmAEyebaF2sy/YVjPs8XpIjULFIgMZ72h05YFB4akWaNyuSbyoQhdgjyPFG80OfgNAvkl0xpNjL2dz2V+wI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EhWfwzBW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741634339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FW26yOeGd8FsUgqCXYMLoexwnJ+HSuO06Px25PwBcpk=;
	b=EhWfwzBWZ0QAmiI4zpAtam7zHhxwoQ1V3eXoNtMq5uFQSam5Lh3cgXsdEhVmcI7G+OlPcR
	c68TWkXkRXO0rmXoVXT7t1xXh3ulgjjkOYmCs7Okc0bvgmIdxxhQAddyi2YQMQAgSPNpOg
	ZkmfuQTyMhwoN71M3cTR5AdRVXLX2mI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-YDOa-xYiMpiGx6_5LdU8AQ-1; Mon, 10 Mar 2025 15:18:57 -0400
X-MC-Unique: YDOa-xYiMpiGx6_5LdU8AQ-1
X-Mimecast-MFC-AGG-ID: YDOa-xYiMpiGx6_5LdU8AQ_1741634337
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e91d8a7183so25388136d6.0
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 12:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741634337; x=1742239137;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FW26yOeGd8FsUgqCXYMLoexwnJ+HSuO06Px25PwBcpk=;
        b=aYN8hi64wv82KQ7CB0yrEJsO7JBlBNjW6E7H5ix49rXjy1k9dYcZ+TFE1MN0LHuuyT
         n5mVcbrydPVBnr6xkGQ6mcQizK2KsDQ2V1xUIsANE4qRdzJ6/wZw9zlQasHcy5x0xidw
         y2lt6zOoFUFWM3S6q+RP7apBSu+X5ynDJoP+UiiZO+10PhXTju5p4p7nQco47xFN0lfh
         +WFWO7UW+l86GF/07Z8q538MSj/l3alvkwQ6+DohDGC1D43wD3kNW8oBAJSDrnpPFm7g
         +8KKG1ItORhoAJhOs/j+yQHfJLq9flYJBeRgRyX8eOxLEQENzHNlzBtSMY3SNSAX51AL
         BNqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtr16lRnqLPREjqZTU2qRUv4ERHqrQhLKqt8oYF54/Ch6jGYy39++Z4DjRwWa1nJaZwqfLNZhO@vger.kernel.org
X-Gm-Message-State: AOJu0YyLbyz5JZTHeVr71hFdg46vvwG62Xw6me4XHnXZ6gJHAh8FVm04
	3C/o2xN31XRMi5pemFNUKRuPUdBHmEhLfAC9JJXGNNvl/TPixFeGsmYGYvcHxm2OLvWPUHScuup
	C1ycbXI/a7tB3lQxW52Irqqc3Je9Drd2sIjxxUtte4XL7E4UdqEWrC4o=
X-Gm-Gg: ASbGncuD+ll5JpuNRN31q9T/xzqrfVOiX0ioGYSURXluu1xo3RLNdoltIPcjpea+ACq
	rySjI151CUW3JMCL6kKsiJJPZXADnE9xrTXslx/a/hVKnI/X14vTgcpEfxAcH41CyAdUsy6rFSr
	wOpfcmgNVCkBai1QqCC1AQIYq0ajGBRJJmQjZC3THFiP4UQdRuw1xFpaauCA86Fs7bQFHFhkIUi
	LF7vlfbifckj6fw3GA/n6lW/LyQXo6gKo3YPtNktkHF8RBVxKNi8fzelFoFlObAL7vrFl+Qyb/9
	vCjeOPum6TpYH9jUtfrsIE7Cs3TyByaqxeGH6I3WWoHL8AYW9t0rE3n08cZQaw==
X-Received: by 2002:a05:6214:410f:b0:6e6:6b5b:e559 with SMTP id 6a1803df08f44-6ea3a698657mr14049656d6.34.1741634337551;
        Mon, 10 Mar 2025 12:18:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5wDu/JAC3Co4zaR/Est4jAkafKsO8b40TLou1V9tXx1j18RmCBuNgwe9rhBlqLNlpqgqHGw==
X-Received: by 2002:a05:6214:410f:b0:6e6:6b5b:e559 with SMTP id 6a1803df08f44-6ea3a698657mr14049106d6.34.1741634337167;
        Mon, 10 Mar 2025 12:18:57 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090904sm61851766d6.28.2025.03.10.12.18.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 12:18:56 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <398c710f-2e4e-4b35-a8a3-4c8d64f2fe68@redhat.com>
Date: Mon, 10 Mar 2025 15:18:54 -0400
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
 Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
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
Content-Language: en-US
In-Reply-To: <797146a4-97d6-442e-b2d3-f7c4f438d209@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/10/25 2:54 PM, Dietmar Eggemann wrote:
> On 10/03/2025 10:37, Juri Lelli wrote:
>> Rebuilding of root domains accounting information (total_bw) is
>> currently broken on some cases, e.g. suspend/resume on aarch64. Problem
> Nit: Couldn't spot any arch dependency here. I guess it was just tested
> on Arm64 platforms so far.
>
> [...]
>
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 44093339761c..363ad268a25b 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -2791,6 +2791,7 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
>>   	ndoms_cur = ndoms_new;
>>   
>>   	update_sched_domain_debugfs();
>> +	dl_rebuild_rd_accounting();
> Won't dl_rebuild_rd_accounting()'s lockdep_assert_held(&cpuset_mutex)
> barf when called via cpuhp's:
>
> sched_cpu_deactivate()
>
>    cpuset_cpu_inactive()
>
>      partition_sched_domains()
>
>        partition_sched_domains_locked()
>
>          dl_rebuild_rd_accounting()
>
> ?
>
> [...]

Right. If cpuhp_tasks_frozen is true, partition_sched_domains() will be 
called without holding cpuset mutex.

Well, I think we will need an additional wrapper in cpuset.c that 
acquires the cpuset_mutex first before calling partition_sched_domains() 
and use the new wrapper in these cases.

Cheers,
Longman


