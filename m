Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD54066AD
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 07:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhIJFWg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 01:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhIJFWf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 01:22:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C80C061574;
        Thu,  9 Sep 2021 22:21:25 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso653515pjb.3;
        Thu, 09 Sep 2021 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BLhN9TB7Ol57sQQenKldl3mBRnGfktBhdGML7tJA3Ww=;
        b=hktGUARwAQCs/rrNssjoUdMQwzYznSPdwPBEc22JFRemiMjqWDYzC+dzoeKKnhYkVR
         T1b9xEKSF9jGM3t4ejhzDcAaOuGihnjoM9wLUIwdzf6I5vcf9wB0X50i3Gb5YBshLTWc
         3sTMapg+S1zz4st1unMb/cCOtt9BhQZrX/Bf8xUH/lTpNzBqpRF9fbSgYBO27yA2QBRK
         yJUoMwX+D+ewzlDCf/az0x2t/2YAi4ZQlePOx7sTheh6r5kQs8nw9NK8aU1cNzQ0X6ub
         iXVl4yiUgKfBdndy432DD6n6kFiQjT+nsjoFj4Wfro0AVRddDjIAZl1OBvQTR6FZMYvC
         5HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BLhN9TB7Ol57sQQenKldl3mBRnGfktBhdGML7tJA3Ww=;
        b=D791Mab4RPEMUuFl1mvD23Qjw/V5Z9XKVXn48/cm8LmUX55dhKk/7tzjhby8tnACPE
         fndymAyGr+p4ghofzmff/IKQ0NRkTtCTWhnza8DWj4Cl57BKpm3nzNsOIttH8NjULq8K
         K6EFU+BIHW+ghwwOQ2XwYvdAYtPDGUfb9JZWIxfJ03oGLowiOyUwMgiYRlbmR7JEnrJO
         vyTHD8q7t7FkyOwBEYnCvQrtz094UDsdulRsR/+vFTCD13I6YDFSBN9PNTY4UBio90tH
         aVfAdTijjehWgMNrcAPuYNM2R6MaBYvPpZ6McYIaLcs79J+nPpdqtXpCjqAP32smPYdG
         uf8Q==
X-Gm-Message-State: AOAM530L2B+YxzlEGB8PLk+x3kkF+eRpZ92exjblaBpQutGYPGGpKrOB
        fAY+2INSb/gTrJ6nEPNPtfnO2e3FpGo=
X-Google-Smtp-Source: ABdhPJyQwCSO91i/7kvr+Bkf6L8vPK8Vbqb3wbRbzOsMX8n6govWgfHh2SKdWsWxhH8M0s5w5O61GQ==
X-Received: by 2002:a17:90a:b881:: with SMTP id o1mr7485690pjr.141.1631251284688;
        Thu, 09 Sep 2021 22:21:24 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id m18sm3866631pjq.32.2021.09.09.22.21.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 22:21:24 -0700 (PDT)
Subject: Re: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and
 misc_events.local
To:     Vipin Sharma <vipinsh@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <20210909143702.GA13761@blackbody.suse.cz>
 <CAHVum0eGN=v1kLqHQg7HBESp8Kg4aGZFNd4XTpxfeyToXPmPVg@mail.gmail.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <8259b666-f3a4-6788-880c-38d679414bcb@gmail.com>
Date:   Fri, 10 Sep 2021 13:20:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHVum0eGN=v1kLqHQg7HBESp8Kg4aGZFNd4XTpxfeyToXPmPVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Vipin Sharma wrote on 2021/9/10 1:08 上午:
> On Thu, Sep 9, 2021 at 7:37 AM Michal Koutný <mkoutny@suse.com> wrote:
>>
>> Hello Chunguang.
>>
>> The new version looks like a good step generally.
>>
>> My main remark is that I wouldn't make a distinct v1 and v2 interface,
>> it's a new controller so I think the v2 could be exposed in both cases
>> (or in other words, don't create new v1-specific features).
> 
> I agree with Michal. We can have the same interface for v1 otherwise
> there will not be any form of feedback in v1 for failures.

Yeah, this is more reasonable. But there is still one question, whether we
need to be consistent with other cgroup subsystems, events and events.local
under v1 should not support hierarchy？

>>
>> On Wed, Sep 08, 2021 at 01:24:34PM +0800, brookxu <brookxu.cn@gmail.com> wrote:
>>> +static int misc_events_show(struct seq_file *sf, void *v)
>>> +{
>>> +     struct misc_cg *cg = css_misc(seq_css(sf));
>>> +     unsigned long count, i;
>>> +
>>> +     for (i = 0; i < MISC_CG_RES_TYPES; i++) {
>>> +             count = atomic_long_read(&cg->events[i]);
>>> +             if (READ_ONCE(misc_res_capacity[i]) || count)
>>> +                     seq_printf(sf, "%s %lu\n", misc_res_name[i], count);
>>
>> More future-proof key would be
>>                         seq_printf(sf, "%s.max %lu\n", misc_res_name[i], count);
>> or
>>                         seq_printf(sf, "max.%s %lu\n", misc_res_name[i], count);
>>
>> (Which one is a judgement call but I'd include the "name" of event type too.)
>>
> I am inclined more towards "%s.max", it looks nice to see the resource
> name before its corresponding events

I also think %s.max may be more intuitive.
