Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F571FCE82
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2020 15:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFQNfK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Jun 2020 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgFQNfK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Jun 2020 09:35:10 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0314C06174E
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 06:35:09 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q2so2008291qkb.2
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2020 06:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bI+LSwU3WmKQTw3s6Ynrm9kunWR6ux85bO94Rtl9UB8=;
        b=Hy1d/ERyRuOB+PHm+LELxp1o2YdldrppiRVKFZyx/RbXD3vjo9A0QBXm5PWd4kJKNe
         IpTqynvSN806MhwnVN8BDl15WWL5qjhtvYjVRcWHgUeRBKvUC/PdE1RBP/rcqSrba/fl
         gZP/7f3fWYzrqWgetaSNhIiuvxiMDLIRcfQdRga5mURGu115WWvvQ7yf5tu5CNqKKKod
         U9T2O66BCAeZX+b0MvOCrHEgUPMUuIEuuYHJ5tO/uUP4ZAE8NvbQVjnsCiwIAxlDoU/0
         atGiASzPLZ5wAKzHteiMjnyfArxhvqfXuueHlzWvnDsGFMgUpREHhBa0ohJAE1eRnFDR
         mAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bI+LSwU3WmKQTw3s6Ynrm9kunWR6ux85bO94Rtl9UB8=;
        b=C+zlKaLx11WdoLKaahGzEXNmUD7KXPkLc3gfZHR1ue4NRHaFmomkfn6FFEown6bz/H
         2AfPqyTVO+F/bKD3Di73VqFHlZytNrfgu5eneuc+gzas18hPXVe12JkNzFU+fHGef/vs
         ngEbpJcJZvvdg8BYztWe7ehRBKRQ4iIEArOjH2H6s2AFzeto2bnYbH7ZMyZ36temsnNp
         Lg3UvmFYndHQ4uJmqT2BYgKzWachTE/su9d4LpNkpogBXPG283uvG0c/qUDy0iyjXDcT
         b4bMYbVfDkE9yd+2pP5OzuClB7XwnQ+H6dCWRTd0cqz7cwkx9K3ug5lJtyVzFFAIvjaD
         1ytw==
X-Gm-Message-State: AOAM532iyOOD9D6nYtTjSJcgRtqokUY2osySs+MBhO5Z09nzfjQJJX7H
        r19oMpZxe7+ckuKGgqSBEzIF+g==
X-Google-Smtp-Source: ABdhPJyT1KFLnbxsbl7Fl39ylT63qRNdMhgI3eNkeaXzfkVKKdRpwxWQaQtewJRUQT7fLpptdev19Q==
X-Received: by 2002:ae9:c10d:: with SMTP id z13mr24307857qki.3.1592400908949;
        Wed, 17 Jun 2020 06:35:08 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c201sm17429402qkg.57.2020.06.17.06.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 06:35:07 -0700 (PDT)
Date:   Wed, 17 Jun 2020 09:34:30 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH for 5.8] mm: do_swap_page fix up the error code
 instantiation
Message-ID: <20200617133430.GD616830@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
 <20200508183105.225460-17-hannes@cmpxchg.org>
 <20200611093523.GB20450@dhcp22.suse.cz>
 <20200617084927.GK9499@dhcp22.suse.cz>
 <20200617090238.GL9499@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617090238.GL9499@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 17, 2020 at 11:02:38AM +0200, Michal Hocko wrote:
> Damn, I forgot to commit my last change (s@err@ret@). Sorry about the
> noise.
> 
> From 50297dd026ebf71fe901e1945a9ce1e8d8aa083b Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Wed, 17 Jun 2020 10:40:47 +0200
> Subject: [PATCH] mm: do_swap_page fix up the error code
> 
> do_swap_page returns error codes from the VM_FAULT* space. try_charge
> might return -ENOMEM, though, and then do_swap_page simply returns 0
> which means a success.
> 
> We almost never return ENOMEM for GFP_KERNEL single page charge. Except
> for async OOM handling (oom_disabled v1). So this needs translation to
> VM_FAULT_OOM otherwise the the page fault path will not notify the
> userspace and wait for an action.
> 
> Fixes: 4c6355b25e8b ("mm: memcontrol: charge swapin pages on instantiation")
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Good catch, thanks Michal.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
