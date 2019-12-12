Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 274AF11D6F7
	for <lists+cgroups@lfdr.de>; Thu, 12 Dec 2019 20:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfLLTVd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Dec 2019 14:21:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730168AbfLLTVd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Dec 2019 14:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576178492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MNdyMW+9R8OjH9E5NWw9gkGV5v5acY4lW0YP7ujMB0E=;
        b=NfqDMtZcgm+bY6GhH+D8YG4hIRhPb4AIYonR96XQcH1dWC8lqt6MUTP3fzRcBiSfEttuL3
        d087b3bSYuLExcuA1w2bpPjHsIMF+xrDnlccER0+v2JSNsvr5raMy4a4rUGFngxCtuwfUR
        r6R+WoNDW5VPFAwaMFhPK7F7j4x65Rg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-gONwxeXJPHq7Tws4H7DOtw-1; Thu, 12 Dec 2019 14:21:27 -0500
X-MC-Unique: gONwxeXJPHq7Tws4H7DOtw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C770F477;
        Thu, 12 Dec 2019 19:21:24 +0000 (UTC)
Received: from localhost (ovpn-116-111.ams2.redhat.com [10.36.116.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4637410013A1;
        Thu, 12 Dec 2019 19:21:23 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     cgroups@vger.kernel.org
Cc:     mike.kravetz@oracle.com, tj@kernel.org, mkoutny@suse.com,
        lizefan@huawei.com, hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v4] mm: hugetlb controller for cgroups v2
References: <20191205114739.12294-1-gscrivan@redhat.com>
Date:   Thu, 12 Dec 2019 20:21:21 +0100
In-Reply-To: <20191205114739.12294-1-gscrivan@redhat.com> (Giuseppe Scrivano's
        message of "Thu, 5 Dec 2019 12:47:39 +0100")
Message-ID: <87fthpl58u.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Giuseppe Scrivano <gscrivan@redhat.com> writes:

> In the effort of supporting cgroups v2 into Kubernetes, I stumped on
> the lack of the hugetlb controller.
>
> When the controller is enabled, it exposes three new files for each
> hugetlb size on non-root cgroups:
>
> - hugetlb.<hugepagesize>.current
> - hugetlb.<hugepagesize>.max
> - hugetlb.<hugepagesize>.events
> - hugetlb.<hugepagesize>.events.local
>
> The differences with the legacy hierarchy are in the file names and
> using the value "max" instead of "-1" to disable a limit.
>
> The file .limit_in_bytes is renamed to .max.
>
> The file .usage_in_bytes is renamed to .usage.
>
> .failcnt is not provided as a single file anymore, but its value can
> be read through the new flat-keyed files .events and .events.local,
> through the "max" key.
>
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
> v4:
>   - fix .events file to record and notify all the events in the sub
>     directories
>   - add .events.local file to record events only in the current cgroup
>
> v3: https://www.spinics.net/lists/cgroups/msg23922.html
>   - simplify hugetlb_cgroup_read_u64_max and drop dead code
>   - notify changes to the .events file
>
> v2: https://www.spinics.net/lists/cgroups/msg23917.html
>   - dropped max_usage_in_bytes and renamed .stats::failcnt to .events::max
>
> v1: https://www.spinics.net/lists/cgroups/msg23893.html

is there anything I could do to move this forward?

Thanks,
Giuseppe

