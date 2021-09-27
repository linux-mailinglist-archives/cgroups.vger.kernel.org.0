Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31D419196
	for <lists+cgroups@lfdr.de>; Mon, 27 Sep 2021 11:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhI0Jh7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Sep 2021 05:37:59 -0400
Received: from relay.sw.ru ([185.231.240.75]:54652 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233587AbhI0Jh6 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 27 Sep 2021 05:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=UuF6FHs19BNorLrl2iJ5nlzRqI12m41442Ub5BwC1yY=; b=cLaqobgNClIHOqPlH
        4PvwKYnD6rUCdvka5AQkv2s1rFASROYIi0XMbECngjIx9Cdm9lUzuqO/DpoDma1WyY+fZO27ZPZCz
        yVMT5tKlP4GG049tOkT8nVxdakIoLjMIA4pjZZ1d+/PtrSfIjlruZdsBA9KuVUT0pB6QMF8a5RhM4
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mUn3Y-003bZI-4A; Mon, 27 Sep 2021 12:36:16 +0300
Subject: Re: [PATCH mm] vmalloc: back off when the current task is OOM-killed
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@openvz.org
References: <YT8PEBbYZhLixEJD@dhcp22.suse.cz>
 <d07a5540-3e07-44ba-1e59-067500f024d9@virtuozzo.com>
 <YUsg4j8gEt+WOCzi@dhcp22.suse.cz>
 <fa29c6f9-a53c-83bd-adcb-1e09d4387024@virtuozzo.com>
 <YU2EXP5wrSKv+b/8@dhcp22.suse.cz>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <508abe37-a044-7180-ac67-b4ce5e4cc149@virtuozzo.com>
Date:   Mon, 27 Sep 2021 12:36:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YU2EXP5wrSKv+b/8@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/24/21 10:55 AM, Michal Hocko wrote:
> On Thu 23-09-21 09:49:57, Vasily Averin wrote:
> [...]
>> I'm agree that vmalloc callers should expect and handle single vnalloc failures.
>> I think it is acceptable to enable fatal_signal_pending check to quickly
>> detect such kind of iussues.
>> However fatal_signal_pending check can cause serial vmalloc failures
>> and I doubt it is acceptable. 
>>
>> Rollback after failed vmalloc can call new vmalloc calls that will be failed too, 
>> even properly handled such serial failures can cause troubles.
> 
> Could you be more specific? Also how would this be any different from
> similar failures for an oom victim? Except that the later is less likely
> so (as already mentioend) any potential bugs would be just lurking there
> for a longer time.
> 
>> Hypothetically, cancelled vmalloc called inside some filesystem's transaction
>> forces its rollback, that in own turn it can call own vmalloc.
> 
> Do you have any specific example?

No, it was pure hypothetical assumption.
I was thinking about it over the weekend, and decided that:
a) such kind of issue (i.e. vmalloc call in rollback after failed vmalloc)
   is very unlikely
b) if it still exists -- it must have own failback with kmalloc(NOFAIL) 
   or just accept/ignore such failure and should not lead to critical failures.
   If this still happen -- ihis is a bug, we should detect and fix it ASAP.

>> Should we perhaps interrupt the first vmalloc only?
> 
> This doesn't make much sense to me TBH. It doesn't address the very
> problem you are describing in the changelog.

Last question:
how do you think, should we perhaps, instead, detect such vmallocs 
(called in rollback after failed vmalloc) and generate a warnings,
to prevent such kind of problems in future?

Thank you,
	Vasily Averin
