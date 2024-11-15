Return-Path: <cgroups+bounces-5580-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D479CF363
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 18:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E51E1F219C4
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2024 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C501D8DFB;
	Fri, 15 Nov 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gl8PKqqz"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E761CEEB2
	for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731693357; cv=none; b=W/vBScR+gWS2NGkb6hrf+fbJPXl/UcEv+VHJv3GcUanuxxEZFkK4H38einqZ3wBWBWD7iK499zJtdb8irjMn4m94Qf2yaM/t5o0lJQMPr2XTCfx4kd1U6cvCBmBewa7FyxAHwTz8fz2yB9jqlhHDxnALkK/mpDEY8xJMkiwnX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731693357; c=relaxed/simple;
	bh=1UudV+Y/O2DT7CczE3lBShqjb8KX6ZN8X1AlHzhl9Bs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LIKpSSNHi90EBGq/tZ9xS8nFjlw32YPUjSqvM4oUzzUO4cZEIpBj7NV+uFIsKdivs0N/Qz2i1RswCTYHkxWPuQp8Oz4zuymXZjYV1IWy/OpRhZfrFWtyBWL9jspWQmPYDEFCh3b4HKMy1YKwslsTiBzEZSxaeQ3CrNXs0NzP4hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gl8PKqqz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731693355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PZ9g+prF726DXSyYrdVv/0vVba01Lxcn9IJr7aD26Os=;
	b=gl8PKqqzaNThxIondVLuV3vJ1ORPmVgUWSBIEWwjEt9kwPjrlyCbmxc4R4G2+iooB/og2p
	B1GiGNI+Ej3shhynws5Ln1az4rQsnx0Xxe8p24GulbQfKhHSRdFLoHiiLX9jq8jBpT+SRk
	Q40b39oKLPNf2ECypzMf4H+bHODot5I=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-v_83tscbOr2B04KStMN4pw-1; Fri, 15 Nov 2024 12:55:52 -0500
X-MC-Unique: v_83tscbOr2B04KStMN4pw-1
X-Mimecast-MFC-AGG-ID: v_83tscbOr2B04KStMN4pw
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e2971589916so1558372276.3
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2024 09:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731693351; x=1732298151;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ9g+prF726DXSyYrdVv/0vVba01Lxcn9IJr7aD26Os=;
        b=hEtirCbr0igEIQdjdImzgL6NQ3HsyKs4kApGa85XCBq0/g2EgNxwnTpGjokoM6Zw+e
         UyYIId4Ih4D+CnoI/l9uEbFNLbmOGlz5Op+6Yivrr+0SRczxXtOnp0A4StplG5+hcHnA
         i/HvIDKg+pC22Ay5ZyBHlPhAW1ahg/mpAJbFNccZ7ocUoglvefpCOtV015KzC33dUWOe
         GxlQ27jcBk26Nr8vAeuUEGx38e8n+1wsPPsob1Nbi7V/IGId1QiVphE81IteTVkKcW2K
         zq52Lcc8ZE3WAY4FGH3NWqF6CGB8DASbUB60GeL98mZ3rnA5453XvomJ7udW7U/SxVXA
         1HCg==
X-Forwarded-Encrypted: i=1; AJvYcCVyqASZ2qUc0ML2Otrz05/6+Oni4SfbaSkWhNUP+9nBffSY1po9122NsWkBkGLxDCjShi6Xt1M8@vger.kernel.org
X-Gm-Message-State: AOJu0YymFTI1/HvnjcmNja84ZPisvHuOhmVU+45wv8K+FSlOcAhvHels
	awkrm9eQT9so+DqZWshYD/OCstorH6tGnO3xZKMsCl7+zCqKII15fEcuyjbZn/wSPTCyWqZ8ezw
	FojiOOber1kXk1UTtsHK8BMDXOpFQfJQXJRSNIjsAS0AifoXyJRNjoEY=
X-Received: by 2002:a05:6902:c09:b0:e2b:ad82:e592 with SMTP id 3f1490d57ef6-e382639f2f9mr4089040276.36.1731693351361;
        Fri, 15 Nov 2024 09:55:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+1QWTBBsRsnWD7xEyBA7Byqtsr7Ze3dfkac9aauUWeB34a97OMqiAOUbZh5+RbEF8hgYARw==
X-Received: by 2002:a05:6902:c09:b0:e2b:ad82:e592 with SMTP id 3f1490d57ef6-e382639f2f9mr4089016276.36.1731693351000;
        Fri, 15 Nov 2024 09:55:51 -0800 (PST)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3f5b4f2aasm17482756d6.104.2024.11.15.09.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 09:55:50 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1515c439-32ef-4aee-9f69-c5af1fca79e3@redhat.com>
Date: Fri, 15 Nov 2024 12:55:49 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Disable cpuset_cpumask_can_shrink() test
 if not load balancing
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>
References: <20241114181915.142894-1-longman@redhat.com>
 <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
In-Reply-To: <ZzcoZj90XeYj3TzG@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/24 5:54 AM, Juri Lelli wrote:
> Hi Waiman,
>
> On 14/11/24 13:19, Waiman Long wrote:
>> With some recent proposed changes [1] in the deadline server code,
>> it has caused a test failure in test_cpuset_prs.sh when a change
>> is being made to an isolated partition. This is due to failing
>> the cpuset_cpumask_can_shrink() check for SCHED_DEADLINE tasks at
>> validate_change().
> What sort of change is being made to that isolated partition? Which test
> is failing from the test_cpuset_prs.sh collection? Asking because I now
> see "All tests PASSED" running that locally (with all my 3 patches on
> top of cgroup/for-6.13 w/o this last patch from you).

The failing test isn't an isolated partition. The actual test failure is

Test TEST_MATRIX[62] failed result check!
C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 . . X5 . . 0 
A1:0-4,A2:1-4,A3:2-4 A1:P0,A2:P-2,A3:P-1

In this particular case, cgroup A3 has the following setting before the 
X5 operation.

A1/A2/A3/cpuset.cpus: 2-4
A1/A2/A3/cpuset.cpus.exclusive: 4
A1/A2/A3/cpuset.cpus.effective: 4
A1/A2/A3/cpuset.cpus.exclusive.effective: 4
A1/A2/A3/cpuset.cpus.partition: root

I believe this is fixed by my other change in the commit to change 
arguments of cpuset_cpumask_can_shrink() to use effective_cpus instead 
as cpus_allowed may not represent what CPUs are currently used in the 
partition.

Cheers,
Longman


