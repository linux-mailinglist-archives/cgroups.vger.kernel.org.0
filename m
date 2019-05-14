Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC751CC5F
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2019 18:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfENQCE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 May 2019 12:02:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfENQCE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 14 May 2019 12:02:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7082A811D5;
        Tue, 14 May 2019 16:02:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2454419C5A;
        Tue, 14 May 2019 16:02:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 14 May 2019 18:02:02 +0200 (CEST)
Date:   Tue, 14 May 2019 18:01:59 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Tejun Heo <tj@kernel.org>, Alex Xu <alex_y_xu@yahoo.ca>,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signal: don't always leave task frozen after
 ptrace_stop()
Message-ID: <20190514160158.GB32459@redhat.com>
References: <20190513195517.2289671-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513195517.2289671-1-guro@fb.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 14 May 2019 16:02:04 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Roman,

Sorry, I can't agree with this patch. And even the changelog doesn't
look right.

On 05/13, Roman Gushchin wrote:
>
> The ptrace_stop() function contains the cgroup_enter_frozen() call,
> but no cgroup_leave_frozen(). When ptrace_stop() is called from the
> do_jobctl_trap() path, it's correct, because corresponding
> cgroup_leave_frozen() calls in get_signal() will guarantee that
> the task won't leave the signal handler loop frozen.
>
> However, if ptrace_stop() is called from ptrace_signal() or
> ptrace_notify(), there is no such guarantee, and the task may leave
> with the frozen bit set.

ptrace_signal() looks fine in that the task can't return to user-mode,
get_signal() will be called again exactly because ->frozen == 1 means
TIF_SIGPENDING. So I an not surre I understand why ptrace_signal() does
ptrace_stop(false) with your patch. But this is minor.

> It leads to the regression, reported by Alex Xu. Write system call
> gets mistakenly interrupted by fake TIF_SIGPENDING, which is set
> by recalc_sigpending_tsk() because of the set frozen bit.

IMHO, the real problem is not that syscall was interrupted. The problem
is that a frozen task must never start the syscall.


---------------------------------------------------------------------------

Can't we add the unconditional leave_frozen() into ptrace_stop() for now ?

Sure, this is not what we want. Debugger can disturb CGRP_FROZEN.

But. The "may_remain_frozen" argument uglifies this code too much (imo) and
at the same time it doesn't solve the problem above: CGRP_FROZEN can be cleared
"for no reason".

Say, why ptrace_event_pid() should do leave_frozen(true) ? And if there is any
reason, then why wait_for_vfork_done() can do leave_frozen(false) ?

Or syscall-exit path. It can't miss get_signal(), it doesn't need leave_frozen().


In short, I believe that compared to the unconditional leave_frozen() in ptrace_stop()
this patch buys almost nothing, but makes the code and the whole logic much uglier.

Oleg.

