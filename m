Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB53B19475B
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2020 20:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZTUl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 15:20:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:47082 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTUk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 15:20:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id u4so8049721qkj.13;
        Thu, 26 Mar 2020 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BshxP40VVzwMKYJQVOlxQ7cvaL9xzYOkqdrLAsauMpo=;
        b=c20H/cNu1p8GBlF+mPsYbUh0rXL1H1AWe/ycm2VlcgEK65RBZQUQlnCR/ZCQQsD1K1
         +Eew8NDPAtsfuRrpiipXtIJx7olzpXEAHnH8S2hPh8lobGAMro4Qdjqd/LMLw/Ote73l
         SwhEfIIRGs6JQOEYNVnK3CsC7lNZ2gM/RM9o3qDLuATA7GcnGnxS5L5kopZxYXw1HJt6
         8gC5IhTabVdSWE6IGVSn9jzjguGE1t62zXlN3zPGs1TY2gMDyiLuiWT9/GYedbHZGDqB
         TZCSr3w0/jJpxXKukQ9LUz5TucI9EYGjvlrwGWAvs5teC779vvVK8kCKIoj4u2JHd9tY
         sUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BshxP40VVzwMKYJQVOlxQ7cvaL9xzYOkqdrLAsauMpo=;
        b=JslQ4PTCwHe8Yw9wYpRUW5H/31Aa9poSt0SPjbof6nRld8GgK1KLTpqNcuDpioUPq0
         Hk7RFzXJ8QkNi5Abgm5sgfiZSSnZmdhrgVNEJNB4cgFKhpFez0PX/d5gwDMOHxRjoAqn
         G3eEC9ql6wsVizpK1VcgJKGmA+FlQmGmytSYuo4NJMlSRbM/8jjIr9LBLqYVfhh9vTWJ
         WOfSRk6FGpf8p1nzOks64QmdRaJkA1IO8xqaY7419WeAohoeYmMoSlH8wk/gpsoZKGsA
         g52DWqb/I2yZ1nxgC+R2bHxYAnv0/1SUxptzkJ9NHl/jQT3lV2wAzAC5eQrpwSMsutUT
         bFeQ==
X-Gm-Message-State: ANhLgQ2Q+cgGN3CbPU1euneaCco+s/jITAxGQSlCDyfqlh1mnX2VaATA
        PNoKw1pFM6co1wWWUqljlyA=
X-Google-Smtp-Source: ADFU+vtedxdPndItEm/+/U0dOWfZkCzogEf0Rosyqrgj3YaDSDXRWTyCODUB+KtNSPMKhttNMenckg==
X-Received: by 2002:a37:a50d:: with SMTP id o13mr9754025qke.37.1585250438033;
        Thu, 26 Mar 2020 12:20:38 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d3b8])
        by smtp.gmail.com with ESMTPSA id i4sm1234609qkh.27.2020.03.26.12.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:20:37 -0700 (PDT)
Date:   Thu, 26 Mar 2020 15:20:35 -0400
From:   Tejun Heo <tj@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        jsbarnes@google.com, sonnyrao@google.com, vpillai@digitalocean.com,
        peterz@infradead.org, Guenter Roeck <groeck@chromium.org>,
        Waiman Long <longman@redhat.com>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Message-ID: <20200326192035.GO162390@mtj.duckdns.org>
References: <20200326191623.129285-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326191623.129285-1-joel@joelfernandes.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 26, 2020 at 03:16:23PM -0400, Joel Fernandes (Google) wrote:
> This deliberately changes the behavior of the per-cpuset
> cpus file to not be effected by hotplug. When a cpu is offlined,
> it will be removed from the cpuset/cpus file. When a cpu is onlined,
> if the cpuset originally requested that that cpu was part of the cpuset,
> that cpu will be restored to the cpuset. The cpus files still
> have to be hierachical, but the ranges no longer have to be out of
> the currently online cpus, just the physically present cpus.

This is already the behavior on cgroup2 and I don't think we want to
introduce this big a behavior change to cgroup1 cpuset at this point.

Thanks.

-- 
tejun
