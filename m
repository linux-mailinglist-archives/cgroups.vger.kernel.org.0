Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8EF177C5D
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2020 17:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgCCQvH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 11:51:07 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37210 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgCCQvH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 11:51:07 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so3700545otp.4
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2020 08:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHOn5vqQErDHAkJzL6biRHoTSOSlgdzSHmMDR1rwOSw=;
        b=PrhC/74bze2iem1KsYtIHMvUu/v2Av2MYk8EydsyRsT6ErJ1YQjmNh0R/wDKNLwWyQ
         giq1Pswj3xm3xsbBxVlb00LD6jgh8VspNAcUdojVVHgzs6YNMORKfgfiLcxXKihiD2U4
         VPumlwmRJK94sUJBBlqZZYGZUQDwIbA2T5iHVgWPvH96kjWeV0LugsEESIk6ALCIRDQm
         RBXbpHeIFbrG+TdqIZuAbNbugBhyCIMZGQaFYAf3mlAz6FH7d7jAZcPCS1yweB7G38bo
         a3New9pxIAHaKb1Yr5Al4Jz6nhSG737F7DafcGI95pWkYx4GRRGQsLd7Cs4k3E6agMnj
         8xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHOn5vqQErDHAkJzL6biRHoTSOSlgdzSHmMDR1rwOSw=;
        b=Do89e4A79gij66W4uIXKbO5g3vspgqXK1jJ77TpLHRCKFDYdd/E6TGl9bL3q+vYC91
         5vUVCUhlX6I3I7TredNSTY/md5dHUZINUJKfYeFM6kRrDH+VN4lQEwq29D/7hXzEstMI
         zgdAeJalTYQHNrU93xQzXY914TcSf6LopOkJ96wdamBoJbEAcp/w5gX8RKMtzYuIZ3Cd
         NdqTS5zhpp30NT80nVBsBqFMS2eIlttCGhCAOc+qnB62hQx/iNgBWjcS7Lb2zYNViE35
         RB6Hu9LZdzj4DIln/M+houiOGucaVo8FXVkFH4L2UmpytX6KUm4pWBiYfaL80mXRJysn
         Rajw==
X-Gm-Message-State: ANhLgQ1VnymHtCVKDKLdhOfiTd4lj6CAzfgoCm06CVTd4uSbx8VtmAGx
        RWQzbNn8HzQKFnUetKUHJjWO/2N6wFgT4bGW5+4gx5Q5
X-Google-Smtp-Source: ADFU+vs5bHTlzYDWcHBa7hol10zll+6LrbecnEkuqNf6A/g6QQbYC6octS5rirZT91tqzWiEaJRDmLwA3XoTOV7oDBs=
X-Received: by 2002:a05:6830:118c:: with SMTP id u12mr3866768otq.124.1583254265433;
 Tue, 03 Mar 2020 08:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20200303013901.32150-1-dxu@dxuuu.xyz>
In-Reply-To: <20200303013901.32150-1-dxu@dxuuu.xyz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Mar 2020 08:50:54 -0800
Message-ID: <CALvZod5m3otRRqcLBebbgiZbhoYWAMbMg+ESkacJuj64OP=H4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support user xattrs in cgroupfs
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Cgroups <cgroups@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Daniel,

On Mon, Mar 2, 2020 at 5:42 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> User extended attributes are useful as metadata storage for kernfs
> consumers like cgroups. Especially in the case of cgroups, it is useful
> to have a central metadata store that multiple processes/services can
> use to coordinate actions.
>
> A concrete example is for userspace out of memory killers. We want to
> let delegated cgroup subtree owners (running as non-root) to be able to
> say "please avoid killing this cgroup". In server environments this is
> less important as everyone is running as root.

I would recommend removing the "everyone is running as root" statement
as it is not generally true.

Shakeel
