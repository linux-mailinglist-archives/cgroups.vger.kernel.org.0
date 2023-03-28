Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2953D6CC6C6
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 17:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjC1PlQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 11:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjC1PlA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 11:41:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE04E18F;
        Tue, 28 Mar 2023 08:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4110EB81BC3;
        Tue, 28 Mar 2023 15:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D67C433EF;
        Tue, 28 Mar 2023 15:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680017992;
        bh=bm2MrEPyszxRmD7eWeSEITojITTA3y9rSJopaZVgCJI=;
        h=Date:From:To:Cc:Subject:From;
        b=begcOk0DwzxGyVMLYF8bwQ+eCzvQnXEm8Jj0EsCUgDUd6VADHMrkE4JmDezxj6mW3
         iSy7A1uKgLiOMporYuaLWHCy2oHE/KhBBsFoDywqVQ14LvVm7Fywx45VPMRoPhTr4o
         oogaZbacKQnoG748LJG58XAM1ps0EEuZcOZomgXjt6pbvc/9TdpKBCtUuqdsxshhTx
         RxnEgFgIoLc5EfzVLUmiyELHH+7pZ/Pvcm5sil1NNouUpD/pHO/Xlj0dM0Yu4jjWmc
         /7gTw21ScGVCcV5EOVbr9LZXeFWN407R1kJdXnkFo7xfiGfChQ4Jbr10t88zqVQauS
         sWqNQPoGm6T+Q==
Date:   Tue, 28 Mar 2023 17:39:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, gscrivan@redhat.com
Subject: CLONE_INTO_CGROUP probably needs to call controller attach handlers
Message-ID: <20230328153943.op62j3sw7qaixdsq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hey,

Giuseppe reported that the the affinity mask isn't updated when a
process is spawned directly into the target cgroup via
CLONE_INTO_CGROUP. However, migrating a process will cause the affinity
mask to be updated (see the repro at [1].

I took a quick look and the issue seems to be that we don't call the
various attach handlers during CLONE_INTO_CGROUP whereas we do for
migration. So the solution seems to roughly be that we need to call the
various attach handlers during CLONE_INTO_CGROUP as well when the
parent's cgroups is different from the child cgroup. I think we need to
call all of them, can, cancel and attach.

The plumbing here might be a bit intricate since the arguments that the
fork handlers take are different from the attach handlers.

Christian

[1]: https://paste.centos.org/view/f434fa1a


