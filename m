Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669B063D5BC
	for <lists+cgroups@lfdr.de>; Wed, 30 Nov 2022 13:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiK3Mj4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Nov 2022 07:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK3Mjy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Nov 2022 07:39:54 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70432792B;
        Wed, 30 Nov 2022 04:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669811993; x=1701347993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iPuUqicRuUklAlC5NV44CDz/ub4ZDmFDWBmSCxl3Jkw=;
  b=VmD+Tld7VK+TKKsOLApG+zWmnWS7mdPl+tG1U9gyyz5MrCD5MqP0+i/W
   Mz5Qj5MvCTxwwUNyeK30kW31itd+mXLM6k+oAeK3vkFFxpDE+HMewrjQF
   VXh9LlvGqtNmddQfYCuMQAWCxFRXTq+7EgvCqhniM6Z5PNfNJeNmhqJ8g
   aDcy538050krtABGERsZGLNCIBxrLSL6ihxp5GzYeAMXIKKKNwJjUS1gf
   cw1jmsBa3hJJmZkzcQ5oFs7ysCv7XnyEPyyI4sSIXyYLW2tzKk1jcPfWq
   QvzhtCpAu6Ylp2JZ8u3McEZ7VoKxQuux8SjEcSmE1xEgLllhMaQt8k3kI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379663970"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="379663970"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 04:39:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="637977002"
X-IronPort-AV: E=Sophos;i="5.96,206,1665471600"; 
   d="scan'208";a="637977002"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 30 Nov 2022 04:39:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0MNO-002GIz-1o;
        Wed, 30 Nov 2022 14:39:46 +0200
Date:   Wed, 30 Nov 2022 14:39:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH-block v2] bdi, blk-cgroup: Fix potential UAF of blkcg
Message-ID: <Y4dPEtGuQ2A3L+Ww@smile.fi.intel.com>
References: <20221129203400.1456100-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129203400.1456100-1-longman@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 29, 2022 at 03:34:00PM -0500, Waiman Long wrote:
> Commit 59b57717fff8 ("blkcg: delay blkg destruction until after
> writeback has finished") delayed call to blkcg_destroy_blkgs() to
> cgwb_release_workfn(). However, it is done after a css_put() of blkcg
> which may be the final put that causes the blkcg to be freed as RCU
> read lock isn't held.
> 
> By adding a css_tryget() into blkcg_destroy_blkgs() and warning its
> failure, the following stack trace was produced in a test system on
> bootup.
> 
> [   34.254240] RIP: 0010:blkcg_destroy_blkgs+0x16a/0x1a0
>       :
> [   34.339943] Call Trace:
> [   34.342395]  <TASK>
> [   34.344510]  blkcg_unpin_online+0x38/0x60
> [   34.348523]  cgwb_release_workfn+0x6a/0x200
> [   34.352708]  process_one_work+0x1e5/0x3b0
> [   34.356742]  ? rescuer_thread+0x390/0x390
> [   34.360758]  worker_thread+0x50/0x3a0
> [   34.364425]  ? rescuer_thread+0x390/0x390
> [   34.368447]  kthread+0xd9/0x100
> [   34.371592]  ? kthread_complete_and_exit+0x20/0x20
> [   34.376386]  ret_from_fork+0x22/0x30
> [   34.379982]  </TASK>

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages


> This confirms that a potential UAF situation can happen.
> 
> Fix that by delaying the css_put() until after the blkcg_unpin_online()
> call. Also use css_tryget() in blkcg_destroy_blkgs() and issue a warning
> if css_tryget() fails with no RCU read lock held.
> 
> The reproducing system can no longer produce a warning with this patch.
> All the runnable block/0* tests including block/027 were run successfully
> without failure.

-- 
With Best Regards,
Andy Shevchenko


