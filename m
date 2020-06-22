Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35004203D72
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2020 19:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgFVRGG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Jun 2020 13:06:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:51457 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbgFVRGG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 22 Jun 2020 13:06:06 -0400
IronPort-SDR: h0NsZA7CJ/aU21vsvKslvx/Xj6PFJ5cBcxpuXEFKjyb3h/m3kpZ+39ubTNndUB1fyXOF59+KJu
 NRdpEUTyRJrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="142069568"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="142069568"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 10:06:06 -0700
IronPort-SDR: aZSJs/4pP7RcQJxep4jJujdorrTUDjovrMmabyDZQPYu6ydeAFYwQUQbWKa3QBtQoGOdHZ7rT7
 opZiTpKuaZBw==
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="264561866"
Received: from unknown (HELO intel.com) ([10.252.132.84])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 10:06:05 -0700
Date:   Mon, 22 Jun 2020 10:06:03 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 13/19] mm: memcontrol: drop unused try/commit/cancel
 charge API
Message-ID: <20200622170603.yuqbjizzxihmlyk2@intel.com>
Mail-Followup-To: Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>, Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-14-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508183105.225460-14-hannes@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 20-05-08 14:31:00, Johannes Weiner wrote:
> There are no more users. RIP in peace.
> 

Would it make sense to update Documentation/admin-guide/cgroup-v1/memcg_test.rst
too? I don't have the history on this file, or why it exists (it does say
implementation details can be changed).

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
[snip]

