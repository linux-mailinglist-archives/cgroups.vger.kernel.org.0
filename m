Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB7D151967
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2020 12:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBDLNM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Feb 2020 06:13:12 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47994 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgBDLNM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Feb 2020 06:13:12 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iyw8i-0004qC-Ni; Tue, 04 Feb 2020 11:13:08 +0000
Date:   Tue, 4 Feb 2020 12:13:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v5 5/6] clone3: allow spawning processes into cgroups
Message-ID: <20200204111307.hxtundpcneju2y7n@wittgenstein>
References: <20200121154844.411-1-christian.brauner@ubuntu.com>
 <20200121154844.411-6-christian.brauner@ubuntu.com>
 <20200129132719.GD11384@blackbody.suse.cz>
 <20200202093702.cdlyytywty7hk3rn@wittgenstein>
 <20200203143228.GC13360@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200203143228.GC13360@blackbody.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 03, 2020 at 03:32:28PM +0100, Michal Koutný wrote:
> On Sun, Feb 02, 2020 at 10:37:02AM +0100, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> > cgroup_post_fork() is called past the point of no return for fork and
> > cgroup_css_set_put_fork() is explicitly documented as only being
> > callable before forks point of no return:
> I missed this and somehow incorrectly assumed it's called at the end of
> fork too. I find the css_set refcounting correct now.
> 
> BTW any reason why not to utilize cgroup_css_set_put_fork() for the
> regular cleanup in cgroup_post_fork() too?

Hmyeah, should be doable if we do:
kargs->cset = NULL;
cgroup_css_set_put_fork(kargs);

Christian
