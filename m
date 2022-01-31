Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C380B4A4EDA
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 19:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358038AbiAaSsY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 13:48:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358290AbiAaSsT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 13:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643654898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfQFfvwTGn23fXKYlknOZjlgILY6kYRW26SfIwpEJJM=;
        b=HKNyrpQa598Ejmi7D9BN6TnVcyRStku6wt7yQ1gZaqhWXPZHFKfCgwrrZenPiipysWdYo2
        KLzIAmy25avmprcxQZ2KgIK4DcKYFWdDuPVKRmNBfY5qYvdZolXOfhFBDHrfJGbDU62BSU
        peapwoxB8eblWWqhICPiXNi2uMpUUCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-y95AX1aoM06TnU-mvZxpgg-1; Mon, 31 Jan 2022 13:48:15 -0500
X-MC-Unique: y95AX1aoM06TnU-mvZxpgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 566D81966320;
        Mon, 31 Jan 2022 18:48:13 +0000 (UTC)
Received: from [10.22.16.244] (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8C977A424;
        Mon, 31 Jan 2022 18:48:11 +0000 (UTC)
Message-ID: <c33b6435-1b27-32af-b14c-0f3a0318dcca@redhat.com>
Date:   Mon, 31 Jan 2022 13:48:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
 <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
 <Yfe5Bb3U6Uil7Y6g@smile.fi.intel.com> <Yfe6SfG4CqzWSaMM@smile.fi.intel.com>
 <Yfe7Q5cx+MoaOev/@smile.fi.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yfe7Q5cx+MoaOev/@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/22 05:34, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 12:30:33PM +0200, Andy Shevchenko wrote:
>> On Mon, Jan 31, 2022 at 12:25:09PM +0200, Andy Shevchenko wrote:
>>> On Sun, Jan 30, 2022 at 12:49:37PM -0800, David Rientjes wrote:
>>>> On Sat, 29 Jan 2022, Waiman Long wrote:
>>>>
>>>>> For *scnprintf(), vsnprintf() is always called even if the input size is
>>>>> 0. That is a waste of time, so just return 0 in this case.
>>> Why do you think it's not legit?
>> I have to elaborate.
>>
>> For *nprintf() the size=0 is quite useful to have.
>> For *cnprintf() the size=0 makes less sense, but, if we read `man snprintf()`:
>>
>>    The  functions  snprintf() and vsnprintf() do not write more than size bytes
>>    (including the terminating null byte ('\0')). If the output was truncated due
>>    to this limit, then the return value is the  number of  characters (excluding
>>    the terminating null byte) which would have been written to the final string
>>    if enough space had been available. Thus, a return value of size or more
>>    means  that  the  output  was truncated.  (See also below under NOTES.)
>>
>>    If an output error is encountered, a negative value is returned.
>>
>> Note the last sentence there. You need to answer to it in the commit message
>> why your change is okay and it will show that you thought through all possible
>> scenarios.
> Also it seems currently the kernel documentation is not aligned with the code
>
>    "If @size is == 0 the function returns 0."
>
> It should mention the (theoretical?) possibility of getting negative value,
> if vsnprintf() returns negative value.

AFAICS, the kernel's vsnprintf() function will not return -1. So in that 
sense it is not fully POSIX compliant. Since vscnprintf() function 
always returns 0 when size is 0, there is no point in finding out 
exactly how much bytes the buffer needs to hold the formatted text as 
this information will not be returned back to the caller anyway. I will 
update to indicate the vsnprintf() does not return -1.

Thanks,
Longmn

