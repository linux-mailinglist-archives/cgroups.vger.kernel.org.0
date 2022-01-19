Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B78D493AC8
	for <lists+cgroups@lfdr.de>; Wed, 19 Jan 2022 14:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354571AbiASNCb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jan 2022 08:02:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60470 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354583AbiASNCZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Jan 2022 08:02:25 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6361218B1;
        Wed, 19 Jan 2022 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642597343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RkiBdzpfXdOX7MXZnhxrmQteAOQNnX9ERhFe1qzjPU0=;
        b=lT7JXlp02MR/i1jZ/yNF3al5FTGadcBqD8X3i/eOVe6bqBYGMKowI3ZTW0wO8Vu4ifeqVB
        Xl+mDX1mPTcK98Eax6zG9jhbmxDlYLTGa6NRYXB/qLPkx7j3GLA7YoET3Dke19bp95HpUY
        Xgv+befEEnMmIw52lDoAhd0gD3wOCfQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A307F13B61;
        Wed, 19 Jan 2022 13:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id omYVJ98L6GHlLQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 19 Jan 2022 13:02:23 +0000
Date:   Wed, 19 Jan 2022 14:02:22 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Zhang Qiao <zhangqiao22@huawei.com>
Cc:     Tejun Heo <tj@kernel.org>, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Question] set_cpus_allowed_ptr() call failed at cpuset_attach()
Message-ID: <20220119130221.GA31037@blackbody.suse.cz>
References: <09ce5796-798e-83d0-f1a6-ba38a787bfc5@huawei.com>
 <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 14, 2022 at 09:15:06AM +0800, Zhang Qiao <zhangqiao22@huawei.com> wrote:
> 	I found the following warning log on qemu. I migrated a task from one cpuset cgroup to
> another, while I also performed the cpu hotplug operation, and got following calltrace.

Do you have more information on what hotplug event and what error
(from set_cpus_allowed_ptr() you observe? (And what's src/dst cpuset wrt
root/non-root)?

> 	Can we use cpus_read_lock()/cpus_read_unlock() to guarantee that set_cpus_allowed_ptr()
> doesn't fail, as follows:

I'm wondering what can be wrong with the current actors:

    cpuset_can_attach
      down_read(cpuset_rwsem)
        // check all migratees
      up_read(cpuset_rwsem)
                                      [ _cpu_down / cpuhp_setup_state ]
                                      schedule_work
                                      ...
                                      cpuset_hotplug_update_tasks
                                        down_write(cpuset_rwsem)
                                        up_write(cpuset_rwsem)
                                      ... flush_work
                                      [ _cpu_down / cpu_up_down_serialize_trainwrecks ]
    cpuset_attach
      down_write(cpuset_rwsem)
        set_cpus_allowed_ptr(allowed_cpus_weird)
      up_write(cpuset_rwsem)

The statement in cpuset_attach() about cpuset_can_attach() test is not
so strong since task_can_attach() is mostly a pass for non-deadline
tasks. Still, the use of cpuset_rwsem above should synchronize (I may be
mistaken) the changes of cpuset's cpu masks, so I'd be interested about
the details above to understand why the current approach doesn't work.

The additional cpus_read_{,un}lock (when reordered wrt cpuset_rwsem)
may work but your patch should explain why (in what situation).

My .02€,
Michal
