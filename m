Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1D06A0F5B
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 19:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBWSWO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 13:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjBWSWN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 13:22:13 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32BA3B642;
        Thu, 23 Feb 2023 10:22:12 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so156859pjb.3;
        Thu, 23 Feb 2023 10:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjT5RDIYjClMZUhiJmsiPwT8mIJGRNa0EFpaJl2jelA=;
        b=Ukme3+K3HjLvPsdqhtKKYkHuMO/N9SoQ9PPYVv2MsICMkI03J1ZmZHTePDjQX4X4Kc
         Uax+bJBaRGbYQoCM3aJd7NMn7Y7QqCtV/yX0vanHn1J3d4Ff3aVE8drM2eUlpNn7U9iJ
         DJxVQCmM16QHOSfImPZ3Rwld+i7syDGG150dbv4GP3d3+MlRdiuXt5b0BcZl8aMeoZeJ
         jmJXKahSpMaFrYBd7cL9/4ePB3Rrao+hXxN0q5+By6tXEfiiKJQF09rsrfY3lMDqr/qI
         mhYNXIi9VZWAnsuc3egKApOjI1h0v4+MvutaS6kwOO1nD7DAW9z7MaD4bRMY1Gk0duOj
         JspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjT5RDIYjClMZUhiJmsiPwT8mIJGRNa0EFpaJl2jelA=;
        b=U88DeLSnUZAv5e+BK+NTXlaUIV/+6fBRioeJkuiOqNdQIZilFaMdD7YGCDn7eLsjkP
         On1QZX3raCgWkbGOD9UrwgCuK6hL8Bnq3EZlw3lfyG0amz+r4uWkZudw+GySYDVstZjO
         086u3guBG9x+xAk29xMcJY16IpXrEya0GvgTvxHHqnRZt8PtknkWQMZre+ZHjRIyRErO
         EeWmem0GS6ipI5DBIdR6epF8Xv2H79Z9Qj2D45O8CTeJrG/vlVykhw5rCde2rFocDhWs
         VVNm3IInjunxkLOLBS4Qbsr5bBvEg1UGsFnkNYBSSCIa6Eag8jz3D5R2GPub4pDNdamQ
         GH6g==
X-Gm-Message-State: AO0yUKWdM4GMBFADLXvnYtWtI6uq8mGrm2vzfA444LntE9D1xJQQCTo3
        h6QfK23hvG1AN+Td3KXvnZM=
X-Google-Smtp-Source: AK7set+57ejpJ/XcdX5q39ijeoh8EWU8UYU2LtDhrk34nhUl+WnAHngIU7XsBgdqTVfclF5BtwccSw==
X-Received: by 2002:a05:6a20:bca0:b0:c9:9312:5f1d with SMTP id fx32-20020a056a20bca000b000c993125f1dmr11714096pzb.4.1677176532228;
        Thu, 23 Feb 2023 10:22:12 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:e5b4])
        by smtp.gmail.com with ESMTPSA id c19-20020aa78813000000b005a817973a81sm4930867pfo.43.2023.02.23.10.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 10:22:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 23 Feb 2023 08:22:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y/eu0cUDGe5JNOlq@slm.duckdns.org>
References: <87o7pmnd0p.fsf@nvidia.com>
 <Y/YRJNwwvqp7nKKt@nvidia.com>
 <87k009nvnr.fsf@nvidia.com>
 <Y/bHNO7A8T3QQ5T+@nvidia.com>
 <CABdmKX18MY19bnsxN5W38Z9zmoaZx+S4+zzN_5XCYDBruwPrLg@mail.gmail.com>
 <Y/eiLBo88pgr2IUm@nvidia.com>
 <CAJD7tkadBRP22qP63-SjKSch1im9sHLoMzc6c2h10+ggbuxqMg@mail.gmail.com>
 <Y/esMBOyTaJnv5CW@nvidia.com>
 <Y/etNfwxHv8XO3iC@slm.duckdns.org>
 <Y/etrtvyaiwRIo6f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/etrtvyaiwRIo6f@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 23, 2023 at 02:17:18PM -0400, Jason Gunthorpe wrote:
> On Thu, Feb 23, 2023 at 08:15:17AM -1000, Tejun Heo wrote:
> > On Thu, Feb 23, 2023 at 02:10:56PM -0400, Jason Gunthorpe wrote:
> > > > I am not familiar with memfd, but based on
> > > > mem_cgroup_swapin_charge_folio() it seems like if cgroup B swapped in
> > > > the pages they will remain charged to cgroup A, unless cgroup A is
> > > > removed/offlined. Am I missing something?
> > > 
> > > Ah, I don't know, Tejun said:
> > > 
> > > "but it can converge when page usage transfers across cgroups
> > > if needed."
> > > 
> > > Which I assumed was swap related but I don't know how convergence
> > > works.
> > 
> > That'd work for pagecache. For swap-backed, I think Yosry is right. Is
> > MAP_SHARED | MAP_ANONYMOUS a concern? Such mappings can only be shared
> > through forking, so it's not a common thing to be shared across different
> > resource domains.
> 
> Isn't memfd also in the same boat?

I see. Yeah, that's looks like named shared anon. The first one
instantiating a page would always be the owner.

Thanks.

-- 
tejun
