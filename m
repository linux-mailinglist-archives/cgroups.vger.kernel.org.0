Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CA165DF0F
	for <lists+cgroups@lfdr.de>; Wed,  4 Jan 2023 22:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbjADV3q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Jan 2023 16:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240557AbjADV30 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Jan 2023 16:29:26 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C68DC0;
        Wed,  4 Jan 2023 13:27:41 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id k137so19045499pfd.8;
        Wed, 04 Jan 2023 13:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xdMyQrIHWeXBS5vaDhN2cRckBSGcEP38oOfunYml57w=;
        b=iX1y43d8OBGxLwGmJscAlBFVnoWSPofv9iXyHsuaXj45BXH9vjeirS5X7+rIV9ZZhI
         kgmsMBU1MysDrFbe5rtEWFt3D2dmZmvt2X51oLkbTZJaWB5ewxlLnwJhiMW7BreTmtfW
         gUO9PK9xlkX5hzeZQafxvgzJNW1B/yl2HD4O0wLbybwd/pYpO6kvt2y4c332bDDpWc17
         buMOo5EORzykQc5P1bAlU++s1JKjLPniSHO9H1zEkv4emgaz3yQe4kJPFanSwrCTgIK3
         /Q+NYDb2RAQraD1dbEv0ycfBtTFyFeBCuk0miK7rATtvKPXxIMcj5DbUXdFZIDn6+JSO
         5q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xdMyQrIHWeXBS5vaDhN2cRckBSGcEP38oOfunYml57w=;
        b=6NSBQ9KIrx47UwI7BTO3Qw3sOYBIqpDi31eiIWxDY+tufgVlbeHBCg5ZsHOSydFJOE
         IkXQtUDresDR+EoXgNRW6h8VnW87alQcLrrdo4agD691EK91T6ChT7ferX5Gk48EiK0g
         lJE6ya/kyq8NqCDSXEYWKXN7y7nFrUFYaFN3qh7yVv+sK9Fx6XiS7n18cn9WgEst4xtX
         y9vxLXvmZuOqOlrGMfoAoqPvlddLJKYH015e3zM2jz29LyCXB9bXoS+fk40igs5tDjbR
         EtkIN6aAwctS5osBJjnq6UDjblYLv/I/8CPJMM/t41ZCVsjhj0hDimMJ5afhZMK7uruH
         ShAQ==
X-Gm-Message-State: AFqh2koLIQ5VklFdXsBpUycJ7rOmfyaCasK/IYnZPO/BwLsFRgIAk2OP
        RP2s+020kGZTDTaeDWatxKGroHmv0i8=
X-Google-Smtp-Source: AMrXdXvhpuwOOVfrKEsoZWgSrWme3m5gOzE/qQ8ObvZGAs31erUxihR0pPQenvtgB+5fhqu4d5DaQg==
X-Received: by 2002:aa7:8594:0:b0:581:f301:23fc with SMTP id w20-20020aa78594000000b00581f30123fcmr21332893pfn.12.1672867661193;
        Wed, 04 Jan 2023 13:27:41 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id a184-20020a624dc1000000b00576cc60e5c9sm22939324pfb.87.2023.01.04.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:27:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 4 Jan 2023 11:27:39 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH 00/10] docs: cgroup-v1: formatting improv for "Memory
 Resource Controller" doc
Message-ID: <Y7XvS5LJK01lWq48@slm.duckdns.org>
References: <20221219042209.22898-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219042209.22898-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 19, 2022 at 11:21:59AM +0700, Bagas Sanjaya wrote:
> "Memory Resource Controller" CGroup v1 documentation has been in reST
> since 99c8b231ae6c6c ("docs: cgroup-v1: convert docs to ReST and rename to *.rst"). The current doc look is kinda ugly, so improve the formatting (only
> htmldocs is tested).
> 
> The first patch is a fix for recently reported htmldocs warning, which can
> be pickup separately from rest of the series.
> 
> Bagas Sanjaya (10):
>   docs: cgroup-v1: extend underline of section 8
>   docs: cgroup-v1: replace custom note constructs with appropriate
>     admonition blocks
>   docs: cgroup-v1: wrap remaining admonitions in admonition blocks
>   docs: cgroup-v1: use code block for locking order schema
>   docs: cgroup-v1: fix footnotes
>   docs: cgroup-v1: move hierarchy of accounting caption
>   docs: cgroup-v1: use bullet lists for list of stat file tables
>   docs: cgroup-v1: use make swap extension subsections subsections
>   docs: cgroup-v1: add internal cross-references
>   docs: cgroup-v1: use numbered lists for user interface setup
> 
>  .../admin-guide/cgroup-v1/cgroups.rst         |   2 +
>  .../admin-guide/cgroup-v1/memory.rst          | 290 ++++++++++--------
>  2 files changed, 158 insertions(+), 134 deletions(-)

Patchset doesn't apply. Can you please rebase on top of linus#master and
drop reference to the commit in -next?

Thanks.

-- 
tejun
