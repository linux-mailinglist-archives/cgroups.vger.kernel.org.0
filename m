Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86F621F63B
	for <lists+cgroups@lfdr.de>; Wed, 15 May 2019 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfEOOLn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 May 2019 10:11:43 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39253 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbfEOOLm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 May 2019 10:11:42 -0400
Received: by mail-yb1-f196.google.com with SMTP id x5so974639ybn.6
        for <cgroups@vger.kernel.org>; Wed, 15 May 2019 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DkABSB9+ocVSEDM1acJkspFNCkj7bZrir9llBRZBZbk=;
        b=diNffEIXfA/QFvQ4JDN4yWPbBFk9QYgBHQ4+BVJ1NfD0TF6g+5vVE0YSL1BnVjtejf
         CrAeQK4hrTmj1WQuMCeXacIymo+qMfuKsRMkXThtVIfdGWD3UWU68tOQie85EkAx3kZA
         YA78rnXPrmWhtTDNmjqohIlpLATlRKpAgbVUzdHZ/0oIWDRCWeJPe4MkeQfL4NNPlAhb
         5gw18O/g48n/nZ7gRYd6s2xdXe7fCpmxbuVDtTd8Fhd7nK4blg8+HLxt6MmLicorJV+J
         ANLAPFx1lNLWprZ3HdLcTYYUg1gfx/xT6ADtn2L5nwfSQpvrZp2SEK2dbyUh8ZEYZ9Xq
         UKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DkABSB9+ocVSEDM1acJkspFNCkj7bZrir9llBRZBZbk=;
        b=U+MhA8P24rSrIYmWEP2YNsHuT5VOwaFGukKvVsHsBvxw2AyHosomUdAORYY0+8+FpP
         TSDgBEzm3y0hd3+K66zgIGZEst9wWYOfHZHy5TfNlmJgfb8m/c3ihWaJhYfeZLo7Ue44
         JOYRiGpr1uuY3HUuiAegQgoaV6Z0tlCSnYhBOlsBYYtwkAYN19ufcufZgz4bLuShRUWo
         EXxJ5ZGjUdt2ZtscZ2eHp8nV8fP6ODfMYorEtHCKVDQG+DTbf4X1/p34k6495jbSKWzg
         NRWN6kafpGbks2np67gq4GZaUgmXBDmZqqf+7RoKVYfxX4ctz9G099Bkwg4ypk5UM0QM
         uxGg==
X-Gm-Message-State: APjAAAUaicr/HXsF40vKYlX36akyW/609J4Ec6w5OSg3koyZgyLF6lgN
        5ejK4GIN77f4RevasqLd63VDhY8uvnJx434KF/hCyw==
X-Google-Smtp-Source: APXvYqwFVrkJc6Ars41vZLv1PWwWvp79P7NNy1HRLGKPliMA4SZgci9iPnaAggH1BDGnbrEDsgGovH0KqGY39VpJ6TM=
X-Received: by 2002:a25:4147:: with SMTP id o68mr20740148yba.148.1557929501573;
 Wed, 15 May 2019 07:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190514213940.2405198-1-guro@fb.com> <20190514213940.2405198-6-guro@fb.com>
 <0100016abbcb13b1-a1f70846-1d8c-4212-8e74-2b9be8c32ce7-000000@email.amazonses.com>
In-Reply-To: <0100016abbcb13b1-a1f70846-1d8c-4212-8e74-2b9be8c32ce7-000000@email.amazonses.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 15 May 2019 07:11:30 -0700
Message-ID: <CALvZod5dMM50pZWuOR5SN7aPPG8Zsp-+U3Y+q-UHTNo=Dgz-Nw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] mm: rework non-root kmem_cache lifecycle management
To:     Christopher Lameter <cl@linux.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christopher Lameter <cl@linux.com>
Date: Wed, May 15, 2019 at 7:00 AM
To: Roman Gushchin
Cc: Andrew Morton, Shakeel Butt, <linux-mm@kvack.org>,
<linux-kernel@vger.kernel.org>, <kernel-team@fb.com>, Johannes Weiner,
Michal Hocko, Rik van Riel, Vladimir Davydov,
<cgroups@vger.kernel.org>

> On Tue, 14 May 2019, Roman Gushchin wrote:
>
> > To make this possible we need to introduce a new percpu refcounter
> > for non-root kmem_caches. The counter is initialized to the percpu
> > mode, and is switched to atomic mode after deactivation, so we never
> > shutdown an active cache. The counter is bumped for every charged page
> > and also for every running allocation. So the kmem_cache can't
> > be released unless all allocations complete.
>
> Increase refcounts during each allocation? Looks to be quite heavy
> processing.

Not really, it's a percpu refcnt. Basically the memcg's
percpu_ref_tryget* is replaced with kmem_cache's percpu_ref_tryget,
so, no additional processing.
