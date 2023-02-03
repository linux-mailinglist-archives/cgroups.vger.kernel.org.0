Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F9E68A346
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 20:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjBCTvv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 14:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBCTvv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 14:51:51 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863FFA42A6;
        Fri,  3 Feb 2023 11:51:50 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id u9so2073845plf.3;
        Fri, 03 Feb 2023 11:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxF088S52bQwgAxLundAr5dx4dt7mnQYl5+HLZOJtj4=;
        b=OufnVsrkdCDZnrIIO4z9mG+OmxXEYJhXTvrHKQ5i1TrGix9g4zhpmykgWn5GbeO8Hb
         KjVBbZkI3qZ4GADHnhYlK17mNoL1tCcvGc4JKk7Zhhav0CGJC83QiWgyKrT4ZQaE3EZU
         a9NvqYIrKTGpyS0gdUKcTKiV/dbIeZHc3SEVVs8qVFt6Z51gmeadlElp/vy9hcSr4WUi
         65qca52xlGD+LWkNe+BswaNtofGUzOZvSb+8BVEKLWYBY4VCPad4jPinbgCUanywfNGb
         oH5d9oxKUzYHjDFq2vIRLub8cCe0Or1OV6dqxUKcJGfZpurZKjRoyjr2gGvaUerBiHTf
         tC6g==
X-Gm-Message-State: AO0yUKURD5u3oevEJ1WNOo0/F5wnwKQysY6W39TL5M3qoZ6Y573DZmLQ
        r/XrPk3+2zBUCWs7JGH1+Ek=
X-Google-Smtp-Source: AK7set8OWiY85LqgYTIFwdPApnxkX47RN0hU8c4CbFbske6wYlFVr1lKBOZ8wL0SUra4zWcxuRwuaQ==
X-Received: by 2002:a17:90b:3147:b0:22c:3830:d777 with SMTP id ip7-20020a17090b314700b0022c3830d777mr11876374pjb.48.1675453909925;
        Fri, 03 Feb 2023 11:51:49 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:b752:5d03:ec5e:7be5? ([2620:15c:211:201:b752:5d03:ec5e:7be5])
        by smtp.gmail.com with ESMTPSA id ms17-20020a17090b235100b002262ab43327sm5382865pjb.26.2023.02.03.11.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 11:51:48 -0800 (PST)
Message-ID: <a2d8d491-7410-2dd8-cc11-a0519e2025b6@acm.org>
Date:   Fri, 3 Feb 2023 11:51:47 -0800
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
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230201045227.2203123-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/31/23 20:52, Hou Tao wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index c8ae7c897f14..e0b9f73ef62a 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2038,17 +2038,27 @@ that attribute:
>   	Change the I/O priority class of all requests into IDLE, the lowest
>   	I/O priority class.
>   
> +  promote-to-rt
> +	For requests that have I/O priority class BE or that have I/O priority
> +        class IDLE, change it into RT. Do not modify the I/O priority class
> +        of requests that have priority class RT.

Please document whether or not this policy modifies the I/O priority
(IOPRIO_PRIO_DATA()). Do you agree that the I/O priority should be preserved
when promoting from BE to RT and that only the I/O priority class should be
modified for such promotions?

>   The following numerical values are associated with the I/O priority policies:
>   
> -+-------------+---+
> -| no-change   | 0 |
> -+-------------+---+
> -| none-to-rt  | 1 |
> -+-------------+---+
> -| rt-to-be    | 2 |
> -+-------------+---+
> -| all-to-idle | 3 |
> -+-------------+---+
> +
> ++---------------+---------+-----+
> +| policy        | inst    | num |
> ++---------------+---------+-----+
> +| no-change     | demote  | 0   |
> ++---------------+---------+-----+
> +| none-to-rt    | demote  | 1   |
> ++---------------+---------+-----+
> +| rt-to-be      | demote  | 2   |
> ++---------------+---------+-----+
> +| idle          | demote  | 3   |
> ++---------------+---------+-----+
> +| promote-to-rt | promote | 1   |
> ++---------------+---------+-----+

I prefer that this table is not modified. The numerical values associated with
policies only matters for none-to-rt, rt-to-be and all-to-idle but not for
promote-to-rt. So I don't think that it is necessary to mention a numerical
value for the promote-to-rt policy. Additionally, "none-to-rt" is not a policy
that demotes the I/O priority but a policy that may promote the I/O priority.

> +-- If the instruction is promotion, change the request I/O priority class
> +-  into the minimum of the I/O priority class policy number and the numerical
> +-  I/O priority class.

Using the minimum value seems wrong to me because that will change
IOPRIO_VALUE(IOPRIO_CLASS_RT, 1) into IOPRIO_VALUE(IOPRIO_CLASS_RT, 0).

Thanks,

Bart.
