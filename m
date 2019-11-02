Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4C3ECFB0
	for <lists+cgroups@lfdr.de>; Sat,  2 Nov 2019 17:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfKBQO4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Nov 2019 12:14:56 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:36588 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfKBQO4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Nov 2019 12:14:56 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id A459B2E0DDE;
        Sat,  2 Nov 2019 19:14:52 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id EyUENoXOa7-EqDSob5x;
        Sat, 02 Nov 2019 19:14:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572711292; bh=Yd0CleJdEZRkBuzs0TYF6lmKdD5XxhQPGhQbqlbh1rs=;
        h=In-Reply-To:References:Date:Message-ID:From:To:Subject;
        b=Hmd1SS8FaLYfXLialvxaRuDNR9z0cBETtPVQqrm55xgu7uifS0HC/9FbkK/S66nMS
         tdEfmITpnkRcvh1IeWvmV4LHVLiCeitt98Sacehrrtv06CdILIuXHfYN5YP71JEnkV
         DSJPImoOysWZL0BvYUYmBzfnHJmLy1K01HpixnW8=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8554:53c0:3d75:2e8a])
        by vla1-5826f599457c.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id VQiFRucw4e-EqVmg9Qb;
        Sat, 02 Nov 2019 19:14:52 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <157270779336.1961.6528158720593572480.stgit@buzz>
 <20191102160252.GA19103@freebsd.familie-tometzki.de>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <5c85a690-4ed7-91bb-30b5-c40174534a27@yandex-team.ru>
Date:   Sat, 2 Nov 2019 19:14:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191102160252.GA19103@freebsd.familie-tometzki.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 02/11/2019 19.02, Damian Tometzki wrote:
> On Sat, 02. Nov 18:16, Konstantin Khlebnikov wrote:
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
> Hello Konstantin,
> 
> iff --> if :-)
> 

This "iff" is shortened "if and only if".
https://en.wikipedia.org/wiki/If_and_only_if

> Best regards
> Damian
> 
> 
>> +		shortage has happened inside page fault, random
>> +		syscall may fail with ENOMEM or EFAULT. Since 4.19
>> +		failed memory cgroup allocation invokes oom killer and
>> +		keeps retrying until it succeeds.
>>   
>>   		This event is not raised if the OOM killer is not
>>   		considered as an option, e.g. for failed high-order
>>
