Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8303482C7A
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2019 09:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbfHFHT4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Aug 2019 03:19:56 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:50064 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731807AbfHFHTz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Aug 2019 03:19:55 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 5210B2E129D;
        Tue,  6 Aug 2019 10:19:52 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:10])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id kYXKZpPAQ1-JqZiG3nU;
        Tue, 06 Aug 2019 10:19:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1565075992; bh=N6mFKzcJuhbgMksEZaXjMK9Sa+aXVEkZHt/RWDgwRic=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=qj1+3eKYycJsRWYRyESXh/le9T+uXhFB29JZh8tHuGVXVY4TzJH31MfvV4dDd3p3D
         5j+amf4w55mGNYaE/HxSlnsaBt7smrFwVUAi4JQnakvs/XAP5VyloJFo3MqiiLQ9zS
         ItceemZk1AVrWepJltjbLkwA8naBgpG1rtuSRmSk=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:81f7:1ca8:6615:d682])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id J4Zd7BQsFS-JpkCvNW7;
        Tue, 06 Aug 2019 10:19:52 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729154952.GC21958@cmpxchg.org> <20190729185509.GI9330@dhcp22.suse.cz>
 <20190802094028.GG6461@dhcp22.suse.cz>
 <105a2f1f-de5c-7bac-3aa5-87bd1dbcaed9@yandex-team.ru>
 <20190802114438.GH6461@dhcp22.suse.cz>
 <20190806070728.GB11812@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <c6b2c864-985a-2565-95e7-3af9e3e015f8@yandex-team.ru>
Date:   Tue, 6 Aug 2019 10:19:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190806070728.GB11812@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 8/6/19 10:07 AM, Michal Hocko wrote:
> On Fri 02-08-19 13:44:38, Michal Hocko wrote:
> [...]
>>>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>>>> index ba9138a4a1de..53a35c526e43 100644
>>>> --- a/mm/memcontrol.c
>>>> +++ b/mm/memcontrol.c
>>>> @@ -2429,8 +2429,12 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>>>>    				schedule_work(&memcg->high_work);
>>>>    				break;
>>>>    			}
>>>> -			current->memcg_nr_pages_over_high += batch;
>>>> -			set_notify_resume(current);
>>>> +			if (gfpflags_allow_blocking(gfp_mask)) {
>>>> +				reclaim_high(memcg, nr_pages, GFP_KERNEL);
>>
>> ups, this should be s@GFP_KERNEL@gfp_mask@
>>
>>>> +			} else {
>>>> +				current->memcg_nr_pages_over_high += batch;
>>>> +				set_notify_resume(current);
>>>> +			}
>>>>    			break;
>>>>    		}
>>>>    	} while ((memcg = parent_mem_cgroup(memcg)));
>>>>
> 
> Should I send an official patch for this?
> 

I prefer to keep it as is while we have no better solution.
