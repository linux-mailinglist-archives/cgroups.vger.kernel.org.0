Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2347064AE7C
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 04:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiLMDzY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 22:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLMDzW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 22:55:22 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E47D62
        for <cgroups@vger.kernel.org>; Mon, 12 Dec 2022 19:55:21 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id w37so9614814pga.5
        for <cgroups@vger.kernel.org>; Mon, 12 Dec 2022 19:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYjaVxJ8zzYY/wcJIpDE24JVFr7zT7qIcwbkFsHmVvs=;
        b=QWEx+gZ2PhKWDG0bgn2LpnDM2ERwR0BtZxJCkzyxSMzyqp91gjIp9nztK75ZbkIZGj
         fH+BckFZpqbGaNDMTQvYT0GjUCFDXpaT9Q68Pqcq8dg87e9Ubp7zgxs06kgGcFtsyM6v
         X+wXRVQqk0dEG5RCr0OeSEf6bWScfcfyi88jC3lI9JU6yW0Z8Or3q7+HwHvcgd1s0nNK
         wTC98sUh2PBmkmNZy9lWh+6vpPmvAMXTOmE+8Y4uVxaELC/6Rbstvc0upqU86ZS0yVxa
         Bqdux28uMNN0+pHpHGZyd4FihPpyg7GALCAh4lAEqE2oXwGEZTmtq4DJPSqfab7wzTqI
         lRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fYjaVxJ8zzYY/wcJIpDE24JVFr7zT7qIcwbkFsHmVvs=;
        b=Q1dmWOTQEkPglyHt5b+L/PpeAtMTNfzWMyx+KnZWTbJUinAAMeTv5VQln613CHJgaW
         XunfcH2HOO9eZeKl5cTLlsVhbgTRvKFFdCrCOerXgtentIEpAlmSQMUfxKwD3Y6RsVqh
         AB61beooqmwmxcG+1OVwgFbRAwGDTGmNGx1YRPWdyrNjAILGayqHq+XloZP2qZkvZtVg
         ZEJJe+5CgRov9P1C8Zc3Q3ShwyOShVu4zw02cq2JlB2gpvBA3tTOzkUoVCRX9FSsrcur
         RmNxZ64odGTlrisua4wVsDhz62ZjHYQK0xdlRIhxvhVRQ2SB2FDZvhQCPDrZDYc9RvaE
         15XQ==
X-Gm-Message-State: ANoB5plQWUesbhCt4O+wmusL31HjdLcZnmuIKn894/VKlCeCY2RYAdIO
        ZNdstCXiPMNdkcmsPV7Bwov/mQ==
X-Google-Smtp-Source: AA0mqf7C5Xdij/8oSeypbd3y1Kst+OwPZKp+6fVzidf4boHf8OrOOAVP8ZvucD/mcRCJaFF9XWUTqg==
X-Received: by 2002:aa7:8108:0:b0:575:e8c5:eb14 with SMTP id b8-20020aa78108000000b00575e8c5eb14mr15284976pfi.18.1670903721109;
        Mon, 12 Dec 2022 19:55:21 -0800 (PST)
Received: from [10.5.231.247] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id q14-20020aa7960e000000b00562a526cd2esm6576688pfg.55.2022.12.12.19.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 19:55:20 -0800 (PST)
Message-ID: <f42d81c1-47c8-e283-1259-8c554bf46c46@bytedance.com>
Date:   Tue, 13 Dec 2022 11:55:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [External] Re: [RFC PATCH] blk-throtl: Introduce sync queue for
 write ios
To:     Tejun Heo <tj@kernel.org>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221206163826.10700-1-hanjinke.666@bytedance.com>
 <Y5et48VryiKgL/eD@slm.duckdns.org>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <Y5et48VryiKgL/eD@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



在 2022/12/13 上午6:40, Tejun Heo 写道:
> On Wed, Dec 07, 2022 at 12:38:26AM +0800, Jinke Han wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> Now we don't distinguish sync write ios from normal buffer write ios
>> in blk-throtl. A bio with REQ_SYNC tagged always mean it will be wait
>> until write completion soon after it submit. So it's reasonable for sync
>> io to complete as soon as possible.
>>
>> In our test, fio writes a 100g file in sequential 4k blocksize in
>> a container with low bps limit configured (wbps=10M). More than 1200
>> ios were throttled in blk-throtl queue and the avarage throtle time
>> of each io is 140s. At the same time, the operation of saving a small
>> file by vim will be blocked amolst 140s. As a fsync will be send by vim,
>> the sync ios of fsync will be blocked by a huge amount of buffer write
>> ios ahead. This is also a priority inversion problem within one cgroup.
>> In the database scene, things got really bad with blk-throtle enabled
>> as fsync is called very often.
>>
>> This patch introduces a independent sync queue for write ios and gives
>> a huge priority to sync write ios. I think it's a nice respond to the
>> semantics of REQ_SYNC. Bios with REQ_META and REQ_PRIO gains the same
>> priority as they are important to fs. This may avoid some potential
>> priority inversion problems.
> 
> I think the idea makes sense but wonder whether the implementation would be
> cleaner / simpler if the sq->queued[] are indexed by SYNC, ASYNC and the
> sync writes are queued in the sync queue together with reads.
> 
> Thanks.
> 

If something is said wrong, please correct me.

If sq->queue[] were only classfied SYNC and ASYNC, some things may 
become a little difficult to handle。As we put sync write and read 
together into SYNC queue, the two may influence each other.
Whit wbps=1M and rbps=100M configured, sync io likely be throtled while 
read ios after it may can be dispatched within the limit. In that case,
maybe we should scan the whole SYNC queue to check read io.

Thanks.
Jinke

