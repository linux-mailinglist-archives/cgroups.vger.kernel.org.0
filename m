Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094242AFED4
	for <lists+cgroups@lfdr.de>; Thu, 12 Nov 2020 06:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgKLFic (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Nov 2020 00:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgKLC2o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Nov 2020 21:28:44 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A696DC0613D4
        for <cgroups@vger.kernel.org>; Wed, 11 Nov 2020 18:28:42 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id j14so4207589ots.1
        for <cgroups@vger.kernel.org>; Wed, 11 Nov 2020 18:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=AvwRUTHJ9jTp1FV7SvxjXPTpodIViw+Olzzn0cdboYg=;
        b=lMyQa3HoSGrWwK8T9kKUMIlmfO5rgLpJnycM2uiTklWJC1raq7dGrWwm2m9/O/if2P
         3n7ga50tjyyPXWvWHiYwKwgL71HOGc0UsHfCamf5Lb/v6jwKiGtkZaV+P/Wht/+eQ0gk
         72CTbdBOF5eQeyXTRetfdXuu3yjIbyVQER+3mo8NswaNnZCCSwUw3+GXKNdL+WpEJPsc
         ZiloYfx5zK7I6BMUOJdaXePB/dRGYPw1vVDN88kE+Fh7udX6Jzsp3ynwIwSGo4T8Wq8k
         XyE0c8ANci/qxhmbZ7uB9liD3aqNmaCP5Ne/bJd5re/Pi7/eHeAqVlF05mv7yH2RRQyu
         ZXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=AvwRUTHJ9jTp1FV7SvxjXPTpodIViw+Olzzn0cdboYg=;
        b=Csc38uY6j6DgtYzvraAPQmvMfpbq663YPmGdotf3XsSdqu3uaQeBfRYX/SYA5PYqA0
         u2M964ITJ0OJpDR4cOUmUbnX5k0FX1VfN1eMJghPFssrRX2X/omncab1U29Q5fCCBjnN
         5qfZ+AfQBESGWWS7z8mQPqSXUqildnsuZiKmn8zPZ8EGzx4+pgu9Y4EKhWg6db6PyMKU
         lxydB6hi/5KvgRyvAVTYS+B1xynlTOdFh/mVzvMtOlCDh4huRqfMNXLvkAgkdUJu0rV7
         OOn2fGvotyMDkgdAgd/VTj5rh6RSWWebTS8V4teZUnR0jYBlq/C1JeQpDjbWrSWEYaZE
         8Wgw==
X-Gm-Message-State: AOAM532fPCgVLxhU5s/N27crSzkMvzi9Nphx6gfytnpREjlix2eIE3Bz
        hNS4Vp8pdZ16pfu5VCCAdPcWmw==
X-Google-Smtp-Source: ABdhPJyzQWbqz38yLAmtNxgQ/7L8jQxu79O3IRdahxiukEm5uaBC3UhwBHYm+Dr9JmbN+3xGvHDZGw==
X-Received: by 2002:a9d:6a96:: with SMTP id l22mr4298651otq.156.1605148121715;
        Wed, 11 Nov 2020 18:28:41 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s14sm851761oij.4.2020.11.11.18.28.39
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2020 18:28:40 -0800 (PST)
Date:   Wed, 11 Nov 2020 18:28:38 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v21 15/19] mm/compaction: do page isolation first in
 compaction
In-Reply-To: <a0b8c198-6bd0-2ccb-fe55-970895c26a0b@suse.cz>
Message-ID: <alpine.LSU.2.11.2011111803580.2174@eggly.anvils>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com> <1604566549-62481-16-git-send-email-alex.shi@linux.alibaba.com> <a0b8c198-6bd0-2ccb-fe55-970895c26a0b@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 11 Nov 2020, Vlastimil Babka wrote:
> On 11/5/20 9:55 AM, Alex Shi wrote:
> 
> > @@ -979,10 +995,6 @@ static bool too_many_isolated(pg_data_t *pgdat)
> >   					goto isolate_abort;
> >   			}
> >   -			/* Recheck PageLRU and PageCompound under lock */
> > -			if (!PageLRU(page))
> > -				goto isolate_fail;
> > -
> >   			/*
> >   			 * Page become compound since the non-locked check,
> >   			 * and it's on LRU. It can only be a THP so the order
> > @@ -990,16 +1002,13 @@ static bool too_many_isolated(pg_data_t *pgdat)

Completely off-topic, and won't matter at all when Andrew rediffs into
mmotm: but isn't it weird that this is showing "too_many_isolated(",
when actually the function is isolate_migratepages_block()?

> >   			 */
> >   			if (unlikely(PageCompound(page) &&
> > !cc->alloc_contig)) {
> >   				low_pfn += compound_nr(page) - 1;
> > -				goto isolate_fail;
> > +				SetPageLRU(page);
> > +				goto isolate_fail_put;
> >   			}
> 
> IIUC the danger here is khugepaged will collapse a THP. For that,
> __collapse_huge_page_isolate() has to succeed isolate_lru_page(). Under the
> new scheme, it shouldn't be possible, right? If that's correct, we can remove
> this part?

I don't think so.  A preliminary check for PageCompound was made much
higher up, before taking a reference on the page, but it can easily have
become PageCompound since then (when racing prep_new_page() calls
prep_compound_page()).

And __collapse_huge_page_isolate() does not turn a non-compound page
into a compound page: it isolates small pages before copying them into
the compound page (in the usual case: I can see there's also allowance
for PageCompound there too, which will do something different).

Hugh
