Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1977968CB32
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 01:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjBGAcq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 19:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBGAcp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 19:32:45 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279D4CC0B;
        Mon,  6 Feb 2023 16:32:41 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id w5so3976875plg.8;
        Mon, 06 Feb 2023 16:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yg/htWu0h5ky+EZYsIhtW9pYXyUpBD0h03Dnr/pHD7Y=;
        b=d2qVKAn3/FIUwu+zOygjEPGFy97MBnBGsttXg8EOJqeIM2iEvN2VFDmES4qVDmBv5i
         yGmrObVu2A6QXjJhUL7fHvZlbAg0b4cuS24cGrzzNjiEU3Cm/vgsztB9B98BvUrrC/y9
         byTpHLXW3xY7Tw6ESTfeCHNFETuNApMcEUJ91y+/cS+YPVtJswhVedc4VvBRSbOw48b2
         J0S/CO1py7yzLJbNh7fogdekTRrUb/4U3ggx6bNTaXX/OadYifqxCHOSkZSAg6UC4TvY
         2jHPBqS/DZE5LCIGRkv5WUE2C+t5DEfgqo4CqBDJQ8eRNXrgXzq6THP917nV+zL5I270
         QGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yg/htWu0h5ky+EZYsIhtW9pYXyUpBD0h03Dnr/pHD7Y=;
        b=loA13Vf+k3XXY8zWO2tZB/7LZVH5fv27LErB4NXn4O0n8hkNMIeRJQIRIWqkErk9H5
         pdAcFcf6JtMUtwj1sLEphW8F7MmqClpfCJV4CHoH182MWCHxtwDU898I51HXQJSwKTGK
         um+RpFe2BCaboSAfLl1AJM5WJbg8gr16QuMxfDQ1DAUyz3exPBlegTha1pE4jslMNz8w
         S0alVHRdQoBtMn2BsMY5bVPR4/neoChPosp9idnK1THz3rpBzx4dorK8o7nViLlbJ/kG
         UPpYA28d6ixldehivcPp+Qy4hBiEaHB74owJrgWA1UHl3pvi8GZmxl4l6u207MNFP8ex
         eDZQ==
X-Gm-Message-State: AO0yUKVGVYHsDSkp4SNRprcsMSE8sUX2GCVp3BCv+SE3WkdTHofc6hrp
        oz6x9UIqsR07cR2O39E8Zliu7L3E0eI=
X-Google-Smtp-Source: AK7set/zysKJs3fqs4nJd+bR85UfkzsGibypkyMDBcD3FCQb+PpGvGEorCJop7XWg5XsHJbOT7D2ow==
X-Received: by 2002:a17:90b:1d0b:b0:22c:5f4f:489 with SMTP id on11-20020a17090b1d0b00b0022c5f4f0489mr1765022pjb.19.1675729960402;
        Mon, 06 Feb 2023 16:32:40 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-44e6-6a58-44be-40a6.res6.spectrum.com. [2603:800c:1a02:1bae:44e6:6a58:44be:40a6])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090a740500b0022c0622cc16sm3067685pjg.54.2023.02.06.16.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 16:32:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 14:32:37 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhubbard@nvidia.com, tjmercier@google.com, hannes@cmpxchg.org,
        surenb@google.com, mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+GcJQRhvjqFaaSp@mtj.duckdns.org>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
 <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
 <Y+GQB9I6MFN6BOFw@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+GQB9I6MFN6BOFw@nvidia.com>
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

On Mon, Feb 06, 2023 at 07:40:55PM -0400, Jason Gunthorpe wrote:
> (a) kind of destroys the point of this as a sandboxing tool
> 
> It is not so harmful to use memory that someone else has been charged
> with allocating.
> 
> But it is harmful to pin memory if someone else is charged for the
> pin. It means it is unpredictable how much memory a sandbox can
> actually lock down.
> 
> Plus we have the double accounting problem, if 1000 processes in
> different cgroups open the tmpfs and all pin the memory then cgroup A
> will be charged 1000x for the memory and hit its limit, possibly
> creating a DOS from less priv to more priv

Let's hear what memcg people think about it. I'm not a fan of disassociating
the ownership and locker of the same page but it is true that actively
increasing locked consumption on a remote cgroup is awkward too.

Thanks.

-- 
tejun
