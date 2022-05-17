Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A995299F8
	for <lists+cgroups@lfdr.de>; Tue, 17 May 2022 08:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbiEQG5B (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 May 2022 02:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbiEQG4n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 May 2022 02:56:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9A29C9A
        for <cgroups@vger.kernel.org>; Mon, 16 May 2022 23:56:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6D9C3220E3;
        Tue, 17 May 2022 06:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652770600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YyW7EIH3WdepBr8smb4cheN1ADPHu7QpG6rwte21Qjg=;
        b=m/oYQcAlGSR8cd3cSSa95oAkOufK1I7s2sxcoa6y+R7OGFiMvaPHPclIN1g+nPqyCbKcql
        TYd9OdyuYfZEt21pg+XTSz4TwLd3Q9t9OUyyosOVF2J3jW6SAJwKL137fL8ZS5nyxUByqe
        911RSUPqMjG4vbAJlroiO9ipgHFvUiU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 22F362C141;
        Tue, 17 May 2022 06:56:40 +0000 (UTC)
Date:   Tue, 17 May 2022 08:56:39 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Yu Zhao <yuzhao@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>
Subject: Re: [RFC] Add swappiness argument to memory.reclaim
Message-ID: <YoNHJwyjR7NJ5kG7@dhcp22.suse.cz>
References: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkbDpyoODveCsnaqBBMZEkDvshXJmNdbk51yKSNgD7aGdg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 16-05-22 15:29:42, Yosry Ahmed wrote:
> The discussions on the patch series [1] to add memory.reclaim has
> shown that it is desirable to add an argument to control the type of
> memory being reclaimed by invoked proactive reclaim using
> memory.reclaim.
> 
> I am proposing adding a swappiness optional argument to the interface.
> If set, it overwrites vm.swappiness and per-memcg swappiness. This
> provides a way to enforce user policy on a stateless per-reclaim
> basis. We can make policy decisions to perform reclaim differently for
> tasks of different app classes based on their individual QoS needs. It
> also helps for use cases when particularly page cache is high and we
> want to mainly hit that without swapping out.

Can you be more specific about the usecase please? Also how do you
define the semantic? Behavior like vm_swappiness is rather vague because
the kernel is free to ignore (and it does indeed) this knob in many
situations. What is the expected behavior when user explicitly requests
a certain swappiness?
-- 
Michal Hocko
SUSE Labs
