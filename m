Return-Path: <cgroups+bounces-3253-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679C19107FC
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 16:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C3612825DF
	for <lists+cgroups@lfdr.de>; Thu, 20 Jun 2024 14:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4A1AD9D3;
	Thu, 20 Jun 2024 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S72+N/V4"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054881AD4B4
	for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893220; cv=none; b=QLcl3njAd6TgKaaJxS6tCeuqv0jKTkksf6I6GLgkcuNbDF20EwExNrwFTcHndGQx+vJXCHaj207n/ImDH80PrKn2iOirn+2al+Wr7srUJP1WVifHIeUatcw2wTHxxgMjJ4EfG3c+55h4sW20SRremf1uZQzAryGrTD3YLCH5OsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893220; c=relaxed/simple;
	bh=EP81fzKArsSo2Fm95OfrjSibEXltMZuTIs31bJ74/aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1GFFpKulrHKsdId/59bK3/PVxUMg07b3kXorCngrPOeWLdwZwPjR4Blu3GCLSt1ziWU05y+YxfFodIQnHuHTgkPCQirRbIgDFtVSQ3ExU3dam4sT7JIJkSrv73xWYEOH1FZm1CG2oyJm9NHrDXVS9PL2n+bflxcIJxEd8ERJTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S72+N/V4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718893218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5YwJR1NKRwN4fL5jNH9a/kXcG9cHy+5EzEQU+rHMO3I=;
	b=S72+N/V483POiE9wFosQyDNytEF4o9GCKDj+5CbyQG42Dca70iYA1a4lNxw5ehEeRy3yOA
	aQxSp9MSvIDvztJ8o7cFHUobuxO+IyBOYjUvS7zkxaBkZ88omIGQ4R14REcweHqMCiUg3W
	iW+yB4V2AuKKm7S2qES5CDEZIOe4Ox4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-1lhws8EoOhm8vJcAmOTcYQ-1; Thu, 20 Jun 2024 10:20:16 -0400
X-MC-Unique: 1lhws8EoOhm8vJcAmOTcYQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-52bc0027a29so643626e87.3
        for <cgroups@vger.kernel.org>; Thu, 20 Jun 2024 07:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893215; x=1719498015;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5YwJR1NKRwN4fL5jNH9a/kXcG9cHy+5EzEQU+rHMO3I=;
        b=FYqEYZTPNieUuifJ98Q1fZQb8+9vFcUCz6tO5iJ6CKyH7j+LMgrfsUpWBjnaY03ysu
         CfpIrYdPWRtSwfy4qPDUNplAyD1XJmlzzGDBbsgXuTKlfNHni1xGUNTROdl9QM6snOTF
         dM4Ed38uF33ftDLnlOiTDx3DyBE1CyieM31hiOkdhTcaSLZMvKiTItzIv/GaJ7zBJOD4
         VbqlNEzL/fcGg0CA941kXlTtDD91KHhaK+9/Ai1S9cx55e0OeQ1hwnhrciWDzWuyqgQj
         iaAcMU5doISjwWcLPyvqMHso+L/N2IZM714eqTQj+Nd2rMzaHWLIxFtC2N9Ma2QEbm1c
         yxuA==
X-Forwarded-Encrypted: i=1; AJvYcCUmjOyYFMYLjqp/TzpvunBJbsWZCdl8Hcm7VSvrsL0rKEEUsGUf9V3GwSnOFiRjJVLddDmALPanPpkmBpbSPs37MLmA+zQN3Q==
X-Gm-Message-State: AOJu0YzajLu2fEsasAHmhw2hcomXoZJqyxm/WTAM7MHIBsVeZv4tBgDf
	AqUFl+xKLm8M8c14Zd2JKxsalFPbbnFO7yccera+Vmud5jtemZ6pSuNKaRc6tWqRdTEzr5fN4o9
	Ql7Rc8X9LCcs30hLvfMvZCOCxU3CbeAcl9AsEnxGohZdMXYatmPj0IuY=
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id 2adb3069b0e04-52ccaa5693emr4100923e87.11.1718893214972;
        Thu, 20 Jun 2024 07:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeTQL8Yco26PVM8D0V3en6/5afdIHWF/18NOFXb2mr5OHhn1CZokrSB4RjI8WqqCIc8xXp9g==
