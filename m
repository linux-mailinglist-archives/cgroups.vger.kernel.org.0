Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA7C2EB520
	for <lists+cgroups@lfdr.de>; Tue,  5 Jan 2021 23:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbhAEWDQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jan 2021 17:03:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730589AbhAEWDP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jan 2021 17:03:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609884109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCiTIr0SkXb9xXdCM/zdjzsQYQMxU0c5XLqeexCynRw=;
        b=NBkENRmuICr3VYRHCkPxXtB0nOwfFsfgvOu2NyyJ11KvEY7BDlBN+awUXXJzcPv24YVSFW
        GvUZ0TMHu9dvSI5uiJjbsldWisMVifHf/+S7zU89Jdpj1SEhoyNPB4VHPpmpV5gr0+anlA
        Y1e5iKPfPF3NRHfrpMZKIwmT92qEktI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-v1618q3dM_CPEgMXu8h55A-1; Tue, 05 Jan 2021 17:01:44 -0500
X-MC-Unique: v1618q3dM_CPEgMXu8h55A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 02B3B801B14;
        Tue,  5 Jan 2021 22:01:41 +0000 (UTC)
Received: from ovpn-115-104.rdu2.redhat.com (ovpn-115-104.rdu2.redhat.com [10.10.115.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AB055D9D2;
        Tue,  5 Jan 2021 22:01:37 +0000 (UTC)
Message-ID: <f127c35a34a391d20b05c53c17adeb72464b28ee.camel@redhat.com>
Subject: Re: [PATCH v21 00/19] per memcg lru lock
From:   Qian Cai <qcai@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <lkp@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        alexander.duyck@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <shy828301@gmail.com>
Date:   Tue, 05 Jan 2021 17:01:37 -0500
In-Reply-To: <alpine.LSU.2.11.2101051326410.6519@eggly.anvils>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
         <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com>
         <CALvZod448Ebw7YE-HVCNXNSbtvTcTvQx+_EqcyxTVd_SZ4ATBA@mail.gmail.com>
         <49be27f2652d4658f80c95bea171142c35513761.camel@redhat.com>
         <alpine.LSU.2.11.2101051326410.6519@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 2021-01-05 at 13:35 -0800, Hugh Dickins wrote:
> This patchset went into mmotm 2020-11-16-16-23, so probably linux-next
> on 2020-11-17: you'll have had three trouble-free weeks testing with it
> in, so it's not a likely suspect.  I haven't looked yet at your report,
> to think of a more likely suspect: will do.

Probably my memory was bad then. Unfortunately, I had 2 weeks holidays before
the Thanksgiving as well. I have tried a few times so far and only been able to
reproduce once. Looks nasty...

