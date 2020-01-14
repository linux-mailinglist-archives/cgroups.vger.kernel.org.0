Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46D34139E9B
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2020 01:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgANAyt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 19:54:49 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37378 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728890AbgANAys (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Jan 2020 19:54:48 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so5054094pjb.2
        for <cgroups@vger.kernel.org>; Mon, 13 Jan 2020 16:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=i4tIlIuY63N7J2qzzaXh1IQqlXDyyq0nv6BqUm7J/CM=;
        b=mMc7iA8m150d3kyklJaIfPUS2LEM8UbRcQcpV5QNvWU77wKnxmOJ6sz0E0LSlnVhTX
         8/I9Ns2MxSDk9rXb1xF4T5hPjeY0Uu2InhFf2mcFnlyJgGgM/vBR+XGM6BSwl5/A/LAu
         RmX8S1Oet1NNxwkI5WL/FxVmTsVOhdNR+WycIjWSdZ/+SyQEv2OLW7OfaGWBxiTXXaay
         3ueCC6uKsQjt/8mCMPQz6L1bOEhiIuiqpjJwLYlH3Ry8GhLu1DdFa7IXn6UiPLfq3P4d
         KkQorMSl1NMIi+oKNHNpXPRFsPzLZJiyBfTirZCNGemoZZWKjYesHtxVVTjPLc3RyYwB
         3y3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=i4tIlIuY63N7J2qzzaXh1IQqlXDyyq0nv6BqUm7J/CM=;
        b=gz+NtqjJxKenPZcL2EipkuMfcg4xCAxfsLl8qHh8DuvOkzhPUG9muZiXj9b4muwz1D
         1jYFUGjCZI8M+hYEz0sBTe5KbTGmhNxESv87y2pXgiJPQf3eGvna+WqvY9DHgbLEXd8r
         8t6g/5MTyUsVejRj/gdSYQFo/yssADFPPUtFUklZz9cUsDJn+B58jRpzpLFsWrislC1R
         u83MDenx4lSapG8H4um26HPxTQQ2PI1F4yi+DPAowmI8fus/RhjWBueXmJKxLxu7yR6F
         sFEDXZiST/Dve1vjLOHJ9PKSfe+VLSxEyOTDzepax0+CkaS2Y9FpWQV3LcMb1D64XdKu
         P8lg==
X-Gm-Message-State: APjAAAWXR1Jg/b2NovOAw4seQRZUaPyfu6Zv6itkQ9lzj3oZhKyByIKl
        2xnEg6hY7qlh4exG4DKsIJ0InA==
X-Google-Smtp-Source: APXvYqw5Ad33yyrBH1TG7XCao+7rbWbRNYs7PR407QwkNL/P8BHAvovUlnJccNx+Ax/4T5ceApEwvQ==
X-Received: by 2002:a17:902:b781:: with SMTP id e1mr23718913pls.128.1578963287490;
        Mon, 13 Jan 2020 16:54:47 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y14sm15372185pfe.147.2020.01.13.16.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:54:46 -0800 (PST)
Date:   Mon, 13 Jan 2020 16:54:46 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shuah@kernel.org, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, mkoutny@suse.com,
        Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH v9 8/8] hugetlb_cgroup: Add hugetlb_cgroup reservation
 docs
In-Reply-To: <20191217231615.164161-8-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2001131649100.164268@chino.kir.corp.google.com>
References: <20191217231615.164161-1-almasrymina@google.com> <20191217231615.164161-8-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 17 Dec 2019, Mina Almasry wrote:

> diff --git a/Documentation/admin-guide/cgroup-v1/hugetlb.rst b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> index a3902aa253a96..efb94e4db9d5a 100644
> --- a/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> +++ b/Documentation/admin-guide/cgroup-v1/hugetlb.rst
> @@ -2,13 +2,6 @@
>  HugeTLB Controller
>  ==================
> 
> -The HugeTLB controller allows to limit the HugeTLB usage per control group and
> -enforces the controller limit during page fault. Since HugeTLB doesn't
> -support page reclaim, enforcing the limit at page fault time implies that,
> -the application will get SIGBUS signal if it tries to access HugeTLB pages
> -beyond its limit. This requires the application to know beforehand how much
> -HugeTLB pages it would require for its use.
> -
>  HugeTLB controller can be created by first mounting the cgroup filesystem.
> 
>  # mount -t cgroup -o hugetlb none /sys/fs/cgroup
> @@ -28,10 +21,14 @@ process (bash) into it.
> 
>  Brief summary of control files::
> 
> - hugetlb.<hugepagesize>.limit_in_bytes     # set/show limit of "hugepagesize" hugetlb usage
> - hugetlb.<hugepagesize>.max_usage_in_bytes # show max "hugepagesize" hugetlb  usage recorded
> - hugetlb.<hugepagesize>.usage_in_bytes     # show current usage for "hugepagesize" hugetlb
> - hugetlb.<hugepagesize>.failcnt		   # show the number of allocation failure due to HugeTLB limit
> + hugetlb.<hugepagesize>.reservation_limit_in_bytes     # set/show limit of "hugepagesize" hugetlb reservations
> + hugetlb.<hugepagesize>.reservation_max_usage_in_bytes # show max "hugepagesize" hugetlb reservations and no-reserve faults.
> + hugetlb.<hugepagesize>.reservation_usage_in_bytes     # show current reservations and no-reserve faults for "hugepagesize" hugetlb
> + hugetlb.<hugepagesize>.reservation_failcnt            # show the number of allocation failure due to HugeTLB reservation limit
> + hugetlb.<hugepagesize>.limit_in_bytes                 # set/show limit of "hugepagesize" hugetlb faults
> + hugetlb.<hugepagesize>.max_usage_in_bytes             # show max "hugepagesize" hugetlb  usage recorded
> + hugetlb.<hugepagesize>.usage_in_bytes                 # show current usage for "hugepagesize" hugetlb
> + hugetlb.<hugepagesize>.failcnt                        # show the number of allocation failure due to HugeTLB usage limit
> 

