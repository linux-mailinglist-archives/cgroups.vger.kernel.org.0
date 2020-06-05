Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6631F00B4
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2020 22:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgFEUGH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Jun 2020 16:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgFEUGF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Jun 2020 16:06:05 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22177C08C5C2;
        Fri,  5 Jun 2020 13:06:05 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j32so9558012qte.10;
        Fri, 05 Jun 2020 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JTkFUvaRvYSG6ygtt1GZV9UfYQcME0QUIQgnCNhspzw=;
        b=LujWpYSX9TMTA4Reh58wuCm3r1H0Yl5Mifzj7Q9qRPX8q4rB2cXcnuI7G9ELPvtpTF
         dgro1uYoKRf1Gnvcc8GSjfxy2GlyibIg60ztwrMN5t0kJZoHlGF2e/zLLeiw/gMii0CL
         f+duJNpaVmhE8t12pBVy/xvYlv0YzP6gNBEiYBum8vpszAqUs361QZdFZtg2MhXVFW6d
         cfkH7Pp/5xbe25VKKgmMnWdy6cvSAlguFc3SpyfEHhGu8y/VAOox9N++Q6unj5HdxT14
         zzy7S+7NUmLZOX0Y0vA6YVvwqTuNS2+cycw/30J2LR+P1xdfjPpDlIq/aHOkfXQqrjGx
         amLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=JTkFUvaRvYSG6ygtt1GZV9UfYQcME0QUIQgnCNhspzw=;
        b=qnLEAODtfW4vtW2SULA5OniZArHU+IZdhUaTULLIe2DOrWgv6r4doA7zPxlScNa4PC
         VGxGK+hQUurFgxn0UkkyriGEfH5K577y9e6+zJ6v54IKQBjHbYsAoYgY4N7FNBrYWXEN
         kRSlMFCxOfVYA0/2rATC+KIre7NfIIlo5CqY1P4KH9DgRMsFzUwIpxTEy1PiQDFVPkOD
         RjTKbVmDPqjNPmgpUqOQO01a9DBwrVOfp6+5YoEwVfgDLgd4QsGsjVcHjj+9apGV818X
         ion9GakG7qV+WESfPlmEhvU9BZma63yY9OlODnYplJFO0qkkoIj3cPgJ8c4B/jxingEq
         nz5Q==
X-Gm-Message-State: AOAM532kkQj4RRxWp1GS4iTGPGvnk6W/XZTWaa9NosyI9uaA2qqZf9rR
        HsEqUVTubD9iTMPlQcgS3VoLcLcI
X-Google-Smtp-Source: ABdhPJxA24UWMHhoPj3bxG2+IXRRn/DllUkA3pM3drpQ60gBUrA6zd03FpJ84dOWRShQMDV/5TQ3oA==
X-Received: by 2002:aed:2d23:: with SMTP id h32mr10303700qtd.69.1591387563816;
        Fri, 05 Jun 2020 13:06:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:86c8])
        by smtp.gmail.com with ESMTPSA id a7sm654103qth.61.2020.06.05.13.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 13:06:02 -0700 (PDT)
Date:   Fri, 5 Jun 2020 16:06:01 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup changes for v5.8-rc1
Message-ID: <20200605200601.GJ31548@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Linus.

Just two patches. One to add system-level cpu.stat to the root cgroup for
convenience and a trivial comment update.

Thanks.

The following changes since commit eec8fd0277e37cf447b88c6be181e81df867bcf1:

  device_cgroup: Cleanup cgroup eBPF device filter code (2020-04-13 14:41:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-5.8

for you to fetch changes up to 936f2a70f2077f64fab1dcb3eca71879e82ecd3f:

  cgroup: add cpu.stat file to root cgroup (2020-05-28 10:06:35 -0400)

----------------------------------------------------------------
Boris Burkov (1):
      cgroup: add cpu.stat file to root cgroup

Zefan Li (1):
      cgroup: Remove stale comments

 Documentation/admin-guide/cgroup-v2.rst |  6 ++--
 kernel/cgroup/cgroup.c                  | 10 +-----
 kernel/cgroup/rstat.c                   | 60 ++++++++++++++++++++++++++++-----
 3 files changed, 55 insertions(+), 21 deletions(-)

-- 
tejun
