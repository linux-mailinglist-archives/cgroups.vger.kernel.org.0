Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68594E4C59
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 15:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504780AbfJYNeY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Oct 2019 09:34:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45676 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfJYNeY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Oct 2019 09:34:24 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iNzj6-0004Db-9r; Fri, 25 Oct 2019 13:34:00 +0000
Date:   Fri, 25 Oct 2019 15:33:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>, dvyukov@google.com
Cc:     Oleg Nesterov <oleg@redhat.com>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, arnd@arndb.de, deepa.kernel@gmail.com,
        ebiederm@xmission.com, elver@google.com, guro@fb.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        cgroups@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191025133358.pxpzxkhqc3mboi5x@wittgenstein>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
 <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

[+Dmitry]

On Fri, Oct 25, 2019 at 05:56:06AM -0700, Tejun Heo wrote:
> On Thu, Oct 24, 2019 at 12:03:51PM -0700, Tejun Heo wrote:
> > cgroup_enable_task_cg_lists() is used to lazyily initialize task
> > cgroup associations on the first use to reduce fork / exit overheads
> > on systems which don't use cgroup.  Unfortunately, locking around it
> > has never been actually correct and its value is dubious given how the
> > vast majority of systems use cgroup right away from boot.
> > 
> > This patch removes the optimization.  For now, replace the cg_list
> > based branches with WARN_ON_ONCE()'s to be on the safe side.  We can
> > simplify the logic further in the future.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reported-by: Oleg Nesterov <oleg@redhat.com>
> 
> Applying to cgroup/for-5.5.

The code you removed was the only place where task->flags was set from
!current. So I think this fixes the syzbot data-race report in:
https://lore.kernel.org/r/0000000000003b1e8005956939f1@google.com

Link: syzbot+492a4acccd8fc75ddfd0@syzkaller.appspotmail.com

Thanks!
Christian
