Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00F159F642
	for <lists+cgroups@lfdr.de>; Wed, 24 Aug 2022 11:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbiHXJb2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Aug 2022 05:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiHXJbF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Aug 2022 05:31:05 -0400
Received: from digon.foursquare.net (digon.foursquare.net [216.8.179.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDD1F915DA
        for <cgroups@vger.kernel.org>; Wed, 24 Aug 2022 02:30:35 -0700 (PDT)
Received: by digon.foursquare.net (Postfix, from userid 1000)
        id 3D50340083; Wed, 24 Aug 2022 05:30:23 -0400 (EDT)
Date:   Wed, 24 Aug 2022 05:30:23 -0400
From:   Chris Frey <cdfrey@foursquare.net>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: an argument for keeping oom_control in cgroups v2
Message-ID: <20220824093023.GA29770@foursquare.net>
References: <20220822120402.GA20333@foursquare.net>
 <YwRIDTmZJflhKP2n@slm.duckdns.org>
 <YwRgOcfagx4FfQcY@dhcp22.suse.cz>
 <YwT7/VFUTNmjarTh@P9FQF9L96D>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwT7/VFUTNmjarTh@P9FQF9L96D>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 23, 2022 at 09:10:37AM -0700, Roman Gushchin wrote:
> Btw, it's fairly easy to emulate the oom_control behaviour using cgroups v2:
> a userspace agent can listen to memory.high/max events and use the cgroup v2
> freezer to stop the workload and handle the oom in v1 oom_control style.
> An agent can have a high/real-time priority, so I guess the behavior will be
> actually quite close to the v1 experience. Much safer though.

Thanks to everyone who responded.  Looks like the same functionality,
slightly different, is still available through different means,
so my query has been satisfied.

- Chris

