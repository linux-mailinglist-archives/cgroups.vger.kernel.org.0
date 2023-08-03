Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3212C76EF06
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjHCQId (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbjHCQIc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 12:08:32 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393402D7E
        for <cgroups@vger.kernel.org>; Thu,  3 Aug 2023 09:08:30 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-765ae938b1bso85404585a.0
        for <cgroups@vger.kernel.org>; Thu, 03 Aug 2023 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1691078909; x=1691683709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XToHAF3Tp6ttDMOwj4eUjXmrH43hQkGliAE52bu3OI=;
        b=nwBfuP1EF89+aISDQLUPsPs557pMHRTYHh/moPt/GEUf3VZSegFJN2WLjwtOxNaeVr
         tELhzCnpQiVVzn/p9TxTM40ypLAI9Wl8Dm00Ma0u6gCG9cYdJZyEwo/8Du3Xb48kiI3S
         aj+mMtHg5P4dd9nwwPCbs602BbZueBi9x/ZXCX+ClObKOCBNOJ2QGS2u1cys65T6jh4F
         sdy7Pm6FD7EqT02Lj5dytAzyu/Lm8M/yCK7CYer/QhZjZ1QXAsA3k1m/WtIhfHYpfDaQ
         JTwBdRXqxtir8UKBvShgRNW5OjaHl24g01HNtAzPqjO+63i2Pwtjedb13yOisZI7uZQ1
         KP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691078909; x=1691683709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XToHAF3Tp6ttDMOwj4eUjXmrH43hQkGliAE52bu3OI=;
        b=X2nV8EQVOLn/LlK3MKfX/FABbh7WKeoCkjAtB/YerYVZrhroni3EDm+M/4Y5hlYpw+
         +sZeeTXti1XjLWB8bDVEwpLIEfVUuPrvUXbTFZXbTOmNBQi1GJq9RFZseULkM5ZZdO0Q
         sYsKYBq8NmrJF8IqbGFZmhvvSV/UjOdUXi8/IDgd1+RecwH7gcXC+z1lULoFHnpYXQ8L
         EjXDwWdQOGr2vzoOTvIhZtnX3HIEdrWdmlWIIHJ+wcSxc968/nDd5jLeld229MRXJJrP
         q9pDuylExPmKKDkJ+Q4Y2ssrN3QCm02IW8cncJCeKzHVUqpC9wc6ENJZw4ofWQsFCkG7
         gG/g==
X-Gm-Message-State: ABy/qLY+YVujwKTpj8AQEpthO+VzgCE5piT1DeOp/hlLiOaM2UXlPMD2
        vX3JUOjYnU/2D8wJox2DaZlXoQ==
X-Google-Smtp-Source: APBJJlE/HITWbFDhpZ/D5lR41JynAMCPkaudsb/XHWlqv+SykPhRMLbLhtMkySOs7sEOxK1mOiRSuw==
X-Received: by 2002:a37:5a05:0:b0:767:2471:c880 with SMTP id o5-20020a375a05000000b007672471c880mr18403599qkb.28.1691078909290;
        Thu, 03 Aug 2023 09:08:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:9910])
        by smtp.gmail.com with ESMTPSA id g16-20020ae9e110000000b0076cb0ed2d7asm14050qkm.24.2023.08.03.09.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:08:29 -0700 (PDT)
Date:   Thu, 3 Aug 2023 12:08:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Lucas Karpinski <lkarpins@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: cgroup: fix test_kmem_basic slab1 check
Message-ID: <20230803160828.GA223746@cmpxchg.org>
References: <ix6vzgjqay2x7bskle7pypoint4nj66fwq7odvd5hektatvp2l@kukoifnfj3dr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ix6vzgjqay2x7bskle7pypoint4nj66fwq7odvd5hektatvp2l@kukoifnfj3dr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 03, 2023 at 12:00:47PM -0400, Lucas Karpinski wrote:
> test_kmem_basic creates 100,000 negative dentries, with each one mapping
> to a slab object. After memory.high is set, these are reclaimed through
> the shrink_slab function call which reclaims all 100,000 entries. The
> test passes the majority of the time because when slab1 is calculated,
> it is often above 0, however, 0 is also an acceptable value.
> 
> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> @@ -71,7 +71,7 @@ static int test_kmem_basic(const char *root)
>  
>  	cg_write(cg, "memory.high", "1M");
>  	slab1 = cg_read_key_long(cg, "memory.stat", "slab ");
> -	if (slab1 <= 0)
> +	if (slab1 < 0)
>  		goto cleanup;

This conflicts with a recent patch already queued up in -mm:

  selftests: cgroup: fix test_kmem_basic false positives

which adds a sleep(1) between cg_write() and cg_read_key_long().

Can you please rebase on top of

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable

and re-send the patch with

  To: Andrew Morton <akpm@linux-foundation.org>

? Thanks

