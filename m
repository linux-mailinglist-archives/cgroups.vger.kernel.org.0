Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70DD43112C
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 09:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhJRHLt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 03:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhJRHLl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 03:11:41 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC2C061745;
        Mon, 18 Oct 2021 00:09:30 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id l16-20020a9d6a90000000b0054e7ab56f27so796849otq.12;
        Mon, 18 Oct 2021 00:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=O/OZJC0HIUE3DNP74CA6ob2Ysy1RgHmyhS2ZxyEPXFQ=;
        b=SSUOD1uC9IodrXjZW/i5EdgxkEgrD955N9s4FpbRkuCr8XDDCmVTbVqRPHDNRSENmQ
         iz9t4oURkPyAIYFZ3pF4/7pS+eNQ6jTzoIb8Ev4KENA7b6ItNIiOxdYyMocXP4myvfsj
         15woTtJGjmSTDkC3/6mQkEhMkSU7psQwGbmQfHehlpJMH3yHUwtWBcHFxxkAXVoKt9Ts
         nBaKJ59mpV+je8EW4XMdc2rrfQz96tlTmC0TJu+NT3nZuvW7kx11mUXZ9afwkITGFFTH
         VJ4YFQqqQCqqqoGqQaTuKHkzbE+8N/bVbWwHgsEX8SSO9yDK5OStQK0VbKm5QKeo1bcd
         is/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=O/OZJC0HIUE3DNP74CA6ob2Ysy1RgHmyhS2ZxyEPXFQ=;
        b=o8R9Zwf5hdwuKPbYH+P5uvqFSeWG4wP90FJPDQIW51egpvFSJDqef2OObmZJxjrsdD
         AeK3v4FxfgmBsjthzdgqAte61LSAzRXH3dqVtEyv8ZjeFAA3O23ebOyXOpZUU2+xq4ox
         tTeN7F1dUPO5xNsI+MnCDgyhcVYO8XFl+d9vVC/K1Gq3Z4HyJn6fPHs8CM1sqMiu15kf
         ShOVPwPHZLs5GWC+8abZQQCLzv19g50ACkFd1ysaHixr6Vt/YFu1BmrgYnUVRPyphXOv
         IllF5BywSs+UMBTuv3vRAIs9BA7w3IJV0kFyLOWjCqG6cdcYV7gCKgnLiv5lJkBUlFUy
         OCew==
X-Gm-Message-State: AOAM531hSPMfvHxOIxLl6Qhc8t5KZ3DfEydgo3OgKHGqEzRCqlsqcyHq
        K5t5s0lXiA7xa8qlgANF+mEBBALkSSYI7znu6jakZipkDQU=
X-Google-Smtp-Source: ABdhPJyVC+RTqo8zzXghqNePAGY9z5PgIv0+b0z2Csc9EVNystgb5c+HnaMTxR7F/tuzIl8oNOgfX2djHgX3uGTMNIE=
X-Received: by 2002:a05:6830:92:: with SMTP id a18mr12269184oto.307.1634540969155;
 Mon, 18 Oct 2021 00:09:29 -0700 (PDT)
MIME-Version: 1.0
From:   Youfu Zhang <zhangyoufu@gmail.com>
Date:   Mon, 18 Oct 2021 15:08:53 +0800
Message-ID: <CAEKhA2x1Qi3Ywaj9fzdsaChabqDSMe2m2441wReg_V=39_Cuhg@mail.gmail.com>
Subject: [BUG] blk-throttle panic on 32bit machine after startup
To:     tj@kernel.org, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

I ran into a kernel bug related to blk-throttle on CentOS 7 AltArch for i386.
Userspace programs may panic the kernel if they hit the I/O limit
within 5 minutes after startup.

Root cause:
1. jiffies was initialized to -300HZ during boot on 32bit machines
2. enable blkio cgroup hierarchy
   __DEVEL__sane_behavior for cgroup v1 or default hierarchy for cgroup v2
   EL7 kernel modified throtl_pd_init and always enable hierarchical throttling
3. enable & trigger blkio throttling within 5 minutes after startup
   bio propagated from child tg to parent
4. enter throtl_start_new_slice_with_credit
   if(time_after_eq(start, tg->slice_start[rw]))
   aka. time_after_eq(0xFFFxxxxx, 0) does not hold
   parent tg->slice_start[rw] was zero-initialized and not updated
5. enter throtl_trim_slice
   BUG_ON(time_before(tg->slice_end[rw], tg->slice_start[rw]))
   aka. time_before(0xFFFxxxxx, 0) triggers a panic

Reproducer: (tested on Alpine Linux x86 kernel 5.10.X)
#!/bin/sh
CGROUP_PATH="$(mktemp -d)"
mount -t cgroup2 none "$CGROUP_PATH"
echo +io >"$CGROUP_PATH/cgroup.subtree_control"
mkdir "$CGROUP_PATH/child"
echo "7:0 riops=2" >"$CGROUP_PATH/child/io.max"
echo 0 >"$CGROUP_PATH/child/cgroup.procs"
echo 3 >/proc/sys/vm/drop_caches
dd if=/dev/loop0 of=/dev/null count=3
