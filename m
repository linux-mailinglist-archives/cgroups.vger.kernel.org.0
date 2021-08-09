Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5E3E4F58
	for <lists+cgroups@lfdr.de>; Tue, 10 Aug 2021 00:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhHIWiT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Aug 2021 18:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbhHIWiT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Aug 2021 18:38:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292EBC0613D3;
        Mon,  9 Aug 2021 15:37:58 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a8so30238976pjk.4;
        Mon, 09 Aug 2021 15:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3y0PR9hqaxZCbgji9aEKkljrODgvwX/4vrec8nondds=;
        b=hV/65XscHrUVTSXlPXqgMC6M187FxVGO48d2RrLSEcEd1ZVh9XRuET4/wAi9Ht8NvK
         vy3lAN2dWaHEvnIv53DwRAN5+8aFe5LTGgby7GCF2RVjWmzesyFRQgQ+VBWctei6hpUp
         Zdw8b4GCtfJSUDaJDgoczIVrW+gYQnkNOhs7eb6CrzUEcID/MuPhxLZregZkEjQTHNSP
         ZSih/+6fleuLQBQ+BJNq3v40NN4c7e+6eS6QNUBYzicNufv5Kq5XLnq5T7bz3VLO3bW9
         2unQEtTeLqQ/yx9D9a1d9VPUVwwMIg2t0oV5SgrSPzuO6khuzu53BzLKl3E+z9danjj/
         1FIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3y0PR9hqaxZCbgji9aEKkljrODgvwX/4vrec8nondds=;
        b=AiaooMb1dP/lkXmGqzsi98PDNC2KBQkQ043bTSeyyKcKpxcl9ztec7HkrcIkFs29cN
         pHpJ0bDiLGuIkyOazE/CJiUtiKN8but0affBB39ruutY5UkG0FC+BJGIeSriQy4zHAx5
         9spGb46z4u8x7kYmQ3mIXLVfDB+ANy1tRoTh0NQe5PyNxzZGqAIN/nG9nWMw9Vhy6PHA
         CztEUjkadBPDqrV+9Z9UcBM1s7GQ7ytbjpDY/7hn2nXPb2KtfKu9aPegnL5e5nU6F9sK
         9NPHeZcatNTMIl2WxwYr69HJs7/zBqtWSX2xWHcEtCe6WDlF3RDhNesHQWZJo5FWiP59
         cazw==
X-Gm-Message-State: AOAM5323E2x+OQooPxGROyN3+qgybmvI3LnHZlTWosTd8Fsu+F7Zn0iG
        aoJclKD/85eqQeZR/1Nh5tk=
X-Google-Smtp-Source: ABdhPJzFRwGeL391h12HMsmaXlUUl5tadO9B+m7SNIAyReZYwf426ugeZCgM8qW4q+QUE+dzeIr59g==
X-Received: by 2002:a17:902:a40c:b029:12c:17cf:ab6f with SMTP id p12-20020a170902a40cb029012c17cfab6fmr2878556plq.71.1628548677565;
        Mon, 09 Aug 2021 15:37:57 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:df1c])
        by smtp.gmail.com with ESMTPSA id r18sm26832734pgk.54.2021.08.09.15.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 15:37:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 9 Aug 2021 12:37:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 24/38] cgroup: Replace deprecated CPU-hotplug functions.
Message-ID: <YRGuQpOaoikOGcyl@mtj.duckdns.org>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
 <20210803141621.780504-25-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803141621.780504-25-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 03, 2021 at 04:16:07PM +0200, Sebastian Andrzej Siewior wrote:
> The functions get_online_cpus() and put_online_cpus() have been
> deprecated during the CPU hotplug rework. They map directly to
> cpus_read_lock() and cpus_read_unlock().
> 
> Replace deprecated CPU-hotplug functions with the official version.
> The behavior remains unchanged.
> 
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
