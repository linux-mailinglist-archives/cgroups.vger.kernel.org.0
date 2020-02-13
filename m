Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB3215C50B
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 16:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgBMPwx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Feb 2020 10:52:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36030 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729202AbgBMPww (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Feb 2020 10:52:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id db9so2825044qvb.3;
        Thu, 13 Feb 2020 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EuJrg4ULs0tpagr31hXq1zdKPAdFI4MMOOagF1qJLOg=;
        b=PnjLF4bNA/eUyCHgQ/R8wWTcv3gOxU/nYK8t0Sd6AcOsphiCjIu2d4hWM4XNJrJafd
         XgexmQM//GYEUS2Q79iqv68UkFJZPtLjF1AZJdYosM2nOHeRG3BwnZoNAe+H15LDic0U
         mKRMYRni5DqhLpZ9U0Plvl11o3JecbI4ETKTy4aMgKU4sndLLwACtL53DzTrrbRX0WWy
         oNFNxYsLwhjxLBwrqYmDBR/4Y5K+F6KfdMe2Sr2t56jkIy16cydbw7Q6u8fhT2NUopRX
         YWcB76bAbCNyH5CJcWEJDAJhA8Ungl8ZJhh35Jp0l2R31W8u+aum4qdhDbnwFDwye59v
         vTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=EuJrg4ULs0tpagr31hXq1zdKPAdFI4MMOOagF1qJLOg=;
        b=ITIpqr3HZ2A4pea7QD1aVIDLQmjHo92tr9fODfDL+uNA4IOH68Bcehed8+SjocPl78
         o6ywE04/1vctnNNo29OhuEmfB/2GQxitn+yRq7ArQX8hJzI9wJ71wLBjzCESzC4AejXY
         8+pW4h0t2bjzZSyWtlyBmxjzk/w3RxtfAdLSjE+UG2/4uya/Xlurs2oeNGKph1HTfIVS
         XCOKhUd1uWI00pUFhw9nrniGXfG4uYcGgo8bIpObIsbEBKJgnrBm3k+7JKsbiRO4PsFs
         OhBUOgb4papceI/dyMjLwMoM+jUIrrfyZL1srvnK6EmLAOBmd+cxvNGwrmaoYaWbdeGd
         16ZA==
X-Gm-Message-State: APjAAAXiMcGBKzVmAgFVfBGnfxN1COhp7Tn9SiyOZ3QTT2gVQULFESKz
        6gmpNRoJhOg+hI4nshN4qq6gLz/toEI=
X-Google-Smtp-Source: APXvYqwgtnWEN5FesTTslQ57egNuS1baXiQAXTLM2vbGsZMUPJpSNipp0vBwp8oFOfgBHYOElxnPgQ==
X-Received: by 2002:a0c:efc4:: with SMTP id a4mr12479571qvt.178.1581609170928;
        Thu, 13 Feb 2020 07:52:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:f3be])
        by smtp.gmail.com with ESMTPSA id 65sm1639533qtf.95.2020.02.13.07.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 07:52:50 -0800 (PST)
Date:   Thu, 13 Feb 2020 10:52:49 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 3/3] mm: memcontrol: recursive memory.low protection
Message-ID: <20200213155249.GI88887@mtj.thefacebook.com>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-4-hannes@cmpxchg.org>
 <20200130170020.GZ24244@dhcp22.suse.cz>
 <20200203215201.GD6380@cmpxchg.org>
 <20200211164753.GQ10636@dhcp22.suse.cz>
 <20200212170826.GC180867@cmpxchg.org>
 <20200213074049.GA31689@dhcp22.suse.cz>
 <20200213135348.GF88887@mtj.thefacebook.com>
 <20200213154731.GE31689@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213154731.GE31689@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Feb 13, 2020 at 04:47:31PM +0100, Michal Hocko wrote:
> Well, I would tend to agree but I can see an existing cgroup hierarchy
> imposed by systemd and that is more about "logical" organization of
> processes based on their purpose than anything resembling resources.
> So what can we do about that to make it all work?

systemd right now isn't configuring any resource control by default,
so I'm not sure why it is relevant in this discussion. You gotta
change the layout to configure resource control no matter what and
it's pretty easy to do. systemd folks are planning to integrate higher
level resource control features, so my expectation is that the default
layout is gonna change as it develops.

Thanks.

-- 
tejun
