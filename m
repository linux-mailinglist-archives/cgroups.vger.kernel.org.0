Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB3A4A51D1
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 22:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381161AbiAaVqi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 16:46:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376935AbiAaVqg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 16:46:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643665595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrfhAK5TTZj4g7edUXER7YgS33zywQPgQldaDuFqoqY=;
        b=ZAGbKnlUlBMiMpP3I7jUE6wJcxEpMjyry8jISD82Am/HXbWtjzs+StBXfIvt3l862EMjqc
        Uabvfq0bjH3LYb+6o0ute7xbrSQ7QDs+spZb8mWh7HmDMybTGGQ8bXozeeo9Tw2bP/Ht9c
        x72RFBYbp7A6nFEmdjTKGTFL+PotdKg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-Gq8PbYdIPL29PDftlnn-kA-1; Mon, 31 Jan 2022 16:46:32 -0500
X-MC-Unique: Gq8PbYdIPL29PDftlnn-kA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D63C2190B2A0;
        Mon, 31 Jan 2022 21:46:29 +0000 (UTC)
Received: from [10.22.16.244] (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D44F16AB95;
        Mon, 31 Jan 2022 21:46:27 +0000 (UTC)
Message-ID: <12f62103-d0e9-3010-4c7b-7b80f086734d@redhat.com>
Date:   Mon, 31 Jan 2022 16:46:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 4/4] mm/page_owner: Record task command name
Content-Language: en-US
To:     Roman Gushchin <guro@fb.com>
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
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-5-longman@redhat.com>
 <YfhMd5LTzTHu9zMD@carbon.dhcp.thefacebook.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YfhMd5LTzTHu9zMD@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/22 15:54, Roman Gushchin wrote:
> On Mon, Jan 31, 2022 at 02:23:08PM -0500, Waiman Long wrote:
>> The page_owner information currently includes the pid of the calling
>> task. That is useful as long as the task is still running. Otherwise,
>> the number is meaningless. To have more information about the allocating
>> tasks that had exited by the time the page_owner information is
>> retrieved, we need to store the command name of the task.
>>
>> Add a new comm field into page_owner structure to store the command name
>> and display it when the page_owner information is retrieved. Only the
>> first 15 characters of the command name will be copied, but that should
>> be enough in most cases. Even for those commands with longer names,
>> it shouldn't be hard to guess what they are.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/page_owner.c | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index a471c74c7fe0..8b2b381fd986 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -20,6 +20,7 @@
>>    * to use off stack temporal storage
>>    */
>>   #define PAGE_OWNER_STACK_DEPTH (16)
>> +#define PAGE_OWNER_COMM_LEN	16
> Not sure I understand why not simply use TASK_COMM_LEN ?

Yes, you are right. I thought TASK_COMM_LEN is larger than 16 without 
actually checking it. Will fix that.

Cheers,
Longman

