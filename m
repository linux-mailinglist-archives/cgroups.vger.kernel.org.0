Return-Path: <cgroups+bounces-5590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D80859CFBCB
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 01:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E913B28917
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2024 00:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323D05C96;
	Sat, 16 Nov 2024 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="crM7bwLU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E87621
	for <cgroups@vger.kernel.org>; Sat, 16 Nov 2024 00:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717623; cv=none; b=lHmYDfRYowS4Vxt12wpV0qeeUf0gdxzp5wH/MYNVIgu8U9PX36Zxe1smgSeYjtXjpwYzk/Q7AXw5B6hUTSL/xwiNV0nfue7nOJux48XggcMIRorgvw9uPiv0caAc5SD+4JpehctDGRPBYl6xMtKmwqaMNawtNp7RAO+solwreds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717623; c=relaxed/simple;
	bh=WEdCMQfli2BaSgFf4rTo0+73c80op+HJdxWiI59yzpo=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xm4OtAzU53RTWUJHurN2tto/CUkDpx/M9wwL42egafHq9As+BAygKmpCnJD84QaRh+gsls8X+Up95aARG4hDJDJio/hywgmzgUmIr5B2+saQO9rvx4rfKGqtMS+UssU6C8F1Tb7/EDz4QI3scIzUdwbCLnAz+EcGCOfwmt1ZP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=crM7bwLU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731717619;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZ491H8nPc+8CS+1Kn2/2/tGwNeve6hebjiSCMJj62E=;
	b=crM7bwLUEW6GfL8Alc9A5jxXlk0t1/yHukKI21lDUZBB+CrCx+UYOGLXlk+PNE2Nvrn1Zi
	51lk0aWr9mrQUR2iLgMhkhpIEgEr4CbWKh0Q7Ejr16lNc9wHuD7RdVl37XF47kSk1NEEjf
	vRNIXnxstsT2qENTA+IOBKu+KI24CGk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-Y1rx78jAMmK5zuNdisM09Q-1; Fri, 15 Nov 2024 19:40:18 -0500
X-MC-Unique: Y1rx78jAMmK5zuNdisM09Q-1
X-Mimecast-MFC-AGG-ID: Y1rx78jAMmK5zuNdisM09Q
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-460c73093edso20021691cf.2
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 16:40:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731717617; x=1732322417;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oZ491H8nPc+8CS+1Kn2/2/tGwNeve6hebjiSCMJj62E=;
        b=q5Y34V9e5zRpKlWIOhpO9fSIFkuIH2CP7cbJwfdeXcBdy1TMONA8fCuCJTzhXokgSA
         HXFMamEnEZerQbUIvaNmBtP9eswx63V+suZDZeOULAMJ8OHzoTegP6Jm+pSjnHpvZ30b
         V+9anP5abeI2CSm8NPhTEhpfStwSZdI+w6sXezIlicbA2Ipi3DtVL7KSV/WCRHPQiRrc
         Z70lVmny2xyX80dLzVslR0xTPweRaODA0YQBtBR3Kb2wrtbNElM72WhvThBH1ESVDl/k
         amjVJl8uPE1SRJVXQeYZuhVfI7Vz+b8+bkAKVJi1nmiLMQtf/+2E2rYKimcXO+0CyV5+
         8OPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4sPTgU/uE+B93vCCssv5LYsuPjbKa3/oykuM1RrS5+XOwPpd0Mjtw5JfTmlAsIkvl9CB0sDJk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzph/pg1cJTm3pQk+D3nmM/dZNiAXIbwV6w3vdEN98i/A8eZNjY
	97RjrmOG9gZu+OvDoiBeXlsUc0nPJuJ3UeN8WMo98GTjpbbU8dhZUKHszNlymyImxB6V4xndBhs
	8rbA5O1lvBLSSSz0f1s233esFGswO725pO0Cu1NlYfMMzHNp4olzhT7Y=
X-Received: by 2002:a05:622a:2987:b0:447:e769:76fc with SMTP id d75a77b69052e-46363e97083mr56852401cf.34.1731717617452;
        Fri, 15 Nov 2024 16:40:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4OiBBQNU6PmAwmO6S73QsswIAzoZikat/kul0o+V01YiJtapz1/OsZiyX1VAE92HLGSNbzQ==
X-Received: by 2002:a05:622a:2987:b0:447:e769:76fc with SMTP id d75a77b69052e-46363e97083mr56851421cf.34.1731717615802;
        Fri, 15 Nov 2024 16:40:15 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635ab5d891sm25609501cf.77.2024.11.15.16.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 16:40:14 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5b8d92f6-0d55-4b43-844c-696e71266978@redhat.com>
Date: Fri, 15 Nov 2024 19:40:13 -0500
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
> (Also someone mentioned that this could share lots of code with CPU
> offlining/onlining.)

Yes, that is true. The simplest way to do that is to offline the CPUs to 
be isolated, change the housekeeping masks and then online those CPUs 
again. That is good for managing a single isolated partition. However, 
Daniel had told me that CPU hotplug code could cause latency spike in 
existing isolated CPUs. That could be a problem if we have more than one 
isolated partitions to manage. So more investigation will be needed in this.

This is still the direction we are going initially, but first we need to 
enable dynamic changes to the housekeeping masks first.

Cheers,
Longman


