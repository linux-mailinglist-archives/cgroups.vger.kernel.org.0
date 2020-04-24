Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCC21B6A4A
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 02:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgDXA33 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Apr 2020 20:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgDXA33 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Apr 2020 20:29:29 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FD4C09B042;
        Thu, 23 Apr 2020 17:29:28 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so3916740pfn.5;
        Thu, 23 Apr 2020 17:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzkio/hjOsP5SuHUSxUmuTr2KttZIZznccGmIe5MGTE=;
        b=LjfGxbjdlWzcFZwfvVVJkPC+E9ey1960eHifxNarjq22YJ0k9l9Vo0xL7T6TmlIZwt
         lC9m3uWPZO/jNOocdrGsnyEZ3uGvSwmZdIr1Rc76z1PdMi58UMJPinl6nfCQCs4no8L2
         9b+SMjJ8KNMJT3eoTlODXq8TSx7hxhT+XjGRVsZ6KpxCF2oFP8sB5orojvn9YHbH9OVi
         3OOvvVEPzZqoFbUV8qSzg5ro/Xraq56018GGKNT8nqCxLUPt7lMAzjBhG2AxTSwvqRrF
         NLO4/Hc8WBnhRzoSrvIXszHmog/8eLSmGgtz2PT9m/FY2YKfIS45xYux9tul5Mn2l+p9
         PTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzkio/hjOsP5SuHUSxUmuTr2KttZIZznccGmIe5MGTE=;
        b=mkvifKpD27U9/OhfQsvPeeLVXamlc2zgb4AaMY6B+2kOPTgvb3YTHtMg/fo3ab+YcC
         bBQAcCJ30WCVWV0Fia/Tkzwl/bS3iM3r6xrFXKSH6AtBnRDThMKgOxSSgq9HMEdIKSsW
         CD9sayGmhs6PgFXCgJ6nPFSNgaHO/5NFkfSnYRxFJ863OeTtE6NL82MJ53vX8VztSyU7
         rCjfIibTD10XcyTHwWcLbvuy9Se3lC4FHBJK9BcLKovRoKiBGPzzGNjweNKyT3HJT0fN
         bJr0PIxoJ5wzbuGq04koXfSG6MX4Ej2KSteekkvxK1xzkIDvnTMDewCfeeVZw+d2NKOx
         nFjA==
X-Gm-Message-State: AGi0PuYth2mx0zQsIphGAK8pHLPcv5LzkCh5/GTy3HooE6z7cZNtxv26
        GKILDdHf7oWfiyIs81AAoTI=
X-Google-Smtp-Source: APiQypIdvE5K2aEAaHQ1wU8OjQkB5YjvHrVsl/RDA61isWhV8Y7LNYB7z3/tLahjSPD3g5DE4aaFyg==
X-Received: by 2002:a63:460a:: with SMTP id t10mr6572072pga.105.1587688168381;
        Thu, 23 Apr 2020 17:29:28 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id u8sm3356495pjy.16.2020.04.23.17.29.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 17:29:27 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:29:21 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 11/18] mm: memcontrol: switch to native NR_ANON_THPS
 counter
Message-ID: <20200424002910.GA13929@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-12-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-12-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:19PM -0400, Johannes Weiner wrote:
> With rmap memcg locking already in place for NR_ANON_MAPPED, it's just
> a small step to remove the MEMCG_RSS_HUGE wart and switch memcg to the
> native NR_ANON_THPS accounting sites.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

