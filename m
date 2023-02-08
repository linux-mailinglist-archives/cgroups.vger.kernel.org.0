Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B3768F627
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 18:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjBHRxq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 12:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjBHRxp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 12:53:45 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BAB59E2;
        Wed,  8 Feb 2023 09:53:44 -0800 (PST)
Received: by mail-pl1-f182.google.com with SMTP id k13so20227761plg.0;
        Wed, 08 Feb 2023 09:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHYPrSiTkVKIlfo8HfMdMKbV5juD4qgKqM8oSnLweE8=;
        b=sQwEsm+G5eaUbb7aY1mSz7DJb8FYCFum2/YVoB4IJIWjliqWRFDlUam0z9NiKPYfl8
         1tx0ZjD+WdqUjwWbtzjxx7ER0S2E5GXcsunYeS4CrkWjR9XYMWLqDJ4nEvPJCSNqIvKb
         gfN6bySy569/MsWsXFEAkVF4qIQST4IGSFtaJH+fsb9We1LUyqwXmJ3fpzv1DjUV6AIa
         PSgDdeytsXpAHk5wZ2tP94Rpr4UZo8amFj1z7QqvKjnOUKQEtRiAwf74C3i1O99Tgher
         6dsKD1+ZmRXMW33Qm45LSgQRcu6PLgAZi8GhupiKbkeyVEY76bLEapaRwoODq13AOYgW
         mzMw==
X-Gm-Message-State: AO0yUKVCqbh/42wON6JxA3liBwlzgya8lCkqcJMjXdGNC+g/UpnwRqxD
        1plw+3ptQzc+rGEA/FGB//Y=
X-Google-Smtp-Source: AK7set/GrvVfRVcZ26t5iBnwWqMEPtJBrPM9dsurSPWoOG+E6492+ASW9DmosYVxi30oZtwSF3UQFQ==
X-Received: by 2002:a17:902:e1c4:b0:195:e92e:c4d3 with SMTP id t4-20020a170902e1c400b00195e92ec4d3mr5589893pla.46.1675878824157;
        Wed, 08 Feb 2023 09:53:44 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:869f:66a2:40c:445d? ([2620:15c:211:201:869f:66a2:40c:445d])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902a60200b001962858f990sm11370358plq.164.2023.02.08.09.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 09:53:43 -0800 (PST)
Message-ID: <7fcd4c38-ccbe-6411-e424-a57595ad9c0b@acm.org>
Date:   Wed, 8 Feb 2023 09:53:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
 <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
 <beb7782e-72a4-c350-3750-23a767c88753@huaweicloud.com>
 <aedc240d-7c9e-248a-52d2-c9775f3e8ca1@acm.org>
 <20230208134345.77bdep3kzp52haxu@quack3>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230208134345.77bdep3kzp52haxu@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/8/23 05:43, Jan Kara wrote:
> On Fri 03-02-23 11:45:32, Bart Van Assche wrote:
>> On 2/2/23 17:48, Hou Tao wrote:
>>> I don't get it on how to remove IOPRIO_POL_PROMOTION when calculating the final
>>> ioprio for bio. IOPRIO_POL_PROMOTION is not used for IOPRIO_CLASS values but
>>> used to determinate on how to calculate the final ioprio for bio: choosing the
>>> maximum or minimum between blkcg ioprio and original bio bi_ioprio.
>>
>> Do the block layer code changes shown below implement the functionality
>> that you need?
> 
> Just one question guys: So with my a78418e6a04c ("block: Always initialize
> bio IO priority on submit") none-to-rt policy became effectively a noop as
> Hou properly noticed. Are we aware of any users that were broken by this?
> Shouldn't we rather fix the code so that none-to-rt starts to operate
> correctly again? Or maybe change the none-to-rt meaning to be actually
> promote-to-rt?
> 
> I have to admit I'm wondering a bit what was the intended usecase behind
> the introduction of none-to-rt policy. Can someone elaborate? promote-to-rt
> makes some sense to me - we have a priviledged cgroup we want to provide
> low latency access to IO but none-to-rt just does not make much sense to
> me...

Hi Jan,

The test results I shared some time ago show that IOPRIO_CLASS_NONE was 
the default I/O priority two years ago (see also 
https://lore.kernel.org/linux-block/20210927220328.1410161-5-bvanassche@acm.org/). 
The none-to-rt policy increases the priority of bio's that have not been 
assigned an I/O priority to RT. Does this answer your question?

Thanks,

Bart.

