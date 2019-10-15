Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA47D77F0
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 16:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbfJOOEt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 10:04:49 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:45050 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728880AbfJOOEs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Oct 2019 10:04:48 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 93D7C2E150F;
        Tue, 15 Oct 2019 17:04:45 +0300 (MSK)
Received: from myt5-6212ef07a9ec.qloud-c.yandex.net (myt5-6212ef07a9ec.qloud-c.yandex.net [2a02:6b8:c12:3b2d:0:640:6212:ef07])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id TQ8yEn6Bxb-4iOilYj0;
        Tue, 15 Oct 2019 17:04:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571148285; bh=gapCxVyFjCKK96iTj5+/HTSHg4pVE+p4wO6AeL1O5js=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=iexJ4OXOHRyfvZOijhnDLG/OTy9p46fATNnCRuDS3uURs4zONzQOCug4kegm8PrUp
         r7YEtJsOfu0s8iXkRLCF4KwchV8t6Db1ylKADx0+jrNc/0CO6Pt0LvfyXyw82hKy5R
         vhqiRKrwvDQqEd2HUE6UbUXWLI2/HLIwQLMBxmbQ=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7005::1:13])
        by myt5-6212ef07a9ec.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id KzKUEhJ4eP-4iGWHmeE;
        Tue, 15 Oct 2019 17:04:44 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
 <20191015135348.GA139269@cmpxchg.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <89171a94-8b6f-e949-0078-10fa8fd26dfc@yandex-team.ru>
Date:   Tue, 15 Oct 2019 17:04:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191015135348.GA139269@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 15/10/2019 16.53, Johannes Weiner wrote:
> On Tue, Oct 15, 2019 at 11:09:59AM +0300, Konstantin Khlebnikov wrote:
>> Mapped, dirty and writeback pages are also counted in per-lruvec stats.
>> These counters needs update when page is moved between cgroups.
>>
>> Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Please mention in the changelog that currently is nobody *consuming*
> the lruvec versions of these counters and that there is no
> user-visible effect. Thanks
> 

Maybe just kill all these per-lruvec counters?
I see only one user which have no alternative data source: WORKINGSET_ACTIVATE.

This will save some memory: 32 * sizeof(long) * nr_nodes * nr_cpus bytes
