Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAA43D85EB
	for <lists+cgroups@lfdr.de>; Wed, 28 Jul 2021 04:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhG1Cdb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Jul 2021 22:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbhG1Cdb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Jul 2021 22:33:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68895C061757;
        Tue, 27 Jul 2021 19:33:29 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso7798262pjb.1;
        Tue, 27 Jul 2021 19:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D45lrolxqJIjPPb8I/48vYfzy0j0FugUdvX8Qruvv54=;
        b=pQfJFQ+eTwlrNYDdbzs2U9jeZ0E/c0YUPgCYHaq+gBlpkgqxicfU9PnwGI0BrE3/lT
         tt2V1uJZiKWoQ5kUXBGAXbePZTKTjE2YexRN9Gnmkix3BF4KxE0qYyjh69qdQS6o7EQL
         6Ax5YEkduRwRULXud/4EmTwFUKwWcNR/GIADiNZrQely2ESBEN3UVhZKwnFKd1dji3dF
         rDbXmtNZs3qHjiJ9GuBK7FAoljylKQlQVdzjarnbpEyV09wdSSVF+tiU9f+xKKz+IaLF
         S9MODWQ4I2U2Q1M7emhDGag6v8H0L8j6jGp5S2APB42m9ppQ5Sw6JhXkmb1Tdaq0tVb1
         YeLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D45lrolxqJIjPPb8I/48vYfzy0j0FugUdvX8Qruvv54=;
        b=eFKVMc0SMBTo/uLX/gESXPFZKkNqamX7+1R7veiljvzK/tGGvQn4RO4fPA0/Uicskc
         BL/tg5942uIQ3IsPFVMEUsZEo37/xMSflUIRa3GOdCm4kQheE8gEfdwASUhf6ydnssoi
         67qVRnXv5ZUNC7xM6WmSfAFljDA4Y+R6RfxqTlRSpscB8scHxvfWF8UnIxtoTCMRN7sU
         xzHCIwjyTbDizDBEhCVpQH+MbSGQoWSQiB8H+7rzYMR9/gWI51PUcwL4GLkkOHHpRSj6
         EoOf5H8gyegOxr7SZbnxivuxTFuYdSLQGp+hVrq2l6KrdvNsBR5oJvLcZ6ekCkQsS0cB
         0t1w==
X-Gm-Message-State: AOAM533iAJSD+xRA8AITGOEfdSRI9X9WXi+nlEbN6tmI4+J0BIxm8l68
        Tj6dwUKTx7vWfYQJISYefaqrLAPPchJtMw==
X-Google-Smtp-Source: ABdhPJxP5Se/5psX3Di0Yjyg2zr2lBpOzdzRRiH5bE1mZy3PBuFZSeeuLMOJh+nGdvPJ+ExVs2UZDw==
X-Received: by 2002:a65:52c2:: with SMTP id z2mr1994938pgp.225.1627439608862;
        Tue, 27 Jul 2021 19:33:28 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.110])
        by smtp.gmail.com with ESMTPSA id j22sm5339769pgb.62.2021.07.27.19.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 19:33:28 -0700 (PDT)
Subject: Re: [PATCH] blk-throtl: optimize IOPS throttle for large IO scenarios
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1626416569-30907-1-git-send-email-brookxu.cn@gmail.com>
 <YPGvIzZUI+QxP1js@mtj.duckdns.org>
 <957ab14d-c4bc-32f0-3f7d-af98832ab955@gmail.com>
 <YP8tPwkJNMAcjDqk@mtj.duckdns.org>
 <34a6f4b5-9055-e519-5693-068f8dcb169c@gmail.com>
 <YQAydzEhZfPUpzWI@mtj.duckdns.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <fab343e8-5929-fb30-90e3-b5b6bd34702a@gmail.com>
Date:   Wed, 28 Jul 2021 10:33:20 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQAydzEhZfPUpzWI@mtj.duckdns.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for your time.

Tejun Heo wrote on 2021/7/28 12:21 上午:
> Hello,
> 
> On Tue, Jul 27, 2021 at 11:06:18AM +0800, brookxu wrote:
>> Make blk-throttle use rq-qos may be more elegant. But I found that there may be at least
>> one problem that is difficult to solve. blk-throttle supports separate throttle for read
>> and write IOs, which means that we cannot suspend tasks during throttle, but rq-qos
>> throttle IOs by suspending tasks.
> 
> Ah, right, I forgot about that.
> 
>> We may be able to relocate the blk-throttle hooks to the rq-qos hooks. Since we may not
>> be able to replace the throttle hook, in this case, if we register a rq-qos to the system,
>> part of the blk-throttle hooks is in rq-qos and part hooks not, which feels a bit confusing.
>> In addition, we may need to implement more hooks, such as IO merge hook.
> 
> Would it be possible to just move the blk-throtl throttling hook right next
> to the rq-qos hook so that it gets throttled after splitting?

If we do this, I think we will encounter some problems, as follows:
1. blk-throttle is now at the top of the IO stack. Changing the position of the throttle hook
   will make this mechanism invalid for some devices.
2. We may also need to add a new hook to handle back-merge, otherwise I think the isolation
   effect will be worse in the sequential IO scene.
3. Since bio has entered the IO stack, if it is suspended and resubmitted by blk-throttle,
   then there is an IO stack reentry problem, which I think may cause many small problems.

> Thanks.
> 
