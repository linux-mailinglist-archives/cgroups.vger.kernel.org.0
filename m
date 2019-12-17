Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86DA122B78
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 13:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfLQM15 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 07:27:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20302 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727775AbfLQM15 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 07:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576585676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvWqfrkB3tYp4gw6CTTKcHLhfdHVPlflZaaCSTeR6/E=;
        b=XX++q6ZYSKPgF1djXu31Ra538oehj3xIMwLoOJGSSFh2J1Fn6K0269BxioEsLCGkmdhtsR
        1/yvAKELXecUkortIsEUl1rCdrRUF9U4VxddevBoRIcgEYW8RmevaFbDOS9G4Jx3QZM1VR
        vsOno4nU1KTD2+lPkny4vtO/ynj8GN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-6E3ESDy4Ny6kCTtFNLJ28Q-1; Tue, 17 Dec 2019 07:27:51 -0500
X-MC-Unique: 6E3ESDy4Ny6kCTtFNLJ28Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEE7A593A1;
        Tue, 17 Dec 2019 12:27:49 +0000 (UTC)
Received: from localhost (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CDE85D9C9;
        Tue, 17 Dec 2019 12:27:48 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, cgroups@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v6] mm: hugetlb controller for cgroups v2
References: <20191216193831.540953-1-gscrivan@redhat.com>
        <20191216204348.GF2196666@devbig004.ftw2.facebook.com>
        <20191216132747.1f02af9da0d7fa6a3e5e6c70@linux-foundation.org>
        <CAHS8izP1hrDOyjjWOu2xoy=-8Jz_in3ZiMVzvXb+pReOAyLc8w@mail.gmail.com>
Date:   Tue, 17 Dec 2019 13:27:47 +0100
In-Reply-To: <CAHS8izP1hrDOyjjWOu2xoy=-8Jz_in3ZiMVzvXb+pReOAyLc8w@mail.gmail.com>
        (Mina Almasry's message of "Mon, 16 Dec 2019 13:49:24 -0800")
Message-ID: <87bls7jfwc.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> On Mon, Dec 16, 2019 at 1:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Mon, 16 Dec 2019 12:43:48 -0800 Tejun Heo <tj@kernel.org> wrote:
>>
>> > On Mon, Dec 16, 2019 at 08:38:31PM +0100, Giuseppe Scrivano wrote:
>> > > In the effort of supporting cgroups v2 into Kubernetes, I stumped on
>> > > the lack of the hugetlb controller.
>> > >
>> > > When the controller is enabled, it exposes four new files for each
>> > > hugetlb size on non-root cgroups:
>> > >
>> > > - hugetlb.<hugepagesize>.current
>> > > - hugetlb.<hugepagesize>.max
>> > > - hugetlb.<hugepagesize>.events
>> > > - hugetlb.<hugepagesize>.events.local
>> > >
>> > > The differences with the legacy hierarchy are in the file names and
>> > > using the value "max" instead of "-1" to disable a limit.
>> > >
>> > > The file .limit_in_bytes is renamed to .max.
>> > >
>> > > The file .usage_in_bytes is renamed to .current.
>> > >
>> > > .failcnt is not provided as a single file anymore, but its value can
>> > > be read through the new flat-keyed files .events and .events.local,
>> > > through the "max" key.
>> > >
>> > > Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> >
>> > Acked-by: Tejun Heo <tj@kernel.org>
>> >
>> > This can go through either the mm tree or the cgroup tree.  If Andrew
>> > doesn't pick it up in several days, I'll apply it to cgroup/for-5.6.
>> >
>>
>> Thanks, I grabbed it.
>>
>> Giuseppe, yuo presumably have test code lying around.  Do you have
>> something which can be tossed together for tools/testing/selftests/?
>> Presumably under cgroup/.
>>
>> We don't seem to have much in the way of selftest code for cgroups.  I
>> wonder why.
>
> Just FYI I have a patch series in review that does a hefty bit of
> modifications to hugetlb_cgroup, and that comes with a decent bit of
> tests for hugetlb cgroup (and only hugetlb cgroups, I'm not looking
> into memcg tests or cgroup tests in general):
> https://lkml.org/lkml/2019/10/29/1203
>
> If Giuseppe adds tests for hugetlb cgroup v2 that would be great, but
> if not, a decent bit of hugetlb cgroup tests should be coming your way
> as my series gets reviewed.

I've some code I've used to test the hugetlb cgroup that I can clean up
and include in the selftests.

Mina, are you going to rebase your patchset?  I can add new tests for
cgroup v2 on top of yours.

Regards,
Giuseppe

