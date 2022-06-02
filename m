Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3ED53B132
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 03:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiFBAkz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Jun 2022 20:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiFBAky (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Jun 2022 20:40:54 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB7D235121
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 17:40:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n10so3488798pjh.5
        for <cgroups@vger.kernel.org>; Wed, 01 Jun 2022 17:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=bCg75JCW+pfC2cBeuVcFJREBBHmfucnS3ebVUyU/JTo=;
        b=nvakCz5XU4OHW+crILNG26v7+vQ2IiR6NULuMci2uYtam+NThJ/3HpJrQJFMfg8a14
         Mqux8+tlKQRiYmlV6wq6o/Bwvjv63JmaCKuMD3fu2InTMyQscdIpanE/tjFmLJSdihfc
         dDqfD112MsNKtlgnntpgBLaMJHKh/NnByZpxbkseO5IHgidWzXLN1ccFm7YnOHm20b2t
         hwTzKwFPdaBmu67/KqpRwxh2Mqk4Y2fxy8TM5+nNQPIAPg2Hz1YEZ1OvwuiauFRp3Ysv
         wI3HHcEptwZcEIO5D6eY3mbSIq99WSH/HnNAlvUFfeRLa9oTmyvDXpWIijtl+2tBRKgy
         FP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=bCg75JCW+pfC2cBeuVcFJREBBHmfucnS3ebVUyU/JTo=;
        b=Qbfm2/CWJZcEyBrMLAogFzfsSXtUMg0S8bzscy/vb76z5mGO+TgQVjFYcgEKIDXVxm
         HOEK9VKwus2J6IcBCwvi4D8CSxLZans7UZSUcBF9S+tAMBoRIqHItuL8VHmPIbETBf94
         DN2FC4XUp/Bm/iqLNO4w2qQUPbFBEQVVdOcqep7jpcnxXaW7i+iDyiYp+JvC3fXAjG25
         sR/HXEfxLxnE3adqcXLfLwnbRelonDQbBzLR40JhjtqTAXZ30g3hDNWeeczxME1z87KN
         YIUa8okrBfRYlCM7QAwUt3H6M5cqlvEXJTnyRp+6/bGQiqjO0qKrpOil/Eng3kVBt1kx
         3bew==
X-Gm-Message-State: AOAM5307I0GVRn5e9VrOaZK21BLyfkVHIkBmdt4HoI818nejQOlAoVb7
        GnX6B0/15kIi3CIPzUA3KhI5KQ==
X-Google-Smtp-Source: ABdhPJxkd62FRjm9zmFqVgDijdpENsQzD+qSxsY+7ENYNw+nWjcrnF7ib5hts50aNXdDVDhwdVYL3Q==
X-Received: by 2002:a17:902:9349:b0:158:a6f7:e280 with SMTP id g9-20020a170902934900b00158a6f7e280mr2060476plp.155.1654130452700;
        Wed, 01 Jun 2022 17:40:52 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902650500b0015e8d4eb23asm2144288plk.132.2022.06.01.17.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 17:40:52 -0700 (PDT)
Message-ID: <0fd1c3fd-fa86-dbed-f3f0-74c91b1efa11@linaro.org>
Date:   Wed, 1 Jun 2022 17:40:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
References: <20220525161455.GA16134@blackbody.suse.cz>
 <Yo7KfEOz92kS2z5Y@blackbook> <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
 <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
 <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
 <c3bd8e63-7204-f86d-8efa-254db71185fc@linaro.org>
 <Ypf/MpwzByOrSp6A@slm.duckdns.org>
 <416dc60a-f0e5-7d05-1613-3cd0ca415768@linaro.org>
 <YpgEY/lJbLidLOhc@slm.duckdns.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
In-Reply-To: <YpgEY/lJbLidLOhc@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 6/1/22 17:29, Tejun Heo wrote:
> On Wed, Jun 01, 2022 at 05:26:34PM -0700, Tadeusz Struk wrote:
>> Ok the problem is that
>>
>> 1. kill_css() triggers css_killed_ref_fn(), which enqueues &css->destroy_work on cgroup_destroy_wq
>> 2. Last put_css() calls css_release(), which enqueues &css->destroy_work on cgroup_destroy_wq
>>
>> We have two instances of the same work struct enqueued on the same WQ (cgroup_destroy_wq),
>> which causes "BUG: corrupted list in insert_work"
> 
> #2 shouldn't be happening before kill_ref_fn() is done with the css. If what
> you're saying is happening, what's broken is the fact that the refcnt is
> reaching 0 prematurely.

css_killed_ref_fn() will be called regardless of the value of refcnt (via percpu_ref_kill_and_confirm())
and it will only enqueue the css_killed_work_fn() to be called later.
Then css_put()->css_release() will be called before the css_killed_work_fn() will even
get a chance to run, and it will also *only* enqueue css_release_work_fn() to be called later.
The problem happens on the second enqueue. So there need to be something in place that
will make sure that css_killed_work_fn() is done before css_release() can enqueue
the second job. Does it sound right?
  
>> So I think the easiest way to solve this would be to have two separate work_structs,
>> one for the killed_ref path and css_release path as in:
> 
> If you do that, you'd just be racing the free path against the kill path and
> the css might get freed while the kill path is still accessing it.
> 
> Thanks.
> 


-- 
Thanks,
Tadeusz
