Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB711057E
	for <lists+cgroups@lfdr.de>; Tue,  3 Dec 2019 20:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLCTtl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Dec 2019 14:49:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30372 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726640AbfLCTtl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Dec 2019 14:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575402580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xZY/Fa6jv8+6DbMOh2fx4eUoa4dV0dwmn5JWKnenYrM=;
        b=Ja+eFvDT2HAd6wqmW4TB+LzYVWFo+Bv8UWj1DbNlTvm7xBAxM5XkuE+CtLsKiSm70jIM89
        hhE7kyG4MMu1p+cEHSLWv4cDlMmryjBbIVTGAg/CtXX7D3TnWRR1HN9aTfawOY92l+Ir5C
        VYE9uTjUupMofb/Xi9uYgZOay3XQDiY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87--i3ZqxPCOF-8eQKBsi9rBQ-1; Tue, 03 Dec 2019 14:49:37 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16BC8477;
        Tue,  3 Dec 2019 19:49:35 +0000 (UTC)
Received: from localhost (ovpn-116-76.ams2.redhat.com [10.36.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 047B75C541;
        Tue,  3 Dec 2019 19:49:33 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v3] mm: hugetlb controller for cgroups v2
References: <20191127124446.1542764-1-gscrivan@redhat.com>
        <20191203144602.GB20677@blackbody.suse.cz>
        <59c7e7a2-e8bb-c7b8-d7ec-1996ef350482@oracle.com>
Date:   Tue, 03 Dec 2019 20:49:32 +0100
In-Reply-To: <59c7e7a2-e8bb-c7b8-d7ec-1996ef350482@oracle.com> (Mike Kravetz's
        message of "Tue, 3 Dec 2019 11:42:57 -0800")
Message-ID: <87pnh5i3zn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -i3ZqxPCOF-8eQKBsi9rBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 12/3/19 6:46 AM, Michal Koutn=C3=BD wrote:
>> Hello.
>>=20
>> On Wed, Nov 27, 2019 at 01:44:46PM +0100, Giuseppe Scrivano <gscrivan@re=
dhat.com> wrote:
>>> - hugetlb.<hugepagesize>.current
>>> - hugetlb.<hugepagesize>.max
>>> - hugetlb.<hugepagesize>.events
>> Just out of curiosity (perhaps addressed to Mike), does this naming
>> account for the potential future split between reservations and
>> allocations charges?
>
> Mina has been working/pushing the effort to add reservations to cgroup
> accounting and would be the one to ask.  However, it does seem that the
> names here should be created in anticipation of adding reservations in
> the future.  So, perhaps something like:
>
> hugetlb_usage.<hugepagesize>.current
>
> with the new functionality having names like
>
> hugetlb_reserves.<hugepagesize>.current

that seems to be very different than other cgroup v2 file names.

Should it be something like?

hugetlb.<hugepagesize>.current_usage
hugetlb.<hugepagesize>.current_reserves

Alternatively, could we make hugetlb.<hugepagesize>.current a flat-keyed
file (or rename to .stat) so it can be easily extended in future?

Giuseppe

