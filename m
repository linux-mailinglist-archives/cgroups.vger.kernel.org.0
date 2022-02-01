Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894EF4A60EC
	for <lists+cgroups@lfdr.de>; Tue,  1 Feb 2022 17:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240769AbiBAQCa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Feb 2022 11:02:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235398AbiBAQCa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Feb 2022 11:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643731349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0lOsjYnjuXJjkQQPkdLRQ4+5wRRHj/4IS9YqFDRMAvI=;
        b=Jw3E49V/j4fkG+DDj3JcaDr2A8lPGKvcAVLj4fDbXsW7xycaMHDmaakfis8MM9BGYM4OEF
        lUkqdRZY7IT5hWwAkxd5FNNPFufOnVNYWGYy7piY7YfMgcIHE0xqCg9r5NiAFDNJBaV2jM
        90K7jMrhN9cbp06zYZyaS4NkL9RUON4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-WqDDEl3dPKOc7sq2HX2xEg-1; Tue, 01 Feb 2022 11:02:27 -0500
X-MC-Unique: WqDDEl3dPKOc7sq2HX2xEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A3211966320;
        Tue,  1 Feb 2022 16:02:14 +0000 (UTC)
Received: from [10.22.19.61] (unknown [10.22.19.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00CF772FA2;
        Tue,  1 Feb 2022 16:01:51 +0000 (UTC)
Message-ID: <a4a3366e-1e7b-7d2b-5e05-46a308d09978@redhat.com>
Date:   Tue, 1 Feb 2022 11:01:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
 <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
 <Yfe5Bb3U6Uil7Y6g@smile.fi.intel.com> <Yfe6SfG4CqzWSaMM@smile.fi.intel.com>
 <Yfe7Q5cx+MoaOev/@smile.fi.intel.com>
 <c33b6435-1b27-32af-b14c-0f3a0318dcca@redhat.com>
 <f3bcf541-e77b-ca93-ef5c-862f4de99366@rasmusvillemoes.dk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <f3bcf541-e77b-ca93-ef5c-862f4de99366@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/1/22 02:12, Rasmus Villemoes wrote:
> On 31/01/2022 19.48, Waiman Long wrote:
>> On 1/31/22 05:34, Andy Shevchenko wrote:
>>> Also it seems currently the kernel documentation is not aligned with
>>> the code
>>>
>>>     "If @size is == 0 the function returns 0."
>>>
>>> It should mention the (theoretical?) possibility of getting negative
>>> value,
>>> if vsnprintf() returns negative value.
>> AFAICS, the kernel's vsnprintf() function will not return -1.
> Even if it did, the "i < size" comparison in vscnprintf() is "int v
> size_t", so integer promotion says that even if i were negative, that
> comparison would be false, so we wouldn't forward that negative value
> anyway.
>
>> So in that
>> sense it is not fully POSIX compliant.
> Of course it's not, but not because it doesn't return -1. POSIX just
> says to return that in case of an error, and as a matter of QoI, the
> kernel's implementation simply can't (and must not) fail. There are
> other cases where we don't follow POSIX/C, e.g. in some corner cases
> around field length and precision (documented in test_printf.c), and the
> non-support of %n (and floating point and handling of wchar_t*), and the
> whole %p<> extension etc.
>
> Rasmus
>
Thanks for the clarification.

Cheers,
Longman

