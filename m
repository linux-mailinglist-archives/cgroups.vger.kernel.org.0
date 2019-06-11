Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34AE43CC05
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2019 14:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbfFKMqt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jun 2019 08:46:49 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41406 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387563AbfFKMqs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jun 2019 08:46:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id 33so6120448qtr.8
        for <cgroups@vger.kernel.org>; Tue, 11 Jun 2019 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZpJoiyTHXYiF7kVWlp5BjDY7BKtjLiYkm/X37H4JtRA=;
        b=hLRASOXJ6YWopQW2zJe/it1PtEXmPcjruiqSpyOQKa5oD3C8YF+KvSNFv+xPBPv8TH
         CzCRYOnzTi4MviZsxUxLvtnYX/SstM6qMHkP2ZjCGdKb4NOMo4OzomCUwM9AkZRJvLcY
         zBlSTNXp47ZYVck/lb2Vf8hj+ivWJlgzX8hHHfJACZXIAazfHU6t6bVEp/2MWe1uv3gW
         uyDUU1Pw4fo18A5CmdAe1aQn+1GjjYUMlwnvuYNfoWxQ+TfCNSVL8tW0FDAe57IqSIZl
         TCwTH4gLQ/iBsYni03TKMCwq5TPb+YwXTrsEGY4TugtM+wRkRbwhzTzCkT+wKtQlm0Df
         hqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZpJoiyTHXYiF7kVWlp5BjDY7BKtjLiYkm/X37H4JtRA=;
        b=oxLlYdHltxKctzG9y5NDjT2AlC8nf1WXV5Kzf/hik9zESnUAvrQcPFYN9alNgjId7j
         cO67woJcvNQAX/Vf9D6KrPczf014Yzz6VHi/SyyWpwDtPlJk4Hhr1tmwkMfFN9sVgsQx
         qDBXnWjTAKsrdAL/lkbaJhTeCi21ihG87zGQHwgHWgKG4tyu3kRWqZfXgwXO/t3m19Nq
         ltxwH/APFur6xEX4TjHXE8mLaju7dsf+XgWMkgFFbxy4q7kdYbgh6/kmt8ulMj3cy/+E
         9RmTYGAI3wqDga6jsHWTdv7z9mNxqPz/A4xsZ8r9VVQIc+GVCB4eV7r4CW8PHdoFhkAX
         bfsQ==
X-Gm-Message-State: APjAAAUB1j9ZlwdKShGyav3ZmN5sKoKZJyZcsZi7fszlYOcf3uvnhrqX
        BOkdIDL9n8OdVsFzF2PodXvjkw==
X-Google-Smtp-Source: APXvYqwO5+sxJPYjLg249ECV9oOGg9Mp8tZmJ0f1umM1BO5C8rtfLDuiPkC+udH3Ifno3lmofhD1OA==
X-Received: by 2002:a0c:95af:: with SMTP id s44mr33429845qvs.162.1560257207741;
        Tue, 11 Jun 2019 05:46:47 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s23sm6636182qtk.31.2019.06.11.05.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 05:46:46 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20190611124118.GA4761@rapoport-lnx>
