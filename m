Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A29C2A408C
	for <lists+cgroups@lfdr.de>; Sat, 31 Aug 2019 00:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbfH3W1m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Aug 2019 18:27:42 -0400
Received: from mx6.ucr.edu ([138.23.62.71]:44566 "EHLO mx6.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfH3W1m (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 30 Aug 2019 18:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567204062; x=1598740062;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=+AxKleiBOotn72mRXxY/KudOmnLMJMiIcrvaqwrtHdw=;
  b=LH0KFHNWRNvzX+riE6BAiviAIpghckehNEMgFmrch/5vCQ9uxXvjelON
   lQfmJbaWEXTZe7fPJz6QZ8RzovXF3D+PQ7/3ZVn75WftiNYwGv4yoE7zo
   5DC647mr9M/30oLNQQq8d/etq3lKxVjDhxrb+EQoUhUDyK8AT0scdnFAY
   YT3bxXTP0PEJ3nn5PID2xZUwEDogOLjPwLgDJ28iOVFVu3N9j8KOPMEQm
   hiPHfwtXV3DtgmqD0QVJwqyYG50BUQcRmdr29ULrf92h8b/Hnd5R1Jxq7
   7/D0UMSdjlANzVFVwvRAvggCF05KbhYYlyG5Zd2bQ5sXRkBj7yLmg6sjF
   A==;
IronPort-SDR: sGlKQBWd0Gg6gkdQsOsijPEm3VC5b54NIVqy/rwZ9CCiVe8bsie+lfPohJnNXQ3d8bfYEsnFJQ
 S3CHTB/afMWNeJ+2dmNggGucqvHCUoIS/byEp+g2qNy6O2Qa75yHsKRxlSQ0LgKBcf5VntODqU
 X3JoE8k+wy5ERE0ihM1YKOTUuIFEXy2X0VsgJSSRnLjAkNFQc/gbeZN0B+4ViDk1UumD1sAKYs
 k73dcF3KOEG6n3L6w9gOQKcVHlsjnYVYjSDqMnOEVY5hNEchb7tvjArYSkCZuMhT1/sS7LvPtC
 kuQ=
IronPort-PHdr: =?us-ascii?q?9a23=3AluUVaRMajBwymjHZQP8l6mtUPXoX/o7sNwtQ0K?=
 =?us-ascii?q?IMzox0Lfr/rarrMEGX3/hxlliBBdydt6sezbOI7uu5ACQp2tWoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagf79+Ngi6oATRu8UZnIduN7s6xw?=
 =?us-ascii?q?fUrHdPZ+lY335jK0iJnxb76Mew/Zpj/DpVtvk86cNOUrj0crohQ7BAAzsoL2?=
 =?us-ascii?q?465MvwtRneVgSP/WcTUn8XkhVTHQfI6gzxU4rrvSv7sup93zSaPdHzQLspVz?=
 =?us-ascii?q?mu87tnRRn1gyocKTU37H/YhdBxjKJDoRKuuRp/w5LPYIqIMPZyZ77Rcc8GSW?=
 =?us-ascii?q?ZEWMtaSi5PDZ6mb4YXAOUBM+RXoYnzqVUNsBWwGxWjCfjzyjNUnHL6wbE23/?=
 =?us-ascii?q?gjHAzAwQcuH8gOsHPRrNjtNqgSUOG0zKnVzTXEcvhZ2jf955LJchs8pvyNXb?=
 =?us-ascii?q?NxccrLxkkuCw/JkludpJf4PzyJzOQBqXaU4Pd9Ve+2jWMstgJ/oiC3y8sylo?=
 =?us-ascii?q?XEgpgZx1PE+Clj3Yo4JN+1RFR5bNK4FpZbqjuUOJFsQsw4RmFloCM6yrobtp?=
 =?us-ascii?q?GlZCUK05EnxwLHa/yAboiI/grvVOaPLjd8g3JoYLe/iAyz8Uik0+H8Use03E?=
 =?us-ascii?q?tToipLkNTAqmoB1xPU6siARft9+lmu1SyT2ADU7+FIOUE0lazFJJ492rM8iI?=
 =?us-ascii?q?YfvEDZEiL1mEj6lrKae0Qm9+Sy6enrfq3qppqGOI91jgH+PL4umsu6AekgMg?=
 =?us-ascii?q?kPXmib9v691LH/4UH0Tq5HjuAqnanDqpzVO9kUprOhDw9Pzokj8wq/Dyuh0N?=
 =?us-ascii?q?kAgXYHI0hFeBWaj4jxIFHDO+74DfihjFS2ijtrxO7JPqfnAprTKnjPirDhfa?=
 =?us-ascii?q?xy6x0U9A1m6NFU55tQQpEGK/H0Ehv0tNvTDRgRMAGuxevjTtJn2dVNd3iIB/?=
 =?us-ascii?q?qoMbHSrFjA1OImIqHYdZ0VsTelc6MN+vX0y3I1hAlOLuGSwZILZSXgTbxdKE?=
 =?us-ascii?q?KDbC+p249ZHA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2E8AAB6omldf0anVdFmHgEGBwaBVQc?=
 =?us-ascii?q?LAYNWMyqEIY8LgW0FHZN2hSSBewEIAQEBDi8BAYQ/AoJhIzYHDgIDCAEBBQE?=
 =?us-ascii?q?BAQEBBgQBAQIQAQEJCwsIJ4VDgjopAYJoAQEBAxIRBFIQCwsDCgICJgICIhI?=
 =?us-ascii?q?BBQEcBhMIGoULBaFigQM8iyR/M4huAQgMgUkSeiiLeIIXgRGDEj6HT4JYBIE?=
 =?us-ascii?q?uAQEBlFSWCQEGAoINFIwriCwbmGItpiIPIYE1AYIKMxolfwZngU6CThcVji0?=
 =?us-ascii?q?iMI84AQE?=
X-IPAS-Result: =?us-ascii?q?A2E8AAB6omldf0anVdFmHgEGBwaBVQcLAYNWMyqEIY8Lg?=
 =?us-ascii?q?W0FHZN2hSSBewEIAQEBDi8BAYQ/AoJhIzYHDgIDCAEBBQEBAQEBBgQBAQIQA?=
 =?us-ascii?q?QEJCwsIJ4VDgjopAYJoAQEBAxIRBFIQCwsDCgICJgICIhIBBQEcBhMIGoULB?=
 =?us-ascii?q?aFigQM8iyR/M4huAQgMgUkSeiiLeIIXgRGDEj6HT4JYBIEuAQEBlFSWCQEGA?=
 =?us-ascii?q?oINFIwriCwbmGItpiIPIYE1AYIKMxolfwZngU6CThcVji0iMI84AQE?=
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="73576433"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtpmx6.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 15:27:21 -0700
Received: by mail-lf1-f70.google.com with SMTP id b30so1859883lfq.6
        for <cgroups@vger.kernel.org>; Fri, 30 Aug 2019 15:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLm09boqVLNebbJn0KRM9g9k9tAtM8q9U95oJU1h0L0=;
        b=Vo3zchKlbdu1n1q1rBoq/8Hs8DgdlP90ur3n0n9/YRexZ9zG4hPhz8Mgbmhh9QYHJw
         9LQxvlv6DRewM5yLspJ1LlP7B1u3Io51xD8DbVc1n1f2BhmzNViNXu4v5mqBsJ1plW/Y
         JfPuKo0xGEURjO+84Er5+IDLJbt9cBXfeJAmSsNU3DURRyvT4TzKctQcWT+KT0whhtJH
         nW/kAV0Mecl6U5xvTwgM8uCLLoERtBrSaYhwnBDwVpwbUFnuWj7PuQkMWRQrZg+QAcLb
         nelQyeur01kfjOtjGCDi3Bw4PTVDxjnIUojpMJrj6t7fCp8oEFp7WA6cdnELgntXS2bS
         oasQ==
X-Gm-Message-State: APjAAAUBL1VAonYf7viVdIo+lcsx1JoRgLdWRWoQ2A0TU3r/Z5Oi/4Tg
        EHWta9uEbCBMpQWm/074NwW5BSWcibOAaxM5OPMtF7Wvb2MAHG1qFBtcgPm55LQQdnxTkWU3qtb
        lvSv7102cGcJW31iVln4kvLIsS+AN62w9ABA=
X-Received: by 2002:a19:2d19:: with SMTP id k25mr11524770lfj.76.1567204039625;
        Fri, 30 Aug 2019 15:27:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxNwVPvOdN/tveaY5mDrcDGRnQDZr8owb4Bj/v//Ng1I8rWXAU6aT8pAFp3c8BU1Pct5O5eSmP/cI28qOpREA4=
X-Received: by 2002:a19:2d19:: with SMTP id k25mr11524763lfj.76.1567204039450;
 Fri, 30 Aug 2019 15:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190822062210.18649-1-yzhai003@ucr.edu> <20190822070550.GA12785@dhcp22.suse.cz>
 <CABvMjLRCt4gC3GKzBehGppxfyMOb6OGQwW-6Yu_+MbMp5tN3tg@mail.gmail.com> <20190822201200.GP12785@dhcp22.suse.cz>
In-Reply-To: <20190822201200.GP12785@dhcp22.suse.cz>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Fri, 30 Aug 2019 15:27:50 -0700
Message-ID: <CABvMjLRFm5ghgXJYuuNOOSzg01EgE1MazAY7c6HXZaa6wogF8g@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: return value of the function
 mem_cgroup_from_css() is not checked
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Our tool did not trace back the whole path, so, now we could say it
might happen.

On Thu, Aug 22, 2019 at 1:12 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 22-08-19 13:07:17, Yizhuo Zhai wrote:
> > This will happen if variable "wb->memcg_css" is NULL. This case is reported
> > by our analysis tool.
>
> Does your tool report the particular call path and conditions when that
> happen? Or is it just a "it mignt happen" kinda thing?
>
> > Since the function mem_cgroup_wb_domain() is visible to the global, we
> > cannot control caller's behavior.
>
> I am sorry but I do not understand what is this supposed to mean.
> --
> Michal Hocko
> SUSE Labs



-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
