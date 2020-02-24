Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED016B2BF
	for <lists+cgroups@lfdr.de>; Mon, 24 Feb 2020 22:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBXVhy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Feb 2020 16:37:54 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37254 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVhy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Feb 2020 16:37:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id w47so7630020qtk.4;
        Mon, 24 Feb 2020 13:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/oLy8oVuts+NDR86rWT12f1DfuTi/T+KFkIcevjcIVk=;
        b=G/dqJBKUaChhHiklV5Lw+49KVuJF9AbPOpkfS+2n6Qk8wkhPUVDGGMJD5uvSfRAwOx
         xzJfG8b8FMlMdMb4KndOLEFwTqa8kpbf1gnvD3wJ7DmQ3+a0myrZMyoZ7gQm/CiO1t8Y
         AQ2niiTydeDa2Tm4yZZQAzuwao4ut8S7wQoFQU7h30tlwtv05ivIKuBQl9CAbTmUQykG
         vhhobIrRrVhM0SrntztkE7e08WvFc+q24oNp6mNiqulz617fl7f3YoSmNWXPrsOexSXk
         /3UsPWtixv84JHg6mkf5BwIRJHok/gkKO/3aAOD4Hc4Tpta4BGbVr3rVA37at/r8be18
         XmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/oLy8oVuts+NDR86rWT12f1DfuTi/T+KFkIcevjcIVk=;
        b=n+6QsJu2ObyNHEveuhnu+qYroaJy0gAsJTXbcQsYvc9dVStvuojn0mPEGi1dgX2OoZ
         /7S9zDtKdYrMAE1QGffFdzgWTEQPqGvhgQaqI/9sabhFQ/VeCF9Ryf4IAp3cd4i/4j4c
         cVw4jdWwRfUwe1BH/IVBfzZK4639Vdmx0ZxztSDEcoEnEDpjgQHzFLjL81/ywHhrmvCK
         6Sw595eXAgAvvLdes0FKvMpuZFnhIgdszjNjHqhDRLVUOoqD6+RW65sYZ3niVktzZmoh
         wOyMeg6n/Io/V26hBbE3TUojHB12qduptw3MW6LTx37qw6/QTr0fGA/OcTaktSkdGdZC
         CqyA==
X-Gm-Message-State: APjAAAUuxBOFYrrwCsWdtRvVTUzMdFYvLbB6K/Fe3kA9bgmOcQrwewDD
        cKiYcMuuf3vSTVPYfyJ4TTM=
X-Google-Smtp-Source: APXvYqw6QDKZMmbPqHOGHQZTwBxnfivEGgL5joDo4YpHdeSL71y1/54B9Y6S4a4M109nogftkRXbJg==
X-Received: by 2002:ac8:5419:: with SMTP id b25mr51215597qtq.390.1582580273055;
        Mon, 24 Feb 2020 13:37:53 -0800 (PST)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:500::2:b19b])
        by smtp.gmail.com with ESMTPSA id c10sm6404718qkb.4.2020.02.24.13.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:37:52 -0800 (PST)
Date:   Mon, 24 Feb 2020 16:37:50 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 2/3] mm: Charge active memcg when no mm is set
Message-ID: <20200224213750.GA3773@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <cover.1582216294.git.schatzberg.dan@gmail.com>
 <0a27b6fcbd1f7af104d7f4cf0adc6a31e0e7dd19.1582216294.git.schatzberg.dan@gmail.com>
 <alpine.LSU.2.11.2002231058520.5735@eggly.anvils>
 <alpine.LSU.2.11.2002231710420.7354@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2002231710420.7354@eggly.anvils>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Feb 23, 2020 at 05:11:12PM -0800, Hugh Dickins wrote:
> On Sun, 23 Feb 2020, Hugh Dickins wrote:
> > On Thu, 20 Feb 2020, Dan Schatzberg wrote:
> > 
> > > memalloc_use_memcg() worked for kernel allocations but was silently
> > > ignored for user pages.
> > > 
> > > This patch establishes a precedence order for who gets charged:
> > > 
> > > 1. If there is a memcg associated with the page already, that memcg is
> > >    charged. This happens during swapin.
> > > 
> > > 2. If an explicit mm is passed, mm->memcg is charged. This happens
> > >    during page faults, which can be triggered in remote VMs (eg gup).
> > > 
> > > 3. Otherwise consult the current process context. If it has configured
> > >    a current->active_memcg, use that. Otherwise, current->mm->memcg.
> > > 
> > > Previously, if a NULL mm was passed to mem_cgroup_try_charge (case 3) it
> > > would always charge the root cgroup. Now it looks up the current
> > > active_memcg first (falling back to charging the root cgroup if not
> > > set).
> > > 
> > > Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Acked-by: Tejun Heo <tj@kernel.org>
> > 
> > Acked-by: Hugh Dickins <hughd@google.com>
> > 
> > Yes, internally we have some further not-yet-upstreamed complications
> > here (mainly, the "memcg=" mount option for all charges on a tmpfs to
> > be charged to that memcg); but what you're doing here does not obstruct
> > adding that later, they fit in well with the hierarchy that you (and
> > Johannes) mapped out above, and it's really an improvement for shmem
> > not to be referring to current there - thanks.
> 
> I acked slightly too soon. There are two other uses of "try_charge" in
> mm/shmem.c: we can be confident that the userfaultfd one knows what mm
> it's dealing with, but the shmem_swapin_page() instance has a similar
> use of current->mm, that you also want to adjust to NULL, don't you?
> 
> Hugh

Yes, you're right. I'll change shmem_swapin_page as well