Date:   Tue, 11 Jun 2019 08:46:45 -0400
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        catalin.marinas@arm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mhocko@kernel.org, linux-mm@kvack.org, vdavydov.dev@gmail.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F6E1B9F-3789-4648-B95C-C4243B57DA02@lca.pw>
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
 <20190604142338.GC24467@lakrids.cambridge.arm.com>
 <20190610114326.GF15979@fuggles.cambridge.arm.com>
 <1560187575.6132.70.camel@lca.pw>
 <20190611100348.GB26409@lakrids.cambridge.arm.com>
 <20190611124118.GA4761@rapoport-lnx>
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Jun 11, 2019, at 8:41 AM, Mike Rapoport <rppt@linux.ibm.com> wrote:
>=20
> On Tue, Jun 11, 2019 at 11:03:49AM +0100, Mark Rutland wrote:
>> On Mon, Jun 10, 2019 at 01:26:15PM -0400, Qian Cai wrote:
>>> On Mon, 2019-06-10 at 12:43 +0100, Will Deacon wrote:
>>>> On Tue, Jun 04, 2019 at 03:23:38PM +0100, Mark Rutland wrote:
>>>>> On Tue, Jun 04, 2019 at 10:00:36AM -0400, Qian Cai wrote:
>>>>>> The commit "arm64: switch to generic version of pte allocation"
>>>>>> introduced endless failures during boot like,
>>>>>>=20
>>>>>> kobject_add_internal failed for pgd_cache(285:chronyd.service) =
(error:
>>>>>> -2 parent: cgroup)
>>>>>>=20
>>>>>> It turns out __GFP_ACCOUNT is passed to kernel page table =
allocations
>>>>>> and then later memcg finds out those don't belong to any cgroup.
>>>>>=20
>>>>> Mike, I understood from [1] that this wasn't expected to be a =
problem,
>>>>> as the accounting should bypass kernel threads.
>>>>>=20
>>>>> Was that assumption wrong, or is something different happening =
here?
>>>>>=20
>>>>>>=20
>>>>>> backtrace:
>>>>>>   kobject_add_internal
>>>>>>   kobject_init_and_add
>>>>>>   sysfs_slab_add+0x1a8
>>>>>>   __kmem_cache_create
>>>>>>   create_cache
>>>>>>   memcg_create_kmem_cache
>>>>>>   memcg_kmem_cache_create_func
>>>>>>   process_one_work
>>>>>>   worker_thread
>>>>>>   kthread
>>>>>>=20
>>>>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>>>>> ---
>>>>>>  arch/arm64/mm/pgd.c | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>=20
>>>>>> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
>>>>>> index 769516cb6677..53c48f5c8765 100644
>>>>>> --- a/arch/arm64/mm/pgd.c
>>>>>> +++ b/arch/arm64/mm/pgd.c
>>>>>> @@ -38,7 +38,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>>>>>>  	if (PGD_SIZE =3D=3D PAGE_SIZE)
>>>>>>  		return (pgd_t *)__get_free_page(gfp);
>>>>>>  	else
>>>>>> -		return kmem_cache_alloc(pgd_cache, gfp);
>>>>>> +		return kmem_cache_alloc(pgd_cache, =
GFP_PGTABLE_KERNEL);
>>>>>=20
>>>>> This is used to allocate PGDs for both user and kernel pagetables =
(e.g.
>>>>> for the efi runtime services), so while this may fix the =
regression, I'm
>>>>> not sure it's the right fix.
>>>>>=20
>>>>> Do we need a separate pgd_alloc_kernel()?
>>>>=20
>>>> So can I take the above for -rc5, or is somebody else working on a =
different
>>>> fix to implement pgd_alloc_kernel()?
>>>=20
>>> The offensive commit "arm64: switch to generic version of pte =
allocation" is not
>>> yet in the mainline, but only in the Andrew's tree and linux-next, =
and I doubt
>>> Andrew will push this out any time sooner given it is broken.
>>=20
>> I'd assumed that Mike would respin these patches to implement and use
>> pgd_alloc_kernel() (or take gfp flags) and the updated patches would
>> replace these in akpm's tree.
>>=20
>> Mike, could you confirm what your plan is? I'm happy to review/test
>> updated patches for arm64.
>=20
> Sorry for the delay, I'm mostly offline these days.
>=20
> I wanted to understand first what is the reason for the failure. I've =
tried
> to reproduce it with qemu, but I failed to find a bootable =
configuration
> that will have PGD_SIZE !=3D PAGE_SIZE :(
>=20
> Qian Cai, can you share what is your environment and the kernel =
config?


https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config

# lscpu
Architecture:        aarch64
Byte Order:          Little Endian
CPU(s):              256
On-line CPU(s) list: 0-255
Thread(s) per core:  4
Core(s) per socket:  32
Socket(s):           2
NUMA node(s):        2
Vendor ID:           Cavium
Model:               1
Model name:          ThunderX2 99xx
Stepping:            0x1
BogoMIPS:            400.00
L1d cache:           32K
L1i cache:           32K
L2 cache:            256K
L3 cache:            32768K
NUMA node0 CPU(s):   0-127
NUMA node1 CPU(s):   128-255
Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics =
cpuid asimdrdm

# dmidecode
Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: HPE
        Product Name: Apollo 70            =20
        Version: X1
        Wake-up Type: Power Switch
        Family: CN99XX


