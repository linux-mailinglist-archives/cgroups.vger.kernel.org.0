Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBBF521A18D
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2020 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgGIN7B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jul 2020 09:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgGIN7A (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jul 2020 09:59:00 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2CFC08E763
        for <cgroups@vger.kernel.org>; Thu,  9 Jul 2020 06:59:00 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so2371598iow.8
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2020 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ttUciq1R4DLXwSrCKOG8sMg2/ZhVL4qipuIgKqQy2hE=;
        b=coM9AtJu0ST+XR8OMgywQuHtTrKC9/b3RSDkB5xLiy4QzbX3T0Aw61rbH1CahgBBuR
         uHGxD5IVaENFxujEI50kNZMa4M546fERlVcPXVLx0073TNTIByYun/g+RHhX1WEDPk90
         nLVTJFCuIlptJdGLVxMiS/3WV+WEeYk/uPnJy7GYNSE5TcqY5Sk+XRfP9o7wxQhjTuBd
         OfxdrSK1xj7iSzi0tqotyg0P0tyJIhgxoopV77fateMyHS2NoNRk3u2YMgfEUz9jt+Mx
         I7oNOyQ+dlAawprLARe5BTTjR91BKrEJGHW7LfKtefXB0VFKSsrdcDKI81gtPbkU0jfv
         Jz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ttUciq1R4DLXwSrCKOG8sMg2/ZhVL4qipuIgKqQy2hE=;
        b=M2NERbfelfVKgSSLuOyDvg0bjC8WWcl7lYZu+bpIxxnQy/bckDDrl8P3Irzqo2mlQl
         1T5aIQxwJzSrPHa6w7P42j5Kge7XpnYlmQz9qU5SiZQ3zcjkNoJ3wO4yaIufJRmX3fiV
         yBOt7qvCdeSDPBT4yn4hv/uwzlYsueAXbBlsvfsl+hlaDaLJCFKKQ91UACE2OwC+yr19
         RYrpv6OMTb45i/PNoWbQ+sbpyUcxw0NS2KK95ouLtj4Y1dQoHV4Pnm9NcMR9WOuvoQMP
         QC0KgnBzC6he8QXOBNUtBAoZFrXcU7au5rbtsIcmlVeJiffBO5F+/luxSQmCQ6Sb35mI
         JIvA==
X-Gm-Message-State: AOAM532gWm8W3RerAHzwp548W1AQS2RLyZi8iYf2Gs902BZn5zFQMqqN
        bSXydRKBfXmsV+ADwD/0jrv6MA==
X-Google-Smtp-Source: ABdhPJwILxLSUCxDdCac/fZUN7tHM3l14dJ0zrZ6D/Tc1v+OsXoh2HYNZYg6WBqjtOr30hdwGoEJQw==
X-Received: by 2002:a05:6638:168e:: with SMTP id f14mr67991477jat.64.1594303139999;
        Thu, 09 Jul 2020 06:58:59 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a1sm1884363ilq.50.2020.07.09.06.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 06:58:59 -0700 (PDT)
Subject: Re: remove dead bdi congestion leftovers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Tejun Heo <tj@kernel.org>, dm-devel@redhat.com,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200701090622.3354860-1-hch@lst.de>
 <b5d6df17-68af-d535-79e4-f95e16dd5632@kernel.dk>
 <20200709053233.GA3243@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82e2785d-2091-1986-0014-3b7cea7cd0d8@kernel.dk>
Date:   Thu, 9 Jul 2020 07:58:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709053233.GA3243@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 7/8/20 11:32 PM, Christoph Hellwig wrote:
> On Wed, Jul 08, 2020 at 05:14:29PM -0600, Jens Axboe wrote:
>> On 7/1/20 3:06 AM, Christoph Hellwig wrote:
>>> Hi Jens,
>>>
>>> we have a lot of bdi congestion related code that is left around without
>>> any use.  This series removes it in preparation of sorting out the bdi
>>> lifetime rules properly.
>>
>> Please run series like this through a full compilation, for both this one
>> and the previous series I had to fix up issues like this:
>>
>> drivers/md/bcache/request.c: In function ‘bch_cached_dev_request_init’:
>> drivers/md/bcache/request.c:1233:18: warning: unused variable ‘g’ [-Wunused-variable]
>>  1233 |  struct gendisk *g = dc->disk.disk;
>>       |                  ^
>> drivers/md/bcache/request.c: In function ‘bch_flash_dev_request_init’:
>> drivers/md/bcache/request.c:1320:18: warning: unused variable ‘g’ [-Wunused-variable]
>>  1320 |  struct gendisk *g = d->disk;
>>       |                  ^
>>
>> Did the same here, applied it.
> 
> And just like the previous one I did, and the compiler did not complain.
> There must be something about certain gcc versions not warning about
> variables that are initialized but not otherwise used.

Are you using gcc-10? It sucks for that. gcc-9 seems to reliably hit
these cases for me, not sure why gcc-10 doesn't. And the ones quoted
above are about as trivial as they can get.

-- 
Jens Axboe

