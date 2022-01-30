Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370A4A3992
	for <lists+cgroups@lfdr.de>; Sun, 30 Jan 2022 21:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347711AbiA3U52 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jan 2022 15:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbiA3U51 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jan 2022 15:57:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643576246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CYWsjFfFSt2RF45PXlVv4n8PSHaq7o1llJS6PLtLhlI=;
        b=ZcCYjN0VICs6GHKyc43gECTd7sSHjxqa2m5QQTZ3R6WRl+/c4NhjCHaPpaid5wLB1l492R
        oINShXGWa3IKGUSWmCsrKDxRBOs6my5z80KQzwKRc9W/Hey/63K8n85lkBLsZMmT7MG08x
        VHzlBOZV3yfP98EkFRBHVa2YIzeXrkE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-YyS5BFIUMLe47zlp5ij9Jw-1; Sun, 30 Jan 2022 15:57:23 -0500
X-MC-Unique: YyS5BFIUMLe47zlp5ij9Jw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D37BE814245;
        Sun, 30 Jan 2022 20:57:20 +0000 (UTC)
Received: from [10.22.16.114] (unknown [10.22.16.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7BD4B56F6F;
        Sun, 30 Jan 2022 20:57:15 +0000 (UTC)
Message-ID: <53f74ef1-e097-ea2a-84ef-2d34367e60eb@redhat.com>
Date:   Sun, 30 Jan 2022 15:57:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
 <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/30/22 15:49, David Rientjes wrote:
> On Sat, 29 Jan 2022, Waiman Long wrote:
>
>> For *scnprintf(), vsnprintf() is always called even if the input size is
>> 0. That is a waste of time, so just return 0 in this case.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   lib/vsprintf.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
>> index 3b8129dd374c..a65df546fb06 100644
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -2895,13 +2895,15 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
>>   {
>>   	int i;
>>   
>> +	if (!size)
>> +		return 0;
> Nit: any reason this shouldn't be unlikely()?  If the conditional for
> i < size is likely(), this seems assumed already?

Good suggestion. Will make the change in the next version.

Cheers,
Longman

