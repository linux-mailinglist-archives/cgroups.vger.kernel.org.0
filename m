Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 969F817A2BB
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 11:02:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCEKA1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 05:00:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37958 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgCEKA0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 05:00:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id u9so5004430wml.3;
        Thu, 05 Mar 2020 02:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N+VHYLrvI+7e0ZVMs5A2YwvXMlQT1Gheq6HEnWaXrHg=;
        b=bhyksl/2dsNRmdBN5+5IiXymbHl3MnUtSSq7uoI1qNzqAbKktR97O0QY4ngO6yBIXl
         Fcfhmnw31EaYAdgnRSCb6o6TarDXeLq3+1GyHQHEAQoZcvdGX7AfIKnBaZ4Lfba5YDRz
         3OUfoZxt8m2YtXo4iXO69ksFpf/MOEL9urYFdVgZboBDteLAqIDCt4Xs2dBwODjE+Woi
         SD/7WhGiPxCkT35LgHtoWpxdsVh0reff7DjUhGrh2bYObZPrzpoCOHtNzgv61kY0AdTn
         Nj5euNAbnfCG5RdCGRT1SYnUz9hDk6v4Yg1aduBDGuJIA5tS7UyzUIkR1yBwBt6MB1uV
         dXTg==
X-Gm-Message-State: ANhLgQ10h5UM/MqBv3IyVHgd1FKmdv1Tj2uX1J2Mk3rgAaQUsC88mKt4
        xsM+vyVH2clz4LjzF7VH9Cw=
X-Google-Smtp-Source: ADFU+vsjaigYaEU+QZdTj0scvF+IN/q3UIp8DX+Zj1RxoQokICpr/pwGVXS7WJffS4KX2QC2pN6duQ==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr8419345wmc.71.1583402424648;
        Thu, 05 Mar 2020 02:00:24 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 25sm8514392wmg.30.2020.03.05.02.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:00:23 -0800 (PST)
Date:   Thu, 5 Mar 2020 11:00:23 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Make mem_cgroup_id_get_many dependent on MMU and
 MEMCG_SWAP
Message-ID: <20200305100023.GR16139@dhcp22.suse.cz>
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

On Thu 05-03-20 09:49:23, Vincenzo Frascino wrote:
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

We have discussed __maybe_unused in the email thread as well. I am not a
great fan of that as mentioed there.
-- 
Michal Hocko
SUSE Labs
