Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0159268A08A
	for <lists+cgroups@lfdr.de>; Fri,  3 Feb 2023 18:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbjBCRm1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Feb 2023 12:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjBCRm0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Feb 2023 12:42:26 -0500
Received: from out-131.mta0.migadu.com (out-131.mta0.migadu.com [IPv6:2001:41d0:1004:224b::83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA242125
        for <cgroups@vger.kernel.org>; Fri,  3 Feb 2023 09:42:24 -0800 (PST)
Date:   Fri, 3 Feb 2023 09:42:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675446142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZYvx87/bApyuUVwX/LObDHee8cS4wUlkoRlwfbD39PE=;
        b=LGHrzaZwAx29gBlXOkLljkso6NQ92suLDFaEogkOQt1FEn3w8ek0TBLiGtVX57Q8fwq3qI
        LZCTIUAkK3mdrLn3A5V/7RuWxv9SpZkZtBTARwGqciKa8ttsyGiY2Z+CaaY2plO61J4wrr
        o7dBN5HJfu98Di+SvTaYhw2SUg3NLNM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: introduce entrance for root_mem_cgroup's current
Message-ID: <Y91Hc3Iu+5VyyIwS@P9FQF9L96D.corp.robot.car>
References: <1675312377-4782-1-git-send-email-zhaoyang.huang@unisoc.com>
 <Y9tz+0J9fw+Z+O+O@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9tz+0J9fw+Z+O+O@dhcp22.suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 09:27:39AM +0100, Michal Hocko wrote:
> On Thu 02-02-23 12:32:57, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > 
> > Introducing memory.root_current for the memory charges on root_mem_cgroup.
> 
> Charges are not currently accounted for the root memcg universally. See
> try_charge which is used for all user space and skmem charges. I am not
> 100% sure about objcg based accounting because there is no explicit
> check for the root memcg but this might be hidden somewhere as well.

root_mem_cgroup has no corresponding obj_cgroup: see memcg_online_kmem().

Thanks
