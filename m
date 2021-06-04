Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA0539B929
	for <lists+cgroups@lfdr.de>; Fri,  4 Jun 2021 14:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhFDMr0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Jun 2021 08:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDMr0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Jun 2021 08:47:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4CC06174A;
        Fri,  4 Jun 2021 05:45:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t9so354562qtw.7;
        Fri, 04 Jun 2021 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nx4sy3vKThPKrptN4SMiBtntPC6yuGT09cDORxlv+yc=;
        b=QOs7/5IzXSeBRJVY8zaGVanRYpvfw+wNNeX6TADPr1JFXUcUSD5iD0dAZI2adwPip3
         +qO2zMkh9wMFvUo+egv7LH5RPSTZ11HVCcMh0cMsVN/yDUqdfp7rMRpWmvksZVmvRAB+
         8bW8EJ461T0mcIzy/gDkyRL1xDGsmPa93cHTr4qBaNv5yIXecqsbYZKSdiIkl5j3ssM4
         E4o76gBHi1BEKYJjwM+XASMdkUZVHKSO7ZKuV6d6SLljBD+wwUYyTb2xLmMqbmMiRtRW
         z52UFs0wlzbp+zBcmKQ8/+C8x0akJCFCU4MV2OuVKTpKhvI3ODu9mL15KUZNKGTqdKua
         yjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Nx4sy3vKThPKrptN4SMiBtntPC6yuGT09cDORxlv+yc=;
        b=ZntctbSDkZ3VO0qGbtbGHT3yetk6Yr0R9iFX2UEbPyX4HzSzOUllVSDVo23OIwL3O0
         bBO1Rn6UYBU7RAUWV18/BkM1RX2RZxnkYfMjyriJQdmuXjcW2BOdYfnJ9BDcamufNAF5
         8I9mByZNehLfjtaWdRdGH3bwRzmcMnZAEfy/EyCzWJIJCFNl0nzpmXaMrb1kA+XhK152
         gw+WjN7UlhWVLhWk7f4O5kInf9NrBVlghgPSPAMd3VmUAuoqY3Rhv9BjDu2oiOpenvuH
         rV9yqAUqJfyHoHYFmRNA3mO/hH+XGUOLGyT9eSzopeJLu+b3+G0Xc1j6sqlTellyxjwH
         7D6g==
X-Gm-Message-State: AOAM5336Jk5iCiUx5By558tuef8OKJRFdI3vb/TjNp/d9MtWZW+kGq4F
        9NDBoNn9Qi6Q3eZDKYpD+To=
X-Google-Smtp-Source: ABdhPJx2XiseyJVJGjcQc4ShBR0Xc6XR53wuqdFXWkA89vMY73axIT+SbV5m1xvrv8QF3nY3EvWmjg==
X-Received: by 2002:ac8:5f8f:: with SMTP id j15mr4465156qta.116.1622810720672;
        Fri, 04 Jun 2021 05:45:20 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id f11sm3375209qtf.30.2021.06.04.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:45:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 08:45:19 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] memcg: periodically flush the memcg stats
Message-ID: <YLogX+4YSMacgbGH@slm.duckdns.org>
References: <20210604015640.2586269-1-shakeelb@google.com>
 <20210604061816.3110-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604061816.3110-1-hdanton@sina.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jun 04, 2021 at 02:18:16PM +0800, Hillf Danton wrote:
> On Thu,  3 Jun 2021 18:56:40 -0700 Shakeel Butt wrote:
> >  
> > +static void flush_memcg_stats(struct work_struct *w)
> > +{
> > +	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
> > +	schedule_delayed_work(&stats_flush, round_jiffies(2UL*HZ));
> > +}
> 
> Given flush may block, the unbound wq is what you need.
>
> 	queue_delayed_work(system_unbound_wq, &stats_flush, 2 * HZ);

Default per-cpu workqueue can block just fine. I don't see a strong reason
why this would need to be unbound.

-- 
tejun
