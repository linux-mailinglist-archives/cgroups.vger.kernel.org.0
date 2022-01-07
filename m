Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566E4487E19
	for <lists+cgroups@lfdr.de>; Fri,  7 Jan 2022 22:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiAGVSu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 16:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiAGVSt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 16:18:49 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA177C061574;
        Fri,  7 Jan 2022 13:18:49 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gp5so6142947pjb.0;
        Fri, 07 Jan 2022 13:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+mr+pZW4rtkqx4SLZE7ugT/NQ4UbxX8mOU3Dn6TRB6E=;
        b=ZuF6bOWd6HtMcHA/bmJB1Shy2xxq6HYD6KqDZeTxu750fya3OiGetfqbVr2CUYNqbA
         AnEyOYmA4HDVuAXKWGU4om1OHTDuf9bVVL9ZJd23rN4X/C2DjSEZg3SgRmMK0g5mBXg1
         c5an3csi7XL+F6f1NicQH8YOUasfa2gWNBpW1XXIgYMDvOAwrE8koHzN1h02gbtMe0lw
         I9ZJB59fM4queKy4VeG0J2GhXboceIkj0Zbyr7WfYTBtHRxmRdf19WKeHoAXo/Axy5iU
         cFWUrrYcwe//r7iVsP9TWzOfqxpHZCg1N5yQn36Gnd1hMP5SClcAtkj7v9ID8c3XyhVo
         BRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=+mr+pZW4rtkqx4SLZE7ugT/NQ4UbxX8mOU3Dn6TRB6E=;
        b=u1dlZqpXpecSkKp0wGWHvNsjKP/aaHif/bD3zsvBdXnVmlL97IgOLO5+8Ne83WxAPP
         GLD3RkWpWWOVGOopXelaSbaOEmRJOHRvU3Yo951CdIyQmTFMzJfpVlCJjK82Zrd30MP1
         BgKGVCSp1Lh2mtX+hfys0PXBkjpHhj2arTEQ8mSMcaEk/8ksSmIOAMUXhaMMbCcJow0K
         M6Gfv5TpuBT4sJa6WKWN/aCoOqHMepgSPtYofPnZZ5js5eRHj0foKTExKYQJYoQ9oPKJ
         u+ul1Te3mn/fdrGlemV7GqtzBOSc3B8ZrA01E4PiQBd3z2eFeUI4jX9tYC8DYjohJwI0
         uVNw==
X-Gm-Message-State: AOAM532mnPr8JbGLI95a+WXSaJmlCmPsgcCEinh/DuDdqQ5Lp4tc0nOB
        PZxtDZv0uIiQTDYpnsNcqVg=
X-Google-Smtp-Source: ABdhPJzDfFuAfm7wc/zg1mWwwVSzhzcBr0JCM31bdg44rNqROMTxCopNrCHTQZZFgnfF1N01spu6mg==
X-Received: by 2002:a17:902:c215:b0:148:af14:6e96 with SMTP id 21-20020a170902c21500b00148af146e96mr64413333pll.80.1641590329057;
        Fri, 07 Jan 2022 13:18:49 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id n26sm1610483pgb.91.2022.01.07.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:18:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 7 Jan 2022 11:18:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Yu Kuai <yukuai3@huawei.com>, hch@infradead.org, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 2/2] block: cancel all throttled bios in del_gendisk()
Message-ID: <YdiuN9kv5OvE/Rtf@slm.duckdns.org>
References: <20211210083143.3181535-1-yukuai3@huawei.com>
 <20211210083143.3181535-3-yukuai3@huawei.com>
 <20220107150519.GA26824@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220107150519.GA26824@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Jan 07, 2022 at 04:05:19PM +0100, Michal Koutný wrote:
> On Fri, Dec 10, 2021 at 04:31:43PM +0800, Yu Kuai <yukuai3@huawei.com> wrote:
> > +	 * queue_lock is held, rcu lock is not needed here.
> > +	 */
> > +	blkg_for_each_descendant_post(blkg, pos_css, td->queue->root_blkg)
> > +		tg_drain_bios(&blkg_to_tg(blkg)->service_queue);
> 
> FTR, I acknowledge this can work due to RCU peculiarities, however, I
> don't understand why is it preferred against more robust explict
> rcu_read_lock().
> 
> (All in all, this isn't a deal breaker and I'm not confident evaluating
> the rest of the patch.)

Cc'ing Paul for RCU. Paul, this nit is around whether or not to use
rcu_read_lock() in an irq disabled section. I can see both sides of the
arguments - it's weird to put in an extra rcu_read_lock() when technically
unnecessary but it's also nice to have something explicit and structured to
mark parts which require RCU protection. Putting in a comment is okay but
consistency is difficult to achieve that way.

Maybe all these are unnecessary as lockdep would be able to catch them
anyway, or maybe we'd want something to explicitly mark RCU protected
sections. I don't know but whichever way, I think we need to establish a
convention.

Thanks.

-- 
tejun
