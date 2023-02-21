Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8D269E6D5
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjBUSHS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 13:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBUSHR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 13:07:17 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D8B2F7BA;
        Tue, 21 Feb 2023 10:07:16 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g12so3029798pfi.0;
        Tue, 21 Feb 2023 10:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iC2+JAOPJ7xBzI8XxPV50aOEhLdtaBVXx3tgIqcIDA8=;
        b=JxVgPwFf7PjLbqHyg/KF/bgcZTQyoMGHvbtVxDqt6yOY9aGl+AvfLI1AXDxz/r1wvV
         S+BrCUA9rK42zdI/Nzsaw//jN1f4IG1/si+33bGh8BWt8Ya1CJR38YIebWuF1Mo07cb9
         ir4sJZrHHOcDWDDxAfugg9OaOSg8y43jssvNXjnAXq2byO9AFBVugRCbXUVssSAMabAd
         ekkiFJCsuLfKBpDbCzzRVEUuCoCPKn5Hleyy6/LRtTHq0QLWEKOURXVW89vZ9P0Hnt+Y
         ISdL8k+PVv40iT4STlT7TM32PbUzIoMuXdCOzE+L4zMeW65sJG/C04HXNTUu9KSvEhAu
         UuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iC2+JAOPJ7xBzI8XxPV50aOEhLdtaBVXx3tgIqcIDA8=;
        b=DbDDIMgj3MtsnnCBCel6Nmkq2pGYEn8w7hmzU8vqogti8ytO3caYTZsqW1cvj+uHf4
         KuRJSyVnO3WmtPzqckrwmws3R2KYM2rqKtjkYKEHdPbKeU0E+2kGNng/YQWUPqRRiQXu
         Uuo5mP3UvtQ5+xbLt78nta7xZ7l9Q7S55ZgvVOwAZmC2Lk60L/3JAFGzzVTCINWlfPU0
         c+/vXliLSiIYu0IrN7NZdWn1CQpiE0l/+reVKmyWJPSbGDKVDq9E3DIxkxD1TIJtV4h2
         5ZgcJXIvO5KRw/BuAFDdkU9iT7miDODGzaT7CPLfxgJlC8bgDqorKoquqChwTkq8O81o
         QVPQ==
X-Gm-Message-State: AO0yUKX2O3nom/L1fFiVf6VsZ+PGZIPxhwi3MpLv/SkNPXks27kFI2Hc
        GwkYrUkTKtCtrBUAvx34UyA=
X-Google-Smtp-Source: AK7set/sIEbxQwDSsYKcsiPToHrtUeG4U2oC9f/kXGSXecReTeGpfnX+J9vcCz1UZmzqM7677z82eQ==
X-Received: by 2002:a62:174a:0:b0:5a8:bd14:d6f1 with SMTP id 71-20020a62174a000000b005a8bd14d6f1mr6422099pfx.7.1677002835751;
        Tue, 21 Feb 2023 10:07:15 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i13-20020aa7908d000000b005abc30d9445sm6746645pfa.180.2023.02.21.10.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:07:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 21 Feb 2023 08:07:13 -1000
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
Message-ID: <Y/UIURDjR9pv+gzx@slm.duckdns.org>
References: <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com>
 <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
 <Y/UEkNn0O65Pfi4e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/UEkNn0O65Pfi4e@nvidia.com>
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

On Tue, Feb 21, 2023 at 01:51:12PM -0400, Jason Gunthorpe wrote:
> > Yeah, so, what I'm trying to say is that that might be the source of the
> > problem. Is the current page ownership attribution correct 
> 
> It should be correct.
> 
> This mechanism is driven by pin_user_page(), (as it is the only API
> that can actually create a pin) so the cgroup owner of the page is
> broadly related to the "owner" of the VMA's inode.
> 
> The owner of the pin is the caller of pin_user_page(), which is
> initated by some FD/proces that is not necessarily related to the
> VMA's inode.
> 
> Eg concretely, something like io_uring will do something like:
>   buffer = mmap()     <- Charge memcg for the pages
>   fd = io_uring_setup(..)
>   io_uring_register(fd,xx,buffer,..);   <- Charge the pincg for the pin
> 
> If mmap is a private anonymous VMA created by the same process then it
> is likely the pages will have the same cgroup as io_uring_register and
> the FD.
> 
> Otherwise the page cgroup is unconstrained. MAP_SHARED mappings will
> have the page cgroup point at whatever cgroup was first to allocate
> the page for the VMA's inode.
> 
> AFAIK there are few real use cases to establish a pin on MAP_SHARED
> mappings outside your cgroup. However, it is possible, the APIs allow
> it, and for security sandbox purposes we can't allow a process inside
> a cgroup to triger a charge on a different cgroup. That breaks the
> sandbox goal.

It seems broken anyway. Please consider the following scenario:

1. A is a tiny cgroup which only does streaming IOs and has memory.high of
   128M which is more than sufficient for IO window. The last file it
   streamed happened to be F which was about 256M.

2. B is an a lot larger cgroup w/ pin limit way above 256M. B pins the
   entirety of F.

3. A now tries to stream another file but F is almost fully occupying its
   memory allowance and can't be evicted. A keeps thrashing due to lack of
   memory and isolation is completely broken.

This stems directly from page ownership and pin accounting discrepancy.

> If memcg could support multiple owners then it would be logical that
> the pinner would be one of the memcg owners.
> 
> > for whatever reason is determining the pinning ownership or should the page
> > ownership be attributed the same way too? If they indeed need to differ,
> > that probably would need pretty strong justifications.
> 
> It is inherent to how pin_user_pages() works. It is an API that
> establishs pins on existing pages. There is nothing about it that says
> who the page's memcg owner is.
> 
> I don't think we can do anything about this without breaking things.

That's a discrepancy in an internal interface and we don't wanna codify
something like that into userspace interface. Semantially, it seems like if
pin_user_pages() wanna charge pinning to the cgroup associated with an fd
(or whatever), it should also claim the ownership of the pages themselves. I
have no idea how feasiable that'd be from memcg POV tho. Given that this
would be a fairly cold path (in most cases, the ownership should already
match), maybe it won't be too bad?

Thanks.

-- 
tejun
