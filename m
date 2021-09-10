Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810FD406FB5
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhIJQd4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Sep 2021 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhIJQdz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Sep 2021 12:33:55 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534FBC061574;
        Fri, 10 Sep 2021 09:32:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so1010146pjb.5;
        Fri, 10 Sep 2021 09:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tgXe1DESruN+/rTizBx5p8iE+/E14BLor/fcAtYbb1Y=;
        b=JuMs70r+VpXKmfURn7r1xAkHa84J7MIyXxrJkKqeGRSLmcEHeI6eBYHRj/UlwtCdzT
         tLuzHwmJ9HIREMcgiVTeB0/5kfb+2ErkdRQLAp5Abzt2CIgawsp6KCa+/x/nJgz2sKxE
         S70frEvrS6JAwVg0zTv9BzJDl/0YytEaj82TLB5AbjAB6cilXZ3nhzAnzwJwMHyzL6DT
         XdmrQ9PcZ8mbVvUigWepdGNjzfdEAr29KT03oozkZhUIfJOCtZI5DODbwWmtTpjcD//X
         OKv9R0gJdnYpeSAFMA6JK4X3AyZRf/3SHjAj883RH1wneUsLki+feIcHSowtHFWucbeb
         tOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=tgXe1DESruN+/rTizBx5p8iE+/E14BLor/fcAtYbb1Y=;
        b=Iyw/ofn8hPloeDay3T8q41bm1AuKcKSf+x//lFwPByhJvcI8te07IyIJuFiU0hGjMx
         9S53O99J5il5WQXLpDrj6LKmDww/Y9v+jI0SYfJBtSDZHSPR+AnxKyyphSQqYKn7ZCc6
         1B4y3theycU82mE4xjRLfWJSjj1F24pbVqCluEDuvV44/BCKLX8PXHxUPP1LDdLMX5w2
         6gWd1MeEXzYI7eIAfQ4R7uVo+2T1WpCrg8Ap4qQtd5pQQ8DxQ3YDVsghnD1M9MdDJ1H1
         gFysWPk4Lg24/OYejFADuiPr7hf2scCgER2qTO8sjY4lVF74mp1nT5aTl1KoWTPD9Q3+
         79YQ==
X-Gm-Message-State: AOAM531Ts8Av40fIe4wVhEsKvprEaYikq7EsapdXBt5O1wLzPUvO3D40
        8viSfqjM0VEyVv0vDcwyBMw=
X-Google-Smtp-Source: ABdhPJwAB+ZqfvMWnfvJ2jXzVt7EtKEwT3dbc8Bbn1e/ypFOlipg1TVHRfQlVGHpav8AVh2r14CDZg==
X-Received: by 2002:a17:902:724b:b0:131:ab33:1e4e with SMTP id c11-20020a170902724b00b00131ab331e4emr8437154pll.12.1631291563520;
        Fri, 10 Sep 2021 09:32:43 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id p9sm5526834pfn.97.2021.09.10.09.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 09:32:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 10 Sep 2021 06:32:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     brookxu <brookxu.cn@gmail.com>, Vipin Sharma <vipinsh@google.com>,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] misc_cgroup: introduce misc.events and
 misc_events.local
Message-ID: <YTuIqecqjPKEZcrn@slm.duckdns.org>
References: <988f340462a1a3c62b7dc2c64ceb89a4c0a00552.1631077837.git.brookxu@tencent.com>
 <20210909143702.GA13761@blackbody.suse.cz>
 <CAHVum0eGN=v1kLqHQg7HBESp8Kg4aGZFNd4XTpxfeyToXPmPVg@mail.gmail.com>
 <8259b666-f3a4-6788-880c-38d679414bcb@gmail.com>
 <20210910103306.GA24156@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210910103306.GA24156@blackbody.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, Sep 10, 2021 at 12:33:06PM +0200, Michal Koutný wrote:
> On Fri, Sep 10, 2021 at 01:20:37PM +0800, brookxu <brookxu.cn@gmail.com> wrote:
> > Yeah, this is more reasonable. But there is still one question, whether we
> > need to be consistent with other cgroup subsystems, events and events.local
> > under v1 should not support hierarchy？
> 
> My take is that it's acceptable to present the v2-like files in v1 too
> for the sake of simplicity since:
> - this is not used yet,
> - the v1 is less conventional and
> - the presence of events.local would cater even to cases with tasks in
>   inner nodes.
> 
> It'd be good to have Tejun's insight on this too.

My general appraoch is

* If it's trivial both in terms of complexity and effort to add support for
  cgroup1, oh well, why not?

* Otherwise, don't bother.

* cgroup1 interface is wildly inconsistent anyway, so I wouldn't worry much
  about that.

Thanks.

-- 
tejun
