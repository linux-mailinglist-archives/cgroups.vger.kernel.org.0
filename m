Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3FF059D04F
	for <lists+cgroups@lfdr.de>; Tue, 23 Aug 2022 07:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiHWFGI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Aug 2022 01:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiHWFGG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Aug 2022 01:06:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ECD52FD5
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 22:06:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0AC8533BAC;
        Tue, 23 Aug 2022 05:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661231162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n13NAN9ffJ2MVaULyYx08l67c4Jvz9ioDGiOIBNWoTA=;
        b=kV4cusk4xw/njZv0QPW2NMdhCsG/V77aYBeqmeW6P1+q8rM2Rd/aGS9Vqwrcub7DJK2QBR
        DFE0caAsqwYmUCjtoNCTBFiJ80LY25e+Cj0vqwR20ImkMyeEaNymjdOJpkGJ3nrZcvnk4P
        DCwR71kL2yF8tTBLIclCp4Nn+l3Y/Nw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E0FF213AB7;
        Tue, 23 Aug 2022 05:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yqOiNDlgBGNPDwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 23 Aug 2022 05:06:01 +0000
Date:   Tue, 23 Aug 2022 07:06:01 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Chris Frey <cdfrey@foursquare.net>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: an argument for keeping oom_control in cgroups v2
Message-ID: <YwRgOcfagx4FfQcY@dhcp22.suse.cz>
References: <20220822120402.GA20333@foursquare.net>
 <YwRIDTmZJflhKP2n@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwRIDTmZJflhKP2n@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 22-08-22 17:22:53, Tejun Heo wrote:
> (cc'ing memcg folks for visiblity)
> 
> On Mon, Aug 22, 2022 at 08:04:02AM -0400, Chris Frey wrote:
> > In cgroups v1 we had:
> > 
> > 	memory.soft_limit_in_bytes
> > 	memory.limit_in_bytes
> > 	memory.memsw.limit_in_bytes
> > 	memory.oom_control
> > 
> > Using these features, we could achieve:
> > 
> > 	- cause programs that were memory hungry to suffer performance, but
> > 	  not stop (soft limit)

There is memory.high with a much more sensible semantic and
implementation to achieve a similar thing.

> > 	- cause programs to swap before the system actually ran out of memory
> > 	  (limit)

Not sure what this is supposed to mean.

> > 	- cause programs to be OOM-killed if they used too much swap
> > 	  (memsw.limit...)


There is an explicit swap limit. It is true that the semantic is
different but do you have an example where you cannot really achieve
what you need by the swap limit?

> > 
> > 	- cause programs to halt instead of get killed (oom_control)
> > 
> > That last feature is something I haven't seen duplicated in the settings
> > for cgroups v2.  In terms of handling a truly non-malicious memory hungry
> > program, it is a feature that has no equal, because the user may require
> > time to free up memory elsewhere before allocating more to the program,
> > and he may not want the performance degredation, nor the loss of work,
> > that comes from the other options.

Yes this functionality is not available in v2 anymore. One reason is
that the implementation had to be considerably reduced to only block on
OOM for user space triggered page faults 3812c8c8f395 ("mm: memcg: do
not trap chargers with full callstack on OOM"). The primary reason is,
as Tejun indicated, that we cannot simply block a random kernel code
path and wait for userspace because that is a potential DoS on the rest
of the system and unrelated workloads which is a trivial breakage of
workload separation.

This means that many other kernel paths which can cause memcg OOM cannot
be blocked and so the feature is severly crippled. In order to allow for
this feature we would essentially need a safe place to wait for the
userspace for any allocation (charging) kernel path where no locks are
held yet allocation failure is not observed and that is not feasible.

Hope this helps clarify
-- 
Michal Hocko
SUSE Labs
