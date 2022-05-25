Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A2B5338BF
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 10:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiEYIqZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 04:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiEYIqY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 04:46:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E35621E0B
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 01:46:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so18011156plh.2
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 01:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d/L9bJONQPp0uSY28kh2HkObDppTNggSH2SJIKJfLuk=;
        b=2GEuOFvz3Bywye/v7GI6JcRFObM9JkE9PB987vWqYpJiiyxSqKAphe+RZffoCyw3Z8
         dQ4s8QBk94CQnN1GPQjqLpFQQtB6tVtsrCMONfYb8ZH+S3ljKkkBZntxUWs+DW5oOLCY
         MVoldevPZzFme10e5rTEUi02U4vA4Is0+GRUtHOulZuFhPIOnv5LIbwIJq2lSGo5/6La
         lqm5E+niPY2k3kRldtKfA/ZIldsMIrJrdsia9LnJH2u2QRZX927wPJ/hO1yElkEsN67n
         ACcx7saaMsBzaEhlKwdSQPEdtY1RGNsTc69pkFZHcT7E3YFH+3JoignnjhAtztA1LuMA
         B9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/L9bJONQPp0uSY28kh2HkObDppTNggSH2SJIKJfLuk=;
        b=Fukz9rozls6J9ei8fBOTCOqLxGI41Xp/1NOuKT0O2KLFJpYi3qKfKOllCfdCbo3IKR
         a9qMCSSsmMDSsD0ZUAlqTLSs0iq+yRHLls2u6DsJq8mEY+qD5/i/K1R+VToF+oUHo2sM
         YoLnUzUDgTImXrLV1SSHDyiegVlEFiEihCs5L0CJ7tPugtTd/yEj6xKwDXKwd0gfvcYF
         yTcmcwFUFTTiuR6XD5HPbVnBjJXHKrTSDxk+UZI6XyZ27UeqSdyTnbl9f6EyjHfuufuc
         QGxmwHhkvn2ImpW851+hTs8xCzdLl18D9d5XCNhZH/aPqbVBDXkhWZWcOpaqN5LNnQ1F
         bdCg==
X-Gm-Message-State: AOAM533pC6W6fw+R6u7TETrMKG3AO95zkNHoXGHkqU1QGfienFHOGLEK
        +UD99lAL+qDt18o2Ti0sUDXATg==
X-Google-Smtp-Source: ABdhPJwnmL+cvLM5lHxHfpGLmHf4g+oYpN6zeK6b7y0jWu6+wMWakWV0yI6oG3RyjogpIQyC6oZmtQ==
X-Received: by 2002:a17:902:748c:b0:163:5fa0:68c0 with SMTP id h12-20020a170902748c00b001635fa068c0mr953508pll.123.1653468382775;
        Wed, 25 May 2022 01:46:22 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40f:7b5:4fa8:df3f])
        by smtp.gmail.com with ESMTPSA id m24-20020a170902bb9800b0015e8d4eb28csm8643430pls.214.2022.05.25.01.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 01:46:22 -0700 (PDT)
Date:   Wed, 25 May 2022 16:46:17 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 01/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <Yo3s2al2HElmb76K@FVFYT0MHHV2J.usts.net>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-2-songmuchun@bytedance.com>
 <Yo0rhX2LFNPTv47b@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo0rhX2LFNPTv47b@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 03:01:25PM -0400, Johannes Weiner wrote:
> On Tue, May 24, 2022 at 02:05:41PM +0800, Muchun Song wrote:
> > Pagecache pages are charged at the allocation time and holding a
> > reference to the original memory cgroup until being reclaimed.
> > Depending on the memory pressure, specific patterns of the page
> > sharing between different cgroups and the cgroup creation and
> > destruction rates, a large number of dying memory cgroups can be
> > pinned by pagecache pages. It makes the page reclaim less efficient
> > and wastes memory.
> > 
> > We can convert LRU pages and most other raw memcg pins to the objcg
> > direction to fix this problem, and then the page->memcg will always
> > point to an object cgroup pointer.
> > 
> > Therefore, the infrastructure of objcg no longer only serves
> > CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> > objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> > can reuse it to charge pages.
> > 
> > We know that the LRU pages are not accounted at the root level. But
> > the page->memcg_data points to the root_mem_cgroup. So the
> > page->memcg_data of the LRU pages always points to a valid pointer.
> > But the root_mem_cgroup dose not have an object cgroup. If we use
> > obj_cgroup APIs to charge the LRU pages, we should set the
> > page->memcg_data to a root object cgroup. So we also allocate an
> > object cgroup for the root_mem_cgroup.
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Looks good to me. Also gets rid of some use_hierarchy cruft.
>

Thanks for taking a look.
 
