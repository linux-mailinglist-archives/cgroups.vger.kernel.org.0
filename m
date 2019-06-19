Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2C4B8A6
	for <lists+cgroups@lfdr.de>; Wed, 19 Jun 2019 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbfFSMeK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Jun 2019 08:34:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33846 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731750AbfFSMeK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Jun 2019 08:34:10 -0400
Received: by mail-wr1-f66.google.com with SMTP id k11so3248618wrl.1
        for <cgroups@vger.kernel.org>; Wed, 19 Jun 2019 05:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zkomWHfm2nE4Ls9LrFCC/lbq6EDt2hSMOozA/jG6M0g=;
        b=Mo37Vv3V95npvaQp1oJBaWvR1G+gbkeV9pRFIhCi/UluOgh6mXRY0PpIceQyeYRP4B
         PQzVxngahYDdME+Pjc0qxaAmPDkne2WgMjqgeo8dFU8QimOSa/t1JZMvpVtuufvPvpZ7
         qKVPr6G5M+2sMpZQXZ+zFWJe4onxv5LlngZQ1QGfszxe/YfHVyK/U8veIrNiUT8nuOc2
         dVt/+8a95Zp5etHHRk1Omywm7MtRrqP0k3X62Kr1unil6phwDuIC8xIqK+qaUwps1tS4
         JFOieWdQsp0dR44OK0bHKSQ6vSyuZ90sOBwMIhlDks9/OFFtXVPP2O42XnQpKsKv4pcH
         gudg==
X-Gm-Message-State: APjAAAWcScBS6ZsNAFd58h/feOpC0en76mZkV7ERAETdvhMrhvDlQw+r
        JR6BhN5c59E5vfj0zjAaEgc45g==
X-Google-Smtp-Source: APXvYqx7v2CxZ8iyadpYL/pvPW+etAFEjWdVabNUMX4QKPf6eO0WEPIHMZvCJedse968+c6i885NOw==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr9807590wrq.72.1560947648011;
        Wed, 19 Jun 2019 05:34:08 -0700 (PDT)
Received: from localhost.localdomain ([151.29.165.245])
        by smtp.gmail.com with ESMTPSA id 72sm13469223wrk.22.2019.06.19.05.34.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 05:34:07 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:34:05 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        lizefan@huawei.com, tj@kernel.org, bristot@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Fix cpu controller for !RT_GROUP_SCHED
Message-ID: <20190619123405.GN26005@localhost.localdomain>
References: <20190605114935.7683-1-juri.lelli@redhat.com>
 <20190605142003.GD4255@blackbody.suse.cz>
 <20190619092904.GB28937@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619092904.GB28937@blackbody.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

On 19/06/19 11:29, Michal Koutný wrote:
> On Wed, Jun 05, 2019 at 04:20:03PM +0200, Michal Koutný <mkoutny@suse.com> wrote:
> > I considered relaxing the check to non-root cgroups only, however, as
> > your example shows, it doesn't prevent reaching the avoided state by
> > other paths. I'm not that familiar with RT sched to tell whether
> > RT-priority tasks in different task_groups break any assumptions.
> So I had another look and the check is bogus.
> 
> The RT sched with !CONFIG_RT_GROUP_SCHED works only with the struct
> rt_rq embedded in the generic struct rq -- regardless of the task's
> membership in the cpu controller hierarchy.

Yep.

> Perhaps, the commit message may mention this also prevents enabling cpu
> controller on unified hierarchy (if there are any (kernel) RT tasks to
> migrate).

Sure. Can add such a comment.

> Reviewed-by: Michal Koutný <mkoutny@suse.com>

Thanks!

Peter?

Best,

Juri
