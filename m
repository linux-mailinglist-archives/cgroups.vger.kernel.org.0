Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B752C40C3
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 14:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgKYNA2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Nov 2020 08:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728306AbgKYNA2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Nov 2020 08:00:28 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50EC0613D4;
        Wed, 25 Nov 2020 05:00:26 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id v11so1445508qtq.12;
        Wed, 25 Nov 2020 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XuQ+2DG9U9Hwi9eXWeTXB4FOzgysYN6dM+DTmKoBeH0=;
        b=qJp6arWgErU52EuWjiDRXw9HeRKWRsWYxdYmBevAXA64CKkJl9n5dlPUWE3uZJB3wo
         ynVOismALsLZPJVeKGEurbPQo+/ayLYJJrrGV6L/kYu4XvOeT5NbhsEtXNRZNzTiesQ1
         sZ6630I0yDI2jQ155IzrsBYzFumlJ7syQ2lW1T6eFA8Dka6yYpbE8GkYjtGLFZhXIzNY
         C57JmhtsdTNy1m9xlZ+GvhS58tYPbPuzFWhluTeUgV93APIwUUblGwgocra7pJDvyis9
         HG0EEuO0edUIE2FTSbrwfUJDoBhvnEX8xCwXAwvZ+ZJ1kPKxCiA5EAghxX9CEc7gbqv+
         oEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XuQ+2DG9U9Hwi9eXWeTXB4FOzgysYN6dM+DTmKoBeH0=;
        b=ECNgDODB3xrA3JcanHbxhc3ydymbnTU3hSxDh+UO69fu1mFGRqe/pVCd2Iiwew1eAB
         A5wUNaOPGomYkh9ncmJR/3HrW6FIYJqnOC9nS/NBuSebbMJqPFuhXvB+tRyWuPlAaXMH
         LFs52aUGzcRkzIt/oZwdnQ+Ntj2Ou60uG35QktYzIqh5ZpaYx6lA5mYWhmrtD3OK5spi
         H4DsqeA/qn+U6RuSiuYV9Ilnrg2lwY9MaI2BcnFxcLpK5/B+SV5TYu27HMIctVkY4q+v
         mQ1s14TKiv0RIhLprEH2BeqVL2YQHzwio6ic5H1PK+1PBGKOaGG29Qbk3UKVWLi+NS7J
         2hcw==
X-Gm-Message-State: AOAM531VdYlaBzKPLJ0tT8yL7ydlnDn64q17yfYoIFwKyfw0JF8iyO3O
        gX85zo6sl4Zy2Fe7zzV2Qsg=
X-Google-Smtp-Source: ABdhPJwsR4D4Pj0COnlD0OhehpqTr40t94QXx3ieuW6LDWnb12auAiw2cfny/ABIWFOvAdkVBTwJyA==
X-Received: by 2002:ac8:67da:: with SMTP id r26mr2871023qtp.101.1606309225965;
        Wed, 25 Nov 2020 05:00:25 -0800 (PST)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [72.28.8.195])
        by smtp.gmail.com with ESMTPSA id l79sm2340074qke.1.2020.11.25.05.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 05:00:25 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 25 Nov 2020 08:00:03 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Hui Su <sh_def@163.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/cgroup.c: replace 'of->kn->priv' with of_cft()
Message-ID: <X75VUww1HSDTIogr@mtj.duckdns.org>
References: <20201106144740.GA9692@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106144740.GA9692@rlk>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 06, 2020 at 10:47:40PM +0800, Hui Su wrote:
> we have supplied the inline function: of_cft() in cgroup.h.
> 
> So replace the direct use 'of->kn->priv' with inline func
> of_cft(), which is more readable.
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Applied to cgroup/for-5.10-fixes.

Thanks.

-- 
tejun
