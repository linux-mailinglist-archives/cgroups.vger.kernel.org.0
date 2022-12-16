Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251C264EB6C
	for <lists+cgroups@lfdr.de>; Fri, 16 Dec 2022 13:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiLPM2c (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Dec 2022 07:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLPM2c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Dec 2022 07:28:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E2AE012;
        Fri, 16 Dec 2022 04:28:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2207146pjo.3;
        Fri, 16 Dec 2022 04:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XN2BUIyyxfcPTn0lH7csIpbvsG2W/DIuROkPMqaCcZA=;
        b=gTmjQHIthgTaarmTiJIFcOmKO18lOJx70K41j/h8aKXjh6KsuWGEkZFj33q3evneNQ
         Z2aOHDpL36LFgscqFBHNKzMVJ9mYIx0ZAod72hmvUaLZsAbM7hZrGu12f8gqDapCACMi
         41FVVH0qwRa4z0G6jmKXty6+LfGNMpKKDSTCYx8cJ/m33BMfthqrsxXH+AzoxBx8M9Yn
         C/3DIhGswmw+wRwrjR6uyzMYIeKhpQu3fKP+73cPXx9rO1TkIqOY+++ZfmE+EG9Mnlfb
         Id6KF6Rn3DAwHZhYd2fmrXGE5W6ntZV+znP4hk8sgPNWBl6FZtqOqmGU/m0AG/lTtkaW
         KYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XN2BUIyyxfcPTn0lH7csIpbvsG2W/DIuROkPMqaCcZA=;
        b=DVtf9Z2cDJFg1MTn+t/jDHGflkgVNdxRLnYreDEx+a5EzvdBsZy9pm/BfC2J19YVdt
         BCwWCDXGBOqSqVt4QYdS/apmd++L4fE9woFzKOx2dAv7f5pvYVUA2t/GE8qE+sC7t14l
         y3m3IAUylbQgGJ0OGiVPv9Q6YbvsWp5usB0Uzt1Lm2qEWvBp78UZCCqoUSWUgq+XC+Km
         dukP4kmAw3JIRp+cvaqpNcp2Zml6FOCgYVBk7bFmd8Yfc7Kq2euljIHn/AXuvAAbwp4s
         rE4ndqDqx0ch/WYSpU83Rpagce38xpPY/kTAZlUUSREbeQCSrp8hM5mWwrwLMs6VTz0D
         /54w==
X-Gm-Message-State: ANoB5pkDJNcUfTFmG09irURIPsR0qD3xiwIJs9A2e4veytzXhETOmZU2
        OWJrh1c/8GxOotyVF22GxOc=
X-Google-Smtp-Source: AA0mqf6d7oqZU2G/xjT5P7wiQ6Ao9vsN4Z35ejH9yc72sa2sgRGO8RLbwwQKenbvXgNM8+nnx4ulRg==
X-Received: by 2002:a17:902:e285:b0:189:fd83:eb80 with SMTP id o5-20020a170902e28500b00189fd83eb80mr30939639plc.62.1671193710453;
        Fri, 16 Dec 2022 04:28:30 -0800 (PST)
Received: from [192.168.43.80] (subs32-116-206-28-27.three.co.id. [116.206.28.27])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b00189847cd4acsm1474100pla.237.2022.12.16.04.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:28:30 -0800 (PST)
Message-ID: <85f627d5-7572-1fc7-db1f-bc1337767a68@gmail.com>
Date:   Fri, 16 Dec 2022 19:28:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Revert "mm: add nodes= arg to memory.reclaim"
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20221202223533.1785418-1-almasrymina@google.com>
 <Y5bsmpCyeryu3Zz1@dhcp22.suse.cz> <Y5xASNe1x8cusiTx@dhcp22.suse.cz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y5xASNe1x8cusiTx@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/16/22 16:54, Michal Hocko wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index c8ae7c897f14..74cec76be9f2 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1245,13 +1245,17 @@ PAGE_SIZE multiple when read back.
>  	This is a simple interface to trigger memory reclaim in the
>  	target cgroup.
>  
> -	This file accepts a string which contains the number of bytes to
> -	reclaim.
> +	This file accepts a single key, the number of bytes to reclaim.
> +	No nested keys are currently supported.
>  
>  	Example::
>  
>  	  echo "1G" > memory.reclaim
>  
> +	The interface can be later extended with nested keys to
> +	configure the reclaim behavior. For example, specify the
> +	type of memory to reclaim from (anon, file, ..).
> +
>  	Please note that the kernel can over or under reclaim from
>  	the target cgroup. If less bytes are reclaimed than the
>  	specified amount, -EAGAIN is returned.
> @@ -1263,13 +1267,6 @@ PAGE_SIZE multiple when read back.
>  	This means that the networking layer will not adapt based on
>  	reclaim induced by memory.reclaim.
>  
> -	This file also allows the user to specify the nodes to reclaim from,
> -	via the 'nodes=' key, for example::
> -
> -	  echo "1G nodes=0,1" > memory.reclaim
> -
> -	The above instructs the kernel to reclaim memory from nodes 0,1.
> -
>    memory.peak
>  	A read-only single value file which exists on non-root
>  	cgroups.

Ah! I forgot to add my Reviewed-by: tag when the original patch was
submitted. However, I was Cc'ed the revert presumably due to Cc: tag in the
original.

In any case, for the documentation part:

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

