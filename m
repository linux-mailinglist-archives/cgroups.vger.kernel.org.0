Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43FDB3F2FBA
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 17:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241196AbhHTPmt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 11:42:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45030 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241045AbhHTPms (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 11:42:48 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CAAE21FE2C;
        Fri, 20 Aug 2021 15:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629474129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvfDF5eMx9B1DGeIPF2eXAnu9j+546SJreXX4X/2/LM=;
        b=C5IT/PW1hmbH61XIjN7Wc8SbyMIvagbJL2zGwVShR9zzsjkQRtKGAC85D9AhbS5PM/r/SX
        Q1MANu0muX1nsJwo5+SvI+3h3LVOew+eE86kVRkT93DMgacaQWSR0GVtEuA7n44G23prmR
        JcaLFXEvnXE+yBZGph5yVDTbFq1/Z5U=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 163BFA3B9B;
        Fri, 20 Aug 2021 15:42:08 +0000 (UTC)
Date:   Fri, 20 Aug 2021 17:41:56 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     yong w <yongw.pur@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, alexs@kernel.org,
        Wei Yang <richard.weiyang@gmail.com>, Hui Su <sh_def@163.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        wang.yong12@zte.com.cn, Cgroups <cgroups@vger.kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2] mm: Add configuration to control whether vmpressure
 notifier is enabled
Message-ID: <YR/NRJEhPKRQ1r22@dhcp22.suse.cz>
References: <1629417219-74853-1-git-send-email-wang.yong12@zte.com.cn>
 <YR+Rc9HC6OqlEq4I@dhcp22.suse.cz>
 <CAOH5QeCfwF0hX3XpoThEtwnddtOFEU9Jtp0Hoj+Q37D4Q6HC0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOH5QeCfwF0hX3XpoThEtwnddtOFEU9Jtp0Hoj+Q37D4Q6HC0Q@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 20-08-21 23:20:40, yong w wrote:
> Michal Hocko <mhocko@suse.com> 于2021年8月20日周五 下午7:26写道：
> >
> > On Thu 19-08-21 16:53:39, yongw.pur@gmail.com wrote:
> > > From: wangyong <wang.yong@zte.com.cn>
> > >
> > > Inspired by PSI features, vmpressure inotifier function should
> > > also be configured to decide whether it is used, because it is an
> > > independent feature which notifies the user of memory pressure.
> >
> > Yes, it is an independent feature indeed but what is the actual reason
> > to put a more configuration space here. Config options are not free both
> > from the user experience POV as well as the code maintenance. Why do we
> > need to disable this feature. Who can benefit from such a setup?
> >
> > > So we add configuration to control whether vmpressure notifier is
> > > enabled, and provide a boot parameter to use vmpressure notifier
> > > flexibly.
> >
> > Flexibility is nice but not free as mentioned above.
> >
> > > Use Christoph Lamenter’s pagefault tool
> > > (https://lkml.org/lkml/2006/8/29/294) for comparative testing.
> > > Test with 5.14.0-rc5-next-20210813 on x86_64 4G Ram
> > > To ensure that the vmpressure function is executed, we enable zram
> > > and let the program occupy memory so that some memory is swapped out
> > >
> > > unpatched:
> > > Gb    Rep     Thr     CLine   User(s) System(s) Wall(s) flt/cpu/s     fault/wsec
> > > 2     1       1       1       0.1     0.97    1.13    485490.062      463533.34
> > > 2     1       1       1       0.11    0.96    1.12    483086.072      465309.495
> > > 2     1       1       1       0.1     0.95    1.11    496687.098      469887.643
> > > 2     1       1       1       0.09    0.97    1.11    489711.434      468402.102
> > > 2     1       1       1       0.13    0.94    1.12    484159.415      466080.941
> > > average                               0.106   0.958   1.118   487826.8162     466642.7042
> > >
> > > patched and CONFIG_MEMCG_VMPRESSURE is not set:
> > > Gb    Rep     Thr     CLine   User(s) System(s) Wall(s) flt/cpu/s     fault/wsec
> > > 2     1       1       1       0.1     0.96    1.1     490942.682      473125.98
> > > 2     1       1       1       0.08    0.99    1.13    484987.521      463161.975
> > > 2     1       1       1       0.09    0.96    1.09    498824.98       476696.066
> > > 2     1       1       1       0.1     0.97    1.12    484127.673      465951.238
> > > 2     1       1       1       0.1     0.97    1.11    487032          468964.662
> > > average                               0.094   0.97    1.11    489182.9712     469579.9842
> > >
> > > According to flt/cpu/s, performance improved by 0.2% which is not obvious.
> >
> > I haven't checked how are those numbers calculated but from a very brief
> > look it seems like the variation between different runs is higher than
> > 0.2%. Have you checked the average against standard deviation to get a
> > better idea whether the difference is really outside of the noise?
> > --
> > Michal Hocko
> > SUSE Labs
> 
> Thanks for your reply.
> The reason for adding configuration is as follows：

All those reasons should be a part of the changelog.

> 1. Referring to [PATCH] psi: make disabling/enabling easier for vendor
> kernels, the modification
> is also applicable to vmpressure.
> 
> 2. With the introduction of psi into the kernel, there are two memory
> pressure monitoring methods，
> it is not necessary to use both and it makes sense to make vmpressure
> configurable.

I am not sure these are sufficient justifications but that is something
to discuss. And hence it should be a part of the changelog.

> 3. In the case where the user does not need vmpressure,  vmpressure
> calculation is additional overhead.

You should quantify that and argue why that overhead cannot be further
reduced without config/boot time knobs.

> In some special scenes with tight memory, vmpressure will be executed
> frequently.we use "likely" and "inline"
> to improve the performance of the kernel, why not reduce some
> unnecessary calculations?

I am all for improving the code. Is it possible to do it by other means?
E.g. reduce a potential overhead when there no events registered?
-- 
Michal Hocko
SUSE Labs
