Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3F2507FF
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHXSmH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 14:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHXSmG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 24 Aug 2020 14:42:06 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59D8F20866;
        Mon, 24 Aug 2020 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598294526;
        bh=Nd2awSgpg3NOzIIw5/W9KTQlYTFQWu5lPKGtd3+FdgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NOVxsxxfKZUuSkWhhaeTdPaLhuV4A66ePOhaJl3iuBe698JtvkFNo6oULxqlhRKP9
         go5x9qm6wtG2ewR1N11GC7U8IRi2+zLl5jsMqJbl1fpfY+Ehcgt4iV8yyI/eb7Q/wE
         BKPTYrXANG2WV2orZF5CadUwCkVAyb6/6Ktcz9Hg=
Date:   Mon, 24 Aug 2020 11:42:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v18 00/32] per memcg lru_lock
Message-Id: <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org>
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 24 Aug 2020 20:54:33 +0800 Alex Shi <alex.shi@linux.alibaba.com> wrote:

> The new version which bases on v5.9-rc2. The first 6 patches was picked into
> linux-mm, and add patch 25-32 that do some further post optimization.

32 patches, version 18.  That's quite heroic.  I'm unsure whether I
should merge it up at this point - what do people think?

> 
> Following Daniel Jordan's suggestion, I have run 208 'dd' with on 104
> containers on a 2s * 26cores * HT box with a modefied case:
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-lru-file-readtwice
> With this patchset, the readtwice performance increased about 80%
> in concurrent containers.

That's rather a slight amount of performance testing for a huge
performance patchset!  Is more detailed testing planned?

