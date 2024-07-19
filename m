Return-Path: <cgroups+bounces-3797-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00127937494
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CB2DB2258C
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 07:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9075D57C8D;
	Fri, 19 Jul 2024 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mInGDfpV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B82C80;
	Fri, 19 Jul 2024 07:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721375685; cv=none; b=M/XXWQxO8qtPJCs5gd82TH3M/SUz5QDiggOy8VN00T0zkk/M9Mx73RXvE4+1LenX7wq0vEsq0f3O7v+C/NCC5NL4N9hBwkNuj1RA3RP8xkXpdm6+rmgefWpJsCxg3y7m4RCVubwVj5DmxFOvv6T1bW0ivWwCV9kmQQJQ0NsEkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721375685; c=relaxed/simple;
	bh=bWcDV70r6eQGJyJJqDs1xMTbnoM4r5EvMsf4/4R/5M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbGpLjVieva5jzMhTr31/uWFkx6nNin/NVZ/mSA6d2JirWHXsyYIIAwnboNEYLaAxZA3aZVSLe6lNmzVAxgDldd9HIQerkN/0l5TmpMhH6JreX0SgItqo7hoxZWYgVQKZW7B1B/4I4R10te3H53wRW4/D8f7GFDGiyJaXMHELNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mInGDfpV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF6BC32782;
	Fri, 19 Jul 2024 07:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721375684;
	bh=bWcDV70r6eQGJyJJqDs1xMTbnoM4r5EvMsf4/4R/5M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mInGDfpVQ/i2+n7SY2uYp0BP2jZYocblZYrIAA7jjLUApJ1OpF1tWxmFi8MS3fIop
	 OvLc6YOJicmzLA15i+cqWyY09SxyNA7MOVm/Xcx/HWNKYvOtL8gNfAnRP4XIrs910S
	 fG+HiTMibYRCU6pGLTZhFzzP79LgGNu3RT3SfZZvAvHs/J+SE7BFLzUEnkRr/7O06P
	 5WnoFXxYLE5bifVCkrKm4wOfk2fYpc9/zQDQmc6yhIR7j8+dMZUTDfSL7xdog/Phgx
	 gPWT2yGprtXjIEiE1Lc5Q5BmOe+k5bBhaKYcBsAPeeI2Sxs+vV+t+fGExdhVXzyIgx
	 Dgpj2iF63PoQQ==
Message-ID: <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org>
Date: Fri, 19 Jul 2024 09:54:41 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>, tj@kernel.org,
 cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
 <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
 <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/07/2024 02.40, Shakeel Butt wrote:
> Hi Jesper,
> 
> On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wrote:
>>
> [...]
>>
>>
>> Looking at the production numbers for the time the lock is held for level 0:
>>
>> @locked_time_level[0]:
>> [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
>> [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>> [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
>> [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
>>
> 
> Is it possible to get the above histogram for other levels as well?

Data from other levels available in [1]:
  [1] 
https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org/

IMHO the data shows we will get most out of skipping level-0 root-cgroup 
flushes.

Copy-pasted here (adj whitespaces hoping it better fit email):

Time below is in nanosec:
  - M -> ms
  - K -> usec

@locked_time_level[0]:
[4M, 8M)      623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
[8M, 16M)     860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[16M, 32M)    295 |@@@@@@@@@@@@@@@@@      |
[32M, 64M)    275 |@@@@@@@@@@@@@@@@      |

@locked_time_level[1]:
[4K, 8K)        6 |@@@@      |
[8K, 16K)      65 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[16K, 32K)     52 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
[32K, 64K)     23 |@@@@@@@@@@@@@@@@@@      |
[64K, 128K)    15 |@@@@@@@@@@@@      |
[128K, 256K)   10 |@@@@@@@@      |
[256K, 512K)    6 |@@@@      |
[512K, 1M)     15 |@@@@@@@@@@@@      |
[1M, 2M)        2 |@      |
[2M, 4M)       14 |@@@@@@@@@@@      |
[4M, 8M)        6 |@@@@      |
[8M, 16M)       7 |@@@@@      |
[16M, 32M)      1 |      |

@locked_time_level[2]:
[2K, 4K)        1 |      |
[4K, 8K)      160 |@@@@@@@@@      |
[8K, 16K)     733 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
[16K, 32K)    901 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)    191 |@@@@@@@@@@@      |
[64K, 128K)   115 |@@@@@@      |
[128K, 256K)   61 |@@@      |
[256K, 512K)   70 |@@@@      |
[512K, 1M)     59 |@@@      |
[1M, 2M)       27 |@      |
[2M, 4M)        9 |      |

@locked_time_level[3]:
[1K, 2K)        3 |      |
[2K, 4K)        2 |      |
[4K, 8K)        5 |      |
[8K, 16K)     147 |@@@@@@      |
[16K, 32K)   1222 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)    266 |@@@@@@@@@@@      |
[64K, 128K)   199 |@@@@@@@@      |
[128K, 256K)  146 |@@@@@@      |
[256K, 512K)  124 |@@@@@      |
[512K, 1M)     17 |      |
[1M, 2M)        0 |      |
[2M, 4M)        0 |      |
[4M, 8M)        1 |      |

@locked_time_level[4]:
[4K, 8K)        2 |@@      |
[8K, 16K)      17 |@@@@@@@@@@@@@@@@@@@@@@      |
[16K, 32K)     40 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)      4 |@@@@@      |


> I know this is 12 numa node machine, how many total CPUs are there?

192 CPU cores (incl HyperThreaded).

--Jesper

