Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308E14176A2
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 16:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345170AbhIXOM4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 10:12:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45770 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344675AbhIXOMz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 10:12:55 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id D935E22429;
        Fri, 24 Sep 2021 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632492681; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xptrUF64qS+6u7xLV3tWOmzw4bsvaWDSNFYfVdST24M=;
        b=picfxz/elp6W9f7CrwEaQtXFpVHkQ2uj6HVogFSG1fbe3TZ6Rp4MRjWYdS5gaBAaz8eySa
        xry+lDDpqV1kUX56tSodaps3toJJXLjQ2T01KVkKlU2muVl907c/RGZT8ulP0oAIHJ8nlA
        IKuWE5zGXaNvMWoQnX0qayxiW3eIzFU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 684F525EB2;
        Fri, 24 Sep 2021 14:11:21 +0000 (UTC)
Date:   Fri, 24 Sep 2021 16:11:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     yongw.pur@gmail.com
Cc:     tj@kernel.org, peterz@infradead.org, wang.yong12@zte.com.cn,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, yang.yang29@zte.com.cn
Subject: Re: [PATCH v3] vmpressure: wake up work only when there is
 registration event
Message-ID: <YU3ciRm7L2p9lJo6@dhcp22.suse.cz>
References: <1632491065-10785-1-git-send-email-wang.yong12@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632491065-10785-1-git-send-email-wang.yong12@zte.com.cn>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 24-09-21 06:44:25, yongw.pur@gmail.com wrote:
> From: wangyong <wang.yong12@zte.com.cn>
> 
> Use the global variable num_events to record the number of vmpressure
> events registered by the system, and wake up work only when there
> is registration event.
> Usually, the vmpressure event is not registered in the system, this patch
> can avoid waking up work and doing nothing.
> 
> Test with 5.14.0-rc5-next-20210813 on x86_64 4G ram.
> Consume cgroup memory until it is about to be reclaimed, then execute
> "perf stat -I 2000 malloc.out" command to trigger memory reclamation
> and get performance results.
> The context-switches is reduced by about 20 times.
> 
> unpatched:
> Average of 10 test results
> 582.4674048     task-clock(msec)
> 19910.8         context-switches
> 0               cpu-migrations
> 1292.9          page-faults
> 414784733.1     cycles
> 580070698.4     instructions
> 125572244.7     branches
> 2073541.2       branch-misses
> 
> patched:
> Average of 10 test results
> 973.6174796     task-clock(msec)
> 988.6           context-switches
> 0               cpu-migrations
> 1785.2          page-faults
> 772883602.4     cycles
> 1360280911      instructions
> 290519434.9     branches
> 3378378.2       branch-misses

Your data still doesn't make any sense. I have asked about that in the
previous submission and you haven't really clarified anything. How come
your task-clock has almost doubled. You are likely not not comparing
apples to apples or something weird is going on.

This patch is not going to fly without a sensible data and analysis of
that data.

Thanks!
-- 
Michal Hocko
SUSE Labs
