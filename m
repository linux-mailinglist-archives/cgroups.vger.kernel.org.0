Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31795B2B17
	for <lists+cgroups@lfdr.de>; Fri,  9 Sep 2022 02:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiIIA0p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Sep 2022 20:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiIIA0o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Sep 2022 20:26:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661A0B6D7F;
        Thu,  8 Sep 2022 17:26:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 022341F74A;
        Fri,  9 Sep 2022 00:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662683202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLbPE0Wn9MUv5iN+ZKgk87GvaSESM1SLfiGAHxsb7sE=;
        b=M74DCUqR4Zhu9qqowdIzC0yWGEoMxSvugFKMY6JydiDEwLYyXEwH+g1XQQml9JPnNg32Hz
        mbxmvw39Sc18R00K1lESxAGd+PBORN4d2sIqExz+Xv3FSi1hhzsEO6JM0hbam1jNxG//tS
        Ux5JGHlq845aLt0NMqCQKtgNo4wBibM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9EE413A93;
        Fri,  9 Sep 2022 00:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XX8wLEGIGmO3MAAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 09 Sep 2022 00:26:41 +0000
Date:   Fri, 9 Sep 2022 02:26:40 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] memcg: extract memcg_vmstats from struct mem_cgroup
Message-ID: <YxqIQOWzrsrPnff3@blackbook>
References: <20220907043537.3457014-1-shakeelb@google.com>
 <20220907043537.3457014-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907043537.3457014-2-shakeelb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi.

On Wed, Sep 07, 2022 at 04:35:35AM +0000, Shakeel Butt <shakeelb@google.com> wrote:
> This is a preparatory patch to reduce the memory overhead of memory
> cgroup. The struct memcg_vmstats is the largest object embedded into the
> struct mem_cgroup. 
> This patch extracts struct memcg_vmstats from struct
> mem_cgroup to ease the following patches in reducing the size of struct
> memcg_vmstats.

Is the reason for the extraction just moving things away from the header
file?
Or is the separate allocation+indirection somehow beneficial wrt, e.g.
fragmentation?

Thanks,
Michal
