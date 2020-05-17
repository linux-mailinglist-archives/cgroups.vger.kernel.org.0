Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA501D6519
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2020 03:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgEQBy2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 May 2020 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgEQBy1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 May 2020 21:54:27 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C60C061A0C
        for <cgroups@vger.kernel.org>; Sat, 16 May 2020 18:54:27 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id fb16so3044306qvb.5
        for <cgroups@vger.kernel.org>; Sat, 16 May 2020 18:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QqBtGMwRf4iMThT/E7Zzgq854jp3AIpzA1Y8zlAhggY=;
        b=kWafknG1HhI2nq0LzV1WNZsMtIbtpGsnnUjIJW35CsFYFMlqLGy5HA66FACPokMXhc
         /8td4xNLaqhlfun7I+onfk0qbHyvwgkIKM8bOj4UMsnD0rRDMxMFSALK5mG4ULqZwOj6
         WmoXzu7R1hOLYUxM2mStHwrkm9PL4c1U1akmER10YBtOmhSV/QJGIj1QxTJ8sHWdoxzm
         dbKcw0on4aWVPAChVGm9vwFsCT8sIV3v9jp7cvdbpBJyWqOLiLrk+mVcF4sn8GKQ2wvn
         RuI8czmKO7TExBBB9x2BribWkKTRmRWIkWPT23qn8tkEWth3IcWCMu+8xOn6mQAGy9ww
         kcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QqBtGMwRf4iMThT/E7Zzgq854jp3AIpzA1Y8zlAhggY=;
        b=USf3E1y1ytnDF2CEpc+fl3Uub6cxCqgoxODP714VoyUwTjE6T1Tdh/I/cDpctMJOxc
         BAVDwhgv4IRai+ofVQUlMx66K14eJZDwCNfs1xCzf56jnnUseHLVwaIZu/h35+jTIiDg
         9mxuKaaXsDMJqFQ8WshxeleBE3RbWaiZY6u85icJlKz5ygo6s4FSYB0stXbk2PSvkuL3
         CQKX9NKNRE82SYzj+fAE0Fhj/2wCi1uyvZf0otseJuj+sCsIFkjS1yup1t4M3U99tasZ
         8dHPf6LPi0nEw6nHpfCIfkTGKzMnKZSrlzlRdIj8Rm3dl+RzXtNQG/TQrioUf9gkMzG0
         45tw==
X-Gm-Message-State: AOAM532nETsBi2+sfhC31TMQ5PJKilf68gybw9D5BDXHJ8WZFa06Xc/b
        W+Ze4ixK7OCO+O451HfCRce7Dg==
X-Google-Smtp-Source: ABdhPJwXFqCGZrPtK8SOtTnNQZnWefQKpRMKA6723XCzFN2bp70KEacdXczdHr/cz1QgFNHfQMMwXg==
X-Received: by 2002:a0c:eb8b:: with SMTP id x11mr10102936qvo.33.1589680466545;
        Sat, 16 May 2020 18:54:26 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m33sm5978445qtb.88.2020.05.16.18.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 18:54:25 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/4] mm/slub: Fix sysfs circular locking dependency
Date:   Sat, 16 May 2020 21:54:25 -0400
Message-Id: <2BD2A76D-CB50-4BA8-A867-DF71B1DA5F28@lca.pw>
References: <20200427235621.7823-1-longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
In-Reply-To: <20200427235621.7823-1-longman@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17E262)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
> 
> v2:
> - Use regular cmpxchg() instead of x86-only try_cmpxchg() in patch 2.
> - Add patches 3 and 4 to fix circular locking dependency showing up
>   at shutdown time.
> 
> With lockdep enabled, issuing the following command to the slub sysfs
> files will cause splat about circular locking dependency to show up
> either immediately afterwards or at shutdown time.
> 
> # echo 1 > validate
> # echo 1 > shrink
> 
> This patchset fixes these lockdep splats by replacing slab_mutex with
> memcg_cache_ids_sem as well as changing some of the lock operations
> with trylock.

For the whole series, feel free to use,

Tested-by: Qian Cai <cai@lca.pw>
