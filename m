Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9708F1B2FD9
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgDUTNs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Apr 2020 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUTNs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Apr 2020 15:13:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9221CC0610D5
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 12:13:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so15209527ljd.3
        for <cgroups@vger.kernel.org>; Tue, 21 Apr 2020 12:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a/+YOMpTdK2B7DWfew1yvduwiCraaW2/kuntapldYZ0=;
        b=bUWoO33YlTxWoYWiORjP3cfd0fXYcJlwyVFVKaoJXnsvHiP4GSzVRDCjxFF08py8lN
         5ZUrKIqEk822Szjrlp1a4M6EooH0kyC/WpUqGiVwtSTYmjBfkxKXaIUk0OCxAPeXkyQt
         /6fuXhRJIF6ZD/CXoAAPg2r9Quv9ZDfp9xAv0Cx9MdvuVu74+9KjyhWDEj5qnLon4d8u
         nXYnLbO9ypaVJ5RXViyX+EC3kVxDVZ/QAZZ0OD1acVRZBUPXSJSR2gBVHUcVu1xrfS9Y
         rXdzeb62flwCVklON1DT44s3z++HTQophQ/mY77/dUZF7wNPPJZa/MEoe1DHqIarJdWt
         LZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/+YOMpTdK2B7DWfew1yvduwiCraaW2/kuntapldYZ0=;
        b=AQGzcZI8Yg+3A7B6bbJrg+wwRsjWfiAE1sLnRf2LlNJHOcnrYhu0wla6/04prsGSXN
         Y4Vy5GBmQwCno+okkqAnBSlFgDu7hraIGkgH3OMTeE53VyG3/m+SUgSN9WMgru1J4f4T
         ijL62/bSPRLf0nMmBSRstyuXD5jEeDmcYSZJ+GcyDK3YzwMXRQAL3aaO0MR9dLPq0DaU
         TmbR3mJB8TicXNnEj1C12AzKQ51TJoBglWIEr85IWFN6S7H2AMgvbHbPW+P7huOBW0Lh
         obECmg8R0mgwiK5Ds6aLiZaE56kHvKVu4m96Gg8wZK6V+QzTBfflrf52nmknoTBgd90U
         CmIQ==
X-Gm-Message-State: AGi0PuaqhA8NOQZFnECiPeugVifDYQrC2vkWpPryqkQhCcJtfRnyYGVP
        W9wxQ3MiPH7fRH22UlpwMokik1IrWqM1FftyP/yiiA==
X-Google-Smtp-Source: APiQypKipAK8wadINnlUb+Uo4VCJh7LWj2FEF1/+sowHcDfqmnlaXFG2Y5WcttyQhyOio2DlQGMNfqNHgxfZn6kUa2o=
X-Received: by 2002:a05:651c:1209:: with SMTP id i9mr12984953lja.250.1587496425813;
 Tue, 21 Apr 2020 12:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-2-hannes@cmpxchg.org>
In-Reply-To: <20200420221126.341272-2-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Apr 2020 12:13:34 -0700
Message-ID: <CALvZod4Rc0a1LBE7DCa0U8xA3a3N1u7g=mDjRw0cJEzvK62vmA@mail.gmail.com>
Subject: Re: [PATCH 01/18] mm: fix NUMA node file count error in replace_page_cache()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> When replacing one page with another one in the cache, we have to
> decrease the file count of the old page's NUMA node and increase the
> one of the new NUMA node, otherwise the old node leaks the count and
> the new node eventually underflows its counter.
>
> Fixes: 74d609585d8b ("page cache: Add and replace pages using the XArray")
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
