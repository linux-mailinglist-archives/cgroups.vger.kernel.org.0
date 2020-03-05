Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774FD17AA31
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 17:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCEQJc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 11:09:32 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44365 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgCEQJc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 11:09:32 -0500
Received: by mail-qv1-f68.google.com with SMTP id b13so2634358qvt.11
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YFJQskCNWVXuMbTVUr/PuWgn4wVuFnn3nZZ9fMSzuBk=;
        b=O+9wu3BfAMHUjSBZqShEq7hMfSVcLTfHQH3cPXWeDLhMdWns+lMT2fjlIuVY1xcidZ
         r4aOTQjLqDmz1oGNL0DlWKypSa0m3yZsnU98baSb735BbZLpwMdBa8ezdluL9EQhAfjQ
         WrqEGLIjEEzTA76rzJUhPVQYxwdyqC/HlQ5i15gGol/dcdcCgy5ZTMSn9xCotqoHeL/z
         LVSdPNoJnFMfy2TqYVXGDzx2e2K2xAWeZ4P34/1bZNcK28XlUjpfu0FAZ5QWJBKKgIRG
         8xBuG8dS2XEPA3p/3jNDBn8jVaTwqUBnDUKjRsG9drVZQl30An7O+5aTkA+ooVkatlL1
         ceLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YFJQskCNWVXuMbTVUr/PuWgn4wVuFnn3nZZ9fMSzuBk=;
        b=iHPNx9zycXfjsX+IXck08RnM+4/sEkZLGyupRTxuJG9ElXDrV4N58uJTeYzxvWeAlb
         MWjkGv1Q5fGRV1u27cLZcqaDlSPbdgc3xdNJ6nC7qPX/c/0EYWfQlYffzwoGxV6lFXkt
         DD9w3UbE3Dz1bRHAT5NKvyuzFkOLU7q+/ntYSpOC3yRufDbCH+qgEb7j0yXbyBZBJ+mz
         0kut7lAsdizTVm75hKD0jogCv043qV/FtWIKzWEg/nCjim+vUgDZCnw/6m4TylScOJxh
         y3ADy+44rdieGZZp5tHq1FCCo3lhIXoinY3dMITyb4GST7qpbb8hG3s1mNHa1RbcU1uT
         JSzw==
X-Gm-Message-State: ANhLgQ3VJO9ccbf9zb/IW+rQ06nNXTR/5U8BHdNKTUrn/SON20eFdU07
        0zhg49Q3rY6j7iChLS/ceVz7ZD9kXuI=
X-Google-Smtp-Source: ADFU+vtZefeykjoi6XK4ZnTYc/+LRGud/nqzFl3SaKgi4mOWBmWqaGlmlg6yNMVJUNRNWWa06BMDeQ==
X-Received: by 2002:ad4:510f:: with SMTP id g15mr7140943qvp.105.1583424571027;
        Thu, 05 Mar 2020 08:09:31 -0800 (PST)
Received: from localhost (pool-96-232-200-60.nycmny.fios.verizon.net. [96.232.200.60])
        by smtp.gmail.com with ESMTPSA id j1sm13031066qtd.66.2020.03.05.08.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 08:09:30 -0800 (PST)
Date:   Thu, 5 Mar 2020 11:09:29 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Make mem_cgroup_id_get_many dependent on MMU and
 MEMCG_SWAP
Message-ID: <20200305160929.GA1166@cmpxchg.org>
References: <20200304142348.48167-1-vincenzo.frascino@arm.com>
 <20200304165336.GO16139@dhcp22.suse.cz>
 <8c489836-b824-184e-7cfe-25e55ab73000@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c489836-b824-184e-7cfe-25e55ab73000@arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 05, 2020 at 09:49:23AM +0000, Vincenzo Frascino wrote:
> Hi Michal,
> 
> On 3/4/20 4:53 PM, Michal Hocko wrote:
> > On Wed 04-03-20 14:23:48, Vincenzo Frascino wrote:
> >> mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
> >> configuration options are enabled. Having them disabled triggers the
> >> following warning at compile time:
> >>
> >> linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
> >> but not used [-Wunused-function]
> >>  static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
> >>  int n)
> >>
> >> Make mem_cgroup_id_get_many() dependent on MMU and MEMCG_SWAP to address
> >> the issue.
> > 
> > A similar patch has been proposed recently
> > http://lkml.kernel.org/r/87fthjh2ib.wl-kuninori.morimoto.gx@renesas.com.
> > The conclusion was that the warning is not really worth adding code.
> > 
> 
> Thank you for pointing this out, I was not aware of it. I understand that you
> are against "#ifdeffery" in this case, but isn't it the case of adding at least
> __maybe_unused? This would prevent people from reporting it over and over again
> and you to have to push them back :) Let me know what do you think, in case I am
> happy to change my patch accordingly.

I would ack a patch that adds __maybe_unused.

This is a tiny function. If we keep it around a few releases after
removing the last user, it costs us absolutely nothing. Eventually
somebody will notice and send a patch to remove it. No big deal.

There is, however, real cost in keeping bogus warnings around and
telling people to ignore them. It's actively lowering the
signal-to-noise ratio and normalizing warnings to developers. That's
the kind of thing that will actually hide problems in the kernel.

We know that the function can be unused in certain scenarios. It's
silly to let the compiler continue to warn about it. That's exactly
what __maybe_unused is for, so let's use it here.
