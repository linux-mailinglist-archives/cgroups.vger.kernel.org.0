Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56DF113C897
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2020 16:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgAOP7R (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jan 2020 10:59:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41803 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOP7Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jan 2020 10:59:16 -0500
Received: by mail-qt1-f193.google.com with SMTP id k40so16152499qtk.8;
        Wed, 15 Jan 2020 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BHlo4uJGdkpMotzf6l1LEH0nK2SaURIBMqF7pq0+cPE=;
        b=LwRP9gLUlXJubGXbdTk+FhYOQlXwRmMsHlEe55cVAnjtJ90OQMIoErVrPpruu18dlX
         gk9SxqoS+xp621iP9KezoinvlIWqxdUruCqdIjGT0wMVd8oFC9Hg0l/mGm/aa6G5lQnS
         myUuH1Il7L7qvg1vzJD0Vh6JhzHuENKoLY8+i/CJDR+TmGEE48+64nxI9QGLCtwwK9vi
         7Tj+N4LP7dU3wf5k7tQAeD5e2WyyViFDeBQwyWar+u9GbQ43KtAhQveaJbuzQ9yweZvN
         izYsaa3bnk/z3Y6bjHTITWkMD1RyD3Vg5f9jUU4DXO63KMPxIx07fcmj0nmVRg/5LRSS
         y6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BHlo4uJGdkpMotzf6l1LEH0nK2SaURIBMqF7pq0+cPE=;
        b=LhpnTN02moswEOb9AfvF8UhCUM07KAotWZykBhcn9f/L9ZYjx5U5k7CNcGNyXTdWMu
         7WAtneN34UiZm6+HrVvkrew61dXS3Uf8ie+p8luC1K8ewGur7KxHt3z5aaZ0Eg/F4xI6
         q4hbBzg1g6O+7npB5ply+w/Mx0ChwP6zBuD2v8UAwzPMPmhIreAwPJKIlKV7ceopyhbm
         RjYzP4gzClMgdEcf1iJDURi/brt+wRoUPoGEyGCgaR0L6QbPyKvnrNJE3vDI4tikWFAt
         ThNi/ciqFstK+swatp6LDi1gFUeljJPiFCqy1oH+4nYFiq8pG5VWn7i0n+zsmUyAlYCP
         UOwQ==
X-Gm-Message-State: APjAAAU8vko+G/1NQoSxSKyOxq0awDmjfFd4xoXd7etHKn+yAEDbN0ha
        qjbgC1XDZdXoV7nyjd4HBhU=
X-Google-Smtp-Source: APXvYqx4Z3lHPtwvrtxcO6zVWqLJaCDt7Qbk0m1L8KWW+WW80dlHwOOW1mXWqDSr2W0Elhf4GX3+WQ==
X-Received: by 2002:ac8:6747:: with SMTP id n7mr4221929qtp.224.1579103955239;
        Wed, 15 Jan 2020 07:59:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:1e68])
        by smtp.gmail.com with ESMTPSA id s1sm8496365qkm.84.2020.01.15.07.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 07:59:14 -0800 (PST)
Date:   Wed, 15 Jan 2020 07:59:12 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix function name in comment
Message-ID: <20200115155912.GE2677547@devbig004.ftw2.facebook.com>
References: <20200110072320.85605-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110072320.85605-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 10, 2020 at 03:23:20PM +0800, Chen Zhou wrote:
> Function name cgroup_rstat_cpu_pop_upated() in comment should be
> cgroup_rstat_cpu_pop_updated().
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Applied to cgroup/for-5.6.

Thanks.

-- 
tejun
