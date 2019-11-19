Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4B5102927
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 17:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfKSQUB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 11:20:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42960 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSQUB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 11:20:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id i3so6336659qkk.9
        for <cgroups@vger.kernel.org>; Tue, 19 Nov 2019 08:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P9Nm0dmtDONqzZOiG8f0kC+bAXI7b+Ydc24QnuYX/wc=;
        b=z9ODofZLwVJ5kMknpHKRESiJDZBNi3Pyza7Lc9GUeJNHofrQ86wibU3eFnsO2CVIu+
         IfAgM62vq+764hz0qZ7RurgWgkiidhrvNyqW6ve6XTcrt1pa0T+IBaQFh6GvVNqcIXBF
         Ufy2rTPODX34yXNizSAi3WtQarGWeLPCoeXXJKP8I0Cb0CRRWpEy9NOqkoaP9VmwY9h1
         cD8j9AgPTXAvnN73paddQAX1/NUY7TjJhO4MrEwcGMLbJNfqlaFEN76hxgxI1sUPxUoF
         rpTdJBr0sBkYiM5s7RkzXWL86X/Ms+STXj4E4DantEgdps6LghwvRYO6bCdspBkQ3lot
         zPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P9Nm0dmtDONqzZOiG8f0kC+bAXI7b+Ydc24QnuYX/wc=;
        b=Tfx/F8aPbSMRSxl03hAmIr+R3gtb655hLsUDUtneUpXZk8tjH1Ui6I8dB+9jW+SroB
         Vb7ILN0girWgj+oorVw4lJjnMC8FxH7Br0x3axiUFxsvr8lW5Rsaygpgbdh/mCDBao+M
         AK3VXi95vVjPSolMdqho5qt4J7adYaIGP+tdB3fPfK1MsIsgAGCJ5QakkMxusYbp/0Q7
         zIjWRl7RkvrJitbw51Nhthyqe9xEfg85jy1BdY5SmTWCgCeR2micipmgRVjQX6DWkgcJ
         LDbmSGTUsh84NnXSexI1r+xtXoKqbRO+xBenIM2pS7mbAK/u8vJbegjOkA1B7elF5iV3
         6nLA==
X-Gm-Message-State: APjAAAXCrKboMy5vOkgRtIDGvvqtNyY9P6qm7ePCbAuJDo0Uz0DWS6Pv
        sTMkid0iJl47DpTSKQ4DBYryQA==
X-Google-Smtp-Source: APXvYqwl+S9iMasVSXI1muFO2L+Fzgo4inTTJLcO5OXE6vDvUnuWsZ5UkRMSK4/30PNMVIetjQqjxw==
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr29793788qkm.393.1574180400357;
        Tue, 19 Nov 2019 08:20:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::c7ac])
        by smtp.gmail.com with ESMTPSA id a7sm10253897qka.136.2019.11.19.08.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 08:19:59 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:19:58 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ira Weiny <ira.weiny@intel.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Arun KS <arunks@codeaurora.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v4 9/9] mm/lru: revise the comments of lru_lock
Message-ID: <20191119161958.GE382712@cmpxchg.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-10-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574166203-151975-10-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 19, 2019 at 08:23:23PM +0800, Alex Shi wrote:
> Since we changed the pgdat->lru_lock to lruvec->lru_lock, it's time to
> fix the incorrect comments in code. Also fixed some zone->lru_lock comment
> error from ancient time. etc.
> 
> Originally-from: Hugh Dickins <hughd@google.com>

You can resubmit a patch written by somebody else, but you need to
preserve authorship such that git can attribute it properly:

	From: Hugh Dickins <hughd@google.com>

in the patch header, as well as

	Signed-off-by: Hugh Dickins <hughd@google.com>

in the changelog tags. It should look something like this:

---
From: Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/memcg: update lru_lock Doc and comments

Update scattered references from "zone_lru_lock" to "lruvec->lru_lock"
(in low-level descriptions) or "lruvec lock" (where that reads better).

In the course of doing so, update lock ordering comments in mm/rmap.c
and mm/filemap.c and Documentation/cgroups/memory.txt - slightly, with
no attempt to be complete (swap_lock, in particular, left out-of-date).
Remove allusions to set_page_dirty under page_remove_rmap: gone in v3.9.

memcg_test.txt looks quite out-of-date: just give LRU a short paragraph.
Replaced zone by node throughout unevictable-lru.txt (except for stats).
Leave Documentation/locking/lockstat.txt untouched this time: it doesn't
matter if that still refers to zone->lru_lock, along with other history.

I struggled to understand the comment above move_pages_to_lru() (surely
it never calls page_referenced()), and eventually realized that most of
it had got separated from shrink_active_list(): move that comment back.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
---
