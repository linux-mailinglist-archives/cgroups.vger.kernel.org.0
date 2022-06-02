Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E505053B27B
	for <lists+cgroups@lfdr.de>; Thu,  2 Jun 2022 06:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiFBEOS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Jun 2022 00:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiFBEOO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Jun 2022 00:14:14 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A745523357F
        for <cgroups@vger.kernel.org>; Wed,  1 Jun 2022 21:14:12 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 137so3709638pgb.5
        for <cgroups@vger.kernel.org>; Wed, 01 Jun 2022 21:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o/UKlvjBmq/GEr5NrImr3MrgSwxgE88wiN4r50yamSw=;
        b=DZpIXcD/hmaZBUagAs3C2t/0HooyyKDjMlX2Mq/6f09fzuif5gF+Pm+6Edmc4Wblaw
         s5vRGKy2d9fkaseDxbQMVER68m3eMGq9P5FvWNFIQby1IsLn2ECsFvlsgZ89+aRpPM2q
         zf6phcx67MW4xWbVzj2tLCHWBZIzJYohlxxQ05NKm/uksVQe9lc4+nZx0/kW6j/cGUBG
         Pze9qfPd4iU6Elm+1R/2ylR4DzXuC3Epg9G47dRB67gZVFOS+h00nX0vtP1eq4Zjx0a6
         kzIrgs83pD7a82U7tUoShqimRbTpknzJI1BIJP6U3oEOcmlrsCArZ7c6jng/BkO5h4rg
         5H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o/UKlvjBmq/GEr5NrImr3MrgSwxgE88wiN4r50yamSw=;
        b=jIRTIyoqFqlwa5UZoyAKxPvA1kPgPJrgUXiqTLwC8fW6ywwQ3yncubEQMfYJE+faOe
         qBnFAhZWICbn7BqL+9VNuQPlDyqvURv0brWbEiDKwwReXL7HCOnbP0uxE076tHasyLjL
         /Qn92l7WJm9bxe/0Pb4hs+lue9X5supRhf4Wwcaif4jXxpmebhV4vbXXHYxatDqh3kxs
         HLiK0cMQxsEOSwAMvNeKf/n7nOfdkrnlDsfasRzV2wPgPr9CwA3dCM0dZFT09yYJee00
         yoL4aqxppOLKndwrO6b8unMyuSDiqNaQORmCxc9I9W95jYk+JHp4K2xupscZv0hJg438
         s21Q==
X-Gm-Message-State: AOAM532loaM6o7bk1lJkDJQIF/Or/p+MPsm/tCUU1cPRwaiL7RgA3VNy
        qRVcLTxzYaY2u2N8S9PycCnrz4CPnu1aXQ==
X-Google-Smtp-Source: ABdhPJwpTGp0sg6z4BBIMsIeEvvv5ZD1xdLYZ+lZk0b2MAdlqkjhAq0wP04s2h/DCb5MeMQ1QZQ8/w==
X-Received: by 2002:a63:d314:0:b0:3fc:7054:bf54 with SMTP id b20-20020a63d314000000b003fc7054bf54mr2423414pgg.615.1654143252491;
        Wed, 01 Jun 2022 21:14:12 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2468:2a68:7bbe:680c])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902d18c00b001616e19537esm2269603plb.213.2022.06.01.21.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 21:14:12 -0700 (PDT)
Date:   Thu, 2 Jun 2022 12:14:06 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v5 09/11] mm: memcontrol: use obj_cgroup APIs to charge
 the LRU pages
Message-ID: <Ypg5DhrXCEAazDE9@FVFYT0MHHV2J.googleapis.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530074919.46352-10-songmuchun@bytedance.com>
 <20220601173438.GC2434@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220601173438.GC2434@blackbody.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 01, 2022 at 07:34:38PM +0200, Michal Koutný wrote:
> Hello Muchun.
> 
> On Mon, May 30, 2022 at 03:49:17PM +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> > +static inline bool obj_cgroup_is_root(struct obj_cgroup *objcg)
> > +{
> > +	return objcg == root_obj_cgroup;
> > +}
> 
> Admittedly, this predicate alone caught my eye, why it did not also
> check root_mem_cgroup->objcg_list.
> However, deeper look reveals it's purpose is to avoid missing uncharges
> of pages that were charged in non-root memcg and later re-associated
> upwards after reparenting.

Right.

> So it's like obj_cgroup_root_origin() (I'm not suggesting a rename, just
> illustrating the understanding).
> 
> get_obj_cgroup_from_current() gains some complexity but it still holds
> that in root memcg neither kernel objects nor LRU pages are charged.
> At the same time, reparented kernel objects or LRU pages are properly
> uncharged.
> 
> These parts are 
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> 

Thanks Michal.

> (I did not look into the locking guarantees with the new API though.)
> 
> 
