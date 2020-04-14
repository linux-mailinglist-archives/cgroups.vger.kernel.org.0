Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9087C1A8EC9
	for <lists+cgroups@lfdr.de>; Wed, 15 Apr 2020 00:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634298AbgDNWza (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 18:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730783AbgDNWz2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 18:55:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA141C061A0C
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 15:55:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so12259914wrq.2
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8qoDjMoKh8m7k69YSal4t9Yzh8UqpaGOqxo2kh4+H4=;
        b=qUOTrLKP5lkD+hzSEZLpsh2KQaBFsVU/EEodUWabGWRaIAOxSAA6Fky7NKOSZ1UPR3
         KWeEOVeGQt5g+r3W8cYBFDYtCbD3yqd4wkOln8yW3EbPswE3I0zAIvmvIAuKKrHLRf8j
         YNCY0b2m8MjDExYGkz21fWnOsPZs4GHRqaZdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8qoDjMoKh8m7k69YSal4t9Yzh8UqpaGOqxo2kh4+H4=;
        b=AZp2Z51Xn57Jx4AX0DY3P1sGskOJIWtYj07YHfy2Z/gOJUtQZZPZXSm1jNDWOSeNik
         jgGBmuCE/DZojG2wJgLc0VMKt9692DzLM+fdSZqHmnY0NqXV/wXm9m+c84+YlN9nsZIi
         IJCv+qaVaqlIM51bC09U1QSwUZ9i3h8vIU30bUNnHe0nM723LZHlIFnOTcgOUHN/2CzE
         TP7h0qERAgiPGJ3+I2u3YdhSk8Hqw/Z4Yp/DSiN61FSDfSLcP5LkFhCzCF22gQ0WaUGN
         hfdZ8tT8DYU0D27gi5bOx9D4m/UuaLXtkhIpc/G2teLHC+NXM9Ta0fNr7yBImhVZrqCa
         gWZg==
X-Gm-Message-State: AGi0PuYYP8OBmTcf3QcAFCDv2sqHvgycl0Pzpbo9+dgmWhwZOVyan++t
        bNngBJ9adZf6fpUIXlc45JRyGw==
X-Google-Smtp-Source: APiQypJ6O4aookb/rRY4LDzvhk4cVYhjiK8tQJBOUQvu8zJJrPOFWvoVk8qrVg2FQLDrNSc+7Hmokg==
X-Received: by 2002:adf:ef01:: with SMTP id e1mr966160wro.182.1586904926418;
        Tue, 14 Apr 2020 15:55:26 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:fa59:71ff:fe7e:8d21])
        by smtp.gmail.com with ESMTPSA id w83sm21173847wmb.37.2020.04.14.15.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:55:25 -0700 (PDT)
Date:   Tue, 14 Apr 2020 23:55:25 +0100
From:   Chris Down <chris@chrisdown.name>
To:     svc_lmoiseichuk@magicleap.com
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        akpm@linux-foundation.org, rientjes@google.com, minchan@kernel.org,
        vinmenon@codeaurora.org, andriy.shevchenko@linux.intel.com,
        anton.vorontsov@linaro.org, penberg@kernel.org, linux-mm@kvack.org,
        Leonid Moiseichuk <lmoiseichuk@magicleap.com>
Subject: Re: [PATCH 1/2] memcg: expose vmpressure knobs
Message-ID: <20200414225525.GA1892067@chrisdown.name>
References: <20200413215750.7239-1-lmoiseichuk@magicleap.com>
 <20200413215750.7239-2-lmoiseichuk@magicleap.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200413215750.7239-2-lmoiseichuk@magicleap.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

svc_lmoiseichuk@magicleap.com writes:
>From: Leonid Moiseichuk <lmoiseichuk@magicleap.com>
>
>Populating memcg vmpressure controls with legacy defaults:
>- memory.pressure_window (512 or SWAP_CLUSTER_MAX * 16)
>- memory.pressure_level_critical_prio (3)
>- memory.pressure_level_medium (60)
>- memory.pressure_level_critical (95)
>
>Signed-off-by: Leonid Moiseichuk <lmoiseichuk@magicleap.com>

I'm against this even in the abstract, cgroup v1 is deprecated and its 
interface frozen, and vmpressure is pretty much already supplanted by PSI, 
which actually works (whereas vmpressure often doesn't since it mostly ends up 
just measuring reclaim efficiency, rather than actual memory pressure).

Without an extremely compelling reason to expose these, this just muddles the 
situation.
