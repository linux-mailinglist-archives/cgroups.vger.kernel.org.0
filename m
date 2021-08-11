Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F693E972E
	for <lists+cgroups@lfdr.de>; Wed, 11 Aug 2021 19:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhHKR63 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Aug 2021 13:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhHKR62 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Aug 2021 13:58:28 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7D8C061765;
        Wed, 11 Aug 2021 10:58:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d1so3709954pll.1;
        Wed, 11 Aug 2021 10:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rk1BWpuiJ39JmRSvLcCw9Ka+QLQwce0JveS233i7okU=;
        b=hXnfg+THbnp0MKwZoNSddpaouYeIdGFdgzY/kWmV1W0dFINKA6zmdPGuCd61wUNmsW
         3cVCn2qhEFihFcbfDwynXSVL7bP//tFXHdBEBve6IlBr4wuvMMaoM7pjo0m0ct+U+5wG
         eBvOe/8osuVPBGFwBQP8SBu6GUCRZn5k+mU6JjrQH4pjmYt0F9lZuejHR3ZJuw76ZoNw
         JzMI8IelJtmcqVDpay4LUvfNH6Iw1Ejsq8zqRnFzmmkbYhOdHdjLsgL+5lEqjcjHewZh
         pUnNqfVA7PBFh/pE7amqpUtEGSblnSQL0buFL/irH8vtxiKXPsHGbcIEBrOncOeVt87Q
         hW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rk1BWpuiJ39JmRSvLcCw9Ka+QLQwce0JveS233i7okU=;
        b=ZkZsnXTfn9txkw9wZpgLDlaDzyxoQtFcJb4xIGLwZ+Phb3mVUJixAjL01h2MuNSDry
         XS5xt7fdXXJ79mXX0mL4rPysO1Y2UXfzlSyuLCr6MpX1qdeHi67hNbxXVn136XnKvndC
         nWvRpw13nPUIon63S+JbhCQ1WawXIXmDH3BoBdaCew0H0eQFS8jqsOMnRHm5sINnqA2g
         j7beFtVjda8EEYNdbRvdiyzn8yISc3c75+M3xm7yj+Z/e1CXuH2qroKQ0rYk4tet8iku
         TBKqJmtF9jqBxNNDN6XeSz/3kKBBch+O4iyi7ziAG0Qpr3PK+ULceye6kfWyX4kCRYKs
         jrPg==
X-Gm-Message-State: AOAM531mKvgXDhHsoF1iAABFBbI9Mok7q1S1P06U1gwXC4qkq8iz4xaV
        gp1ViS5ydppRJKm7jwJFVKI=
X-Google-Smtp-Source: ABdhPJyOXI7ZO4/o/AYgtWU/vzaN6JrfVL0TFjyuaLSBlXKARxSi2kobnLQ26lP6XIb2mx5wFxDOTA==
X-Received: by 2002:a17:902:7243:b029:12d:3d23:f9b3 with SMTP id c3-20020a1709027243b029012d3d23f9b3mr112361pll.0.1628704684424;
        Wed, 11 Aug 2021 10:58:04 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y4sm7479535pjg.9.2021.08.11.10.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:58:04 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 07:58:02 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: cgroup-v1: clean up kernel-doc notation
Message-ID: <YRQPqk8YrsSLB1tk@slm.duckdns.org>
References: <20210811000349.32645-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811000349.32645-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 10, 2021 at 05:03:49PM -0700, Randy Dunlap wrote:
> Fix kernel-doc warnings found in cgroup-v1.c:
> 
> kernel/cgroup/cgroup-v1.c:55: warning: No description found for return value of 'cgroup_attach_task_all'
> kernel/cgroup/cgroup-v1.c:94: warning: expecting prototype for cgroup_trasnsfer_tasks(). Prototype was for cgroup_transfer_tasks() instead
> cgroup-v1.c:96: warning: No description found for return value of 'cgroup_transfer_tasks'
> kernel/cgroup/cgroup-v1.c:687: warning: No description found for return value of 'cgroupstats_build'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: cgroups@vger.kernel.org

Applied to cgroup/for-5.15.

Thanks.

-- 
tejun
