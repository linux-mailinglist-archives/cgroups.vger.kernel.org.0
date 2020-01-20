Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252D9142D9F
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2020 15:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgATOdk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Jan 2020 09:33:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37259 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATOdk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Jan 2020 09:33:40 -0500
Received: from [154.119.55.242] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1itY7T-0004eh-K1; Mon, 20 Jan 2020 14:33:38 +0000
Date:   Mon, 20 Jan 2020 15:33:30 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v4 3/6] cgroup: refactor fork helpers
Message-ID: <20200120143329.o7cmmemfqexk3x37@wittgenstein>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
 <20200117181219.14542-4-christian.brauner@ubuntu.com>
 <20200120140029.GB30403@redhat.com>
 <20200120140452.qyjogmmhyqc3gxon@wittgenstein>
 <20200120142202.GC30403@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200120142202.GC30403@redhat.com>
User-Agent: NeoMutt/20180716
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 20, 2020 at 03:22:03PM +0100, Oleg Nesterov wrote:
> On 01/20, Christian Brauner wrote:
> >
> > On Mon, Jan 20, 2020 at 03:00:30PM +0100, Oleg Nesterov wrote:
> > > This is probably the only patch in series I can understand ;)
> > >
> > > To me it looks like a good cleanup regardless, but
> > >
> > > On 01/17, Christian Brauner wrote:
> > > >
> > > > The patch just passes in the parent task_struct
> > >
> > > For what? "parent" is always "current", no?
> >
> > Yes. What exactly are you hinting at? :) Would you prefer that the
> > commit message speaks of "current" instead of "parent"?
> 
> I meant, I don't understand why did you add the new "parent" arg,
> cgroup_xxx_fork() can simply use "current" ?

There's no specific reason behind it. I don't care much whether it's an
arg or we just grab current in each helper directly.

Christian
