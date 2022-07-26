Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F98581C67
	for <lists+cgroups@lfdr.de>; Wed, 27 Jul 2022 01:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiGZXap (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Jul 2022 19:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZXao (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Jul 2022 19:30:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FF26554;
        Tue, 26 Jul 2022 16:30:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so14542476pfb.7;
        Tue, 26 Jul 2022 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=IWWxn3X0jnsR94h+cZ81QPmnOmsG3z0u/cykcxbxqQk=;
        b=mBWyIaZ3887OTEur8s1YPqKZsGf3UyXWCMl0JX9K3rbdQIfEVIfq7cXTx+hHgeTbZh
         y+BDnqiaRAskVnICRetNJsy1UwxxhRBSXodYVrU0KQfsBRGBgteG70kVZUzn6S3E+I5w
         Yj1zjv47GCl2+goVzhJOurXm2jzYz0LE0tYMuknKI5Q0YDf4bR0VCvz5pEwIjsewZ9wN
         5lmV1e+mi/vZKP2Z3Rjdoprfv+pJQYEkwuFPTr/h8jOYv8Dp7v84HHL9z2sAKqdLNXW5
         sShwmNi+AOPBVMv9CS8oWE/LuMcWJ6Xbl+roqNA369ALlbqRf6BtaTnbAeQHxwK19vAc
         ZbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=IWWxn3X0jnsR94h+cZ81QPmnOmsG3z0u/cykcxbxqQk=;
        b=6pNOrQmQccxn1hW5t04iO08UezfNOfxvcxPrUNMpm0Uzq1v7lF53XPMpG/ixCO7p4A
         Xcy9OmS5j8uEc4/6efkwbHBh7JM2GfQSC6v8A0CLswB/fP8OT9do7Tc77hn77VF6Drng
         e/gbiIW5kfl+iyBIDYAjWZhGFOpMvaQS9ekVCKES1EoLPgDe03PjMW9BjM6xhzM8fhed
         kf2OfdSp9r0ogxXpYCOavYt7KVhErXgHzh1PM0IDpXmzCYzgRdKykMs4xab+U5yaK6Ve
         d7y+RByHdHCf0TwOeiPig9KnyMxU3tKtFJvNuRLRh8QGx25vfy31O5bv9Koa77rNDMYv
         p83Q==
X-Gm-Message-State: AJIora+nA1npMjDQQrpcLLNIwV//N58CuaCw8Ej3VKnlvd0cx+XWqDut
        xz0dg1HxfV/kplSZNlQZ7O0=
X-Google-Smtp-Source: AGRyM1s3ZPAxH1ynRbYFscu3o8AocBU3BZY+xC/4LJsgHZ2QXpev/iZnZz/68PqpcE8idISPihs45g==
X-Received: by 2002:a63:e908:0:b0:41b:390a:f60d with SMTP id i8-20020a63e908000000b0041b390af60dmr2298982pgh.147.1658878243053;
        Tue, 26 Jul 2022 16:30:43 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:370d])
        by smtp.gmail.com with ESMTPSA id d11-20020a63d64b000000b00416212f8da7sm10732203pgj.44.2022.07.26.16.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 16:30:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 26 Jul 2022 13:30:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 2/3 cgroup/for-5.20] cgroup: Add "no" prefixed mount
 options
Message-ID: <YuB5ICv3bXsy5Xuh@slm.duckdns.org>
References: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
 <YtDvU4jRPSsarcNp@slm.duckdns.org>
 <20220726143246.GA23794@blackbody.suse.cz>
 <YuBIACfZDk72yjI3@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuBIACfZDk72yjI3@slm.duckdns.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Jul 26, 2022 at 10:01:04AM -1000, Tejun Heo wrote:
> On Tue, Jul 26, 2022 at 04:32:46PM +0200, Michal Koutný wrote:
> > On Thu, Jul 14, 2022 at 06:38:43PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > We allow modifying these mount options via remount. Let's add "no" prefixed
> > > variants so that they can be turned off too.
> > 
> > They can be turned off:
> > 
> > > // on v5.19-rc?
> > > :~ # grep cg /proc/mounts
> > > cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0
> > > :~ # mount -t cgroup2 cgroup2 /sys/fs/cgroup/ -oremount
> > > :~ # grep cg /proc/mounts
> > > cgroup2 /sys/fs/cgroup cgroup2 rw,relatime 0 0

  root@test ~# grep cgroup /proc/mounts
  cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot 0 0
  root@test ~# mount -o remount,exec /sys/fs/cgroup
  root@test ~# grep cgroup /proc/mounts
  cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,relatime,nsdelegate,memory_recursiveprot 0 0
  root@test ~# mount -o remount /sys/fs/cgroup
  root@test ~# grep cgroup /proc/mounts
  cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,relatime,nsdelegate,memory_recursiveprot 0 0
  root@test ~# mount -o remount,nsdelegate,memory_recursiveprot cgroup2 /sys/fs/cgroup
  root@test ~# grep cgroup /proc/mounts
  cgroup2 /sys/fs/cgroup cgroup2 rw,relatime,nsdelegate,memory_recursiveprot 0 0
  root@test ~# mount -o remount,memory_recursiveprot cgroup2 /sys/fs/cgroup
  root@test ~# grep cgroup /proc/mounts
  cgroup2 /sys/fs/cgroup cgroup2 rw,relatime,memory_recursiveprot 0 0
  root@test ~# mount -o remount cgroup2 /sys/fs/cgroup
  root@test ~# grep cgroup /proc/mounts
  cgroup2 /sys/fs/cgroup cgroup2 rw,relatime 0 0

Man, I had no idea that `mount -o remount,$OPTS $MOUNT_POINT` and `mount -o
remount,$OPTS $SRC $MOUNT_POINT` behave completely differently in how they
handle existing options. I wonder why other filesystems are implementing
explicit no prefixed options.

Anyways, will soon post a patch to remove the no prefixed options.

Thanks for pointing it out.

-- 
tejun
