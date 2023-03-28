Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62806CCA23
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 20:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjC1Snk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 14:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjC1Snj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 14:43:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1452103
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 11:43:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id eg48so53510679edb.13
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 11:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680029002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rj2RQnjDsXwaVL7ntpieUXva4Ffe8kxZx/xthWWU0bA=;
        b=gsJgxRHD3bOgSTLtfz5lc8JsyfjCFq9/1NiJAHhPimNN7eSlnuIqbiYFd01bZKnjkP
         vevcfEYFS4Wi1X3PMT55jO0hLoanb2YDgLQB0gSA0WRGTU7cKXBQ7FdqWZXGIUTi0z/D
         uwwS34T9zxFwD124x/eKhqE+Q3wUyFb+2h4s1O+zEfRZmy/OhHw2EFVJgNUkqIBI9O3W
         P1W537yWyPHsem/Dbp1zlCM6bVIkxo4eis/m7QM9I4yKYCM8l+XkutscKtdNCdql72dA
         78QHdu1hsBdcel8kv8irSlL4e6NqUJGVkREQTZ4WoslS1aU7O0XplLGhNFJ9T9qXSA5z
         Fklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj2RQnjDsXwaVL7ntpieUXva4Ffe8kxZx/xthWWU0bA=;
        b=QvmTPOyAf7VRLlifjD0bC6pTUMdevyXjlDTwW3DQt3RkhXqxZc9xtBRLIN5cRVoV8C
         ExrgK3TzvAm5eABRZGiiv2I5M0Zw4fRC4RnfNrEvUNl1T/ZoeSiZWpW8m9Ri5xPuNiDs
         dtUDn8NuFeGMbfUSM8DG/TxPIrdOhekGxy4iHUyV6nmE55bUgA06RwFhYy04EHf7Za1q
         ti1xlmaWr+5S2NDSmlWap+irwGtNKOEgSxpzmveISWYtdo9R+Dgib+9biHtv1ApbYZWJ
         VPKbTOsaCDjRPIHkp23lBDLfZJYKEW0v7PiuUJQgSk49LFJrI4c6RzVHlhmMyWOPHlDH
         UtFQ==
X-Gm-Message-State: AAQBX9fmasF7ThEWsKH0do6M5TjwzxLs091lXfZ0dnI8GabiLuVN6pLH
        5vFSiD0yB/0JRR63pNS2j//tJg==
X-Google-Smtp-Source: AKy350ZBgNqTLZmGafKvz39W/GT1Mit2dRqnjGmdrRbaKi3drMY5VIC19T1z7xf7oIKC0pmnW1Faqw==
X-Received: by 2002:a17:906:5849:b0:931:4b0b:73e3 with SMTP id h9-20020a170906584900b009314b0b73e3mr16287762ejs.65.1680029002767;
        Tue, 28 Mar 2023 11:43:22 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id b1-20020a1709065e4100b008ca52f7fbcbsm15499474eju.1.2023.03.28.11.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:43:22 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:43:21 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 7/9] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <ZCM1Sayt3nYZ9LL9@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-8-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-8-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:36AM +0000, Yosry Ahmed wrote:
> @@ -406,6 +406,8 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
>  	eviction <<= bucket_order;
>  
> +	/* Flush stats (and potentially sleep) before holding RCU read lock */
> +	mem_cgroup_flush_stats_ratelimited();
>  	rcu_read_lock();

Minor nit, but please keep the lock section visually separated by an
empty line between the flush and the rcu lock.

Other than that,

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
