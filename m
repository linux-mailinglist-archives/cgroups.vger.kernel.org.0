Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6748468393E
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 23:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAaWVr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 17:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjAaWVo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 17:21:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EC0DBF4;
        Tue, 31 Jan 2023 14:21:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id o13so15560281pjg.2;
        Tue, 31 Jan 2023 14:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=hYlTCWU4D6zFu1UQJkS9/xemXij0e8AmBdRmgEzuwoo=;
        b=A57+gxlvG503jp1nTjrGMT9lh0+EOn8owntFD9UdE5J1fd2F30Ujva0Lz5SysUVETD
         atDNmEDGCctu41xqxCLpZ4UtYQbIHIvjq2L2T2Gd4P0Ds9h1lqdpY3yjvCATtCB3LwmH
         lj0c4PSH9OA1dn414ej95BXEc/B8O2lozGpmennj1ErMXSDvyQvR0ehjn1sjR/AgQRkn
         sybHt2aOTPz7UnCHwFmtf4uISgfy0BqTXOC6aEh1sYqXAsqqLCHEsHiEpVb6fOiVJCZ3
         EU74R4GZLOkrTr9bnAC6ogOsom6+Xh6URJs4d8YSiZy+QXd10wL+0hBjcDGGRZudjF8I
         0G2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYlTCWU4D6zFu1UQJkS9/xemXij0e8AmBdRmgEzuwoo=;
        b=e5Kv47Eey0IXBUKxVvuUB9eUQrRhL7DLDm71GTJFMEAwyVp/fMabOOVr2GiLu/Sp+N
         OL6X1HmLk7og8ve+cNnpyev57zXVKoYO/+mRJHH8lzaow9BMUD0yHD9f4xKmVii0yCYM
         wgFxaSgZrlB+xwwpry5qEyeq686ZcVMysINSA2AuN44J7b9bA88Ue1kfilwfQiI6/roB
         JR7kbOhc1DZ/rEw8zSu/+IAs3iR5X5WZpalkm584XvUHAnT83rZfBS4lpvV7W26J9MRZ
         AY17ztVojTCxJMHO4ygBGeFa4tn/TmINQjs6J7kmhLpUsEnc4wMpL4RkSUGO86Rm+eNW
         kMnw==
X-Gm-Message-State: AO0yUKUMB+/G7SEBs6+wzd8I5LArSY/M+1+k4FN/UoMiEwrJEqtQmpsm
        p8B3KzN63XlwHrr+l2BeUnI=
X-Google-Smtp-Source: AK7set9fcAERknjvZWviVAiTQE0NrjgOeygKlQfkvI9/JNRo6AN+VfkYagP8LLUdgJe6vkQlexhAHQ==
X-Received: by 2002:a17:903:1384:b0:196:790a:8bae with SMTP id jx4-20020a170903138400b00196790a8baemr398832plb.43.1675203672211;
        Tue, 31 Jan 2023 14:21:12 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:1ad6])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db8500b00186b3c3e2dasm10280071pld.155.2023.01.31.14.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:21:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 31 Jan 2023 12:21:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [GIT PULL] cgroup fixes for v6.2-rc6
Message-ID: <Y9mUVtmR0AGJKWty@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following changes since commit 58706f7fb045b7019bada81fa17f372189315fe5:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2023-01-31 11:39:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.2-fixes

for you to fetch changes up to e5ae8803847b80fe9d744a3174abe2b7bfed222a:

  cgroup/cpuset: Fix wrong check in update_parent_subparts_cpumask() (2023-01-31 12:14:02 -1000)

----------------------------------------------------------------
Cgroup fixes for v6.2-rc6

This is a very late pull request but cpuset has a bug which can cause an
oops after some configuration operations, which is introduced during the
v6.1 cycle. This pull request contains only one commit to fix the bug.

----------------------------------------------------------------
Waiman Long (1):
      cgroup/cpuset: Fix wrong check in update_parent_subparts_cpumask()

 kernel/cgroup/cpuset.c                            | 3 ++-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

--
tejun
