Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8840AB50
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 12:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhINKDE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 06:03:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:59470 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhINKDC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 14 Sep 2021 06:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=ImRIPihhAObidTCiJqcnR+Z8IfwFSS7GltQDYdsx+N8=; b=s9EIcM218cXLgAcVF
        x2igWWw+5J2ksbdHAJ76DZGcs4PAzMOI4aqrBzYOgTroR3W22sFgMdz6nr8qWJSgZEgjefXl12Zfz
        5Rzt4hTINk5F9djLHnQdmuhAnpSxGuDgQmwNgTfiMHgIIord/XMaxAN3OiEGHEcr2V+NjawPY02l0
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mQ5G0-001w0o-Uf; Tue, 14 Sep 2021 13:01:40 +0300
Subject: Re: [PATCH memcg] memcg: prohibit unconditional exceeding the limit
 of dying tasks
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <5b06a490-55bc-a6a0-6c85-690254f86fad@virtuozzo.com>
 <YT8RjxShvfEVe4YU@dhcp22.suse.cz>
 <7af26106-388c-6f99-e018-669a8f0cf9b5@virtuozzo.com>
 <YT8uGUMQ7K+/0gyA@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <bab6c1d2-38d8-9098-206f-54894f9871b6@virtuozzo.com>
Date:   Tue, 14 Sep 2021 13:01:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YT8uGUMQ7K+/0gyA@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/13/21 1:55 PM, Michal Hocko wrote:
> Here is what I would do.

Your patch fixes the problem, I just want to add rename of should_force_charge()
helper to task_is_dying() and will submit v2 version soon.

I think this patch is not optimal, however its improvements can be discussed later.

Thank you,
	Vasily Averin
