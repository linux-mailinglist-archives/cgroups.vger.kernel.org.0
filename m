Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F51A609D
	for <lists+cgroups@lfdr.de>; Sun, 12 Apr 2020 23:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgDLVK5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Apr 2020 17:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgDLVK5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 12 Apr 2020 17:10:57 -0400
Received: from youngberry.canonical.com (youngberry.canonical.com [91.189.89.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932FFC0A3BF5;
        Sun, 12 Apr 2020 14:10:57 -0700 (PDT)
Received: from ip5f5bd698.dynamic.kabel-deutschland.de ([95.91.214.152] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jNjsU-0005Yo-KY; Sun, 12 Apr 2020 21:10:54 +0000
Date:   Sun, 12 Apr 2020 23:10:53 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Tejun Heo <tj@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] clone3: fix cgroup argument sanity check
Message-ID: <20200412211053.fs54wfguvttav7j6@wittgenstein>
References: <20200412202533.GA29554@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200412202533.GA29554@asgard.redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 12, 2020 at 10:25:33PM +0200, Eugene Syromiatnikov wrote:
> Checking that cgroup field value of struct clone_args is less than 0
> is useless, as it is defined as unsigned 64-bit integer.  Moreover,
> it doesn't catch the situations where its higher bits are lost during
> the assignment to the cgroup field of the cgroup field of the internal
> struct kernel_clone_args (where it is declared as signed 32-bit
> integer), so it is still possible to pass garbage there.  A check
> against INT_MAX solves both these issues.
> 
> Fixes: ef2c41cf38a7559b ("clone3: allow spawning processes into cgroups")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>

Thanks, will queue for rc2 unless I hear objections.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
