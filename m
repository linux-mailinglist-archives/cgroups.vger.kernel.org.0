Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C821E2FBD31
	for <lists+cgroups@lfdr.de>; Tue, 19 Jan 2021 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbhASRGl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Jan 2021 12:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbhASRFf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Jan 2021 12:05:35 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F37C061573;
        Tue, 19 Jan 2021 09:04:41 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h4so22540910qkk.4;
        Tue, 19 Jan 2021 09:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hC/zpZbVc37tYw12xQlWmizImGmh0tgMQSzuFSnLUZU=;
        b=dNZ5VRxuAFPEt1xf96G3Ir7Dr2NVc6IpAUFuXbxqAJlgEzpm7dLaw4tl4xVf5ikq6o
         odlMxzqpBZ12BrXpEnIeub3bjQDSNuJGP5PACusqEryq+7xJzbH/nmLde+UGBIbaswaV
         xz6PYJfhtnsCHGCpWD6Pu4BFSJbVgpDYf742FotXAPTu/TQDyIyNo/2tX26sWhrs/R8s
         tsUayWWg2VW9XF0QOqrpqERWt2zK/YPCDJLhSpfmMK+pZq1HmXKfM3K/FOIld/68t06O
         I54pLIIoarsZZoeqOQnoY4BG9Ma+IdzUIRm9/h2f0iaAoYgsNmDzvGYI70EOxKRercif
         fgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hC/zpZbVc37tYw12xQlWmizImGmh0tgMQSzuFSnLUZU=;
        b=nTmwHmEtOw+GKumx5LpzeBeUMv4CuHbZZMInv8oTO/+Zz+TzQhURLqNIG+lCq8Xh0U
         CRSzZg0HCoO/TGIAVcafr3idWZBbq37pTJhV2hQcmO1pZu3Z+uUs6agzsNpFvvwVWMlw
         AC/QHFCK8aqWelkpyuCcHRGxpWhLJbUskdhAdVLYCDd72eTgl9BoxVcvUReZM+GPdOBm
         gi2gSIUl50vcBFuOZyvZMrFMpVNOSxtpOdqzYDW4dsd+IS7RxfQRJuLkajmqPbNJbMqe
         F/UTS9wA4XBhbGifOuq2EhJd4esFLaAFLtOsyn4G5bcBLp7xA0jcEUJBt2QUhgiwBzIA
         zHXw==
X-Gm-Message-State: AOAM533FuphEbIYUOJFXevpcOYWSA5O3gthQRbZABqIaOgrqB1Kihzs0
        l+fsJrKzteZ+u+ojsCHkF5M=
X-Google-Smtp-Source: ABdhPJw1ZBE07UP3ZmBtO1xvtU17NUsLJbWWiv2xbrdDV6GDc1Yr7h55DFHasgfAcOhGY6CV3VXqgg==
X-Received: by 2002:a05:620a:74e:: with SMTP id i14mr5398931qki.99.1611075880735;
        Tue, 19 Jan 2021 09:04:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:4cbf])
        by smtp.gmail.com with ESMTPSA id x49sm13160414qtx.6.2021.01.19.09.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 09:04:40 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 19 Jan 2021 12:03:55 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Odin Ugedal <odin@uged.al>, lizefan@huawei.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        dschatzberg@fb.com, surenb@google.com
Subject: Re: [PATCH v2 2/2] cgroup: update PSI file description in docs
Message-ID: <YAcQ+/z0WkW61gL3@mtj.duckdns.org>
References: <20210116173634.1615875-1-odin@uged.al>
 <20210116173634.1615875-3-odin@uged.al>
 <YAcPMlxXVSuKgbvn@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAcPMlxXVSuKgbvn@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 19, 2021 at 11:56:18AM -0500, Johannes Weiner wrote:
> On Sat, Jan 16, 2021 at 06:36:34PM +0100, Odin Ugedal wrote:
> > Update PSI file description in cgroup-v2 docs to reflect the current
> > implementation.
> > 
> > Signed-off-by: Odin Ugedal <odin@uged.al>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > index 63521cd36ce5..f638c9d3d9f2 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1029,7 +1029,7 @@ All time durations are in microseconds.
> >  	one number is written, $MAX is updated.
> >  
> >    cpu.pressure
> > -	A read-only nested-key file which exists on non-root cgroups.
> > +	A read-only nested-keyed file.
> 
> Could you please also change the 'read-only' to 'read-write'?
> 
> With that, please feel free to add:
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Applied w/ the suggested change.

Thanks.

-- 
tejun
