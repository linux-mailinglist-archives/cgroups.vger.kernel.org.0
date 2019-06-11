Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BF83D734
	for <lists+cgroups@lfdr.de>; Tue, 11 Jun 2019 21:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405490AbfFKTwO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jun 2019 15:52:14 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:33231 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405039AbfFKTwO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jun 2019 15:52:14 -0400
Received: by mail-pl1-f175.google.com with SMTP id g21so5580039plq.0;
        Tue, 11 Jun 2019 12:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cHQwQdsrkTpqJAyug+FT0E9rG91BoWa0X7Lnvcu63U0=;
        b=sf4Wv0oOKP6ccpJ9YkQOGUDhSjYMBG+KudnxXTcqLAYPTss2vsI1fbeHmcwPPphcXk
         eATLNIRLct9/VRTkALmNlWMYfZd4ArOl2dDKv2RD398ontULghP25qT50pgbWNv4RPRF
         77gUEK//iTYsdIcrlUK0eU8HjK4D6OkpZM4MQ+WSPhskB0w41UOsJhrx8kG0Sn5KXqpg
         W30qKAytIPB0KJaNA2/a92tHIIvpb7rkfdOzP2u/VtulBlUvKeF5aRsPWlUK4K9CTGn2
         50YrHtyYEwlfXxS0bAkqes8kZlPigVckJQmBPYD/bHVUi4pGGlu4cvhg22lMAOvYaJt0
         lHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cHQwQdsrkTpqJAyug+FT0E9rG91BoWa0X7Lnvcu63U0=;
        b=LNHBBXb4OIglVDkIc11t3Z2Kq5sg/xnML8Ds5skZnVguwuVE9XsAAjuR1y+SZwOCSg
         8J+4E7voiM/HYiKcei1zrtm0REK3k7TihYnYVpJcvWAi7o4Xg4/PzUKHhhz6S0CjkWAA
         WEHmAIqGTEXSmuw9DgfMa4Ybfv0rVFN0Op0CQjziOEYABX3HUvGI/+sRF+/JAF1fK2kq
         3/IwhyFk8hYxE9JXbaIdNYZiWQT69BpHjQdJYOFzj+TvvseIrbID7HiKoEpsZboAbtIu
         Tt/enagBPidZrxEJ9SOI8B0Y9dIjeyc+5Pc+FsL6ZwlQZ5CbSyPOyxmmzqRPuf/61w4l
         MtdA==
X-Gm-Message-State: APjAAAUk2FFtwNnKCanztpHT85FZqOP6RyDrDT+2wf9oQ9S7CGJIzr0x
        dirtrBkJPUvuE0hUp8AoXBA=
X-Google-Smtp-Source: APXvYqwtr7AdbQtXCjzK5M7+YTkrqbJhHbXBQ3iF70ArYweFUb7ISFWWhnZBb2Wk9bDXh3r0GQsgfw==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr52750895pls.278.1560282733634;
        Tue, 11 Jun 2019 12:52:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:1677])
        by smtp.gmail.com with ESMTPSA id d4sm18814972pfc.149.2019.06.11.12.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 12:52:12 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:52:10 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>, hannes@cmpxchg.org,
        jiangshanlai@gmail.com, lizefan@huawei.com, bsd@redhat.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        juri.lelli@redhat.com, mhocko@kernel.org, peterz@infradead.org,
        steven.sistare@oracle.com, tglx@linutronix.de,
        tom.hromatka@oracle.com, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC v2 0/5] cgroup-aware unbound workqueues
Message-ID: <20190611195210.GK3341036@devbig004.ftw2.facebook.com>
References: <20190605133650.28545-1-daniel.m.jordan@oracle.com>
 <20190605135319.GK374014@devbig004.ftw2.facebook.com>
 <20190606061525.GD23056@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606061525.GD23056@rapoport-lnx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Jun 06, 2019 at 09:15:26AM +0300, Mike Rapoport wrote:
> > Can you please go into more details on the use cases?
> 
> If I remember correctly, the original Bandan's work was about using
> workqueues instead of kthreads in vhost. 

For vhosts, I think it might be better to stick with kthread or
kthread_worker given that they can consume lots of cpu cycles over a
long period of time and we want to keep persistent track of scheduling
states.

Thanks.

-- 
tejun
