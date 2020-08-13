Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC3824330D
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 06:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgHMECU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 00:02:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbgHMECU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 00:02:20 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F84C061757;
        Wed, 12 Aug 2020 21:02:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id p4so4187212qkf.0;
        Wed, 12 Aug 2020 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=P1KdIUWFxYzw82EVvLFYFt+MNwT3Xk5xYJFfFDC3pI4=;
        b=pbMlVToUVOgIRz7b6T0Cmo4L05tlQHpSEVkoGFYVI4InDZqz4mjEonJrT9TjtNOg8b
         H1zOIK5DzV6MtTsxmV9fSHEIQLgp/HpHSogVOWCoFPhXQ6fJFFwWEdNL+N2CnZ5Lq9Eh
         KLznw3j1mF7Yruy5bR7H1RwKK4cjJgFtfOyvX0pzuvUqmYwxNC3KQCf7LAfK6G+6ZOar
         rpdpM45wwqdiH4P8c7aHDPC4mw11hvtSvQcNXzQFAvg25sg0+z3INGyrQmgjMM1H3qEa
         VyH0kukxWyHrDUZoZ6LRTGeYFuS4MGUaeC8vuTJIpa+DGhF0afM/3v0dej2rrOgFilDF
         iYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=P1KdIUWFxYzw82EVvLFYFt+MNwT3Xk5xYJFfFDC3pI4=;
        b=lNyJWoXdzHs1+xbWmR94bA2hxi0rjW2YPjnmQ+CDh0CygUBfDYXufv3snB4Z3vSsrg
         QMSlmyyVgrfnuqUt8eV2k4fJ54Sd6Ftx63G7N5d9iK1083HeYaUn6FURbqgI+lYSC8ix
         zF2rwnrliSmZPcRz+qnwPx/mhSfydPw++CECqEj3dtHamNkG8hJieUafRElzhi8cQw80
         B6bDNzb8+BDDuHSKUeEXjPpJPc75QY7uDUSBS7MuRKFIb9yNzJz1Y4EHGEis1SZvFXa/
         E9kWqyj24+c50JGHjBpgTRJWfzGktv4igoXL+gM3loM89TwULhRZL3szveQCboHjcZTL
         HzHg==
X-Gm-Message-State: AOAM531q7WJ+D4ZWzFFrrxPirKf+xeHIrOYTeGNhNxwXRQNurF0YgJqu
        nJto7whTe4jPH3JvpJuNnlA=
X-Google-Smtp-Source: ABdhPJzUScI/ggo7Kl82ZaCRO+U2DpmtWJjkKWWj5B4Aq/dBT4HFNpT8fzz6O/LZ5kWWbVs/g/S0og==
X-Received: by 2002:ae9:f449:: with SMTP id z9mr3140477qkl.352.1597291338871;
        Wed, 12 Aug 2020 21:02:18 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id m66sm4215602qkf.86.2020.08.12.21.02.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 21:02:17 -0700 (PDT)
Subject: [RFC PATCH 0/3] Re: [PATCH v17 14/21] mm/compaction: do page
 isolation first in compaction
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     alex.shi@linux.alibaba.com
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        shakeelb@google.com, willy@infradead.org, hannes@cmpxchg.org,
        tj@kernel.org, cgroups@vger.kernel.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com
Date:   Wed, 12 Aug 2020 21:02:15 -0700
Message-ID: <20200813035100.13054.25671.stgit@localhost.localdomain>
In-Reply-To: <3828d045-17e4-16aa-f0e6-d5dda7ad6b1b@linux.alibaba.com>
References: <3828d045-17e4-16aa-f0e6-d5dda7ad6b1b@linux.alibaba.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Here are the patches I had discussed earlier to address the issues in
isolate_migratepages_block.

They are based on the tree at:
 https://github.com/alexshi/linux.git lrunext 

The first patch is mostly cleanup to address the RCU locking in the
function. The second addresses the test_and_set_skip issue, and the third
relocates PageCompound.

I did some digging into the history of the skip bits and since they are
only supposed to be a hint I thought we could probably just drop the
testing portion of the call since the LRU flag is preventing more than one
thread from accessing the function anyway so it would make sense to just
switch it to a set operation similar to what happens when low_pfn ==
end_pfn at the end of the call.

I have only had a chance to build test these since rebasing on the tree. In
addition I am not 100% certain the PageCompound changes are correct as they
operate on the assumption that get_page_unless_zero is enough to keep a
compound page from being split up. I plan on doing some testing tomorrow,
but thought I would push these out now so that we could discuss them.

---

Alexander Duyck (3):
      mm: Drop locked from isolate_migratepages_block
      mm: Drop use of test_and_set_skip in favor of just setting skip
      mm: Identify compound pages sooner in isolate_migratepages_block


 mm/compaction.c |  126 +++++++++++++++++++------------------------------------
 1 file changed, 44 insertions(+), 82 deletions(-)

--
