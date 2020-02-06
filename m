Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7EE1154808
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2020 16:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBFP1I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Feb 2020 10:27:08 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46548 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBFP1H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Feb 2020 10:27:07 -0500
Received: by mail-qk1-f196.google.com with SMTP id g195so5844678qke.13
        for <cgroups@vger.kernel.org>; Thu, 06 Feb 2020 07:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XZOggLanx1OakxhbvmLypkwLB6o7BwYbW0LP99Ryt1o=;
        b=yqZ/FZfL7rzCP/2Jqs5bBr0b3LqQr+WLoYGIPyBGKw6323lJiZKUFKys6E+VHeTJf2
         Q6Piw50B5YbifhP9CblDm+U1GrvZEKZfGAIM/WgHxJp8L+nPX03q6D8VELhZ9R6NOLtJ
         0N0BATZjWI1IczjjfHIveuTCnUgMe+YptD0IpellozuQtXZMs1KXJDOQoRD808ussEVS
         Oeq1YPf/gA/4zQLcWiJBTPhyXQkV4fdKw2VzJoUCEkl+iDXax7CtlZ/cnhsc9SesEK6s
         rSpSpV2Ot3fvi+Ga5GgVIr1vsjh5V4Ifnz9qtatPI8rzuX97IK5IffeOowrdFDe+hNk2
         Ak9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZOggLanx1OakxhbvmLypkwLB6o7BwYbW0LP99Ryt1o=;
        b=Fan6Qv2QgPeoJNTnkYsECX2kj28DDisyKUALgEmC/2ZmSGpqNNmBhgx41etJ1qMsOr
         +swk9vVEYdALdyPylhA4VCOZ1F2cO8jIngLY83oYJglpKCcyLk6Ral/O6uB3d+w5jCGy
         AsL2RYBC3SyuGucdbgD1SRm79IcO973zRLafsWlstNNdUgN4+ladRUt7B4g7WKlE61Ry
         pOQ81yDJ03mb5RRIxpHgLNJEaM9eUY1x2a66hwGAQg3uYVrjnmoyOmAHP7DMu6J0JMUQ
         5PV3xzWPyiUiF1onH61ZWSazkNQDaxScCjsZcVQs1EyCuG4akOfMHJFSnU6x8BLCoXtN
         /q9A==
X-Gm-Message-State: APjAAAX63lFZu+kOEz3FAPJmsqcvO2Ccv5jkbE8zqgBb9AqKFjk6Cr1U
        HvzcWDJhkyqWIn858qSY1EDz/A==
X-Google-Smtp-Source: APXvYqwoCWoPoxMsBmJ48AbMG+4iF96O7gepmNsPc8GfJXUuFMj8rT6ge/PsiVIYjdA9hTy/JKrEoQ==
X-Received: by 2002:a05:620a:7f4:: with SMTP id k20mr2931953qkk.483.1581002826313;
        Thu, 06 Feb 2020 07:27:06 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id b24sm1741820qto.71.2020.02.06.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:27:05 -0800 (PST)
Date:   Thu, 6 Feb 2020 10:27:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] mm: Charge current memcg when no mm is set
Message-ID: <20200206152704.GA24735@cmpxchg.org>
References: <20200205223348.880610-1-dschatzberg@fb.com>
 <20200205223348.880610-2-dschatzberg@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223348.880610-2-dschatzberg@fb.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 05, 2020 at 02:33:47PM -0800, Dan Schatzberg wrote:
> This modifies the shmem and mm charge logic so that now if there is no
> mm set (as in the case of tmpfs backed loop device), we charge the
> current memcg, if set.
> 
> Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

It's a dependency for 2/2, but it's also an overdue cleanup IMO: it's
always been a bit weird that memalloc_use_memcg() worked for kernel
allocations but was silently ignored for user pages.

This patch establishes a precedence order for who gets charged:

1. If there is a memcg associated with the page already, that memcg is
   charged. This happens during swapin.

2. If an explicit mm is passed, mm->memcg is charged. This happens
   during page faults, which can be triggered in remote VMs (eg gup).

3. Otherwise consult the current process context. If it has configured
   a current->active_memcg, use that. Otherwise, current->mm->memcg.

Thanks Dan
