Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026F13DCE89
	for <lists+cgroups@lfdr.de>; Mon,  2 Aug 2021 03:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhHBBav (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 1 Aug 2021 21:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhHBBau (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 1 Aug 2021 21:30:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891FC06175F;
        Sun,  1 Aug 2021 18:30:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so3436240pjs.0;
        Sun, 01 Aug 2021 18:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u4+MOjnojz3+/+7/XlAa+2lsmVmxt23PCyNNCzzoHqU=;
        b=PZvnds9W8ZafmGzDHBzMjB7paCr1nbUI3ppOFf7WVrfZB20/0F/sfiuY3drYdUMazs
         JQPTN4iaFD3Sn4Qa4vu7DJEpl0mESfDJ9M/qV8CZ2NaOcpyvISlKPaxOHjw7VKkRZ8Ck
         bLnm8d2ogQFaYeEyvXCkivWxtYUTQUjKB+JjN00ZyB3q8hJD56MYjCfaDKHvPFZjPT5z
         S4d1J2bnfdVTLhj4QH78AXcubwXjUQIdhxqQ2K4+iA9mO/OG2t0ZIHWGDSuj4JIXJYUN
         Bv8965hDlj8R3JV5jNZSLLrA32zyGnbKNmD9DCEVD6YVVvDYOjYtOjbjymhRvHuYfpqy
         dw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u4+MOjnojz3+/+7/XlAa+2lsmVmxt23PCyNNCzzoHqU=;
        b=kjPwTadlVAu4XGbJjkZdxujQkeTHo1re5ENx+qyOWcZ8y0kD4lGoPznv0L45p/v2+s
         POZ261UtcdK3PxJ/vsc6B+pwUyxNQw0nircmypHtzVR4xlO9Z7a8VscNkZ+UC+k5CcSu
         jqGQ5MOHp2drIURy5TJnUfAFknPJMIQfSk4i0cmy+mSDwW5iVLGg0cMGdsmmPry1n22u
         y1I0e6H5P3ddKS/JsuSEdyuEU05aPL5eITJgdVRn9kz6ks2pT1t0aHESg6MJYgMvflZe
         fW6AmNcRIsbnF+ssJEHfvkm7Wg/ByiInxqwCxuFv9sNjOxhO3Eoa51LECLbNWq6GHjcK
         fvtg==
X-Gm-Message-State: AOAM530HhhlwQIRQ726iA+/zruGqIOKpa58/lDSMpUn8NFpe6r2MNlKk
        f6AylS6+SEy/qwWlSfCyFCIT72XX5fxv+A==
X-Google-Smtp-Source: ABdhPJwwnNVBRdg/CeIA3G5LUoIuVbpi4SbWB+YvCtwtwLexV8twjcq78gtzSVtec0aqaoExzEXFEw==
X-Received: by 2002:a63:70b:: with SMTP id 11mr298502pgh.75.1627867841666;
        Sun, 01 Aug 2021 18:30:41 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.117])
        by smtp.gmail.com with ESMTPSA id q19sm10576395pgj.17.2021.08.01.18.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Aug 2021 18:30:40 -0700 (PDT)
Subject: Re: [PATCH v2] blk-throtl: optimize IOPS throttle for large IO
 scenarios
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <40915233274d31bb0659ff9f3be8900a5a0e81ba.1627462548.git.brookxu@tencent.com>
 <YQLhRrkZrmKTzfbP@mtj.duckdns.org>
 <1ce9bcbb-8eea-f51f-f80a-22caf5f2e0d8@gmail.com>
 <YQQjpQEBbdAgMUM7@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <c40d1fbf-30de-2325-a662-8fd08aa1b774@gmail.com>
Date:   Mon, 2 Aug 2021 09:30:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQQjpQEBbdAgMUM7@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



Tejun Heo wrote on 2021/7/31 12:07 上午:
> On Fri, Jul 30, 2021 at 10:09:34AM +0800, brookxu wrote:
>>>> @@ -877,10 +900,19 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
>>>>  	else
>>>>  		tg->bytes_disp[rw] = 0;
>>>>  
>>>> -	if (tg->io_disp[rw] >= io_trim)
>>>> +	if (tg_io_disp(tg, rw) >= io_trim) {
>>>
>>> Instead of checking this in multiple places, would it be simpler to transfer
>>> the atomic counters to the existing counters whenever we enter blk-throtl
>>> and leave the rest of the code as-is?
>>
>> If we do this, we need to do similar processing on the bio submission path and the bio
>> resubmission path in pending_timer. It seems that the code is more complicated?
> 
> Yeah, basically whenever we enter blk-throtl. Factored to a function,
> calling it on entry should be fairly clean, right? I wonder whether it'd be
> better to consolidate all atomic counter handling in a single location and
> all it does is transferring whatever's accumulated to the usual counters.
> Also, when you're reading & resetting the atomic counters, can you use a
> pattern like the following?
> 
>   main_counter += atomic_xchg(counter, 0);
> 
> Right now, there's a race window between reading and resetting.

Yeah, thanks for your suggestion, I will submit the next version later.

> Thanks.
> 
