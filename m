Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5184114060
	for <lists+cgroups@lfdr.de>; Thu,  5 Dec 2019 12:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfLELyW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Dec 2019 06:54:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31461 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729072AbfLELyW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Dec 2019 06:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575546861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xgKlH9tJuer1b/3JkA+0s5M6RQWE0+CpEaKCJzLJ5Hg=;
        b=dORX2PYykY188pMlaNXzahhwIIIIESGCYfWB/dulE4qa7cjNk+8csH7xtIA2UNbjnOMWfd
        hrDAoOou2FjxXjy1kXdrPvK2zNTbQ3EBbokmodTi9buOeefdgBSS1EYjPROJgpGM3oJjsl
        BO3VQPpLn9dypku4dxtdu6VE/abVtgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-U6XqpV4ANE2-0Y5lwMNFrA-1; Thu, 05 Dec 2019 06:54:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FB1618543D6;
        Thu,  5 Dec 2019 11:54:16 +0000 (UTC)
Received: from localhost (unknown [10.36.118.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D99CF10013A1;
        Thu,  5 Dec 2019 11:54:15 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     cgroups@vger.kernel.org
Cc:     mike.kravetz@oracle.com, tj@kernel.org, mkoutny@suse.com,
        lizefan@huawei.com, hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH v4] mm: hugetlb controller for cgroups v2
References: <20191205114739.12294-1-gscrivan@redhat.com>
Date:   Thu, 05 Dec 2019 12:54:14 +0100
In-Reply-To: <20191205114739.12294-1-gscrivan@redhat.com> (Giuseppe Scrivano's
        message of "Thu, 5 Dec 2019 12:47:39 +0100")
Message-ID: <87eexj7ztl.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: U6XqpV4ANE2-0Y5lwMNFrA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

note: in the current implementation, there is no support for the
equivalent of "memory_localevents".

If there is request for it, I can add that as a separate patch on top of
the current one.

Giuseppe

