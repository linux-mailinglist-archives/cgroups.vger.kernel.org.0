Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64DE1CD540
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 11:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgEKJeK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 05:34:10 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:50660 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgEKJeK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 05:34:10 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9278C2E0B11;
        Mon, 11 May 2020 12:34:02 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id reGjoSLEJq-Y0XqJVmE;
        Mon, 11 May 2020 12:34:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1589189642; bh=MGEF9xP5Qv6FPGCxjbJhWxmWFx6dPI6oeezhHBsf+rc=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=mwS7DMSvBj3jlt9a2sJJCwLOkbkP58CsD+3SORjXLPm3zW7gkn/BKPM+pVY/cY8Kd
         KtQfD44pPGcoG4Unlp3e9zHUPnnQ/juS1UrcPZfdE1r+UuTCYen3qntrUl4pCIQLdR
         ftmD1pKYDy0WojoV1lcmwF07jbHqD+hRwG1y/XHw=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:423::1:1])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id YWKiKxEGPb-Y0WG1DhL;
        Mon, 11 May 2020 12:34:00 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] doc: cgroup: update note about conditions when oom killer
 is invoked
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
References: <158894738928.208854.5244393925922074518.stgit@buzz>
 <20200511083904.GB29153@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <0ddb8e58-5bfd-7754-6979-4276acf5b4c8@yandex-team.ru>
Date:   Mon, 11 May 2020 12:34:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511083904.GB29153@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 11/05/2020 11.39, Michal Hocko wrote:
> On Fri 08-05-20 17:16:29, Konstantin Khlebnikov wrote:
>> Starting from v4.19 commit 29ef680ae7c2 ("memcg, oom: move out_of_memory
>> back to the charge path") cgroup oom killer is no longer invoked only from
>> page faults. Now it implements the same semantics as global OOM killer:
>> allocation context invokes OOM killer and keeps retrying until success.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> 
>> ---
>>   Documentation/admin-guide/cgroup-v2.rst |   17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index bcc80269bb6a..1bb9a8f6ebe1 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -1172,6 +1172,13 @@ PAGE_SIZE multiple when read back.
>>   	Under certain circumstances, the usage may go over the limit
>>   	temporarily.
>>   
>> +	In default configuration regular 0-order allocation always
>> +	succeed unless OOM killer choose current task as a victim.
>> +
>> +	Some kinds of allocations don't invoke the OOM killer.
>> +	Caller could retry them differently, return into userspace
>> +	as -ENOMEM or silently ignore in cases like disk readahead.
> 
> I would probably add -EFAULT but the less error codes we document the
> better.

Yeah, EFAULT was a most obscure result of memory shortage.
Fortunately with new behaviour this shouldn't happens a lot.

Actually where it is still possible? THP always fallback to 0-order.
I mean EFAULT could appear inside kernel only if task is killed so
nobody would see it.

> 
>> +
>>   	This is the ultimate protection mechanism.  As long as the
>>   	high limit is used and monitored properly, this limit's
>>   	utility is limited to providing the final safety net.
>> @@ -1228,17 +1235,9 @@ PAGE_SIZE multiple when read back.
>>   		The number of time the cgroup's memory usage was
>>   		reached the limit and allocation was about to fail.
>>   
>> -		Depending on context result could be invocation of OOM
>> -		killer and retrying allocation or failing allocation.
>> -
>> -		Failed allocation in its turn could be returned into
>> -		userspace as -ENOMEM or silently ignored in cases like
>> -		disk readahead.  For now OOM in memory cgroup kills
>> -		tasks iff shortage has happened inside page fault.
>> -
>>   		This event is not raised if the OOM killer is not
>>   		considered as an option, e.g. for failed high-order
>> -		allocations.
>> +		allocations or if caller asked to not retry attempts.
>>   
>>   	  oom_kill
>>   		The number of processes belonging to this cgroup
> 
