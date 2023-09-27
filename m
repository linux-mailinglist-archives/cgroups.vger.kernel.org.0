Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00FF7B02A7
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 13:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjI0LVa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjI0LVZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 07:21:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A93F180;
        Wed, 27 Sep 2023 04:21:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8D79218EB;
        Wed, 27 Sep 2023 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695813681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iheTTLd3Z1Ys92CI3hXi6CHRL4MwII17mSI0D1gw4bQ=;
        b=gWDd1nXm1nscic6L7Jwf9q2B5gbk77vFLbIn+4AfQHYLedfamb0kNbc91XohYjFCmLsDCw
        P4E907eIqOJ2o9wV3NumXS2a9J5XzLk1t4LfMx5Q7GszT3xbqPQWSI7KgcHmuV27wQBWNr
        hl+9WCXmlP0PIPHw/L0X4DpE7OVWOq0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 949D313479;
        Wed, 27 Sep 2023 11:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id g406ITEQFGUpVAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 27 Sep 2023 11:21:21 +0000
Date:   Wed, 27 Sep 2023 13:21:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, riel@surriel.com, hannes@cmpxchg.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, mike.kravetz@oracle.com, yosryahmed@google.com,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 0/2] hugetlb memcg accounting
Message-ID: <ZRQQMABiVIcXXcrg@dhcp22.suse.cz>
References: <20230926194949.2637078-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926194949.2637078-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 26-09-23 12:49:47, Nhat Pham wrote:
> Currently, hugetlb memory usage is not acounted for in the memory
> controller, which could lead to memory overprotection for cgroups with
> hugetlb-backed memory. This has been observed in our production system.
> 
> This patch series rectifies this issue by charging the memcg when the
> hugetlb folio is allocated, and uncharging when the folio is freed. In
> addition, a new selftest is added to demonstrate and verify this new
> behavior.

The primary reason why hugetlb is living outside of memcg (and the core
MM as well) is that it doesn't really fit the whole scheme. In several
aspects. First and the foremost it is an independently managed resource
with its own pool management, use and lifetime.

There is no notion of memory reclaim and this makes a huge difference
for the pool that might consume considerable amount of memory. While
this is the case for many kernel allocations as well they usually do not
consume considerable portions of the accounted memory. This makes it
really tricky to handle limit enforcement gracefully.

Another important aspect comes from the lifetime semantics when a proper
reservations accounting and managing needs to handle mmap time rather
than than usual allocation path. While pages are allocated they do not
belong to anybody and only later at the #PF time (or read for the fs
backed mapping) the ownership is established. That makes it really hard
to manage memory as whole under the memcg anyway as a large part of
that pool sits without an ownership yet it cannot be used for any other
purpose.

These and more reasons where behind the earlier decision o have a
dedicated hugetlb controller.

Also I will also Nack involving hugetlb pages being accounted by
default. This would break any setups which mix normal and hugetlb memory
with memcg limits applied.
-- 
Michal Hocko
SUSE Labs
