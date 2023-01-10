Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3473C664662
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjAJQo0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Jan 2023 11:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjAJP7Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Jan 2023 10:59:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2B04FCDF
        for <cgroups@vger.kernel.org>; Tue, 10 Jan 2023 07:59:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id s8so5324792plk.5
        for <cgroups@vger.kernel.org>; Tue, 10 Jan 2023 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2R/55S8jT4stsBsiIv+FPNzG31bz0/CdEe06+rGUk1k=;
        b=61Jwo1uWFCLRsb3ILZ7lkZPW4qjqzqjsluq35w5Ij+AWN0s+nRwdMCrbrPRVqY6nN4
         kJw2BfytRBn2Xj5nvil9XL8+SySFkSZVuinHm5JYtCQJScp6fmHnmG6IHt9qVVYSyJIl
         oyHjT+6SxrvHACnLSAWNBfs/s7CcN3GwNIOnYbS1EQmf35tp84dIIAXZs7qNWpDSb4Jb
         mAGGBh5GBCKZCjT8iF+nmoo1/PwiD+qN5ypq8MpGcw1BXdgExhO4T3cENLzzkT5bV1eW
         tw1eyptt7PA5nbcLQnjfM4ALqtFktFZBHc3iI46z67WOClTyJPZx73W7zUo8eWFHq9vu
         8IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2R/55S8jT4stsBsiIv+FPNzG31bz0/CdEe06+rGUk1k=;
        b=515+0eeXm8di5vUAgwpgrhyuyV8hUCPb5dVRPxAXojC5q8g7lSLWLJlYj21qzEzgAx
         nHCapngyLQhIUbkNhTGXwj74WyT4rlibXJCvYvLaPKH2ktzJ2cI/G8JTKsxST8D8rMod
         pk1pWZcMe+z/RL3Ou7zn5IY83jdKXN2MbZ5QpqkuqUgMBQ7YsigRvEX9tDgo9ARMbtpG
         AD3hnLy0Rr2/Dfmqq6uIwf+A5NpChJf/TmNhVsRMLxn+YWZNbSKjoo698/kaGtpxyjMd
         5GEcaXmJ9QoYQKgzOHFmomZypy6k6Y+TAyRgN3j9P0f3sMFaxsu2XBBPBIFumeUNmF5g
         pHDQ==
X-Gm-Message-State: AFqh2kqc41c3tL8AHfP/wcJE+OgeQVPiXxsvEc4d+gL/mzJ4Heoxf1g6
        dxTmEmvZFDX9ncFvx+tFs+CpsAqBapjw0fb3ni2fVA==
X-Google-Smtp-Source: AMrXdXurVMOG3vgv5T3G0tCOwgHzJpPmQi1SFa+S16AnjjZBHiJDViS424FIrRfLpoVzzEJ+hx8mvQ==
X-Received: by 2002:a05:6a21:3d04:b0:b6:8c6:5e6a with SMTP id bi4-20020a056a213d0400b000b608c65e6amr4256944pzc.0.1673366354682;
        Tue, 10 Jan 2023 07:59:14 -0800 (PST)
Received: from [10.254.85.126] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id h18-20020a656392000000b0046b1dabf9a8sm6948417pgv.70.2023.01.10.07.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 07:59:14 -0800 (PST)
Message-ID: <b4cf040e-a9d9-8b7a-10cf-80b01d02848f@bytedance.com>
Date:   Tue, 10 Jan 2023 23:59:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [External] Re: [PATCH v4] blk-throtl: Introduce sync and async
 queues for blk-throtl
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com
References: <20230107130738.75640-1-hanjinke.666@bytedance.com>
 <Y7x7yq5YmcXhVkQf@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y7x7yq5YmcXhVkQf@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2023/1/10 上午4:40, Tejun Heo 写道:
> On Sat, Jan 07, 2023 at 09:07:38PM +0800, Jinke Han wrote:
>> + * Assumed that there were only bios queued in ASYNC queue and the SYNC
>> + * queue was empty. The ASYNC bio was selected to dispatch and the
>> + * disp_sync_cnt was set to 0 after each dispatching. If a ASYNC bio
>> + * can't be dispatched because of overlimit in current slice, the process
>> + * of dispatch should give up and the spin lock of the request queue
>> + * may be released. A new SYNC bio may be queued in the SYNC queue then.
>> + * When it's time to dispatch this tg, the SYNC bio was selected and pop
>> + * to dispatch as the disp_sync_cnt is 0 and the SYNC queue is no-empty.
>> + * If the dispatched bio is smaller than the waiting bio, the bandwidth
>> + * may be hard to satisfied as the slice may be trimed after each dispatch.
> 
> I still can't make a good sense of this scenario. Can you give concrete
> example scenarios with IOs and why it would matter?
> 
> Thanks.
> 

Assumed that there are many buffer write bios queued in ASYNC queue and 
the SYNC queue is empty. The buffer write bios are all 1M in size and 
the bps limit is 1M/s. The throtl_slice is 100ms.

Assumed that the start/end_slice is [jiffies1, jiffies1+100] and 
bytes_disp[w] = 0. The next ASYNC bio can't dispatch because of 
overlimit within this slice. The wait time is 900ms and the slice will 
be extended to [jiffies1, jiffies1 + 1000] in tg_may_dispatch.

During the waiting of the ASYNC bio, a SYNC 4k bio be queued in SYNC 
queue. After 900ms, it's time to dispatch the ASYNC io, but the SYNC 4k 
bio be selected to be dispatched. Now the slice is [jiffies1, 
jiffies1+1000] and the byte_disp[w] = 4k. The slice may be extended to
[jiffies1, jiffies1+1100]. In tg_dispatch_one_bio, the slice will be 
trimed to [jiffies1+1000, jiffies1+1100], the byte_disp[w] will set 0.

After the 4k SYNC bio be dispatched, the WAITING ASYNC bio still cann't
be dispatched because of overlimit within this slice.

The same thing may happen DISPACH_SYNC_FACTOR times if alway there is a 
SYNC bio be queued in the SYNC queue when the ASYNC bio is waiting.

This means that in nearly 5s, we have dispathed 4 4k SYNC bios and a 1m 
ASYNC bio.

In our test, with 100M/s bps limit setted, the bps only reach to ~80m/s
when a fio generate buffer write ios and fsync continuous generated by 
dbench in same cgroup.

Thanks
Jinke.






