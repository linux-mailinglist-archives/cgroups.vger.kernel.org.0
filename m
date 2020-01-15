Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB86E13B823
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2020 04:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbgAOD05 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 22:26:57 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40204 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgAOD05 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Jan 2020 22:26:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id bg7so6974311pjb.5
        for <cgroups@vger.kernel.org>; Tue, 14 Jan 2020 19:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Iae/mJgVCLpfLGSuYynupuWE+Z4MahohKNOA3VuWzvQ=;
        b=bpGcNk0KuEcv+Ht10XLkBn/HP68yrADkbQzthX19bcUJf/xKxwL4QilvYOrq63iLtP
         QXHGouASBxogJp3LM3yUP91HjYlur9dWJbk1ZdvMkGziZgmXfsEb4avARPSYrYz4rAi2
         OvLl6gWqyFfYMDOctvwF2bIE93PVsy8D7diUVOYObx1xhI1j8NNS0J3jP1ta1FEOYUhN
         fJkqV4C0RQGqlxMN8DMVvJKf7dAkzkAKKtQ1NBTJvxMf445Hmw2mTio4MwQ4BCYmKke0
         akfN3Qikj18K8eS4W8yDU5sAvOYFxPTnfoLGu4VRBE1cm/xaJ5NtSGJk5PobXwkuqimc
         oTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Iae/mJgVCLpfLGSuYynupuWE+Z4MahohKNOA3VuWzvQ=;
        b=BRa+74MfO3QjW/QMR0t4Fz7HtE5kyi/SdJlBrrzs/zo/5TS3riPPyqfouT1kyiN/sv
         AI2rT7JtnT1mLoaCdqQUOfenX7Od2QO6BDxoasRGwSxJyFQ+/MAsKOyOr98cyHEgiVSl
         blAHGxycwY1NCfucx97d/zAWTG9FFMYN4zdweS5D6q5q9XS136a4K17aRey79HMaN5oR
         qvSMZnRhGTJPEZfOX2FXJt3dAaUSiY/gwJOE0kCWQHKklRwUuupt+WYiK/Sqe8SFE621
         SYcK8lurjZ3GB9I8iSnul01pu1NbDwQvzcDFmS84hKsGFkoBSmy0BNMtSaIPtxIOuXfd
         eP7w==
X-Gm-Message-State: APjAAAWW/24HxyOGnjGpwEQEPDQZDVgHy5sSvzD5Nl4UNJUtS55oTw3o
        f/VQRMJRDI9gCJyzOjrCmgKelA==
X-Google-Smtp-Source: APXvYqwymAKsgPxc8cksJon02QT8iWkblHOgN2DfaxP7yMktruZkpOMfqWcYVlLtqQMUC1ww0gHogA==
X-Received: by 2002:a17:902:7e49:: with SMTP id a9mr22409863pln.230.1579058815911;
        Tue, 14 Jan 2020 19:26:55 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a6sm18050644pgg.25.2020.01.14.19.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 19:26:54 -0800 (PST)
Date:   Tue, 14 Jan 2020 19:26:53 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, alexander.duyck@gmail.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200115010722.GA4916@richard>
Message-ID: <alpine.DEB.2.21.2001141924330.114086@chino.kir.corp.google.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com> <20200111000352.efy6krudecpshezh@box> <20200114093122.GH19428@dhcp22.suse.cz> <20200114103112.o6ozdbkfnzdsc2ke@box> <20200114105921.eo2vdwikrvtt3gkb@box> <20200115010722.GA4916@richard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 15 Jan 2020, Wei Yang wrote:

> >split_huge_page_to_list() has page lock taken.
> >
> >free_transhuge_page() is in the free path and doesn't susceptible to the
> >race.
> >
> >deferred_split_scan() is trickier. list_move() should be safe against
> >list_empty() as it will not produce false-positive list_empty().
> >list_del_init() *should* (correct me if I'm wrong) be safe because the page
> >is freeing and memcg will not touch the page anymore.
> >
> >deferred_split_huge_page() is a problematic one. It called from
> >page_remove_rmap() path witch does require page lock. I don't see any
> >obvious way to exclude race with mem_cgroup_move_account() here.
> >Anybody else?
> 
> If my understanding is correct, the reason is deferred_split_huge_page()
> doesn't has page lock taken, right?
> 

I think the fix that you have proposed has inspired some deeper looks at 
the locking around the deferred split queue and the hope was that perhaps 
this could be protected by the page lock but it was found that at least in 
one path that isn't taken.  So I believe your fix is still needed and any 
possible optimizations in this area can be proposed on top.
