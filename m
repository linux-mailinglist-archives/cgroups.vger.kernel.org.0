Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04A5688603
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 19:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjBBSF3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 13:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjBBSF2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 13:05:28 -0500
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C62F7D8B;
        Thu,  2 Feb 2023 10:05:27 -0800 (PST)
Received: by mail-pl1-f178.google.com with SMTP id d3so2663323plr.10;
        Thu, 02 Feb 2023 10:05:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0zT8dOnsNQ4Iqvm0FRa89zk1YjhJiK9M3MQH8V9FYno=;
        b=Fu6cVCEI2hO8V6sKF/OwfalrrSm4ndHRY3yAXE2q3ZayWI+AfaEMLZ3rOd+Qc2Cpfy
         i7QzIlSe4Lr0M58YjwadBB8r49Ni24B3PyzasMohZBVSoNi8jV0w6vfyOHza1XvZ7urT
         tSepTky5964d8vHPgDY14anx4hwqMfiOW2prvEJ7wD4hs2i2EqP6Qw0Ru+GR5iul/jBX
         D2VhAYKLri6faLM4GiN2aRx1MMFyXq+b5doGNjNZZBgSJzdQ6kxsNPceMe0LXjC4OBFj
         4MthPft0IB9auEi92+sgpqZQUDymRpE8DXrsVqyNl/gzHEVqS7lX/7KwsuugjsD7qLb4
         C9Sg==
X-Gm-Message-State: AO0yUKW9mJU0qn8lqVACWWsYpL+u7c94Z87gwOQAdYekQuHY91wL/5Ok
        YWd7nd7wOSbRx9x8kcIkGys=
X-Google-Smtp-Source: AK7set9fhkypiICyVtM5Ql7G+NSr7dbI7umFAXdORuO9KmB/ohQmvu2U4sYetBl9Q1bXf2FPIOXrVA==
X-Received: by 2002:a17:902:d4c1:b0:196:49a9:bf26 with SMTP id o1-20020a170902d4c100b0019649a9bf26mr8344222plg.15.1675361126683;
        Thu, 02 Feb 2023 10:05:26 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:bf7f:37aa:6a01:bf09? ([2620:15c:211:201:bf7f:37aa:6a01:bf09])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b0019601f98550sm5334928pls.132.2023.02.02.10.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 10:05:26 -0800 (PST)
Message-ID: <b6b3c498-e90b-7d1f-6ad5-a31334e433ae@acm.org>
Date:   Thu, 2 Feb 2023 10:05:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] blk-ioprio: Introduce promote-to-rt policy
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230201045227.2203123-1-houtao@huaweicloud.com>
 <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
 <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4f7dcb3e-2d5a-cae3-0e1c-a82bcc3d2217@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/2/23 03:09, Hou Tao wrote:
> Hi,
> 
> On 2/2/2023 1:33 AM, Bart Van Assche wrote:
>> On 1/31/23 20:52, Hou Tao wrote:
>>>    /**
>>>     * enum prio_policy - I/O priority class policy.
>>>     * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
>>> @@ -27,21 +34,30 @@
>>>     * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
>>>     *        IOPRIO_CLASS_BE.
>>>     * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
>>> - *
>>> + * @POLICY_PROMOTE_TO_RT: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_BE into
>>> + *         IOPRIO_CLASS_RT.
>>>     * See also <linux/ioprio.h>.
>>>     */
>>>    enum prio_policy {
>>> -    POLICY_NO_CHANGE    = 0,
>>> -    POLICY_NONE_TO_RT    = 1,
>>> -    POLICY_RESTRICT_TO_BE    = 2,
>>> -    POLICY_ALL_TO_IDLE    = 3,
>>> +    POLICY_NO_CHANGE    = IOPRIO_CLASS_NONE,
>>> +    POLICY_NONE_TO_RT    = IOPRIO_CLASS_RT,
>>> +    POLICY_RESTRICT_TO_BE    = IOPRIO_CLASS_BE,
>>> +    POLICY_ALL_TO_IDLE    = IOPRIO_CLASS_IDLE,
>>> +    POLICY_PROMOTE_TO_RT    = IOPRIO_CLASS_RT | IOPRIO_POL_PROMOTION,
>>> +};
>>
>> The above change complicates the ioprio code. Additionally, I'm concerned that
>> it makes the ioprio code slower. Has it been considered to keep the numerical
>> values for the existing policies, to assign the number 4 to
>> POLICY_PROMOTE_TO_RT and to use a lookup-array in blkcg_set_ioprio() to
>> convert the policy number into an IOPRIO_CLASS value?
> For the slowness, do you meaning the extra dereference of blkcg->ioprio->policy
> when policy is no-change or the handle of IOPRIO_POL_PROMOTION in
> blkcg_set_ioprio()? It seems other functions (e.g., ioprio_show_prio_policy()
> and ioprio_set_prio_policy()) are not on the hot path. Using a lookup array in
> blkcg_set_ioprio() to do the conversion will also be OK, although it will
> introduce an extra lookup each time when policy is not no-change. I don't have
> strong preference. If you are OK with lookup array in blkcg_set_ioprio(), will
> do it in v2.

Hi Hou,

I prefer the lookup array because with the lookup array approach the 
IOPRIO_POL_PROMOTION constant is no longer needed and because I expect 
that this will result in code that is easier to read. Additionally, the 
lookup array will be small so the compiler may be clever enough to 
optimize it away.

Thanks,

Bart.

