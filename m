Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7776C739
	for <lists+cgroups@lfdr.de>; Wed,  2 Aug 2023 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjHBHnV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Aug 2023 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjHBHmc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Aug 2023 03:42:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE60130D8;
        Wed,  2 Aug 2023 00:40:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A1631F749;
        Wed,  2 Aug 2023 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690962017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6e6GiqmpyVCzOwvyGHqSNXCNxBFa7aDIzwYUNSYMUSM=;
        b=J+S11sgO6aiS75myCJ8iLCSy282SRXv1ywdO5YwOTHEIVWLCWo+CmZolywZvDiekiULT7E
        vWy7yPZAHd+/5e7nl5xlTRsvC9Ke8RqcIZJSFGjS/fxw80Gp6IoVhZvIX5Ru4mir/H7nD1
        u3KKzJjm5zGmBVBQNz63u0Wcjp13FkY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B3A513909;
        Wed,  2 Aug 2023 07:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XYsOF2EIymQ9JwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Aug 2023 07:40:17 +0000
Date:   Wed, 2 Aug 2023 09:40:16 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] mm: memcg: use rstat for non-hierarchical stats
Message-ID: <ZMoIYLwITUZzXp4C@dhcp22.suse.cz>
References: <20230726153223.821757-1-yosryahmed@google.com>
 <20230726153223.821757-2-yosryahmed@google.com>
 <ZMkXDuwD8RFRKnNQ@dhcp22.suse.cz>
 <CAJD7tkbb8AWR-duWb+at-S9MMz48b0JqnM+b5ok83TzvXvPb+A@mail.gmail.com>
 <CAJD7tkbZi16w4mYngVK8qA84FMijmHvwzMjHfrJiCsV=WjixOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbZi16w4mYngVK8qA84FMijmHvwzMjHfrJiCsV=WjixOA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 01-08-23 10:29:39, Yosry Ahmed wrote:
> On Tue, Aug 1, 2023 at 9:39 AM Yosry Ahmed <yosryahmed@google.com> wrote:
[...]
> > > Have you measured any potential regression for cgroup v2 which collects
> > > all this data without ever using it (AFAICS)?
> >
> > I did not. I did not expect noticeable regressions given that all the
> > extra work is done during flushing, which should mostly be done by the
> > asynchronous worker, but can also happen in the stats reading context.
> > Let me run the same script on cgroup v2 just in case and report back.
> 
> A few runs on mm-unstable with this patch:
> 
> # time cat /sys/fs/cgroup/cg*/memory.stat > /dev/null

Is this really representative test to make? I would have expected the
overhead would be mostly in mem_cgroup_css_rstat_flush (if it is visible
at all of course). This would be more likely visible in all cpus busy
situation (you can try heavy parallel kernel build from tmpfs for
example).
[...]

> It looks like there are no regressions on cgroup v2 when reading the
> stats. Please let me know if you want me to send a new version with
> the cgroup v2 results as well in the commit log -- or I can just send
> a new commit log. Whatever is easier for Andrew.

Updating the changelog should be good enough.
-- 
Michal Hocko
SUSE Labs
