Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA324B6BBC
	for <lists+cgroups@lfdr.de>; Tue, 15 Feb 2022 13:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiBOMKV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Feb 2022 07:10:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiBOMKV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Feb 2022 07:10:21 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A4CF68EA
        for <cgroups@vger.kernel.org>; Tue, 15 Feb 2022 04:10:10 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id f6so13545244pfj.11
        for <cgroups@vger.kernel.org>; Tue, 15 Feb 2022 04:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Rvc5VFNuQvOUoAjdswhh5nR82Ho+mPvuJf8m7WDO3Qs=;
        b=xtE/ytqcCPY1yN5pIplQeeZomXpKV5da0WHr6CnDmO4fmr9rg8Zr9b3UABGLxx8V3u
         NDNsNtiv5jxI1QCHK7eI3QQKYPuOnQoFIk7qgfFewZ7YvL7MNyQAmr7w1JwmKQxwcAiw
         GJwoOrkN7OZ4C4IKmVNpoSCOB3apeP2UORrDJRJa1/lkq5lBbX+pSCaIM1fIYLOQep5i
         OdNRbnYd+Qc74cE8kHsyBYQNbsumy3whUl0KtR/KQb+tWGWQJ5FrYimIpbZejLR/Gefh
         cLpIHXyY/a5xV3XSh9/zfHngVTYXBqsFWdxKHGGF409sAG6RXss20rkdj+DIkw7G2Hld
         tGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Rvc5VFNuQvOUoAjdswhh5nR82Ho+mPvuJf8m7WDO3Qs=;
        b=0KUS7HuH6PLYbbUJCBsrhtk6uSm4ZM6u8ct7znnwZTY7qQ9oFP9n+Iu9n8NbkaZp4A
         8ir6WI0Cubo44G7s6Ex8iaGN5lsdSI9QohsKGlmGvR1NmCpsYV3hrein3J+lS0OGc+8U
         6NrpGTjdfVsMCq/FoR5w7S85AFZPxVDzXCiyXeCyz2OzRqEDOxTg7yRMbQb6kMij+7TF
         2jNqoYkboqrGb+sOMXkGMdKUri77TBVuIoLNqeucBBisAhDuy57ZJbqGfGPNS4JiXoan
         fkgArpr2XJxD8Y00brcFSzKbEDwjtXRoA6sad8E0YT2fcxQL42h+QLnqB63aV4fjILj5
         ig1w==
X-Gm-Message-State: AOAM532ohxnviWDAFJW5z0lCQ1+U/LQhLBdN6Osmhq7wO1qNG6htT85g
        KGVbSd4OG3Lpa2NEx17b0VrKQA==
X-Google-Smtp-Source: ABdhPJyywc6pxdHcOr/YlYI/BiLGm6yw8O3kIJaImkJ35VKGI9WA1zODQyKYxzF/X12TQesyAppR4Q==
X-Received: by 2002:aa7:88d1:: with SMTP id k17mr3619040pff.38.1644927010288;
        Tue, 15 Feb 2022 04:10:10 -0800 (PST)
Received: from [10.255.13.118] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id h9sm41137904pfi.124.2022.02.15.04.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 04:10:09 -0800 (PST)
Message-ID: <c4b3b8c3-890a-59d1-623a-3341abcf290e@bytedance.com>
Date:   Tue, 15 Feb 2022 20:10:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [Phishing Risk] [External] Re: [PATCH] blk-cgroup: set blkg
 iostat after percpu stat aggregation
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, boris@bur.io, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220213085902.88884-1-zhouchengming@bytedance.com>
 <Ygqmjsbu96+UZDw+@slm.duckdns.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <Ygqmjsbu96+UZDw+@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/2/15 2:59 上午, Tejun Heo wrote:
> On Sun, Feb 13, 2022 at 04:59:02PM +0800, Chengming Zhou wrote:
>> Don't need to do blkg_iostat_set for top blkg iostat on each CPU,
>> so move it after percpu stat aggregation.
>>
>> Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup
>> io.stat")
> 
> I'm not sure Fixes tag is necessary here.

I'm also not sure, since the io.stat reports correct data after all. I put
the Fixes tag here in case someone wants it. Please feel free to delete it.

Thanks.

> 
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> 
> but other than that,
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Thanks.
> 
