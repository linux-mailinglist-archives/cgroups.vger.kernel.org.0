Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB45822C034
	for <lists+cgroups@lfdr.de>; Fri, 24 Jul 2020 09:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGXHzN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jul 2020 03:55:13 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40288 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGXHzM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Jul 2020 03:55:12 -0400
Received: by mail-ed1-f67.google.com with SMTP id b13so3979978edz.7;
        Fri, 24 Jul 2020 00:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e70l9ba9mmLl+TWNFDLUgGIMDIu+o4DPfsM91eYhnXM=;
        b=RehVI9sOPDqGaihTBK6zUKk3HigDD1jDXSWyvsME50oIf2lN7GnF1Lk2+mfkCffjV9
         nQ9Ir30SQQMNlycksmbyYnrWLfY+VtfYkcD7eI98JjiEaQdGbChxQrBqDmH4JC51x5HB
         BgqBEEFLPdsdmTzKnRSVOLrm4I3bh5BmfuzuGXf9XbovtN30rVhCZmZoxVobPBwk98oH
         F6bczcSMSLjnPyouY6y8S8A/+uTErApKW6VOJX7qSiv2ngOd7gP5hFpxKwRHl4ILtDEj
         G2Qebb0++mTA1tmBSwupk0r8lx4GnEZUnAXEqM1HLACP68JyB8vK4gmwd2DyDMYUulg9
         p/Uw==
X-Gm-Message-State: AOAM532vddqNqKTqIRmWuWHB2TsoqXGiSE8dEjcMBGkm4Rmjme0/rzJX
        TReRi44MYG61xb8tzlfI7LE=
X-Google-Smtp-Source: ABdhPJzkk92oCWYAtda9S7hO0B5/oUAWrHAG7N5UefVeITgPKIDsZZG4CdNxAhZpGy+FhhxcWLljmQ==
X-Received: by 2002:a05:6402:543:: with SMTP id i3mr7593711edx.182.1595577309758;
        Fri, 24 Jul 2020 00:55:09 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id v24sm177041eds.71.2020.07.24.00.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:55:08 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:55:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     jingrui <jingrui@huawei.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>
Subject: Re: PROBLEM: cgroup cost too much memory when transfer small files
 to tmpfs
Message-ID: <20200724075508.GF4061@dhcp22.suse.cz>
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 21-07-20 11:19:52, jingrui wrote:
[...]
> systemd related issue: https://github.com/systemd/systemd/issues/16499

Well, I would be really careful with one-off and short lived cgroups.
Firstly there are charges which cannot be easily reparented and secondly
even if the memory footprint is reduced there would be still memcgs
standing in the way.

[...]
> 1. Do we have any idea to descrease cgroup memory cost in this case?

Others have already commented on this.

> 2. When user remove cgroup directory, does it possible associated file memory to root cgroup?

We used to do that in the past but removed it by b2052564e66d ("mm:
memcontrol: continue cache reclaim from offlined groups"). Please read
through the changelog for the reasoning behind.

> 3. Can we provide an option that do not associate memory with cgroup in tmpfs?

What is the reason to run under !root cgroup in those sessions if you do
not care about accounting anyway? tmpfs is a persistent charge until the
file is removed. So if those outlive the session then you either want
them to be charged to somebody or you do not care about accounting at
all, no? Or could you explain your usecase some more?
-- 
Michal Hocko
SUSE Labs
