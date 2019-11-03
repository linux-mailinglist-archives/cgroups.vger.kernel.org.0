Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF7B0ED2F0
	for <lists+cgroups@lfdr.de>; Sun,  3 Nov 2019 11:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfKCKrG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 3 Nov 2019 05:47:06 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:54846 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbfKCKrG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 3 Nov 2019 05:47:06 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 5C90D2E12F1;
        Sun,  3 Nov 2019 13:47:02 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id KHJR1XQOJA-kwROc7Pv;
        Sun, 03 Nov 2019 13:47:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572778021; bh=8XearGK11qBc8jFq4PW5InTouWf44DKhrpzFPg+Gueo=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=lE13eQSas0qHhNiasm2ObqKIkaStVX1Bl/Oof1cHomYycmF+AqaCUCFnFygtZe51t
         cs47xowN98FlJ3SPPgFC/g/p1NFvOdKgw++8jKGe4BbDJIljmDq/LYcsgndyL+Fww/
         SUjmai6T44Gtsi621bYmFOKMqVXtvXoF5h9yVh7c=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7101::1:7])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id Cpf51azSdT-kwV8oddc;
        Sun, 03 Nov 2019 13:46:58 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
To:     David Rientjes <rientjes@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <157270779336.1961.6528158720593572480.stgit@buzz>
 <alpine.DEB.2.21.1911021654020.34229@chino.kir.corp.google.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <fdef5cf2-553a-4f4f-aec9-129391834e9b@yandex-team.ru>
Date:   Sun, 3 Nov 2019 13:46:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911021654020.34229@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 03/11/2019 02.55, David Rientjes wrote:
> On Sat, 2 Nov 2019, Konstantin Khlebnikov wrote:
> 
>> Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the
>> charge path") memcg invokes oom killer not only for user page-faults.
>> This means 0-order allocation will either succeed or task get killed.
>>
>> Fixes: 8e675f7af507 ("mm/oom_kill: count global and memory cgroup oom kills")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |    9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 5361ebec3361..eb47815e137b 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1219,8 +1219,13 @@ PAGE_SIZE multiple when read back.
>>   
>>   		Failed allocation in its turn could be returned into
>>   		userspace as -ENOMEM or silently ignored in cases like
>> -		disk readahead.  For now OOM in memory cgroup kills
>> -		tasks iff shortage has happened inside page fault.
>> +		disk readahead.
>> +
>> +		Before 4.19 OOM in memory cgroup killed tasks iff
>> +		shortage has happened inside page fault, random
>> +		syscall may fail with ENOMEM or EFAULT. Since 4.19
>> +		failed memory cgroup allocation invokes oom killer and
>> +		keeps retrying until it succeeds.
>>   
>>   		This event is not raised if the OOM killer is not
>>   		considered as an option, e.g. for failed high-order
> 
> The previous text is obviously incorrect for today's kernels, but I'm
> curious if we should be conflating the documentation here by describing
> the pre-4.19 behavior.  OOM killing no longer happens only on page fault
> so maybe better to document the exact behavior today and not attempt to
> describe differences with previous versions?
> 

Previous behaviour was here for ages and 4.19 is not so old.
According too https://www.kernel.org/category/releases.html pre-4.19 will
be maintained for couple years at least. Let's keep this tombstone.

I've seen a lot of strange side effects of old behaviour.
Most obscure was a hang inside libc fork() when clone(CLONE_CHILD_SETTID)
silently fails to set child pid =)
https://lore.kernel.org/lkml/20150206162301.18031.32251.stgit@buzz/
