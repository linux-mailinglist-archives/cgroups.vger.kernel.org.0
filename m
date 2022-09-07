Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88405B105B
	for <lists+cgroups@lfdr.de>; Thu,  8 Sep 2022 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiIGX1h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 19:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiIGX1h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 19:27:37 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2644A95AD3;
        Wed,  7 Sep 2022 16:27:33 -0700 (PDT)
Date:   Wed, 7 Sep 2022 16:27:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662593251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TaKcAPnW1Rv+P8V2WVmdtPwTsnlpyaGaJZ+gn5WE91Y=;
        b=ccqnbVj+QPPasLxHBGE6AFu8Yoq671MiQPkkyRGJgyLs7qpb2LL2u4wMhuPhWCx2es0Ow0
        vm2SBlmaYjH8gKdhHyNdc9jnyC4Ik2/2sgdVZTnqm7dxc35nofvltU0Mtl84Fx2WLrNhIZ
        DL6do2sxzUEfuACz0QOFL05zurqThbg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] memcg: reduce size of memcg vmstats structures
Message-ID: <Yxko0AxuVO6oiN5M@P9FQF9L96D.corp.robot.car>
References: <20220907043537.3457014-1-shakeelb@google.com>
 <20220907043537.3457014-4-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907043537.3457014-4-shakeelb@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 07, 2022 at 04:35:37AM +0000, Shakeel Butt wrote:
> The struct memcg_vmstats and struct memcg_vmstats_percpu contains two
> arrays each for events of size NR_VM_EVENT_ITEMS which can be as large
> as 110. However the memcg v1 only uses 4 of those while memcg v2 uses
> 15. The union of both is 17. On a 64 bit system, we are wasting
> approximately ((110 - 17) * 8 * 2) * (nr_cpus + 1) bytes which is
> significant on large machines.
> 
> This patch reduces the size of the given structures by adding one
> indirection and only stores array of events which are actually used by
> the memcg code. With this patch, the size of memcg_vmstats has reduced
> from 2544 bytes to 1056 bytes while the size of memcg_vmstats_percpu has
> reduced from 2568 bytes to 1080 bytes.

This is pretty impressive!

Thank you, Shakeel!

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for the series.

Thanks!
