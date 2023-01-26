Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C6767D52C
	for <lists+cgroups@lfdr.de>; Thu, 26 Jan 2023 20:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjAZTOH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 14:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjAZTOG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 14:14:06 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501F62D43;
        Thu, 26 Jan 2023 11:13:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0C8AA1F8AA;
        Thu, 26 Jan 2023 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674760428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YnzrMwJWnqV7xEolFqXRf8x90j0rKrmMDrv1KOIfhio=;
        b=ei5CGv7oFwVoJj4dBnXnDv29lsXPo+m8Uh+bxtoV2rpzhI8Q3sewvDYNPeZ/J56Sf6OI/Q
        5BPy50FL8QTq/BqhaG6lmuZRaASdcaPCCLxrr2JAro6T5byuInzzNprRAb2ILLPx0l12Cs
        0UkqAkcvrZYEOQ0rOMzZlDb5OKXRfCA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC22D13A09;
        Thu, 26 Jan 2023 19:13:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NRQpNOvQ0mO9FwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 26 Jan 2023 19:13:47 +0000
Date:   Thu, 26 Jan 2023 20:13:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
 <Y9LDAZmApLeffrT8@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9LDAZmApLeffrT8@tpad>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 26-01-23 15:14:25, Marcelo Tosatti wrote:
> On Thu, Jan 26, 2023 at 08:45:36AM +0100, Michal Hocko wrote:
> > On Wed 25-01-23 15:22:00, Marcelo Tosatti wrote:
> > [...]
> > > Remote draining reduces interruptions whether CPU 
> > > is marked as isolated or not:
> > > 
> > > - Allows isolated CPUs from benefiting of pcp caching.
> > > - Removes the interruption to non isolated CPUs. See for example 
> > > 
> > > https://lkml.org/lkml/2022/6/13/2769
> > 
> > This is talking about page allocato per cpu caches, right? In this patch
> > we are talking about memcg pcp caches. Are you sure the same applies
> > here?
> 
> Both can stall the users of the drain operation.

Yes. But it is important to consider who those users are. We are
draining when
	- we are charging and the limit is hit so that memory reclaim
	  has to be triggered.
	- hard, high limits are set and require memory reclaim.
	- force_empty - full memory reclaim for a memcg
	- memcg offlining - cgroup removel - quite a heavy operation as
	  well.
all those could be really costly kernel operations and they affect
isolated cpu only if the same memcg is used by both isolated and non-isolated
cpus. In other words those costly operations would have to be triggered
from non-isolated cpus and those are to be expected to be stalled. It is
the side effect of the local cpu draining that is scheduled that affects
the isolated cpu as well.

Is that more clear?
-- 
Michal Hocko
SUSE Labs
