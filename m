Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E88663C0E
	for <lists+cgroups@lfdr.de>; Tue, 10 Jan 2023 10:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbjAJJBC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Jan 2023 04:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbjAJI7w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Jan 2023 03:59:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563AF4D71E;
        Tue, 10 Jan 2023 00:58:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4930267AEB;
        Tue, 10 Jan 2023 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673341100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MQLMOsWeyfQ9OMwOEPpBfSY/zX1K5gLRGoJXs0PRFhQ=;
        b=d0/gJhZr3338arujv292RDCpaFVCNpNRhfmbIWIBvXye7cZy8BnXDKXCy9uBlP+DXmqzhv
        vH5AzxAF9dGjzxCxyUj1ty+EwLrjZ3mqqo1g8JsfnV+KA79R00NSzTgm9DNtTFXOX4Gf8S
        h+jlN7NEV2XA5L/y7LnIoWd7unR8GQs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28CB313338;
        Tue, 10 Jan 2023 08:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 36wFB6wovWP/IgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 10 Jan 2023 08:58:20 +0000
Date:   Tue, 10 Jan 2023 09:58:19 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     "T.J. Mercier" <tjmercier@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel.vetter@ffwll.ch, android-mm@google.com, jstultz@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/4] memcg: Track exported dma-buffers
Message-ID: <Y70oqxejnUqkJVPx@dhcp22.suse.cz>
References: <20230109213809.418135-1-tjmercier@google.com>
 <20230109213809.418135-2-tjmercier@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109213809.418135-2-tjmercier@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 09-01-23 21:38:04, T.J. Mercier wrote:
> When a buffer is exported to userspace, use memcg to attribute the
> buffer to the allocating cgroup until all buffer references are
> released.
> 
> Unlike the dmabuf sysfs stats implementation, this memcg accounting
> avoids contention over the kernfs_rwsem incurred when creating or
> removing nodes.

I am not familiar with dmabuf infrastructure so please bear with me.
AFAIU this patch adds a dmabuf specific counter to find out the amount
of dmabuf memory used. But I do not see any actual charging implemented
for that memory.

I have looked at two random users of dma_buf_export cma_heap_allocate
and it allocates pages to back the dmabuf (AFAIU) by cma_alloc
which doesn't account to memcg, system_heap_allocate uses
alloc_largest_available which relies on order_flags which doesn't seem
to ever use __GFP_ACCOUNT.

This would mean that the counter doesn't represent any actual memory
reflected in the overall memory consumption of a memcg. I believe this
is rather unexpected and confusing behavior. While some counters
overlap and their sum would exceed the charged memory we do not have any
that doesn't correspond to any memory (at least not for non-root memcgs).

-- 
Michal Hocko
SUSE Labs