X-Received: by 2002:a05:6512:3d04:b0:52b:c262:99b3 with SMTP id 2adb3069b0e04-52ccaa5693emr4100901e87.11.1718893214477;
        Thu, 20 Jun 2024 07:20:14 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b63b5sm27811365e9.7.2024.06.20.07.20.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 07:20:13 -0700 (PDT)
Message-ID: <3cd2cdca-5c89-447e-b6f1-f68112cf3f7b@redhat.com>
Date: Thu, 20 Jun 2024 16:20:12 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.9 000/281] 6.9.6-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Miaohe Lin <linmiaohe@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Cgroups <cgroups@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 jbeulich@suse.com, LTP List <ltp@lists.linux.it>
References: <20240619125609.836313103@linuxfoundation.org>
 <CA+G9fYtPV3kskAyc4NQws68-CpBrV+ohxkt1EEaAN54Dh6J6Uw@mail.gmail.com>
 <2024062028-caloric-cost-2ab9@gregkh>
 <CA+G9fYsr0=_Yzew1uyUtrZ7ayZFYqmaNzAwFZJPjFnDXZEwYcQ@mail.gmail.com>
 <36a38846-0250-4ac2-b2d0-c72e00d6898d@redhat.com>
 <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+G9fYv4fZiB-pL7=4SNfudh2Aqknf5+OXo1RFAFRhJFZMsEsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 16:02, Naresh Kamboju wrote:
> On Thu, 20 Jun 2024 at 19:23, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 20.06.24 15:14, Naresh Kamboju wrote:
>>> On Thu, 20 Jun 2024 at 17:59, Greg Kroah-Hartman
>>> <gregkh@linuxfoundation.org> wrote:
>>>>
>>>> On Thu, Jun 20, 2024 at 05:21:09PM +0530, Naresh Kamboju wrote:
>>>>> On Wed, 19 Jun 2024 at 18:41, Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>>
>>>>>> This is the start of the stable review cycle for the 6.9.6 release.
>>>>>> There are 281 patches in this series, all will be posted as a response
>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>> let me know.
>>>>>>
>>>>>> Responses should be made by Fri, 21 Jun 2024 12:55:11 +0000.
>>>>>> Anything received after that time might be too late.
>>>>>>
>>>>>> The whole patch series can be found in one patch at:
>>>>>>           https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.6-rc1.gz
>>>>>> or in the git tree and branch at:
>>>>>>           git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
>>>>>> and the diffstat can be found below.
>>>>>>
>>>>>> thanks,
>>>>>>
>>>>>> greg k-h
>>>>>
>>>>> There are two major issues on arm64 Juno-r2 on Linux stable-rc 6.9.6-rc1
>>>>>
>>>>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>>>>
>>>>> 1)
>>>>> The LTP controllers cgroup_fj_stress test cases causing kernel crash
>>>>> on arm64 Juno-r2 with
>>>>> compat mode testing with stable-rc 6.9 kernel.
>>>>>
>>>>> In the recent past I have reported this issues on Linux mainline.
>>>>>
>>>>> LTP: fork13: kernel panic on rk3399-rock-pi-4 running mainline 6.10.rc3
>>>>>     - https://lore.kernel.org/all/CA+G9fYvKmr84WzTArmfaypKM9+=Aw0uXCtuUKHQKFCNMGJyOgQ@mail.gmail.com/
>>>>>
>>>>> it goes like this,
>>>>>     Unable to handle kernel NULL pointer dereference at virtual address
>>>>>     ...
>>>>>     Insufficient stack space to handle exception!
>>>>>     end Kernel panic - not syncing: kernel stack overflow
>>>>>
>>
>> How is that related to 6.9.6-rc1? That report is from mainline (6.10.rc3).
>>
>> Can you share a similar kernel dmesg output from  the issue on 6.9.6-rc1?
> 
> I request you to use this link for detailed boot log, test log and crash log.
>   - https://lkft.validation.linaro.org/scheduler/job/7687060#L23314
> 
> Few more logs related to build artifacts links provided in the original
> email thread and bottom of this email.
> 
> crash log:
> ---
> 

