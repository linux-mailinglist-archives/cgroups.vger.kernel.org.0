Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7626563AE70
	for <lists+cgroups@lfdr.de>; Mon, 28 Nov 2022 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiK1RHV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Nov 2022 12:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbiK1RHN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Nov 2022 12:07:13 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52FE23389;
        Mon, 28 Nov 2022 09:07:12 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id s196so10491415pgs.3;
        Mon, 28 Nov 2022 09:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/jS1zRSpC+P8xp144xwnS5feegCHv0w8ewtLrv0nf8=;
        b=kaWfxhV6xf7mJFYhLrtFv1cSXD99yiQq0KYir1cgs5srtEL5R5EtlBW4JHsDgXOPVF
         uxOAQ5sIrXTK7K9lkqSt/uwFo3SL9OnzltOhtizenHqUIottvCisHR3+tV+1neXnj2bp
         OuWqD5GjQWfsUGuYn1LlZJZ6wzMTIhsF/xJkpP+uIuEF15E8jnoTlFtby0SCGqPiYJo4
         JPMCjV9UKJwC8PsvwzfZVOJmhLdX0Li7oU4xVPQ3jMcizLjiMy5YPiE1JGZWl8D//bwS
         rjHVPWYCxC2I3HgTOW1TA8ntXVwsZm9IG+b47NRZ5u9t4f2joIgPZpkDRFN+Iqa6peyh
         3YxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t/jS1zRSpC+P8xp144xwnS5feegCHv0w8ewtLrv0nf8=;
        b=h98bKdo6n6/IqLDX1KttywW6j6IvE99SOqOVcPqK/J5dEEkcX8IPbGlQvjaNoy7tZ/
         ++s5/dkOPpg3Ul86a+RbWxP8eeu8UT51OplyVXGFLnR3R7uRwhCJjVtYyPONRV5JaOwu
         r3YfvCoUoECW9BN/ZuFxsoAlmkl4LC91S5yV1sLcHRvEfnr8RvuVS79EsFENg+DcXnjB
         Nq17BGYH5jYH03iKgaeyA0/g/XrL2Z1dxwUHhCtS1z0SOTEJpu3XhyhaNzaek7eQkIMM
         +W6bEWsAuISa9tP5rpF8ujL0MEDjOSCF+B1hcPLdayUpSSDuYgl7rpYn7xlS2UfLWdlM
         S0LA==
X-Gm-Message-State: ANoB5pkvGjtwv6qa4eS0yLutGcuJhULh1BH1fQgMIj2vJcbQYSsKSzu3
        uUQTQd2ldy/Cac8IQhMvqKO+wXhmtIw=
X-Google-Smtp-Source: AA0mqf5/vhXxoR1I9znY5JVY5l7IcYK1a1Lri4yThXiWTRaWT6zTz3p2EWd21Qq4tAaYnh8VpDqK/g==
X-Received: by 2002:a63:5153:0:b0:41a:4bd4:f43f with SMTP id r19-20020a635153000000b0041a4bd4f43fmr29147466pgl.460.1669655232208;
        Mon, 28 Nov 2022 09:07:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0016be834d54asm8976177pln.306.2022.11.28.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 09:07:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 28 Nov 2022 07:07:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "haifeng.xu" <haifeng.xu@shopee.com>
Cc:     longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Clean up cpuset_task_status_allowed
Message-ID: <Y4TqvlOmXqY/CBEc@slm.duckdns.org>
References: <20221125075133.12718-1-haifeng.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125075133.12718-1-haifeng.xu@shopee.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 25, 2022 at 07:51:33AM +0000, haifeng.xu wrote:
> cpuset_task_status_allowed just shows mems_allowed status, so
> rename it to task_mems_allowed. Moreover, it's only used in
> proc_pid_status, so move it to fs/proc/array.c. There is no
> intentional function change.
> 
> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>

mems_allowed being a very much cpuset feature, I don't see how this is an
improvement. The new code is different and can be another way of doing it,
sure, but there's no inherent benefit to it. What's the point of the churn?

Thanks.

-- 
tejun
