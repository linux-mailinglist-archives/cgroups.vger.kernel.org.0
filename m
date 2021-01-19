Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6E2FBBA8
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 16:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbhASPvz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 10:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391457AbhASPdw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 10:33:52 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32FAC061573
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 07:33:11 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id v3so11643051qtw.4
        for <cgroups@vger.kernel.org>; Tue, 19 Jan 2021 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kSkC2qIvnSbPN0EBpd70Gg0QmXoZHEfwntVfKkWRT5Y=;
        b=heLkTAXMu7tor2Dhd0hqS7RlJXkXrZS8bRbn9D98yRqAUqeSwcmb03MFAJjeYTndSu
         7Umtbpq1+cipanv6fsWnAeAopTJMUp0CtQDWtpeSRbh93VmEahoHq+gFACF/mZNJqKwc
         RPpBA5u2q0hNlML5Uj6SCAqtSNx3zvrchDcVXzX89TKPbZlhe2xkRe+0ZtdedAKZnEey
         TPdF9etfTVmMu9O+IfXatJSYl09Bj+rPqrGR4mgd7xAYPWJEAPKd8Sy502AXeuSPWpWk
         pPlfRr4A65ATWgcPPXh+pgSNusrdfkxsSVjN1jvO10e7sSStKKcwKgS16Cdd27ZnGBXU
         NGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=kSkC2qIvnSbPN0EBpd70Gg0QmXoZHEfwntVfKkWRT5Y=;
        b=VX/Wnw7bhbol1/WsIcCDKIB7peOrnP4yvHg8FwxgxScBbHQIBe8hMVmZ8AjC0WQaHI
         Y6JAAGQC0xY/4OjHXxq1/J2b+Tdn5v97QE9LUdPBMb2lT2TDg87TxJhsDNeRBecKvvLp
         CNwhJbYL7SsRtYRFNcz56Z+J8SwI6LLKplUpsMpr4+rPdKA9+ItXHBuJX64Kms6jrab1
         +5lMpXYk681k0mKmLxmGAkWbTxI1I06ObFrd04cfO6fUhTlZ7vqqIDmHCJyjeBuqZqD/
         Vucyph/yl7XNSx1eoMec7zUrG+TbLKq4E2FuxUA1ASIxJLyz6PjqwK8VDx4lnCEPwX6s
         M4rw==
X-Gm-Message-State: AOAM533du/1Hkyyiu24sItcnwNGyfshOydy4JQHxbF13hQvyplQysEj/
        LlV6aPh5ammqIBI9JwVO0Dw=
X-Google-Smtp-Source: ABdhPJyH7FaQoSqC9/62OpW6VHNPKYyUC8W13ZyRqfDYx8D/kaCLocWuhH3ZyDcS+SCCf41WcdsF8g==
X-Received: by 2002:ac8:4557:: with SMTP id z23mr2880308qtn.191.1611070391032;
        Tue, 19 Jan 2021 07:33:11 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:4cbf])
        by smtp.gmail.com with ESMTPSA id l24sm13427609qkl.46.2021.01.19.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 07:33:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jan 2021 10:32:25 -0500
From:   Tejun Heo <tj@kernel.org>
To:     liming wu <wu860403@gmail.com>
Cc:     cgroups@vger.kernel.org, 398776277 <398776277@qq.com>
Subject: Re: [PATCH] tg: add cpu's wait_count of a task group
Message-ID: <YAb7icZqetp5c827@mtj.duckdns.org>
References: <20210115143005.7071-1-wu860403@gmail.com>
 <YAH4w5T3/oCTGJny@mtj.duckdns.org>
 <CAPnMXWWmfzWh9J_G4OPT=eCFySaD2NAFE0_OiWFQKL-1R0uOkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPnMXWWmfzWh9J_G4OPT=eCFySaD2NAFE0_OiWFQKL-1R0uOkA@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Jan 18, 2021 at 11:07:47AM +0800, liming wu wrote:
> > > +             if (schedstat_enabled() && tg != &root_task_group) {
> > > +                     u64 ws = 0;
> > > +                     u64 wc = 0;
> > > +                     int i;
> > > +
> > > +                     for_each_possible_cpu(i) {
> > > +                             ws += schedstat_val(tg->se[i]->statistics.wait_sum);
> > > +                             wc += schedstat_val(tg->se[i]->statistics.wait_count);
> > > +                     }
> > > +
> > > +                     seq_printf(sf, "wait_sum %llu\n"
> > > +                             "wait_count %llu\n", ws, wc);
> > > +             }
> >
> > What does sum/count tell?
> It can tell the task group average latency of every context switch
> wait_sum is equivalent to sched_info->run_delay (the second parameter
> of /proc/$pid/schedstat)
> wait_count is equivalent to sched_info->pcount(the third parameter of
> /proc/$pid/schedstat)

Sounds good to me but can you please:

* Rename wait_sum to wait_usec and make sure the duration is in usecs.

* Rename wait_count to nr_waits.

* This should go through the scheduler tree. When you post the updated
  version, please cc the scheduler folks from MAINAINERS.

Thanks.

-- 
tejun
