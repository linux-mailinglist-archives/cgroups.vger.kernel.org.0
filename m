Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF1153660F
	for <lists+cgroups@lfdr.de>; Fri, 27 May 2022 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347304AbiE0QjX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 27 May 2022 12:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245083AbiE0QjW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 27 May 2022 12:39:22 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347AAB0CD
        for <cgroups@vger.kernel.org>; Fri, 27 May 2022 09:39:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so4586423plg.5
        for <cgroups@vger.kernel.org>; Fri, 27 May 2022 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=jeA4ER8KbBHKcyc+TaHYMfBnKpuDxMWJ6quO+9dHOWE=;
        b=NSLHsjgjrWqwX/1FYyNqbRe5eG4yejZ3h0d0GNRHAthad8+JrxNe0WwprdS58sHjLG
         +DFIEYNpeUJHV1+de7IN6+6hqCPJvHZpAzT/KyT4Uzzs40+wPILx3PmuZDo3ZE7laNTS
         cwg6C2WrHXDx3w7d9mw/XHohR5XWW2bqpm59bOC9y2hMyncS06X7fS/n/NsOeOA+Auc9
         yWGy/DpZq9uCpNRVlldmo3BHO8pSLPlvYA2RE6DnbPWcNLlS8+5yHlyGWpFiLVxCzD0r
         PuYmyh6SzT4L9DJ+6NrhKH9xQH8MHTACWPpile6TcTNUhr0PsJUw3REwgEWUWiHDp7J3
         0CGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jeA4ER8KbBHKcyc+TaHYMfBnKpuDxMWJ6quO+9dHOWE=;
        b=raH2gt/yY2r7OQJHnvYlg7HvDRuEb1gr94Kz5y6yBjkCYI+mDuI/2T/4SNIk5/rw5W
         VYcnyBWWOcYqxXR3YqY1kl3r1Iy1RlALYwZjb9yL4kRuJFa/WUoIFkdgIWlXbrnJil/d
         VQ+xupTbX73kQ6xowxwVQJKdoy4OHQvt8ehE2GfffWv3rpwJ7XSqe18JjzZyV96A/RBn
         vU7h4PaH5K1rfc6aI3X5eaclwGSivzZNhWOAx7M3WHneJ9FTatr1r6ejPBnw2xZdJca4
         7rMbZYKwTo784oU20dpQMEuyKdOOdoN+P6Cd40VOfchTU31N8r5qrhAvuAUAORA9Vj5F
         45CQ==
X-Gm-Message-State: AOAM533P0y9gCrQtQhHZ/eIbjfneluNx32YTE1Ejy3kOcEav1QSQ/zKV
        p3tCXojvYVNP1rENJUeOQkA7PA==
X-Google-Smtp-Source: ABdhPJyi69Ad1o5E56g2U1o6Hglm4gMSgHsPyLve6/Bw61JoUcE1Pxr/YAer+BxdWsnzdIzVwEuFOQ==
X-Received: by 2002:a17:90a:8807:b0:1df:78c7:c215 with SMTP id s7-20020a17090a880700b001df78c7c215mr9138624pjn.234.1653669561546;
        Fri, 27 May 2022 09:39:21 -0700 (PDT)
Received: from [192.168.254.17] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id z1-20020aa79481000000b0051812f8faa3sm3697788pfk.184.2022.05.27.09.39.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 09:39:21 -0700 (PDT)
Message-ID: <904ef8af-13a5-e566-b760-74519f70fa62@linaro.org>
Date:   Fri, 27 May 2022 09:39:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz> <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
In-Reply-To: <Yo/DtjEU/kYr190u@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 5/26/22 11:15, Tejun Heo wrote:
> Hello, Michal.
> 
> On Thu, May 26, 2022 at 11:56:34AM +0200, Michal Koutný wrote:
>> // ref=A: initial state
>> kill_css()
>>    css_get // ref+=F == A+F: fuse
>>    percpu_ref_kill_and_confirm
>>      __percpu_ref_switch_to_atomic
>>        percpu_ref_get
>>          // ref += 1 == A+F+1: atomic mode, self-protection
>>      percpu_ref_put
>>        // ref -= 1 == A+F: kill the base reference
>>    [via rcu]
>>    percpu_ref_switch_to_atomic_rcu
>>      percpu_ref_call_confirm_rcu
>>        css_killed_ref_fn == refcnt.confirm_switch
>>          queue_work(css->destroy_work)        (1)
>>                                                       [via css->destroy_work]
>>                                                       css_killed_work_fn == wq.func
>>                                                         offline_css() // needs fuse
>>                                                         css_put // ref -= F == A: de-fuse
>>        percpu_ref_put
>>          // ref -= 1 == A-1: remove self-protection
>>          css_release                                   // A <= 1 -> 2nd queue_work explodes!
> 
> I'm not sure I'm following it but it's perfectly fine to re-use the work
> item at this point. The work item actually can be re-cycled from the very
> beginning of the work function. The only thing we need to make sure is that
> we don't css_put() prematurely to avoid it being freed while we're using it.
> 
> For the sharing to be a problem, we should be queueing the release work item
> while the destroy instance is still pending, and if that is the case, it
> doesn't really matter whether we use two separate work items or not. We're
> already broken and would just be shifting the problem to explode elsewhere.
> 
> The only possibility that I can think of is that somehow we're ending up
> with an extra css_put() somewhere thus triggering the release path
> prematurely. If that's the case, we'll prolly need to trace get/puts to find
> out who's causing the ref imbalance.

Hi Michal,
As far as I can see we are trying to test the same thing suggested by Tejun.
I just sent a test request to try this:
https://github.com/tstruk/linux/commit/master

Let me know if you have any more tests to run and I will hold off until
you are done.

-- 
Thanks,
Tadeusz
