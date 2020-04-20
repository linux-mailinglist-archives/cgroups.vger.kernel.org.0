Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0981B129E
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2020 19:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgDTRHO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 13:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725784AbgDTRHO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 13:07:14 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA849C061A0C
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 10:07:12 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id bu9so5044701qvb.13
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vTaZ4A2xTqoec4rGQUiY61oQkfvMOHet/Q+PpcugyL4=;
        b=p9afyDhuR3jY0COsZkjOIfXAXTeTXRlgReAqvf2PU8RvxkM+vIo1afbuo1bJLxOUAp
         /HNtVWe2r/q3jx7v2Ds2n/s7z8C4HJjn8SAda+rEZlSgfJeIq9oRfwNcAseIhO9fxU9Y
         /gZGtnAPJdbrkJFJE7T7KpyPS2viADjItryD+mfVzsKNg6A+D7F4O9Ux+Mk7g2sjn7bZ
         Vof9BFDh9p6dm5Phv0maPfBMmZvwBKHQsKTI+ore0hQngEtHOB3GFLdw+bZNROYTElXY
         3cyMefG2Qs2HJAzVWqVYHLIm3Su+ARxxalpQKmnwLXE/SonvG3lS3/WDxsIRGaQRdbVD
         yzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vTaZ4A2xTqoec4rGQUiY61oQkfvMOHet/Q+PpcugyL4=;
        b=DSoF74XMCy2RjVmmEV+bjCHQppiw0drePUHw+fXC9mQfHIRmZSJ+TpyWXw+tQQQXl4
         TqKSW4F1l5Z9M5YSsxOMpL6f2usYFJNswDoKzjslLeQC46fLJAr0ia8+AitqapywYBm0
         7YtQTvMcaMrZxR21EcRkHnlIMIX17CjzQpAIbupSTZ+QAms+2ZC2EPGaElwH+s2SKbYP
         ORGBeJWbt2G8X6JOKQ+ZOqD5l5brZIRX8T5CB5XklGRmMnRxt1lrCuzZG+AWm54qYvZj
         FJpnNV70hHzKiB9TdYwc295pldPYvUMQGe2eXpRDTdaYecniB4c0bVOkBpxi0PWgxxVW
         IaUw==
X-Gm-Message-State: AGi0PubOWapQ70fJI0N3dELHghglpl96AGzTq6InR0U4mYbVgc/3A86o
        Vtj7e+8Da9B2wZbyzi8TkWw=
X-Google-Smtp-Source: APiQypI2h+zWCkMsGpwMlubVYvX/+UnoNZfKYDxvMh+4fgJTeVMmo0X5pEdFxBSZtY8tzwEC+tej3A==
X-Received: by 2002:ad4:4462:: with SMTP id s2mr16018208qvt.221.1587402411715;
        Mon, 20 Apr 2020 10:06:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b787])
        by smtp.gmail.com with ESMTPSA id y16sm916547qtj.32.2020.04.20.10.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:06:51 -0700 (PDT)
Date:   Mon, 20 Apr 2020 13:06:50 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>
Subject: Re: [PATCH 0/3] memcg: Slow down swap allocation as the available
 space gets depleted
Message-ID: <20200420170650.GA169746@mtj.thefacebook.com>
References: <20200417162355.GA43469@mtj.thefacebook.com>
 <CALvZod4ftvXCu8SbQUXwTGVvx5K2+at9h30r28chZLXEB1JdfQ@mail.gmail.com>
 <20200417173615.GB43469@mtj.thefacebook.com>
 <CALvZod7-r0OrJ+-_uCy_p3BU3348ve2+YatiSdLvFaVqcqCs=w@mail.gmail.com>
 <20200417193539.GC43469@mtj.thefacebook.com>
 <CALvZod6LT25t9aAA1KHmf1U4-L8zSjUXQ4VQvX4cMT1A+R_g+w@mail.gmail.com>
 <20200417225941.GE43469@mtj.thefacebook.com>
 <CALvZod6M4OsM-t8m_KX9wCkEutdwUMgbP9682eHGQor9JvO_BQ@mail.gmail.com>
 <20200420164740.GF43469@mtj.thefacebook.com>
 <20200420170318.GV27314@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420170318.GV27314@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Apr 20, 2020 at 07:03:18PM +0200, Michal Hocko wrote:
> I have asked about the semantic of this know already and didn't really
> get any real answer. So how does swap.high fit into high limit semantic
> when it doesn't act as a limit. Considering that we cannot reclaim swap
> space I find this really hard to grasp.

memory.high slow down is for the case when memory reclaim can't be depended
upon for throttling, right? This is the same. Swap can't be reclaimed so the
backpressure is applied by slowing down the source, the same way memory.high
does.

It fits together with memory.low in that it prevents runaway anon allocation
when swap can't be allocated anymore. It's addressing the same problem that
memory.high slowdown does. It's just a different vector.

Thanks.

-- 
tejun
