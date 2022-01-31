Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854784A418F
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 12:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359224AbiAaLEp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 06:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358812AbiAaLDb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 06:03:31 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D3BC0617BB
        for <cgroups@vger.kernel.org>; Mon, 31 Jan 2022 03:02:32 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x23so26150756lfc.0
        for <cgroups@vger.kernel.org>; Mon, 31 Jan 2022 03:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=czeOm2pkfIYtlH8bieE/wFkWMyQace30JcDwxXQeWDY=;
        b=NAM+paj077GlbsSEbAhREf9Ku6Zelpm258xyJs/uNE2AuRvKnCy48gfwZAgwyslTFR
         m3FwDtohPmEJwRAkIVNJawuANbhmN7JaxgRofyQ/AdWTlQb60iLuWwhb63Vy8Kso+QP0
         7e2+p6p/6JWa/AfN5eIUs1nzVxb1IJYuYjzQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czeOm2pkfIYtlH8bieE/wFkWMyQace30JcDwxXQeWDY=;
        b=6k2hlSSqSiKOpOE9KMEP9rWmz2IcbD4VqGLDG7k1SAJWOqlyJuCc2KjQqBcvWfECdY
         4nQo3LN5Po7cj9dmPJjBcwxwicXLbQGbmuqkLvx55eOicHDPENL4XN6vOs/lbmMg/TCj
         0awunAcv+TLgdHl+7KAciI+cnLzqDorFgu56Bct1f8ZsfCL+/Ady8QnIPx7LpkQ+GW+/
         A464BBC7KnC4ulVNzvX88q7j/ds8EP/0iBLRk5xTmrg4mZUsdrwrfGwpeJkeNseHn1/m
         JBhOUPW46DawKMckVj/DOOaw64mIEmf3rXxBdj3hY18fHYzz/et6TXWcC+SABSgQuIq/
         4t/A==
X-Gm-Message-State: AOAM533klxCmaSMQWzfg5/bysM2o2+4Xf0p375yXITKT7m26MsHjM6aq
        01M7I6YY3ZoJkdpmj8pt7m5ybg==
X-Google-Smtp-Source: ABdhPJz1ok/mMVMmC6806RcAq8MH2XjtwH5h47J/+uzZ8Kh+q34vMsAK2Yo0+uhGrtutG1qy+aMGMg==
X-Received: by 2002:a05:6512:12c5:: with SMTP id p5mr16013020lfg.89.1643626951003;
        Mon, 31 Jan 2022 03:02:31 -0800 (PST)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id g7sm1962543ljk.83.2022.01.31.03.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 03:02:30 -0800 (PST)
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Rientjes <rientjes@google.com>
Cc:     Waiman Long <longman@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <d44824d4-2dd1-a8ab-d3ee-ac67b749ca6f@rasmusvillemoes.dk>
Date:   Mon, 31 Jan 2022 12:02:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yfe7Q5cx+MoaOev/@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 31/01/2022 11.34, Andy Shevchenko wrote:
> On Mon, Jan 31, 2022 at 12:30:33PM +0200, Andy Shevchenko wrote:
>> On Mon, Jan 31, 2022 at 12:25:09PM +0200, Andy Shevchenko wrote:
>>> On Sun, Jan 30, 2022 at 12:49:37PM -0800, David Rientjes wrote:
>>>> On Sat, 29 Jan 2022, Waiman Long wrote:
>>>>
>>>>> For *scnprintf(), vsnprintf() is always called even if the input size is
>>>>> 0. That is a waste of time, so just return 0 in this case.
>>>
>>> Why do you think it's not legit?
>>
>> I have to elaborate.
>>
>> For *nprintf() the size=0 is quite useful to have.
>> For *cnprintf() the size=0 makes less sense, but, if we read `man snprintf()`:
>>
>>   The  functions  snprintf() and vsnprintf() do not write more than size bytes
>>   (including the terminating null byte ('\0')). If the output was truncated due
>>   to this limit, then the return value is the  number of  characters (excluding
>>   the terminating null byte) which would have been written to the final string
>>   if enough space had been available. Thus, a return value of size or more
>>   means  that  the  output  was truncated.  (See also below under NOTES.)
>>
>>   If an output error is encountered, a negative value is returned.
>>
>> Note the last sentence there. You need to answer to it in the commit message
>> why your change is okay and it will show that you thought through all possible
>> scenarios.
> 
> Also it seems currently the kernel documentation is not aligned with the code
> 
>   "If @size is == 0 the function returns 0."
> 
> It should mention the (theoretical?) possibility of getting negative value,
> if vsnprintf() returns negative value.
> 

The kernel's vsnprintf _will never_ return a negative value. There is
way too much code which relies on that. It also has to work from any
context, so we'll never do any memory allocation or anything else that
could possibly force us to error out, and even if we encounter some
impossible situation, we do not return a negative value, but just stop
the output where we are.

So yes, micro-optimizing [v]scnprintf() is completely valid, but I've
never bothered to send the patch because the use case for scnprintf() is
primarily the

  ret += scnprintf(buf + ret, size - ret, ...);

pattern, with ret starting out at 0 and size being some non-zero number.
When given a non-zero size, scnprintf() is guaranteed to return
something _strictly less_ than that value; that invariant guarantees
that the size-ret expression never becomes 0. So if scnprintf() is
properly used, I can't think of any situation where size will be 0,
hence I see that patch as correct-but-mostly-pointless.

Rasmus
