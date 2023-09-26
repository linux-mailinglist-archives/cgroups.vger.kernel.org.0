Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA537AF291
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbjIZSYq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 14:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjIZSYp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 14:24:45 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5433F3
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 11:24:38 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65b0e623189so25209746d6.1
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 11:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695752678; x=1696357478; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rhTI8dcDdjEZYE7dpMYfMSA1DN/2lzmSQcv8fWKSSFk=;
        b=1fvEyH24SAykUGlk20UIHvgMA+IAh4UvzSsJna+6I0dS7ODbdFP6D85ZIIQ1cvdtDL
         +QEF1ysibquPY7SaNb3ScwEyXhsu62LnTRQgxOVxxBZKFqWL5TwfYh81Zek8RhjqnXd2
         gssMv8hXhMA/lsNXxzDvBR0G5LwgVOmOEMUba5KLbZInWS1cgTKYDmUAuB72HDYRLeZk
         PAYvtogBHNKPqvBl7Xf3RlCGEakTolu1v19kWBA3yXD2tgPkDkdlMDF40uCfYVway3pw
         Ob/Nx7D4FIwMoqETd6a7CxDK20DpQ8dfxVkDnhqZoNEyiOtTp10qcn31iOyOcj/pDoIZ
         YLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752678; x=1696357478;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhTI8dcDdjEZYE7dpMYfMSA1DN/2lzmSQcv8fWKSSFk=;
        b=MOPXxyHlmRqpyiDwvKUGouyfFqDphBXI4z6uMMA2yHVbsP/j90lfhCIEjJix8x18+4
         l3U9PQL/U4835ozCkUgFkp22Jf3PeRxt/sGS07L2BR8kzxxcOU/6f3D11OBwV627bI9g
         YHHO/DT1TpWbM5uceVXPr87JkRiEc6qA7nL/XKfuZ1s33hmELhD8bh6wCpFp5YsRPzqE
         qId5zGHJ7VV5UlvIEPzvg6Yj5eudCViAAZHw94JpUT0BKyuvMAX22+LH5EMwGBn5wBwI
         urXUz924Tz7zDSvOkFGuOIDwI9qQtlvVhC1uaD45KGEDegqGE7VZAdXzGasByyDMljuH
         2Ekw==
X-Gm-Message-State: AOJu0YyletqdK92ygzZIwg82XF9HVXpis1EnKl5UyoYIw+xrDb7o5yIG
        pAgrShxnk4TarL/IN/yrHDwT9Q==
X-Google-Smtp-Source: AGHT+IGrllrqWC0EKYtowvbvW5nW/cSOOf9HD2lBbguXAWo9ez72h7EB7JcAv/d+4OtMR5uQ2cxa0A==
X-Received: by 2002:a05:6214:2d04:b0:649:8baa:2986 with SMTP id mz4-20020a0562142d0400b006498baa2986mr10287586qvb.2.1695752677986;
        Tue, 26 Sep 2023 11:24:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id r1-20020a0c9e81000000b00656e2464719sm100717qvd.92.2023.09.26.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 11:24:37 -0700 (PDT)
Date:   Tue, 26 Sep 2023 14:24:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
Message-ID: <20230926182436.GB348484@cmpxchg.org>
References: <20230919171447.2712746-1-nphamcs@gmail.com>
 <20230919171447.2712746-2-nphamcs@gmail.com>
 <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 25, 2023 at 01:17:04PM -0700, Yosry Ahmed wrote:
> +Chris Li
> 
> On Tue, Sep 19, 2023 at 10:14 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >
> > Currently, we only have a single global LRU for zswap. This makes it
> > impossible to perform worload-specific shrinking - an memcg cannot
> > determine which pages in the pool it owns, and often ends up writing
> > pages from other memcgs. This issue has been previously observed in
> > practice and mitigated by simply disabling memcg-initiated shrinking:
> >
> > https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/#u
> >
> > This patch fully resolves the issue by replacing the global zswap LRU
> > with memcg- and NUMA-specific LRUs, and modify the reclaim logic:
> >
> > a) When a store attempt hits an memcg limit, it now triggers a
> >    synchronous reclaim attempt that, if successful, allows the new
> >    hotter page to be accepted by zswap.
> > b) If the store attempt instead hits the global zswap limit, it will
> >    trigger an asynchronous reclaim attempt, in which an memcg is
> >    selected for reclaim in a round-robin-like fashion.
> 
> Hey Nhat,
> 
> I didn't take a very close look as I am currently swamped, but going
> through the patch I have some comments/questions below.
> 
> I am not very familiar with list_lru, but it seems like the existing
> API derives the node and memcg from the list item itself. Seems like
> we can avoid a lot of changes if we allocate struct zswap_entry from
> the same node as the page, and account it to the same memcg. Would
> this be too much of a change or too strong of a restriction? It's a
> slab allocation and we will free memory on that node/memcg right
> after.

My 2c, but I kind of hate that assumption made by list_lru.

We ran into problems with it with the THP shrinker as well. That one
strings up 'struct page', and virt_to_page(page) results in really fun
to debug issues.

IMO it would be less error prone to have memcg and nid as part of the
regular list_lru_add() function signature. And then have an explicit
list_lru_add_obj() that does a documented memcg lookup.

Because of the overhead, we've been selective about the memory we
charge. I'd hesitate to do it just to work around list_lru.
