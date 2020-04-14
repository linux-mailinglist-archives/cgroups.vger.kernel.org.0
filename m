Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6911A89AF
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504055AbgDNSfr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 14:35:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46616 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730984AbgDNSfp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 14:35:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id f13so15668183wrm.13
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 11:35:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NNF+OvzHw+6BJqxasRQ79RmS18VoVVKUc0Ly0+LuCME=;
        b=WGlaUIaM74qt+pICVt6kwn8nDo+Q6lPzidJN7LhafhfhbIslukTuLfZ6oKQJoGzJI/
         EvKoFtDVi7QmWuBeRIrnmuu35l1VxiaGivMyeauXng1YFq2/UoD6m+hIAAWxuAb5QY3w
         xDI8z2zwHdn2ahurDS9ROMX4H2a2IkiGUS1Ff8F/0RIe3sbYhwnWkDbLej6PlG++5bEO
         YG3aZXwUyMNIpW+T836Q+Qq6BBGZA7qv4Ur3jR/VOLQDS0F0WusI2InsUyp9hXU/88J2
         O0q6BJ+40kmCaI319USWsseOZ24zHTtBIxIHd6VPQmcKmPr+f2EQLUMXt6sJCBMLSndF
         vrYg==
X-Gm-Message-State: AGi0PuZlJSw10X1aVhDLZ/42bfKUfvA7CS01bt/sFPleerFt5Gzccvg6
        RfJ0wx0oFU70BsBmlcKDcXs=
X-Google-Smtp-Source: APiQypIAiy2ZpYXqijDv8r0OB8vhT+dKxKS+wH3ejDqjjIxXi/GMfsT4KtkfaQ3men2qZ1VUZTYlMQ==
X-Received: by 2002:adf:f781:: with SMTP id q1mr1873665wrp.323.1586889343514;
        Tue, 14 Apr 2020 11:35:43 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id e2sm1309730wrv.89.2020.04.14.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 11:35:42 -0700 (PDT)
Date:   Tue, 14 Apr 2020 20:35:41 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     svc_lmoiseichuk@magicleap.com
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com, tj@kernel.org,
        lizefan@huawei.com, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: Re: [PATCH v1 0/2] memcg, vmpressure: expose vmpressure controls
Message-ID: <20200414183541.GS4629@dhcp22.suse.cz>
References: <20200414171840.22053-1-lmoiseichuk@magicleap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414171840.22053-1-lmoiseichuk@magicleap.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-04-20 13:18:38, svc_lmoiseichuk@magicleap.com wrote:
> From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>
> 
> Small tweak to populate vmpressure parameters to userspace without
> any built-in logic change.
> 
> The vmpressure is used actively (e.g. on Android) to track mm stress.
> vmpressure parameters selected empiricaly quite long time ago and not
> always suitable for modern memory configurations. Modern 8 GB devices
> starts triggering medium threshold when about 3 GB memory not used,
> and situation with 12 and 16 GB devices even worse.

I am sorry but this doesn't answer questions I've had for the previous
version of the patch. Please do not post newer versions until there is a
consensusn on the approach based on the review feedback. In order to not
fragment the discussion, let's continue in the original email thread
http://lkml.kernel.org/r/20200413215750.7239-1-lmoiseichuk@magicleap.com
-- 
Michal Hocko
SUSE Labs
