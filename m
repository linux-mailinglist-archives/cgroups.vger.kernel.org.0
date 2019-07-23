Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F257718E8
	for <lists+cgroups@lfdr.de>; Tue, 23 Jul 2019 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390009AbfGWNLE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Jul 2019 09:11:04 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33257 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfGWNLE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Jul 2019 09:11:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id f20so10186720pgj.0;
        Tue, 23 Jul 2019 06:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KoRrGXS1xcEHJmR9YK4+5JQrZ37H5yKayrFqWfL3n4M=;
        b=KD1ifaEV5p7WnRGC0HNJ+qVWuOXp5bFQDD3BHmiCOTrRHyJxCD1acj+NzS633mjANf
         qj3MMUwF3gw7MrilS8jAjZDuC1lJ0rupY9Z0lpp6AAi5ICwhVg3HpbMqIcbN61z+6b3M
         X0OSdx1umYaZLuzU5u1s8eFwEDV3W2DyznyRzNHTXOrY8eE/a+WgnDVgvAG85VKCFfp2
         TnaiRBneUcCsPFMM0Urvndy67GeHp58bOexgDUyWZQ21UogE8gRNPq45LjaV+HD8rylK
         9TU3/iAboTNbadUuAGZts7QADaQQse2f2jAdTDOFpmyBDF9OuVDyl5m8VdSzZmXl6nQg
         0izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KoRrGXS1xcEHJmR9YK4+5JQrZ37H5yKayrFqWfL3n4M=;
        b=sfUxfAP/v91gTzvwawYrSaSkdmns1A1UAgpf/MFdldOKXDKUoeBX2cYR4LIAstdDky
         vp2+UcxT2QGZ5DVPwMS8FrTlXe0bipimL21Orr0yJQA/zBp4kRgUi7N8gMEn5ocIcbRz
         PgD3i/jqs2g+iFp8BaKekmsBkaGXqUQCO6b4Bizpbps0K3X/eSflI3N+LYY2JksyJfGk
         ZXqeVGJzzoJkpcpOqpnhUJNN32attrvmQAYfhpUdTq+O4i+OyYN01mTurPesZ+tq02TT
         sbvFHEPtb4B5nvEwUkJD8qkwwsBUWvfdqN2PxZIoPp+OO9RbNhI0xhmBVtSk3gvUy5yC
         NWoA==
X-Gm-Message-State: APjAAAWkt1+7OkY7/pFI50rpxIlC6qoynxbR2lHUEF6H+V+UaPx7hwPv
        JVS6P0R3KlcdvHJbqx39F3Y=
X-Google-Smtp-Source: APXvYqwzb6pLfqRU9ygzvK1kQJaAjVjQM+ULK7S5gnddMHI0dWUkHB4n6nwrMEs098be0obvSEydLg==
X-Received: by 2002:a62:3445:: with SMTP id b66mr5757105pfa.246.1563887463426;
        Tue, 23 Jul 2019 06:11:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:2287])
        by smtp.gmail.com with ESMTPSA id r75sm59223117pfc.18.2019.07.23.06.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 06:11:02 -0700 (PDT)
Date:   Tue, 23 Jul 2019 06:11:00 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com, longman@redhat.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 2/8] sched/core: Streamlining calls to task_rq_unlock()
Message-ID: <20190723131100.GE696309@devbig004.ftw2.facebook.com>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-3-juri.lelli@redhat.com>
 <50f00347-ffb3-285c-5a7d-3a9c5f813950@arm.com>
 <20190722083214.GF25636@localhost.localdomain>
 <20190723103131.GB3402@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723103131.GB3402@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 23, 2019 at 12:31:31PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 22, 2019 at 10:32:14AM +0200, Juri Lelli wrote:
> 
> > Thanks for reporting. The set is based on cgroup/for-next (as of last
> > week), though. I can of course rebase on tip/sched/core or mainline if
> > needed.
> 
> TJ; I would like to take these patches through the scheduler tree if you
> don't mind. Afaict there's no real conflict vs cgroup/for-next (I
> applied the patches and then did a pull of cgroup/for-next which
> finished without complaints).

Yeah, for sure, please go ahead.

Thanks.

-- 
tejun
