Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508833DBCD0
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhG3QHN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhG3QHM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Jul 2021 12:07:12 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8161C061765;
        Fri, 30 Jul 2021 09:07:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id mt6so15912440pjb.1;
        Fri, 30 Jul 2021 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3CUKiPjVhRqbcpNjTZQwL56wlHZezFNK9/SuBkCMsYo=;
        b=Vitr0fqnQypj1qamhMaglBiB17MtNukUrISqQJQNwvJadI4SCPnZhFi5tVzRGDziQL
         TzZG/rVZrnvwJfYIY7xVlSslwlEWcoIQl1bnmZLvpmUQExTJ7SmC5cI7Tm7l+nxlcbax
         McUoJYyyJLoaFecRt8ixolN7evBlu7UTi+yRS5E3stLpmQNPgyd+MAzfxPyS9e3LxRca
         eYAUm7mr0WFq9XGmpHtFu5eKuRF6SCw1Mmc5QEJnkrj/jNRGXoX9mzSmq/GZsMc1ikh2
         rVj66/ueTDslhkUmgwR1VnvDvPE7wNwj4StGN/KdPrDF1PgpDFzFt6lMx/5gCpBw+dFo
         JeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3CUKiPjVhRqbcpNjTZQwL56wlHZezFNK9/SuBkCMsYo=;
        b=fZIuRmGPBwvURLpp0fyh7VLqmEPpDh7mXUUh0meOtSfgSaHfbUnZR5/5jjWVG9Ha80
         wmkOvULI94GIns3nzX8cN8pZmpjv39uK2PAsESUIfy6Uh3tDsOTZGcLi7jo2r6CgzMvy
         38HIttImsWQ2ekTys1zGiEZj0q5mPmFEuC6PhgOcNB/T5e+txYMCb3VXE9MhgNjx5Pi6
         VYMQK/OMnijWkbnUgqGA+0Su2b/QA/H+7PwrgDHnN+WmUBDI1ZIsA/ab9YDc/DxmQK9+
         VcYVtQ9vrK6oVhK26MFGv8KFkpQOI0894X/42unchYdxZqo8OqugGj8y5jPYHbEhaHbz
         UUGA==
X-Gm-Message-State: AOAM533g+G0wyITP1mI2XZwRnYVOLkgWpJ+jd/OibTaFAJCP0eBMMTe5
        Ac5G8p4WcBmOKuTeJMaAnLI=
X-Google-Smtp-Source: ABdhPJwCYY5sKLZ7W+Fx+QYea/+AFAuvAgAFpz9bWR4bmHin8WeVYlz4vm0b+Dvj94m5Pdg7vFYv/w==
X-Received: by 2002:a17:90a:748f:: with SMTP id p15mr2671143pjk.179.1627661226174;
        Fri, 30 Jul 2021 09:07:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:5ec3])
        by smtp.gmail.com with ESMTPSA id x7sm2966394pfc.96.2021.07.30.09.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 09:07:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 30 Jul 2021 06:07:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH v2] blk-throtl: optimize IOPS throttle for large IO
 scenarios
Message-ID: <YQQjpQEBbdAgMUM7@mtj.duckdns.org>
References: <40915233274d31bb0659ff9f3be8900a5a0e81ba.1627462548.git.brookxu@tencent.com>
 <YQLhRrkZrmKTzfbP@mtj.duckdns.org>
 <1ce9bcbb-8eea-f51f-f80a-22caf5f2e0d8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ce9bcbb-8eea-f51f-f80a-22caf5f2e0d8@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 30, 2021 at 10:09:34AM +0800, brookxu wrote:
> >> @@ -877,10 +900,19 @@ static inline void throtl_trim_slice(struct throtl_grp *tg, bool rw)
> >>  	else
> >>  		tg->bytes_disp[rw] = 0;
> >>  
> >> -	if (tg->io_disp[rw] >= io_trim)
> >> +	if (tg_io_disp(tg, rw) >= io_trim) {
> > 
> > Instead of checking this in multiple places, would it be simpler to transfer
> > the atomic counters to the existing counters whenever we enter blk-throtl
> > and leave the rest of the code as-is?
> 
> If we do this, we need to do similar processing on the bio submission path and the bio
> resubmission path in pending_timer. It seems that the code is more complicated?

Yeah, basically whenever we enter blk-throtl. Factored to a function,
calling it on entry should be fairly clean, right? I wonder whether it'd be
better to consolidate all atomic counter handling in a single location and
all it does is transferring whatever's accumulated to the usual counters.
Also, when you're reading & resetting the atomic counters, can you use a
pattern like the following?

  main_counter += atomic_xchg(counter, 0);

Right now, there's a race window between reading and resetting.

Thanks.

-- 
tejun
