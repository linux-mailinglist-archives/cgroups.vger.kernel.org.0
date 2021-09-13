Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B6D409BBA
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhIMSHz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 14:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhIMSHz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 14:07:55 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B77DC061574;
        Mon, 13 Sep 2021 11:06:39 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e7so10214572pgk.2;
        Mon, 13 Sep 2021 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UezHGcxNyfBcoSgxd4hGReV1amoCkpndioXZIVK6Ldk=;
        b=KnpzewmoKWskYVWA28O7T+PmEpz94a6k3t+RifGRk8GmiE6GyfN07hPDF1H/3jnfHA
         uSg5d+JeF15qhOlapCy6kaOketRAkxSRxPmlBoQhLe7pv6DUOKmm3YdetTKj1+Kkju87
         ZlE+Hag61BB4Qn4FUpUngBdaNi3R+JKfwKHaBKqjrIXkamkWQ6Wpv2ikw/W+yRRXpiEp
         ixd3L7wlaMfsk1CwYJ/4Tr/IeHDToKuoYJQ7YPmuxsiZAddJqILGyCevhOK+8dGcaStq
         IY8gWfjqYhdut96tvYAbXuobY8GU+tDcK2lAzD8wPigSfOyjN+1CMuD8JGr40BwcPi21
         pwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UezHGcxNyfBcoSgxd4hGReV1amoCkpndioXZIVK6Ldk=;
        b=zsowNBqMsOZuQME9JUD67Cos5SEafCoOMUWM6A/mJWBZvTst1KOjF3d2iqAt1gpg0A
         4zbXQA2cVPQix+k0hnqH790FPKR4XldCZIm/zHDzbT3IxXyl+LNJ+9+WhxkPRGKr9zzt
         qLQpQuuF7DKLKTxiLCsGck6XjxOgXEdWZ88xjKp50SsOe0r0n6DZ5pwO4BYyO/EafFSD
         HILBWPAJfwMzsqo1OFP5s2hsgZcylW2H/2Tmo8YR0nbb4tua0KwrY63jUt2z+YkwnNus
         /WMuxDWQFwP/BoPd3qDxIq7cUdnF5SThUFCmUV9j7l9IDroBVjSdU2dvN9e0zUfcJNsf
         oylw==
X-Gm-Message-State: AOAM531/71AhQzRkggzAcdHJa+CR62kY1sNWRU2OdIy2vB2i3bPCONst
        ak/VlA0hTjYGac0OfQknBcI=
X-Google-Smtp-Source: ABdhPJytNOrZzLAPzqtDhEndNu4q9bLevaKH8vzmerHw9+lF0DNsDTqSsfZeYh33vqVpnO4okt+6vQ==
X-Received: by 2002:a63:3d4a:: with SMTP id k71mr12193931pga.276.1631556398682;
        Mon, 13 Sep 2021 11:06:38 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id 11sm7342225pfl.41.2021.09.13.11.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:06:38 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 08:06:36 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cgroup/cpuset: Change references of cpuset_mutex to
 cpuset_rwsem
Message-ID: <YT+TLDAsFulWiW/F@slm.duckdns.org>
References: <20210910024256.7615-1-longman@redhat.com>
 <20210910024256.7615-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910024256.7615-2-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 09, 2021 at 10:42:56PM -0400, Waiman Long wrote:
> Since commit 1243dc518c9d ("cgroup/cpuset: Convert cpuset_mutex to
> percpu_rwsem"), cpuset_mutex has been replaced by cpuset_rwsem which is
> a percpu rwsem. However, the comments in kernel/cgroup/cpuset.c still
> reference cpuset_mutex which are now incorrect.
> 
> Change all the references of cpuset_mutex to cpuset_rwsem.
> 
> Fixes: 1243dc518c9d ("cgroup/cpuset: Convert cpuset_mutex to percpu_rwsem")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.15-fixes.

Thanks.

-- 
tejun
