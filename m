Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC5D77C5
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 15:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbfJONxx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 09:53:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38245 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732239AbfJONxx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Oct 2019 09:53:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so30641476qta.5
        for <cgroups@vger.kernel.org>; Tue, 15 Oct 2019 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rdFD1ySM7snbTlYVusRsUK5w8tupUNVkhhCAYZ7l2Pc=;
        b=y5eyFIzUZPf7JNQjTnetQoWn3BAyiwEjxA5Z4qE2NKrnEC5SXIMN2+3NTw9lnNtQpl
         8jXl1nYoG97Myed+YXA4VidWTzzkb728WjXDdyiTxMAnQnJCgfOxgYm+hXr813ku/ApS
         D/V/R44Njsqn3oEV6/kJ7kxFhqWh4qQzvA/G0IpIq0MYI9ymag/1KcZjH4FecF15gYer
         FWTe0oBPGVvjex692yOemBosnoB8ax+5iL9DTQF+3g1QQvhV+wm+0euRJZqpsxIc5fHh
         t7R60n9eCfBoflqA7J0pr4mOMAlD6cCJW5kjSZJkYio+WNor05cV2ad46SLhRD6o/TXk
         48kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rdFD1ySM7snbTlYVusRsUK5w8tupUNVkhhCAYZ7l2Pc=;
        b=AzQupjMoBLcb8VLuxca8OVIMH4OOuubblj4068xPvojowm7c8RN2DAmi2FY3/x59dA
         MkeNdJkUme9JAxFgnjowk6d/Dry32FQAfbQVatl2/OplcDG9hb9iFPoKCL3BxqGDow5q
         MjuUvpSrg4Y2+I7TLvV7NiUuJGg6bANtnyZFDOwsTqRFbWGpRCy1zs2R25m0TDDFBXf1
         zNx0plZqrIqHHtlfAlnwmMj2A7ekcJT0MlyItbT0bJ/ZvY3UC1oH6sm+RREwik9HpHTV
         1Tsz+HjiEmzbhPtasCV/qEaYcRSkBOrSrpatvhTNJYGw50VPOg/PbhsVGyjGI18iMogQ
         Cs+Q==
X-Gm-Message-State: APjAAAVdqSE+zlKUJVWAOAwFRVF2i7cl5o/lkCcACXFSj3oBUU3k1Cc5
        Ep1Ei8uED069N0QVy7MS/ZEZPg==
X-Google-Smtp-Source: APXvYqyhlPRXzOnBK2H9VoOhhErMUW+uFAJUl6CEm6oB8pyKripwSp26aw+YsSeqMP5Lxhsfcz7ugA==
X-Received: by 2002:a0c:b068:: with SMTP id l37mr28886665qvc.36.1571147630166;
        Tue, 15 Oct 2019 06:53:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:d056])
        by smtp.gmail.com with ESMTPSA id t17sm14675129qtt.57.2019.10.15.06.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 06:53:49 -0700 (PDT)
Date:   Tue, 15 Oct 2019 09:53:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: [PATCH] mm/memcontrol: update lruvec counters in
 mem_cgroup_move_account
Message-ID: <20191015135348.GA139269@cmpxchg.org>
References: <157112699975.7360.1062614888388489788.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157112699975.7360.1062614888388489788.stgit@buzz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 15, 2019 at 11:09:59AM +0300, Konstantin Khlebnikov wrote:
> Mapped, dirty and writeback pages are also counted in per-lruvec stats.
> These counters needs update when page is moved between cgroups.
> 
> Fixes: 00f3ca2c2d66 ("mm: memcontrol: per-lruvec stats infrastructure")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Please mention in the changelog that currently is nobody *consuming*
the lruvec versions of these counters and that there is no
user-visible effect. Thanks
