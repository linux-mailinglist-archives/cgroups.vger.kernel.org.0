Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6AF63632A
	for <lists+cgroups@lfdr.de>; Wed, 23 Nov 2022 16:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238698AbiKWPUD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Nov 2022 10:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbiKWPTt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 23 Nov 2022 10:19:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E7690580;
        Wed, 23 Nov 2022 07:19:47 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:19:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669216786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oTwzhKU9n4ncsH7FV/LSW7qnOCWI7kAJ1Y5x5I67+ZY=;
        b=RarddSxY8wubej+5CMsEi0c4ueQywT1Xj6BsflZ7pW0Q3OcLh2fBHBWi7eUN1tqNOwNV2x
        c01JSTuG16x8QV34k9HdUYZV9ZiYuvgZTcxQ3ePuamINLp2gKArsQShyxgKzW9afIeLBRN
        zQjRVJXWuH0JXaEd5tEy3DQtUiabK0RhA0HC3xPoNsJDtf9GbAMLEMN9fI4JqgXt4ifh0f
        H5rTILxPo1GeT8xST2ZLqY9jrEQSZxnVdsw7JEn/uRXgmpl2MpHF0dpktPDqZDRounwffN
        pm0jxzXeAvDljQ4arTP1+T6Xz/eqxyyZ1IUEJMFeSCrZXFRQ5WcUTgovVZpquw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669216786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oTwzhKU9n4ncsH7FV/LSW7qnOCWI7kAJ1Y5x5I67+ZY=;
        b=jDl6R+HoPDbfmAaXlS5ltWdEQcWIFx2SBmdf9vr/0n1PVc+h+OAhbp9dtDAHm/pjrJBaVk
        Mwez3VfTMJ13etDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup/cpuset: Optimize cpuset_attach() on v2
Message-ID: <Y346ENzM4+FAjRnn@linutronix.de>
References: <20221112221939.1272764-1-longman@redhat.com>
 <20221112221939.1272764-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221112221939.1272764-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-11-12 17:19:39 [-0500], Waiman Long wrote:
> It was found that with the default hierarchy, enabling cpuset in the
> child cgroups can trigger a cpuset_attach() call in each of the child
> cgroups that have tasks with no change in effective cpus and mems. If
> there are many processes in those child cgroups, it will burn quite a
> lot of cpu cycles iterating all the tasks without doing useful work.

Thank you.

So this preserves the CPU mask upon attaching the cpuset container.

| ~# taskset -pc $$
| pid 1564's current affinity list: 0-2

default mask after boot due to isolcpus=

| ~# echo "+cpu" >> /sys/fs/cgroup/cgroup.subtree_control ; echo "+cpuset" >> /sys/fs/cgroup/cgroup.subtree_control
| ~# taskset -pc $$
| pid 1564's current affinity list: 0-2

okay.

| ~# echo 1-3 > /sys/fs/cgroup/user.slice/cpuset.cpus
| ~# taskset -pc $$
| pid 1564's current affinity list: 1-3

wiped away.

| ~# taskset -pc 2-3 $$ 
| pid 1564's current affinity list: 1-3
| pid 1564's new affinity list: 2,3
| ~# echo 2-4 > /sys/fs/cgroup/user.slice/cpuset.cpus
| ~# taskset -pc 2-3 $$ 
| pid 1564's current affinity list: 2,3
| pid 1564's new affinity list: 2,3

But it works if the mask was changed on purpose.

Sebastian
