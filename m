Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE4128F77C
	for <lists+cgroups@lfdr.de>; Thu, 15 Oct 2020 19:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390110AbgJORMY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Oct 2020 13:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390105AbgJORMV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Oct 2020 13:12:21 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EED3C061755;
        Thu, 15 Oct 2020 10:12:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id z2so3616432ilh.11;
        Thu, 15 Oct 2020 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cKc+bNP++EX8fyeI3aXeiHgsKpFOPQVrFxV0jhUJ6Fg=;
        b=p0r50dhkcILtmkik8X5doT3aHa4RN3urlDvhCui/LT+YbnQ1OWZozAHZWskt8bEhIW
         yb6JDEMgozrWHdCgXSyYnq8GD+EOW2TGevh3dhnysvwgt6xNa3Zr2iwgHOLfRKMa+/vU
         5QYR9gwKkCKLuhze9yReIip3bePpABLN3vN9Q1eqosiyKI5XQlQlnfeGwW6N3eq6pBha
         SHgCIvsMq4ZJ9XSz0d8BUSSxihLk9cu9V4hWvL2j5L4aL6HauyHuhU9XTGg8mFQmSise
         AFmWX4NcezYAg/A89RzOfNljjxEqHkmFl/ZcYUDopFWTEekqM6RsyCpKnnTEaD1vQM2m
         1GXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=cKc+bNP++EX8fyeI3aXeiHgsKpFOPQVrFxV0jhUJ6Fg=;
        b=i/nBx/5d74zuzgHgM4pRscmeZV5+r9eqdgYQcW279pLmTFnkgf0r0Ju268IZ11/Vcd
         Wf0kzoSpDygK8SA6sdiXOpZnoZKmWd5LjTxrEpGZL9u6gCx1mKm0OfDOk8YPFq6aUZI0
         noDbGNDLKFYGfxkV36QvOvbcK5S/xXMrd0YgEjj2A5Bxs+t/LxE3efyp9i+PJ3Ak8A5w
         gKPMfn9xhW70/l+1ca1pu84pr3kHaAA1KBKlUiwP/6b1PtzvTDKILdItytAQqcgnV1u8
         vvmNudgoF9iHskE0HtwhOBwciAn1EXawrQcXUhDwWN6itZDgtX1pi8bAZyKV6ylz0jFR
         KN9g==
X-Gm-Message-State: AOAM531YhXIJxNVy83YPfMZO48+LhbI6mSzszRwK7UDdeVRdc8hpOEGi
        yYbGrNTPchENrEmla3oxne51fCLQT3vwxw==
X-Google-Smtp-Source: ABdhPJxVnZ1+jrwNEoIkYnMmUllM79lB1UD0hugdC+JJkbQF7qtSN/eSxQ302nVvejCeXS8NAHf8EQ==
X-Received: by 2002:a92:b503:: with SMTP id f3mr3982048ile.23.1602781940097;
        Thu, 15 Oct 2020 10:12:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8126])
        by smtp.gmail.com with ESMTPSA id p12sm3641460ili.14.2020.10.15.10.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 10:12:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 15 Oct 2020 13:12:16 -0400
From:   Tejun Heo <tj@kernel.org>
To:     cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [ANNOUNCEMENT] resctl-demo (Resource Control Demo)
Message-ID: <20201015171216.GG3845@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

resctl-demo which documents resource control features and strategies with
live scenarios has just been released. This documents most stuff that we
learned at FB working with and deploying cgroup2, PSI and oomd.

Setting up the whole environment is still a bit difficult because it depends
on pending kernel patches in devel branches and non-trivial system level
configurations such as btrfs root filesystem, so we've built a system image
which can either be launched in AWS or installed on local machine.
Everything in the image is either already upstream or pending, it's just an
easy way to set things up. Follow the link in the Getting Started section in
README if you wanna check them out.

  https://github.com/facebookexperimental/resctl-demo

Longer term, I'm planning to build benchmark / autotest framework on top so
that we can actually verify and score various aspects of resource control in
terms of both isolation and work conservation.

Thanks.

-- 
tejun
