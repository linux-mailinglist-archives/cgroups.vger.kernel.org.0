Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6400D26B473
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 01:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgIOXYk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Sep 2020 19:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727185AbgIOOiA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Sep 2020 10:38:00 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F17CC061797;
        Tue, 15 Sep 2020 06:17:16 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id j3so1663376qvi.7;
        Tue, 15 Sep 2020 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mj8HXSmsSNxeIujwIa30VgbpWrvEiO598UuHVl/xxe8=;
        b=bHtAaTr37msJEOPArN+wAyZqyi+U84EK+yg4FLU29U2WT5F3NlMFrKlYx15Lnaxg35
         iaNPqo/ZxTk/LX/RZnuY/izI4rNZpq49NOCFW9BcuhcGWeHQEDUSoem1gXprIhbFX+SV
         SQTYidbu2wTV31dg+ncvB3lHATpumuzCVfSLqGdvJwTz4cSlB8PXEFApb9c1lioGJx/A
         wS5DGSV88GR5e6EV1Cov4IosxuDQsd8o1JSCiNIrHw2I8/uFj4/5sNQUknmu1iYGzZkC
         Y75UfxyNyHIgV3Xgx0uKearTwlBb5DeGypy6vOVUJ7pI4NnK9SKmHc4r0U7cexNLjH1Y
         Enew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mj8HXSmsSNxeIujwIa30VgbpWrvEiO598UuHVl/xxe8=;
        b=gTs2kiJduiPWluoFIK8suXdeP+C2votC6z6HZYVTqxOfJ0zwfQHaaag8YLBba51D+z
         XQyayuy8HFYz/Lx0cXX/mpZ/+h5BzOtij1G4NXU+2YG6ZT8D3XiVNu4V910D9POHaQYs
         M05nv+baxdbM7I8uAyGG+gfAE5K8h5njLqjT2XwTi0DvK2t/tf+vsliWy0VTZfBo1VZv
         AvVUZ4SNYD3kKZSzZqgvx7p6CDGfpOmJ4k4vHRnePgHKiAs9Sf4fh3auiyFO/d4VjGbe
         sjEE+G0eeJZzFY+XP0esmfVSDOFVBzEZRSMQGc0xlUgPKvVBkDWiadZsPkgwvO8KUoBP
         vHUg==
X-Gm-Message-State: AOAM533hzauiV9MzmvAdqTenkbfzYEcRhN/UZM9gfjficPESCWc3dSN6
        YWTV0DxKdaZ2v+aksctH/eY=
X-Google-Smtp-Source: ABdhPJyt+1tHPPWQMeQyLwsAJynKK7E0Iunn6FqtUfwe6yHrM7dqmGItWAk2AT1ny975BBdYx33Qaw==
X-Received: by 2002:a05:6214:d6b:: with SMTP id 11mr17952599qvs.30.1600175835673;
        Tue, 15 Sep 2020 06:17:15 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:8e32])
        by smtp.gmail.com with ESMTPSA id b13sm16918676qkl.46.2020.09.15.06.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:17:14 -0700 (PDT)
Date:   Tue, 15 Sep 2020 09:17:12 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v8 0/3] Charge loop device i/o to issuing cgroup
Message-ID: <20200915131712.GA50425@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20200831153704.16848-1-schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831153704.16848-1-schatzberg.dan@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Jens,

How would you like to resolve this patch series? Roman's patch that
this is based off of just made it into linux-next:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/928776957ea4e1c35b1c4c35b8fe7203354fbae3

I suppose you can pull that into the block tree and have git merge
resolve it when it all goes to linus. Another option would be routing
this through Andrew's -mm tree (which already has that commit). Up to
you which you prefer.
