Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E4264AA0E
	for <lists+cgroups@lfdr.de>; Mon, 12 Dec 2022 23:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbiLLWQk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Dec 2022 17:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiLLWQi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Dec 2022 17:16:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AF1183B1;
        Mon, 12 Dec 2022 14:16:37 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id t17so1311880pjo.3;
        Mon, 12 Dec 2022 14:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jGpkSVyc4v+RFtLDSN/m3mYqOtryehMxfGYmcyBkvk=;
        b=EIqkfOYY6p1JIUWt70bGUX7mnzPNoEpOqH6QlCucGYlpM2VZNJQVGYtbLlK7ioSRCQ
         mfJNxsx8/Z0uIJ+1MGPDc+n85sDUAYrPQg+9CQbY1uZ1wqPQ28tQjPZt/lXPdc7R1+yn
         H2LDbOxp7Y5P7npUtry9kDHISuYFckwOEtgNqm3yDu6gx4QyMunYTEEc4U5aoIwB6sGk
         rhU2eswgT90dBBFW6CMnPwo5NvPpWy5WO7yzL8eY7yQ0WzmuPDZCNvHQKrsbLpjVzGFV
         J0vallyMWqqlSsk74jsQQsygRc88eAJrhSKw2CsRPMma/liL0dqbUZj3SFG0VQ2kQR1r
         otWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jGpkSVyc4v+RFtLDSN/m3mYqOtryehMxfGYmcyBkvk=;
        b=wgr0Nay+Zojizwri+mK5KauYm257mBHl6Fvpg0nV+fncLWzYIjBuKGP7w4FeetUmzE
         8X9dU3BKASg6DtnI4DW5RblTLak8LNsi7yiGX6RXkOspS8M7qt1Xis5D7Jc/v8tkVUuN
         5tSq3o5KXPgsONjwmQZnjDyITMDR2ENL9Yqfp8G+dTkZFEUq9piW1PpTj+YnAoNhNK8u
         UZGvHQWrKiED22iF+VkjA3XM3xJqJ7VufInRloK5ZqNxbSLPRhi0isniKdKgrgfvy3x+
         2kJRG9pnNkMZlzeKWnVd9dwW7CJWRhPx7IJ+FNjqunnOQPttoYcC7TiSMIbPKbjmWyRd
         14+w==
X-Gm-Message-State: ANoB5pnrjwhKpcVzam6Xgijcyc1saZYIWWc9Ny59EogABk99MG/mWo0O
        a3GUCKDJ7DBxEFurblHmGAg=
X-Google-Smtp-Source: AA0mqf6DvxA2rDj+gNoMoyJqTqbaeklwbwXmAMMhpE1PS1l1hyZwB1/e2aNBNogaYREc3/ljGac5uw==
X-Received: by 2002:a05:6a20:1b15:b0:a9:d66f:b7e9 with SMTP id ch21-20020a056a201b1500b000a9d66fb7e9mr19697831pzb.30.1670883396887;
        Mon, 12 Dec 2022 14:16:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id e4-20020a63aa04000000b004785d99321asm5640370pgf.86.2022.12.12.14.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 14:16:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 12 Dec 2022 12:16:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Waiman Long <longman@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
Subject: Re: [PATCH-block v2 2/3] blk-cgroup: Don't flush a blkg if destroyed
Message-ID: <Y5eoQ8UBN8Xpc+Wp@slm.duckdns.org>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-3-longman@redhat.com>
 <20221212125953.GE16456@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212125953.GE16456@blackbody.suse.cz>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Dec 12, 2022 at 01:59:53PM +0100, Michal Koutný wrote:
> Hello.
> 
> On Sun, Dec 11, 2022 at 05:20:57PM -0500, Waiman Long <longman@redhat.com> wrote:
> > Before commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
> > blkg's stats is only flushed if they are online.
> 
> I'm not sure I follow -- css_release_work_fn/cgroup_rstat_flush may be
> called on an offlined blkcg (offlined!=released). There's no invariant
> ensuring offlined blkcg won't be flushed. (There is only current
> situation when there is no reader of io data that'd need them flushed
> [1].)
> 
> > In addition, the stat flushing of blkgs in blkcg_rstat_flush()
> > includes propagating the rstat data to its parent. However, if a blkg
> > has been destroyed (offline), the validity of its parent may be
> > questionable.
> 
> Parents won't be freed (neither offlined) before children (see
> css_killed_work_fn). It should be regularly OK to pass data into a
> parent of an offlined blkcg.
> 
> > For safety, revert back to the old behavior by ignoring offline
> > blkg's.
> 
> I don't know if this is a good reasoning. If you argue that offlined
> children needn't be taken into parent's account, then I think it's more
> efficient to exclude the offlined blkcgs from update. (With the caveat I
> have in [1].)

Yeah, I'm not sure about this patch either. Doesn't seem necessary.

Thanks.

-- 
tejun
