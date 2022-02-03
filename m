Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423B64A8BDD
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 19:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353558AbiBCStN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Feb 2022 13:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230376AbiBCStN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Feb 2022 13:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643914152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xvwI014RI3T9gp2AWaO1azWgkMohE5MRNXNJ2U28y3Q=;
        b=CGwYX2/ytROtX0a4EVA7ZzbZ/H0TVDn2l8l+6e6eWp6VvHvhSlfD+6fZTiE8LSU56PLCXs
        Jh6bLs0cNRXZS3JD3S81CkWx5MTzs4p1TfMr4atA4lQ93H1knhNS5g+fLLRp9+DAyBdJW9
        6ls4IOzNC3D6e63JxfyoRhBNLBwDWNA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-TvIIpLhHMeCEUxZNTdvVjw-1; Thu, 03 Feb 2022 13:49:09 -0500
X-MC-Unique: TvIIpLhHMeCEUxZNTdvVjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B78531091DA2;
        Thu,  3 Feb 2022 18:49:05 +0000 (UTC)
Received: from [10.22.8.80] (unknown [10.22.8.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB2844CED8;
        Thu,  3 Feb 2022 18:49:02 +0000 (UTC)
Message-ID: <42cca916-d4c8-daa1-4a91-60738c499c89@redhat.com>
Date:   Thu, 3 Feb 2022 13:49:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v4 2/4] mm/page_owner: Use scnprintf() to avoid excessive
 buffer overrun check
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-3-longman@redhat.com>
 <5c03fa31-35a5-4cbc-6b0e-872d5db82a41@suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <5c03fa31-35a5-4cbc-6b0e-872d5db82a41@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/3/22 10:46, Vlastimil Babka wrote:
> On 2/2/22 21:30, Waiman Long wrote:
>> The snprintf() function can return a length greater than the given
>> input size. That will require a check for buffer overrun after each
>> invocation of snprintf(). scnprintf(), on the other hand, will never
>> return a greater length. By using scnprintf() in selected places, we
>> can avoid some buffer overrun checks except after stack_depot_snprint()
>> and after the last snprintf().
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Acked-by: David Rientjes <rientjes@google.com>
>> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Looks like this will work, but note that if the purpose of patch 1/4 was
> that after the first scnprintf() that overflows the following calls will be
> short-cut thanks to passing the size as 0, AFAICS that won't work. Because
> scnprintf() returns the number without trailing zero, 'ret' will be 'count -
> 1' after the overflow, so 'count - ret' will be 1, never 0.

Yes, I am aware of that. Patch 1 is just a micro-optimization for the 
very rare case.

Cheers,
Longman


