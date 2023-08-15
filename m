Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF62077C4A0
	for <lists+cgroups@lfdr.de>; Tue, 15 Aug 2023 02:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjHOAsY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 20:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjHOAr7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 20:47:59 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5561710;
        Mon, 14 Aug 2023 17:47:58 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a751d2e6ecso4205520b6e.0;
        Mon, 14 Aug 2023 17:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692060477; x=1692665277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNEJH3hSSRRHyRk+tOxvRsyumLi4vURSWSdvolmYkGg=;
        b=BFRuwagfFi9+OedefmC8mcbgzAetuiMxU/z+Brfx5yvijvQeffS9HYxWoftGxN0iAn
         XlpfCa1jBU1A2gAAU0DqCZlvtCCvqBOfZ5jnQ/QP6hAYNDNPFcw8PHQ1r7QAaGH/rYBL
         pyar1XexlSvHmjHuilFQEuVejUCSSY14DcGnPOkG8G/kisQw5MPaUrlKsK/cSFlGvx52
         5KdNvhtEDXpB5vKzIeIj8GXhVLyuS5AI6K5AY2NZcdTxn5++l8bcL6j6s+xcwAcSvJ4x
         UEAf/nH9NkphyEM+A6WsCS7/d5up3bJXvnJbuZiE/HEag9ZlIpWaIftXFL+auU873v54
         WS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692060477; x=1692665277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nNEJH3hSSRRHyRk+tOxvRsyumLi4vURSWSdvolmYkGg=;
        b=XKheWCIzZh3ffTF0UzhvIfTuFrHNQq5q+Ekc6BO4DDMaG4jzW1hFcdXwNQkZ+XVpYH
         lnqq9TT/Za0KYCllhbyvgko8l6KmPl7tqELOcb1ePEi6k1/mgqmygAcKzfacn7VIjzdU
         2FWNIHhxp4NoBcNrcoMB6NGDLTNAygKcxp+xm6FwXwcARdJ//Vti/iNjQHLtbWdzMmcp
         jFP0oXU3+YdP+39dQpx6RfasxtFHOEensEfXye3asu8th7SCqRD7GtHI+upzziw5i72B
         EAKuKGyRsS7DPpo9O4EF53tZPYAUpG/14Tn4cXGBhSoUQwCrrssnzKhQzJMya43GT4fF
         Fdlg==
X-Gm-Message-State: AOJu0Yy2duExlS8Vnr9x+0O0+jcd/NM+z3L1Og79JFZG1sLC8tiMo8vh
        BA5HzI8WbVX0j/dpNZoFnVc=
X-Google-Smtp-Source: AGHT+IElBL0mCNGkQk0GUhaqyFVfIoWjGScv9MnxX1sa+kZadopLwrM3BqRcDHQU9jSlmTTgHYh9bg==
X-Received: by 2002:a05:6871:591:b0:1bf:5d1a:f218 with SMTP id u17-20020a056871059100b001bf5d1af218mr11869959oan.28.1692060477472;
        Mon, 14 Aug 2023 17:47:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:93bd])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090aa60900b00260a5ecd273sm8464607pjq.1.2023.08.14.17.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 17:47:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Aug 2023 14:47:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
Message-ID: <ZNrLO5PAEZw4yjI9@slm.duckdns.org>
References: <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz>
 <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org>
 <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org>
 <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
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

On Mon, Aug 14, 2023 at 05:39:15PM -0700, Yosry Ahmed wrote:
> I believe dropping unified flushing, if possible of course, may fix
> both problems.

Yeah, flushing the whole tree for every stat read will push up the big O
complexity of the operation. It shouldn't be too bad because only what's
updated since the last read will need flushing but if you have a really big
machine with a lot of constantly active cgroups, you're still gonna feel it.
So, yeah, drop that and switch the global lock to mutex and we should all be
good?

Thanks.

-- 
tejun
