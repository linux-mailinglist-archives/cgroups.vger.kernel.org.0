Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 079FF16015A
	for <lists+cgroups@lfdr.de>; Sun, 16 Feb 2020 02:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgBPB3K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 15 Feb 2020 20:29:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34234 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgBPB3J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 15 Feb 2020 20:29:09 -0500
Received: by mail-pg1-f193.google.com with SMTP id j4so7158709pgi.1
        for <cgroups@vger.kernel.org>; Sat, 15 Feb 2020 17:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vFO8RYQ8FlPE3NMfWDMQg3z8BnL2LFOQ1aCp2wNf0j0=;
        b=UT5y7eB27mtmBLa9qTJY5GoNQuboQGZtdwfzReReOwUaVVOzs3n/h9Ba5B4+RntXCc
         W1HLiL5YMb1prRJyisKY/4AyutIk6MxcInq+taUJe61ASvIaUoTX0W1yeVlJTkr2L0yy
         Z3GZggc+OUPDOdBhQ0DJ6Ykh4gvxbTjTWcMManFakBmoxbGTXMvJ4M3UFkEjFGElSKiK
         eN1DWddOuAh6EgdiDyjMRu2QKSwZyN8l5Lyk1v5HDOtCCBbEl0Zg2qdgq3RGqYmGsGq0
         tHcRjJPPPzpU9hR1e2942b2sR9rjzicAMAJmllqUTzPah+NVj/FQiWIRoWMnJmEdNM/l
         7h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vFO8RYQ8FlPE3NMfWDMQg3z8BnL2LFOQ1aCp2wNf0j0=;
        b=Vuz7MEK8c0z/pCTcro3ojM4IekM5WmCJfj4cHZPtAgGgMFNOtbBsC2JgiF4jKgWX77
         6CEdzay6+zxA3UZ/EzfpR5vxxAlB++UPRtGOi4FZ42I3Tj0Sq0GrMDvuLpkvoVzBsxI/
         Qq0MY5cFp5NXyuHMG1t18yQDrKXM5uviPh2DzuGpNDSpXcfeUidRpLpp5fW4HL3V1cmB
         pqFyCDxD7WSRZZsvLGSRsX6ptP5aHZEKyFhlzu2KhFcQnqr/bIIq4+KwdXRz4KPAdYkm
         YS2A08RP28KfSyOfvW5/DNT5CEbVvQSWpFxGKyDs/CWJwEBg2Wmj+4eKdeWr/jMTi+S8
         5RnQ==
X-Gm-Message-State: APjAAAVANfk81sPM1QhYMpH2vD/G2Gt1OEPusHrk3nq1YkW5ylioRT4y
        0pnAyX164TnZDo86fltrQs6NXQ==
X-Google-Smtp-Source: APXvYqwGtSe01CE+gnuMCStuNLDGVUiWBZr15rIhWthJ0+0xS/XrZRM8r+yOoO8qXDDTI8pRQqw/Sw==
X-Received: by 2002:a63:e4d:: with SMTP id 13mr10841291pgo.343.1581816547399;
        Sat, 15 Feb 2020 17:29:07 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b98sm11853084pjc.16.2020.02.15.17.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 17:29:06 -0800 (PST)
Date:   Sat, 15 Feb 2020 17:29:06 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mina Almasry <almasrymina@google.com>
cc:     mike.kravetz@oracle.com, shuah@kernel.org, shakeelb@google.com,
        gthelen@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v12 5/9] hugetlb_cgroup: add accounting for shared
 mappings
In-Reply-To: <20200211213128.73302-5-almasrymina@google.com>
Message-ID: <alpine.DEB.2.21.2002151728250.244463@chino.kir.corp.google.com>
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-5-almasrymina@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 11 Feb 2020, Mina Almasry wrote:

> For shared mappings, the pointer to the hugetlb_cgroup to uncharge lives
> in the resv_map entries, in file_region->reservation_counter.
> 
> After a call to region_chg, we charge the approprate hugetlb_cgroup, and if
> successful, we pass on the hugetlb_cgroup info to a follow up region_add call.
> When a file_region entry is added to the resv_map via region_add, we put the
> pointer to that cgroup in file_region->reservation_counter. If charging doesn't
> succeed, we report the error to the caller, so that the kernel fails the
> reservation.
> 
> On region_del, which is when the hugetlb memory is unreserved, we also uncharge
> the file_region->reservation_counter.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 

Does this develop a dependency on hugetlb_cgroup.h in hugetlb.h?  Or maybe 
we only need a forward declaration of struct file_region there?
