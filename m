Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C75D6F3627
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 18:48:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbfKGRsN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 12:48:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38131 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbfKGRsI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 12:48:08 -0500
Received: by mail-pg1-f194.google.com with SMTP id 15so2513549pgh.5
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2019 09:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YQHzfatweJlvu9QRgWqn6mLupzORKF19rwgbns+H/Ko=;
        b=G8fRkvwVCgK+5AnZZD/V83YvXyFilTUx9GafaEg/RlOfkWwhafnHdqdNeGKXLF/H6K
         FDoIV9FDSYGiZwaMLLnBtT4HOWe9rvBSeoXdkoOt977x30UGwRbKIQD62Y3e0SHPGkJE
         zj18IxkktF05wkCUiif3Tune+pTbQR19EfTWV8nDz4Wk+HvNaFZ82cJrX2VmWcejNZCG
         /iA/y8UqcJOl8F5Lh91S8tMoq40Go993jzHkeaTYmeYHGrX9dqqW6SRh5BZnroMcF8Jn
         BD77+M4HBjqEt44AKkO6oPWfH6+/na5b+Omr1i/uNPazTemCNSqER5sX4i6vu+vqbhQq
         hrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YQHzfatweJlvu9QRgWqn6mLupzORKF19rwgbns+H/Ko=;
        b=RR6KDfTiCHQ6kPBraYHur4+orzJSnPsgchKRfxdBkxMzfh/NWSmef7xKt0dTQ521iH
         RSO/zevBNb0C8bEYkFdWH1AHWwSuXAVZRHL4RZGRCZNZLqJS7WT6OYZvCPm42+885Bq4
         jhgDW4rUF+lNWux1++hkEjd9aHpHXCEtLm0TY0p1sx73pKSqtKkKegI2RZCSagfRg2wM
         9mrq72edVVoM6mYAOecPgGf8jtx34XWW45grd+kiSL5gloWO45Yy69PUw5POz2JHtidN
         oFQKJTG97//eMktIbKdpOK6QC/rdFvfiDlafeq7wWvBF9H9NXDygZ0NLDGaOYLQWzTkt
         guNw==
X-Gm-Message-State: APjAAAWgYrpfj5mTIlG705GU9uyXpiYO3tkCCuGvj+cGMOflSFtO+dAe
        54d8vrdPEgyJ907RrulLxUIS+w==
X-Google-Smtp-Source: APXvYqzAqvPs1jX+juk9qWnYhY1RhnF/vPkdqQeAI9VIRBxgjUBTjIXOsZmOImIrN/73qLNmV/iXGQ==
X-Received: by 2002:a63:6f47:: with SMTP id k68mr5759534pgc.92.1573148887304;
        Thu, 07 Nov 2019 09:48:07 -0800 (PST)
Received: from localhost ([199.201.64.133])
        by smtp.gmail.com with ESMTPSA id t12sm3323606pgv.45.2019.11.07.09.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 09:48:06 -0800 (PST)
Date:   Thu, 7 Nov 2019 09:45:55 -0800
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 00/11] mm: fix page aging across multiple cgroups
Message-ID: <20191107174555.GA116752@cmpxchg.org>
References: <20190603210746.15800-1-hannes@cmpxchg.org>
 <CALvZod7821vuP_KcOKZkzKu-6b_kzDPrximi3E-Ld95fd=zbMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7821vuP_KcOKZkzKu-6b_kzDPrximi3E-Ld95fd=zbMg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 06, 2019 at 06:50:25PM -0800, Shakeel Butt wrote:
> On Mon, Jun 3, 2019 at 2:59 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > When applications are put into unconfigured cgroups for memory
> > accounting purposes, the cgrouping itself should not change the
> > behavior of the page reclaim code. We expect the VM to reclaim the
> > coldest pages in the system. But right now the VM can reclaim hot
> > pages in one cgroup while there is eligible cold cache in others.
> >
> > This is because one part of the reclaim algorithm isn't truly cgroup
> > hierarchy aware: the inactive/active list balancing. That is the part
> > that is supposed to protect hot cache data from one-off streaming IO.
> >
> > The recursive cgroup reclaim scheme will scan and rotate the physical
> > LRU lists of each eligible cgroup at the same rate in a round-robin
> > fashion, thereby establishing a relative order among the pages of all
> > those cgroups. However, the inactive/active balancing decisions are
> > made locally within each cgroup, so when a cgroup is running low on
> > cold pages, its hot pages will get reclaimed - even when sibling
> > cgroups have plenty of cold cache eligible in the same reclaim run.
> >
> > For example:
> >
> >    [root@ham ~]# head -n1 /proc/meminfo
> >    MemTotal:        1016336 kB
> >
> >    [root@ham ~]# ./reclaimtest2.sh
> >    Establishing 50M active files in cgroup A...
> >    Hot pages cached: 12800/12800 workingset-a
> >    Linearly scanning through 18G of file data in cgroup B:
> >    real    0m4.269s
> >    user    0m0.051s
> >    sys     0m4.182s
> >    Hot pages cached: 134/12800 workingset-a
> >
> 
> Can you share reclaimtest2.sh as well? Maybe a selftest to
> monitor/test future changes.

I wish it were more portable, but it really only does what it says in
the log output, in a pretty hacky way, with all parameters hard-coded
to my test environment:

---

#!/bin/bash

# this should protect workingset-a from workingset-b

set -e
#set -x

echo Establishing 50M active files in cgroup A...
rmdir /cgroup/workingset-a 2>/dev/null || true
mkdir /cgroup/workingset-a
echo $$ > /cgroup/workingset-a/cgroup.procs
rm -f workingset-a
dd of=workingset-a bs=1M count=0 seek=50 2>/dev/null >/dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
cat workingset-a > /dev/null
echo -n "Hot pages cached: "
./mincore workingset-a

echo -n Linearly scanning through 2G of file data cgroup B:
rmdir /cgroup/workingset-b >/dev/null || true
mkdir /cgroup/workingset-b
echo $$ > /cgroup/workingset-b/cgroup.procs
rm -f workingset-b
dd of=workingset-b bs=1M count=0 seek=2048 2>/dev/null >/dev/null
time (
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null
  cat workingset-b > /dev/null )
echo -n "Hot pages cached: "
./mincore workingset-a
