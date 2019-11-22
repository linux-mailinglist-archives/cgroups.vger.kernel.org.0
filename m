Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18809106866
	for <lists+cgroups@lfdr.de>; Fri, 22 Nov 2019 09:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKVIyA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Nov 2019 03:54:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726546AbfKVIyA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Nov 2019 03:54:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574412839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4QqIgWoaE+Xswep+dV48vmDan20VoXRhnYLhtuXiKc=;
        b=ig/SBx4an9jC50cDNRPiCD0dTMuoM+CJJ6CyWNul1mX0uMsrQcGkGJUV3xpPq6VGZue0vh
        luF6BlSX4bBn5yY9eyKHOH9hY8pcitI85uo44F3AtUPf/Wu89HAtbIi0Q53n5SPS3Rqjes
        SpeO1dRNr3OnItp8914KsmEJL6ADIIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345--hvr_qoHP9aBliNVjr4Nnw-1; Fri, 22 Nov 2019 03:53:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA01C1085986;
        Fri, 22 Nov 2019 08:53:54 +0000 (UTC)
Received: from localhost (ovpn-116-217.ams2.redhat.com [10.36.116.217])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93FDD61F36;
        Fri, 22 Nov 2019 08:53:53 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     cgroups@vger.kernel.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugetlb controller for cgroups v2
References: <20191121211424.263622-1-gscrivan@redhat.com>
        <CAHS8izPwEFbdtNrDT-xfPs9Zc1YoAY5hmDH0j3fbRZE-OjneuQ@mail.gmail.com>
Date:   Fri, 22 Nov 2019 09:53:52 +0100
In-Reply-To: <CAHS8izPwEFbdtNrDT-xfPs9Zc1YoAY5hmDH0j3fbRZE-OjneuQ@mail.gmail.com>
        (Mina Almasry's message of "Thu, 21 Nov 2019 14:36:12 -0800")
Message-ID: <87tv6wmgv3.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: -hvr_qoHP9aBliNVjr4Nnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Mina,

Mina Almasry <almasrymina@google.com> writes:

> On Thu, Nov 21, 2019 at 1:14 PM Giuseppe Scrivano <gscrivan@redhat.com> w=
rote:
>>
>> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
>> the lack of the hugetlb controller.
>>
>> When the controller is enabled, it exposes three new files for each
>> hugetlb size on non-root cgroups:
>>
>> - hugetlb.<hugepagesize>.current
>> - hugetlb.<hugepagesize>.max
>> - hugetlb.<hugepagesize>.stat
>>
>> The differences with the legacy hierarchy are in the file names and
>> using the value "max" instead of "-1" to disable a limit.
>>
>> The file .limit_in_bytes is renamed to .max.
>>
>> The file .usage_in_bytes is renamed to .usage.
>>
>
> I could be wrong here but I think the memcg files are not renamed, so
> the same file names exist in v1 and v2. Can we follow that example?

I've enabled all the controllers, but I don't see files under
/sys/fs/cgroup that have the .limit_in_bytes or .usage_in_bytes suffix.

To what files are you referring to?

Thanks,
Giuseppe

