Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72050342133
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 16:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhCSPvh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbhCSPv1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 11:51:27 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8D3C06174A;
        Fri, 19 Mar 2021 08:51:26 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id u7so7022800qtq.12;
        Fri, 19 Mar 2021 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yQLsk2Tp9wfXFgh3gpmNEHc/1LVc0qNRoZDzdBhuURQ=;
        b=bCWupG2mTUy75B9SdmzjE60Wm4fflLRjowQwVn0gS6PS4fBpwtA4DG4NH5Ooo3tjeb
         Crja/7T/8mXD/ardmLAx9Cgj9xa8d+7v4SAYzzWKKlTF9zMvmgsqI7cDS2DVMNvfaNqm
         LOnBD/IscqHTTRHxI0+clnR7I7MtJsFKSnRmftmwUX9WDsHYGy3JCbi8ZzuASOeNKxvN
         3zwlzI1Lsg8ODU9JsRK0o+Mrj105/EzdsFRDCKYRigFK6nXnRLSH6W+8swv8w6IIZ21t
         yIoQbHXSuiQUxqfhpVfSgAxe4zd87/cXTnjfUxvlzRsMa6bcG9GblChEkIpSopFEyxX3
         n5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yQLsk2Tp9wfXFgh3gpmNEHc/1LVc0qNRoZDzdBhuURQ=;
        b=X2fi0yy7OZZFnKcKfsZVVIJAKkvgYn9RRTZhD8qcKR53vcWfYK4f4kHhm8RiyITOj4
         3txXvoarfo9PKQRXL/gAPO06Rwclvilqk3U9O142iymCrwXQhyxLqDEEd4RBuxDCWKJ9
         0tcCcujghogHSfTpecYgbkx3EYd9nubaS3FJcUKdOcR1hjmhqQ8hrmcZPSTkN70Elt2F
         lWHQ/AqYqNWsR04C7JCSiNiajEORBDSQcBX3znQpIcyXOdZpJB9EL61YZAG+wCI0OFzx
         izhVSv4gyf3/NeX1Dh9NLYtrZNU++/22ZltpjYtX02Qj+JDhUFG1DjFd1otz5UK9GTTY
         nXHg==
X-Gm-Message-State: AOAM531W0+BQnQbJLmhpgOPrkIuybAfKhpIYQhrejCyfg+FpSCP1eRZZ
        dMPa6pjI3rvadJAKuS0tjR4=
X-Google-Smtp-Source: ABdhPJzNqvzvMhVdlCo1/tWbfYEFMlXh88JQxyq0y9CijEHAeLnaGQDSE/InVASZ3LecfuKpQYtIQA==
X-Received: by 2002:a05:622a:49:: with SMTP id y9mr8885658qtw.0.1616169085886;
        Fri, 19 Mar 2021 08:51:25 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:41da])
        by smtp.gmail.com with ESMTPSA id m13sm4559989qkk.16.2021.03.19.08.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:51:25 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:51:22 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
Message-ID: <YFTIepcb+qm/+/9d@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
 <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk>
 <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
 <8c32421c-4bd8-ec46-f1d0-25996956f4da@kernel.dk>
 <20210318164625.1018062b042e540bd83bb08e@linux-foundation.org>
 <CALvZod6FMQQC17Zsu9xoKs=dFWaJdMC2Qk3YiDPUUQHx8teLYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6FMQQC17Zsu9xoKs=dFWaJdMC2Qk3YiDPUUQHx8teLYg@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 18, 2021 at 05:56:28PM -0700, Shakeel Butt wrote:
> 
> We need something similar for mem_cgroup_swapin_charge_page() as well.
> 
> It is better to take this series in mm tree and Jens is ok with that [1].
> 
> [1] https://lore.kernel.org/linux-next/4fea89a5-0e18-0791-18a8-4c5907b0d2c4@kernel.dk/

It sounds like there are no concerns about the loop-related work in
the patch series. I'll rebase on the mm tree and resubmit.
