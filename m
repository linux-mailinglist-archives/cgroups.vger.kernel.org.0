Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFB16EF7C0
	for <lists+cgroups@lfdr.de>; Wed, 26 Apr 2023 17:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbjDZP1X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbjDZP1W (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 11:27:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4C02707;
        Wed, 26 Apr 2023 08:27:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D86A521A17;
        Wed, 26 Apr 2023 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682522839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PxTXn2BTS1MgLfa6uUxx1IJIGot7tRzMX6mJKeRAOU0=;
        b=QDiaNXkKB3uTdY6B9oH8hNNCSYV+uqkT4a1892oDrK572lszPhfddPLLMre1CgTN3Dsf5G
        ScrUsE1jjfCCS9RdneK3ReDxQPcYS0UeDH/7UrhHe7/jwYuQBWILAIQmwaaDfjMZvTqx/I
        Ekl+fSwPwceAjY3EN+9UF9Yv5eHU6lw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF9B5138F0;
        Wed, 26 Apr 2023 15:27:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YNWXKNdCSWRPBAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 26 Apr 2023 15:27:19 +0000
Date:   Wed, 26 Apr 2023 17:27:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg: dump memory.stat during cgroup OOM for v1
Message-ID: <ZElC127xlU2NtlqF@dhcp22.suse.cz>
References: <20230426133919.1342942-1-yosryahmed@google.com>
 <20230426133919.1342942-3-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426133919.1342942-3-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 26-04-23 13:39:19, Yosry Ahmed wrote:
> Commit c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup
> OOM") made sure we dump all the stats in memory.stat during a cgroup
> OOM, but it also introduced a slight behavioral change. The code used to
> print the non-hierarchical v1 cgroup stats for the entire cgroup
> subtree, not it only prints the v2 cgroup stats for the cgroup under
> OOM.
> 
> Although v2 stats are a superset of v1 stats, some of them have
> different naming. We also lost the non-hierarchical stats for the cgroup
> under OOM in v1.

Why is that a problem worth solving? It would be also nice to add an
example of the oom report before and after the patch.
-- 
Michal Hocko
SUSE Labs
