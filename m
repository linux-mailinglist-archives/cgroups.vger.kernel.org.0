Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635777BCD34
	for <lists+cgroups@lfdr.de>; Sun,  8 Oct 2023 10:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbjJHI0S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 8 Oct 2023 04:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjJHI0R (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 8 Oct 2023 04:26:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F12AC5;
        Sun,  8 Oct 2023 01:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696753576; x=1728289576;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=8/mXfev2GY0awlSB4s6J9CKeqFKLeQiFin++rR6Z0Bc=;
  b=kSM8nCy3/AvN7veay0SpgnG/ALW0E5cphRUZRY8gssGffXsDed7M1BYg
   fAs8DfckXTnlBAvBHo3FMoczCv0l7iGyGgbYzUeNgPyTiXu9H5me7195n
   PFRcjbIlDmdTKb5UrF3KdB3Q0S7ZEygqUGbnwdufwdY1ODqObQ8mYQncA
   470yDnl1PU+21YEWG61BFNTQ5hfFBNra1H+D9nd33R3FtN4hIWLmcdSFq
   EaIhDDWP12j02u5XPgrpoNQvY7fBpnt4b5GPbLcDiRy7w8iS/5yle7pON
   EDhlK1C4SwhlmZbEnxGXh7k29FpU9EwKPraaYIKHE5EB32IpkcJomAYfo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="414978999"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="414978999"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="823013362"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="823013362"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 01:26:09 -0700
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
        <87mswtkj8x.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAFA-uR9ymPTktMbi96cb+smjQHB4Y=8SQfAqmsqTbniGbkGTLA@mail.gmail.com>
Date:   Sun, 08 Oct 2023 16:24:02 +0800
In-Reply-To: <CAFA-uR9ymPTktMbi96cb+smjQHB4Y=8SQfAqmsqTbniGbkGTLA@mail.gmail.com>
        (Jianlin Lv's message of "Sun, 8 Oct 2023 15:52:04 +0800")
Message-ID: <87il7hjzdp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Jianlin Lv <iecedge@gmail.com> writes:

> On Sun, Oct 8, 2023 at 9:17=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>>
>> Jianlin Lv <iecedge@gmail.com> writes:
>>
>> > From: Jianlin Lv <iecedge@gmail.com>
>> >
>> > Global reclaim will swap even if swappiness is set to 0.
>>
>> Why?  Can you elaborate the situation?
>
> We reproduced the issue of pages being swapped out even when swappiness is
> set to 0 in the production environment through the following test program.
> Not sure whether this program can reproduce the issue in any environment.
>
> From the implementation of the get_scan_count code, it can be seen that,
> based on the current runtime situation, memory reclamation will choose a
> scanning method (SCAN_ANON/SCAN_FILE/SCAN_FRACT) to determine how
> aggressively the anon and file LRU are scanned. However, this introduces
> uncertainty.
>
> For the JVM issue at hand, we expect deterministic SCAN_FILE scan to avoid
> swapping out anon pages.

Why doesn't memory.swap.max work?

--
Best Regards,
Huang, Ying
