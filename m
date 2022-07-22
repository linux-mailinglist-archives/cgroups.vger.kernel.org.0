Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F957E506
	for <lists+cgroups@lfdr.de>; Fri, 22 Jul 2022 19:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiGVRF6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Jul 2022 13:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiGVRFz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Jul 2022 13:05:55 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8008EEDF;
        Fri, 22 Jul 2022 10:05:50 -0700 (PDT)
Date:   Fri, 22 Jul 2022 10:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658509548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y7js1RWyqBx3oqDhoWUrWmYCp205K7/u6aMi9Husos0=;
        b=r7ZEFRF55ukGJSsMqum8ZkCKf6/PLDX0tZRl767erRdenIBURHWA9F1mJlJDIhD2k54sd8
        i38xddVh8wdQJ4uxAkd1BE/363j3hZ9M+lmyMSV5ta9ON9JOP2a41+b9R3+7O8Tcm3FOAA
        8OxpP9CIfaMBpn0ieQXqAHXxtMKqouE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Jiebin Sun <jiebin.sun@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, songmuchun@bytedance.com,
        akpm@linux-foundation.org, tim.c.chen@intel.com,
        ying.huang@intel.com, amadeuszx.slawinski@linux.intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Subject: Re: [PATCH] mm: Remove the redundant updating of
 stats_flush_threshold
Message-ID: <YtrY5V+dZl4+Gtz4@castle>
References: <20220722164949.47760-1-jiebin.sun@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722164949.47760-1-jiebin.sun@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 23, 2022 at 12:49:49AM +0800, Jiebin Sun wrote:
> From: jiebin sun <jiebin.sun@intel.com>
> 
> Remove the redundant updating of stats_flush_threshold. If the
> global var stats_flush_threshold has exceeded the trigger value
> for __mem_cgroup_flush_stats, further increment is unnecessary.
> 
> Apply the patch and test the pts/hackbench-1.0.0 Count:4 (160 threads).
> 
> Score gain: 1.95x
> Reduce CPU cycles in __mod_memcg_lruvec_state (44.88% -> 0.12%)
> 
> CPU: ICX 8380 x 2 sockets
> Core number: 40 x 2 physical cores
> Benchmark: pts/hackbench-1.0.0 Count:4 (160 threads)
> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Good optimization, thanks!
