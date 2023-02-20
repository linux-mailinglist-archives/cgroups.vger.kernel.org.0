Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5223069D584
	for <lists+cgroups@lfdr.de>; Mon, 20 Feb 2023 22:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjBTVJx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Feb 2023 16:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjBTVJw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Feb 2023 16:09:52 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571721C5BB;
        Mon, 20 Feb 2023 13:09:51 -0800 (PST)
Date:   Mon, 20 Feb 2023 13:09:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676927389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8JBYS9FvWj14eT3JNuqmdGK9JV/xnFH80x2sQQSrkTI=;
        b=ddyUu3zsm6Y0+vR74DJIcnENOFBU8ue0+E83vkrKf6R+AXgHiE5UZ30o4jj02lbdkPvcYt
        hUCpldBu9NYSmkpAO3+ReRrGa6FiNIZdA+U5woA1UPiRVI9z6yNGlYdYQvvLUTggIAmbrf
        IhM61gJLeSwVxu90+kkRBSSiNec/GKE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yue Zhao <findns94@gmail.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, shakeelb@google.com, muchun.song@linux.dev,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
Message-ID: <Y/PhmEPc/qYeZ52T@P9FQF9L96D>
References: <20230220151638.1371-1-findns94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220151638.1371-1-findns94@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> The knob for cgroup v2 memory controller: memory.oom.group
> will be read and written simultaneously by user space
> programs, thus we'd better change memcg->oom_group access
> with atomic operations to avoid concurrency problems.
> 
> Signed-off-by: Yue Zhao <findns94@gmail.com>

Hi Yue!

I'm curious, have any seen any real issues which your patch is solving?
Can you, please, provide a bit more details.

Also, WRITE/READ_ONCE() don't generally make operations atomic,
they only prevent the compiler from merging and re-fetching reads
and writes.

Thanks!
