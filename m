Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937D636952
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 19:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiKWSyl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 13:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbiKWSyk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 13:54:40 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B296074CC7;
        Wed, 23 Nov 2022 10:54:39 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f3so17532246pgc.2;
        Wed, 23 Nov 2022 10:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5sSGgviv+Rd8DodQepSsltaLLYak+O+h9smkq8iHKcU=;
        b=fPjv6zZam2cSMYf9VamxmWMlMyv7kpdr5YdnhbjOilgItBXwb6LHw4mO0zpf3risoj
         T43v3+mu8k+SWFkbYVjXSMtXRTjZuqLsAZQgYsPkZll4do16vOHi2nbSdqbMOOQ+RSOd
         HQvnOHS5e6tZWST/ye/mBAGqlKPT8RyA04w8Bjy50IdYj8+otNvunOrr9NEAIQ5OnbNk
         8VXIAJ2XD2Fd61/wbMsmflnCo54arTeNGC1DBGpG5Ol7fDTNSUrV5DexVJL1LPLky1Vj
         vlnNvp7fTlt16YKuFSyhRsSaRHXaXYyLb+ZB5wvTuDzyRVYhn/5TI9qLi+rt/1jXsZCx
         7jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sSGgviv+Rd8DodQepSsltaLLYak+O+h9smkq8iHKcU=;
        b=nSwxtyuGhtmmRNwd9xXRzT3a4iheR9W9Zigb+5wQgg058nKXbIhsqiFhAkssht1nc3
         oERsO7BWbQKey9ZKbXfwoUix81LdugQNPtmTPHiNEEg4jkcb7BV5aqrbo9UeFTZeZe4L
         f61NzojoCXWRN1A6blcE6OHIPijFaGn0f/Ogf7FS4f5YVbskEvD/V9+0KdeKNcE/NNTc
         KF7uppjcyPSyAbL6L0mArHkyuA40tduI77sUDTSHULIhR/4C/kzL4GvQ7K5YsWvKSE4U
         pclO7CckGFWsLEsBXfqFIT2GcXjkEmGpOjo7sCPD8Bny0pvV0YVZSccH29iZuInMJWY7
         AMLg==
X-Gm-Message-State: ANoB5pk6n7K8hiTdlujwOPhrNytoaNQcVAgSYWYmo07v/6CyJGlLCnS8
        4IS8ReyHuPd6M2oiSbuyR38=
X-Google-Smtp-Source: AA0mqf44BN7ykPjHPAo2C9WjPmKfOrkxDUUtieAjzTf2lWt8Sgu9pE8eJ2HMvGBgeQ0TatRabC1RUg==
X-Received: by 2002:a05:6a00:410b:b0:56b:dc84:7783 with SMTP id bu11-20020a056a00410b00b0056bdc847783mr15005280pfb.35.1669229678922;
        Wed, 23 Nov 2022 10:54:38 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090322c300b0018912c37c8fsm9780378plg.129.2022.11.23.10.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 10:54:38 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Nov 2022 08:54:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "haifeng.xu" <haifeng.xu@shopee.com>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cpuset: Optimize update_tasks_nodemask()
Message-ID: <Y35sbREgYE6aIdIp@slm.duckdns.org>
References: <20221123082157.71326-1-haifeng.xu@shopee.com>
 <Y35Swdpq+rJe+Tu3@slm.duckdns.org>
 <5fccf438-fdbe-1bc8-6460-b3911cc51566@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fccf438-fdbe-1bc8-6460-b3911cc51566@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 23, 2022 at 01:48:46PM -0500, Waiman Long wrote:
> I think it is an issue anyway if different threads of a process are in
> different cpusets with different node mask. It is not a configuration that
> should be used at all.

Anything memory related is in the same boat and people still use them
reaching whatever end results they reach. Given the whole thing is pretty
ill-defined, I don't wanna change the behavior now.

> This patch makes update_tasks_nodemask() somewhat similar to cpuset_attach()
> where all tasks are iterated to update the node mask but only the task
> leaders are required to update the mm. For a non-group leader task, maybe we
> can check if the group leader is in the same cpuset. If so, we can skip the
> mm update. Do we need similar change in cpuset_attach()?

The leader isn't special tho. We just wanna avoid visiting the same mm more
than once, right?

Thanks.

-- 
tejun
