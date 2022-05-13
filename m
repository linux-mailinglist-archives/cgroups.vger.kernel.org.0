Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C3D526996
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 20:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383233AbiEMSxE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238703AbiEMSxD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 14:53:03 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2B465D29;
        Fri, 13 May 2022 11:53:01 -0700 (PDT)
Date:   Fri, 13 May 2022 11:52:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652467979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c9TRybVbhOQgUFxoQemhb4nS3icLR/En8Zxu0EkRFzs=;
        b=UKCdjVRdCBUCF0VJzs6bgU0WyPR3VyI60/PJnQpwECHSSCbZD9gieB07JA0/lDp7vEtGX3
        tbsyD/Nsy4xjtX15B1/yCq3rz1O6uKYdhfoaXVv9QiXwEeGX2ny9G0ZntrBO0/ppJPLtN/
        YA0km8jz4BreLxE7GMpTSF1HMy7iv/Y=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     void@manifault.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mhocko@kernel.org, shakeelb@google.com, tj@kernel.org,
        Richard Palethorpe <rpalethorpe@suse.de>
Subject: Re: [PATCH 3/4] selftests: memcg: Adjust expected reclaim values of
 protected cgroups
Message-ID: <Yn6pBPq+lAXm9NG8@carbon>
References: <20220512174452.tr34tuh4k5jm6qjs@dev0025.ash9.facebook.com>
 <20220513171811.730-1-mkoutny@suse.com>
 <20220513171811.730-4-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513171811.730-4-mkoutny@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 13, 2022 at 07:18:10PM +0200, Michal Koutny wrote:
> The numbers are not easy to derive in a closed form (certainly mere
> protections ratios do not apply), therefore use a simulation to obtain
> expected numbers.
> 
> The new values make the protection tests succeed more precisely.
> 
> 	% run as: octave-cli script
> 	%
> 	% Input configurations
> 	% -------------------
> 	% E parent effective protection
> 	% n nominal protection of siblings set at the givel level
> 	% c current consumption -,,-
> 
> 	% example from testcase (values in GB)
> 	E = 50 / 1024;
> 	n = [75 25 0 500 ] / 1024;
> 	c = [50 50 50 0] / 1024;
> 
> 	% Reclaim parameters
> 	% ------------------
> 
> 	% Minimal reclaim amount (GB)
> 	cluster = 32*4 / 2**20;
> 
> 	% Reclaim coefficient (think as 0.5^sc->priority)
> 	alpha = .1
> 
> 	% Simulation parameters
> 	% ---------------------
> 	epsilon = 1e-7;
> 	timeout = 1000;
> 
> 	% Simulation loop
> 	% ---------------------
> 	% Simulation assumes siblings consumed the initial amount of memory (w/out
> 	% reclaim) and then the reclaim starts, all memory is reclaimable, i.e. treated
> 	% same. It simulates only non-low reclaim and assumes all memory.min = 0.
> 
> 	ch = [];
> 	eh = [];
> 	rh = [];
> 
> 	for t = 1:timeout
> 		% low_usage
> 		u = min(c, n);
> 		siblings = sum(u);
> 
> 		% effective_protection()
> 		protected = min(n, c);                % start with nominal
> 		e = protected * min(1, E / siblings); % normalize overcommit
> 
> 		% recursive protection
> 		unclaimed = max(0, E - siblings);
> 		parent_overuse = sum(c) - siblings;
> 		if (unclaimed > 0 && parent_overuse > 0)
> 			overuse = max(0, c - protected);
> 			e += unclaimed * (overuse / parent_overuse);
> 		endif
> 
> 		% get_scan_count()
> 		r = alpha * c;             % assume all memory is in a single LRU list
> 
> 		% commit 1bc63fb1272b ("mm, memcg: make scan aggression always exclude protection")
> 		sz = max(e, c);
> 		r .*= (1 - (e+epsilon) ./ (sz+epsilon));
> 
> 		% uncomment to debug prints
> 		% e, c, r
> 
> 		% nothing to reclaim, reached equilibrium
> 		if max(r) < epsilon
> 			break;
> 		endif
> 
> 		% SWAP_CLUSTER_MAX
> 		r = max(r, (r > epsilon) .* cluster);
> 		% XXX here I do parallel reclaim of all siblings
> 		% in reality reclaim is serialized and each sibling recalculates own residual
> 		c = max(c - r, 0);
> 
> 		ch = [ch ; c];
> 		eh = [eh ; e];
> 		rh = [rh ; r];
> 	endfor
> 
> 	t
> 	c, e

This is a cool stuff!

How about to place it into a separate file and add a comment into the code
with a reference?

Thanks!
