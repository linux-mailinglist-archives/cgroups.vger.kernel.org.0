Return-Path: <cgroups+bounces-13490-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ3rEeFSemnk5AEAu9opvQ
	(envelope-from <cgroups+bounces-13490-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 19:18:09 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4F9A7A78
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 19:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2ECDE3105DC7
	for <lists+cgroups@lfdr.de>; Wed, 28 Jan 2026 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04DA37419A;
	Wed, 28 Jan 2026 18:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ax0DsO85";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXWNtN48"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A347237105F
	for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623748; cv=none; b=pT9SWkmYms8nBhI/YLrWWupQ06Evkvy20LecKIWKkJ9ncgPf5bznnukwwTpfAPdEBrSQBWtAiOZ3jMIn3XHFtRGDcwbuRq75kyL4UIpOMVPLw4G37KVnyLH+dpU9FaSLYzRCqME88pbhNM6mP5B1roHU7M01fQ5TcDwk0peg+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623748; c=relaxed/simple;
	bh=sW3ixsa60Tf5yvJXIL5waBKWtOoqnKLO8YAirrnYPuE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=o3MIqgG/RbOK1GY5Z3jZDb/hYG3vXSxYBG+rMYqubC/Th6+/42TzUq27neurxwZToPIGUbjjQVvxrWeO+KldAqBMOhVOczAhwg4sWnbyWkdb7x46w/W79q6M6t1Ysrv1zBVlfhe2zbFSeRaZkz1v9Z+jYe5sxX9CvFmH0iqZGNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ax0DsO85; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXWNtN48; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769623744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F3/5uXj60lotisugWj0ukNSuH4F0JCr6j6Yw3wfib9s=;
	b=ax0DsO85172UXeZuDwN628jYUpyEtLz4Bex0DusydMhd01f2/PigMC78xZ99iPpU9ctj78
	scwjCdr8+JjYteCwy4J9f/GYtE1yDGqveYdo2QbwCUMAnmNAHK/e4Y6ZZAEMK7pqqwxJxw
	qGUivPJBG8agjjAhUbLA2KWyIIXuWNI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-6_HrdO2zNzyV5-hcR65Jnw-1; Wed, 28 Jan 2026 13:09:02 -0500
X-MC-Unique: 6_HrdO2zNzyV5-hcR65Jnw-1
X-Mimecast-MFC-AGG-ID: 6_HrdO2zNzyV5-hcR65Jnw_1769623741
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-88a2cc5b548so31122056d6.0
        for <cgroups@vger.kernel.org>; Wed, 28 Jan 2026 10:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769623741; x=1770228541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F3/5uXj60lotisugWj0ukNSuH4F0JCr6j6Yw3wfib9s=;
        b=OXWNtN480YxEMwJosTJQ70xMNIKuwXw1KKL4dLvOUljJpJkxUDToCvYbwKiOVv7GdS
         OtRuUvzN5UpOYa3yT24ggm2UkPJXfYqSTACKqwtA6AAxk1RJkZqzCS8RUN2shUDFVo7Q
         fe1no8rft91K33zpWmgRqzHuKuaEp9eYCpLrx72fl5IigQVXrbyA09/I8czEMeG4QkEY
         MsLZGo8x1dc9Syn2ze6lVzVAlw4T2jX4sjeZ5j8Y7AmNOgXFCDKNs3FDY4t8SnJkJuVg
         Uo1ukcIggITgyGzTgTiN0UiJC/td7DagHqWZvkAMBFv2ONoCdSKDtznVURA9QfDMTmxk
         cIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769623741; x=1770228541;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F3/5uXj60lotisugWj0ukNSuH4F0JCr6j6Yw3wfib9s=;
        b=tgy3ZOnqHv6uYaU9s/z1IePNgxXODTpLAaASUDv2xclDnoXoTXwCMnLTETxhoI2qD7
         9uJ22YxrpNPjtlx7Yqtki694Hfm4Ny1wEXIdbNDxgxY+ziQ0Xrjy0yCD934akeN5tKA0
         kK2ki2j59/dH+WuD5dRBLYmQ22ybYgHki9eKsBjF4M8X5zAL1Vr685D29i2C0dwoCRX1
         3i65BAy9vxQXrgL6+CzEJFSTTQhRmVvTCySqEopf04Xo3FSOYaObT1Va//Zrqs+b8Coa
         jPUjdCzDX+dsPSXNaWr9wMCNJPWeEzGyC7hq+3z1fiUz8Ic1nQFd/oV7T+64WYGOYq0H
         9IQw==
X-Forwarded-Encrypted: i=1; AJvYcCX/TaQbKNbTDv04ibWS4nRkZlevrjaL8w+Ne5XT7LBMDeutI8SG5UvjUEv1KhORfCOYvgfxIjke@vger.kernel.org
X-Gm-Message-State: AOJu0YyfiXSRYPuN5YZc+Nqz3LzXvaTWx0AudGY6e5wQ8Lspw8Y0/Lqb
	/WmrSfQvN6wnKcKgygh1GvBj1TBHScYOcmLxO+dZ3Z3Z5LtX7GM12pOaSfxQ+mtZs1BbjeLs9gI
	6dJzBXwuHntjZ/OYKYDL0brdPZdxqEtHg5/eO7g3QjVPd4uvGelBcVq6rL40=
X-Gm-Gg: AZuq6aKBXOl2plzkSk+4o412F+sXKTWJ+F+0CtIRNs8WyaZkOpy6bq3BfS1AVDpEGZZ
	y2UxwfNlbpssZ8N9K3tU4rjdU0XTKe2WYehTHiSblm8YNgWTk0ijU8nRPKqCi9R/B3gcPdweovl
	KwLkVIR3UzKkMA79Pdc3E/V/+8geR37HqWqAyztd83P0W5/URmzhh7EvPtxMwe62GGkaHjBmsDO
	t8PfRsagqo7Ex5+NUH48T3TmZhmjl4M/RPysFn6F+sV+VLt5xLWvZfglB+mF+PifCFw1/P8LFb0
	z8oO1iSCYbgMWe6sd+sm5cch3d3eZ/K6cLjgRYl7FCZphWgPW9rbmy1FJ7l+cNObChxkQjmOk+7
	p10TT4H2erin+WpD+m1YUtZzO2DSaiHt2Z5ZazKBj4fNZewKoFSh8Nhrb
X-Received: by 2002:a05:6214:27c1:b0:894:66ec:fac0 with SMTP id 6a1803df08f44-894dfaa2095mr5501766d6.10.1769623741586;
        Wed, 28 Jan 2026 10:09:01 -0800 (PST)
X-Received: by 2002:a05:6214:27c1:b0:894:66ec:fac0 with SMTP id 6a1803df08f44-894dfaa2095mr5501166d6.10.1769623741206;
        Wed, 28 Jan 2026 10:09:01 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d3ea25sm237092385a.36.2026.01.28.10.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 10:09:00 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <494c63e6-4887-4bee-989d-8a9efda7f2c7@redhat.com>
Date: Wed, 28 Jan 2026 13:08:58 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next 1/2] cgroup/cpuset: Defer housekeeping_update()
 call from CPU hotplug to task_work
To: Tejun Heo <tj@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260128044251.1229702-1-longman@redhat.com>
 <20260128044251.1229702-2-longman@redhat.com>
 <aXpLEcOFhuGYGPY-@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <aXpLEcOFhuGYGPY-@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-13490-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC4F9A7A78
X-Rspamd-Action: no action


On 1/28/26 12:44 PM, Tejun Heo wrote:
> On Tue, Jan 27, 2026 at 11:42:50PM -0500, Waiman Long wrote:
>> +static void isolation_task_work_fn(struct callback_head *cb)
>> +{
>> +	cpuset_full_lock();
>> +	__update_isolation_cpumasks(true);
>> +	cpuset_full_lock();
>                      ^
>                      unlock?
>
> Thanks.
>
Sorry about that, will fix it. That change was removed in the 2nd patch. 
That is why the series still worked as expected.

Thanks,
Longman


