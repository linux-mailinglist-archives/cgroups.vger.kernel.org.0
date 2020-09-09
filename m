Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544C926382A
	for <lists+cgroups@lfdr.de>; Wed,  9 Sep 2020 23:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgIIVFj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Sep 2020 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIIVFi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Sep 2020 17:05:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7355FC061573
        for <cgroups@vger.kernel.org>; Wed,  9 Sep 2020 14:05:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n133so3856202qkn.11
        for <cgroups@vger.kernel.org>; Wed, 09 Sep 2020 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=jknzGmoqJw1EY5KNXFDJSNgXqjt2RuOtc/p1w7k0/AY=;
        b=qENp4mbYweCT8tAiqEN3O3TLh+thuG3dwWPJLgqJgRNAryhOqmBvIevkwDDtq/X+Cq
         IU2OoPp9i+zLhxB0W9Fliq1WToqWvbjwKfMcK+QyHwjV9Mj2DAFUOA/yqwhW7ZOJtXu/
         RwzgtlZTJIrzbFikLUMtDM+lR30uPVWwKKjYziRPi2gbMVfyaOvlu8i4qiJ92OCBrMvv
         4SOEUcUjqDmB42cQ3lWF+lINiNnPIcnQiNmmFVanyRhkZryZdbB3DQhd7yF9sCvlu1rZ
         vEhRhA1II2U3kVSRo3OH275fqPurXhxu3LWIjtb/aqeqWFFVpXs/RN9z9ZoE/mCEu44a
         s4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=jknzGmoqJw1EY5KNXFDJSNgXqjt2RuOtc/p1w7k0/AY=;
        b=HVn8rS8PJQnXCuYlud6m8d4mjYRcJNSZr0SNA5aeqqOtYX+YZHKjJdAY+/249KACHc
         1bsJSQJe0o18guwG1LY2iX+efrZ9jAJcTtqGVIZZ7G/cAhomIim4Jidot2YfkOK/EuEY
         GImOQUaAMfP53Q5yPpOPw0fBhXVd1exZgzyV2ov9wJnxa31wmv0hEGy6mCefUXL+O98J
         /lnz64kQ/Ooi9DZwUrZUP3SwuWOLd6qSrHV+QnIsmw4AifzNOgOaYtIQp4apYfpToXkV
         vDtJeiXAAzxlQqPFr8l3fCvggsNIVaMUdQxl7DZbKWnVcxTzBvOmZnIFS8kshjorer8k
         ZqGg==
X-Gm-Message-State: AOAM533yuPZo+mMe661qKB88vlCXBjhRkvGt1+3c1BEeIeTMfPAVT9Y/
        UrnQrWqRLV8xBVh7j9+SCzT2EA==
X-Google-Smtp-Source: ABdhPJzIHnUITkjhNzx36HupQ/sfRxXSwKpb2OivAv6/ZFVFzgHkZlZvShHJwwTX+di1qejHJNVayg==
X-Received: by 2002:a37:e401:: with SMTP id y1mr4090429qkf.150.1599685537274;
        Wed, 09 Sep 2020 14:05:37 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e9sm4063695qkb.8.2020.09.09.14.05.34
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2020 14:05:36 -0700 (PDT)
Date:   Wed, 9 Sep 2020 14:05:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: Re: [PATCH v18 31/32] mm: Add explicit page decrement in exception
 path for isolate_lru_pages
In-Reply-To: <20200909201530.GM6583@casper.infradead.org>
Message-ID: <alpine.LSU.2.11.2009091349100.9747@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-32-git-send-email-alex.shi@linux.alibaba.com> <20200909010118.GB6583@casper.infradead.org> <CAKgT0UcjNx=00OgAQNWezc7UjLmF2NcDH0p7kzZ5D23PaFrFXA@mail.gmail.com>
 <alpine.LSU.2.11.2009091100280.9020@eggly.anvils> <20200909201530.GM6583@casper.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 9 Sep 2020, Matthew Wilcox wrote:
> On Wed, Sep 09, 2020 at 11:24:14AM -0700, Hugh Dickins wrote:
> > After overnight reflection, my own preference would be simply to
> > drop this patch.  I think we are making altogether too much of a
> > fuss here over what was simply correct as plain put_page()
> > (and further from correct if we change it to leak the page in an
> > unforeseen circumstance).
> > 
> > And if Alex's comment was not quite grammatically correct, never mind,
> > it said as much as was worth saying.  I got more worried by his
> > placement of the "busy:" label, but that does appear to work correctly.
> > 
> > There's probably a thousand places where put_page() is used, where
> > it would be troublesome if it were the final put_page(): this one
> > bothered you because you'd been looking at isolate_migratepages_block(),
> > and its necessary avoidance of lru_lock recursion on put_page();
> > but let's just just leave this put_page() as is.
> 
> My problem with put_page() is that it's no longer the simple
> decrement-and-branch-to-slow-path-if-zero that it used to be.  It has the
> awful devmap excrement in it so it really expands into a lot of code.
> I really wish that "feature" could be backed out again.  It clearly
> wasn't ready for merge.

And I suppose I should thank you for opening my eyes to that.
I knew there was "dev" stuff inside __put_page(), but didn't
realize that the inline put_page() has now been defiled.
Yes, I agree, that is horrid and begs to be undone.

But this is not the mail thread for discussing that, and we should
not use strange alternatives to put_page(), here or elsewhere,
just to avoid that (surely? hopefully?) temporary excrescence.

Hugh
