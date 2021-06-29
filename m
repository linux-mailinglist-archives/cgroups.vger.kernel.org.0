Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710B53B73BB
	for <lists+cgroups@lfdr.de>; Tue, 29 Jun 2021 16:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhF2OGE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Jun 2021 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbhF2OGD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 29 Jun 2021 10:06:03 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A30C061760;
        Tue, 29 Jun 2021 07:03:36 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id y29so29567524qky.12;
        Tue, 29 Jun 2021 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=epo3zKiTfhS1s7uCWxNYZiOm+vo3zbXKhTVM1Kqzmbg=;
        b=BvAsn6V+lEebL9543XNZN8ZgjQb+osEKHPTuXHALEL19Dqb6/zJ1xRDLLweEL6wFZe
         nCCZ9qgxxMvqfBg0PIRP27jmbc8ViBnRr2O1g5R9fD2B8DKZbSkVH6hdzgMoPIUWzHeV
         u9B76ZOBRd9zRYeaOAP24ARezCGz/5LgXUOcEzlvE1OffxKOhgMBdA+uNkK66LNl3be2
         4qSEXMtzyF67GlNoC0wg7jZ+nuozmqOqplCuU3fIEYFxurWmsax7mrIOp7Vt3dLHEqxZ
         NEM5Qmqlf4GdsA+ghm9u58I4sopLY1RF+S0SNXXwMWYDVwaevKsyyuATbPEouicRln0n
         JZow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=epo3zKiTfhS1s7uCWxNYZiOm+vo3zbXKhTVM1Kqzmbg=;
        b=k8ghkFCGTFs7p+XjM5WuTay9icRHM6gOMBgdeWskAA1aIISS+ZRrn6EeSKN6vHoalH
         1KVzeyVFSYzhXLvuyTOvnihKg2vOb6BNWXlSxEe0h7EBr9w/ehL6a+SY25AEUgFeapKn
         lbbQZgLdoXiwMc5eTEXGGc2Omv0gfDRHQVg4murpNL7tEGR4NId8suJajuEUHn2chMfB
         yh2Jy3euOSLvIbM4LJLJeRikwwWQxHR5aHbW4d/stzW3IiG1b31ykWcgBkawrsD2SWia
         fXmcULAJNQMMvYTxWRL5O4J79dQ/oh0S8PEx50f3MYzWdbc5TUr7c9RuRYrccLf2Z0AS
         VeYw==
X-Gm-Message-State: AOAM5310FsEF8Qs2UnH4DVM1SZxNYfFaFRQjgaOxDB8CQ4BcxrwFRhmq
        bU4ks4MyM5/6lJvYr8uY4MubYd5wYw7B1g==
X-Google-Smtp-Source: ABdhPJwF1jHHpUGYvGSGqrM20Y/wdjXItsUPDnGvL02uIcUIMmbhuYPgIoI1h5EDhETkH9lFL4LviA==
X-Received: by 2002:a37:9b4b:: with SMTP id d72mr16414129qke.10.1624975415813;
        Tue, 29 Jun 2021 07:03:35 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN ([2620:10d:c091:480::1:85ab])
        by smtp.gmail.com with ESMTPSA id n128sm845772qkd.93.2021.06.29.07.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 07:03:35 -0700 (PDT)
Date:   Tue, 29 Jun 2021 10:03:33 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 3/3] loop: Charge i/o to mem and blk cg
Message-ID: <YNsoNeQNMmdplmtp@dschatzberg-fedora-PC0Y6AEN>
References: <20210610173944.1203706-1-schatzberg.dan@gmail.com>
 <20210610173944.1203706-4-schatzberg.dan@gmail.com>
 <YNXvr81YFzbaTxCb@blackbook>
 <YNnZ7hIRIk9dJDry@dschatzberg-fedora-PC0Y6AEN>
 <YNr1TYfBwR/tEpEJ@blackbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNr1TYfBwR/tEpEJ@blackbook>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> Non-inlining in the loop module doesn't seem like a big trouble. OTOH,
> other callers may be more sensitive and would need to rely on inlining.

Yes, this is my concern as well.

> I can't currently think of a nice way to have both the exported and the
> exlicitly inlined variant at once. It seems it's either API or perf
> craft in the end but both are uncertain, so I guess the current approach
> is fine in the end.
> 
> > Yes it is intentional. All requests (not just aio) go through the loop
> > worker which grabs the blkcg reference in loop_queue_work() on
> > construction. So I believe grabbing a reference per request is
> > unnecessary.
> 
> Isn't there a window without the reference between loop_queue_rq and
> loop_queue_work?

Hmm, perhaps I'm not understanding how the reference counting works,
but my understanding is that we enter loop_queue_rq with presumably
some code earlier holding a reference to the blkcg, we only need to
acquire a reference sometime before returning from loop_queue_rq. The
"window" between loop_queue_rq and loop_queue_work is all
straight-line code so there's no possibility for the earlier code to
get control back and drop the reference.

> I don't know, you seem to know better, so I'd suggest
> dropping a comment line into the code explaining this.

I wouldn't be so sure that I know any better here :D - I'm fairly
inexperienced in this domain.

Where would you suggest putting such a comment? The change in question
removed a particular case where we explicitly grab a reference to the
blkcg because now we do it uniformly in one place. Would you like a
comment explaining why we acquire a reference for all loop workers or
one explaining specifically why we don't need to acquire one for aio?
