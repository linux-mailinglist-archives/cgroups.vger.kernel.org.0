Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 841CB5F4F0
	for <lists+cgroups@lfdr.de>; Thu,  4 Jul 2019 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfGDIta (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Jul 2019 04:49:30 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55095 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfGDIta (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Jul 2019 04:49:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so1851173wme.4
        for <cgroups@vger.kernel.org>; Thu, 04 Jul 2019 01:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AB76fZ4FGkqviuGc5asXXE0TYmR4RcAuqGDgezPIa0I=;
        b=HHg3wRA68na99kAyx9FJkUtrWVwESlV7iqLoDuHihj6EpkL6Tss/+YoG+rGfJyhPf2
         PtYVtO3F+O42TonTgZtRUAxbXcTeYRSMiYryjpvO+njWZB5LWQ++LQdX5NeMdpOXDImU
         Ba2ryCJ1eU+gYtmnNndqLjmJrRNdEBkVERh/YBUanqZrl6c/laqTnfqaySQ1GFJJGMnI
         xGiDG0pX/cIoOWQrHbfXA9hwtLF7j9wZqy9qmOna5DXOBt69saHPTCpwdj5krJF1GeSu
         9qxNYtzTi+XbMxJbQgiyUWD8YPGBPQ3yRc1LH18sXmZ7LqEELQsyRMC9Er348QDU1CsS
         rtxA==
X-Gm-Message-State: APjAAAXBN8ypb1A3vNlYXuSivHDVP+pPvvynu34YW/eJgMOx/YtCZwqe
        4vtDRMVx0emleGycB3BA6JkUd7RHhYc=
X-Google-Smtp-Source: APXvYqz1Q1DleGiXZJyelc0x4oeE2RpsSdPwidTtNcDiqfLPQI8czdr7RR9RMZcY1fHcuY/QWxxFUg==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr11850426wme.177.1562230168039;
        Thu, 04 Jul 2019 01:49:28 -0700 (PDT)
Received: from localhost.localdomain ([151.15.230.231])
        by smtp.gmail.com with ESMTPSA id p11sm5493523wrm.53.2019.07.04.01.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 01:49:26 -0700 (PDT)
Date:   Thu, 4 Jul 2019 10:49:24 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>
Subject: Re: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Message-ID: <20190704084924.GC9099@localhost.localdomain>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-7-juri.lelli@redhat.com>
 <20190628130308.GU3419@hirez.programming.kicks-ass.net>
 <20190701065233.GA26005@localhost.localdomain>
 <20190701082731.GP3402@hirez.programming.kicks-ass.net>
 <20190701145107.GY657710@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701145107.GY657710@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 01/07/19 07:51, Tejun Heo wrote:
> Hello,
> 
> On Mon, Jul 01, 2019 at 10:27:31AM +0200, Peter Zijlstra wrote:
> > IIRC TJ figured it wasn't strictly required to fix the lock invertion at
> > that time and they sorted it differently. If I (re)read the thread
> > correctly the other day, he didn't have fundamental objections against
> > it, but wanted the simpler fix.
> 
> Yeah I've got no objections to the change itself, it just wasn't
> needed at the time.  We've had multiple issues there tho, so please
> keep an eye open after the changes get merged.

Should I take this as an indication that you had a look at the set and
(apart from Peter's comments) you are OK with them?

If that's the case I will send a v9 out soon. Otherwise I'd kindly ask
you to please have a look.

Thanks!

Juri
