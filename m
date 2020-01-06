Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094CA1312C5
	for <lists+cgroups@lfdr.de>; Mon,  6 Jan 2020 14:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgAFNYk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jan 2020 08:24:40 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:37975 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAFNYk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Jan 2020 08:24:40 -0500
Received: by mail-wm1-f45.google.com with SMTP id u2so15234111wmc.3
        for <cgroups@vger.kernel.org>; Mon, 06 Jan 2020 05:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wC9BOXYjk4udfBrvJm6JGmvN7DTg2mdl9SY6BiiM5CI=;
        b=P8pk1o9y6+tG5KTqZ9qfFyt85i2CdbvG8XOjpzH+VC1HkPFsLurbZEyYmkqNh4UWcL
         Eux3W369x5DtVrAYs80Bc1RAmUy6R70BJT8sQX3DdDeJZ0mV0VAsZwbqETyluYbf+uTl
         koNyRRhxh4i5PhdlCabKLdZQ3LgVHGQS9sW0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wC9BOXYjk4udfBrvJm6JGmvN7DTg2mdl9SY6BiiM5CI=;
        b=i5C212uJ44ikFI9YQJnz9y2ZfJD1XfHg+72QEJ6HNcG90xOnPCc1UA2AL2HY5Q35Bz
         XcQKJiyZtiZxskKkCMrHDt2hNkBCOTMqcnJGSrMwsxg1fzYbnrTJBASswcFKC9sNIQp3
         XWbBnK/XvkWAHN4nje7W5aQDlIfz4ZP9Idj7S0VZtE7GAAWm0LkcDXFfrrD2ianrTvCN
         QV+pAIMIB4ndE5l5U61LcwZA5fLSGPRYNJ7FM2UvCz8H31kxXggui6Zi/fy/AHN3GJpu
         6T7lNU++qfoqtjDVFdn49lrphDPnAD7yXQwkp5H7RTY3gqGUMizU4ny2ZsGdqQkHgjJC
         okow==
X-Gm-Message-State: APjAAAW0ROTFTuUl+eZgGIG8YVy4bN6UxjgOn50/VNHImU9mUGp+3E8g
        3SZS3ks+tvRVEV7Q29zADChRRg==
X-Google-Smtp-Source: APXvYqxiB5J5yZSQ8qnPvaI29s4X3LKS+PySqiuL7STuXEvvcVUEmF6Z+6C0eNwuDiq3exnvuiyqIg==
X-Received: by 2002:a1c:6a07:: with SMTP id f7mr35558851wmc.171.1578317077752;
        Mon, 06 Jan 2020 05:24:37 -0800 (PST)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id b137sm23689296wme.26.2020.01.06.05.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 05:24:37 -0800 (PST)
Date:   Mon, 6 Jan 2020 13:24:36 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Hui Zhu <teawater@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC] memcg: Add swappiness to cgroup2
Message-ID: <20200106132436.GC361303@chrisdown.name>
References: <1577252208-32419-1-git-send-email-teawater@gmail.com>
 <20191225140546.GA311630@chrisdown.name>
 <20200106131020.GC9198@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200106131020.GC9198@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>I am not really sure I agree here though. Swappiness has been
>traditionally more about workload because it has been believed that it
>is a preference of the workload whether the anonymous or disk based
>memory is more important. Whether this is a good interface is debatable
>of course but time has shown that it is extremely hard to tune.

Sure, it can theoretically be hardware- and workload-specific -- I don't think 
we disagree here. The reason I suggest it's a generally hardware-specific 
tunable rather than a workload-specific tunable is it's pretty rare to see 
anyone who's meaningfully used it for workload-specific tuning :-)
