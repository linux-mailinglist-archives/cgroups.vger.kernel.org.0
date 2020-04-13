Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC9B1A675F
	for <lists+cgroups@lfdr.de>; Mon, 13 Apr 2020 15:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbgDMN4Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Apr 2020 09:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbgDMN4Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Apr 2020 09:56:24 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E903C0A3BDC;
        Mon, 13 Apr 2020 06:56:24 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l13so4374500qtr.7;
        Mon, 13 Apr 2020 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MEV4w5u8wTFD0TinBcOlOPPgb+JBc/8ZPXNjItBqEvc=;
        b=nhu8f+65G6mbDWJj8y7QJL/7UlzoaljLRQvRspKyQ1CA/3V1M0C4N1KGLFfrTbL8Tt
         tocYT+riHzS6jXIOooqsI+Q70TgCylKcvjHW4rv4Wqzfs18PJ5vAmK+8EyMAiPZdCYAY
         rue0xXczbx7/bbAKqpvIw/a5qCiA7yFQ/RyUo3AdGMjI2ziPFbOK2CCnThdfiJ9VjpxC
         IBmL2aH+zNXCSWto2s+rkQfVgZ7Y37rnId0ypzJV1nlC70CMyYGi84ECkUDEjHNpu5oS
         6uM0V++40A/0m0a86BcwN22LCZ6RBqGoi0NZjG//9GlQ8hYOpARHuViznwHNdU1zRaTU
         PNjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MEV4w5u8wTFD0TinBcOlOPPgb+JBc/8ZPXNjItBqEvc=;
        b=F4dUtmMgWIokbD2bim1bk0P738olAihiOd2jkRO/F7ctIph8v+AWxJCAozJq9a/xrc
         D4XveNiRepUKHLzVs9lk/skzpgDp4SK3QKg9WXYkOO9WfssrbNWTvh3aaPo0/97SeJTC
         Towb/QuuFj5lmU4nzOPQbUCF5PuaOCHbKUmi4dAYyyPn2jh0MuSKPJwDS5txEmxRICo3
         QsFLtLhjGTy7oXuPKmuQWOJQdOOleEZUtJ0Hu0i71s/zZ61FRskp5xiPcNHFAhkMB6gU
         JszDdY5YHMJDIbOGRhKCrqY4wJqzYmmb9fxqvLU63vBPhEPuJ4XlFycswEvoyuObaiUI
         r1xA==
X-Gm-Message-State: AGi0PuZRDXI52zDT6afS7gjmb+y+EdsVpt7Abg/C9xBmVvCfe6tWGwSL
        mFQE3K7T//WsT3w5oxlDhY4=
X-Google-Smtp-Source: APiQypKh5p1mK8Fu6o5MmCy3e0faMipQp8cuUVieWNXjoUNZwo+HvPrYywA6UjjylArxPOfmYc3gvg==
X-Received: by 2002:ac8:193d:: with SMTP id t58mr10665708qtj.93.1586786183152;
        Mon, 13 Apr 2020 06:56:23 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id p10sm8655544qtu.14.2020.04.13.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 06:56:22 -0700 (PDT)
Date:   Mon, 13 Apr 2020 09:56:21 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@vger.kernel.org,
        cgroups@vger.kernel.org, newella@fb.com, josef@toxicpanda.com
Subject: Re: [PATCH 2/5] block: add request->io_data_len
Message-ID: <20200413135621.GB60335@mtj.duckdns.org>
References: <20200408201450.3959560-1-tj@kernel.org>
 <20200408201450.3959560-3-tj@kernel.org>
 <20200409014406.GA370295@localhost.localdomain>
 <20200409021119.GJ162390@mtj.duckdns.org>
 <20200409023857.GB370295@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409023857.GB370295@localhost.localdomain>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Apr 09, 2020 at 10:38:57AM +0800, Ming Lei wrote:
> On Wed, Apr 08, 2020 at 10:11:19PM -0400, Tejun Heo wrote:
> > On Thu, Apr 09, 2020 at 09:44:06AM +0800, Ming Lei wrote:
> > > Almost all __blk_mq_end_request() follow blk_update_request(), so the
> > > completed bytes can be passed to __blk_mq_end_request(), then we can
> > > avoid to introduce this field.
> > 
> > But on some drivers blk_update_request() may be called multiple times before
> > __blk_mq_end_request() is called and what's needed here is the total number of
> > bytes in the whole request, not just in the final completion.
> 
> OK.
> 
> Another choice might be to record request bytes in rq's payload
> when calling .queue_rq() only for these drivers.

There sure are multiple ways to skin a cat.

> > > Also there is just 20 callers of __blk_mq_end_request(), looks this kind
> > > of change shouldn't be too big.
> > 
> > This would work iff we get rid of partial completions and if we get rid of
> > partial completions, we might as well stop exposing blk_update_request() and
> > __blk_mq_end_request().
> 
> Indeed, we can store the completed bytes in request payload, so looks killing
> partial completion shouldn't be too hard.

There's a reason why we've had partial completions. On slower IO devices, like
floppy, partial completions actually are advantageous. I'm not arguing this
still holds up as a valid justification but getting rid of partial completions
isn't just a decision about plumbing details either.

Thanks.

-- 
tejun
