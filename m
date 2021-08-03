Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A58B3DE72E
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 09:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhHCH2H (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 03:28:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42468 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhHCH2G (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 03:28:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B490C20010;
        Tue,  3 Aug 2021 07:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627975674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wuIGTu+T5iM4gV2NreSfqAlufJJUZ957ha88L+oyogc=;
        b=ffPnT6IT5q1xKUJXVgjcL901Ov2a69NYiPyHx1+Bs4Cbr4VGwvsntpN35cb37aoIkc3Ve7
        XCP50BxcQfHCaDDVkfzq2BtntlqQVlQJxBA6jMJ8GH4XRw8lbKAoPq8r0B4SWLIiS5PFQ1
        Mc+vR8f9wGNEVeByrJnEV2bgBgs2Z6I=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D9ADA3BC9;
        Tue,  3 Aug 2021 07:27:53 +0000 (UTC)
Date:   Tue, 3 Aug 2021 09:27:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "alexs@kernel.org" <alexs@kernel.org>,
        "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Message-ID: <YQjv+DzdX3CuVfIo@dhcp22.suse.cz>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com>
 <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
 <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
 <YQi6lOT6j2DtOGlT@carbon.dhcp.thefacebook.com>
 <95629d91-6ae8-b445-e7fc-b51c888cad59@huawei.com>
 <YQjsHTW+46bG9XsV@dhcp22.suse.cz>
 <898130C3-FDF2-41C2-81DD-D33721C977C6@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <898130C3-FDF2-41C2-81DD-D33721C977C6@fb.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 03-08-21 07:13:35, Roman Gushchin wrote:
> I’d go with atomic_dec().

which is not implying memory barriers either. You would need
atomic_dec_return or some other explicit barrier IIRC.
-- 
Michal Hocko
SUSE Labs
