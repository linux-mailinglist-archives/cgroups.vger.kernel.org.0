Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB4076ABE1
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2019 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfGPPgh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Jul 2019 11:36:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37559 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbfGPPgg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Jul 2019 11:36:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id g15so9632189pgi.4;
        Tue, 16 Jul 2019 08:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rkr1cM2tkiVjVeg3QaVTaa27A8PkbBvry/gW4kLkkZo=;
        b=QPXD/nW75d/To43UoaPRd46yJMqyRqYx84yCkV48ArLvUhJsr81fCDsaOReW/mntY4
         RoUEInISzJzFjjgiiNXOa/dFxR7Hzb8s9QWuJEXbDpAjuUW8qLSOa3vp4DB2Du7ikDQx
         kdo3OcgremMaklw/9W7tJleL438pee+faQN3g7CyoM/kHu0ijiYHegsvSSzASOp2/+LL
         bHrQXIPE9qoKfDbqjX+9GC1V1nPuLxGcNXYcNTRg892CVHTum+xRz/WOyDmpD9br0oYT
         o8XwOp8uuAu3ggxnWxmjeLqw+A7zojyphIG3Z2MqJ6olNNctQKECDqK4AOufZ0WUHwvf
         ANng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rkr1cM2tkiVjVeg3QaVTaa27A8PkbBvry/gW4kLkkZo=;
        b=chEVVX6LWzXfTJvu/TDufFD08ERd8qi8y+w1tk2Z78VotgW6QBEhuemAM6Kxmc6KEj
         plauadxiZgGqxFMyLh3Lnd23ZtlLDYgU4Leuk7NsR4RQRuuGL3h3SjmIC/XJ0/ebYlV5
         AI4XTHR+QvdcK4YQf1Ov+NCntOSdJ/sd4ZuEbXV6sPfgWYm/zbWbe4jGBW0W0vbu1hc+
         EWFvocHJpWCL59vKWaHiie1ssDgOSv+74qkChmn+AG/614vx27qmGmE/yHkUEFLNA23j
         MURI41cdRjR/o23Kb9puX/3VW4McDpvGRdRND6vq2je1JKtDBLulS+dkLS3qLLom7wcl
         9rAw==
X-Gm-Message-State: APjAAAXjylL0XjdxK63d7KB9gnVieQ/EpDygHrj9VPWSLN2XSibir/oW
        0TA0aQEyAMtKGu53HRF506o=
X-Google-Smtp-Source: APXvYqxqjICYy2wgQAyfVEsWbMRZ2XhKMky42PgJKXXhPuTAwsdNMpyVPxKFiAlYvIxBfC5n1IkO+Q==
X-Received: by 2002:a17:90a:26ea:: with SMTP id m97mr37461305pje.59.1563291395785;
        Tue, 16 Jul 2019 08:36:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:4779])
        by smtp.gmail.com with ESMTPSA id m31sm25660642pjb.6.2019.07.16.08.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 08:36:35 -0700 (PDT)
Date:   Tue, 16 Jul 2019 08:36:33 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org, Prateek Sood <prsood@codeaurora.org>
Subject: Re: [PATCH v8 6/8] cgroup/cpuset: Change cpuset_rwsem and hotplug
 lock order
Message-ID: <20190716153633.GA696309@devbig004.ftw2.facebook.com>
References: <20190628080618.522-1-juri.lelli@redhat.com>
 <20190628080618.522-7-juri.lelli@redhat.com>
 <20190628130308.GU3419@hirez.programming.kicks-ass.net>
 <20190701065233.GA26005@localhost.localdomain>
 <20190701082731.GP3402@hirez.programming.kicks-ass.net>
 <20190701145107.GY657710@devbig004.ftw2.facebook.com>
 <20190704084924.GC9099@localhost.localdomain>
 <20190712140409.GB13885@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712140409.GB13885@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 12, 2019 at 04:04:09PM +0200, Juri Lelli wrote:
> > Should I take this as an indication that you had a look at the set and
> > (apart from Peter's comments) you are OK with them?
> > 
> > If that's the case I will send a v9 out soon. Otherwise I'd kindly ask
> > you to please have a look.
> 
> Gentle ping.

Sorry about the late response.  Yes, I have no objection to the change
but can you please cc Waiman Long on the next round?

Thanks.

-- 
tejun
