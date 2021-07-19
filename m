Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AAD3CD5AB
	for <lists+cgroups@lfdr.de>; Mon, 19 Jul 2021 15:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbhGSMqM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jul 2021 08:46:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237832AbhGSMqL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 19 Jul 2021 08:46:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A45560E0B;
        Mon, 19 Jul 2021 13:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626701211;
        bh=MdzRIJoouHXqMOtbajXpawm8OypsDYkx33XVamI0/hY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhklKodmBO5Zh8hsh6Lm1OaJsNSNkS9pBiy60DLODIQOI0q/pKqa+olpvQtujVc9R
         Zisa2vB6p7u3SrK/W1aES6nSLhsDIIHJ8m/4JeuwuoIC7YXQiA+5BnT/xFelSNKVy5
         91i6vjeRsLb4RkmlZomo5yI8EMh96/kFC0xVNT0tkGJXERpPjLw3jd3gRGI4cA/YQi
         vvBR0gHAPOOwZ3vMEqAkX8p5gnRlOGsiVavlElvhuQZ1Cu/TIsNDNqZjhAs+WvpKId
         Agb08UgkwGzV/XozIs8eCAWIrZhFkS28+N+CFELamobphtSNMOTaVXa/3g9M20vsir
         7p7U6y2qyUWyw==
Date:   Mon, 19 Jul 2021 15:26:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] cpuset: Add cpuset.isolation_mask file
Message-ID: <20210719132649.GB116346@lothringen>
References: <20210714135420.69624-1-frederic@kernel.org>
 <20210714135420.69624-7-frederic@kernel.org>
 <20210714163157.GA140679@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714163157.GA140679@fuller.cnet>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 14, 2021 at 01:31:57PM -0300, Marcelo Tosatti wrote:
> On Wed, Jul 14, 2021 at 03:54:20PM +0200, Frederic Weisbecker wrote:
> > Add a new cpuset.isolation_mask file in order to be able to modify the
> > housekeeping cpumask for each individual isolation feature on runtime.
> > In the future this will include nohz_full, unbound timers,
> > unbound workqueues, unbound kthreads, managed irqs, etc...
> > 
> > Start with supporting domain exclusion and CPUs passed through
> > "isolcpus=".
> 
> It is possible to just add return -ENOTSUPPORTED for the features 
> whose support is not present?

Maybe, although that looks like a specialized error for corner cases.

> > 
> > CHECKME: Should we have individual cpuset.isolation.$feature files for
> >          each isolation feature instead of a single mask file?
> 
> Yes, guess that is useful, for example due to the -ENOTSUPPORTED
> comment above.
> 
> 
> Guarantees on updates
> =====================
> 
> Perhaps start with a document with:
> 
> On return to the write to the cpumask file, what are the guarantees?
> 
> For example, for kthread it is that any kernel threads from that point
> on should start with the new mask. Therefore userspace should 
> respect the order:
> 
> 1) Change kthread mask.
> 2) Move threads.
> 

Yep.

> Updates to interface
> ====================
> 
> Also, thinking about updates to the interface (which today are one
> cpumask per isolation feature) might be useful. What can happen:
> 
> 1) New isolation feature is added, feature name added to the interface.
> 
> Userspace must support new filename. If not there, then thats an 
> old kernel without support for it.
> 
> 2) If an isolation feature is removed, a file will be gone. What should
> be the behaviour there? Remove the file? (userspace should probably 
> ignore the failure in that case?) (then features names should not be
> reused, as that can confuse #1 above).

Heh, yeah that's complicated. I guess we should use one flag per file as that
fits well within the current cpuset design. But we must carefully choose the new
files to make sure they have the least chances to be useless in the long term.

> Or maybe have a versioned scheme?

I suspect we should avoid that at all costs :-)

Thanks!
