Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373553E9726
	for <lists+cgroups@lfdr.de>; Wed, 11 Aug 2021 19:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhHKR5V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 Aug 2021 13:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhHKR5U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 Aug 2021 13:57:20 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90D7C061765;
        Wed, 11 Aug 2021 10:56:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m24-20020a17090a7f98b0290178b1a81700so6327474pjl.4;
        Wed, 11 Aug 2021 10:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cwgWzWHzZMmumV5gjVMxV+Qi76br3EdobHy6Ey8p6Oc=;
        b=Jeti1NcsjNeJ8sVoIL8mh7m++DlwgRbKC99cR4nnyCCnGPgDZLr/KvcqfiyObb5HOu
         eWltR2gmBq5S9Gk9GFt0amAZJRljTQm4Hv99hFbu4m7nEU1ve8c9WhTcs/Nrt9hW4tcY
         wNq5fjTzDet658woLOZ4exZWaa9kLGaUcOVG9tJrTTweJ7OvFjUKkQyfsutp5ZeKJHGK
         XViFgpEt424rTRYOYiUVq3rAtI9o6mk4t62xiM/GUJLUcICgarEi2xutTomBgRvcWxyq
         WMSNJa4+Nj0vk4AOhTUKGMgEl8OqETTOvZ7wcCL9YCDkICefJDefT38pevcUKUzV1FFX
         2H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cwgWzWHzZMmumV5gjVMxV+Qi76br3EdobHy6Ey8p6Oc=;
        b=PmpfSYWSpagOmt+sumqFFJ5BlNo9xegd1V/vdUrWu/+lKJlV021EQCUNdri+ZlgCUZ
         6ra50q6+UKpzXY1Z7XEBq+zgWQVwgOmdN8Xab+Rcn08BWAan5ncIbmC6Ed/4ugZD6dFz
         x1vAOjIdR9xqxdpXpWgnLMURsNynsoIBRtiQW38y5rTRJbgRGUG8NuBXF9H8MzCG3fZe
         efZiXu+GZFnCef/cIHa1xktA01gOqo6ka094rRod1aV/Tebg97sobCJP3U6d/tSDv/qM
         xK88DQ7xtZSLwBQtlfj0956Bro2YvgTzKhgTgotmUfnUqwdOuxlRL4zzbkH5FvI2KQrJ
         khLA==
X-Gm-Message-State: AOAM531vZgDwjSdleIb2ooohyNbVnBjfThmlRoO6x8hahrm7gQ7qLVoy
        NosVGFZmtGVEkiFC1XkmInM=
X-Google-Smtp-Source: ABdhPJyReDWX0kVPy5WJOEYoCkxHjlvUf71PVfbHEY9wCdsSLt6oFTplzk1kwIYdBhdXU/4ggQAWDA==
X-Received: by 2002:a17:90b:4acb:: with SMTP id mh11mr12297772pjb.20.1628704616358;
        Wed, 11 Aug 2021 10:56:56 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d15sm155703pfo.147.2021.08.11.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 10:56:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 07:56:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] blk-cgroup: stop using seq_get_buf
Message-ID: <YRQPZosdoT1vo2Kz@slm.duckdns.org>
References: <20210810152623.1796144-1-hch@lst.de>
 <20210810152623.1796144-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810152623.1796144-2-hch@lst.de>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 10, 2021 at 05:26:23PM +0200, Christoph Hellwig wrote:
> seq_get_buf is a crutch that undoes all the memory safety of the
> seq_file interface.  Use the normal seq_printf interfaces instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
