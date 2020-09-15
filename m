Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C6F26ABEB
	for <lists+cgroups@lfdr.de>; Tue, 15 Sep 2020 20:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgIOS36 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 14:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgIOSSd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 14:18:33 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC26C06178A
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 11:18:00 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r10so1004193oor.5
        for <cgroups@vger.kernel.org>; Tue, 15 Sep 2020 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bTTRD0/irNQCd03woygzg2YIc3JV44oMGNS2xdYHnuY=;
        b=oMdFH0qeR7ktNNSHnOFu0cnxSyqibVe5Xfhe2tBaiWKuUcg1GDfeVU/qMzK149v5K+
         iK0oQoF39aDYeONrDyDjZS59ruDFyIryDGNrD04kboLa7s9/T2DfrPvNZ5mWtnsUkKVL
         wGRPpofseOHZAXio+PZGs0lAxHmN2RrQUMM55FmC4GuBfqFk6vs/rdl67En8WyxSWjxW
         3H3o+eCZ/0wMTcov8J54w+bE6IFxngx5LeFTF0V4ivTjpkp8ZfjwQtktOH8V2XBotEpH
         qQPHM+S0mkUvPlV3hkhPxbpIp5SEt/s2xbVoAaBbZYT9AHlf2HEqGHcTeYP3nfBbEY13
         w2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bTTRD0/irNQCd03woygzg2YIc3JV44oMGNS2xdYHnuY=;
        b=Dx3lvt20YVuuyUZ9VLtpMLgQw0g4r0jqAJjEu2BnBpuZoatVBP+/9TzxYMrL6IBtnn
         OY/QIRVphHiVc+qI1XMwdUTukPHILlDpu6kijwgbP6g5JP3kgfvIShg8q6a1Aq25HAac
         Oq9s8EMmoM3YoA533kZ1kPdei8m0QIRcw7yLQ0eBFv2dRyLI2Pvvn0ZLgTbWlHU/SI89
         vksVmCqmUcxeEIkD8IudCiy+Wj7YqJNujykw2cSAhevX1YVgAUminSaYNOt5JpMY2QRA
         uyKQ1uATs3ezGzHT4cIq3vSg7ZzRmFiPu74Xlao4fbdZEW4BbjawUlfr/G696iQGzpo/
         3RMw==
X-Gm-Message-State: AOAM5318xn43yfK/uOywVJFwrNVsepkvRnPnUJyzrHi6XgoqVdcvjc04
        VgUuQ71NclRSJbgDAuvQ+bbItBLcoBUTqWaa
X-Google-Smtp-Source: ABdhPJyQ+e6vnFc7oLm3XND80yl17hzMcTnTiY2uZpb1xItEL9ivt+KBWm5ZF0JxQskTaOcMWGW7nA==
X-Received: by 2002:a4a:5896:: with SMTP id f144mr665883oob.49.1600193878720;
        Tue, 15 Sep 2020 11:17:58 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 9sm6876327ois.10.2020.09.15.11.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 11:17:58 -0700 (PDT)
Subject: Re: [PATCH 0/5] Some improvements for blk-throttle
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     tj@kernel.org, baolin.wang7@gmail.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1599458244.git.baolin.wang@linux.alibaba.com>
 <822998a7-4cc7-88ee-8b3f-e8e7660a5b0a@kernel.dk>
 <20200915085926.GA122937@VM20190228-100.tbsite.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c36a1c1b-ca46-13c8-42eb-94e63ff845d1@kernel.dk>
Date:   Tue, 15 Sep 2020 12:17:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915085926.GA122937@VM20190228-100.tbsite.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 9/15/20 2:59 AM, Baolin Wang wrote:
> Hi Jens,
> 
> On Mon, Sep 14, 2020 at 07:37:53PM -0600, Jens Axboe wrote:
>> On 9/7/20 2:10 AM, Baolin Wang wrote:
>>> Hi All,
>>>
>>> This patch set did some clean-ups, as well as removing some unnecessary
>>> bps/iops limitation calculation when checking if can dispatch a bio or
>>> not for a tg. Please help to review. Thanks.
>>>
>>> Baolin Wang (5):
>>>   blk-throttle: Fix some comments' typos
>>>   blk-throttle: Use readable READ/WRITE macros
>>>   blk-throttle: Define readable macros instead of static variables
>>>   blk-throttle: Avoid calculating bps/iops limitation repeatedly
>>>   blk-throttle: Avoid checking bps/iops limitation if bps or iops is    
>>>     unlimited
>>>
>>>  block/blk-throttle.c | 59 ++++++++++++++++++++++++++++++++--------------------
>>>  1 file changed, 36 insertions(+), 23 deletions(-)
>>
>> Looks reasonable to me, I've applied it.
> 
> Thanks.
> 
>>
>> Out of curiosity, are you using blk-throttle in production, or are these
>> just fixes/cleanups that you came across?
> 
> Yes, we're using it in some old products, and I am trying to do some
> cleanups and optimizaiton when testing it.

Gotcha. Reason I ask is I've been considering deprecating it, but when
fixes come in for something, that always makes me think that some folks
are actually using it.

-- 
Jens Axboe

