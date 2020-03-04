Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E6717917A
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 14:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387938AbgCDNgu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 08:36:50 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42881 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgCDNgu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 08:36:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id e11so1550830qkg.9
        for <cgroups@vger.kernel.org>; Wed, 04 Mar 2020 05:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mpYEiYRocka7ATrbRk79a6a7IumZgblHI2WLdpIhwgE=;
        b=KRMhg3xagLh3UMJC+uZmNRJhAvbb7+lGITFZ6oXEJ30imCsJOA2C8r3Gx1xSeoh0lb
         u03uyVzA7OaXsX0ecbqGS+TRSALv/m+efBvYRWRK4sQZPqEj/fTrv1B7Pmq325DuD5NW
         cMufP88PsLaQcCfoDSfv4BPWYvqoVkNYsnhvMkNnX4TuvZd59E+SOYv2wK4k/hxlGpDg
         A2arqwo0nTy1v+8iaOoMpOA01VAURb/SRsABLzydqTmYAeuDo7DyVz1SfDuQwfpnTmhO
         X6UJVLROabbZPV6y+CIAT7vCViW9RJcXYUBynLPR36HFNmVikISKGdk38i/5pQf6o5CQ
         /2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mpYEiYRocka7ATrbRk79a6a7IumZgblHI2WLdpIhwgE=;
        b=kHC+MFQUze0vedBM9zPsZnC/OlBRfom5+C6Hv+/e0+mgdsly6js4GEEWGX/F1/JY7b
         IGP4M7/u2V3t7kjeGTDByzzpnUCrJ6KYQO7ckZZZOI3qpFxGNDVo3ZI1CkW3EbWf0bjM
         akJipTDQJH7sqQajerkPpuuwtRId0tXJW16bdcl04D/6N1mWpzNFR8AZ5fCSrrkZSE4C
         8t9ArNI73OpMmNBOMBkPt2tYbwsN7HIOSK0ABW1XGj/SMEtFzfh2ZyLEgLSITUwqCiKI
         o5uullcTBcjPkSAnJgIOHO1nJyyI1p3TQBSLEVBaKJAGD0ldbgFzDw1PXyXydl7IQk/0
         YHYQ==
X-Gm-Message-State: ANhLgQ34tm+UvbP/o7O9dzCleESw4YV3Z3yR0DqUp0Zv/jMNSlLjL4kT
        cVjXguoXW9rw18pmilbztcaqpg==
X-Google-Smtp-Source: ADFU+vvwqhWeKWuvP/JFbgNL86TeSCyI6fdLqE6IggaPG4339qKIgUrS9GlI8K+DfcRdgWhhjUKT7Q==
X-Received: by 2002:a05:620a:2224:: with SMTP id n4mr2787662qkh.21.1583329009507;
        Wed, 04 Mar 2020 05:36:49 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k5sm1492991qte.25.2020.03.04.05.36.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Mar 2020 05:36:48 -0800 (PST)
Message-ID: <1583329007.7365.151.camel@lca.pw>
Subject: Re: [PATCH] cgroup: fix psi_show() crash on 32bit ino archs
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 04 Mar 2020 08:36:47 -0500
In-Reply-To: <20200224162906.GB1674@cmpxchg.org>
References: <20200224030007.3990-1-cai@lca.pw>
         <20200224162906.GB1674@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2020-02-24 at 11:29 -0500, Johannes Weiner wrote:
> On Sun, Feb 23, 2020 at 10:00:07PM -0500, Qian Cai wrote:
> > Similar to the commit d7495343228f ("cgroup: fix incorrect
> > WARN_ON_ONCE() in cgroup_setup_root()"), cgroup_id(root_cgrp) does not
> > equal to 1 on 32bit ino archs which triggers all sorts of issues with
> > psi_show() on s390x. For example,
> > 
> >  BUG: KASAN: slab-out-of-bounds in collect_percpu_times+0x2d0/
> >  Read of size 4 at addr 000000001e0ce000 by task read_all/3667
> >  collect_percpu_times+0x2d0/0x798
> >  psi_show+0x7c/0x2a8
> >  seq_read+0x2ac/0x830
> >  vfs_read+0x92/0x150
> >  ksys_read+0xe2/0x188
> >  system_call+0xd8/0x2b4
> > 
> > Fix it by using cgroup_ino().
> > 
> > Fixes: 743210386c03 ("cgroup: use cgrp->kn->id as the cgroup ID")
> > Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Tejun, can you take a look at this when you had a chance?
