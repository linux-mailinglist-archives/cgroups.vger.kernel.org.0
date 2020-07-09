Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA4021A403
	for <lists+cgroups@lfdr.de>; Thu,  9 Jul 2020 17:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGIPsS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Jul 2020 11:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbgGIPsS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Jul 2020 11:48:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86C6C08C5CE
        for <cgroups@vger.kernel.org>; Thu,  9 Jul 2020 08:48:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so2973588lji.2
        for <cgroups@vger.kernel.org>; Thu, 09 Jul 2020 08:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/O6H63+iy27zC2H7F0ueImelp7Ge5SFqvQCCzIgdoPI=;
        b=fJdsoF0IE+FLEEv9KDqsmMTunmNA1t7ytAqxnRwXZCyUBjvHa+7Feup8NmXZt2RCIu
         wsgnS324bHVYR7X24SjoapJxe8mrX3K9+2PcjnHWf6rNZtlb7ZolU+tws3K1hH1KVmcm
         bycKsH6D+8Qh9cjGdW5CUIhYqPa2fotIWVcNMVaZzViZEam/5tBRnUOj9UJO1x+fIc3m
         O8cVqipLSngqj+FzKufF+G68podLoQIbSZLK6hhNLOGNV82XT9hOnl60iqcAl0Y9sW56
         rQS8TUjYjEzWJepjjp1cqlqgBm1rgHT/O7QjaC3BjKm630xfivlUM+Jy9Sg0MDc3qNtn
         ucVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/O6H63+iy27zC2H7F0ueImelp7Ge5SFqvQCCzIgdoPI=;
        b=BW1sGMUD5wBkYFxysSqlE41EqvzT8IDbIxf9V7LE2c48cgBKw8mSNbd3kj8vGV3EC8
         A4NbFfRxkX9NlO/Tp+wIvolqS6nnIiUxgeeov2Tb658gf4ylF+E8HwqvFw8/2Xl7DHOy
         Xz3YRUuZRxMRzxCg3/Q7gK8/NpmoOqzUzCWUlk22jCoKkHlgj2qBup1ot6unjmgF9/rB
         dKw1OCSX7uJFDeoUOymVvJ1ldKrDTbriq+xW6YsII1Hyt/ugpjzY//e831MCnQU3yTz4
         4JLd5goVUJkEvocfs7zGTWx/j/nugicLq91h9KazT6kWFlZWth7Cf7GDK78OpUe8ZAnq
         N8iQ==
X-Gm-Message-State: AOAM531sYKMuR4uS+tS1L/O7iSjIHcAHkb6+TS6ZtxDhfJSD9OtHr2lm
        v8Q/aRsrVxqXHYbvx1Dw+PsYxQ==
X-Google-Smtp-Source: ABdhPJwXJuJPmi0hCIRXh7hOH2stPsHaUlbTEb3sv+IZgUbomityN8CqxmAJv3P/iYDzqj1wj1dh5A==
X-Received: by 2002:a2e:9144:: with SMTP id q4mr21400278ljg.84.1594309696184;
        Thu, 09 Jul 2020 08:48:16 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 83sm1055834lfk.84.2020.07.09.08.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 08:48:15 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8F36210222B; Thu,  9 Jul 2020 18:48:16 +0300 (+03)
Date:   Thu, 9 Jul 2020 18:48:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        lkp@intel.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Subject: Re: [PATCH v14 07/20] mm/thp: narrow lru locking
Message-ID: <20200709154816.wieg5thfejyv2h2l@box>
References: <1593752873-4493-1-git-send-email-alex.shi@linux.alibaba.com>
 <1593752873-4493-8-git-send-email-alex.shi@linux.alibaba.com>
 <124eeef1-ff2b-609e-3bf6-a118100c3f2a@linux.alibaba.com>
 <20200706113513.GY25523@casper.infradead.org>
 <alpine.LSU.2.11.2007062059420.2793@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007062059420.2793@eggly.anvils>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 06, 2020 at 09:52:34PM -0700, Hugh Dickins wrote:
> On Mon, 6 Jul 2020, Matthew Wilcox wrote:
> > On Mon, Jul 06, 2020 at 05:15:09PM +0800, Alex Shi wrote:
> > > Hi Kirill & Johannes & Matthew,
> 
> Adding Kirill, who was in patch's Cc list but not mail's Cc list.
> 
> I asked Alex to direct this one particularly to Kirill and Johannes
> and Matthew because (and I regret that the commit message still does
> not make this at all clear) this patch changes the lock ordering:
> which for years has been lru_lock outside memcg move_lock outside
> i_pages lock, but here inverted to lru_lock inside i_pages lock.
> 
> I don't see a strong reason to have them one way round or the other,
> and think Alex is right that they can safely be reversed here: but
> he doesn't actually give any reason for doing so (if cleanup, then
> I think the cleanup should have been taken further), and no reason
> for doing so as part of this series.

I've looked around and changing order of lru_lock wrt. i_pages lock seems
safe. I don't have much experience with memcg move_lock.

Alex, if you are going ahead with the patch, please document the locking
order. We have some locking orders listed at the beginning of filemap.c
and rmap.c.

local_irq_disable() also deserves a comment.

-- 
 Kirill A. Shutemov
