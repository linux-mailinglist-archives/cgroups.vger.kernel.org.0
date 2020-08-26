Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30AB253134
	for <lists+cgroups@lfdr.de>; Wed, 26 Aug 2020 16:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHZOZB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Aug 2020 10:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgHZOYb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Aug 2020 10:24:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C868C061574
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 07:24:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so1467409qtn.9
        for <cgroups@vger.kernel.org>; Wed, 26 Aug 2020 07:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zlwE58oTu+f+CX5TRYYwuWXiyc0+G6WkfNqbI/+jdSY=;
        b=cO+CBnh7nK5+bWxbN/rwQcj2H4qISpWSCtom8J3NYKwbjjXE4VHyCPU6l4SYsLNQmS
         /WI/E5HAG6u+MoAcxZo9egIz5wDe5DDX4DfqLRODmFk9MExnxgPzPF23yCNm1kB3cvoV
         JoRLPo24DnMgbfUAXBvkX2DO0dxWBYMNrm5mIDfNk6jWm/45g4hZat1hwqysM8GfOXFX
         0R9ZwQfqa5GixPcfpxcCrt6oIcNXd+0bZ32ZYNKsPrbRA29tlAUFbv+RobCsikP15Xj7
         ssAysz8PU4hvGQHGShDiRr1e+3BKKvfW+PrqfNf1IzlNtqHYDXkI1vnfAQh1X9s1Ugev
         bVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zlwE58oTu+f+CX5TRYYwuWXiyc0+G6WkfNqbI/+jdSY=;
        b=GFZbslsOMGZgxJNPZhtRx075rbUEHP9E7WD41QCUJPTgWEjyAlJ+EV517gAeniqy8w
         OPzQuST/yrGI7gADVo2lWD38op0CvgXOpiqQXpmTFmwUeAUNPMIlPsovLu9tM9a/pO+C
         eglNT03vyy0DUOdOcE67luv52g7vNEy+pe49yTTET2p4mzNZR06xWuqdhAMX4Y32vmbn
         Savm1OekCdNn0AngpJCajrCfPQbPRK/ihj0iVEp/IvdcN8v+yiVvAIX4X9lfbQCtIBH2
         Kl0PBK5THPKggJa57FDWIFhDKA702n6S4QTIfTcG35qRjHEZpGLhKlLK1pun3f3E+Ds3
         0G9Q==
X-Gm-Message-State: AOAM533l1ESgtMo6NXeySFGXGqA/TQfqbwGtQDZS1UyMslreICsHAukM
        EtcXV5yQ6fjP9OcMVlcBnqa/SQ==
X-Google-Smtp-Source: ABdhPJzBytYswWR/8B2VHm5Q2Kp/UY/Co8p03yrx9NKrzlbYv6CmqwA0aRiqdMFNUUKDmEF2RxDrxg==
X-Received: by 2002:ac8:47c8:: with SMTP id d8mr13412483qtr.32.1598451870688;
        Wed, 26 Aug 2020 07:24:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f646])
        by smtp.gmail.com with ESMTPSA id l1sm2016291qtp.96.2020.08.26.07.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:24:29 -0700 (PDT)
Date:   Wed, 26 Aug 2020 10:23:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] mm: Optimise madvise WILLNEED
Message-ID: <20200826142315.GB988805@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819184850.24779-4-willy@infradead.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 19, 2020 at 07:48:45PM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of calling find_get_entry() for every page index, use an XArray
> iterator to skip over NULL entries, and avoid calling get_page(),
> because we only want the swap entries.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
