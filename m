Return-Path: <cgroups+bounces-12380-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17670CC3D5D
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 16:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47F7E30C2EC5
	for <lists+cgroups@lfdr.de>; Tue, 16 Dec 2025 14:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7A730F54B;
	Tue, 16 Dec 2025 14:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHRjRU6w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="f/7qqRbh"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4430DD3A
	for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765897089; cv=none; b=cInTsAWpQKxp+XCu3aHdzeYnSxDsnbUJ5c9jXCUXa11m50G1Pjs+d5+nLrxyekWlTB1rZJTMvaXzr9wkYQ/ww8iDkkvl7m0Oi8Yz78qWiQxb4J7r3GdJ8oar75ru4G5Y139IybTomVWAKAo7Jf4rwq5vJfDb1ADf4HogWvdCMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765897089; c=relaxed/simple;
	bh=W7dryJ1q2mbpmpztu3wHATkjMFt/4D0jHeGNKYn9Bac=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QcCMUWkpXlcg14W3hL2mAo/lR0TX06w5YtII7nzDcYjayZsfMA4my5k8xisSPPKCeQ21zz3K7OhPrw/Wg9PpptFzAJ2HQuaSc/9r/ad8g/B49Mv3VBE2JUw3AVIZVomGAhrHkh7urjVkA3Goh8qi8dUs54jnDN6PSb0++n7nops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHRjRU6w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=f/7qqRbh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765897086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3Wv45hUbVGlF0RUYD6Si6nD1I/25el12dOJI1Yawrs=;
	b=VHRjRU6wMiXmuzb7alX9lbgWcVYFR3atiYHa4A32Mm7jnpGKrCxyQLpNQ02oroSRYSPTdW
	zjpEzNjG/xnHl76uGQnCdJUhEPK7OdpfXnH9B8gij/ypNd3Et3ePBXkLRdiNabyjBS2Bvt
	OIna1IaRl502ULwpaCot7GxeVqPSGT8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-gG38sFy8P6uG0vkSlTTcuA-1; Tue, 16 Dec 2025 09:58:04 -0500
X-MC-Unique: gG38sFy8P6uG0vkSlTTcuA-1
X-Mimecast-MFC-AGG-ID: gG38sFy8P6uG0vkSlTTcuA_1765897084
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8888447ffebso116339036d6.1
        for <cgroups@vger.kernel.org>; Tue, 16 Dec 2025 06:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765897084; x=1766501884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P3Wv45hUbVGlF0RUYD6Si6nD1I/25el12dOJI1Yawrs=;
        b=f/7qqRbhIE4QQXQd60m/KpSe2Klk/Qyw77XkJEqj6QFFa2TNcIspOYkR21ob5Q/4Hi
         nmvMjm/aXx1riFSgsotL6P9/Hzik0RxMF9cidppVylSO5ccV/zXNSW8lXI4FxI/zrWWc
         ANhO1F6xub7OXL6hESS99hDdLn6OMRog0DzPnW8bzyX8mNnX+Fi9z+DpQO6BLV4j3RXZ
         XvFaGjVDr3taz6aC0M8qdQsL1XbcIIGxr9zPgLztNyzIglUmOkiw2MXgPI6LrhxGmxGu
         capCNwTtrPvgnEW0xqLaaZGXosba8kis83Tk372gKT17jpE6Z9yEHx1iASRCTVhJDTyN
         AmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765897084; x=1766501884;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3Wv45hUbVGlF0RUYD6Si6nD1I/25el12dOJI1Yawrs=;
        b=v6frsg5t0QCxV55to/b7gndcXYird0UhKc2+KcvxmwA3Svxgj9OuXFtpQERlfxIIc5
         T5UGopVSj1G5eGk/k3cY7vNdd0UP22eij9yilSpHI170Ceu7YGr5Wr4AKtR5/r6cls+S
         8r3Xf0gpHIndhM3lAqW+4ulj24pdOwLEv2tV4XGSSVVHGrq36MeP25RyKwWbl7IJSz2A
         0s+ebqSEVdIfsnvbbg5zIu7aSW3BksJjDc5M9n1g+rKL9cJG25YgAVZGXjWdY/rycJiJ
         vO0D3dPujXYXO6vx62Fi9Q/3RTDRD0rhd8DJY5V1GwtRVVD6LuE6QYIuKg3Ub5L0IJ4z
         mzNw==
