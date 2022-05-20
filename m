Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1EA52E1CA
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 03:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbiETBTB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 21:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239345AbiETBTB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 21:19:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5962037002
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 18:19:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fedd52e3c7so59847497b3.15
        for <cgroups@vger.kernel.org>; Thu, 19 May 2022 18:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6CTUhgjUo83Du844ljegCXcw0SIVsWK556UKC8YwhGM=;
        b=JjZ4zTDWiB1nRfl2wC3BsM34tJOz6BnpAkzjM0rDRRpVqW5wr4jPCl1W10bF/oVI4i
         kfNM7xy1sWyNzlErQbLJpvvZ/eh+JUR3GuYKxZaVXVC/mGj8aPBDTqc5fXOqt77buNhq
         +3tlliTSlpw+P5FkV4v72rF54Y7mFmb6UIIDoyIUiN2peDKDKr8kcciBU+qG8ahNzUll
         Z9Dqqj8fvA05IoK2XUKC16G0CfibMIezwCct8opoG3bua8nGrcLUnsbXOaGFjQs1yumH
         g5HeiRKAieKuBxiN0Y/jWP2z6f2JaDWI3aqoDLsHvV3lWpnGPUnuA7p9+Ck3rklSRHIw
         I4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6CTUhgjUo83Du844ljegCXcw0SIVsWK556UKC8YwhGM=;
        b=dZ7tre5lKroBrmg8mzA59mA8bnfD6QkaE6smRv7TqjU0l384aH2NoKly1HaWDAtgJm
         h6UqyTbbj1dsYE1iYHBQhpO9fuIfuzQ1mDcae1ebG1Gg/DHs1zfQ2ud9V2uEaasMnLwa
         IBca3DL63/RpX3ERc3JijWTbvpejN4IEvtgTEVMxFyEcLVsnNbH/wF9l6etAmSBzfKIX
         /56cRilgbL48UaQ/ZBqOobuXamsl19q8M69v6ZDjUK6GQWZoCsP9tYTl3tx5z4vRKG54
         vPultV4AoVWn8+q5Er/pjF0MTanSozuJHe1IAixJmEvDs5c2SqTdw/OjMxGTLRmUB22o
         ruqw==
X-Gm-Message-State: AOAM530Lk5sgW4ahxSmGRhhqVNV6V8Re/5M7sgFxrWw7xEZRu6elFKXs
        d55VD35pN593V95mrZSMktWae2RFcnpvOg==
X-Google-Smtp-Source: ABdhPJwcEXDTff4JJX+Mtg7rEUECZTqaD4S9sbg4gxt52p5COAmY87tzLQaah2Hf5rLMkcBb1PIDneg0QcDR9Q==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:9c03:0:b0:64b:968c:3a2a with SMTP id
 c3-20020a259c03000000b0064b968c3a2amr6954721ybo.57.1653009539588; Thu, 19 May
 2022 18:18:59 -0700 (PDT)
Date:   Fri, 20 May 2022 01:18:57 +0000
In-Reply-To: <30f5b95a-db87-3924-6ad0-4c302c924ff0@openvz.org>
Message-Id: <20220520011857.ggonbc32peagkhl2@google.com>
Mime-Version: 1.0
References: <Ynv7+VG+T2y9rpdk@carbon> <30f5b95a-db87-3924-6ad0-4c302c924ff0@openvz.org>
Subject: Re: [PATCH 4/4] memcg: enable accounting for allocations in alloc_fair_sched_group
From:   Shakeel Butt <shakeelb@google.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 06:52:20PM +0300, Vasily Averin wrote:
> Creating of each new cpu cgroup allocates two 512-bytes kernel objects
> per CPU. This is especially important for cgroups shared parent memory
> cgroup. In this scenario, on nodes with multiple processors, these
> allocations become one of the main memory consumers.
> 
> Accounting for this memory helps to avoid misuse inside memcg-limited
> contianers.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
