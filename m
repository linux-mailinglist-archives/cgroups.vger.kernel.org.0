Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8555E267615
	for <lists+cgroups@lfdr.de>; Sat, 12 Sep 2020 00:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgIKWot (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Sep 2020 18:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgIKWor (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Sep 2020 18:44:47 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49220C061573;
        Fri, 11 Sep 2020 15:44:47 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h1so6025279qvo.9;
        Fri, 11 Sep 2020 15:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u+WhBADY6qVJWkQ3xRM3bDy/SBlYQIzy5ZdNwaCGMPo=;
        b=Vd6T5UxRIdx5jTi/U0KU/8IsFPJn+d/lu1Rm2NRQqLFvakL1U7maewPdM/lewBZIBf
         3JlMLhMrGiLuqhfjC65xkDCyKXeVytlPJRK7J9HAiMm+TJRRlqOh/2R5NiUtCSLvaJT3
         OX9MD+J6eZXUr4IsDcH8JIThEv6bGpk9DePXSYqgZ0fFHA2XzxH5/EzeFwS12bSgIban
         T08PKKO3K2bSfLHbeNo9gH9hE41A48jpwozy4ttMKVyIvb+/HLVMTpx4JvRk9+nDgf9B
         24/5RuG4MXhn2RwEKraI50vOGj06UnXe33AFayZdWAj1277lIwCEUDN7UFQUtNdRLJDq
         7fww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=u+WhBADY6qVJWkQ3xRM3bDy/SBlYQIzy5ZdNwaCGMPo=;
        b=AOfWNZHNCNCW/2g4fQyAW+Ls9E8oUcG591Ijb3dwp0fpUyeSw4Jj2agZdyNp1/sC5n
         eN+TtV4I+t9JeTvzBljvqY14JDy1M7u/vNuGP8lX3rhSOVk2I5JpPBW35PlmuanRXJ4D
         bmhA5gYr1vHBlEDBWaTWLh8LImj+qihn98LrxjdxAnVdsymJsFjwV8T7YWyC5xpYyDgn
         LTrrWVdbiqCXwm8j5FuqcHCLZfTQn12st1LE3VP+v6kHBG1/H4rnGpb++YTo/+UHGNQO
         DCSwyQet/uGPZr/Ydh2FH0V3c/shLo0B4XSTKfA+LI3J9fc3yAdp+kLmIKcNsEltAvRP
         Kt5Q==
X-Gm-Message-State: AOAM532hi2SFqhzaY5jsKIKNcviszXDwNpJAUBAv9vQ0Fz2/unfv5vyy
        xHYqCMOvgVemCijit5rAr4PNlarpYRtqvw==
X-Google-Smtp-Source: ABdhPJwRT7UYaX3oxQFSIVPMf7caj4RAt8NBOJcw930XJ0jTaCEv1EdpSyMs6kiSJ2DLVqor7+/55A==
X-Received: by 2002:a0c:fa07:: with SMTP id q7mr4218336qvn.41.1599864286486;
        Fri, 11 Sep 2020 15:44:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:95ac])
        by smtp.gmail.com with ESMTPSA id j31sm4681290qtc.33.2020.09.11.15.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:44:45 -0700 (PDT)
Date:   Fri, 11 Sep 2020 18:44:44 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 block/for-next] blk-iocost: fix divide-by-zero in
 transfer_surpluses()
Message-ID: <20200911224444.GB865564@mtj.thefacebook.com>
References: <20200911170746.GG4295@mtj.thefacebook.com>
 <ff46ca79-433e-3279-a8eb-35156639be7b@kernel.dk>
 <20200911224049.GA865564@mtj.thefacebook.com>
 <59987f54-47fc-766f-0667-5a90daca0b1a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59987f54-47fc-766f-0667-5a90daca0b1a@kernel.dk>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 11, 2020 at 04:43:18PM -0600, Jens Axboe wrote:
> On 9/11/20 4:40 PM, Tejun Heo wrote:
> > Conceptually, root_iocg->hweight_donating must be less than WEIGHT_ONE but
> > all hweight calculations round up and thus it may end up >= WEIGHT_ONE
> > triggering divide-by-zero and other issues. Bound the value to avoid
> > surprises.
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Fixes: e08d02aa5fc9 ("blk-iocost: implement Andy's method for donation weight updates")
> > 
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > ---
> > Jens, I was flipping between doing max_t(, 1) over the whole divider and
> > doing min_t(, WEIGHT_ONE - 1) for hweight_donating. I thought that I as
> > testing after the last change but it obviously wasn't and the previous patch
> > doesn't compile due to missing type argument. Can you please apply this
> > patch instead? I can send an incremental patch if that'd be better. My
> > apologies.
> 
> Sure, I replaced it. BTW, you had two signed-off-by's in there.

Yeah, sloppy all around. Sorry about that. Gotta slow down more when posting
oh-shit-I-fucked-up stuff.

Thanks.

-- 
tejun
