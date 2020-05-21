Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA531DCDD9
	for <lists+cgroups@lfdr.de>; Thu, 21 May 2020 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgEUNVZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 May 2020 09:21:25 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:43450 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgEUNVZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 May 2020 09:21:25 -0400
Received: by mail-ej1-f65.google.com with SMTP id a2so8744214ejb.10;
        Thu, 21 May 2020 06:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t4ZgBaxu8psJTH+wQpzS+5wxRN/OxLHl3Tsx7xVOSrI=;
        b=JSKS0ikHNPRj8HCxcfMI9mbARZWEEgM0IoG8KLupWs/CoTTn6TRpzJVPK7spKk1DUZ
         OQxXSv0solrkDGgNjJUBUmtTOLAr+UE86ewPg3bUoBKcP1TH+Hr3nw5Ry7p3tKHyOK+/
         EqiCXN1MY7tapHdid0qhza2U6qkLn6yY/sQabRJ6lBbhG9/mX2y9dKtSCmo/XyTv5Qmq
         iNOBhwC27PmoGFDmXW2Kx57FiB+HkeYJt31z23apeSyAJKHUGyf4ZlShAonJcgJYf9+g
         8cPH3SsdEbtZbY9cU4TrKUHLa/lin6oiFQtE/Y7Vp+AxUw4CFL3uKoNSMGNcBNz70iUt
         PsOA==
X-Gm-Message-State: AOAM532lo9gfD/z+j6F9q8l4hUVVjw7mEXK+ys+9lcQPDyqlGooily8Y
        BdpWGeFxHpv+mr0aN96OiyQ=
X-Google-Smtp-Source: ABdhPJwA8k8xRmngoLH2EqAfwEHSAw4oSpuO2/gtbxK0HSC8+a+PLfIENR1tqH/RUQlfft+fASIXZA==
X-Received: by 2002:a17:906:63c9:: with SMTP id u9mr3606605ejk.439.1590067283528;
        Thu, 21 May 2020 06:21:23 -0700 (PDT)
Received: from localhost (ip-37-188-180-112.eurotel.cz. [37.188.180.112])
        by smtp.gmail.com with ESMTPSA id k9sm5065750edl.83.2020.05.21.06.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 06:21:22 -0700 (PDT)
Date:   Thu, 21 May 2020 15:21:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521132120.GR6462@dhcp22.suse.cz>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
 <20200521123742.GO6462@dhcp22.suse.cz>
 <20200521125759.GD990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521125759.GD990580@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 21-05-20 13:57:59, Chris Down wrote:
> Michal Hocko writes:
> > > A cgroup is a unit and breaking it down into "reclaim fairness" for
> > > individual tasks like this seems suspect to me. For example, if one task in
> > > a cgroup is leaking unreclaimable memory like crazy, everyone in that cgroup
> > > is going to be penalised by allocator throttling as a result, even if they
> > > aren't "responsible" for that reclaim.
> > 
> > You are right, but that doesn't mean that it is desirable that some
> > tasks would be throttled unexpectedly too long because of the other's activity.
> 
> Are you really talking about throttling, or reclaim? If throttling, tasks
> are already throttled proportionally to how much this allocation is
> contributing to the overage in calculate_high_delay.

Reclaim is a part of the throttling mechanism. It is a productive side
of it actually.
 
> If you're talking about reclaim, trying to reason about whether the overage
> is the result of some other task in this cgroup or the task that's
> allocating right now is something that we already know doesn't work well
> (eg. global OOM).

I am not sure I follow you here.
-- 
Michal Hocko
SUSE Labs
