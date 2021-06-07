Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909BB39DDC7
	for <lists+cgroups@lfdr.de>; Mon,  7 Jun 2021 15:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhFGNjm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Jun 2021 09:39:42 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:46684 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGNjm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Jun 2021 09:39:42 -0400
Received: by mail-qv1-f48.google.com with SMTP id w9so8780433qvi.13
        for <cgroups@vger.kernel.org>; Mon, 07 Jun 2021 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uged.al; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igiYe7SwyKBt7A5QKk3rIAjajnn7ad4fy0OWQQgiPI4=;
        b=AL0ARjGG2d5UzLScoqRAbXYinCmVuWXQBcHoLRgl5VkHuKhtrwKqmto+JNVUYgKPl2
         b3k4tNPWnwv4RcbyMRhhfOdEm01keBZ51WwEy3xtnoGWJHdy0O9oVdSCYKB9gJalztcE
         1O17QCIDR4emE/ABvZa7F4Pk6t48ADo7f1xfiGv8qs/T5cpIWZlrxkMA5GxlvBrTWGM9
         rljNNoAyIx9MkJQ75F6YKWrBtHge3WmRDRtPJ9xyNH6bSTE4P+sjkFPsXDjcZH35ArlB
         4T+hETApzFiQSXxIXIyMMdJXcT5Oa1Db+FDW7mQa13hipnaroVt4L8oh7MhuQxDfEgyH
         4MZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igiYe7SwyKBt7A5QKk3rIAjajnn7ad4fy0OWQQgiPI4=;
        b=Mbzr/U9c82kt0UNnHgdtqit2CVXUWFY+UDlvypeHCW9yjE0KxuRrw5iIVChJVA8dWs
         P7BpyXCTwv732Cj5kqwMEITLZ4rhnYGKAOtW9WaqpRZLjbjgp+NbgV1zxolFW52/ECXL
         ekk+dq3yGJjlcnACPG0IZzYii4PQOFty5Y2t32raN7HnsfDJWMbe+44gXcE8RPd1L3uk
         cZmJMrXP9WlvVxqvRyqbnwmSoTvcUPMf35rUcw9Rc2m+bIdsUy/ZEkErQqkLJC0wrg3D
         frc8vCeifA53c2rNqBVhmI3uok0jqqB/+MKnDf7QKegc4RXOEe0O728+CD7r9dRovG/F
         TIOQ==
X-Gm-Message-State: AOAM532eD5LZtvm+ocmXf217Q+tJ5kDg0mqdvGwiRuC5ErwcZwp5tQaj
        tD7awnsGQwdc2nTyPg7f7zRivnPTXaPcdklR6YiLfQ==
X-Google-Smtp-Source: ABdhPJxFAkP9Wrb9vGOGQ6bJTtZQhPUtesD4SeHIY7iDN560TIEUUvDnhf/P/AaRfgHMP2UWNREA0Y6d103uy9WzAeg=
X-Received: by 2002:a0c:eac3:: with SMTP id y3mr18247355qvp.9.1623073010586;
 Mon, 07 Jun 2021 06:36:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210604102314.697749-1-odin@uged.al> <CAKfTPtDHrD_QGoLeUkR0ALRakWH+KOopHZk=29fyi-oonerd9g@mail.gmail.com>
In-Reply-To: <CAKfTPtDHrD_QGoLeUkR0ALRakWH+KOopHZk=29fyi-oonerd9g@mail.gmail.com>
From:   Odin Ugedal <odin@uged.al>
Date:   Mon, 7 Jun 2021 15:36:12 +0200
Message-ID: <CAFpoUr1vta7F7PhzsTazqwrehhiySmD71veOxTo=PTBrGhpvLg@mail.gmail.com>
Subject: Re: [PATCH v4] sched/fair: Correctly insert cfs_rq's to list on unthrottle
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Odin Ugedal <odin@uged.al>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> It's not the best place for this function:
> - pelt.h header file is included below but cfs_rq_is_decayed() uses PELT
> - CONFIG_SMP is already defined few lines below
> - cfs_rq_is_decayed() is only used with CONFIG_FAIR_GROUP_SCHED and
> now with CONFIG_CFS_BANDWIDTH which depends on the former
>
> so moving cfs_rq_is_decayed() just above update_tg_load_avg() with
> other functions used for propagating and updating tg load seems a
> better place

Ack. When looking at it now, your suggestion makes more sense. Will fix it.

Thanks
Odin