X-Forwarded-Encrypted: i=1; AJvYcCWWRE0dyenOSyDUtmmR0gqkdIS0t+iYwaQUqI8SCCsZjUp6trik48d/ptIImDwLjCx3effFlTP2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9zKvL7bDEWefLtosHIgu0vQhwys1H8AZu5b2NrZeY7r7Okzy
	/pGmwjNFHobf/TiBHnTwpdsg2kggMNrEkT93MJpM+C813Z4+0ww9Mym7teWDjRLlhC1jfp1CjNO
	AwXc6drTIN1LjYtNHPWoPc9V8UeXWfEVNkIZXn1DAlT8vxKNlpJxlmZsY9xM=
X-Gm-Gg: AY/fxX7/X02oMymXQ0v18nKKE86r7AKppeqkRENRqkuVh1vSl9RVfEfGEjeX5oFCfWY
	dMhiwte23ZDwViU48AWA69bNsY1P5uBUbrXEl48hqqkPkfmDSidbPTjOKOoCu/3OvvI7LXsRejw
	WFF5PlqcxAShvge0gu6Bojxa64CDh21rgZwpGvBmi4R3Z/Zs571OaRkZG9/ecKZSLkVLpo249nU
	FCWOIb6WWiKHPwa+Nj7NlGwI7U0Ql2qICjpPCv9HJrX7QuGX31yrBSXSh2s0BJDtUOPl4cJX18M
	Ubq4pA1v7vGEro5YjViw5lH68SGfFLECMP62Q7EmsXgdpf638TNJ6j/qfmqjxGGLMdiTSbmrJZl
	RbE1LB7wOYQBW6fY1fHI1pIwb88jerx37LteFm5bYwzQfBQYX3V5zZtQ5
X-Received: by 2002:a05:6214:23c9:b0:882:6d84:ebfa with SMTP id 6a1803df08f44-8887e133212mr215059566d6.40.1765897084144;
        Tue, 16 Dec 2025 06:58:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDvFD1v1CVQEJ877Is+NhuE05+NuPhO+okK9L2J6BsTUzD19NK/5XEcjq/2MMzehqW+HPz2Q==
X-Received: by 2002:a05:6214:23c9:b0:882:6d84:ebfa with SMTP id 6a1803df08f44-8887e133212mr215059106d6.40.1765897083653;
        Tue, 16 Dec 2025 06:58:03 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-889a85f02efsm76981516d6.46.2025.12.16.06.58.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 06:58:03 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <5a35692f-2800-4fd4-9c23-97d0284293df@redhat.com>
Date: Tue, 16 Dec 2025 09:58:02 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: add cpuset1_online_css helper for
 v1-specific operations
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, lujialin4@huawei.com
References: <20251216012845.2437419-1-chenridong@huaweicloud.com>
 <sowksqih3jeosuqa7cqnnwnexrgklttpjpfzdxjv2tmc7ym45r@vrmubshmlyqi>
 <a45617e5-7710-49e8-a231-511ae77b5e51@huaweicloud.com>
 <vprpzrc6g4ad4m2pwj6j5xp3do7pd7djivhgeoutp6z2qmeq22@ttgkqpew7uo4>
Content-Language: en-US
In-Reply-To: <vprpzrc6g4ad4m2pwj6j5xp3do7pd7djivhgeoutp6z2qmeq22@ttgkqpew7uo4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/16/25 9:03 AM, Michal Koutný wrote:
> On Tue, Dec 16, 2025 at 08:13:53PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> Regarding the lock assertions: cpuset_mutex is defined in cpuset.c and is not visible in
>> cpuset-v1.c. Given that cpuset v1 is deprecated, would you prefer that we add a helper to assert
>> cpuset_mutex is locked? Is that worth?
> It could be un-static'd and defined in cpuset-internal.h. (Hopefully, we
> should not end up with random callers of the helper but it's IMO worth
> it for docs and greater safety.)
I would suggest defining a "assert_cpuset_lock_held(void)" helper 
function and put the declaration in include/linux/cpuset.h together with 
cpuset_lock/unlock() to complete the full set. This will allow other 
kernel subsystems to acquire the cpuset_mutex and assert that the mutex 
was held.
>
>> Should we guard with !cpuset_v2() or !is_in_v2mode()?
>>
>> In cgroup v1, if the cpuset is operating in v2 mode, are these flags still valid?
> I have no experience with this transitional option so that made me look
> at the docs and there we specify it only affects behaviors of CPU masks,
> not the extra flags. So I wanted to suggest !cpuset_v2(), correct?

The "cpuset_v2_mode" mount flag is used for making the behavior of 
cpuset.{cpus,mems}.effective in v1 behave like in v2. It has no effect 
on other v1 specific control files. So cpuset1_online_css() should only 
be called if "!cpuset_v2()".

Cheers,
Longman

>
> Thanks,
> Michal


