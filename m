Return-Path: <cgroups+bounces-5581-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A40889CF4E1
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 20:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BA9289D42
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 19:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9801D5173;
	Fri, 15 Nov 2024 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gVKtw5H0"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A0188A0C
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699159; cv=none; b=EO153+sL4BVxc4/WN2nRc6N1qwrzxegnDoA2MliYAROFnDo9XvuBI0hUFj24tOWrYK8tt/R6zt7NAE9xr8gTfq2vZrRvzJ9J0Gwl5Z8SCX+m9eJUzlhGLWSYnxN+NbF1iTE2mzlDExhDrL7vpVkGB7UbdltZod8NBiOB6mSKutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699159; c=relaxed/simple;
	bh=c0rTn/rXsByA0NkcYM5XAnL46RC+LOk8WkweuOvIGLA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=u9oiS157Jlh5gRaOVyYwbLQxFhbJTe1yr8SCuBaesXgbSbJSPnAyxppMGdp59nySI7/4s2iAmgqQhJbPD1vDwn+/4rywjIgKVvCivgewa/7Y/ToOJ87ewTCIIJ+2VaG4qNRfx5tQwavY9TjGdeHQJaoMK+oV7MQ2y1tdYtBQhOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gVKtw5H0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731699157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbKfYu0v/mbY0H40hf9EqMzGfpBc6Gg5nFpCpRsNZO4=;
	b=gVKtw5H0eT+FPa5I4GVLso535aX31Qi8g5eF04Vgqn4Dn/AHAVye5jckd9OogCgGqkNyGU
	lkfqbOOjqBSzH7oYfsGXlQXsRS9yGspf1RIpzQ5id091iYy7drolm15xV8OTw9dUL5kk+t
	YD+3Fgpj76Qri5dsnEWo1JPU5ffDF+k=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-Iom0W32IO3ySR_RRHJozkw-1; Fri, 15 Nov 2024 14:32:36 -0500
X-MC-Unique: Iom0W32IO3ySR_RRHJozkw-1
X-Mimecast-MFC-AGG-ID: Iom0W32IO3ySR_RRHJozkw
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-71807a67145so1634552a34.2
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 11:32:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699155; x=1732303955;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbKfYu0v/mbY0H40hf9EqMzGfpBc6Gg5nFpCpRsNZO4=;
        b=WAxxo+V2fw3zA2jrhXwBPDOG3qhR1T5YRAQ02Mc/dwioFKRzkzdQz1fg9yEBpa0vhX
         1/eyxb64pEIk70NCEsuQETbQDO3royYweYQ/fa9nli1FhgPzFBpVZ5UGnaKolzRZljVA
         UOwEQRfj3DMEFZcbB0Huq9qmopyEiu0qp5Lsa76A60kQcOef3YMm12WfgQneIZxjZf+i
         bB8tDqARh/uj35ypUHKMvm342BeSTuii/qzwKOsqIpXl86XQ8Mp+kI1/oH++zZqde+IX
         gjFpZESsIXxi5AKVfW8hsc9uup3fDMv5w9+nFa37O7mI2RKzCAOV0Lfrw5aNnC1qYHrw
         c+nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM4lIKQXQ1fO/E2Y9250lZug6EFuOrBlByEQsbh5deEr88RUhZyOGmKVKQPYD7qwjRb2cPpsns@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMbcOInTClkZIr64qL7z3CqMH7xXqqqmW4eEQoaLq3sBHijjd
	YC5euNJmMFwmd3h8Nw+yiYP/egCD8szG+3TLbi/IxydGy3z/LRiGkVN9bvxelEt4ePTLBS5vv3n
	P+pWqLKxDcdpRFvBGZBzrE68bRKK2KvT5X7yglSD6Bl/eu5BHdEStNFM=
X-Received: by 2002:a05:6358:c83:b0:1c3:7157:2868 with SMTP id e5c5f4694b2df-1c6cd108afdmr278400355d.20.1731699155187;
        Fri, 15 Nov 2024 11:32:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVPdVLptDuazM1NNoZrkjuPzGhK5FMMX7JeiPLEJJnbItrqikYMtuJBNQtcYMdED7s5//dng==
X-Received: by 2002:a05:6358:c83:b0:1c3:7157:2868 with SMTP id e5c5f4694b2df-1c6cd108afdmr278396655d.20.1731699154842;
        Fri, 15 Nov 2024 11:32:34 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40ddd1003sm696d6.123.2024.11.15.11.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:32:34 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <f5241a1d-9753-4c95-b633-067ecda50c10@redhat.com>
Date: Fri, 15 Nov 2024 14:32:32 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] sched/isolation: Exclude dynamically isolated CPUs
 from housekeeping masks
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Daniel Wagner <dwagner@suse.de>
References: <qicmttz6sqccty6jha7s22wi6bc2agps44qrqwhm4hhorcluyp@nl734io7qnl5>
Content-Language: en-US
In-Reply-To: <qicmttz6sqccty6jha7s22wi6bc2agps44qrqwhm4hhorcluyp@nl734io7qnl5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/15/24 10:45 AM, Michal Koutný wrote:
> Hello.
>
> I recently liked the idea of considering isolated CPUs a static (boot
> time) resource and only use cpusets to place (or remove) sensitive
> workload from those selected CPUs depending on current needs. (Yes, this
> may not efficiently utilize the isolated CPUs when reserve them based on
> maximum needs of a node.)

Thanks for taking a look at this.

Yes, I am moving in this direction too. Boot time statically isolated 
CPUs have better isolation than is currently possible if we do it 
dynamically at run time, though we are trying to close the gap.

>
>
> On Wed, Aug 21, 2024 at 10:23:11AM GMT, Waiman Long <longman@redhat.com> wrote:
>> This patch is a step in that direction by making the housekeeping CPU
>> mask APIs exclude the dynamically isolated CPUs when they are called
>> at run time. The housekeeping CPU masks will fall back to the bootup
>> default when all the dynamically isolated CPUs are released.
> But when I look at it with the dynamism in mind, I would expect that
> some API like housekeeping_setup_type(), i.e. modify the set of isolated
> CPUs are requested and leave it up to the isolation implementation to
> propagate any changes to respective subsystems. And return an error of
> type contains a flag for which dynamism isn't implemented yet or not
> possible.

There are currently 9 different hk_type's defined in 
include/linux/sched/isolation.h. We are now trying to reduce their 
number as some of them cannot be set independently. See [1]. I am 
thinking about doing dynamism in the best effort basis. Of course, we 
could expose some information about what aspect of dynamic isolation can 
be enabled at the moment, if necessary.

Cheers,
Longman


