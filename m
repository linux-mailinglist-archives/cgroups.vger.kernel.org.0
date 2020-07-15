Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231EC2205FE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2020 09:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgGOHQJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jul 2020 03:16:09 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:17836 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728905AbgGOHQJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jul 2020 03:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594797369; x=1626333369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=HEw3+Ao/fqO9FvXA+Yo3+7G67lorJbwZfAa4e34wU6o=;
  b=FKkUZ+ixFASeTPY+2m6wAwM0YA2HW9sExpozMrc4IS3oO+zIytEYTxVC
   wpU5FRBncGRBUhiAI8GKnAVA4ZKnPyXxxBHbNKEho5pnIqDtedmHq559B
   E5uLm6OHdFZAla1czKEyzvjejFsE8NLosdLwzbR4QM3VcYxD3XKGgoGwR
   M=;
IronPort-SDR: bESFgyDUpLZQJ2zcI5QT+WenhUMp3wdsKik+XScOdDK1qGtavlf4orhYokhiCxRzO+tLf+5GlT
 5UWCX7q/0f8g==
X-IronPort-AV: E=Sophos;i="5.75,354,1589241600"; 
   d="scan'208";a="43418616"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 15 Jul 2020 07:15:52 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id 8C5C6A17C9;
        Wed, 15 Jul 2020 07:15:50 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 15 Jul 2020 07:15:50 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.146) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 15 Jul 2020 07:15:44 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     David Rientjes <rientjes@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Yang Shi" <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: Re: [patch] mm, memcg: provide a stat to describe reclaimable memory
Date:   Wed, 15 Jul 2020 09:15:22 +0200
Message-ID: <20200715071522.19663-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.23.453.2007142353350.2694999@chino.kir.corp.google.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.146]
X-ClientProxiedBy: EX13D14UWB003.ant.amazon.com (10.43.161.162) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello David,

On Wed, 15 Jul 2020 00:00:03 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> On Tue, 14 Jul 2020, David Rientjes wrote:
> 
[...]
> 
> An alternative to this would also be to change from an "available" metric 
> to an "anon_reclaimable" metric since both the deferred split queues and 
> lazy freeable memory would pertain to anon.  This would no longer attempt 
> to mimic MemAvailable and leave any such calculation to userspace
> (anon_reclaimable + (file + slab_reclaimable) / 2).
> 
> With this route, care would need to be taken to clearly indicate that 
> anon_reclaimable is not necessarily a subset of the "anon" metric since 
> reclaimable memory from compound pages on deferred split queues is not 
> mapped, so it doesn't show up in NR_ANON_MAPPED.
> 
> I'm indifferent to either approach and would be happy to switch to 
> anon_reclaimable if others agree and doesn't foresee any extensibility 
> issues.

Agreed, I was also once confused about the 'MemAvailable'.  The 'reclaimable'
might be better to understand.


Thanks,
SeongJae Park
