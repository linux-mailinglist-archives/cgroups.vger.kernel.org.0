Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440AA110584
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2019 20:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfLCTwj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Dec 2019 14:52:39 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50500 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726564AbfLCTwj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Dec 2019 14:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575402758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWYPRN+TzChldxqtpzTWCuALs03Cz0VNhtiJFHJ1TaE=;
        b=K0NhsZjzcHlSK60LhkGBxsKvM4qr86OxMoJXG08VMD7GosFC4/VmcqGAaL24rWnfc4LIAu
        dTOnxMtuLG9mBJLNP11I7EUEv6gKgM8m3y3uHrjVP9f8Tqumzb0BEkZjHffcQzVnDaL684
        Ac2reQSy+NJJlIG95NKYEi14sS+ZRdA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-QmD-GqlENV6FTYwCy0hAkQ-1; Tue, 03 Dec 2019 14:52:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71936800D41;
        Tue,  3 Dec 2019 19:52:32 +0000 (UTC)
Received: from localhost (ovpn-116-76.ams2.redhat.com [10.36.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F123F1D1;
        Tue,  3 Dec 2019 19:52:31 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com, tj@kernel.org,
        lizefan@huawei.com, hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
References: <20191127124446.1542764-1-gscrivan@redhat.com>
        <20191203144602.GB20677@blackbody.suse.cz>
Date:   Tue, 03 Dec 2019 20:52:30 +0100
In-Reply-To: <20191203144602.GB20677@blackbody.suse.cz> ("Michal
 =?utf-8?Q?Koutn=C3=BD=22's?=
        message of "Tue, 3 Dec 2019 15:46:02 +0100")
Message-ID: <87lfrti3up.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: QmD-GqlENV6FTYwCy0hAkQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Koutn=C3=BD <mkoutny@suse.com> writes:

> 1) Is that on purpose that the events_file (and hence notifications) are
> shared across various huge page sizes?
>
> 2) Note that page_counter_try_charge checks hierarchically all counters
> (not just the current h_cg's) and the limit may also be hit in an
> ancestor (the third argument). I.e. the notification should be triggered
> in the cgroup that actually crossed the limit.
>
> Furthermore, the hierarchical and local events. I suggest looking at
> memcg_memory_event for comparison.
>
> If I take one step back. Is there a consumer for these events? I can see
> the reasoning is the analogy with memcg's limits and events [1] but
> wouldn't be a mere .stats file enough?

just an error on my side.  Thanks for the hint, I'll take a look at the
existing controller.  If everyone agrees I'll split events in two files:

- hugetlb.<SIZE>.events
- hugetlb.<SIZE>.events.local

Giuseppe

