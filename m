Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9DE788A1
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 11:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfG2Jkf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 05:40:35 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:42694 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbfG2Jkf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 Jul 2019 05:40:35 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 8E7312E095E;
        Mon, 29 Jul 2019 12:40:31 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id U8DF8V3uZd-eVNCsmIB;
        Mon, 29 Jul 2019 12:40:31 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1564393231; bh=7/tBJ4/qqqj7+TYSG8WJ1dkQnz6GbGSbSQMPTnlbeZw=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=LUvQwL/QlD6Pg9qp202MGi9db0D1vc9D2+yRRANkR7RNSkFzvu6mMu9rnOq3s/Z7g
         9LobH066Mj6J048YjrUosIn/5LmhCs5N3ausLHyF+VaQpKLpjS4ngZ1UJ3lPHqZRbl
         MkWJ2c9sBwf1N7xBB6VRESXglZ55Hw81Vcb+43Zo=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:6454:ac35:2758:ad6a])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 9QqUdtKSm2-eUAaJpRd;
        Mon, 29 Jul 2019 12:40:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
 <20190729091738.GF9330@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <3d6fc779-2081-ba4b-22cf-be701d617bb4@yandex-team.ru>
Date:   Mon, 29 Jul 2019 12:40:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729091738.GF9330@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 29.07.2019 12:17, Michal Hocko wrote:
> On Sun 28-07-19 15:29:38, Konstantin Khlebnikov wrote:
>> High memory limit in memory cgroup allows to batch memory reclaiming and
>> defer it until returning into userland. This moves it out of any locks.
>>
>> Fixed gap between high and max limit works pretty well (we are using
>> 64 * NR_CPUS pages) except cases when one syscall allocates tons of
>> memory. This affects all other tasks in cgroup because they might hit
>> max memory limit in unhandy places and\or under hot locks.
>>
>> For example mmap with MAP_POPULATE or MAP_LOCKED might allocate a lot
>> of pages and push memory cgroup usage far ahead high memory limit.
>>
>> This patch uses halfway between high and max limits as threshold and
>> in this case starts memory reclaiming if mem_cgroup_handle_over_high()
>> called with argument only_severe = true, otherwise reclaim is deferred
>> till returning into userland. If high limits isn't set nothing changes.
>>
>> Now long running get_user_pages will periodically reclaim cgroup memory.
>> Other possible targets are generic file read/write iter loops.
> 
> I do see how gup can lead to a large high limit excess, but could you be
> more specific why is that a problem? We should be reclaiming the similar
> number of pages cumulatively.
> 

Large gup might push usage close to limit and keep it here for a some time.
As a result concurrent allocations will enter direct reclaim right at
charging much more frequently.


Right now deferred recalaim after passing high limit works like distributed
memcg kswapd which reclaims memory in "background" and prevents completely
synchronous direct reclaim.

Maybe somebody have any plans for real kswapd for memcg?


I've put mem_cgroup_handle_over_high in gup next to cond_resched() and
later that gave me idea that this is good place for running any
deferred works, like bottom half for tasks. Right now this happens
only at switching into userspace.
