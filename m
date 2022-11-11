Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06910625E69
	for <lists+cgroups@lfdr.de>; Fri, 11 Nov 2022 16:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiKKPeP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Nov 2022 10:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiKKPeP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Nov 2022 10:34:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFAE63B8B
        for <cgroups@vger.kernel.org>; Fri, 11 Nov 2022 07:34:12 -0800 (PST)
Date:   Fri, 11 Nov 2022 16:34:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668180850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=59Iz4/j0NOHHN0PdPEaGGuQ/fhXs7seeaEmnWOHDp2M=;
        b=UC5E0/wdAvQaO1L/gtvDbdCXHl/kOKFrL1zRJ8Pz7iMATdRmlU5Hhn06lzWztYbZkFRu01
        pixk2pSli683iWHKLw2kQ+VH9qKYAWaYmmb99QZmkP40cAe7VXTDUy+hFDk9Yy5ajlHrXM
        MYPX6Hst+r+TMNNO935n7sNO1ZksfR0/hfbHkKLIC49YpyCsX5/dzhF/26iiuOhPqRmfGw
        xFAPJWqUoU+Jq5Rq2l3G4HSSt2OcPGCHg8i2aNEHu1Y9cRjeKXdyOfiVJfIEgZXsruiDak
        dUM6XyOb5a7BRXCYcBnOAfNVWle912QQIznIjOYnCFqmbFDAgT2Lv9kh+Gp3qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668180850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=59Iz4/j0NOHHN0PdPEaGGuQ/fhXs7seeaEmnWOHDp2M=;
        b=cDYRWhTnoxSRtYCJuSO0Gang+LViOF8pM68k143EZTVhOZR2xjsr8dYSkEAFckIiIvw3xl
        9TvTqKp+hh+SAJAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 0/2] cpuset: Skip possible unwanted CPU-mask updates.
Message-ID: <Y25rcHYzix+kAJF9@linutronix.de>
References: <20221102105530.1795429-1-bigeasy@linutronix.de>
 <d0b43b7d-54d3-00bd-abe0-78212ee9355a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d0b43b7d-54d3-00bd-abe0-78212ee9355a@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-11-02 09:20:48 [-0400], Waiman Long wrote:
Hi,

> Yes, that is a known issue which is especially problematic when cgroup v2 is
> used. That is why I have recently posted a set of patches to enable
> persistent user requested affinity and they have been merged into tip:
> 
> 851a723e45d1 sched: Always clear user_cpus_ptr in do_set_cpus_allowed()
> da019032819a sched: Enforce user requested affinity
> 8f9ea86fdf99 sched: Always preserve the user requested cpumask
> 713a2e21a513 sched: Introduce affinity_context
> 5584e8ac2c68 sched: Add __releases annotations to affine_move_task()

> They should be able to address the problem that you list here. Please let me
> know if there are still problem remaining.

Thank you. This solves the most pressing issue. The CPU-mask is still
reset upon activation of the cpuset controller.
This is due to the set_cpus_allowed_ptr() in cpuset_attach().

Is is possible to push these patches stable?

> Thanks,
> Longman

Sebastian
