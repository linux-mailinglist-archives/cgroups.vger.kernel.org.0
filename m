Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46006E4B9B
	for <lists+cgroups@lfdr.de>; Fri, 25 Oct 2019 14:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438983AbfJYM4N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 25 Oct 2019 08:56:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36069 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438960AbfJYM4N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 25 Oct 2019 08:56:13 -0400
Received: by mail-qk1-f194.google.com with SMTP id y189so1626087qkc.3;
        Fri, 25 Oct 2019 05:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6M7fFvGY7jmVpbseBKiV7Fuq3JlQ40S3dRzyK1LCwic=;
        b=ofhvMK0eXyZxIRpnFwbaLupPkNajdfWMJjYOm0pfMWn6sTd9WNq4luJCSZCk9U32l3
         Qsq7qfUq2cplcYYiZjZCj6rjn4pkAfkZYRVSaV3wZVSeSSOweGFTQ5McsyFuTTaVTnRQ
         79Fk+brR7YFXM51tJGOe3sYWpdJBc2xuYr8V5dFhF3xfBF0sEkEWPYLUQD1Vez4Cxr01
         3VqbU5JK3wcJQ95futpJg1jGR+TWZcqwxZY10nxIKHvqj8VXhJMXidnFv5oOdyVUwCcD
         RxHdC2RjWCruxMKaRAiw9PvnyvkXOHYAtATq9OsbEnjmVT+bmIWYtbPRTpDo3qUKz5sZ
         zTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=6M7fFvGY7jmVpbseBKiV7Fuq3JlQ40S3dRzyK1LCwic=;
        b=EuiIVXMhiCVLyUEaz2qW6sKS5+8IeHUvHf1w+QahcttI98z5nj26uY7+zLUDuiAeQk
         im5lPJl6M9Pl7nGNMN1+h7NODR06PAVOPsjNMaBswFT7jFk6jm7ATdRxyUNk8fEV5q7t
         Q0XcpWQ7iTMoj6Cz9o1DmZNfLuqiILCsXk02M2sTuKPozswv+AMd8vTLwA8+GDpZrt2O
         MhESKSYoawPB8cis9mRnec96LOTxLMmJI+wRBZ++OxTA/rdcQaSdzFaKH2o2JUyrH/ti
         l51MI/+7g/ODE9I2phnXx++SvMb6knPFMnkshGkzAIIz1oGpfuoY0rzJbLgYN3ps0qRv
         iMLw==
X-Gm-Message-State: APjAAAXNfg+WQyPMxQwDClUZ5qeTQZegpUe9pn2M0+NSD/33kcoLDBgO
        cV8yMQVIOnMQnojINMTbU0g=
X-Google-Smtp-Source: APXvYqwIeAtf98Je6kvGqevr3VxFPhjCXxdWf2AQtaH8UziMziafLNF3MLP/NvgSAEJWy0kKJUkY+A==
X-Received: by 2002:a37:4701:: with SMTP id u1mr2786381qka.44.1572008170395;
        Fri, 25 Oct 2019 05:56:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::fd3c])
        by smtp.gmail.com with ESMTPSA id k3sm1221289qtf.68.2019.10.25.05.56.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 05:56:09 -0700 (PDT)
Date:   Fri, 25 Oct 2019 05:56:06 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        akpm@linux-foundation.org, arnd@arndb.de, christian@brauner.io,
        deepa.kernel@gmail.com, ebiederm@xmission.com, elver@google.com,
        guro@fb.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH cgroup/for-5.5] cgroup: remove
 cgroup_enable_task_cg_lists() optimization
Message-ID: <20191025125606.GI3622521@devbig004.ftw2.facebook.com>
References: <0000000000003b1e8005956939f1@google.com>
 <20191021142111.GB1339@redhat.com>
 <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024190351.GD3622521@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 24, 2019 at 12:03:51PM -0700, Tejun Heo wrote:
> cgroup_enable_task_cg_lists() is used to lazyily initialize task
> cgroup associations on the first use to reduce fork / exit overheads
> on systems which don't use cgroup.  Unfortunately, locking around it
> has never been actually correct and its value is dubious given how the
> vast majority of systems use cgroup right away from boot.
> 
> This patch removes the optimization.  For now, replace the cg_list
> based branches with WARN_ON_ONCE()'s to be on the safe side.  We can
> simplify the logic further in the future.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Oleg Nesterov <oleg@redhat.com>

Applying to cgroup/for-5.5.

Thanks.

-- 
tejun
