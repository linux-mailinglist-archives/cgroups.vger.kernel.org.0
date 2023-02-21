Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7220C69E5FF
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 18:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbjBUR3X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 12:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbjBUR3V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 12:29:21 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D07E40C8;
        Tue, 21 Feb 2023 09:29:21 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id u10so5823281pjc.5;
        Tue, 21 Feb 2023 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CtEZ/7pnoyH06jUq+fgMxtlXiNC1jdAF93zVpBlKNvs=;
        b=mwAbh7M9wX3g1OzbvYABaL+kfK7rqeaqAMqPsEu9mPBCxmgk1N5zZECvq0Ss/MlzOD
         ROLyIRXLTZkTovztN4E21qQcT7ddYAkDbnNUlyw53talFh762BRNcyOyVpEDMg8g3B9u
         jykabVaGMXGLfiUat5SxJsNSFyraLPtDLRf+ITb5xxLKY4PASUCZnIOs3hjg1YPRk5Lt
         0kEytg6sLdm3KQTD0RbRdQ0Zm2BEY5TX6QXhIGu5FQTJpNtpNF2huHAdKOHpLei2igGJ
         C3rfRljyrxSRtoCGlF1kUWXRKEvfveiSGOD1SFYBImSqr3JJOlxH2edGQ7qtWRbXCZIO
         FyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtEZ/7pnoyH06jUq+fgMxtlXiNC1jdAF93zVpBlKNvs=;
        b=JHsewGg5+90PmRhT7IAqOo3tLyHmXj2pI5/BcyMEQjNfbkbOIkuijqV6AcCxRDAFTq
         kWttT21cyASWOMUa1dh/BlUNA5qFNCRdXsn5crw2zR6CEaOVMKHvUXgpabGZcjeO1/2A
         U1qFC00KJQybyYvnK2WJixqdv1dO+etdFjjsPirQZhz8ehab6IUje1wMLEwqsPwXrOdg
         IZP3FNCPa0FAlSBpFw7K0TEf+MxfuF4hkzSxAvnixt//p8OPZAooNObMNBhcdNwMo0+h
         Rh9IInghjRPQXpQbJTRC3gEw2R32yJPpxwZ8C+ze6lZTNkLYiMCh70KLUxSX6Ge/dYBd
         gPjw==
X-Gm-Message-State: AO0yUKViaEv5enUGtXDJtHyN2biPnxMHq/R2rUkWc8AqPBt7BPKmzq6N
        pFrmkGW1yKwvYogzvsABx04=
X-Google-Smtp-Source: AK7set8chT3xCP2Az0tuzlOPUZgJny1oGBAMs3MdDI/jVnEGjYfFMfe1WD2aoForZ9SO3Ibtf5to4Q==
X-Received: by 2002:a05:6a20:1610:b0:c7:1da3:e3a with SMTP id l16-20020a056a20161000b000c71da30e3amr3842395pzj.16.1677000560373;
        Tue, 21 Feb 2023 09:29:20 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d9-20020a631d09000000b004e63aa44474sm3286678pgd.33.2023.02.21.09.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:29:19 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 21 Feb 2023 07:29:18 -1000
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
Message-ID: <Y/T/bkcYc9Krw4rE@slm.duckdns.org>
References: <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
 <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
 <Y+0rxoM4w9nilUMZ@dhcp22.suse.cz>
 <Y+0tWZxMUx/NZ3Ne@nvidia.com>
 <Y+3jcw9vo4ml5p0M@dhcp22.suse.cz>
 <Y+4lcq4Fge27TQIn@nvidia.com>
 <Y/T2pNQ70eMAl1sX@slm.duckdns.org>
 <Y/T+pw25oGmKqz1k@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/T+pw25oGmKqz1k@nvidia.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 21, 2023 at 01:25:59PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 21, 2023 at 06:51:48AM -1000, Tejun Heo wrote:
> > cgroup, right? It makes little sense to me to separate the owner of the
> > memory page and the pinner of it. They should be one and the same.
> 
> The owner and pinner are not always the same entity or we could just
> use the page's cgroup.

Yeah, so, what I'm trying to say is that that might be the source of the
problem. Is the current page ownership attribution correct given that the fd
for whatever reason is determining the pinning ownership or should the page
ownership be attributed the same way too? If they indeed need to differ,
that probably would need pretty strong justifications.

Thanks.

-- 
tejun
