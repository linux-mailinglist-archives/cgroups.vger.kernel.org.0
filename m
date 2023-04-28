Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086006F1273
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 09:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbjD1HgX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Apr 2023 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345179AbjD1HgV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Apr 2023 03:36:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5822701;
        Fri, 28 Apr 2023 00:36:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a677dffb37so77547445ad.2;
        Fri, 28 Apr 2023 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682667379; x=1685259379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4T9X6ORTgiJIhVcjeFoQF4kfGQPAh+aPhJ9TCOLtx4=;
        b=gTkMq43ck648y6RXcRGmriNhxjIOInPfKt5o9jPe9LMJ3iz00MefD9rJqTbBvvgyoE
         n+YGdtHh9a37pUY7eFw4CB/nD1D3437E2uZD/SRcEaKHSghT3u7OufYEJmPsnIlmBVHb
         p6VDeiJIpWJ6f37+X2fopxRBcna17GK/b+ymsPcLVyv7yZ2cAfOmnC6VHLvfZ/6XebZY
         hQ0zkF8NMjv+pmrpO6wx+qAS/A0tvdSo8SrZMcOiZxZaF6FGxDBXxzSUfBBxfN4MvuHC
         D5KmyFkVJHu07yYZwCnG36VzBr4mK+BQogBKOP8A4lm3amFn6dwayw9KhWFDrGn5SUh5
         x3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682667379; x=1685259379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r4T9X6ORTgiJIhVcjeFoQF4kfGQPAh+aPhJ9TCOLtx4=;
        b=jY1iSrUKJOStacwZZfQG8yCTYCIdV06QOJhWbJpdlqNi2S5fEfe0/azZ8qVfdDBAE6
         Z2+VyZXFYpzbXNx9TWZD3oP7wXKL3CMdG4iu7t3df1hZ9G5rdxCf2AKbXd5dzg0lzEIn
         sJwxIw7VIMF1WG8vxFIeW/9hqKvuLfUR1E3y1n7E9J+iw0C3P7u8M1kqCPP45z/1FNIN
         69HCbP5PqgvJ3pyRKoQUmTCzStklv1do/nw/meaq2j9mzICMFg72ICDO45W7v4BXs+dX
         fSDlfREdGJvpMlna25NhyWZ2QxWIWlor6mtGvgHTRxqV9ziRtAD2zhY94i1wgKXuKqcs
         QwEw==
X-Gm-Message-State: AC+VfDwgdr/TgJobfe3ZR+y7jdFX/SEDqKy+1cXSVsOkdjKmojRWrkgv
        ZzkKKsvTDmMs82uMxQ4jUO0=
X-Google-Smtp-Source: ACHHUZ60fKWLEIqyAWAnKeWdOP4G0oY86AfBkmNu1uZtkYt7SeEF7oCuxi56kt2NKqeyahklw8TmVw==
X-Received: by 2002:a17:902:e849:b0:1a9:5674:282e with SMTP id t9-20020a170902e84900b001a95674282emr4744876plg.14.1682667379021;
        Fri, 28 Apr 2023 00:36:19 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id t5-20020a170902a5c500b001a4fecf79e4sm12713524plq.49.2023.04.28.00.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 00:36:18 -0700 (PDT)
Message-ID: <ab90dcf6-5861-48dc-f261-d6851e150863@gmail.com>
Date:   Fri, 28 Apr 2023 14:36:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4] blk-ioprio: Introduce promote-to-rt policy
To:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Chaitanya Kulkarni <kch@nvidia.com>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230428074404.280532-1-houtao@huaweicloud.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230428074404.280532-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/28/23 14:44, Hou Tao wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index f67c0829350b..7544ce00e0cb 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2024,31 +2024,33 @@ that attribute:
>    no-change
>  	Do not modify the I/O priority class.
>  
> -  none-to-rt
> -	For requests that do not have an I/O priority class (NONE),
> -	change the I/O priority class into RT. Do not modify
> -	the I/O priority class of other requests.
> +  promote-to-rt
> +	For requests that have a non-RT I/O priority class, change it into RT.
> +	Also change the priority level of these requests to 4. Do not modify
> +	the I/O priority of requests that have priority class RT.
>  
>    restrict-to-be
>  	For requests that do not have an I/O priority class or that have I/O
> -	priority class RT, change it into BE. Do not modify the I/O priority
> -	class of requests that have priority class IDLE.
> +	priority class RT, change it into BE. Also change the priority level
> +	of these requests to 0. Do not modify the I/O priority class of
> +	requests that have priority class IDLE.
>  
>    idle
>  	Change the I/O priority class of all requests into IDLE, the lowest
>  	I/O priority class.
>  
> +  none-to-rt
> +	Deprecated. Just an alias for promote-to-rt.
> +
>  The following numerical values are associated with the I/O priority policies:
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
> ++----------------+---+
> +| no-change      | 0 |
> ++----------------+---+
> +| rt-to-be       | 2 |
> ++----------------+---+
> +| all-to-idle    | 3 |
> ++----------------+---+
>  
>  The numerical value that corresponds to each I/O priority class is as follows:
>  
> @@ -2064,9 +2066,13 @@ The numerical value that corresponds to each I/O priority class is as follows:
>  
>  The algorithm to set the I/O priority class for a request is as follows:
>  
> -- Translate the I/O priority class policy into a number.
> -- Change the request I/O priority class into the maximum of the I/O priority
> -  class policy number and the numerical I/O priority class.
> +- If I/O priority class policy is promote-to-rt, change the request I/O
> +  priority class to IOPRIO_CLASS_RT and change the request I/O priority
> +  level to 4.
> +- If I/O priorityt class is not promote-to-rt, translate the I/O priority
> +  class policy into a number, then change the request I/O priority class
> +  into the maximum of the I/O priority class policy number and the numerical
> +  I/O priority class.
>  
>  PID
>  ---

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

