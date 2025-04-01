Return-Path: <cgroups+bounces-7276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D011A772E7
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 05:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928EE188D9C9
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 03:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436CE85C5E;
	Tue,  1 Apr 2025 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aMz01Rxz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6F35942
	for <cgroups@vger.kernel.org>; Tue,  1 Apr 2025 03:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743477133; cv=none; b=KkVyKjLlOwunI+6Jz/A3j6/1I1OKYvUuFBZMvnMnd9Ct1Gj2if3u4mczOBAW6nLZqy187HBREjUW5Pd4VplgNsbNh/KcbWFAsNAZDiURMM49sSXPopXvkeWv+FMiM+VmFfB/eeHXJwDPgGtiqhKhu3k/nMjvBJYNDii6b99d3yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743477133; c=relaxed/simple;
	bh=YH7JCvQ8t1ajK7yqoxSreEprl3ng3fcJ/g1aGkjZ1Ok=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mak6bU/IoVlmCWky3/YUqlJPdS2ohFdJCOZiEOKPOOh9f5Rwc2aVjr/Yq/uROukJixzpX1CTCZFKBxxQ9fjgV2dU+h27MwNNIwcA9F4EllEcesHW/lLKvyLuC4EVxsx+QQ0CZcpiNGTRnjP6xCAJEc3SGeM2K5c6hLe5wbeGc5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aMz01Rxz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743477130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D+yChQ8LHPX/9hgzwjNue2CwizV8oJdhGjOx1G3bhZ4=;
	b=aMz01RxzBDZqXLgPaGi1+qfsEtm8W00t777YY9LRA0UukPV8XSYrN2VRvTauSlPJwtJO7m
	2v3w2zHWrkPWW75MAGhhhhBnavswRH0UwOYqFcPSO/t3zbWa4/JZ9JaXlpSLh382vJfy+L
	N3YmFDQmnQ8R9LqxX0gUxDDWdyzGAoc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-xX-rn-N5M6Scqnm6w3AN3A-1; Mon, 31 Mar 2025 23:12:08 -0400
X-MC-Unique: xX-rn-N5M6Scqnm6w3AN3A-1
X-Mimecast-MFC-AGG-ID: xX-rn-N5M6Scqnm6w3AN3A_1743477128
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c5e28d0cc0so846532985a.3
        for <cgroups@vger.kernel.org>; Mon, 31 Mar 2025 20:12:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743477128; x=1744081928;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+yChQ8LHPX/9hgzwjNue2CwizV8oJdhGjOx1G3bhZ4=;
        b=RwrdhcUwG9IowwLLdtriIqHGrlGEzvsCNLY40dUjQFf2XLUjS9QbUBmonrvK00C22z
         y82SfdYPeTOdrlniqgtwOI8fGNl6I4/5jkcxYptOeQO7sR89uiXwFnnV4r5g5v5ZULLf
         i8HZ9NFDNumgzZRjU1Oy0KV0jj/dzHyM1X6I4XJZQSlUqW/6zEb6y7ZzcNxLIg9lSweL
         wHSWk83Y8/OIh9sjnYiOoxFqgc99G3PW4+8VPMKkIcRW4a8egCISeS8ztx6is+L2XuoC
         B9CqnF495LaHXk8qXYc/jCzSvFyX2ry0LsHub2Dbjd5lpp41cylYZUEKJT0ogMG4d8cv
         9R1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOp1/+IFxoXVeANNYM+Q6oPopY8i3kY6JzyzPXLkB+0nl0gbnsKTLLxiqGzpsrcsGvOFnOvNbb@vger.kernel.org
X-Gm-Message-State: AOJu0YxxBiI/pIo7rzVVDbJGBaZ3nPjr22H64Eibn39ffRQFX0B65GFL
	vjXLIaxuhnTr1NGdKpWMchzQohG15fUk3x29QFdG68iaGHQHy4GS/GBQVsNeNM06Bznf6BH/koo
	mxKruI7G/24iTamP1VBlmqganRoBcGr7cr1pI5aWWGqcIiyUpjMz4B+g=
