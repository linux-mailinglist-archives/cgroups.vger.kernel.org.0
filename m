Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7617C5E8691
	for <lists+cgroups@lfdr.de>; Sat, 24 Sep 2022 02:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIXALc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 23 Sep 2022 20:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiIXALM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 23 Sep 2022 20:11:12 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1B110FF4;
        Fri, 23 Sep 2022 17:09:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fs14so1408742pjb.5;
        Fri, 23 Sep 2022 17:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Wy0ZAB6jF2RLgatMO2ipKaVR//CFOKWia2M42iS8znI=;
        b=W/98zSk0vPJr1V+ETrctpZlkYfX/A44q9wVPlqgd55ybOj8kIlIFNDYejFhI77ChF3
         O3Bbe91Wnb0tZqQMGQIPhd0Sa3s0DUL4r/5ZQPC+rXJjDO9Q5nqyYRSNcwiPQxzwFuEY
         Y2UuAYQ07iS94QLQT0m8YE2JMfgT9Ixf9svmaHi/BKPC3+amGR0ST/KP5QBXQ20tGhgg
         la5VjOzrJ9yhXwgUHmwFijNtjo8+kN7f+GbnlgbTjbutwchsa+aOSyOnhP/9eu5szQDr
         nI4TiX2A5FzM8+Q7Ayibh1GD/sldGc2vCqzYBeU8x53tQncGxvt9drOp6QBDAr9wVvnS
         rqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wy0ZAB6jF2RLgatMO2ipKaVR//CFOKWia2M42iS8znI=;
        b=6iqBpgsIBxbzY2214lEtVHHnMsfnqSMAIQKx+XFVPK8mIXXxe7M7aKz2Wazk4ziNVM
         eWIZ1xeRD6kJ+5+CZwRlza0QyxBmSJ9xYj6Y6FtSeAxLp+ryUMT7gkEZdoNvOnH5i/e7
         v/Dh0I5AnRM1kmE+6q0o6LSvFUfcCOTydKFXlJMNmMuKqLgaWkT+qM1l8GbKv4ntf5ew
         N+3Jv+uO9tr9cGuqWIFVZfe3jQNTmlpvkU2GXX1CUKYBUyiF+6K6Iv1Quk2YOEn2jjQv
         sr2cTWnIrQp+6AHZ+eRJCCrcuBZ9MqrIYADT3LTfGZSdBP5oRiEnjMm2f9MCY2+Eytd3
         TWwg==
X-Gm-Message-State: ACrzQf2eP2ZrwiRnvOF6hKD0R3kn0nnAp8OuwcdpXfzt8CmhcR6zI9VU
        wJNaBG9fnYPNC0M3u0eCu2k=
X-Google-Smtp-Source: AMsMyM65YYdlW2MKPfRWZgKby/urX4EoVy0wZEoLJ3Udyhk0jf2Mu3O7Tt7gSuEYp2NI2WLHfNqZtw==
X-Received: by 2002:a17:90a:4f4f:b0:202:7ab1:46ec with SMTP id w15-20020a17090a4f4f00b002027ab146ecmr12470877pjl.32.1663978180682;
        Fri, 23 Sep 2022 17:09:40 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 143-20020a621695000000b0052d2b55be32sm7153459pfw.171.2022.09.23.17.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 17:09:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 23 Sep 2022 14:09:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RFC PATCH 00/20] Add Cgroup support for SGX EPC memory
Message-ID: <Yy5KwnRTbFjmKE9X@slm.duckdns.org>
References: <20220922171057.1236139-1-kristen@linux.intel.com>
 <YyyeSVSk/lWdo/W4@slm.duckdns.org>
 <4b8605533e5deade739249bfb341ab9c06d56a1e.camel@linux.intel.com>
 <YyyykUJQtYbPVctn@slm.duckdns.org>
 <7ff6d114-a6cc-e3c5-5edb-8ac0e527d8a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff6d114-a6cc-e3c5-5edb-8ac0e527d8a9@intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Sep 22, 2022 at 02:03:52PM -0700, Dave Hansen wrote:
> On 9/22/22 12:08, Tejun Heo wrote:
> > Can you please give more concrete examples? I'd love to hear how the SGX EPC
> > memory is typically used in what amounts and what's the performance
> > implications when they get reclaimed and so on. ie. Please describe a
> > realistic usage scenario of contention with sufficient details on how the
> > system is set up, what the applications are using the SGX EPC memory for and
> > how much, how the contention on memory affects the users and so on.
> 
> One wrinkle is that the apps that use SGX EPC memory are *normal* apps.
>  There are frameworks that some folks are very excited about that allow
> you to run mostly unmodified app stacks inside SGX.  For example:
> 
> 	https://github.com/gramineproject/graphene
> 
> In fact, Gramine users are the troublesome ones for overcommit.  Most
> explicitly-written SGX applications are quite austere in their SGX
> memory use; they're probably never going to see overcommit.  These
> Gramine-wrapped apps are (relative) pigs.  They've been the ones finding
> bugs in the existing SGX overcommit code.
> 
> So, where does all the SGX memory go?  It's the usual suspects:
> memcached and redis. ;)

Hey, so, I'm a bit weary that this doesn't seem to have a strong demand at
this point. When there's clear shared demand, I usually hear from multiple
parties about their use cases and the practical problems they're trying to
solve and so on. This, at least to me, seems primarily driven by producers
than consumers.

There's nothing wrong with projecting future usages and jumping ahead the
curve but there's a balance to hit, and going full-on memcg-style controller
with three control knobs seems to be jumping the gun and may create
commitments which we end up looking back on with a bit of regret.

Given that, how about this? We can easily add the functionality of .max
through the misc controller. Add a new key there, trycharge when allocating
new memory, if fails, try reclaim and then fail allocation if reclaim fails
hard enough. I belive that should give at least a reasonable place to start
especially given that memcg only had limits with similar semantics for quite
a while at the beginning.

That way, we avoid creating a big interface commitments while providing a
feature which should be able to serve and test out the immediate usecases.
If, for some reason, many of us end up running hefty applications in SGX, we
can revisit the issue and build up something more complete with provisions
for backward compatibility.

Thanks.

-- 
tejun
