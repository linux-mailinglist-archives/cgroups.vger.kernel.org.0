Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC06F112BDA
	for <lists+cgroups@lfdr.de>; Wed,  4 Dec 2019 13:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfLDMpm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Dec 2019 07:45:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46464 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726832AbfLDMpm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Dec 2019 07:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575463541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oRUrNTczCFLoNrgRs3sRDxk8fQv6ECtVtgVfNpAcX9s=;
        b=QLJbITweNypcHeJm/arW+TYIPyn+ecyqbeI9XJQ+UgdJD52Z2ZzTFsv3LwCvZVJayYTG/P
        srMwVYubQgnYJsYk1nJX7R7OYdohB7PR+UmLyDrVb5bKATkROntQEPCCyjPWz6t9Fjv0dX
        KWsXdM/FSpYrFgMA3b7Lj2Tf0RG4/AM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-5CwklinYMg-7FRUphHdK2Q-1; Wed, 04 Dec 2019 07:45:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97723800D5E;
        Wed,  4 Dec 2019 12:45:36 +0000 (UTC)
Received: from localhost (ovpn-116-76.ams2.redhat.com [10.36.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0273260C63;
        Wed,  4 Dec 2019 12:45:35 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
References: <20191127124446.1542764-1-gscrivan@redhat.com>
        <20191203144602.GB20677@blackbody.suse.cz>
        <59c7e7a2-e8bb-c7b8-d7ec-1996ef350482@oracle.com>
        <CAHS8izOegERV08QJ=GgsvPLWmQieYcsNccwucyMY_HOuX12wRw@mail.gmail.com>
Date:   Wed, 04 Dec 2019 13:45:34 +0100
In-Reply-To: <CAHS8izOegERV08QJ=GgsvPLWmQieYcsNccwucyMY_HOuX12wRw@mail.gmail.com>
        (Mina Almasry's message of "Tue, 3 Dec 2019 12:39:36 -0800")
Message-ID: <87fti0i7ip.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 5CwklinYMg-7FRUphHdK2Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

>> Mina has been working/pushing the effort to add reservations to cgroup
>> accounting and would be the one to ask.  However, it does seem that the
>> names here should be created in anticipation of adding reservations in
>> the future.  So, perhaps something like:
>>
>> hugetlb_usage.<hugepagesize>.current
>>
>> with the new functionality having names like
>>
>> hugetlb_reserves.<hugepagesize>.current
>
> I was thinking I'll just rebase my patches on top of this patch and
> add the files for the reservations myself, since Guiseppe doesn't have
> an implementation of that locally so the files would be dummies (or
> maybe they would mirror the current counters).
>
> But if Guiseppe is adding them then that's fine too. I would prefer names=
:
>
> hugetlb.<hugepagesize>.current_reservations
> hugetlb.<hugepagesize>.max_reservations

I think it is better to add them as part of the patch that is also
adding the functionality.

I've fixed the issue with events and events.local Michal reported, now
it works similarly to the memcg.

I'll send the updated version once we agree on the file names to use.

Are you fine if I keep these two file names?

- hugetlb.<hugepagesize>.current
- hugetlb.<hugepagesize>.max

Regards,
Giuseppe

