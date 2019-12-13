Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E46A411E1ED
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2019 11:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLMK32 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Dec 2019 05:29:28 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25578 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbfLMK32 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Dec 2019 05:29:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576232967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Z0TFM5AXk7Qoe9QkAjK90diNXEHkvPDf5Fst1MN3bw=;
        b=gueH7XEJVqzxXzEq+DwJIdbgpNEN0VqBA/dySNV5s5cHG7NaNRcgoh982SiGwqf7fVDj+M
        8FewdeTd0C1i9l8pELkrLed9gkojZW78DYJYU+TJZv31bpyGlO4o5/hFhkId1kg6shudtm
        RcgKucIOgHYy6FiEiImCS/WEqynuekM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-kzsbzHV0OEq78RFk8GrISA-1; Fri, 13 Dec 2019 05:29:23 -0500
X-MC-Unique: kzsbzHV0OEq78RFk8GrISA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26722800D41;
        Fri, 13 Dec 2019 10:29:22 +0000 (UTC)
Received: from localhost (ovpn-116-111.ams2.redhat.com [10.36.116.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD17A60BA8;
        Fri, 13 Dec 2019 10:29:21 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        tj@kernel.org, mkoutny@suse.com, lizefan@huawei.com,
        almasrymina@google.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v4] mm: hugetlb controller for cgroups v2
References: <20191205114739.12294-1-gscrivan@redhat.com>
        <20191212194148.GB163236@cmpxchg.org>
        <2a203549-5fe6-f13f-7d96-7e33d88327c1@oracle.com>
Date:   Fri, 13 Dec 2019 11:29:20 +0100
In-Reply-To: <2a203549-5fe6-f13f-7d96-7e33d88327c1@oracle.com> (Mike Kravetz's
        message of "Thu, 12 Dec 2019 15:18:47 -0800")
Message-ID: <8736doldrz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Mike Kravetz <mike.kravetz@oracle.com> writes:

> On 12/12/19 11:41 AM, Johannes Weiner wrote:
>> [CC Andrew]
>> 
>> Andrew, can you pick up this patch please?
>> 
>> On Thu, Dec 05, 2019 at 12:47:39PM +0100, Giuseppe Scrivano wrote:
>>> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
>>> the lack of the hugetlb controller.
>>>
>>> When the controller is enabled, it exposes three new files for each
>
> Nit, there are four files now that you added "events.local"
>
>>> hugetlb size on non-root cgroups:
>>>
>>> - hugetlb.<hugepagesize>.current
>>> - hugetlb.<hugepagesize>.max
>>> - hugetlb.<hugepagesize>.events
>>> - hugetlb.<hugepagesize>.events.local
>>>
>>> The differences with the legacy hierarchy are in the file names and
>>> using the value "max" instead of "-1" to disable a limit.
>>>
>>> The file .limit_in_bytes is renamed to .max.
>>>
>>> The file .usage_in_bytes is renamed to .usage.
>> 
>> Minor point: that should be ".current" rather than ".usage"
>> 
>>> .failcnt is not provided as a single file anymore, but its value can
>>> be read through the new flat-keyed files .events and .events.local,
>>> through the "max" key.
>>>
>>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> 
>> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Since this has no impacts on core hugetlb code, and appears to do what is
> needed for cgroups v2, you can add:
>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

thanks for the reviews, I've fixed the commit message and sent the
updated version.

Giuseppe

