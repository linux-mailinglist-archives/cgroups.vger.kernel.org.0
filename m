Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A579B9C2
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 02:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377457AbjIKW0Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbjIKTeX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 15:34:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B5E18D;
        Mon, 11 Sep 2023 12:34:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD7372183F;
        Mon, 11 Sep 2023 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694460855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GtgT2X4Lzwli3PQHVCNnWgiwe9JIqA+mySpJCTGonc=;
        b=inBeglmLIoSjZlhjij03px88WQrURLaG1YUEBgOpUyL20GxHeUP/Y88emsAQxatOusOYl+
        +Tbfps3gPaKBPyOLqvX5fZmSfkSJwTiVn9WprQ33JRTjhOvRWpHllAJj08kGrvRbfkrbJZ
        x2TW/UzxIda62LHY7iSw1knKIKhwACg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA837139CC;
        Mon, 11 Sep 2023 19:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id c4qoJrdr/2QdXQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 11 Sep 2023 19:34:15 +0000
Date:   Mon, 11 Sep 2023 21:34:14 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Wei Xu <weixugc@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZP9rtiRwRv2bQvde@dhcp22.suse.cz>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com>
 <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com>
 <ZP8SDdjut9VEVpps@dhcp22.suse.cz>
 <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 11-09-23 12:15:24, Wei Xu wrote:
> On Mon, Sep 11, 2023 at 6:11 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 07-09-23 17:52:12, Wei Xu wrote:
> > [...]
> > > I tested this patch on a machine with 384 CPUs using a microbenchmark
> > > that spawns 10K threads, each reading its memory.stat every 100
> > > milliseconds.
> >
> > This is rather extreme case but I wouldn't call it utterly insane
> > though.
> >
> > > Most of memory.stat reads take 5ms-10ms in kernel, with
> > > ~5% reads even exceeding 1 second.
> >
> > Just curious, what would numbers look like if the mutex is removed and
> > those threads would be condending on the existing spinlock with lock
> > dropping in place and removed. Would you be willing to give it a shot?
> 
> Without the mutex and with the spinlock only, the common read latency
> of memory.stat is still 5ms-10ms in kernel. There are very few reads
> (<0.003%) going above 10ms and none more than 1 second.

Is this with the existing spinlock dropping and same 10k potentially
contending readers?
-- 
Michal Hocko
SUSE Labs
