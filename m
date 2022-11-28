Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D165863B1BE
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 20:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiK1TBH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 14:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbiK1TBC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 14:01:02 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E73527937
        for <cgroups@vger.kernel.org>; Mon, 28 Nov 2022 11:00:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o12so2598327pjo.4
        for <cgroups@vger.kernel.org>; Mon, 28 Nov 2022 11:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvEJDQxAkm5Pcp5ay5EjtKj5MIU+4aSru9VkuAAqDpI=;
        b=ZIxVcpTUMb/D5eaOHDEpksfQ3kJ7ZSLXnpj/xXuk9U3DX0xoA2fCl9AbKfhZwZhspV
         fbCcGlev/4EIGojtU1A9K3yvnZdq0T/YLnigSVlZGNQ4cmCpsz54dTGsTSZnzhQQSh2F
         Cfpm/jc+vFpNjyQ+IZMGe+5QzeVLYaYHfv1vY5263b/JPmEuMWLMhThQSjKqNuWjbaqr
         st2WSkGe+KfyQYa85gs07HW4jJt3Qgj8hCQALJ5ZvFw66ttA8YfEsaKse0X+lJHhwT/n
         JbSc9Xv4dAC1AUM24H/pg1KhjbiUnHTiPpNuNxguOTpswj0T3okv4RQZv7mFYqAHY8sd
         vCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LvEJDQxAkm5Pcp5ay5EjtKj5MIU+4aSru9VkuAAqDpI=;
        b=6zBHxzTbvrbQwj/nVTA8NyWP0WKnGe8mCgr3PS78EU/+QsW4nctZovh2G/yEgYBGQh
         ZPtcEchnBdmmqSs7MOyNSsc+hE+bJsbxd6ihN7ZO2e3VREONHuMnMmI63rh8/KSMINAo
         XXumveekGnKE8TVgRXJIW/dtZ5VCDBUrrZxJGFeQD38pcveSeZXv9mhps4JnqDy/uOar
         dxU0y6rxK2noiZliqNhihMLRJ1nZn9d6HwcMzsmlwjn8pSn0cuZvq4E1eM0VugXRSV5u
         hH8YJRDtH3/jdTfe7yrRV8y5cuZpRvh0pens2Bod0PWO6P/h0JKxcFz5fW45c78cO0vY
         SZOw==
X-Gm-Message-State: ANoB5pnD1woFKsq6bNcpTv5av87tvN79I2bzbplCZDTU7g6ZiMUZZ4Eb
        e2ipp6orwZd+7h/laMrpcX1gXw==
X-Google-Smtp-Source: AA0mqf5Tp1M+FX2RI4vi6K/Uf4ycXTS0LenkHg91EgRKhSqajbSJM3Ugd/1SDVwIRupnNt7JPvregQ==
X-Received: by 2002:a17:902:7d97:b0:188:f87d:70d3 with SMTP id a23-20020a1709027d9700b00188f87d70d3mr32810098plm.43.1669662058117;
        Mon, 28 Nov 2022 11:00:58 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id oa16-20020a17090b1bd000b001ef8ab65052sm7929766pjb.11.2022.11.28.11.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 11:00:56 -0800 (PST)
Message-ID: <f89e922c-16d5-0bcf-7e7e-096f42793a36@kernel.dk>
Date:   Mon, 28 Nov 2022 12:00:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
 <d08a0059-7c0b-d65f-d184-5b0cb75c08ed@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d08a0059-7c0b-d65f-d184-5b0cb75c08ed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/28/22 11:56 AM, Bart Van Assche wrote:
> On 11/27/22 19:30, Waiman Long wrote:
>> Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")
> 
> Has Jens' for-next branch perhaps been rebased? I see the following commit ID for that patch:
> 
> dae590a6c96c ("blk-cgroup: Flush stats at blkgs destruction path")

I don't know that sha is from, not from me. for-6.2/block has not been
rebased, for-next gets rebased whenever I need to do so as linux-next is
continually rebased anyway. But the sha for that commit would not change
as a result.

I don't even have that sha in my tree, so...

-- 
Jens Axboe