X-Gm-Gg: ASbGnctJS5CuPrmw/L97elGkz+rBz51iYtdM3bjMjHLVNBwEuwTppT6rtc6VmoDKm3x
	MiUW5eIq/nipKcVsFEj/wfdNn74Uak8alvY3X+psoKG30dwU1MOu0891sBP3uiHqJHZArAdTN9a
	Bx0+xyCkisco1vQGijF6BhUGHzKehim+y0+y/WG6554HXtkbfYaEGKvX0HnlMwA/GA1JvabHsUL
	vfeKfdfk+7iSP1p1o3H+bLQZwKKxyjgl7CharEIhkvAf58uGKKc7pv50uB9xx4HZYPVpr93ofaT
	fN/F8pAKzy37z9lgHBweSRSx85kB3K7JUfaoUspITmCkmuwA8P7A/BQTphIcWA==
X-Received: by 2002:a05:620a:3193:b0:7c5:aec7:7ecc with SMTP id af79cd13be357-7c75bbb2973mr216489985a.13.1743477128008;
        Mon, 31 Mar 2025 20:12:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg1j7Vc+zuUQ1pOrhianPa9k1mLxzvuGG2Gm2NPTKGwMMBDaWsWyn19rFctKJdNGrDvU+WZw==
X-Received: by 2002:a05:620a:3193:b0:7c5:aec7:7ecc with SMTP id af79cd13be357-7c75bbb2973mr216488085a.13.1743477127711;
        Mon, 31 Mar 2025 20:12:07 -0700 (PDT)
Received: from ?IPV6:2601:188:c100:5710:315f:57b3:b997:5fca? ([2601:188:c100:5710:315f:57b3:b997:5fca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7764c7fsm587396785a.84.2025.03.31.20.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 20:12:06 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <915d1261-ee9f-4080-a338-775982e1c48d@redhat.com>
Date: Mon, 31 Mar 2025 23:12:06 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
 <Z-shjD2OwHJPI0vG@slm.duckdns.org>
Content-Language: en-US
In-Reply-To: <Z-shjD2OwHJPI0vG@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/25 7:13 PM, Tejun Heo wrote:
> Hello,
>
> On Sun, Mar 30, 2025 at 05:52:39PM -0400, Waiman Long wrote:
> ...
>> One possible way to fix this is to iterate the dying cpusets as well and
>> avoid using the exclusive CPUs in those dying cpusets. However, this
>> can still cause random partition creation failures or other anomalies
>> due to racing. A better way to fix this race is to reset the partition
>> state at the moment when a cpuset is being killed.
> I'm not a big fan of adding another method call in the destruction path.
> css_offline() is where the kill can be seen from all CPUs and notified to
> the controller and I'm not sure why bringing it sooner would be necessary to
> close the race window. Can't the creation side drain the cgroups that are
> going down if the asynchronous part is a problem? e.g. We already have
> cgroup_lock_and_drain_offline() which isn't the most scalable thing but
> partition operations aren't very frequent, right? And if that's a problem,
> there should be a way to make it reasonably quicker.

The problem is the RCU delay between the time a cgroup is killed and is 
in a dying state and when the partition is deactivated when 
cpuset_css_offline() is called. That delay can be rather lengthy 
depending on the current workload.

Another alternative that I can think of is to scan the remote partition 
list for remote partition and sibling cpusets for local partition 
whenever some kind of conflicts are detected when enabling a partition. 
When a dying cpuset partition is detected, deactivate it immediately to 
resolve the conflict. Otherwise, the dying partition will still be 
deactivated at cpuset_css_offline() time.

That will be a bit more complex and I think can still get the problem 
solved without adding a new method. What do you think? If you are OK 
with that, I will send out a new patch later this week.

Thanks,
Longman


