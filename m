Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD532C62F
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 14:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfE1MKj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 08:10:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:58162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726620AbfE1MKj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 28 May 2019 08:10:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 70416AEF9;
        Tue, 28 May 2019 12:10:38 +0000 (UTC)
Date:   Tue, 28 May 2019 14:10:37 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Waiman Long <longman@redhat.com>, Phil Auld <pauld@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpuset: restore sanity to
 cpuset_cpus_allowed_fallback()
Message-ID: <20190528121036.GC31588@blackbody.suse.cz>
References: <20190409204003.6428-1-jsavitz@redhat.com>
 <20190521143414.GJ5307@blackbody.suse.cz>
 <CAL1p7m6nfPkWoEEAjO+Gxq-ZiRY7+1jU_7dVcw2-hjC22xz-4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1p7m6nfPkWoEEAjO+Gxq-ZiRY7+1jU_7dVcw2-hjC22xz-4A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Thanks for digging through this.

On Fri, May 24, 2019 at 11:33:55AM -0400, Joel Savitz <jsavitz@redhat.com> wrote:
> It is a bit ambiguous, but I performed no action on the task's cpuset
> nor did I offline any cpus at point (a).
So did you do any operation that left you with
    cpu_active_mask & 0xf0 == 0
?

(If so, I think the demo code should be made without it to avoid the
confusion.)

Regardless, the demo code should also specify in what cpuset it happens
(for the v2 case).

> I think the /proc/$$/status value is intended to simply reflect the
> user-specified policy stating which cpus the task is allowed to run on
> without consideration for hardware state, whereas the taskset value is
> representative of the cpus that the task can actually be run on given
> the restriction policy specified by the user via the cpuset mechanism.
Yes, it seems to me to be somewhat analogous to effective_cpus vs
cpus_allowed in the v2 cpuset.


> By the way, I posted a v2 of this patch that correctly handles cgroup
> v2 behavior.
I see the original version made the state = cpuset in select_fallback_rq
mostly redundant. The split on v2 (hierarchy) in v2 (patch) makes some
sense. Although, on v1 we will lose the "no longer affine to..." message
(which is what happens in your demo IIUC).

Michal
