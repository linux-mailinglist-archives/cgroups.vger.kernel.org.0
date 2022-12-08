Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E418F6471D8
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 15:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiLHOgl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 09:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHOgl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 09:36:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA768C7D
        for <cgroups@vger.kernel.org>; Thu,  8 Dec 2022 06:36:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id x22so4481466ejs.11
        for <cgroups@vger.kernel.org>; Thu, 08 Dec 2022 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XpT/D9wiadtdd3e4LD/NlNKNROKlLGu0EeO/Y2cMVkU=;
        b=yaLVQV2sZvB66nEBKpEDKn1QIIFVfhV06yDQIM+8N2W90AxPc9Vrl/BgiiNABpQZYo
         w2p4bz4FMdjPz2rhPDLmHgcUK5wfEhpob+2m9bwgMetjD8AUuPdt4/KsnbczW1yU25ZM
         Te1vHw41kmz6KTwhNxqnrZeUeeuuJC18TCZWuJRIaOmq8wM85+i/9IicaILlnBHalFwQ
         oagzbVgq6jkXLuezmCsOnnFVTZc0eqHwOIpWYWgI8BlNgC0Tbeo9PXFRolB1/9l2IiVa
         Sl2a4vyf83n1mIs2h/qlWXgiX8yqbZdwCpFONfyadCGCxoYjpSmzplWq/5XmV2UI31qq
         0/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpT/D9wiadtdd3e4LD/NlNKNROKlLGu0EeO/Y2cMVkU=;
        b=df+4JqWhOXljEpy7OigRnOy5R5bMYObZMGPF4RCSfRRrYOb8mxuHloiD9HpQGqllVz
         S7Fu5zU/+jDG16Nbgh5DP9nn3rt7VEmGidxonNCNwVHY91GGG7WgdNzS2hRs9BwsXHQt
         xEbYpRJkYJvHAobhZ9Yfl4LYi7wRZ2bFg4/+tfTHRB5RFMnMYsyHv7jFF4c1e4+FxaQb
         f0s8r/Zxp6udNM00xbfZXb0xAdjhuEAjyWB0cDcKvSOss0I/H/0C6irAd4Ngd8QIxEaG
         JHJnhQRqj5yVurTflwS7Q7qvRvtqdNgpxv19u0NF0fp6m+70JZ2ffe5DUYU4BIpNfwiG
         85vQ==
X-Gm-Message-State: ANoB5pmmNnIHoyaOmtupMcTy5WvRJ/6QgEslGQwrce1Obex6DqSJvcCO
        6eWbGNkw1iJrQPg5fXCyNXpNUg==
X-Google-Smtp-Source: AA0mqf5oStqmxj38CinNuMDiiE0ovdTkzdEtA6ey7UvoYb64akzWa6ABnN+e/aaRla/b7iY0LqqUEQ==
X-Received: by 2002:a17:907:80c3:b0:7a2:7226:6c39 with SMTP id io3-20020a17090780c300b007a272266c39mr2416897ejc.23.1670510197614;
        Thu, 08 Dec 2022 06:36:37 -0800 (PST)
Received: from localhost (ip-046-005-139-011.um12.pools.vodafone-ip.de. [46.5.139.11])
        by smtp.gmail.com with ESMTPSA id gi20-20020a1709070c9400b0077d6f628e14sm9810461ejc.83.2022.12.08.06.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 06:36:37 -0800 (PST)
Date:   Thu, 8 Dec 2022 15:36:34 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH for-6.1-fixes] memcg: Fix possible use-after-free in
 memcg_write_event_control()
Message-ID: <Y5H2clPCac1gIE7I@cmpxchg.org>
References: <Y5FRm/cfcKPGzWwl@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5FRm/cfcKPGzWwl@slm.duckdns.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 07, 2022 at 04:53:15PM -1000, Tejun Heo wrote:
> memcg_write_event_control() accesses the dentry->d_name of the specified
> control fd to route the write call. As a cgroup interface file can't be
> renamed, it's safe to access d_name as long as the specified file is a
> regular cgroup file. Also, as these cgroup interface files can't be removed
> before the directory, it's safe to access the parent too.
> 
> Prior to 347c4a874710 ("memcg: remove cgroup_event->cft"), there was a call
> to __file_cft() which verified that the specified file is a regular cgroupfs
> file before further accesses. The cftype pointer returned from __file_cft()
> was no longer necessary and the commit inadvertently dropped the file type
> check with it allowing any file to slip through. With the invarients broken,
> the d_name and parent accesses can now race against renames and removals of
> arbitrary files and cause use-after-free's.
> 
> Fix the bug by resurrecting the file type check in __file_cft(). Now that
> cgroupfs is implemented through kernfs, checking the file operations needs
> to go through a layer of indirection. Instead, let's check the superblock
> and dentry type.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Fixes: 347c4a874710 ("memcg: remove cgroup_event->cft")
> Cc: stable@vger.kernel.org # v3.14+
> Reported-by: Jann Horn <jannh@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
