Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3176668C983
	for <lists+cgroups@lfdr.de>; Mon,  6 Feb 2023 23:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBFWga (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 17:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBFWg3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 17:36:29 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CABD16AC3;
        Mon,  6 Feb 2023 14:36:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id ge21-20020a17090b0e1500b002308aac5b5eso6867998pjb.4;
        Mon, 06 Feb 2023 14:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXMYbgDcLP+C7eZB1xaeoXCjWryL7Y0FGjQjkRAiPu4=;
        b=U3uz6QlenYSTx7+7wwZviiGVhFRBlwg5tFwn64kb40PHnHGQnn/KtLilsb4KmtJFEM
         1F7WGWkCvOoZrZe6y57NVcbBRfCN1uRku07igB1HQl+GMBr1mewsK7it+dFTVC/9zTTb
         cVlZ/OBVzAUc0bPSunWog7ZMHamtfvzHk/w+emTTdMFV3hw5cyfja3jrmLyMgUK8yikM
         0dPQ0t72FMRAN02L3kCZvh0eAulsoHbV5zNGX6aYEAW/7PfOZ2ZO9ihdMgNAtUSAbjk+
         dV4BZM7g6zv7iYyFX9x5Ku14OsRm5or1ENmCm3E4RYcNlo1dO1fvlFbmY+2NejXznhOk
         +ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXMYbgDcLP+C7eZB1xaeoXCjWryL7Y0FGjQjkRAiPu4=;
        b=PPu7lSf/KX8RtzTIJOc6A9sDfhMHaW5+60zDvZlnljT4wvLfgrFr3S5kEVRxmrgHfO
         DCUpT47w5QvvaTZMKsw8u1Eg/H63Arf6YY3sURDaAJstqY08pnORFenXJIn9D0D0+bhu
         30vsN5KRiT/Pz15QYT6sNFLnp8BWNizrOzZLhfDjMG9+/XdxIXylOgOthSg+COxRJI2e
         zb/Vx64ul+Be/adaLLftE9VZoKMyfbHXKswYnpSpO97Zz1V1W07VY5Ic5iRtvh7g+I/S
         4yOHed5FV3oEBJr5JYXaN9A5I7fhNRgRKXx9ytqJ0wWrDeF+kNRoKwZ0LY1Hr4A7ox1P
         I32A==
X-Gm-Message-State: AO0yUKUT7EApz7fKTzKoAfcLh6D4+AsOG1/NA7jgLZG/RlBbfbdTK9J1
        i4AGmNqDqTMW6xdhbN38Nks=
X-Google-Smtp-Source: AK7set9n1ywY37cEy62MsiI5rOGGVJ1rGtnIFWDfgwGHjt1SCXuTlNgJNjTbpFKbLfVaGYRjQDTmlA==
X-Received: by 2002:a17:903:1c2:b0:196:6577:5a96 with SMTP id e2-20020a17090301c200b0019665775a96mr699288plh.30.1675722987942;
        Mon, 06 Feb 2023 14:36:27 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902b08e00b001888cadf8f6sm4915892plr.49.2023.02.06.14.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:36:27 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 6 Feb 2023 12:36:25 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
Message-ID: <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org>
 <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 06, 2023 at 02:32:10PM -0800, Yosry Ahmed wrote:
> I guess it boils down to which we want:
> (a) Limit the amount of memory processes in a cgroup can be pinned/locked.
> (b) Limit the amount of memory charged to a cgroup that can be pinned/locked.
> 
> The proposal is doing (a), I suppose if this was part of memcg it
> would be (b), right?
> 
> I am not saying it should be one or the other, I am just making sure
> my understanding is clear.

I don't quite understand what the distinction would mean in practice. It's
just odd to put locked memory in a separate controller from interface POV.

Thanks.

-- 
tejun