I assume these are better named hugetlb.<hugepagesize>.reservation.* 
rather than reservation_*, or perhaps shortened to resv.*, so for example 
hugetlb.<hugepagesize>.resv.limit_in_bytes.

>  For a system supporting three hugepage sizes (64k, 32M and 1G), the control
>  files include::
> @@ -40,11 +37,56 @@ files include::
>    hugetlb.1GB.max_usage_in_bytes
>    hugetlb.1GB.usage_in_bytes
>    hugetlb.1GB.failcnt
> +  hugetlb.1GB.reservation_limit_in_bytes
> +  hugetlb.1GB.reservation_max_usage_in_bytes
> +  hugetlb.1GB.reservation_usage_in_bytes
> +  hugetlb.1GB.reservation_failcnt
>    hugetlb.64KB.limit_in_bytes
>    hugetlb.64KB.max_usage_in_bytes
>    hugetlb.64KB.usage_in_bytes
>    hugetlb.64KB.failcnt
> +  hugetlb.64KB.reservation_limit_in_bytes
> +  hugetlb.64KB.reservation_max_usage_in_bytes
> +  hugetlb.64KB.reservation_usage_in_bytes
> +  hugetlb.64KB.reservation_failcnt
>    hugetlb.32MB.limit_in_bytes
>    hugetlb.32MB.max_usage_in_bytes
>    hugetlb.32MB.usage_in_bytes
>    hugetlb.32MB.failcnt
> +  hugetlb.32MB.reservation_limit_in_bytes
> +  hugetlb.32MB.reservation_max_usage_in_bytes
> +  hugetlb.32MB.reservation_usage_in_bytes
> +  hugetlb.32MB.reservation_failcnt
> +
> +
> +1. Reservation limits

Should probably be described after the page fault limits since those are 
the canonical limits that already exist and the "reservation_.*" 
equivalents are supplementary.

> +
> +The HugeTLB controller allows to limit the HugeTLB reservations per control
> +group and enforces the controller limit at reservation time and at the fault of
> +hugetlb memory for which no reservation exists. Reservation limits
> +are superior to Page fault limits (see section 2), since Reservation limits are
> +enforced at reservation time (on mmap or shget), and never causes the
> +application to get SIGBUS signal if the memory was reserved before hand. For
> +MAP_NORESERVE allocations, the reservation limit behaves the same as the fault
> +limit, enforcing memory usage at fault time and causing the application to
> +receive a SIGBUS if it's crossing its limit.
> +

When saying that reservation limits are superior to page fault limits, it 
might be helpful to expand on the downsides of page fault limits.  The 
existing documentation calls out that the application needs to know its 
expected usage; it does not call attention to the fact that several 
different applications may be accessing an overcommited system-wide pool 
of hugetlb memory.  So it might be possible that the application 
understands its own usage but it may not understand how that is 
orchestrated with other applications on the same system accessing a shared 
pool of hugetlb pages.

But yes, I think MAP_FAILED and allow for fallback or freeing of hugetlb 
memory is far superior to SIGBUS :)

> +2. Page fault limits
> +
> +The HugeTLB controller allows to limit the HugeTLB usage (page fault) per
> +control group and enforces the controller limit during page fault. Since HugeTLB
> +doesn't support page reclaim, enforcing the limit at page fault time implies
> +that, the application will get SIGBUS signal if it tries to access HugeTLB
> +pages beyond its limit. This requires the application to know beforehand how
> +much HugeTLB pages it would require for its use.
> +
> +
> +3. Caveats with shared memory
> +
> +For shared hugetlb memory, both hugetlb reservation and page faults are charged
> +to the first task that causes the memory to be reserved or faulted, and all
> +subsequent uses of this reserved or faulted memory is done without charging.
> +
> +Shared hugetlb memory is only uncharged when it is unreserved or deallocated.
> +This is usually when the hugetlbfs file is deleted, and not when the task that
> +caused the reservation or fault has exited.

Discussion of reparenting?
