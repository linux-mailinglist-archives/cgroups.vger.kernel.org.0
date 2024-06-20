Return-Path: <cgroups+bounces-3251-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B366E9106D4
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 15:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B60781C215CF
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3CF48CCD;
	Thu, 20 Jun 2024 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iAWXOVWD"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C01AC782
	for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718891606; cv=none; b=Wh60BB+GHVh/8bRzsaNhu5xtmuxALeitGarQW9gWn3UdJCiL+llenaIxsEZ5rQem1Z2GYx5uCxIQM4n7fEm0DicxV247pE8QPUqPminA1mKgBIzZwVY59rh3G4pIT3DsT2ehgeXMMKeetRgqd0c8ylSiV7QNU10kNOetUEKlgDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718891606; c=relaxed/simple;
	bh=w/uFHP8P1yGlPABbo121/TIN5IJtqMpUp1kMqb3444Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6uoiKNpkp5mSB3ZDrYQk04g4yc6AY1Nal0O6mm+PXL2bZ9lNVW+VnFnqNSZqsjlFz+3bqGOcWgu0oGCFdXTGdO4w5uIG106G+aMe7HzaacuSW4hTiiWSaWZJ7gSo4VGh8vYyoIkacjwSuAKkmtqmTM55Qr53R+KZIAI1dPmFe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iAWXOVWD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718891604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PNBVAgBh1qUdde5v1fyOGhK2OpFLFOvWHKPem6oZyJM=;
	b=iAWXOVWDKDuWNk9Uz/KEcSEt/rQYC9yV/CS8/g+VDFc6OVVCIv9q7QNxjVEXgclFfa+k/V
	aw4uvZLIx+4rWJevaOBgLT3uhDRMTwkkNRYMSt2Pv5eVBeo2Ci7do/wSdNbQIUqBQo/7VM
	uR4/XZZn2QY20/EUi+udApuM9ILWITs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-p5eHvLtrNLOT20EEzIP78Q-1; Thu, 20 Jun 2024 09:53:23 -0400
X-MC-Unique: p5eHvLtrNLOT20EEzIP78Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4229a964745so6878835e9.2
        for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 06:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718891602; x=1719496402;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PNBVAgBh1qUdde5v1fyOGhK2OpFLFOvWHKPem6oZyJM=;
        b=thEiQ53SDPkSz+szy2ND22GPQGQamx+bCkBvNjd6fllUZZ4Fq8or/RK2HTL7umkoS9
         ZznfV5mYt8OtBKzNI3of7YBBHdmRnOAIHelNl+0+yU4KA7fTu1Cfz5rThWh6tZtU5DSD
         c9K8cfZfnjabuQeIbpvZoNIFM87EMwGLWEaGK2fWH7Hlu/4pkt+QmetLbfC2x9l6dOe7
         0Ixy0OpxoRzEcJ54YWEmURF+n7OblbjTXzOyk2zxicuVLQxn352W7fbOBz+5a8aIi/rK
         qe5zcwdLZZ8EG/aJ6Ig12Nbg8K8uAxdv/sekKXMDeVbL8krqZ8VBuExblhgUBvGZm4Pk
         p6aA==
X-Forwarded-Encrypted: i=1; AJvYcCUx4kTVSij66fDKnN0QQfAPNZtj8zgV2HRG8KWEH4NW7pZRrHCRMlcgoIhM33qN8fz14/5dpUb5yExneyY/oIUXFqWPjlSQrw==
X-Gm-Message-State: AOJu0Ywoep0XHTPtBTtAMMcL5tCiVistSTvFvKp2OqltBAhFCIx3pH7F
	KtmVUgOAtz3sinqFuDMRAz660QZ7rm9ZKWismtou1jOLfouzv6FAg0Gk9wLNqWTVlT8Ea6VAG7n
	+H1E5ow9TZuVzAhbrmMWJw8hgA9Pv6vMVnwytyH+aZziqXlYsJzK5ib0=
X-Received: by 2002:a05:600c:4b19:b0:422:fdae:b687 with SMTP id 5b1f17b1804b1-42475184342mr40094275e9.17.1718891601886;
        Thu, 20 Jun 2024 06:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUrpDltGw0aYmrvP64jp8sAeYweHTuRQ1JJCRsyM56PxufV1oTqD+YVHKFqzFB9JfU965xsw==
X-Received: by 2002:a05:600c:4b19:b0:422:fdae:b687 with SMTP id 5b1f17b1804b1-42475184342mr40093895e9.17.1718891601373;
        Thu, 20 Jun 2024 06:53:21 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-364a5b38996sm2003695f8f.3.2024.06.20.06.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 06:53:20 -0700 (PDT)
Message-ID: <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
Date: Thu, 20 Jun 2024 15:53:18 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Cgroups <cgroups@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, jbeulich@suse.com,
 LTP List <ltp@lists.linux.it>
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
 <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 15:14, Naresh Kamboju wrote:
> On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
>>> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> This is the start of the stable review cycle for the 6.9.6 release.
>>>> There are 281 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>> The whole patch series can be found in one patch at:
>>>>          https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
>>>> or in the git tree and branch at:
>>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
>>>> and the diffstat can be found below.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>
>>> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
>>>
>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>
>>> 1)
>>> The LTP controllers cgroup_fj_stress test cases causing kernel crash
>>> on arm64 Juno-r2 with
>>> compat mode testing with stable-rc 6.9 kernel.
>>>
>>> In the recent past I have reported this issues on Linux mainline.
>>>
>>> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
>>>    - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
>>>
>>> it goes like this,
>>>    Unable to handle kernel NULL pointer dereference at virtual address
>>>    ...
>>>    Insufficient stack space to handle exception!
>>>    end Kernel panic - not syncing: kernel stack overflow
>>>

How is that related to 6.9.6-rc1? That report is from mainline (6.10.rc3).

Can you share a similar kernel dmesg output from  the issue on 6.9.6-rc1?

-- 
Cheers,

David / dhildenb


