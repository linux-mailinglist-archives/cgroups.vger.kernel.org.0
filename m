Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046678588D
	for <lists+cgroups@lfdr.de>; Wed, 23 Aug 2023 15:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbjHWNMs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Aug 2023 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjHWNMr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Aug 2023 09:12:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B56E4E;
        Wed, 23 Aug 2023 06:12:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 467D820829;
        Wed, 23 Aug 2023 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692796362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uz09CIFb4phUja5aPxrRB0e9q5bhxoa70nYLw9mLuHM=;
        b=jWTBefLrqe2p82kmhfsYvU/xVcAN6GLUbIIDYYcXdMJBReUCLsL7ElyotvzvcBfOpqzO/t
        1hb3KK7+IQXveL1TfELQbWLV8euLDx/p1JGmt5VU/+RbtQbaVs3R/7z0gQg2JU8KqWMciz
        7M+WaltLFLrP9qJqGJtUdr9uAG1bdzE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23EB713458;
        Wed, 23 Aug 2023 13:12:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id woQJBsoF5mSEZwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 23 Aug 2023 13:12:42 +0000
Date:   Wed, 23 Aug 2023 15:12:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        wangkefeng.wang@huawei.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: vmscan: reclaim anon pages if there are swapcache
 pages
Message-ID: <ZOYFydIp3q8BNrEa@dhcp22.suse.cz>
References: <20230822024901.2412520-1-liushixin2@huawei.com>
 <CAJD7tkZkYsopuqGH_Lo=kE4=HO33wmvK6mXhuq4p_KZ6pYuXtw@mail.gmail.com>
 <50c49baf-d04a-f1e3-0d0e-7bb8e22c3889@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50c49baf-d04a-f1e3-0d0e-7bb8e22c3889@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 23-08-23 10:00:58, Liu Shixin wrote:
> 
> 
> On 2023/8/23 0:35, Yosry Ahmed wrote:
> > On Mon, Aug 21, 2023 at 6:54 PM Liu Shixin <liushixin2@huawei.com> wrote:
> >> When spaces of swap devices are exhausted, only file pages can be reclaimed.
> >> But there are still some swapcache pages in anon lru list. This can lead
> >> to a premature out-of-memory.
> >>
> >> This problem can be fixed by checking number of swapcache pages in
> >> can_reclaim_anon_pages(). For memcg v2, there are swapcache stat that can
> >> be used directly. For memcg v1, use total_swapcache_pages() instead, which
> >> may not accurate but can solve the problem.
> > Interesting find. I wonder if we really don't have any handling of
> > this situation.
> I have alreadly test this problem and can confirm that it is a real problem.
> With 9MB swap space and 10MB mem_cgroup limit，when allocate 15MB memory,
> there is a probability that OOM occurs.

Could you be more specific about the test and the oom report?

-- 
Michal Hocko
SUSE Labs