Thanks, so this is something different than the

"BUG: Bad page map in process fork13
  BUG: Bad rss-counter state mm:"

stuff on mainline you referenced.

Looks like some recursive exception until we exhausted the stack.


Trying to connect the dots here, can you enlighten me how this is 
related to the fork13 mainline report?

> [ 0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
> [ 0.000000] Linux version 6.9.6-rc1 (tuxmake@tuxmake)
> (aarch64-linux-gnu-gcc (Debian 13.2.0-12) 13.2.0, GNU ld (GNU Binutils
> for Debian) 2.42) #1 SMP PREEMPT @1718817000
> ...
> [ 1786.336761] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000070
> [ 1786.345564] Mem abort info:
> [ 1786.348359]   ESR = 0x0000000096000004
> [ 1786.352112]   EC = 0x25: DABT (current EL), IL = 32 bits
> [ 1786.357434]   SET = 0, FnV = 0
> [ 1786.360492]   EA = 0, S1PTW = 0
> [ 1786.363637]   FSC = 0x04: level 0 translation fault
> [ 1786.368523] Data abort info:
> [ 1786.371405]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> [ 1786.376900]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> [ 1786.381960]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> [ 1786.387284] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000000000070
> [ 1786.387293] Insufficient stack space to handle exception!
> [ 1786.387296] ESR: 0x0000000096000047 -- DABT (current EL)
> [ 1786.387302] FAR: 0xffff80008399ffe0
> [ 1786.387306] Task stack:     [0xffff8000839a0000..0xffff8000839a4000]
> [ 1786.387312] IRQ stack:      [0xffff8000837f8000..0xffff8000837fc000]
> [ 1786.387319] Overflow stack: [0xffff00097ec95320..0xffff00097ec96320]
> [ 1786.387327] CPU: 4 PID: 0 Comm: swapper/4 Not tainted 6.9.6-rc1 #1
> [ 1786.387338] Hardware name: ARM Juno development board (r2) (DT)
> [ 1786.387344] pstate: a00003c5 (NzCv DAIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [ 1786.387355] pc : _prb_read_valid (kernel/printk/printk_ringbuffer.c:2109)
> [ 1786.387374] lr : prb_read_valid (kernel/printk/printk_ringbuffer.c:2183)
> [ 1786.387385] sp : ffff80008399ffe0
> [ 1786.387390] x29: ffff8000839a0030 x28: ffff000800365f00 x27: ffff800082530008
> [ 1786.387407] x26: ffff8000834e33b8 x25: ffff8000839a00b0 x24: 0000000000000001
> [ 1786.387423] x23: ffff8000839a00a8 x22: ffff8000830e3e40 x21: 0000000000001e9e
> [ 1786.387438] x20: 0000000000000000 x19: ffff8000839a01c8 x18: 0000000000000010
> [ 1786.387453] x17: 72646461206c6175 x16: 7472697620746120 x15: 65636e6572656665
> [ 1786.387468] x14: 726564207265746e x13: 3037303030303030 x12: 3030303030303030
> [ 1786.387483] x11: 2073736572646461 x10: ffff800083151ea0 x9 : ffff80008014273c
> [ 1786.387498] x8 : ffff8000839a0120 x7 : 0000000000000000 x6 : 0000000000000e9f
> [ 1786.387512] x5 : ffff8000839a00c8 x4 : ffff8000837157c0 x3 : 0000000000000000
> [ 1786.387526] x2 : ffff8000839a00b0 x1 : 0000000000000000 x0 : ffff8000830e3f58
> [ 1786.387542] Kernel panic - not syncing: kernel stack overflow
> [ 1786.387549] SMP: stopping secondary CPUs
> [ 1787.510055] SMP: failed to stop secondary CPUs 0,4
> [ 1787.510065] Kernel Offset: disabled
> [ 1787.510068] CPU features: 0x4,00001061,e0100000,0200421b
> [ 1787.510076] Memory Limit: none
> [ 1787.680436] ---[ end Kernel panic - not syncing: kernel stack overflow ]---


-- 
Cheers,

David / dhildenb


