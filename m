Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1FC190FE2
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 14:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgCXNXy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 09:23:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40096 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgCXNXx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 09:23:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id a81so3349623wmf.5
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2020 06:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=16WGU3cNB1gezVOdWiJDOY/jwLM7wxW+VZ4bxA/PHPk=;
        b=bWlSVSaAkOrITpOQwvrWt1U9KbT9mbpxsTyfS70Bdu05BJ1bpQu2yaT81q91QdmG8m
         b2iC6Eyj1qy/xakWe9eSTS+HImwFRVl0AESSqhQrw9NqXo0VwH0qp2T3zTae9TqhsZf/
         n/Lgm424ZcP3W7ZZ2bRqCxOKpCo5Nk/adFez4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=16WGU3cNB1gezVOdWiJDOY/jwLM7wxW+VZ4bxA/PHPk=;
        b=hp1HbH+WBNEQcJd6ZR5TKXurRpt0LnJtirDoR2XAnvnri5Eqlf/vCu5QBH+8LmARGJ
         pnS8qZXpPy/aj/UiLXWPdfDLBAov3g+dMt/g3LnQydLqmed3ckI+vlAO8oPYYLYNfBDX
         vOGFAFVbNhDihCQIhbQMx3EzFkAgnxv4PymcgoqLE6G5ZmOf9+1MuKAgBxL68zZI5J8S
         0S3joiIIoUBqrpYd8hYtvCEa/5Kghu+0vmk0o9u5RXYZEZzLYau5Hr8fcD65rR9OidtC
         8jzXg4USAPAmju6kuO0K/lnpC0XehbzmTu3HkTicK+MV2a5KLB0jDk7rqwF7OgtyHrps
         RkFw==
X-Gm-Message-State: ANhLgQ3SV6wwfjNuhHftqW6fLUVnVR6aVFAQBMIGV6raLCQORnavA/de
        IajMczQm5IVkmd4SQF/hDKlCLg==
X-Google-Smtp-Source: ADFU+vsRXGhBNDWactdLbIMseJKjnvylYAlIoBTm5ZCXj70sl98tC5w95ZPI7DAjbM3/oddQVqqJtA==
X-Received: by 2002:a05:600c:280b:: with SMTP id m11mr5309390wmb.99.1585056231630;
        Tue, 24 Mar 2020 06:23:51 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:8734])
        by smtp.gmail.com with ESMTPSA id w7sm29792149wrr.60.2020.03.24.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:23:51 -0700 (PDT)
Date:   Tue, 24 Mar 2020 13:23:50 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Hui Zhu <teawater@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hughd@google.com,
        yang.shi@linux.alibaba.com, kirill@shutemov.name,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        sean.j.christopherson@intel.com, thellstrom@vmware.com,
        guro@fb.com, shakeelb@google.com, tj@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
Message-ID: <20200324132350.GA7528@chrisdown.name>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1585045916-27339-1-git-send-email-teawater@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hui Zhu writes:
>/sys/kernel/mm/transparent_hugepage/enabled is the only interface to
>control if the application can use THP in system level.
>Sometime, we would not want an application use THP even if
>transparent_hugepage/enabled is set to "always" or "madvise" because
>thp may need more cpu and memory resources in some cases.
>
>This commit add a new interface memory.transparent_hugepage_disabled
>in memcg.
>When it set to 1, the application inside the cgroup cannot use THP
>except dax.

I'm against this patch even in the abstract -- this adds an extremely niche use 
case to a general interface, and there are plenty of ways to already indicate 
THP preference.

Perhaps there is some new interface desirable for your use case, but adding a 
new global file to memcg certainly isn't it.
