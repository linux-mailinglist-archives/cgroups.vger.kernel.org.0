Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644DE17148E
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2020 10:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgB0J7D (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Feb 2020 04:59:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46207 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbgB0J7D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Feb 2020 04:59:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id j7so2451309wrp.13;
        Thu, 27 Feb 2020 01:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VQ5cODCZxfkuaY7C2X27hLMvpBk5ErfD2dcMR1H0vUQ=;
        b=JJU0oNnazQsJt2bms+AMLR/OzVoAGmRebYNrmf2enIBVhIyVEh8UKPSPvU1QAB1yxw
         ISl9/mGH+qEazp4gKqF5/ZIsIvfbLfhqWyW9IzJZrliSNHkAv1WkrFSQVlArErG3ujm5
         uSt0nk0gRc3EWkoWcy3un2IhRZAkCe3rLZKX6J3C8S/Y35XzHuTrfEj3dx3ZfrTx3idv
         dmKwIhW9+K3luWrlcViyVjptuR+jLjX2YMXxgrdCBf/odKqoA211p962V9/O0k6aXU2T
         KGT/0l/9B9x8Q2SIybxCyHmGV1+yt4/4pO4qtdM23qcbA/sJezmG+DowwYNdU/f0llPU
         /eTg==
X-Gm-Message-State: APjAAAUvp7Ny8+kJ3XiSPxzoPWYMJDHeXcDiOrA+dRcU00q302rVCra7
        wy1n0fgGGnMX3xiFGdNyfxE=
X-Google-Smtp-Source: APXvYqyIHDqVdj4EvcgNGGEOqLGP0YnWFvgtDohXEArkdrFlu3228O8uGCdziWphEpOylyvx14xPRQ==
X-Received: by 2002:adf:ed84:: with SMTP id c4mr3890509wro.24.1582797540999;
        Thu, 27 Feb 2020 01:59:00 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a198sm7226849wme.12.2020.02.27.01.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 01:58:59 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:58:59 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200227095859.GA3771@dhcp22.suse.cz>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <CALvZod7fya+o8mO+qo=FXjk3WgNje=2P=sxM5StgdBoGNeXRMg@mail.gmail.com>
 <20200226222642.GB30206@cmpxchg.org>
 <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2be6ac8d-e290-0a85-5cfa-084968a7fe36@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 26-02-20 16:12:23, Yang Shi wrote:
[...]
> Actually I'm wondering if we really need account CPU cycles used by
> background reclaimer or not. For our usecase (this may be not general), the
> purpose of background reclaimer is to avoid latency sensitive workloads get
> into direct relcaim (avoid the stall from direct relcaim). In fact it just
> "steal" CPU cycles from lower priority or best-effort workloads to guarantee
> latency sensitive workloads behave well. If the "stolen" CPU cycles are
> accounted, it means the latency sensitive workloads would get throttled from
> somewhere else later, i.e. by CPU share.

I believe we need to because that work is not for free and so you are
essentially stealing those CPUs cycles from everybody else outside of
your throttled cgroup.
-- 
Michal Hocko
SUSE Labs
