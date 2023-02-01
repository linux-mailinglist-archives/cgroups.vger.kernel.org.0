Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A56686D22
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 18:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjBAReZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 12:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBAReS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 12:34:18 -0500
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049E168AEC;
        Wed,  1 Feb 2023 09:33:51 -0800 (PST)
Received: by mail-pj1-f41.google.com with SMTP id l4-20020a17090a850400b0023013402671so2930231pjn.5;
        Wed, 01 Feb 2023 09:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/aU7Sx+Q2q+ijznzRLc/zl8vln97T87YSV2SvjpCmw=;
        b=NoLXqe8+25lyX9nERFHTPag0M6UHjxIp4pH9S6XXo4J/pLBSPPoXYdZ1tlZvvxHZ7l
         qaMqpUDbWB2cxw2FdJV0y0kMpsCKgWQ7BQ6F1Umhvk5HkQdDT25K2zGWl+haHBk3H8zO
         /t38FsEYCbbG22gLfXFtuWBX8WXgsVONrLHmwayiAqS0Z+fP69xpLRxnKm/vRccOBrVI
         PsUofoIJ5qICtoxPEKxrxEqGlR4UTIBaZ+3mkOc3Cdn0lGpIgbzl9h6v6zxOzfuCrWH4
         WKtTEqDvzxAX+mOGAmA9mBsSA6B4hTeRTH7OfkyBN9sVt0ikhF4NJ9CNvTo+iSQDLFng
         c8Qw==
X-Gm-Message-State: AO0yUKVbTOnIDxAkx4AIIP2os1ja6HCjbqTOH3NmRFxAybxPMRCCH2gL
        v0zvIQKTlRPPj3rN/6iTSblHycF9LKQ=
X-Google-Smtp-Source: AK7set9Ycqux29N2wsB31xcfCQChDuOZNpbLrXNTTh/WzZIVKAYDMFTzZ4Xw5aYXc54sZ606NodI2Q==
X-Received: by 2002:a17:903:cd:b0:195:f097:d65b with SMTP id x13-20020a17090300cd00b00195f097d65bmr12801187plc.49.1675272807088;
        Wed, 01 Feb 2023 09:33:27 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:f3cf:17ca:687:af15? ([2620:15c:211:201:f3cf:17ca:687:af15])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709026b8100b00192b23b8451sm12005700plk.108.2023.02.01.09.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 09:33:26 -0800 (PST)
Message-ID: <8c068af3-7199-11cf-5c69-a523c7c22d9a@acm.org>
Date:   Wed, 1 Feb 2023 09:33:24 -0800
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
>   /**
>    * enum prio_policy - I/O priority class policy.
>    * @POLICY_NO_CHANGE: (default) do not modify the I/O priority class.
> @@ -27,21 +34,30 @@
>    * @POLICY_RESTRICT_TO_BE: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_RT into
>    *		IOPRIO_CLASS_BE.
>    * @POLICY_ALL_TO_IDLE: change the I/O priority class into IOPRIO_CLASS_IDLE.
> - *
> + * @POLICY_PROMOTE_TO_RT: modify IOPRIO_CLASS_NONE and IOPRIO_CLASS_BE into
> + * 		IOPRIO_CLASS_RT.
>    * See also <linux/ioprio.h>.
>    */
>   enum prio_policy {
> -	POLICY_NO_CHANGE	= 0,
> -	POLICY_NONE_TO_RT	= 1,
> -	POLICY_RESTRICT_TO_BE	= 2,
> -	POLICY_ALL_TO_IDLE	= 3,
> +	POLICY_NO_CHANGE	= IOPRIO_CLASS_NONE,
> +	POLICY_NONE_TO_RT	= IOPRIO_CLASS_RT,
> +	POLICY_RESTRICT_TO_BE	= IOPRIO_CLASS_BE,
> +	POLICY_ALL_TO_IDLE	= IOPRIO_CLASS_IDLE,
> +	POLICY_PROMOTE_TO_RT	= IOPRIO_CLASS_RT | IOPRIO_POL_PROMOTION,
> +};

The above change complicates the ioprio code. Additionally, I'm 
concerned that it makes the ioprio code slower. Has it been considered 
to keep the numerical values for the existing policies, to assign the 
number 4 to POLICY_PROMOTE_TO_RT and to use a lookup-array in 
blkcg_set_ioprio() to convert the policy number into an IOPRIO_CLASS value?

Thanks,

Bart.

