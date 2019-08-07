Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46285305
	for <lists+cgroups@lfdr.de>; Wed,  7 Aug 2019 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbfHGSei (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Aug 2019 14:34:38 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42146 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389041AbfHGSeh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Aug 2019 14:34:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id t12so802982qtp.9;
        Wed, 07 Aug 2019 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TEd6gatoycG7ZYK/wRTlCi/eISRx26y7juuHAC9jUEs=;
        b=R644OPU+lCko3k9nDXGu9/A/vuDcJn94rJoMUPsDRCffxsG+isnp+BHBLQmc2K644e
         66mQuGkZTGxAke75vOwmSvJK6B7tThNNgU17Mmy0pGVSIX7MQcF/72c5IwF+SVKe2+/9
         3vXSRys0roMn1jdcB9qW6Ab8phv2F8C6FUUrmfEUu1zHhqC8meLDYyMaehtDUQwJF5bQ
         Y8GRTNQsLFdruJQs1xnvhyznDmk+7799OjLS/bJHXjEXyrGCjSTajeSkhizcSbuqKREl
         DPUrIKRtYKK8ndWxQKW2D8e2SYP9w65swXBr4FQtUapMvV0tAHkSYCN+X0SubrlfmUMZ
         lRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=TEd6gatoycG7ZYK/wRTlCi/eISRx26y7juuHAC9jUEs=;
        b=QJ79hqsYr+HHcFERWm8mXlWz4oDndHTd+m0ndPdjiNcsBYjnLJXRRoUFej/BXajkR1
         qU4pEttm9HxbrwP56AcVXD4R5I8UAJHyZB7er9I+dmE7+BHAKiKCoVtDf8vL8HIsjFf8
         /CLI2CTZnI9/aaNwKnhT94mT1XqJqbTaDoZS4sdEsrV6QT4ZNUwpg3gT/qnhkGJrPj0z
         A/pyFD6GmBHUUebedKvbUq7To59X6ONCpOBF1Xdbq4/kk/AaRofUAuaVuW78PjeiOdLw
         FwIAMksuvclmIVG1BhS62ER/Q4BZX68dNcxkCHKX4ZEZ8honHHV4qEoX7hk245LH3h11
         0Xjg==
X-Gm-Message-State: APjAAAUppIqmFAMOerg5k5ntmU/ae5TKfqO9DgreHsc9EsOs/XVQUn1z
        VuqYk8A6khNb6oHMKoXzj1o=
X-Google-Smtp-Source: APXvYqw/m3khFk3Yualfy2xpN4sanvEEAmz6JBxD6EOIZ0rs6tDT7YTG6mbRbwiCk+s0QUksrpFdBw==
X-Received: by 2002:ac8:2439:: with SMTP id c54mr9364734qtc.160.1565202876678;
        Wed, 07 Aug 2019 11:34:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::6ac7])
        by smtp.gmail.com with ESMTPSA id i27sm37896195qkk.58.2019.08.07.11.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Aug 2019 11:34:36 -0700 (PDT)
Date:   Wed, 7 Aug 2019 11:34:34 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com
Subject: Re: [PATCH 4/4] writeback, memcg: Implement foreign dirty flushing
Message-ID: <20190807183434.GN136335@devbig004.ftw2.facebook.com>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-5-tj@kernel.org>
 <20190806160306.5330bd4fdddf357db4b7086c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806160306.5330bd4fdddf357db4b7086c@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Aug 06, 2019 at 04:03:06PM -0700, Andrew Morton wrote:
> > +	if (i < MEMCG_CGWB_FRN_CNT) {
> > +		unsigned long update_intv =
> > +			min_t(unsigned long, HZ,
> > +			      msecs_to_jiffies(dirty_expire_interval * 10) / 8);
> 
> An explanation of what's going on here would be helpful.
> 
> Why "* 1.25" and not, umm "* 1.24"?

Just because /8 is cheaper.  It's likely that a fairly wide range of
numbers are okay for the above.  I'll add some comment to explain that
and why the specific constants are picked.

> > +void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
> > +{
> > +	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
> > +	unsigned long intv = msecs_to_jiffies(dirty_expire_interval * 10);
> 
> Ditto.

This is just dirty expiration.  If the dirty data has expired,
writeback must already be in progress by its bdi_wb, so there's no
reason to scheduler foreign writeback.  Will add a comment.

Thanks.

-- 
tejun
