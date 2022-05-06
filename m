Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E251D984
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 15:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384838AbiEFNpn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 May 2022 09:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441886AbiEFNpg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 May 2022 09:45:36 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3A538DAB;
        Fri,  6 May 2022 06:41:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5D55F1F91C;
        Fri,  6 May 2022 13:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651844512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pXZ/Mip46MPK94udG6dn0vA9jCul4KfitQH0YKOCKlo=;
        b=VV80UgGUua9ByI5dnKDgazpxk/aupgxGDKd9KoBkpD9krA/NR1XXVh6kgSKaZ7FUzsf8f0
        zkBRcq08cNuw+WGzG+8vRnfHpT3IQstg+wTRO7clRbPhs6BBEHLo0KCBFeEKzSE5o9Tl3z
        hIkEaaxexMDzsfw5D/nqLKWqnK7j/Zw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1D7312C142;
        Fri,  6 May 2022 13:41:51 +0000 (UTC)
Date:   Fri, 6 May 2022 15:41:50 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, willy@infradead.org,
        shy828301@gmail.com, roman.gushchin@linux.dev, shakeelb@google.com,
        linmiaohe@huawei.com, william.kucharski@oracle.com,
        peterx@redhat.com, hughd@google.com, vbabka@suse.cz,
        songmuchun@bytedance.com, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
Message-ID: <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505033814.103256-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 05-05-22 03:38:15, cgel.zte@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn> 
> 
> Using THP may promote the performance of memory, but increase memory
> footprint. Applications may use madvise to decrease footprint, but
> not all applications support using madvise, and it takes much costs
> to re-code all the applications. And we notice container becomes more
> and more popular to manage a set of tasks.

Could you be more specific about the actual usecase? When do you group
processes based on their general THP reqirements? You are mentioning
containers but those are usually bags of different processes that just
share a common objective.
 
> So add support for cgroup to control THP behaviour will provide much
> convenience, administrator may only enable THP for important containers,
> and disable it for other containers.

Why would that be a matter of importance?

Also what is actual semantic when processes living inside those cgroups
explicitly state their THP requirements?

-- 
Michal Hocko
SUSE Labs
