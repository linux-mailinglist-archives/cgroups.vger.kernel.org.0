Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221B969E880
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 20:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjBUTpV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 14:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBUTpU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 14:45:20 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AC4303CC;
        Tue, 21 Feb 2023 11:45:18 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id fd25so2386122pfb.1;
        Tue, 21 Feb 2023 11:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8Fw863vYfPuhJasko8shrY4FAYlAxC3uA3w425iqK0=;
        b=ZEHG7lOnQJAZUYa9JABpoxh1o9+wBCbhvsehzjqT+E7quaMrJOPsaccDZe52r0U5eI
         Wl2Yv3964tGhKOkZTfcjpmJwvuFGvtBi3oy09nbaYT62gAUZDrnR4pSbTuU2SFVNuy1P
         CmdrtDQ8EmgggBqy4VGb5JBmMaVO6gkqnVpsJYqgG7BDSo115dqSwWqgxH/Ipu6ne0bP
         GRAvVac7/7B1rzHhTXy/NA4aOz0UfW9JcqKwvCQsKSYY41tQ/mLshdOz6uioAWmSqo72
         aawleuhd63JPO8Q7OzYdyMlLKHm5kyK/vjZ8lghkG+sD0zV5fIspvbCUFMrDfyV8F7XO
         r4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8Fw863vYfPuhJasko8shrY4FAYlAxC3uA3w425iqK0=;
        b=SU6CzZLU5n6LLheCcY0g4PwthEz9vIHCoQhj/WZR4xnaulqfglPW0YYAxBixr8w3eu
         7D5bA9u3yphvOIaZxHrlPddLf7FYn7rHGvJeWhAFdKr8+3FTR+utF0LHEUYg5diF4qpC
         hVsTp+stR/4PTLk2gAeV/KIh37YG18dB3k6OU4y/8wAEPA0deFSJ4xJ0qgwpLxvvPeAk
         qKdZReuCTHBWcIIJsz42lOTT8scrHht54LcuAGlimcGUQAQWzr+Y/mr6EJoul4kF5h2H
         yZ0nmxRFcdBibAgdYUSgR2AQzN500ImqpPWEuPc9E1GO6Mf4eTswbbqceWuQbEkxO2/s
         Q4Lg==
X-Gm-Message-State: AO0yUKUEchpCscGhxFZI5aFyGZFBVEIeawmznXxJl7fItZLjXgv6UAAE
        1ZT7JBOvU5tGZPduM4kJd8GOYfqVbas=
X-Google-Smtp-Source: AK7set8urRSGStm1IPUPo50I4THD3x06nUbSBRBi4r/DqWJckfJiO3y1/5Ab6xlK4XDSli4bc6aj1w==
X-Received: by 2002:aa7:9407:0:b0:5a9:ea47:cd00 with SMTP id x7-20020aa79407000000b005a9ea47cd00mr5133411pfo.17.1677008717600;
        Tue, 21 Feb 2023 11:45:17 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7820d000000b0058e08796e98sm4146160pfi.196.2023.02.21.11.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:45:16 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 21 Feb 2023 09:45:15 -1000
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
Message-ID: <Y/UfS8TDIXhUlJ/I@slm.duckdns.org>
References: <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com>
 <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com>
 <Y/UIURDjR9pv+gzx@slm.duckdns.org>
 <Y/Ua6VcNe/DFh7X4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Ua6VcNe/DFh7X4@nvidia.com>
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

On Tue, Feb 21, 2023 at 03:26:33PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 21, 2023 at 08:07:13AM -1000, Tejun Heo wrote:
> > > AFAIK there are few real use cases to establish a pin on MAP_SHARED
> > > mappings outside your cgroup. However, it is possible, the APIs allow
> > > it, and for security sandbox purposes we can't allow a process inside
> > > a cgroup to triger a charge on a different cgroup. That breaks the
> > > sandbox goal.
> > 
> > It seems broken anyway. Please consider the following scenario:
> 
> Yes, this is broken like this already today - memcg doesn't work
> entirely perfectly for MAP_SHARED scenarios, IMHO.

It is far from perfect but the existing behavior isn't that broken. e.g. in
the same scenario, without pinning, even if the larger cgroup keeps using
the same page, the smaller cgroup should be able to evict the pages as they
are not pinned and the cgroup is under heavy reclaim pressure. The larger
cgroup will refault them back in and end up owning those pages.

memcg can't capture the case of the same pages being actively shared by
multiple cgroups concurrently (I think those cases should be handled by
pushing them to the common parent as discussed elswhere but that's a
separate topic) but it can converge when page usage transfers across cgroups
if needed. Disassociating ownership and pinning will break that in an
irreversible way.

> > > > for whatever reason is determining the pinning ownership or should the page
> > > > ownership be attributed the same way too? If they indeed need to differ,
> > > > that probably would need pretty strong justifications.
> > > 
> > > It is inherent to how pin_user_pages() works. It is an API that
> > > establishs pins on existing pages. There is nothing about it that says
> > > who the page's memcg owner is.
> > > 
> > > I don't think we can do anything about this without breaking things.
> > 
> > That's a discrepancy in an internal interface and we don't wanna codify
> > something like that into userspace interface. Semantially, it seems like if
> > pin_user_pages() wanna charge pinning to the cgroup associated with an fd
> > (or whatever), it should also claim the ownership of the pages
> > themselves.
> 
> Multiple cgroup can pin the same page, so it is not as simple as just
> transfering ownership, we need multi-ownership and to really fix the
> memcg limitations with MAP_SHARED without an API impact.
> 
> You are right that pinning is really just a special case of
> allocation, but there is a reason the memcg was left with weak support
> for MAP_SHARED and changing that may be more than just hard but an
> infeasible trade off..
> 
> At least I don't have a good idea how to even approach building a
> reasonable datstructure that can track the number of
> charges per-cgroup per page. :\

As I wrote above, I don't think the problem here is the case of pages being
shared by multiple cgroups concurrently. We can leave that problem for
another thread. However, if we want to support accounting and control of
pinned memory, we really shouldn't introduce a fundmental discrepancy like
the owner and pinner disagreeing with each other. At least conceptually, the
solution is rather straight-forward - whoever pins a page should also claim
the ownership of it.

Thanks.

-- 
tejun
