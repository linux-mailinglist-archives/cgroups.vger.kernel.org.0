Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9269E88B
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 20:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBUTtW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 14:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjBUTtS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 14:49:18 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AE22F7AA;
        Tue, 21 Feb 2023 11:49:15 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a7so3358883pfx.10;
        Tue, 21 Feb 2023 11:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6K/xl9e8Q8bnQo/ivH2EBeLdam1+5jz+038tWO9HPw=;
        b=o5K60sI+5b3Joc4VXeVEsRTLlEHrmHo5Gm6MHi2NP7SDV2A81z5eipAA9fm5uwEetY
         GBJ4jybLksDDpDVvHpL1gkdPkiSdY9KNYSnHlCdWWTo7pZsL7fP1jDUFx/7sMfYrWRcd
         OtyismMkU3X8VhAEWlZZ9PILlrAIfgFEU9yD39Nnsrux59EyB/mDrjYaSn7uOgkaodJm
         Cz2EAJgG19XlI7GL+Kjl0IU51wTslY3dBPCvHHsonTa9ZfKL0619LUHf5VMqnw3JC98g
         TnsITtSZFCp9FbjlgSL+PKOJRoks8jQMaEYlGQReJvGKABTS3rygU6XGL0HJ3JhGKi3N
         6dng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6K/xl9e8Q8bnQo/ivH2EBeLdam1+5jz+038tWO9HPw=;
        b=l0fnOtaokotT9h3Shw3AWawz/CsBZptn7dHeU9gc5UpN5COOgLhQ23QTZrLv4zOF/N
         NjfupKGL7P0XqoE70Zkzmp2O3Q1xRGpORttoeu0gGWSl3nwK97FyI3qPffBOk3IiAUke
         36EpVxcZT+qUN85YmblcZUsPcbME18S6coDjteJFPncMgEtOLKMZcUV8jdVBgm/HaAZQ
         QabafhgqW6E/SzDQO65IyRaMaxptKY0fZ9diZEl3h0hrUdUx0zEL0N6rzTUAT1tT63w5
         AAQ4B1hHo4Sp+USPrX+Ns1fyHPJE2wh9BvW5yyKAdWCFzLKEUy9NSoA6tGri7YNIs9+t
         LdHA==
X-Gm-Message-State: AO0yUKWipB5gk9dI99tC81QjXSRwcGBbWuOiVgftBdGbXlJfNGNXKe8L
        0FPpnW4gOI+7QgB9nr7Jl1M=
X-Google-Smtp-Source: AK7set8DdZWjRRBY8P9hQ8YEJUXokeLzfnzfcQJkv9nPUQO/GStF/1UkGKu6FLKvebXMhaq9nD/pJw==
X-Received: by 2002:aa7:9ae6:0:b0:5a8:52d5:3bc6 with SMTP id y6-20020aa79ae6000000b005a852d53bc6mr5875557pfp.26.1677008954195;
        Tue, 21 Feb 2023 11:49:14 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id j26-20020aa78d1a000000b0058173c4b3d1sm9857822pfe.80.2023.02.21.11.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:49:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 21 Feb 2023 09:49:12 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/UgOEv2/KzapGPN@slm.duckdns.org>
References: <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com>
 <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com>
 <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 09:45:15AM -1000, Tejun Heo wrote:
> > Multiple cgroup can pin the same page, so it is not as simple as just
> > transfering ownership, we need multi-ownership and to really fix the
> > memcg limitations with MAP_SHARED without an API impact.
> > 
> > You are right that pinning is really just a special case of
> > allocation, but there is a reason the memcg was left with weak support
> > for MAP_SHARED and changing that may be more than just hard but an
> > infeasible trade off..
> > 
> > At least I don't have a good idea how to even approach building a
> > reasonable datstructure that can track the number of
> > charges per-cgroup per page. :\
> 
> As I wrote above, I don't think the problem here is the case of pages being
> shared by multiple cgroups concurrently. We can leave that problem for
> another thread. However, if we want to support accounting and control of
> pinned memory, we really shouldn't introduce a fundmental discrepancy like
> the owner and pinner disagreeing with each other. At least conceptually, the
> solution is rather straight-forward - whoever pins a page should also claim
> the ownership of it.

Ah, sorry, I missed the part about multiple cgroups pinning the same page.
Yeah, I can't think of a good answer for that.

Thanks.

-- 
tejun
