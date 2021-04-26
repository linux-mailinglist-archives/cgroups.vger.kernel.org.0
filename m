Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896EF36B589
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 17:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhDZPQC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 11:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233919AbhDZPQC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 26 Apr 2021 11:16:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EABC06127A;
        Mon, 26 Apr 2021 15:15:17 +0000 (UTC)
Date:   Mon, 26 Apr 2021 17:15:14 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
Message-ID: <20210426151514.od5d7bru7fyu24qs@wittgenstein>
References: <20210423171351.3614430-1-brauner@kernel.org>
 <YIMZkjzNFypjZao9@carbon.dhcp.thefacebook.com>
 <YIbRP5/w1ZD804DL@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIbRP5/w1ZD804DL@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 26, 2021 at 04:42:07PM +0200, Michal Koutný wrote:
> Hello.

(Tiny favor, can you please leave a newline before your inline replies.
Would make it easier to follow.)

> 
> On Fri, Apr 23, 2021 at 12:01:38PM -0700, Roman Gushchin <guro@fb.com> wrote:
> > Overall it sounds very reasonable and makes total sense to me.
> I agree this sounds like very desired convenience...
> 
> > Many userspace applications can use the new interface instead of
> > reading cgroup.procs in a cycle and killing all processes or using the
> > freezer and kill a frozen list of tasks.
> ...however, exactly because of this, I'm not convinced it's justifying
> yet another way how to do it and implement that in kernel. (AFAIU, both
> those ways should be reliable too (assuming reading cgroup.procs of the
> _default_ hierarchy), please correct me if I'm wrong.)
> 
> > It will simplify the code and make it more reliable.
> It's not cost free though, part of the complexity is moved to the
> kernel.
> As Roman already pointed earlier, there are is unclear situation wrt
> forking tasks. The similar had to be solved for the freezer hence why
> not let uspace rely on that already? Having similar codepaths for
> signalling the cgroups seems like a way to have two similar codepaths
> side by side where one of them serves just to simplify uspace tools.

The established way of doing things in userspace stems from cgroup v1
where the concept of "kill this cgroup and all its descendants didn't
really make sense in the face of multiple hierarchies. This is in pretty
stark contrast to cgroup v2 where that concept first does make a lot of
sense. So the "traditional" way of killing cgroups is a take-over from
the legacy cgroup world.

Since cgroups organize and manage resources and processes killing
cgroups is arguably a core cgroup feature and in some form was always
planned. It just hasn't been high-priority.

We often tend to bring "this is just convenience and therefore not worth
it" as an argument (sure did it myself) but I think that's quite often
not a very good argument. We should very much try to make interfaces
simpler to use for userspace. In this specific instance the code comes
down from an algorithm to recursively kill all cgroups to a single write
into a file. Which seems like a good win.

This also allows for quite a few things that aren't currently possible
in userspace. Some of which were in the original mail (at least
implicitly).
For example, you can delegate killing of a privileged cgroup to a less
privileged or sandboxed process by having the privileged process open
the cgroup.kill file and then handing it off. In general similar to
freezing you can send around that file descriptor. You can kill
processes in ancestor or sibling pid namespaces as long as they are
encompassed in the same cgroup. And other useful things.

But really, the simplifcation alone is already quite good.
