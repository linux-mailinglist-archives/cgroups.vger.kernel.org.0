Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6D2791AC2
	for <lists+cgroups@lfdr.de>; Mon,  4 Sep 2023 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352513AbjIDPlQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Sep 2023 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjIDPlQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Sep 2023 11:41:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E4A83;
        Mon,  4 Sep 2023 08:41:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3261F74B;
        Mon,  4 Sep 2023 15:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693842071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LhJ5sTl63kPWjdnDX0OeDaOslOG+1efqgSGhwPg2LwY=;
        b=OZAWOqBQsCEfpI3eFuLk7qToZKY+SYTEOk72LyofIJymzTGxX7iTneBlvSQa1EtpyTEC66
        9MfOrbNbfb0xXS5YRf8l+Hc4af3UnLICdYto92i8Net2jWr6FpKUI/1z1CgqCZjGdkYx6/
        JOU72i1B90DxzFoA2gmVtBFUPLmhYEs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 58FA213585;
        Mon,  4 Sep 2023 15:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jP6fEpf69WRyVAAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 04 Sep 2023 15:41:11 +0000
Date:   Mon, 4 Sep 2023 17:41:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] mm: memcg: let non-unified root stats flushes
 help unified flushes
Message-ID: <ZPX6luPGqypp68+L@dhcp22.suse.cz>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-4-yosryahmed@google.com>
 <ZPXupwjewuLgksAI@dhcp22.suse.cz>
 <6tne52ip62ucev7nmnim3m7fhcydnwcytyxynrlxxgaf4cbqea@r4hec425izap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6tne52ip62ucev7nmnim3m7fhcydnwcytyxynrlxxgaf4cbqea@r4hec425izap>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 04-09-23 17:29:14, Michal Koutny wrote:
> Hello.
> 
> On Mon, Sep 04, 2023 at 04:50:15PM +0200, Michal Hocko <mhocko@suse.com> wrote:
> > I have hard time to follow why we really want/need this. Does this cause
> > any observable changes to the behavior?
> 
> Behavior change depends on how much userspace triggers the root memcg
> flush, from nothing to effectively offloading flushing to userspace tasks.
> (Theory^^^)
> 
> It keeps stats_flush_threshold up to date representing global error
> estimate so that error-tolerant readers may save their time and it keeps
> the reasoning about the stats_flush_threshold effect simple.

So it also creates an undocumented but userspace visible behavior.
Something that userspace might start depending on, right?
-- 
Michal Hocko
SUSE Labs
