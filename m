Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD95EEC5C
	for <lists+cgroups@lfdr.de>; Thu, 29 Sep 2022 05:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiI2DPT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Sep 2022 23:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiI2DPR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Sep 2022 23:15:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9BBE6A2C
        for <cgroups@vger.kernel.org>; Wed, 28 Sep 2022 20:15:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b75so278375pfb.7
        for <cgroups@vger.kernel.org>; Wed, 28 Sep 2022 20:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=PPw35s/6IrjE9k5D5RV/GouQK31w+teLLRYYyCLRYOk=;
        b=v5ylXiRj+RiZTaBClX9KpUMT2fBnX7kdGoacLHRQ05aBEkMC9mXBSLwUVHfIfV/elX
         0bL9oAQD3ekTU9lW8axHBGe68HH7uYYx2449jrqDNPJiZTTH/rNKgOBkGfz8p0UbQOKl
         BT3M9eRS4r2yAxFw9ncdp5TgcCuh7LMOsR/3x8LCBZB+20JFL1LeW0fvZ7mmX2YQ5X3d
         jodFIEaXLhIqnk286MMbQpdmtVzqC9Z1pmIUoj+4iENdT8uCfAqiBMW/IsJpUMpYBbO1
         FF5UZvwanPmMgfsyo3tz3kn13iEWzo7JL+nseGutfqUb/+i5vH75tox45oyupgvzEozl
         pZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=PPw35s/6IrjE9k5D5RV/GouQK31w+teLLRYYyCLRYOk=;
        b=xDggy1p5MZ7ORvzo2vIYwiO2ay+1BXQEqRZ2aX6OqlUl0FEbG9JW0HsyMxPzDsWs1+
         ORyUM5ns1bNtNIjq5nje2RlNTBGwM96pO7RiRwzgHdaqZxABk8Bm3t5JZelgIC85dkdD
         vuKUVf3ujpeahjE8NSjD+F98Ms2NXSzNwHQjo8V9YhFuYrzZ8bDvSvrCZJcFJGf4MoSP
         eYPokHb6YZ96RKLtHOwwbAWDNNkjOPXVRP4FDD4Ifthep7v3Aml6WgrkaZPKFmmaMJbQ
         yQJl7/Tkicmvh7b9BBtrr9D+rqy2rv2k2VyPWkL8pm302Pw34wvdG3SKN5n4FWlQl+ys
         AN8A==
X-Gm-Message-State: ACrzQf0Pr+kdG4a3aBUZzjdOF5k/amFNDARwJnS4uE+FBHe8mBzuyftA
        hQbztUMT4/JF0ZPWjCmai/HRrQ==
X-Google-Smtp-Source: AMsMyM5+mdugvTJsZfTCa69ObGYcnuzg1tXlm34Uz1ubbNN6jMZQH60mC3e2f+84vBtlSIZsbDkhPA==
X-Received: by 2002:a65:498d:0:b0:438:8287:6a43 with SMTP id r13-20020a65498d000000b0043882876a43mr940778pgs.495.1664421314460;
        Wed, 28 Sep 2022 20:15:14 -0700 (PDT)
Received: from [10.76.43.192] ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id i7-20020a170902c94700b001754064ac31sm4588128pla.280.2022.09.28.20.15.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 20:15:13 -0700 (PDT)
Message-ID: <19779c13-2db4-8273-8c7e-69fd51f5b71f@bytedance.com>
Date:   Thu, 29 Sep 2022 11:15:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: Re: [RFC PATCH v1] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220921064710.89663-1-ligang.bdlg@bytedance.com>
 <18621b07-256b-7da1-885a-c96dfc8244b6@google.com>
 <Yy1kAnvowZh4ViP4@dhcp22.suse.cz>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <Yy1kAnvowZh4ViP4@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022/9/23 15:45, Michal Hocko wrote:
> Yeah, that is possible and something to consider. One way to go about
> that is to make the selection from all cpusets with an overlap with the
> requested nodemask (probably with a preference to more constrained
> ones). In any case let's keep in mind that this is a mere heuristic. We
> just need to kill some process, it is not really feasible to aim for the
> best selection. We should just try to reduce the harm. Our exisiting
> cpuset based OOM is effectivelly random without any clear relation to
> cpusets so I would be open to experimenting in this area.

In addition to cpuset, users can also bind numa through mbind(). So I
want to manage numa binding applications that are not managed by cpuset.
Do you have any ideas?
