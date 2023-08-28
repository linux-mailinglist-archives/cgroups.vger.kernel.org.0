Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DB178B4BA
	for <lists+cgroups@lfdr.de>; Mon, 28 Aug 2023 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjH1Prt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjH1PrS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 11:47:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05379D;
        Mon, 28 Aug 2023 08:47:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A4FCE21A89;
        Mon, 28 Aug 2023 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693237634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wgffJfTbN2hrM2LfawRv94KbFXBSWdoYhh+f+YXVzXA=;
        b=j9QKq8c9xmscDVZf6LzoNgCsUfGNvGMoqZlKWzlvV1liR+juWKDkG/lLU4xNc5qBs/MW+x
        uyeKOP+bAwmg6pleKvqb1/El8aRPFEFsnNGdwa/rM1xNFzsehyP9P939blDXfum1VRnruS
        +NjieNHQc211STH1b2HQt6KFCWRUK/Q=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 827D713A11;
        Mon, 28 Aug 2023 15:47:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bwb/HILB7GQ0DgAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 28 Aug 2023 15:47:14 +0000
Date:   Mon, 28 Aug 2023 17:47:13 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
Message-ID: <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz>
References: <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz>
 <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
 <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz>
 <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Done my homework and studied the rstat code more (sorry should have done
that earlier).

On Fri 25-08-23 08:14:54, Yosry Ahmed wrote:
[...]
> I guess what I am trying to say is, breaking down that lock is a major
> surgery that might require re-designing or re-implementing some parts
> of rstat. I would be extremely happy to be proven wrong. If we can
> break down that lock then there is no need for unified flushing even
> for in-kernel contexts, and we can all live happily ever after with
> cheap(ish) and accurate stats flushing.

Yes, this seems like a big change and also over complicating the whole
thing. I am not sure this is worth it.

> I really hope we can move forward with the problems at hand (sometimes
> reads are expensive, sometimes reads are stale), and not block fixing
> them until we can come up with an alternative to that global lock
> (unless, of course, there is a simpler way of doing that).

Well, I really have to say that I do not like the notion that reading
stats is unpredictable. This just makes it really hard to use. If
the precision is to be sarificed then this should be preferable over
potentially high global lock contention. We already have that model in
place of /proc/vmstat (configurable timeout for flusher and a way to
flush explicitly). I appreciate you would like to have a better
precision but as you have explored the locking is really hard to get rid
of here.

So from my POV I would prefer to avoid flushing from the stats reading
path and implement force flushing by writing to stat file. If the 2s
flushing interval is considered to coarse I would be OK to allow setting
it from userspace. This way this would be more in line with /proc/vmstat
which seems to be working quite well.

If this is not accaptable or deemed a wrong approach long term then it
would be good to reonsider the current cgroup_rstat_lock at least.
Either by turning it into mutex or by dropping the yielding code which
can severly affect the worst case latency AFAIU.

> Sorry for the very long reply :)

Thanks for bearing with me and taking time to formulate all this!
-- 
Michal Hocko
SUSE Labs
