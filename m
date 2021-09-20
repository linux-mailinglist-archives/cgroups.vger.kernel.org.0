Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEB2412B7E
	for <lists+cgroups@lfdr.de>; Tue, 21 Sep 2021 04:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346881AbhIUCTL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Sep 2021 22:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238942AbhIUB6N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Sep 2021 21:58:13 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F5CC1117A0;
        Mon, 20 Sep 2021 11:00:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n2so8999333plk.12;
        Mon, 20 Sep 2021 11:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GW86IGUcMDKzVGAN04j3id2pxwxU5rmCGoMKv3mUqk0=;
        b=e0saxRzRZlC8Lgq4gXik9RYBQBAyVRuu5ycCyW2wxsag+Xtqrc7kSn8fOHDDs6coKG
         pmVPv73Cfn9xw3yjS3jgFJ+xXMyJQLn4oAuOPMNCQ+2qVFqKWb0IJOlote/fUwuCsWCy
         QBdlFRYoTauNy/EpY54H5vfAuCqm8Qp21ZCTNueWiURoMBtOWm+QADbCxaBJ4gIRq/2B
         CU076jVa59LvxhtmIvLRiv1wyVUW6ahXMAQUP6WYMcpwJaFyqzn6qjwLkn1FcWErFyT7
         wt3SkTgBCL7GgOo9g6Qd4N1qhbh2fmt26TISkzrX4U3dNEE4BBvP8TBm26Wu+nwywsS1
         Bj3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=GW86IGUcMDKzVGAN04j3id2pxwxU5rmCGoMKv3mUqk0=;
        b=HUA/KmOPJ5MMWZVsNQusTD5WdQ7hUvzVHsFttZ4RftiS/4V/aAO3v+vV8DG4fyhtjw
         yefrRo1wpmUWj4i8577Nh6nRQVSwFdaN5C33ahdPJLKNQW6Wzhh4lYh3bZcr5huoOc4N
         mMcl4mWFtt9ZhfTLwjpTzzuRYOBDIspMZt2r3b199tDpVMT+6CXIvs4oNJudEcpdXOj6
         TXqtKgH7SZPWBdyxm3rWlILO7sj/inuqgLeYad+z/p5PZ2eAiP7k4nJ5McbPay80Qtgi
         2c7vFvu1vL6AQdNYt4C89P4DafAcEwog3QUYii4E/tqcuDNi1BrFXj7hpTAJrG4FuRdU
         bjVA==
X-Gm-Message-State: AOAM5305wr+I3AMabugLq+eSKv4m0Ltw3iJnLSMGah8dZVO2mIcuRM9g
        sjfVUOxgmL1eutWOPbgQxJQ=
X-Google-Smtp-Source: ABdhPJxhf47Zmb7HDBtaswZ87telUlrRy0KPi3GZv7GlqbhKvzcC6GlmeTCz/JHjOfRXR04T45h2lw==
X-Received: by 2002:a17:90a:8505:: with SMTP id l5mr279372pjn.173.1632160830447;
        Mon, 20 Sep 2021 11:00:30 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id e18sm10323849pfj.159.2021.09.20.11.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:00:30 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 20 Sep 2021 08:00:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup: Make rebind_subsystems() disable v2
 controllers all at once
Message-ID: <YUjMPK5IzG7V2MnB@slm.duckdns.org>
References: <20210918225308.23822-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918225308.23822-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Sep 18, 2021 at 06:53:08PM -0400, Waiman Long wrote:
...
> It was caused by the fact that rebind_subsystem() disables
> controllers to be rebound one by one. If more than one disabled
> controllers are originally from the default hierarchy, it means that
> cgroup_apply_control_disable() will be called multiple times for the
> same default hierarchy. A controller may be killed by css_kill() in
> the first round. In the second round, the killed controller may not be
> completely dead yet leading to the warning.
> 
> To avoid this problem, we collect all the ssid's of controllers that
> needed to be disabled from the default hierarchy and then disable them
> in one go instead of one by one.
> 
> Fixes: 334c3679ec4b ("cgroup: reimplement rebind_subsystems() using cgroup_apply_control() and friends")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-5.16.

Thanks.

-- 
tejun
