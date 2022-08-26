Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCF95A220E
	for <lists+cgroups@lfdr.de>; Fri, 26 Aug 2022 09:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244999AbiHZHiX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 26 Aug 2022 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244859AbiHZHiW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 26 Aug 2022 03:38:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C81E3E7;
        Fri, 26 Aug 2022 00:38:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B90F433687;
        Fri, 26 Aug 2022 07:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661499500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RtYcNt5XkJRCJhjOhp/OsUYuN7jr0K2tW7LntfrhxP0=;
        b=I83xBB1b8caTVTsQfISvp8FIA6foX4NceUMAUYAmwPJBwHop0a0Gzweik2JXe457EyMmtN
        lSClOj6h8yDjeJxxWe7yi6oWSwq5m/lU52xMew9cIuPfHGqSESJsh2j1xWq98TMK759ova
        nDVuukr7lE2gmxo6ybIB1sxADXm6izM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9786513421;
        Fri, 26 Aug 2022 07:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BYD3Imx4CGOxEQAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 26 Aug 2022 07:38:20 +0000
Date:   Fri, 26 Aug 2022 09:38:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Lu Jialin <lujialin4@huawei.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC 2/2] memcg: Adapt cgroup.top into per-memcg
Message-ID: <Ywh4a0NBL3QNMGYS@dhcp22.suse.cz>
References: <20220826011503.103894-1-lujialin4@huawei.com>
 <20220826011503.103894-3-lujialin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826011503.103894-3-lujialin4@huawei.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_OTHER_BAD_TLD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_RED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 26-08-22 09:15:03, Lu Jialin wrote:
> cgroup.top is able to show resource usage information for each cgroups.
> Currently only memory usage is monitored ,including usage,anon,file,
> kmem(Bytes), stats for other resource types would be added as well.
> 
> Show case:
> / # mount -t cgroup2 none /sys/fs/cgroup
> / # cd /sys/fs/cgroup/
> /sys/fs/cgroup # echo "+memory" > cgroup.subtree_control
> /sys/fs/cgroup # mkdir test1
> /sys/fs/cgroup # mkdir test2
> /sys/fs/cgroup # mkdir test3
> /sys/fs/cgroup # echo $$ > test2/cgroup.procs
> /sys/fs/cgroup # cd /test
> /test # ./memcg_malloc 512000 &
> /test # ./memcg_malloc 512000 &
> /test # ./memcg_malloc 512000 &
> /test # cd /sys/fs/cgroup
> /sys/fs/cgroup # echo $$ > test1/cgroup.procs
> /sys/fs/cgroup # cd /test
> /test # ./memcg_malloc 512000 &
> /test # cd /sys/fs/cgroup
> /sys/fs/cgroup # echo $$ > test3/cgroup.procs
> /sys/fs/cgroup # cat cgroup.top
> memory top:
> name            usage           anon            file            kernel
> test2           1974272         1671168         0               270336
> test1           700416          569344          0               94208
> test3           196608          86016           0               86016

This information is already present in memory.stat and can be easily
post-processed to generate similar output. Why is that insufficient?
-- 
Michal Hocko
SUSE Labs
