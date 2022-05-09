Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FF351FB48
	for <lists+cgroups@lfdr.de>; Mon,  9 May 2022 13:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiEILa4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiEILak (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 07:30:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E4F164C99;
        Mon,  9 May 2022 04:26:46 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s16so1681406pgs.3;
        Mon, 09 May 2022 04:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Ms5dtQehfkw1mFFz53YAav8LEpkzzlzEpCcB6kSnvY=;
        b=MVsp2jjiHNDmg59AzmpxFmJ7JTasWhUSVTYxRGAhW/4rn2RZgVAzmY6rO8TowyTJAc
         FRAAowpSFJ73ZVtwXcM6SzbbrEpMWO4jA96IwSUd4/toiWyZwJd+kVCybGjjHZXhU9fK
         UuggCJ5SWapCGbLK8LkRCuUXDXr5RQYuW+XEfCvfJCJYNsNg/zVn/XIWfwQ+3qZiNMH1
         97LvMixlZ7SMQ1s2a18HesTT052QM5dR2Ek1eOEDtImvaAHHlFzhloQkJ+MHrkGouvI1
         MGqhXhXrX5KMpOwtQAjOaDdea+K0oLRKdEh1kas3SspjdjBUHiC2UjT31YJxQkqVVm4e
         /eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Ms5dtQehfkw1mFFz53YAav8LEpkzzlzEpCcB6kSnvY=;
        b=KlO7vPnIk+X0EVBr9dDQsFEw+SkPI5BlNnRYn8wtPGgBL/v7o6ot0r2Ldj3LH8GmxX
         150zRFbOqLD/07eOzTIOiVKZGJc6C9kPAWhn8hQ8TiPXuc1RLS6MiS2k9nkBoCOcNE1I
         w09WrcYhO17FOLQNLBvhqRDjdVp5GE3ePJLgUjO7876qpfCQz8i5HCZMObUEwSCDchHM
         bwXikN9a70ZDiGC8xhQf66x39qZ6PY5EgwXX+hIKlQ1ENqM7VsPWFCYoTs59XKvf951f
         er/Fuj9+LtjcPJzfzqApzW6PkYNLDXLjflQVG7rI1yqk1jJyjgwBKyMK7HxHsbUimTbK
         v1ww==
X-Gm-Message-State: AOAM533LEkUtwLRlxDj00eYh9pcgf3C847YHAExV/gAhimXFgSFdaFGw
        b28xRYjUTqPSHWQgn3CVgDc=
X-Google-Smtp-Source: ABdhPJxolDEt0Adrw+QGt/t5j16jYKevYnRFb403wZBw1BSJWcDPihVMAV64uYXj/wt+1jrVzyqcoA==
X-Received: by 2002:aa7:9085:0:b0:50d:35ae:271 with SMTP id i5-20020aa79085000000b0050d35ae0271mr15404202pfa.42.1652095605860;
        Mon, 09 May 2022 04:26:45 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0015e8d4eb1d5sm6845311plo.31.2022.05.09.04.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:26:45 -0700 (PDT)
Message-ID: <6278fa75.1c69fb81.9c598.f794@mx.google.com>
X-Google-Original-Message-ID: <20220509112643.GA1147603@cgel.zte@gmail.com>
Date:   Mon, 9 May 2022 11:26:43 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 09, 2022 at 12:00:28PM +0200, Michal Hocko wrote:
> On Sat 07-05-22 02:05:25, CGEL wrote:
> [...]
> > If there are many containers to run on one host, and some of them have high
> > performance requirements, administrator could turn on thp for them:
> > # docker run -it --thp-enabled=always
> > Then all the processes in those containers will always use thp.
> > While other containers turn off thp by:
> > # docker run -it --thp-enabled=never
> 
> I do not know. The THP config space is already too confusing and complex
> and this just adds on top. E.g. is the behavior of the knob
> hierarchical? What is the policy if parent memcg says madivise while
> child says always? How does the per-application configuration aligns
> with all that (e.g. memcg policy madivise but application says never via
> prctl while still uses some madvised - e.g. via library).
>

The cgroup THP behavior is align to host and totally independent just likes
/sys/fs/cgroup/memory.swappiness. That means if one cgroup config 'always'
for thp, it has no matter with host or other cgroup. This make it simple for
user to understand or control.

If memcg policy madivise but application says never, just like host, the result
is no THP for that application.

> > By doing this we could promote important containers's performance with less
> > footprint of thp.
> 
> Do we really want to provide something like THP based QoS? To me it
> sounds like a bad idea and if the justification is "it might be useful"
> then I would say no. So you really need to come with a very good usecase
> to promote this further.

At least on some 5G(communication technology) machine, it's useful to provide
THP based QoS. Those 5G machine use micro-service software architecture, in
other words one service application runs in one container. Container becomes
the suitable management unit but not the whole host. And some performance
sensitive containers desiderate THP to provide low latency communication.
But if we use THP with 'always', it will consume more memory(on our machine
that is about 10% of total memory). And unnecessary huge pages will increase
memory pressure, add latency for minor pages faults, and add overhead when
splitting huge pages or coalescing normal sized pages into huge pages.

So container manager should welcome cgroup based THP QoS.

> -- 
> Michal Hocko
> SUSE Labs
