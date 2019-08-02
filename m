Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF1F97F3EA
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 12:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405225AbfHBKBQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 06:01:16 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:59604 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407093AbfHBKBO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 2 Aug 2019 06:01:14 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B6E762E1531;
        Fri,  2 Aug 2019 13:01:08 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id HOPkayq66P-18ZKcidf;
        Fri, 02 Aug 2019 13:01:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1564740068; bh=7bbzX4NqS7tPlZl7gqOBotqgWDukNiS3yB34/LQpZj4=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=moNr7gZ0cw46pUWpD6Kc7KZit/7vWlq/+bm9aSLLfyTHajQxFIF6NO0eZbtRnQnlt
         8/3f6xX2AE9lAZha1WwiDSi+7GkhRjLEfbfSQzeoRWg2vKQ12/g+secRmysS7PnKgh
         txBLBlys7Azw5kyL63Cc1ZWr+j7i4olh1Dv57I8A=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:6454:ac35:2758:ad6a])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id tiugwYi2cZ-18Q82FIR;
        Fri, 02 Aug 2019 13:01:08 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
To:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729154952.GC21958@cmpxchg.org> <20190729185509.GI9330@dhcp22.suse.cz>
 <20190802094028.GG6461@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <105a2f1f-de5c-7bac-3aa5-87bd1dbcaed9@yandex-team.ru>
Date:   Fri, 2 Aug 2019 13:01:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190802094028.GG6461@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 02.08.2019 12:40, Michal Hocko wrote:
> On Mon 29-07-19 20:55:09, Michal Hocko wrote:
>> On Mon 29-07-19 11:49:52, Johannes Weiner wrote:
>>> On Sun, Jul 28, 2019 at 03:29:38PM +0300, Konstantin Khlebnikov wrote:
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -847,8 +847,11 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>>>>   			ret = -ERESTARTSYS;
>>>>   			goto out;
>>>>   		}
>>>> -		cond_resched();
>>>>   
>>>> +		/* Reclaim memory over high limit before stocking too much */
>>>> +		mem_cgroup_handle_over_high(true);
>>>
>>> I'd rather this remained part of the try_charge() call. The code
>>> comment in try_charge says this:
>>>
>>> 	 * We can perform reclaim here if __GFP_RECLAIM but let's
>>> 	 * always punt for simplicity and so that GFP_KERNEL can
>>> 	 * consistently be used during reclaim.
>>>
>>> The simplicity argument doesn't hold true anymore once we have to add
>>> manual calls into allocation sites. We should instead fix try_charge()
>>> to do synchronous reclaim for __GFP_RECLAIM and only punt to userspace
>>> return when actually needed.
>>
>> Agreed. If we want to do direct reclaim on the high limit breach then it
>> should go into try_charge same way we do hard limit reclaim there. I am
>> not yet sure about how/whether to scale the excess. The only reason to
>> move reclaim to return-to-userspace path was GFP_NOWAIT charges. As you
>> say, maybe we should start by always performing the reclaim for
>> sleepable contexts first and only defer for non-sleeping requests.
> 
> In other words. Something like patch below (completely untested). Could
> you give it a try Konstantin?

This should work but also eliminate all benefits from deferred reclaim:
bigger batching and running without of any locks.

After that gap between high and max will work just as reserve for atomic allocations.

> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ba9138a4a1de..53a35c526e43 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2429,8 +2429,12 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>   				schedule_work(&memcg->high_work);
>   				break;
>   			}
> -			current->memcg_nr_pages_over_high += batch;
> -			set_notify_resume(current);
> +			if (gfpflags_allow_blocking(gfp_mask)) {
> +				reclaim_high(memcg, nr_pages, GFP_KERNEL);
> +			} else {
> +				current->memcg_nr_pages_over_high += batch;
> +				set_notify_resume(current);
> +			}
>   			break;
>   		}
>   	} while ((memcg = parent_mem_cgroup(memcg)));
> 
