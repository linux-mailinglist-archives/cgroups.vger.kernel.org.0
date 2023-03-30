Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1366CFCFC
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC3Hji (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjC3Hjh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:39:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808AB4213;
        Thu, 30 Mar 2023 00:39:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 26AA121B00;
        Thu, 30 Mar 2023 07:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680161975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g18B/GLg5ItJpD8zvJQQFzAO1axtsluF41GXm3XAUWQ=;
        b=ET0uIz8SFpap4Z0OGPb9kwXXtyHW/o/NGozAbd+0d3gbFzcP0A1LuFuJJJfq/l87AkaSbV
        PgKMOzdr17x6a4N6mNu8/3S0yq7fyz8szN2RSGvlRHH+6oHlgPx7hTfNDt5u9aESoovany
        8D/iM3t2ToRiYsbtSkzNzWdUvaSrkg0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 06E591348E;
        Thu, 30 Mar 2023 07:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5x/vOrY8JWRyfAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 30 Mar 2023 07:39:34 +0000
Date:   Thu, 30 Mar 2023 09:39:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v2 7/9] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-8-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328221644.803272-8-yosryahmed@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 28-03-23 22:16:42, Yosry Ahmed wrote:
> In workingset_refault(), we call
> mem_cgroup_flush_stats_atomic_ratelimited() to flush stats within an
> RCU read section and with sleeping disallowed. Move the call above
> the RCU read section and allow sleeping to avoid unnecessarily
> performing a lot of work without sleeping.

Could you say few words why the flushing is done before counters are
updated rather than after (the RCU section)?
-- 
Michal Hocko
SUSE Labs
