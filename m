Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7117A127658
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2019 08:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfLTHNh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Dec 2019 02:13:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45464 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfLTHNh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Dec 2019 02:13:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so8309245wrj.12;
        Thu, 19 Dec 2019 23:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOQzWpHfx4pdEUl4NggtZJqU0xFxHqL/b5XZR3ZC39E=;
        b=QkGVKx++/WV6H4PtmjKdkwN4r8XbhV9bLtp6el9zG87BCvk5DoWsjDhTEFV5beMA8m
         LlOvVMuzWcxKCQv55Gv0rx9sYHQC6bpIZtfhTtBoFaEzRpcAKXg73PpNUbH+lNmpJOeL
         Z/eB//GPeKU/fuXX6XOod/hyCb1wzssu21pH6byoydZQm0hmA9PygZOoBRVjfP3oHuc3
         nubRBDhGb4CQtGpoEc948GLFBb6ZOI0UfYM5IfUicJho+FQrDZVdJPC0gJDYLxboZkz+
         P0ZrFAOofGhKbALH81zsPwjn1RyOguKxLCDZEtxudLFl8vlRoTJnGh1EoXTLsR7Gvh5J
         w+6g==
X-Gm-Message-State: APjAAAXxQkJ2Bb4F2HNrer0N+buuIof3L4PqFiYjfg9dIDz7EfBJldkR
        eAIBN3t0y03IGFcUBpeOkXGdF83n
X-Google-Smtp-Source: APXvYqw7CXurc2quSgaz5A798GccKKbvTrl6mO4b61Y+BCiP1i/FuiRxu1BeUhnZUrnAQZU6IO1TwQ==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr13025777wrq.332.1576826015587;
        Thu, 19 Dec 2019 23:13:35 -0800 (PST)
Received: from localhost (ip-37-188-150-151.eurotel.cz. [37.188.150.151])
        by smtp.gmail.com with ESMTPSA id g7sm8987211wrq.21.2019.12.19.23.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 23:13:34 -0800 (PST)
Date:   Fri, 20 Dec 2019 08:13:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     zgpeng.linux@gmail.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, shakeelb@google.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        zgpeng <zgpeng@tencent.com>
Subject: Re: [PATCH] oom: choose a more suitable process to kill while all
 processes are not killable
Message-ID: <20191220071334.GB20332@dhcp22.suse.cz>
References: <1576823172-25943-1-git-send-email-zgpeng.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576823172-25943-1-git-send-email-zgpeng.linux@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 20-12-19 14:26:12, zgpeng.linux@gmail.com wrote:
> From: zgpeng <zgpeng@tencent.com>
> 
> It has been found in multiple business scenarios that when a oom occurs
> in a cgroup, the process that consumes the most memory in the cgroup is 
> not killed first. Analysis of the reasons found that each process in the
> cgroup oom_score_adj is set to -998, oom_badness in the calculation of 
> points, if points is negative, uniformly set it to 1.

Can you provide an example of the oom report?
-- 
Michal Hocko
SUSE Labs
