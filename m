Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFD85F15C7
	for <lists+cgroups@lfdr.de>; Sat,  1 Oct 2022 00:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiI3WIo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Sep 2022 18:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI3WIn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Sep 2022 18:08:43 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 347BB1F615;
        Fri, 30 Sep 2022 15:08:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 14CB98AB7FA;
        Sat,  1 Oct 2022 08:08:35 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oeOBO-00E7Hy-9c; Sat, 01 Oct 2022 08:08:34 +1000
Date:   Sat, 1 Oct 2022 08:08:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH] memcg: calling reclaim_high(GFP_KERNEL) in GFP_NOFS
 context deadlocks
Message-ID: <20220930220834.GK3600936@dread.disaster.area>
References: <20220929215440.1967887-1-david@fromorbit.com>
 <20220929222006.GI3600936@dread.disaster.area>
 <YzbesGeUkX3qwqj8@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YzbesGeUkX3qwqj8@blackbook>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=633768e4
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=8nJEP1OIZ-IA:10 a=Qawa6l4ZSaYA:10 a=7-415B0cAAAA:8
        a=S0Piwmq705tsB1qMP1wA:9 a=wPNLvfGTeEIA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 30, 2022 at 02:18:56PM +0200, Michal Koutný wrote:
> On Fri, Sep 30, 2022 at 08:20:06AM +1000, Dave Chinner <david@fromorbit.com> wrote:
> > Fixes: b3ff92916af3 ("mm, memcg: reclaim more aggressively before high allocator throttling")
> 
> Perhaps you meant this instead?
> 
> Fixes: c9afe31ec443 ("memcg: synchronously enforce memory.high for large overcharges")

You might be right in that c9afe31ec443 exposed the issue, but it's
not the root cause. I think c9afe31ec443 just a case of a
new caller of mem_cgroup_handle_over_high() stepping on the landmine
left by b3ff92916af3 adding an unconditional GFP_KERNEL direct
reclaim deep in the guts of the memcg code.

IOWs, if b3ff92916af3 did things the right way to begin with, then
c9afe31ec443 would not have caused any problems. So what's the real
root cause of the issue - the commit that stepped on the landmine,
or the commit that placed the landmine?

Either way, if anyone backports b3ff92916af3 or has a kernel with
b3ff92916af3 and not c9afe31ec443, they still need to know
about the landmine in b3ff92916af3....

-Dave.
-- 
Dave Chinner
david@fromorbit.com
