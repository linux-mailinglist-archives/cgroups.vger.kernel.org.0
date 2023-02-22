Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2095C69EF75
	for <lists+cgroups@lfdr.de>; Wed, 22 Feb 2023 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjBVHiJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 02:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjBVHiJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 02:38:09 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8F031E1D;
        Tue, 21 Feb 2023 23:38:07 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id nt5-20020a17090b248500b00237161e33f4so5487305pjb.4;
        Tue, 21 Feb 2023 23:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQnhk4w+A1CZuSiFNzZYnpV69X8Dsuspy9qsHPKjTI0=;
        b=kgMH6/tfuXU3Gt2XMp21OuwvVA7LLi2oGBFlBP4ahaNQCsd817zZxxjh4mmlcyGvAj
         74AoHp4DwwrMqH84r7BaW1B5YjzjPwgl5Lqc5kp3BY+TJMmpy22BB1GiBDCLUoW0DLaD
         lH0rIPkmqTCJ8UVbVqQrNVrQvnT9soVkZ9Wol5REsAUZesfvlxpnMO/cY1oAAGHLRkTS
         6ixharSxG0r0hXm7NVnsOZLiF+2X/nH7PYpG+RemZ7+HrHLZIwvVxop0E1tSlEDDa8UI
         cGCbTsjy4lmO8cPMpSI3iN+CTPnPugV5b2m03N3L/ujetT9wDtOE6OTtlhDG5NoGtav6
         yZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQnhk4w+A1CZuSiFNzZYnpV69X8Dsuspy9qsHPKjTI0=;
        b=teMmgQEtBHR35ppLNdZgCroI71RLLqe3l6qgVOHVlP1EIcQ7QIbDOYVJpxJNP9RAnc
         BRE61D4Ve8Y23znqlJN6axh8ZN3CJYpklzaG8Al+qCb21EMFxYrLHVEsgmCPes3g5zMc
         JvoSR7W49dlxJycxBZWoFELqTXC5lXZSk3hYcqLy0GKKkRn2X4tu3RcuCaqZM4zwL7jZ
         8OixL8T4+ZpOCuHEaRVMnUO+j/Fz50u7akB/ZvV+ra3zL/B2OBv0ga+/FlISZujD3axM
         x3G2r/Uqu6bYRW1bnYH9Z4yF5dMQVQHsKdbOPa17KMw59i/51u8ZAWI8XpRu0XvNhCd2
         0Jog==
X-Gm-Message-State: AO0yUKVRUlMx3mfXu8wkMOAyuG60zV2UnqR8rgPWYbXETJjlgczb2Y2k
        GGPewTHPP2NjEW2py5RxROc=
X-Google-Smtp-Source: AK7set9BPJiiiPA0ZWH3kfJoeUKXA2xqAuB/5VgGXoQcSKWcONnqYOqfJi5snvsOHG7lUNiCqyEK0A==
X-Received: by 2002:a17:902:eccc:b0:19a:fdc9:7983 with SMTP id a12-20020a170902eccc00b0019afdc97983mr7640085plh.63.1677051487089;
        Tue, 21 Feb 2023 23:38:07 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id g12-20020a1709026b4c00b001992b8cf89bsm1182987plt.16.2023.02.21.23.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 23:38:06 -0800 (PST)
Message-ID: <5ff2b68a-a8fb-7901-2c38-1056a2c59f70@gmail.com>
Date:   Wed, 22 Feb 2023 14:38:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] blk-ioprio: Introduce promote-to-rt policy
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, houtao1@huawei.com
References: <20230220135428.2632906-1-houtao@huaweicloud.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230220135428.2632906-1-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2/20/23 20:54, Hou Tao wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 74cec76be9f2..ccfb9fdfbc16 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2021,31 +2021,33 @@ that attribute:
>    no-change
>  	Do not modify the I/O priority class.
>  
> -  none-to-rt
> -	For requests that do not have an I/O priority class (NONE),
> -	change the I/O priority class into RT. Do not modify
> -	the I/O priority class of other requests.
> +  promote-to-rt
> +	For requests that have a no-RT I/O priority class, change it into RT.
"non-RT" maybe? Or the original wording is better?
> +	Also change the priority level of these requests to 4. Do not modify
> +	the I/O priority of requests that have priority class RT.>  
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
> @@ -2061,9 +2063,13 @@ The numerical value that corresponds to each I/O priority class is as follows:
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

The rest is LGTM.

-- 
An old man doll... just what I always wanted! - Clara

