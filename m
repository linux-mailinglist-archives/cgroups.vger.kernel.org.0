Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73981D19E8
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 17:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgEMPvS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 11:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgEMPvS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 11:51:18 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86BC061A0C
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 08:51:17 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x8so220948qtr.2
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 08:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rLEeAmSBwjT3ETZ4wrXG/Y/gbcP+c03guOC0q4Y8fXA=;
        b=CxGZlnCeO8Z+6gWlkyNbL90JiSBlEzm6ThptrdmeTLYbrTmiUMlAF6eHDx9NV4zeGb
         6Rz3PQV5R2XN9pUf4xmN1IKVyaF3WVMHV2UboX5qGevLW946cEuuraERFw9eQEGrXbKC
         ZEtxxPGYbrPUoeWB24ML8Lrx5iuNxW9EkzdqgnkAEasHh2uQH+0JMGCCrdUhLWCvQxBk
         JnuFgJC9Q7HhNbdxW6kBxmZQg/NA4JNrsvfHwgltLePF6FTwiQ/6ToQYL4IHmpzv3H5S
         y/cem8PayEiSqD2aA8SYbHiKZP+VpyM2Tnbb7hjAsHqXaRo4rS7TuE99ktMAowj5sh3E
         V6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rLEeAmSBwjT3ETZ4wrXG/Y/gbcP+c03guOC0q4Y8fXA=;
        b=U/FGSyOBltqNnc2n0Csiwp7Glj9G5czo21QZ8e5McLirmWAEbpQkL51sFnjdULuSx8
         CUAJjioqm/oIhIOvvLoOlv+/xzWdIcF5+dq0B08JK6nS6ObCLCkbp4757un8r0PzIQtN
         acX6nyG2wyaXWqd5OkDJbkN5pK4cFTYiemDaWI4LfvBTLockeZ6iy5jYTShF2ovZbY9+
         N6Q6KUtxNQ5N6kJEAs5a11WqcoQiTXayphpiX+ZMH3IFKGiIGmq6x7O7NV5aptE0yc+y
         rImDQWflo7udgoyRL5WcXFPyTYIBmoTJ2hKQgmK0TkXfODVoCmP+TBzqzLOv9EVsrlR/
         1ZXQ==
X-Gm-Message-State: AGi0PubhZni9Ds2+vcyOMNZKZxmjlCfqZvY8mQ7CZr/WaVTwtkRVMfB7
        5XV1WVuA/w2a/8GOhtFRkoQ=
X-Google-Smtp-Source: APiQypJBGgkxSgwM/jON7e/l0PAa64vx+SeoV9cMd7E3z4I3RW/6nSCOjOHbnOoiFOC7cea+rfzl7g==
X-Received: by 2002:ac8:3664:: with SMTP id n33mr29399453qtb.363.1589385076554;
        Wed, 13 May 2020 08:51:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:beb1])
        by smtp.gmail.com with ESMTPSA id t88sm7645qtd.5.2020.05.13.08.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:51:15 -0700 (PDT)
Date:   Wed, 13 May 2020 11:51:14 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     Veronika Kabatova <vkabatov@redhat.com>, cgroups@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Memory Management <mm-qe@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        catalin marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, LTP List <ltp@lists.linux.it>
Subject: Re: =?utf-8?B?4p2MIEZBSUw=?= =?utf-8?Q?=3A?= Test report for
 kernel?5.7.0-rc5-51f14e2.cki (arm-next)
Message-ID: <20200513155114.GF16815@mtj.duckdns.org>
References: <cki.495C39BD1A.T35Z6VDJPY@redhat.com>
 <20200513060321.GA17433@willie-the-truck>
 <1322199095.22739428.1589365183678.JavaMail.zimbra@redhat.com>
 <1039472143.12305448.1589384415559.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039472143.12305448.1589384415559.JavaMail.zimbra@redhat.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 13, 2020 at 11:40:15AM -0400, Jan Stancek wrote:
> In LTP issue above it was clear that memory controller is in use.
> Here it looks like some lingering reference to cpuset controller
> that can't be seen in sysfs.
> 
> It's triggered by podman tests actually:
> 1. run podman tests
> 2. mount -t cgroup -ocpuset cpuset /mnt/cpuset/ -> EBUSY
> 
> # mount | grep cgroup
> cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,seclabel)
> 
> # grep cpuset -r /sys/fs/cgroup/
> /sys/fs/cgroup/cgroup.controllers:cpuset cpu io memory pids
> 
> And yet, v1 cgroup fails to mount:
> 
> # mount -t cgroup -ocpuset cpuset /mnt/cpuset/
> mount: /mnt/cpuset: cpuset already mounted or mount point busy.

While if a regression it may point to a newly introduced behavior, in
general, dynamically reassigning cgroup controllers to a different version
hierarchy after active use is not something fully supported. From cgroup2
documentation:

  A controller can be moved across hierarchies only after the controller is
  no longer referenced in its current hierarchy. Because per-cgroup
  controller states are destroyed asynchronously and controllers may have
  lingering references, a controller may not show up immediately on the v2
  hierarchy after the final umount of the previous hierarchy. Similarly, a
  controller should be fully disabled to be moved out of the unified
  hierarchy and it may take some time for the disabled controller to become
  available for other hierarchies; furthermore, due to inter-controller
  dependencies, other controllers may need to be disabled too.

  While useful for development and manual configurations, moving controllers
  dynamically between the v2 and other hierarchies is strongly discouraged
  for production use. It is recommended to decide the hierarchies and
  controller associations before starting using the controllers after system
  boot.

Thanks.

-- 
tejun
