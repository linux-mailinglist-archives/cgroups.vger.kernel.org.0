Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE361368205
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhDVN7q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 09:59:46 -0400
Received: from relay.sw.ru ([185.231.240.75]:54390 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236254AbhDVN7p (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 22 Apr 2021 09:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:From:
        Subject; bh=RJzqymK4KdLIflkHg7fNUFw31wIE7fLJRZ1fSy+vabc=; b=N8B30dAs7aOqNLVdf
        Pa0srpVl2C/DUZIitS8DKW0kYyfVEDKhbVoZUwnyMgTE6eqTAucI0+gS+PYci9Bt8ed2mRP6H7RDN
        mIzWS40A9nXNBXchcDS2WdywUiQLu4jFtZgs2aCnkUUhnDABY/ChQ338ZFkUxDGG4aWO56rQ9uzl8
        =;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94)
        (envelope-from <vvs@virtuozzo.com>)
        id 1lZZrC-001BRM-2Y; Thu, 22 Apr 2021 16:59:02 +0300
Subject: Re: [PATCH v3 15/16] memcg: enable accounting for tty-related objects
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Jiri Slaby <jirislaby@kernel.org>
References: <dddf6b29-debd-dcb5-62d0-74909d610edb@virtuozzo.com>
 <da450388-2fbc-1bb8-0839-b6480cb0eead@virtuozzo.com>
 <YIFcqcd4dCiNcILj@kroah.com> <YIFhuwlXKaAaY3IU@dhcp22.suse.cz>
 <YIFjI3zHVQr4BjHc@kroah.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <6e697a1f-936d-5ffe-d29f-e4dcbe099799@virtuozzo.com>
Date:   Thu, 22 Apr 2021 16:59:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YIFjI3zHVQr4BjHc@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/22/21 2:50 PM, Greg Kroah-Hartman wrote:
> On Thu, Apr 22, 2021 at 01:44:59PM +0200, Michal Hocko wrote:
>> On Thu 22-04-21 13:23:21, Greg KH wrote:
>>> On Thu, Apr 22, 2021 at 01:37:53PM +0300, Vasily Averin wrote:
>>>> At each login the user forces the kernel to create a new terminal and
>>>> allocate up to ~1Kb memory for the tty-related structures.
>>>
>>> Does this tiny amount of memory actually matter?
>>
>> The primary question is whether an untrusted user can trigger an
>> unbounded amount of these allocations.
> 
> Can they?  They are not bounded by some other resource limit?

I'm not ready to provide usecase right now,
but on the other hand I do not see any related limits.
Let me take time out to dig this question.

Thank you,
	Vasily Averin
