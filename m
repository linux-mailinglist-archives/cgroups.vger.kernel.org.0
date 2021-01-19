Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29342FBCFB
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 17:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbhASQx3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 11:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731966AbhASQxX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 11:53:23 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F77BC061574
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:52:40 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h1so9423500qvy.12
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 08:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uGojdeA20zzASlYpdW76UKnqe50ntC8qShndn6zJIz4=;
        b=xtAjKAEtfJQvTQE5lGL0o/pBMwEY1osKiNGCA40ER/PyoQC6arxZqOi3F65vp97cKN
         h+lMfbHribwS5JhD+aM32o5RCl7lTiUuS4dsKUM0nJ8J/V4y8xND8eWXhbfYz935LOuH
         Oygf+8ZTdrQUK4JsMzhoMVERDJnqu7csEnK5zT75ytSHbN7YI8FOvCBn/LZSz7DOvAwY
         6GvraSTztJHRercM9PV46hF8l53VyDol1fxk7eJUlraR/FfdKKf2/tpxctc9l/tfB7JP
         qwQhf7xoRiBqJLidHBzAtWUem0/wr1XEQeC0oFNFhYaFgbHqiOmNo1Baurzc1aS0pcu8
         9iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uGojdeA20zzASlYpdW76UKnqe50ntC8qShndn6zJIz4=;
        b=peYAwNTNi46pnW8iwli1sNBSNikS9tmH3LBGSd+iSgaxCgICwDp851ftsCtt8Wo2XL
         PmsDhZp/rj1T93uGPXzMqUSC6EOjj2N4EQohMhXOCg2GV5jIbrpuS7WIWBUHuDuoqcDn
         MnKvn5d6ZJ2QBKKWC1h4AmmHkFHP51jsjWM5fGwTndkAkcMSXk//5KnNWfbs37181e+1
         N/382QkHtMloRz/1GedErJb0hg12KFJAOUOB5i7W718nXgAHYNlrWZwgnQlVJ0LCp4Bl
         RLZ/bbBsYC5diZCLAD1s+ewlBUUxwmajGnHquppi4e5r3FbPh/uxVm4zDveV9iJ3ZaBU
         oknw==
X-Gm-Message-State: AOAM532tFTv6bo4UuZ86lA4gTlKf7NpXKxwuuyZibSL8FBf9dDHqq8Pl
        mEVj1Bi9e6/G2CPme/392t/yEg==
X-Google-Smtp-Source: ABdhPJz3ic1j17HOrepfbmnlJXR37AVr6m5z0Ku7AfBnvKhYbNPxVtgPdcR7MnHR/P5XmARgVyLfHg==
X-Received: by 2002:a0c:c3c9:: with SMTP id p9mr5315412qvi.49.1611075159264;
        Tue, 19 Jan 2021 08:52:39 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id w91sm6552912qte.83.2021.01.19.08.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:52:38 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:52:37 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Odin Ugedal <odin@uged.al>
Cc:     tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, dschatzberg@fb.com, surenb@google.com
Subject: Re: [PATCH v2 1/2] cgroup: fix psi monitor for root cgroup
Message-ID: <YAcOVZ9hceK3gwWT@cmpxchg.org>
References: <20210116173634.1615875-1-odin@uged.al>
 <20210116173634.1615875-2-odin@uged.al>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116173634.1615875-2-odin@uged.al>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 16, 2021 at 06:36:33PM +0100, Odin Ugedal wrote:
> Fix NULL pointer dereference when adding new psi monitor to the root
> cgroup. PSI files for root cgroup was introduced in df5ba5be742 by using
> system wide psi struct when reading, but file write/monitor was not
> properly fixed. Since the PSI config for the root cgroup isn't
> initialized, the current implementation tries to lock a NULL ptr,
> resulting in a crash.
> 
> Can be triggered by running this as root:
> $ tee /sys/fs/cgroup/cpu.pressure <<< "some 10000 1000000"
> 
> Signed-off-by: Odin Ugedal <odin@uged.al>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Fixes: df5ba5be7425 ("kernel/sched/psi.c: expose pressure metrics on root cgroup")
Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Since this is a userspace-triggerable NULL ptr crash, we should
probably also

Cc: stable@vger.kernel.org # 5.2+
