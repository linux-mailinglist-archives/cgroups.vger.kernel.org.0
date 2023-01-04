Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3865DACF
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 17:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbjADQ53 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 11:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240291AbjADQ5N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 11:57:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8EDA0;
        Wed,  4 Jan 2023 08:54:02 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso25287490pjc.2;
        Wed, 04 Jan 2023 08:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbOBQVb3RdLyfUHgOO8SrdRe73a4J3V0VjVeqsiIMyg=;
        b=EA3IfsuvB4+ngQcFgXazs9up+BHg+GXLXmIVafCOFWXPSUT8axBmcCc1JLrx5b6W1g
         siIkRYQTpey+yElpHtfv87wOzTxE1v0zyYy3Ex6tm3thIOOa4gDPySQs03+yg6balCQx
         qNCujaog5PzmZaRXHveJ3HYnAXxfGp/cPKgwa3pVXzBDvE03j9DPoc3cObdHkE9krfiE
         vD/7euCAVa13V48VfRFiUeNVkDMFrV0BEofVemxwLx5Iry3H/bmcrseymZRPP1F+yyPW
         PNFU4dOkcT52xQ3eLLHRLdsJZRRT/fAIt8ug5+5mwBK9th/QDNdlPXPJ61BMzrsAauOP
         vTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbOBQVb3RdLyfUHgOO8SrdRe73a4J3V0VjVeqsiIMyg=;
        b=IbdK9Cyt+vxOt/EZjYFyOD9ViWvmt4qQXZDXCDZPj2cqOJ2Wuf5EdeZaArmfW9peGM
         Wvhm6htwVjijxx4tjoRQSTeu4/KYtgKedo0hGWLZq1R2teThN/6s/El+TrbEgMQtJTF9
         G2YsB96FtIO6m/ZiqV6Xkn5CxfzGu84qlW+hGV+qiE1ZHBw4UDJEWOCEalCRekh2lnUk
         Hi5Y85/U7LpMMSpDJpaljpB6VpkTZlBrTX3WsBSZ3vcSyZtrn0ysaUzVK9DCl2Otu4TE
         PYSnycEPeDbgxbgjmQyMvTWFEkONBbdGt7iuWjvpJb1iXa0BM3wPL0rfIgL9My0wSfi8
         GPXg==
X-Gm-Message-State: AFqh2kqSM3L33BnKwqzrYH9hnp0xSe47SZ5WuCDPYje5reTo6lMhMpMy
        Xd+uePcbGxZDztJKhQSOTQc=
X-Google-Smtp-Source: AMrXdXv8KwaLBN02f6SybYhP2+cZNEImFb/2Rg7xdstihKD1Yz8YPGGVeOATVrwGMcrihgYIRjA05A==
X-Received: by 2002:a05:6a20:5482:b0:a4:491d:d589 with SMTP id i2-20020a056a20548200b000a4491dd589mr79127340pzk.4.1672851241481;
        Wed, 04 Jan 2023 08:54:01 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id f2-20020a655502000000b004790eb3fee1sm20284950pgr.90.2023.01.04.08.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:54:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 06:53:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH 00/10] docs: cgroup-v1: formatting improv for "Memory
 Resource Controller" doc
Message-ID: <Y7WvJzquc8r81X9u@slm.duckdns.org>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
 <87a630h5mv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a630h5mv.fsf@meer.lwn.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 02, 2023 at 04:35:20PM -0700, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > "Memory Resource Controller" CGroup v1 documentation has been in reST
> > since 99c8b231ae6c6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rst"). The current doc look is kinda ugly, so improve the formatting (only
> > htmldocs is tested).
> >
> > The first patch is a fix for recently reported htmldocs warning, which can
> > be pickup separately from rest of the series.
> >
> > Bagas Sanjaya (10):
> >   docs: cgroup-v1: extend underline of section 8
> >   docs: cgroup-v1: replace custom note constructs with appropriate
> >     admonition blocks
> >   docs: cgroup-v1: wrap remaining admonitions in admonition blocks
> >   docs: cgroup-v1: use code block for locking order schema
> >   docs: cgroup-v1: fix footnotes
> >   docs: cgroup-v1: move hierarchy of accounting caption
> >   docs: cgroup-v1: use bullet lists for list of stat file tables
> >   docs: cgroup-v1: use make swap extension subsections subsections
> >   docs: cgroup-v1: add internal cross-references
> >   docs: cgroup-v1: use numbered lists for user interface setup
> >
> >  .../admin-guide/cgroup-v1/cgroups.rst         |   2 +
> >  .../admin-guide/cgroup-v1/memory.rst          | 290 ++++++++++--------
> >  2 files changed, 158 insertions(+), 134 deletions(-)
> 
> Tejun, do you have an opinion on these?  I'm not really sure we need to
> be tweaking the v1 docs at this point, but I don't see anything in here
> that seems harmful either...

One of the patches doesn't apply because it's against -next (it's
referencing -next sha1 too) and the series feels a bit overly elaborate but,
I mean, why not? I was planning to pick up the series after the holidays
unless you wanna route it through the doc tree.

Thanks.

-- 
tejun
