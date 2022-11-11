Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B91625FD0
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiKKQtp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 11:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiKKQtm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 11:49:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48224657D0
        for <cgroups@vger.kernel.org>; Fri, 11 Nov 2022 08:49:41 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:49:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668185378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=by5QqL9du6glqSYYKGtrnRKbCf8L3MRSLJ1pR1GLmhU=;
        b=1idBG7W72aOfhjnPjmpTrC+XQm01QjleZeeywZhW9FqSM8vO0jtzcH5/qdm9f2MT3idOv8
        wv29xZwiFvLHqEl7mE9jiSrqFJX45oII4Xt/pfKXsZXrtSZ1Cil+SfvL/FUSQZ9HT8QYI+
        wEjh3wiTAdWikzAEO8zONhNRlv31f4UXekIuv5TMYCD+LgKTn2HzvjD41NWJfUhweK1nbE
        PXZx/7O8jtBkAXNL1OP+nUnSfm4nCgApb0x9AIh427y+O/tec9H60TUtkWJXv7M9Jo+FpG
        t/C2jiA26FnJ42s4FytOUgLOrR7fp2/M6uTzyu4PcWU1jPKxXOkgIMb9P62vog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668185378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=by5QqL9du6glqSYYKGtrnRKbCf8L3MRSLJ1pR1GLmhU=;
        b=qxpl5BK/7KQuq4cV7JAAwdZPpn9yRQ6248uMdajM8qFsJpVLhT3oiZqUoFnv+1YwIhfhQX
        JSYy8Y6eNs3dsRBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/2] cpuset: Skip possible unwanted CPU-mask updates.
Message-ID: <Y259IcCb937bw3AZ@linutronix.de>
References: <20221102105530.1795429-1-bigeasy@linutronix.de>
 <d0b43b7d-54d3-00bd-abe0-78212ee9355a@redhat.com>
 <Y25rcHYzix+kAJF9@linutronix.de>
 <6948de71-a3e3-b6c2-bc67-1bb39cbdff69@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6948de71-a3e3-b6c2-bc67-1bb39cbdff69@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-11-11 11:37:03 [-0500], Waiman Long wrote:
> 
> On 11/11/22 10:34, Sebastian Andrzej Siewior wrote:
> > On 2022-11-02 09:20:48 [-0400], Waiman Long wrote:
> > Hi,
> > 
> > > Yes, that is a known issue which is especially problematic when cgroup v2 is
> > > used. That is why I have recently posted a set of patches to enable
> > > persistent user requested affinity and they have been merged into tip:
> > > 
> > > 851a723e45d1 sched: Always clear user_cpus_ptr in do_set_cpus_allowed()
> > > da019032819a sched: Enforce user requested affinity
> > > 8f9ea86fdf99 sched: Always preserve the user requested cpumask
> > > 713a2e21a513 sched: Introduce affinity_context
> > > 5584e8ac2c68 sched: Add __releases annotations to affine_move_task()
> > > They should be able to address the problem that you list here. Please let me
> > > know if there are still problem remaining.
> > Thank you. This solves the most pressing issue. The CPU-mask is still
> > reset upon activation of the cpuset controller.
> > This is due to the set_cpus_allowed_ptr() in cpuset_attach().
> > 
> > Is is possible to push these patches stable?
> 
> Actually, I prefer to not call set_cpus_allowed_ptr() if the cpumask of the
> old and new cpusets are the same. That will save some cpu cycles. Similarly
> for node_mask. If there is any changes in the cpumask, we have to call
> set_cpus_allowed_ptr(). I will work out a patch to that effect when I have
> spare cycle.

But couldn't we skip that set_cpus_allowed_ptr() if the current mask is
a subset of the new mask and keep the behavior that the mask isn't
changed if the cgroup's mask changes but is still a subset?
That cpuset_attach() callback is only invoked while the task is
initially added to the cgroup which happens during enabling of the
controller. Or do I miss another common usecase?

> Thanks,
> Longman

Sebastian
