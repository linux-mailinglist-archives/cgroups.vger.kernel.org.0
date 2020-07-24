Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DADD22C468
	for <lists+cgroups@lfdr.de>; Fri, 24 Jul 2020 13:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGXLfe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jul 2020 07:35:34 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:41232 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXLfe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Jul 2020 07:35:34 -0400
Received: by mail-ed1-f50.google.com with SMTP id c2so951990edx.8;
        Fri, 24 Jul 2020 04:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vQEzWbMpqfBFFfZHk6MrbUvuK+Pg0nDtdn7/73b59ek=;
        b=ULMgnHJCc9ndYrczgcWu7HjaK1D2z6n0a0uNhxY0e/ujxrbw2dVLCiKyQPAHrnZLKz
         sFr4Fg7E3KcTdVYDmCHMmG+4x5cCeFQG9bYc89mLAFfSjtTzPqWJpTjXUhK7ZvMmKV11
         VHIZIZ3Tv121JUq2xLU1cY5oFul4LbCQajzelPnSgI/KOftQIfaE91SZssdqE4jonu7q
         3ME0GCJlzrDpl96FCaKp+vn0WqNTt4pNJVPvFE+d0XyiDqvrP17V+YAh4kvDC8rJUMMY
         7/uyaYxA0griyV8PGw5w+Sxw23SlD77+oiCwK26fDeE19ZPR2C0wYjITIDfUUTxsgkiL
         pp4w==
X-Gm-Message-State: AOAM530r6AdGulB9YfhCxeVAqES1MPvxFVxQY4pk9UofipsECXTlO7Yy
        j5ktalLhouJXTVIl26CqI5c=
X-Google-Smtp-Source: ABdhPJxZeRaF8wBVp/96IA7pcovFXsVEdMc8azrBIuC+gEhhLihno21Zmwh3HzkLSdPLz8P7ONNtPA==
X-Received: by 2002:aa7:d90f:: with SMTP id a15mr8235565edr.86.1595590532568;
        Fri, 24 Jul 2020 04:35:32 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id by20sm499447ejc.119.2020.07.24.04.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 04:35:31 -0700 (PDT)
Date:   Fri, 24 Jul 2020 13:35:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     jingrui <jingrui@huawei.com>
Cc:     "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiBQUk9CTEVNOiBjZ3Jv?= =?utf-8?Q?up?= cost too
 much memory when transfer small files to tmpfs
Message-ID: <20200724113530.GH4061@dhcp22.suse.cz>
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
 <20200724075508.GF4061@dhcp22.suse.cz>
 <2E04DD7753BE0E4ABABF0B664610AD6F2620D4F6@dggeml528-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E04DD7753BE0E4ABABF0B664610AD6F2620D4F6@dggeml528-mbx.china.huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 24-07-20 09:35:26, jingrui wrote:
> 
> On Friday, July 24, 2020 3:55 PM, Michal Hocko wrote:
> 
> > What is the reason to run under !root cgroup in those sessions if you do not care about accounting anyway? 
> 
> The systemd not support run those sessions under root cgroup, disable
> pam-systemd will not create session/cgroup, but this is not safe and make
> systemd-logind not work.

Could you be more specific please?
-- 
Michal Hocko
SUSE Labs
