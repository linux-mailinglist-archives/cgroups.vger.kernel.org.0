Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064387BEF8D
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 02:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379188AbjJJANU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 20:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379155AbjJJANU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 20:13:20 -0400
Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D166A4
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 17:13:19 -0700 (PDT)
Date:   Mon, 9 Oct 2023 17:13:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696896797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZeq0QRWRWi6ocPj6CHnmD55De3FO2vm3Swj0y/CU04=;
        b=sPH06k4kpYsnUUlTXM40LLCDKORqerwr68VfdM8QOQ4wUV3V6p3Q3HHMdZUCiBrPLFTRvE
        +7mP4wWsJaRvfrg45J0eH24hka54JixJvNvXJwQRQyXyNitPcvng11f0CLUSackGw6rCRD
        68RF24lgJFGGJjPsz4BHrkx0zT65arA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v2 0/5] mm: improve performance of accounted kernel
 memory allocations
Message-ID: <ZSSXGOpkwqs8MOvT@P9FQF9L96D>
References: <20231010000929.450702-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010000929.450702-1-roman.gushchin@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Andrew,

can you, please, drop v1 entirely (with all follow-up fixes)
and replace it with v2?

Thanks!
