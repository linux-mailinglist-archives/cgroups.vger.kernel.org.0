Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB4E512211
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 21:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiD0THb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 15:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiD0TG4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 15:06:56 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3F77C169
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 11:53:45 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id iy15so1691014qvb.9
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Bxi6KofN0Ih5O2P5EXy7XNcKRJLdVQH6xt19JcR/Cc=;
        b=65NapwWd4Bu52BgiMzSrFcem1E52ZJnpS0GWN6sZuF8lZ5D+NZ9Ww0Anh9KupdJguI
         UzAS0QkUzTyoa4mXefmL3ncFHMeJEYGiv8Y4ZWUY5GqWqlu6l8H3TeskMI6hQscaCpfY
         xFTNfO8WOciEzvX0JjGttg51D/9bWg1IxH7Q9heQTyN0Ax1r1H6fpSgxb1qUOYSOt4/b
         VLQI177Dk/OGl9IygOnXPdYVJLVXXFN59R2Qt3TQ2OMHxqMptwsfkrNXKPx5A6KaTz0c
         ZfjzEibO+5o5S6D/+WwZ8cM2fs2lXZy9mXt7BWxQ6A3lY0GIvJq4h5tUVYWmcEZW3FdV
         8Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Bxi6KofN0Ih5O2P5EXy7XNcKRJLdVQH6xt19JcR/Cc=;
        b=ZKZDTnTX0a1PVrQlUenPEX5IRQ6Cp53qFgzL7oevhJlx18YzGoH0ilWK4JN7JIs+DU
         QwkHoDMHY7gxUHb7I++MCGkwdGtlNV0wPA4F9njl9H/ODVmh8xRaKPV78YAFUUm9yuS0
         iN47NvfU6ZqMpKlQEjmduU1hJhsMAGyK8PKPYHYN4H/zCU4zhf1oYV+54ROvV53BBDYx
         wEdql0eeq/tdWiHTw2gByKjbLpAcBVGtNJpJB+3uW/Yg3CapIBJju88QcbW61jk0J4me
         Ph27yOK8DBbZNvRH62EGUqRQ11QYzb40KNcaam9Ki2HlcnAI3lpfRbegE9NwKewZ3DEB
         kwXw==
X-Gm-Message-State: AOAM531Hoq1RTOh5UA895Wc6TpRyo5+qW3i0v3PcINjt0HZ//CV62+j8
        fvcqET1O1cVqHqpndbqPPeGFTw==
X-Google-Smtp-Source: ABdhPJy8dRFnCXB+gsjhhIqlkGq+xCQRJDXI9iajkuXVfgL7CeLRLL3u3OvlYSHjyEszbXwsVMwtjg==
X-Received: by 2002:a0c:c3c6:0:b0:42c:17e4:9a75 with SMTP id p6-20020a0cc3c6000000b0042c17e49a75mr21460568qvi.124.1651085624374;
        Wed, 27 Apr 2022 11:53:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f617])
        by smtp.gmail.com with ESMTPSA id r9-20020ac85c89000000b002f378738ed4sm3690092qta.7.2022.04.27.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:53:44 -0700 (PDT)
Date:   Wed, 27 Apr 2022 14:53:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YmmRFOXJsjLj4a7T@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <20220427113654.ef8f543d7ba279952deff6f7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427113654.ef8f543d7ba279952deff6f7@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 11:36:54AM -0700, Andrew Morton wrote:
> On Wed, 27 Apr 2022 12:00:15 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Currently it requires poking at debugfs to figure out the size and
> > population of the zswap cache on a host. There are no counters for
> > reads and writes against the cache. As a result, it's difficult to
> > understand zswap behavior on production systems.
> > 
> > Print zswap memory consumption and how many pages are zswapped out in
> > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> 
> /proc/meminfo is rather prime real estate.  Is this important enough to
> be placed in there, or should it instead be in the more lowly
> /proc/vmstat?

The zswap pool size is capped to 20% of available RAM, and we usually
have a utilization of tens of gigabytes. I think it's fair to say it's
a first class memory consumer when enabled, and actually a huge hole
in /proc/meminfo coverage right now.

> /proc/meminfo is documented in Documentation/filesystems/proc.rst ;)
> 
> That file appears to need a bit of updating for other things.

"The following is from a 16GB PIII, which has highmem enabled."

lmao.

I'll send a general update for that, and a delta fixlet for 4/5.

Thanks!
