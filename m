Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3753312F
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 21:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240906AbiEXTDN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbiEXTDE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 15:03:04 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA64A41982
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:01:28 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id hh4so15414376qtb.10
        for <cgroups@vger.kernel.org>; Tue, 24 May 2022 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N1NyblKLcbohBQoY7VD4CeyW8jWo8CQASjSrNPOY/Yo=;
        b=5jbLkbR/uOOEGcHuRkQuqxaY6Whn0WWZJI73E9T6SlozE5nWJfDFv28tOhdw2Irpoo
         ynu/oD5zPSoRnvOuieUuisexDncUJ9EhvY4IxA0FYIs846o/GA08BcTErhQHfklV/qf0
         jg0IcxxINtvlr2Bxdr4w1FKtN4Hr/+eb58jqrlcI8O9fldRZrzN4qtR3yJ5NQHkSSx87
         QVBY1FH1zFqA1zpBb6JeXcIx3cjBFrwrFWuWBTy1j0DS5ZAGQwmItNhPF5kCU5Dw8Pmf
         843ZDy7B/DAg+XUmHuEO5HppBvbMLLsifaMMzS6+fo5EuIPCFt1xQwZG7gG/nNEj74ye
         IG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1NyblKLcbohBQoY7VD4CeyW8jWo8CQASjSrNPOY/Yo=;
        b=YXmrT1gPRbukzBdiqWoyoYTGJbWofTis8b+HQH2fHP67U8UCoD1h/UhDyNqar5tUYX
         piybS7IhQ/6BzBfxaUVByu8Yq2GCwq9JXfWZ6ZqzoRBnb1Z3yU270KYHD9xfIBs7VgUp
         oDaRm+8zrnLwwiwmdHI1Y42Tdz4BhTTDDYCBYP+5omB6yF8mJywHyoWrN+HQ93yACAeM
         9+5zPkh6w0WtBte7BMQXPpjsVR3cZlfaWnybA4dUiwnl6ZY2i3MMpQgDHh1cty89dnli
         ZOvZ3rTE6yxGDKcNiyHHkGwBje2SfQqiiNLHM6n3KZrr3tRJFsreN/vTzzWI8iXZmjbs
         Lg+Q==
X-Gm-Message-State: AOAM532t1E8/oOITDLGjEdzvYl6oOdEVsUu+lT/UHy7s5t4uVXW5zJkp
        YnGB1df4q9kZ+r6sXLG8uhxeAA==
X-Google-Smtp-Source: ABdhPJwyJDma/cDSH1QDMd/26bP9vKjCHlXwU76/B8cVC9D3MAicjzWFuXlvICvkqo3oAg4VMZPAjQ==
X-Received: by 2002:a05:622a:110c:b0:2f3:d347:6f8d with SMTP id e12-20020a05622a110c00b002f3d3476f8dmr21461556qty.403.1653418886409;
        Tue, 24 May 2022 12:01:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id l11-20020ac84a8b000000b002f39b99f6c4sm48783qtq.94.2022.05.24.12.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:01:26 -0700 (PDT)
Date:   Tue, 24 May 2022 15:01:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v4 01/11] mm: memcontrol: prepare objcg API for non-kmem
 usage
Message-ID: <Yo0rhX2LFNPTv47b@cmpxchg.org>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
 <20220524060551.80037-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524060551.80037-2-songmuchun@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 24, 2022 at 02:05:41PM +0800, Muchun Song wrote:
> Pagecache pages are charged at the allocation time and holding a
> reference to the original memory cgroup until being reclaimed.
> Depending on the memory pressure, specific patterns of the page
> sharing between different cgroups and the cgroup creation and
> destruction rates, a large number of dying memory cgroups can be
> pinned by pagecache pages. It makes the page reclaim less efficient
> and wastes memory.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer.
> 
> Therefore, the infrastructure of objcg no longer only serves
> CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> can reuse it to charge pages.
> 
> We know that the LRU pages are not accounted at the root level. But
> the page->memcg_data points to the root_mem_cgroup. So the
> page->memcg_data of the LRU pages always points to a valid pointer.
> But the root_mem_cgroup dose not have an object cgroup. If we use
> obj_cgroup APIs to charge the LRU pages, we should set the
> page->memcg_data to a root object cgroup. So we also allocate an
> object cgroup for the root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Looks good to me. Also gets rid of some use_hierarchy cruft.
