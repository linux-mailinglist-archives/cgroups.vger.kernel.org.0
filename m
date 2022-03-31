Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513364EDC4F
	for <lists+cgroups@lfdr.de>; Thu, 31 Mar 2022 17:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237011AbiCaPFl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 11:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiCaPFl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 11:05:41 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4931DC6
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 08:03:52 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id c4so21619605qtx.1
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 08:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d1kYZrmObSeZbyw3RMt9FzoTsF57Tn5L7U9ZzVddVG4=;
        b=e2xD+tga/GoLwXnWljxsycUVzkUHHyFtBZKj9ohJ3DP81/4ckKV/P9xjMrfLtBjaN8
         Y0jQRfJ0wP4mfKhofDqV7PBy2k7vHUHo0TufYPjQRU543RWwSgi458e5LByUAvekjqD6
         6mlrpkeoiYpUpBurMZwQncB+hcsM4fnzgrTSoPR45s5VhDL9WiWRUs9iec9d8NzGqATk
         aigMYifkF1/doRpuLcRVcPWvkVIQZ1qExWkm5fTs3sjVJH30REhh3Q6Qjb0Oi2JXZxPq
         wU1ti7XW3WX2DApr61woyuQxTDHY+thYU3CFYK68PNE2xWO7fIdGDsFTszmbSqBKt/8T
         XEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d1kYZrmObSeZbyw3RMt9FzoTsF57Tn5L7U9ZzVddVG4=;
        b=vm+1RLNGddvZeFG6AMlHfjo2JCRWeJg3kCy6jWtYgOsjmoFSTjtE/iJnFwdXJ7AU+l
         xIVC5iJ067RERM1CvTwB7d3mXxHhvwu/wcSQAsH6TYlvzw6jdHKxmhoRR2nZWMi+8ss1
         mzzs6TWDgOfpFfKJfSc3uwYgXpKRFym0c6GZkN7cdkRhNYNP2xMO6N/K88+D3wVOH69h
         QviF3i/2Emay6InfIgmfm18WD2MAHMo0hg6ooAG9VEW77GcJF7lhikfSHh6+Ah6suskD
         ifhj6lu3EH7n405gmujZq2fnTzWl3mtSb9Ws3bL8p+tnviTVcPWEsYCs41pWIf5bNY4T
         V3Mg==
X-Gm-Message-State: AOAM531OfDHhOS69SrGvKBFRaAk0mNA9tcmX9SfwDnyn5HIvGwmfpggx
        4SPH3PfjD+55W/wF41jHu+ltaQ==
X-Google-Smtp-Source: ABdhPJwK/dO1SqlWZzy8Ome1xM0rJLftTCnmGQoUxC0JJNCTJoYeogOobH0D44OOIICSVVy0CzD0mg==
X-Received: by 2002:a05:622a:1905:b0:2e0:7543:21d4 with SMTP id w5-20020a05622a190500b002e0754321d4mr4845011qtc.12.1648739031643;
        Thu, 31 Mar 2022 08:03:51 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id j4-20020a37c244000000b0067d79a3fd0esm12903088qkm.106.2022.03.31.08.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:03:51 -0700 (PDT)
Date:   Thu, 31 Mar 2022 11:03:50 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [Patch v2 2/3] mm/memcg: set pos explicitly for reclaim and
 !reclaim
Message-ID: <YkXC1l27pUjwRDJa@cmpxchg.org>
References: <20220330234719.18340-1-richard.weiyang@gmail.com>
 <20220330234719.18340-3-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330234719.18340-3-richard.weiyang@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 30, 2022 at 11:47:18PM +0000, Wei Yang wrote:
> During mem_cgroup_iter, there are two ways to get iteration position:
> reclaim vs non-reclaim mode.
> 
> Let's do it explicitly for reclaim vs non-reclaim mode.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
