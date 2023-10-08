Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BFB7BCB6D
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 03:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjJHBRK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 21:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjJHBRJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 21:17:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF158F;
        Sat,  7 Oct 2023 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696727828; x=1728263828;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=BObmF+e1EHfAcOcXWcw1IxrBQsQNIWGH7aR97cf+Zh4=;
  b=Gyhe3xeAlVflBgX3cmPyUHIdQByb/faclzNH8gvbsIfZERAxGIlcwTJq
   s14mJMl8/zYYjRLBYgBJ4YZ5EszMKUUDxwHCK4zx1ZXEOX7Sy4semLZNz
   L8ps+rS4M21bhWR6z4AfTgJxzuRr9kJf0b1Lxb8e/usoTng8Ssj21xbYy
   0ApCLZr2S88LPb/YQDwIkmeFdiK1RvMasYbKebITrEVMvK0Synsi1mAEP
   uueBJGcJ6xlASRZWUBZjIz9tACu/dbGQTAWE9S16OTJAiXabM23agHEvX
   o5Z7so/W4J2e/hrR7odac+3uRHablCc9StKnMivFhdfQSp525zdIbwN57
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="387834737"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="387834737"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 18:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="729268794"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="729268794"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 18:17:01 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Jianlin Lv <iecedge@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, yosryahmed@google.com,
        willy@infradead.org, linmiaohe@huawei.com,
        wangkefeng.wang@huawei.com, laoar.shao@gmail.com,
        yuzhao@google.com, wuyun.abel@bytedance.com, david@redhat.com,
        peterx@redhat.com, vishal.moola@gmail.com, hughd@google.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jianlv@ebay.com
Subject: Re: [PATCH] memcg: add interface to force disable swap
References: <20231007130905.78554-1-jianlv@ebay.com>
Date:   Sun, 08 Oct 2023 09:14:54 +0800
In-Reply-To: <20231007130905.78554-1-jianlv@ebay.com> (Jianlin Lv's message of
        "Sat, 7 Oct 2023 21:09:05 +0800")
Message-ID: <87mswtkj8x.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Jianlin Lv <iecedge@gmail.com> writes:

> From: Jianlin Lv <iecedge@gmail.com>
>
> Global reclaim will swap even if swappiness is set to 0.

Why?  Can you elaborate the situation?

> In particular
> case, users wish to be able to completely disable swap for specific
> processes. One scenario is that if JVM memory pages falls into swap,
> the performance will noticeably reduce and the GC pauses tend to increase
> to levels not tolerable by most applications.
> If it's possible to only disable swap out for specific processes, it can
> address the JVM GC pauses issues, and at the same time, memory reclaim
> pressure is also manageable.
>
> This patch adds "memory.swap_force_disable" control file to support disable
> swap for non-root cgroup. When process is associated with a cgroup,
> 'echo 1 > memory.swap_force_disable' will forbid anon pages be swapped out.
> This patch also adds read and write handler of the control file.

--
Best Regards,
Huang, Ying
